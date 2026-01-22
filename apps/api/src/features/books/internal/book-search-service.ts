import { err, ok, type Result } from "../../../errors/result.js";
import type { LoggerService } from "../../../logger/index.js";
import { mapGoogleBooksVolume, type Book } from "./book-mapper.js";
import type { ExternalBookRepository } from "./external-book-repository.js";

export type BookSearchErrors =
  | { code: "NETWORK_ERROR"; message: string }
  | { code: "EXTERNAL_API_ERROR"; message: string }
  | { code: "VALIDATION_ERROR"; message: string };

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

export interface BookSearchService {
  searchBooks(
    input: SearchBooksInput,
  ): Promise<Result<SearchBooksResult, BookSearchErrors>>;

  searchBookByISBN(
    input: SearchByISBNInput,
  ): Promise<Result<Book | null, BookSearchErrors>>;
}

const DEFAULT_LIMIT = 10;
const MAX_LIMIT = 40;
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

function mapExternalApiError(
  externalError: { code: string; message: string },
): BookSearchErrors {
  switch (externalError.code) {
    case "NETWORK_ERROR":
    case "TIMEOUT_ERROR":
      return {
        code: "NETWORK_ERROR",
        message: externalError.message,
      };
    case "RATE_LIMIT_ERROR":
    case "API_ERROR":
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

      const { items: volumes, totalItems } = repositoryResult.data;
      const books = volumes.map(mapGoogleBooksVolume);
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

      const volume = repositoryResult.data;

      if (volume === null) {
        logger.info("Book not found for ISBN", {
          feature: "books",
          isbn,
        });
        return ok(null);
      }

      const book = mapGoogleBooksVolume(volume);

      logger.info("ISBN search completed successfully", {
        feature: "books",
        isbn,
        bookId: book.id,
      });

      return ok(book);
    },
  };
}
