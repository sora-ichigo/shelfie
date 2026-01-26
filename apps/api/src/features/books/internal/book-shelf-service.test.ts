import { describe, expect, it, vi } from "vitest";
import type { UserBook } from "../../../db/schema/books.js";
import type { BookShelfRepository } from "./book-shelf-repository.js";
import {
  type AddBookToShelfInput,
  createBookShelfService,
} from "./book-shelf-service.js";

function createMockRepository(): BookShelfRepository & {
  mockFindUserBookByExternalId: ReturnType<typeof vi.fn>;
  mockCreateUserBook: ReturnType<typeof vi.fn>;
  mockGetUserBooks: ReturnType<typeof vi.fn>;
  mockGetUserBooksWithPagination: ReturnType<typeof vi.fn>;
  mockFindUserBookById: ReturnType<typeof vi.fn>;
  mockUpdateUserBook: ReturnType<typeof vi.fn>;
  mockDeleteUserBook: ReturnType<typeof vi.fn>;
  mockCountUserBooks: ReturnType<typeof vi.fn>;
} {
  const mockFindUserBookByExternalId = vi.fn();
  const mockCreateUserBook = vi.fn();
  const mockGetUserBooks = vi.fn();
  const mockGetUserBooksWithPagination = vi.fn();
  const mockFindUserBookById = vi.fn();
  const mockUpdateUserBook = vi.fn();
  const mockDeleteUserBook = vi.fn();
  const mockCountUserBooks = vi.fn();

  return {
    findUserBookByExternalId: mockFindUserBookByExternalId,
    createUserBook: mockCreateUserBook,
    getUserBooks: mockGetUserBooks,
    getUserBooksWithPagination: mockGetUserBooksWithPagination,
    findUserBookById: mockFindUserBookById,
    updateUserBook: mockUpdateUserBook,
    deleteUserBook: mockDeleteUserBook,
    countUserBooks: mockCountUserBooks,
    mockFindUserBookByExternalId,
    mockCreateUserBook,
    mockGetUserBooks,
    mockGetUserBooksWithPagination,
    mockFindUserBookById,
    mockUpdateUserBook,
    mockDeleteUserBook,
    mockCountUserBooks,
  };
}

function createMockLogger() {
  return {
    debug: vi.fn(),
    info: vi.fn(),
    warn: vi.fn(),
    error: vi.fn(),
    child: vi.fn().mockReturnThis(),
  };
}

describe("BookShelfService", () => {
  describe("addBookToShelf", () => {
    it("should add a book to the shelf successfully when book does not exist", async () => {
      const mockRepository = createMockRepository();
      const mockLogger = createMockLogger();

      mockRepository.mockFindUserBookByExternalId.mockResolvedValue(null);

      const createdUserBook: UserBook = {
        id: 1,
        userId: 100,
        externalId: "google-book-123",
        title: "Test Book",
        authors: ["Author One"],
        publisher: "Test Publisher",
        publishedDate: "2024-01-01",
        isbn: "9781234567890",
        coverImageUrl: "https://example.com/cover.jpg",
        source: "rakuten",
        addedAt: new Date(),
        readingStatus: "backlog",
        completedAt: null,
        note: null,
        noteUpdatedAt: null,
        rating: null,
      };
      mockRepository.mockCreateUserBook.mockResolvedValue(createdUserBook);

      const service = createBookShelfService(mockRepository, mockLogger);

      const input: AddBookToShelfInput = {
        userId: 100,
        bookInput: {
          externalId: "google-book-123",
          title: "Test Book",
          authors: ["Author One"],
          publisher: "Test Publisher",
          publishedDate: "2024-01-01",
          isbn: "9781234567890",
          coverImageUrl: "https://example.com/cover.jpg",
        },
      };

      const result = await service.addBookToShelf(input);

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data).toEqual(createdUserBook);
      }
      expect(mockRepository.mockFindUserBookByExternalId).toHaveBeenCalledWith(
        100,
        "google-book-123",
      );
      expect(mockRepository.mockCreateUserBook).toHaveBeenCalledWith({
        userId: 100,
        externalId: "google-book-123",
        title: "Test Book",
        authors: ["Author One"],
        publisher: "Test Publisher",
        publishedDate: "2024-01-01",
        isbn: "9781234567890",
        coverImageUrl: "https://example.com/cover.jpg",
        source: "rakuten",
      });
      expect(mockLogger.info).toHaveBeenCalledWith(
        "Book added to shelf successfully",
        expect.objectContaining({
          feature: "books",
          userId: "100",
          externalId: "google-book-123",
        }),
      );
    });

    it("should return DUPLICATE_BOOK error when book already exists", async () => {
      const mockRepository = createMockRepository();
      const mockLogger = createMockLogger();

      const existingUserBook: UserBook = {
        id: 1,
        userId: 100,
        externalId: "google-book-123",
        title: "Test Book",
        authors: ["Author One"],
        publisher: "Test Publisher",
        publishedDate: "2024-01-01",
        isbn: "9781234567890",
        coverImageUrl: "https://example.com/cover.jpg",
        source: "rakuten",
        addedAt: new Date(),
        readingStatus: "backlog",
        completedAt: null,
        note: null,
        noteUpdatedAt: null,
        rating: null,
      };
      mockRepository.mockFindUserBookByExternalId.mockResolvedValue(
        existingUserBook,
      );

      const service = createBookShelfService(mockRepository, mockLogger);

      const input: AddBookToShelfInput = {
        userId: 100,
        bookInput: {
          externalId: "google-book-123",
          title: "Test Book",
          authors: ["Author One"],
          publisher: "Test Publisher",
          publishedDate: "2024-01-01",
          isbn: "9781234567890",
          coverImageUrl: "https://example.com/cover.jpg",
        },
      };

      const result = await service.addBookToShelf(input);

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("DUPLICATE_BOOK");
        expect(result.error.message).toBe("This book is already in your shelf");
      }
      expect(mockRepository.mockCreateUserBook).not.toHaveBeenCalled();
      expect(mockLogger.info).toHaveBeenCalledWith(
        "Duplicate book detected",
        expect.objectContaining({
          feature: "books",
          userId: "100",
          externalId: "google-book-123",
        }),
      );
    });

    it("should return DATABASE_ERROR when repository throws", async () => {
      const mockRepository = createMockRepository();
      const mockLogger = createMockLogger();

      mockRepository.mockFindUserBookByExternalId.mockResolvedValue(null);
      mockRepository.mockCreateUserBook.mockRejectedValue(
        new Error("Database connection failed"),
      );

      const service = createBookShelfService(mockRepository, mockLogger);

      const input: AddBookToShelfInput = {
        userId: 100,
        bookInput: {
          externalId: "google-book-123",
          title: "Test Book",
          authors: ["Author One"],
          publisher: null,
          publishedDate: null,
          isbn: null,
          coverImageUrl: null,
        },
      };

      const result = await service.addBookToShelf(input);

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("DATABASE_ERROR");
        expect(result.error.message).toContain("Database connection failed");
      }
      expect(mockLogger.error).toHaveBeenCalledWith(
        "Database error while adding book to shelf",
        expect.any(Error),
        expect.objectContaining({
          feature: "books",
          userId: "100",
          externalId: "google-book-123",
        }),
      );
    });

    it("should handle book with optional fields as null", async () => {
      const mockRepository = createMockRepository();
      const mockLogger = createMockLogger();

      mockRepository.mockFindUserBookByExternalId.mockResolvedValue(null);

      const createdUserBook: UserBook = {
        id: 2,
        userId: 100,
        externalId: "google-book-456",
        title: "Minimal Book",
        authors: [],
        publisher: null,
        publishedDate: null,
        isbn: null,
        coverImageUrl: null,
        source: "rakuten",
        addedAt: new Date(),
        readingStatus: "backlog",
        completedAt: null,
        note: null,
        noteUpdatedAt: null,
        rating: null,
      };
      mockRepository.mockCreateUserBook.mockResolvedValue(createdUserBook);

      const service = createBookShelfService(mockRepository, mockLogger);

      const input: AddBookToShelfInput = {
        userId: 100,
        bookInput: {
          externalId: "google-book-456",
          title: "Minimal Book",
          authors: [],
          publisher: null,
          publishedDate: null,
          isbn: null,
          coverImageUrl: null,
        },
      };

      const result = await service.addBookToShelf(input);

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.publisher).toBeNull();
        expect(result.data.publishedDate).toBeNull();
        expect(result.data.isbn).toBeNull();
        expect(result.data.coverImageUrl).toBeNull();
      }
    });

    it("should return DATABASE_ERROR when checking for existing book fails", async () => {
      const mockRepository = createMockRepository();
      const mockLogger = createMockLogger();

      mockRepository.mockFindUserBookByExternalId.mockRejectedValue(
        new Error("Connection timeout"),
      );

      const service = createBookShelfService(mockRepository, mockLogger);

      const input: AddBookToShelfInput = {
        userId: 100,
        bookInput: {
          externalId: "google-book-123",
          title: "Test Book",
          authors: [],
          publisher: null,
          publishedDate: null,
          isbn: null,
          coverImageUrl: null,
        },
      };

      const result = await service.addBookToShelf(input);

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("DATABASE_ERROR");
      }
    });
  });

  describe("getUserBooksWithPagination", () => {
    it("should return paginated user books with totalCount and hasMore", async () => {
      const mockRepository = createMockRepository();
      const mockLogger = createMockLogger();

      const userBooks: UserBook[] = [
        {
          id: 1,
          userId: 100,
          externalId: "book-1",
          title: "Test Book 1",
          authors: ["Author One"],
          publisher: null,
          publishedDate: null,
          isbn: null,
          coverImageUrl: "https://example.com/cover1.jpg",
          source: "rakuten",
          addedAt: new Date(),
          readingStatus: "reading",
          completedAt: null,
          note: null,
          noteUpdatedAt: null,
          rating: null,
        },
        {
          id: 2,
          userId: 100,
          externalId: "book-2",
          title: "Test Book 2",
          authors: ["Author Two"],
          publisher: null,
          publishedDate: null,
          isbn: null,
          coverImageUrl: "https://example.com/cover2.jpg",
          source: "rakuten",
          addedAt: new Date(),
          readingStatus: "completed",
          completedAt: new Date(),
          note: null,
          noteUpdatedAt: null,
          rating: null,
        },
      ];

      mockRepository.mockGetUserBooksWithPagination.mockResolvedValue({
        items: userBooks,
        totalCount: 25,
      });

      const service = createBookShelfService(mockRepository, mockLogger);

      const result = await service.getUserBooksWithPagination(100, {
        limit: 20,
        offset: 0,
      });

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.items).toEqual(userBooks);
        expect(result.data.totalCount).toBe(25);
        expect(result.data.hasMore).toBe(true);
      }
    });

    it("should return hasMore false when no more items", async () => {
      const mockRepository = createMockRepository();
      const mockLogger = createMockLogger();

      const userBooks: UserBook[] = [
        {
          id: 1,
          userId: 100,
          externalId: "book-1",
          title: "Test Book 1",
          authors: ["Author One"],
          publisher: null,
          publishedDate: null,
          isbn: null,
          coverImageUrl: null,
          source: "rakuten",
          addedAt: new Date(),
          readingStatus: "reading",
          completedAt: null,
          note: null,
          noteUpdatedAt: null,
          rating: null,
        },
      ];

      mockRepository.mockGetUserBooksWithPagination.mockResolvedValue({
        items: userBooks,
        totalCount: 1,
      });

      const service = createBookShelfService(mockRepository, mockLogger);

      const result = await service.getUserBooksWithPagination(100, {
        limit: 20,
        offset: 0,
      });

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.hasMore).toBe(false);
      }
    });

    it("should pass search query to repository", async () => {
      const mockRepository = createMockRepository();
      const mockLogger = createMockLogger();

      mockRepository.mockGetUserBooksWithPagination.mockResolvedValue({
        items: [],
        totalCount: 0,
      });

      const service = createBookShelfService(mockRepository, mockLogger);

      await service.getUserBooksWithPagination(100, {
        query: "JavaScript",
        sortBy: "TITLE",
        sortOrder: "ASC",
        limit: 10,
        offset: 5,
      });

      expect(
        mockRepository.mockGetUserBooksWithPagination,
      ).toHaveBeenCalledWith(100, {
        query: "JavaScript",
        sortBy: "TITLE",
        sortOrder: "ASC",
        limit: 10,
        offset: 5,
      });
    });

    it("should return DATABASE_ERROR when repository throws", async () => {
      const mockRepository = createMockRepository();
      const mockLogger = createMockLogger();

      mockRepository.mockGetUserBooksWithPagination.mockRejectedValue(
        new Error("Database connection failed"),
      );

      const service = createBookShelfService(mockRepository, mockLogger);

      const result = await service.getUserBooksWithPagination(100, {});

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("DATABASE_ERROR");
      }
    });
  });

  describe("interface compliance", () => {
    it("should implement BookShelfService methods", () => {
      const mockRepository = createMockRepository();
      const mockLogger = createMockLogger();
      const service = createBookShelfService(mockRepository, mockLogger);

      expect(typeof service.addBookToShelf).toBe("function");
      expect(typeof service.getUserBookByExternalId).toBe("function");
      expect(typeof service.getUserBooks).toBe("function");
      expect(typeof service.updateReadingStatus).toBe("function");
      expect(typeof service.updateReadingNote).toBe("function");
      expect(typeof service.removeFromShelf).toBe("function");
    });
  });

  describe("getUserBooks", () => {
    it("should return all user books successfully", async () => {
      const mockRepository = createMockRepository();
      const mockLogger = createMockLogger();

      const userBooks: UserBook[] = [
        {
          id: 1,
          userId: 100,
          externalId: "google-book-1",
          title: "Test Book 1",
          authors: ["Author One"],
          publisher: null,
          publishedDate: null,
          isbn: null,
          coverImageUrl: null,
          source: "rakuten",
          addedAt: new Date(),
          readingStatus: "reading",
          completedAt: null,
          note: null,
          noteUpdatedAt: null,
          rating: null,
        },
        {
          id: 2,
          userId: 100,
          externalId: "google-book-2",
          title: "Test Book 2",
          authors: ["Author Two"],
          publisher: null,
          publishedDate: null,
          isbn: null,
          coverImageUrl: null,
          source: "rakuten",
          addedAt: new Date(),
          readingStatus: "completed",
          completedAt: new Date(),
          note: "Great book!",
          noteUpdatedAt: new Date(),
          rating: null,
        },
      ];
      mockRepository.mockGetUserBooks.mockResolvedValue(userBooks);

      const service = createBookShelfService(mockRepository, mockLogger);

      const result = await service.getUserBooks(100);

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data).toEqual(userBooks);
        expect(result.data).toHaveLength(2);
      }
      expect(mockRepository.mockGetUserBooks).toHaveBeenCalledWith(100);
    });

    it("should return empty array when user has no books", async () => {
      const mockRepository = createMockRepository();
      const mockLogger = createMockLogger();

      mockRepository.mockGetUserBooks.mockResolvedValue([]);

      const service = createBookShelfService(mockRepository, mockLogger);

      const result = await service.getUserBooks(100);

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data).toEqual([]);
        expect(result.data).toHaveLength(0);
      }
    });

    it("should return DATABASE_ERROR when repository throws", async () => {
      const mockRepository = createMockRepository();
      const mockLogger = createMockLogger();

      mockRepository.mockGetUserBooks.mockRejectedValue(
        new Error("Database connection failed"),
      );

      const service = createBookShelfService(mockRepository, mockLogger);

      const result = await service.getUserBooks(100);

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("DATABASE_ERROR");
        expect(result.error.message).toContain("Database connection failed");
      }
      expect(mockLogger.error).toHaveBeenCalledWith(
        "Database error while fetching user books",
        expect.any(Error),
        expect.objectContaining({
          feature: "books",
          userId: "100",
        }),
      );
    });
  });

  describe("updateReadingStatus", () => {
    it("should update reading status successfully", async () => {
      const mockRepository = createMockRepository();
      const mockLogger = createMockLogger();

      const existingUserBook: UserBook = {
        id: 1,
        userId: 100,
        externalId: "google-book-123",
        title: "Test Book",
        authors: ["Author One"],
        publisher: "Test Publisher",
        publishedDate: "2024-01-01",
        isbn: "9781234567890",
        coverImageUrl: "https://example.com/cover.jpg",
        source: "rakuten",
        addedAt: new Date(),
        readingStatus: "backlog",
        completedAt: null,
        note: null,
        noteUpdatedAt: null,
        rating: null,
      };
      mockRepository.mockFindUserBookById.mockResolvedValue(existingUserBook);

      const updatedUserBook: UserBook = {
        ...existingUserBook,
        readingStatus: "reading",
      };
      mockRepository.mockUpdateUserBook.mockResolvedValue(updatedUserBook);

      const service = createBookShelfService(mockRepository, mockLogger);

      const result = await service.updateReadingStatus({
        userBookId: 1,
        userId: 100,
        status: "reading",
      });

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.readingStatus).toBe("reading");
      }
      expect(mockRepository.mockUpdateUserBook).toHaveBeenCalledWith(
        1,
        expect.objectContaining({
          readingStatus: "reading",
        }),
      );
    });

    it("should set completedAt when status is changed to completed", async () => {
      const mockRepository = createMockRepository();
      const mockLogger = createMockLogger();

      const existingUserBook: UserBook = {
        id: 1,
        userId: 100,
        externalId: "google-book-123",
        title: "Test Book",
        authors: ["Author One"],
        publisher: null,
        publishedDate: null,
        isbn: null,
        coverImageUrl: null,
        source: "rakuten",
        addedAt: new Date(),
        readingStatus: "reading",
        completedAt: null,
        note: null,
        noteUpdatedAt: null,
        rating: null,
      };
      mockRepository.mockFindUserBookById.mockResolvedValue(existingUserBook);

      const completedAt = new Date();
      const updatedUserBook: UserBook = {
        ...existingUserBook,
        readingStatus: "completed",
        completedAt,
      };
      mockRepository.mockUpdateUserBook.mockResolvedValue(updatedUserBook);

      const service = createBookShelfService(mockRepository, mockLogger);

      const result = await service.updateReadingStatus({
        userBookId: 1,
        userId: 100,
        status: "completed",
      });

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.readingStatus).toBe("completed");
        expect(result.data.completedAt).toBeDefined();
      }
      expect(mockRepository.mockUpdateUserBook).toHaveBeenCalledWith(
        1,
        expect.objectContaining({
          readingStatus: "completed",
          completedAt: expect.any(Date),
        }),
      );
    });

    it("should clear completedAt when status is changed from completed to another status", async () => {
      const mockRepository = createMockRepository();
      const mockLogger = createMockLogger();

      const existingUserBook: UserBook = {
        id: 1,
        userId: 100,
        externalId: "google-book-123",
        title: "Test Book",
        authors: ["Author One"],
        publisher: null,
        publishedDate: null,
        isbn: null,
        coverImageUrl: null,
        source: "rakuten",
        addedAt: new Date(),
        readingStatus: "completed",
        completedAt: new Date(),
        note: null,
        noteUpdatedAt: null,
        rating: null,
      };
      mockRepository.mockFindUserBookById.mockResolvedValue(existingUserBook);

      const updatedUserBook: UserBook = {
        ...existingUserBook,
        readingStatus: "reading",
        completedAt: null,
      };
      mockRepository.mockUpdateUserBook.mockResolvedValue(updatedUserBook);

      const service = createBookShelfService(mockRepository, mockLogger);

      const result = await service.updateReadingStatus({
        userBookId: 1,
        userId: 100,
        status: "reading",
      });

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.readingStatus).toBe("reading");
        expect(result.data.completedAt).toBeNull();
      }
      expect(mockRepository.mockUpdateUserBook).toHaveBeenCalledWith(
        1,
        expect.objectContaining({
          readingStatus: "reading",
          completedAt: null,
        }),
      );
    });

    it("should return BOOK_NOT_FOUND error when user book does not exist", async () => {
      const mockRepository = createMockRepository();
      const mockLogger = createMockLogger();

      mockRepository.mockFindUserBookById.mockResolvedValue(null);

      const service = createBookShelfService(mockRepository, mockLogger);

      const result = await service.updateReadingStatus({
        userBookId: 999,
        userId: 100,
        status: "reading",
      });

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("BOOK_NOT_FOUND");
      }
      expect(mockRepository.mockUpdateUserBook).not.toHaveBeenCalled();
    });

    it("should return FORBIDDEN error when user does not own the book", async () => {
      const mockRepository = createMockRepository();
      const mockLogger = createMockLogger();

      const existingUserBook: UserBook = {
        id: 1,
        userId: 200,
        externalId: "google-book-123",
        title: "Test Book",
        authors: ["Author One"],
        publisher: null,
        publishedDate: null,
        isbn: null,
        coverImageUrl: null,
        source: "rakuten",
        addedAt: new Date(),
        readingStatus: "backlog",
        completedAt: null,
        note: null,
        noteUpdatedAt: null,
        rating: null,
      };
      mockRepository.mockFindUserBookById.mockResolvedValue(existingUserBook);

      const service = createBookShelfService(mockRepository, mockLogger);

      const result = await service.updateReadingStatus({
        userBookId: 1,
        userId: 100,
        status: "reading",
      });

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("FORBIDDEN");
      }
      expect(mockRepository.mockUpdateUserBook).not.toHaveBeenCalled();
    });

    it("should return DATABASE_ERROR when repository throws", async () => {
      const mockRepository = createMockRepository();
      const mockLogger = createMockLogger();

      mockRepository.mockFindUserBookById.mockRejectedValue(
        new Error("Database connection failed"),
      );

      const service = createBookShelfService(mockRepository, mockLogger);

      const result = await service.updateReadingStatus({
        userBookId: 1,
        userId: 100,
        status: "reading",
      });

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("DATABASE_ERROR");
      }
    });
  });

  describe("updateReadingNote", () => {
    it("should update reading note successfully", async () => {
      const mockRepository = createMockRepository();
      const mockLogger = createMockLogger();

      const existingUserBook: UserBook = {
        id: 1,
        userId: 100,
        externalId: "google-book-123",
        title: "Test Book",
        authors: ["Author One"],
        publisher: null,
        publishedDate: null,
        isbn: null,
        coverImageUrl: null,
        source: "rakuten",
        addedAt: new Date(),
        readingStatus: "reading",
        completedAt: null,
        note: null,
        noteUpdatedAt: null,
        rating: null,
      };
      mockRepository.mockFindUserBookById.mockResolvedValue(existingUserBook);

      const noteUpdatedAt = new Date();
      const updatedUserBook: UserBook = {
        ...existingUserBook,
        note: "This is a great book!",
        noteUpdatedAt,
      };
      mockRepository.mockUpdateUserBook.mockResolvedValue(updatedUserBook);

      const service = createBookShelfService(mockRepository, mockLogger);

      const result = await service.updateReadingNote({
        userBookId: 1,
        userId: 100,
        note: "This is a great book!",
      });

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.note).toBe("This is a great book!");
        expect(result.data.noteUpdatedAt).toBeDefined();
      }
      expect(mockRepository.mockUpdateUserBook).toHaveBeenCalledWith(
        1,
        expect.objectContaining({
          note: "This is a great book!",
          noteUpdatedAt: expect.any(Date),
        }),
      );
    });

    it("should allow empty note (delete note)", async () => {
      const mockRepository = createMockRepository();
      const mockLogger = createMockLogger();

      const existingUserBook: UserBook = {
        id: 1,
        userId: 100,
        externalId: "google-book-123",
        title: "Test Book",
        authors: ["Author One"],
        publisher: null,
        publishedDate: null,
        isbn: null,
        coverImageUrl: null,
        source: "rakuten",
        addedAt: new Date(),
        readingStatus: "reading",
        completedAt: null,
        note: "Old note",
        noteUpdatedAt: new Date(),
        rating: null,
      };
      mockRepository.mockFindUserBookById.mockResolvedValue(existingUserBook);

      const noteUpdatedAt = new Date();
      const updatedUserBook: UserBook = {
        ...existingUserBook,
        note: "",
        noteUpdatedAt,
      };
      mockRepository.mockUpdateUserBook.mockResolvedValue(updatedUserBook);

      const service = createBookShelfService(mockRepository, mockLogger);

      const result = await service.updateReadingNote({
        userBookId: 1,
        userId: 100,
        note: "",
      });

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.note).toBe("");
      }
      expect(mockRepository.mockUpdateUserBook).toHaveBeenCalledWith(
        1,
        expect.objectContaining({
          note: "",
          noteUpdatedAt: expect.any(Date),
        }),
      );
    });

    it("should return BOOK_NOT_FOUND error when user book does not exist", async () => {
      const mockRepository = createMockRepository();
      const mockLogger = createMockLogger();

      mockRepository.mockFindUserBookById.mockResolvedValue(null);

      const service = createBookShelfService(mockRepository, mockLogger);

      const result = await service.updateReadingNote({
        userBookId: 999,
        userId: 100,
        note: "Some note",
      });

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("BOOK_NOT_FOUND");
      }
      expect(mockRepository.mockUpdateUserBook).not.toHaveBeenCalled();
    });

    it("should return FORBIDDEN error when user does not own the book", async () => {
      const mockRepository = createMockRepository();
      const mockLogger = createMockLogger();

      const existingUserBook: UserBook = {
        id: 1,
        userId: 200,
        externalId: "google-book-123",
        title: "Test Book",
        authors: ["Author One"],
        publisher: null,
        publishedDate: null,
        isbn: null,
        coverImageUrl: null,
        source: "rakuten",
        addedAt: new Date(),
        readingStatus: "backlog",
        completedAt: null,
        note: null,
        noteUpdatedAt: null,
        rating: null,
      };
      mockRepository.mockFindUserBookById.mockResolvedValue(existingUserBook);

      const service = createBookShelfService(mockRepository, mockLogger);

      const result = await service.updateReadingNote({
        userBookId: 1,
        userId: 100,
        note: "Some note",
      });

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("FORBIDDEN");
      }
      expect(mockRepository.mockUpdateUserBook).not.toHaveBeenCalled();
    });

    it("should return DATABASE_ERROR when repository throws", async () => {
      const mockRepository = createMockRepository();
      const mockLogger = createMockLogger();

      mockRepository.mockFindUserBookById.mockRejectedValue(
        new Error("Database connection failed"),
      );

      const service = createBookShelfService(mockRepository, mockLogger);

      const result = await service.updateReadingNote({
        userBookId: 1,
        userId: 100,
        note: "Some note",
      });

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("DATABASE_ERROR");
      }
    });
  });
});
