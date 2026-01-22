import { describe, expect, it, vi } from "vitest";
import {
  type AddBookInput,
  type AddBookToShelfInput,
  type Book,
  type BookSearchErrors,
  type BookSearchService,
  type BookShelfErrors,
  type BookShelfRepository,
  type BookShelfService,
  createBookSearchService,
  createBookShelfService,
  createExternalBookRepository,
  type ExternalApiErrors,
  type ExternalBookRepository,
  type GoogleBooksVolume,
  mapGoogleBooksVolume,
  type NewUserBook,
  type SearchBooksInput,
  type SearchBooksResult,
  type SearchByISBNInput,
  type UserBook,
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

    it("createBookShelfService 関数がエクスポートされている", () => {
      expect(typeof createBookShelfService).toBe("function");
    });

    it("BookShelfService 型がエクスポートされている", () => {
      const mockRepo: BookShelfRepository = {
        findUserBookByExternalId: vi.fn(),
        createUserBook: vi.fn(),
        getUserBooks: vi.fn(),
      };
      const mockLogger = {
        debug: () => {},
        info: () => {},
        warn: () => {},
        error: () => {},
        child: () => mockLogger,
      };
      const service: BookShelfService = createBookShelfService(
        mockRepo,
        mockLogger,
      );
      expect(typeof service.addBookToShelf).toBe("function");
    });

    it("BookShelfRepository 型がエクスポートされている", () => {
      const repo: BookShelfRepository = {
        findUserBookByExternalId: vi.fn(),
        createUserBook: vi.fn(),
        getUserBooks: vi.fn(),
      };
      expect(typeof repo.findUserBookByExternalId).toBe("function");
      expect(typeof repo.createUserBook).toBe("function");
      expect(typeof repo.getUserBooks).toBe("function");
    });

    it("BookShelfErrors 型がエクスポートされている", () => {
      const error: BookShelfErrors = {
        code: "DUPLICATE_BOOK",
        message: "test",
      };
      expect(error.code).toBe("DUPLICATE_BOOK");
    });

    it("AddBookInput 型がエクスポートされている", () => {
      const input: AddBookInput = {
        externalId: "google-123",
        title: "Test Book",
        authors: ["Author"],
        publisher: null,
        publishedDate: null,
        isbn: null,
        coverImageUrl: null,
      };
      expect(input.externalId).toBe("google-123");
    });

    it("AddBookToShelfInput 型がエクスポートされている", () => {
      const input: AddBookToShelfInput = {
        userId: 100,
        bookInput: {
          externalId: "google-123",
          title: "Test Book",
          authors: [],
          publisher: null,
          publishedDate: null,
          isbn: null,
          coverImageUrl: null,
        },
      };
      expect(input.userId).toBe(100);
    });

    it("UserBook 型がエクスポートされている", () => {
      const userBook: UserBook = {
        id: 1,
        userId: 100,
        externalId: "google-123",
        title: "Test Book",
        authors: [],
        publisher: null,
        publishedDate: null,
        isbn: null,
        coverImageUrl: null,
        addedAt: new Date(),
      };
      expect(userBook.id).toBe(1);
    });

    it("NewUserBook 型がエクスポートされている", () => {
      const newUserBook: NewUserBook = {
        userId: 100,
        externalId: "google-123",
        title: "Test Book",
        authors: [],
      };
      expect(newUserBook.userId).toBe(100);
    });
  });
});
