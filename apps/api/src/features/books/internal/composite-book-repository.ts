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

function hasJapaneseCharacters(text: string): boolean {
  return /[\u3040-\u309F\u30A0-\u30FF\u4E00-\u9FFF]/.test(text);
}

function isJapaneseIsbn(isbn: string | null): boolean {
  if (!isbn) return false;
  return isbn.startsWith("978-4") || isbn.startsWith("9784") || isbn.startsWith("979-4") || isbn.startsWith("9794");
}

function isJapaneseBook(book: Book): boolean {
  return isJapaneseIsbn(book.isbn) || hasJapaneseCharacters(book.title);
}

function filterJapaneseBooks(books: Book[]): Book[] {
  return books.filter(isJapaneseBook);
}

function rakutenFirstMerge(rakutenBooks: Book[], googleBooks: Book[]): Book[] {
  return [...rakutenBooks, ...googleBooks];
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
        ? filterJapaneseBooks(googleResult.data.items.map(mapGoogleBooksVolume))
        : [];

      if (!rakutenResult.success && !googleResult.success) {
        return err(rakutenResult.error);
      }

      const mergedBooks = rakutenFirstMerge(rakutenBooks, googleBooks);
      const deduplicatedBooks = deduplicateByIsbn(mergedBooks);

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
