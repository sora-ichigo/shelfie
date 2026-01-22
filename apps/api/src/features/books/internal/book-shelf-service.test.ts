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
} {
  const mockFindUserBookByExternalId = vi.fn();
  const mockCreateUserBook = vi.fn();
  const mockGetUserBooks = vi.fn();

  return {
    findUserBookByExternalId: mockFindUserBookByExternalId,
    createUserBook: mockCreateUserBook,
    getUserBooks: mockGetUserBooks,
    mockFindUserBookByExternalId,
    mockCreateUserBook,
    mockGetUserBooks,
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
        addedAt: new Date(),
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
        addedAt: new Date(),
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
        addedAt: new Date(),
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

  describe("interface compliance", () => {
    it("should implement BookShelfService methods", () => {
      const mockRepository = createMockRepository();
      const mockLogger = createMockLogger();
      const service = createBookShelfService(mockRepository, mockLogger);

      expect(typeof service.addBookToShelf).toBe("function");
    });
  });
});
