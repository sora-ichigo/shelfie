import { describe, expect, it } from "vitest";
import {
  type Book,
  type BookSearchErrors,
  type BookSearchService,
  createBookSearchService,
  createExternalBookRepository,
  type ExternalApiErrors,
  type ExternalBookRepository,
  type GoogleBooksVolume,
  mapGoogleBooksVolume,
  type SearchBooksInput,
  type SearchBooksResult,
  type SearchByISBNInput,
} from "./index.js";

describe("books Feature public API", () => {
  describe("exports", () => {
    it("mapGoogleBooksVolume 関数がエクスポートされている", () => {
      expect(typeof mapGoogleBooksVolume).toBe("function");
    });

    it("createExternalBookRepository 関数がエクスポートされている", () => {
      expect(typeof createExternalBookRepository).toBe("function");
    });

    it("Book 型がエクスポートされている", () => {
      const book: Book = {
        id: "test",
        title: "Test",
        authors: [],
        publisher: null,
        publishedDate: null,
        isbn: null,
        coverImageUrl: null,
      };
      expect(book.id).toBe("test");
    });

    it("GoogleBooksVolume 型がエクスポートされている", () => {
      const volume: GoogleBooksVolume = {
        id: "test",
        volumeInfo: {
          title: "Test",
        },
      };
      expect(volume.id).toBe("test");
    });

    it("ExternalBookRepository 型がエクスポートされている", () => {
      const repo: ExternalBookRepository = createExternalBookRepository(
        "test-key",
      );
      expect(typeof repo.searchByQuery).toBe("function");
      expect(typeof repo.searchByISBN).toBe("function");
    });

    it("ExternalApiErrors 型がエクスポートされている", () => {
      const error: ExternalApiErrors = {
        code: "NETWORK_ERROR",
        message: "test",
      };
      expect(error.code).toBe("NETWORK_ERROR");
    });

    it("createBookSearchService 関数がエクスポートされている", () => {
      expect(typeof createBookSearchService).toBe("function");
    });

    it("BookSearchService 型がエクスポートされている", () => {
      const mockLogger = {
        debug: () => {},
        info: () => {},
        warn: () => {},
        error: () => {},
        child: () => mockLogger,
      };
      const repo = createExternalBookRepository("test-key");
      const service: BookSearchService = createBookSearchService(
        repo,
        mockLogger,
      );
      expect(typeof service.searchBooks).toBe("function");
      expect(typeof service.searchBookByISBN).toBe("function");
    });

    it("BookSearchErrors 型がエクスポートされている", () => {
      const error: BookSearchErrors = {
        code: "VALIDATION_ERROR",
        message: "test",
      };
      expect(error.code).toBe("VALIDATION_ERROR");
    });

    it("SearchBooksInput 型がエクスポートされている", () => {
      const input: SearchBooksInput = {
        query: "test",
        limit: 10,
        offset: 0,
      };
      expect(input.query).toBe("test");
    });

    it("SearchBooksResult 型がエクスポートされている", () => {
      const result: SearchBooksResult = {
        items: [],
        totalCount: 0,
        hasMore: false,
      };
      expect(result.items).toHaveLength(0);
    });

    it("SearchByISBNInput 型がエクスポートされている", () => {
      const input: SearchByISBNInput = {
        isbn: "9784123456789",
      };
      expect(input.isbn).toBe("9784123456789");
    });
  });
});
