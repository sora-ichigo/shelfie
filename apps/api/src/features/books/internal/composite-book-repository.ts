import { err, ok, type Result } from "../../../errors/result.js";
import type { LoggerService } from "../../../logger/index.js";
import {
  type Book,
  mapGoogleBooksVolume,
  mapRakutenBooksItem,
} from "./book-mapper.js";
import type {
  ExternalApiErrors,
  ExternalBookRepository,
} from "./external-book-repository.js";
import type { GoogleBooksRepository } from "./google-books-repository.js";

export interface CompositeBookRepository {
  searchByQuery(
    query: string,
    limit: number,
    offset: number,
  ): Promise<Result<{ items: Book[]; totalItems: number }, ExternalApiErrors>>;
}

function balancedInterleave(rakutenBooks: Book[], googleBooks: Book[]): Book[] {
  const result: Book[] = [];
  const maxLength = Math.max(rakutenBooks.length, googleBooks.length);

  for (let i = 0; i < maxLength; i++) {
    if (i < rakutenBooks.length) {
      result.push(rakutenBooks[i]);
    }
    if (i < googleBooks.length) {
      result.push(googleBooks[i]);
    }
  }

  return result;
}

function deduplicateByIsbn(books: Book[]): Book[] {
  const seenIsbns = new Set<string>();
  const result: Book[] = [];

  for (const book of books) {
    if (book.isbn === null) {
      result.push(book);
      continue;
    }

    if (!seenIsbns.has(book.isbn)) {
      seenIsbns.add(book.isbn);
      result.push(book);
    }
  }

  return result;
}

export function createCompositeBookRepository(
  rakutenRepository: ExternalBookRepository,
  googleRepository: GoogleBooksRepository,
  logger: LoggerService,
): CompositeBookRepository {
  return {
    async searchByQuery(
      query: string,
      limit: number,
      offset: number,
    ): Promise<
      Result<{ items: Book[]; totalItems: number }, ExternalApiErrors>
    > {
      const [rakutenResult, googleResult] = await Promise.all([
        rakutenRepository.searchByQuery(query, limit, offset),
        googleRepository.searchByQuery(query, limit, offset),
      ]);

      if (!rakutenResult.success) {
        logger.warn("Rakuten Books API error", {
          feature: "books",
          query,
          error: rakutenResult.error,
        });
      }

      if (!googleResult.success) {
        logger.warn("Google Books API error", {
          feature: "books",
          query,
          error: googleResult.error,
        });
      }

      const rakutenBooks = rakutenResult.success
        ? rakutenResult.data.items.map(mapRakutenBooksItem)
        : [];
      const googleBooks = googleResult.success
        ? googleResult.data.items.map(mapGoogleBooksVolume)
        : [];

      if (!rakutenResult.success && !googleResult.success) {
        return err(rakutenResult.error);
      }

      const interleavedBooks = balancedInterleave(rakutenBooks, googleBooks);
      const deduplicatedBooks = deduplicateByIsbn(interleavedBooks);

      const totalItems =
        (rakutenResult.success ? rakutenResult.data.totalItems : 0) +
        (googleResult.success ? googleResult.data.totalItems : 0);

      return ok({
        items: deduplicatedBooks,
        totalItems,
      });
    },
  };
}
