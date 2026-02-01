import { err, ok, type Result } from "../../../errors/result.js";
import type { LoggerService } from "../../../logger/index.js";
import {
  type Book,
  type BookDetail,
  type BookSource,
  mapGoogleBooksVolumeToDetail,
  mapRakutenBooksItem,
  mapRakutenBooksItemToDetail,
} from "./book-mapper.js";
import type { CompositeBookRepository } from "./composite-book-repository.js";
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
  compositeRepository?: CompositeBookRepository,
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

      if (compositeRepository) {
        const repositoryResult = await compositeRepository.searchByQuery(
          query,
          limit,
          offset,
        );

        if (!repositoryResult.success) {
          logger.warn("Composite API error during book search", {
            feature: "books",
            query,
            error: repositoryResult.error,
          });
          return err(mapExternalApiError(repositoryResult.error));
        }

        const { items, totalItems } = repositoryResult.data;
        const hasMore = offset + items.length < totalItems;

        logger.info("Book search completed successfully (composite)", {
          feature: "books",
          query,
          resultCount: items.length,
          totalCount: totalItems,
        });

        return ok({
          items,
          totalCount: totalItems,
          hasMore,
        });
      }

      const repositoryResult = await externalRepository.searchByQuery(
        query,
        limit,
        offset,
      );

      if (!repositoryResult.success) {
        logger.warn("External API error during book search", {
          feature: "books",
          query,
          error: repositoryResult.error,
        });
        return err(mapExternalApiError(repositoryResult.error));
      }

      const { items, totalItems } = repositoryResult.data;
      const books = items.map(mapRakutenBooksItem);
      const hasMore = offset + books.length < totalItems;

      logger.info("Book search completed successfully", {
        feature: "books",
        query,
        resultCount: books.length,
        totalCount: totalItems,
      });

      return ok({
        items: books,
        totalCount: totalItems,
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
