import { err, ok, type Result } from "../../../errors/result.js";
import type { LoggerService } from "../../../logger/index.js";
import {
  type Book,
  type BookDetail,
  type BookSource,
  mapGoogleBooksVolume,
  mapGoogleBooksVolumeToDetail,
  mapRakutenBooksItem,
  mapRakutenBooksItemToDetail,
} from "./book-mapper.js";
import {
  deduplicateByIsbn,
  filterValidGoogleBooks,
} from "./composite-book-repository.js";
import type { ExternalBookRepository } from "./external-book-repository.js";
import type { GoogleBooksRepository } from "./google-books-repository.js";

export type BookSearchErrors =
  | { code: "NETWORK_ERROR"; message: string }
  | { code: "EXTERNAL_API_ERROR"; message: string }
  | { code: "VALIDATION_ERROR"; message: string }
  | { code: "NOT_FOUND"; message: string };

export interface SearchBooksInput {
  query: string;
  limit?: number;
  offset?: number;
}

export interface SearchByISBNInput {
  isbn: string;
}

export interface SearchBooksResult {
  items: Book[];
  totalCount: number;
  hasMore: boolean;
}

export type { BookDetail } from "./book-mapper.js";

export interface BookSearchService {
  searchBooks(
    input: SearchBooksInput,
  ): Promise<Result<SearchBooksResult, BookSearchErrors>>;

  searchBookByISBN(
    input: SearchByISBNInput,
  ): Promise<Result<Book | null, BookSearchErrors>>;

  getBookDetail(
    bookId: string,
    source?: BookSource,
  ): Promise<Result<BookDetail, BookSearchErrors>>;
}

const DEFAULT_LIMIT = 10;
const MAX_LIMIT = 20;
const MIN_LIMIT = 1;

function validateSearchInput(
  input: SearchBooksInput,
): Result<{ query: string; limit: number; offset: number }, BookSearchErrors> {
  const query = input.query.trim();

  if (query.length === 0) {
    return err({
      code: "VALIDATION_ERROR",
      message: "Search query cannot be empty",
    });
  }

  const limit = input.limit ?? DEFAULT_LIMIT;
  const offset = input.offset ?? 0;

  if (limit < MIN_LIMIT || limit > MAX_LIMIT) {
    return err({
      code: "VALIDATION_ERROR",
      message: `limit must be between ${MIN_LIMIT} and ${MAX_LIMIT}`,
    });
  }

  if (offset < 0) {
    return err({
      code: "VALIDATION_ERROR",
      message: "offset must be non-negative",
    });
  }

  return ok({ query, limit, offset });
}

function normalizeIsbn(isbn: string): string {
  return isbn.replace(/-/g, "");
}

function isValidIsbnLength(isbn: string): boolean {
  const normalized = normalizeIsbn(isbn);
  return normalized.length === 10 || normalized.length === 13;
}

function validateIsbnInput(
  input: SearchByISBNInput,
): Result<{ isbn: string }, BookSearchErrors> {
  const isbn = input.isbn.trim();

  if (isbn.length === 0) {
    return err({
      code: "VALIDATION_ERROR",
      message: "ISBN cannot be empty",
    });
  }

  if (!isValidIsbnLength(isbn)) {
    return err({
      code: "VALIDATION_ERROR",
      message: "ISBN must be 10 or 13 digits",
    });
  }

  return ok({ isbn: normalizeIsbn(isbn) });
}

function looksLikeIsbn(id: string): boolean {
  return /^\d{10}$/.test(id) || /^\d{13}$/.test(id);
}

function mapExternalApiError(externalError: {
  code: string;
  message: string;
}): BookSearchErrors {
  switch (externalError.code) {
    case "NETWORK_ERROR":
    case "TIMEOUT_ERROR":
      return {
        code: "NETWORK_ERROR",
        message: externalError.message,
      };
    default:
      return {
        code: "EXTERNAL_API_ERROR",
        message: externalError.message,
      };
  }
}

export function createBookSearchService(
  externalRepository: ExternalBookRepository,
  logger: LoggerService,
  googleRepository?: GoogleBooksRepository,
): BookSearchService {
  return {
    async searchBooks(
      input: SearchBooksInput,
    ): Promise<Result<SearchBooksResult, BookSearchErrors>> {
      const validationResult = validateSearchInput(input);

      if (!validationResult.success) {
        return validationResult;
      }

      const { query, limit, offset } = validationResult.data;

      const rakutenResult = await externalRepository.searchByQuery(
        query,
        limit,
        offset,
      );

      if (!rakutenResult.success) {
        logger.warn("External API error during book search", {
          feature: "books",
          query,
          error: rakutenResult.error,
        });
        return err(mapExternalApiError(rakutenResult.error));
      }

      const rakutenTotal = rakutenResult.data.totalItems;
      const rakutenBooks = rakutenResult.data.items.map(mapRakutenBooksItem);

      // Case 1: Rakuten has enough results and not on boundary
      if (rakutenBooks.length >= limit && offset + limit < rakutenTotal) {
        logger.info("Book search completed successfully", {
          feature: "books",
          query,
          resultCount: rakutenBooks.length,
          totalCount: rakutenTotal,
        });
        return ok({
          items: rakutenBooks,
          totalCount: rakutenTotal,
          hasMore: true,
        });
      }

      // No Google repository available — return Rakuten only
      if (!googleRepository) {
        const hasMore = offset + rakutenBooks.length < rakutenTotal;
        logger.info("Book search completed successfully", {
          feature: "books",
          query,
          resultCount: rakutenBooks.length,
          totalCount: rakutenTotal,
        });
        return ok({
          items: rakutenBooks,
          totalCount: rakutenTotal,
          hasMore,
        });
      }

      // Case 2: Boundary page — Rakuten filled the page but next page would exceed
      if (rakutenBooks.length >= limit && offset + limit >= rakutenTotal) {
        const googleProbe = await googleRepository.searchByQuery(query, 1, 0);
        const googleTotal = googleProbe.success
          ? googleProbe.data.totalItems
          : 0;
        if (!googleProbe.success) {
          logger.warn("Google Books API error during probe", {
            feature: "books",
            query,
            error: googleProbe.error,
          });
        }
        const totalCount = rakutenTotal + googleTotal;
        const hasMore = offset + rakutenBooks.length < totalCount;

        logger.info("Book search completed successfully", {
          feature: "books",
          query,
          resultCount: rakutenBooks.length,
          totalCount,
        });
        return ok({
          items: rakutenBooks,
          totalCount,
          hasMore,
        });
      }

      // Case 3: Rakuten returned fewer than limit — fill with Google
      const googleOffset = Math.max(0, offset - rakutenTotal);
      const googleLimit = limit - rakutenBooks.length;

      const googleResult = await googleRepository.searchByQuery(
        query,
        googleLimit,
        googleOffset,
      );

      if (!googleResult.success) {
        logger.warn("Google Books API error during fill", {
          feature: "books",
          query,
          error: googleResult.error,
        });
        const hasMore = offset + rakutenBooks.length < rakutenTotal;
        logger.info("Book search completed successfully", {
          feature: "books",
          query,
          resultCount: rakutenBooks.length,
          totalCount: rakutenTotal,
        });
        return ok({
          items: rakutenBooks,
          totalCount: rakutenTotal,
          hasMore,
        });
      }

      const googleBooks = filterValidGoogleBooks(
        googleResult.data.items.map(mapGoogleBooksVolume),
      );
      const googleTotal = googleResult.data.totalItems;
      const combined = deduplicateByIsbn([...rakutenBooks, ...googleBooks]);
      const totalCount = rakutenTotal + googleTotal;
      const hasMore = offset + combined.length < totalCount;

      logger.info("Book search completed successfully", {
        feature: "books",
        query,
        resultCount: combined.length,
        totalCount,
      });

      return ok({
        items: combined,
        totalCount,
        hasMore,
      });
    },

    async searchBookByISBN(
      input: SearchByISBNInput,
    ): Promise<Result<Book | null, BookSearchErrors>> {
      const validationResult = validateIsbnInput(input);

      if (!validationResult.success) {
        return validationResult;
      }

      const { isbn } = validationResult.data;

      const repositoryResult = await externalRepository.searchByISBN(isbn);

      if (!repositoryResult.success) {
        logger.warn("External API error during ISBN search", {
          feature: "books",
          isbn,
          error: repositoryResult.error,
        });
        return err(mapExternalApiError(repositoryResult.error));
      }

      const item = repositoryResult.data;

      if (item === null) {
        logger.info("Book not found for ISBN", {
          feature: "books",
          isbn,
        });
        return ok(null);
      }

      const book = mapRakutenBooksItem(item);

      logger.info("ISBN search completed successfully", {
        feature: "books",
        isbn,
        bookId: book.id,
      });

      return ok(book);
    },

    async getBookDetail(
      bookId: string,
      source?: BookSource,
    ): Promise<Result<BookDetail, BookSearchErrors>> {
      if (!bookId.trim()) {
        return err({
          code: "VALIDATION_ERROR",
          message: "Book ID cannot be empty",
        });
      }

      if (source === "google" && googleRepository) {
        if (looksLikeIsbn(bookId)) {
          const searchResult = await googleRepository.searchByQuery(
            `isbn:${bookId}`,
            1,
            0,
          );

          if (!searchResult.success) {
            logger.warn("Google Books API error during ISBN search", {
              feature: "books",
              bookId,
              source,
              error: searchResult.error,
            });
            return err(mapExternalApiError(searchResult.error));
          }

          const items = searchResult.data.items;

          if (items.length === 0) {
            logger.info("Book not found", {
              feature: "books",
              bookId,
              source,
            });
            return err({
              code: "NOT_FOUND",
              message: "Book not found",
            });
          }

          const bookDetail = mapGoogleBooksVolumeToDetail(items[0]);

          logger.info("Book detail fetch completed successfully", {
            feature: "books",
            bookId,
            source,
          });

          return ok(bookDetail);
        }

        const repositoryResult = await googleRepository.getVolumeById(bookId);

        if (!repositoryResult.success) {
          logger.warn("Google Books API error during book detail fetch", {
            feature: "books",
            bookId,
            source,
            error: repositoryResult.error,
          });
          return err(mapExternalApiError(repositoryResult.error));
        }

        const volume = repositoryResult.data;

        if (volume === null) {
          logger.info("Book not found", {
            feature: "books",
            bookId,
            source,
          });
          return err({
            code: "NOT_FOUND",
            message: "Book not found",
          });
        }

        const bookDetail = mapGoogleBooksVolumeToDetail(volume);

        logger.info("Book detail fetch completed successfully", {
          feature: "books",
          bookId,
          source,
        });

        return ok(bookDetail);
      }

      const repositoryResult = await externalRepository.getBookByISBN(bookId);

      if (!repositoryResult.success) {
        logger.warn("External API error during book detail fetch", {
          feature: "books",
          bookId,
          error: repositoryResult.error,
        });
        return err(mapExternalApiError(repositoryResult.error));
      }

      const item = repositoryResult.data;

      if (item === null) {
        logger.info("Book not found", {
          feature: "books",
          bookId,
        });
        return err({
          code: "NOT_FOUND",
          message: "Book not found",
        });
      }

      const bookDetail = mapRakutenBooksItemToDetail(item);

      logger.info("Book detail fetch completed successfully", {
        feature: "books",
        bookId,
      });

      return ok(bookDetail);
    },
  };
}
