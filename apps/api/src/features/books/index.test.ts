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
  mapRakutenBooksItem,
  type NewUserBook,
  type RakutenBooksItem,
  type SearchBooksInput,
  type SearchBooksResult,
  type SearchByISBNInput,
  type UserBook,
} from "./index.js";

describe("books Feature public API", () => {
  describe("exports", () => {
    it("mapRakutenBooksItem 関数がエクスポートされている", () => {
      expect(typeof mapRakutenBooksItem).toBe("function");
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
        source: "rakuten",
      };
      expect(book.id).toBe("test");
    });

    it("RakutenBooksItem 型がエクスポートされている", () => {
      const item: RakutenBooksItem = {
        title: "Test",
        author: "Test Author",
        publisherName: "Test Publisher",
        isbn: "9784123456789",
        itemPrice: 1980,
        salesDate: "2024年01月01日",
        availability: "1",
        itemUrl: "https://books.rakuten.co.jp/rb/12345678/",
        reviewCount: 10,
        reviewAverage: "4.0",
        booksGenreId: "001004008",
      };
      expect(item.isbn).toBe("9784123456789");
    });

    it("ExternalBookRepository 型がエクスポートされている", () => {
      const repo: ExternalBookRepository =
        createExternalBookRepository("test-key");
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
        findUserBookById: vi.fn(),
        createUserBook: vi.fn(),
        updateUserBook: vi.fn(),
        deleteUserBook: vi.fn(),
        getUserBooks: vi.fn(),
        getUserBooksWithPagination: vi.fn(),
        countUserBooks: vi.fn(),
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
      expect(typeof service.updateReadingStatus).toBe("function");
      expect(typeof service.updateReadingNote).toBe("function");
      expect(typeof service.getUserBooksWithPagination).toBe("function");
    });

    it("BookShelfRepository 型がエクスポートされている", () => {
      const repo: BookShelfRepository = {
        findUserBookByExternalId: vi.fn(),
        findUserBookById: vi.fn(),
        createUserBook: vi.fn(),
        updateUserBook: vi.fn(),
        deleteUserBook: vi.fn(),
        getUserBooks: vi.fn(),
        getUserBooksWithPagination: vi.fn(),
        countUserBooks: vi.fn(),
      };
      expect(typeof repo.findUserBookByExternalId).toBe("function");
      expect(typeof repo.findUserBookById).toBe("function");
      expect(typeof repo.createUserBook).toBe("function");
      expect(typeof repo.updateUserBook).toBe("function");
      expect(typeof repo.getUserBooks).toBe("function");
      expect(typeof repo.getUserBooksWithPagination).toBe("function");
      expect(typeof repo.countUserBooks).toBe("function");
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
        externalId: "9784123456789",
        title: "Test Book",
        authors: ["Author"],
        publisher: null,
        publishedDate: null,
        isbn: null,
        coverImageUrl: null,
      };
      expect(input.externalId).toBe("9784123456789");
    });

    it("AddBookToShelfInput 型がエクスポートされている", () => {
      const input: AddBookToShelfInput = {
        userId: 100,
        bookInput: {
          externalId: "9784123456789",
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
        externalId: "9784123456789",
        title: "Test Book",
        authors: [],
        publisher: null,
        publishedDate: null,
        isbn: null,
        coverImageUrl: null,
        addedAt: new Date(),
        readingStatus: "backlog",
        completedAt: null,
        note: null,
        noteUpdatedAt: null,
        rating: null,
        source: "rakuten",
      };
      expect(userBook.id).toBe(1);
    });

    it("NewUserBook 型がエクスポートされている", () => {
      const newUserBook: NewUserBook = {
        userId: 100,
        externalId: "9784123456789",
        title: "Test Book",
        authors: [],
      };
      expect(newUserBook.userId).toBe(100);
    });
  });
});
