import { describe, expect, it, vi } from "vitest";
import type { NewUserBook, UserBook } from "../../../db/schema/books.js";
import { createBookShelfRepository } from "./book-shelf-repository.js";

function createMockDb() {
  const mockResults: unknown[] = [];

  const returningFn = vi
    .fn()
    .mockImplementation(() => Promise.resolve(mockResults));
  const whereFn = vi.fn().mockImplementation(() => {
    const chainAfterWhere = Promise.resolve(mockResults);
    (
      chainAfterWhere as unknown as { returning: typeof returningFn }
    ).returning = returningFn;
    return chainAfterWhere;
  });
  const setFn = vi
    .fn()
    .mockImplementation(() => ({ where: whereFn, returning: returningFn }));
  const updateFn = vi.fn().mockImplementation(() => ({ set: setFn }));

  const mockQuery = {
    select: vi.fn().mockReturnThis(),
    from: vi.fn().mockReturnThis(),
    where: whereFn,
    insert: vi.fn().mockReturnThis(),
    values: vi.fn().mockReturnThis(),
    returning: returningFn,
    update: updateFn,
    set: setFn,
  };

  return {
    query: mockQuery,
    setResults: (results: unknown[]) => {
      mockResults.length = 0;
      mockResults.push(...results);
    },
    clearMocks: () => {
      vi.clearAllMocks();
      mockResults.length = 0;
    },
  };
}

describe("BookShelfRepository", () => {
  describe("interface compliance", () => {
    it("should implement BookShelfRepository methods", () => {
      const mockDb = createMockDb();
      const repository = createBookShelfRepository(mockDb.query as never);

      expect(typeof repository.findUserBookByExternalId).toBe("function");
      expect(typeof repository.createUserBook).toBe("function");
      expect(typeof repository.getUserBooks).toBe("function");
      expect(typeof repository.countUserBooks).toBe("function");
    });
  });

  describe("countUserBooks", () => {
    it("should return count of user books", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([{ count: 5 }]);

      const repository = createBookShelfRepository(mockDb.query as never);
      const result = await repository.countUserBooks(100);

      expect(result).toBe(5);
    });

    it("should return 0 when user has no books", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([{ count: 0 }]);

      const repository = createBookShelfRepository(mockDb.query as never);
      const result = await repository.countUserBooks(100);

      expect(result).toBe(0);
    });
  });

  describe("findUserBookByExternalId", () => {
    it("should return user book when found by user ID and external ID", async () => {
      const mockDb = createMockDb();
      const mockUserBook: UserBook = {
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
        readingStatus: "backlog",
        completedAt: null,
        note: null,
        noteUpdatedAt: null,
        rating: null,
        source: "rakuten",
      };
      mockDb.setResults([mockUserBook]);

      const repository = createBookShelfRepository(mockDb.query as never);
      const result = await repository.findUserBookByExternalId(
        100,
        "google-book-123",
      );

      expect(result).toEqual(mockUserBook);
    });

    it("should return null when user book not found", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([]);

      const repository = createBookShelfRepository(mockDb.query as never);
      const result = await repository.findUserBookByExternalId(
        100,
        "non-existent-id",
      );

      expect(result).toBeNull();
    });
  });

  describe("createUserBook", () => {
    it("should create a new user book and return it", async () => {
      const mockDb = createMockDb();
      const newUserBook: NewUserBook = {
        userId: 100,
        externalId: "google-book-456",
        title: "New Book",
        authors: ["Author Two"],
        publisher: "Publisher Inc",
        publishedDate: "2024-06-15",
        isbn: "9789876543210",
        coverImageUrl: "https://example.com/new-cover.jpg",
      };
      const createdUserBook: UserBook = {
        id: 1,
        userId: newUserBook.userId,
        externalId: newUserBook.externalId,
        title: newUserBook.title,
        authors: newUserBook.authors ?? [],
        publisher: newUserBook.publisher ?? null,
        publishedDate: newUserBook.publishedDate ?? null,
        isbn: newUserBook.isbn ?? null,
        coverImageUrl: newUserBook.coverImageUrl ?? null,
        addedAt: new Date(),
        readingStatus: "backlog",
        completedAt: null,
        note: null,
        noteUpdatedAt: null,
        rating: null,
        source: "rakuten",
      };
      mockDb.setResults([createdUserBook]);

      const repository = createBookShelfRepository(mockDb.query as never);
      const result = await repository.createUserBook(newUserBook);

      expect(result).toEqual(createdUserBook);
      expect(mockDb.query.insert).toHaveBeenCalled();
    });
  });

  describe("getUserBooks", () => {
    it("should return all books for a user", async () => {
      const mockDb = createMockDb();
      const mockUserBooks: UserBook[] = [
        {
          id: 1,
          userId: 100,
          externalId: "book-1",
          title: "Book One",
          authors: ["Author A"],
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
        },
        {
          id: 2,
          userId: 100,
          externalId: "book-2",
          title: "Book Two",
          authors: ["Author B", "Author C"],
          publisher: "Publisher X",
          publishedDate: "2023-01-01",
          isbn: "9781111111111",
          coverImageUrl: "https://example.com/book2.jpg",
          addedAt: new Date(),
          readingStatus: "reading",
          completedAt: null,
          note: null,
          noteUpdatedAt: null,
          rating: null,
          source: "rakuten",
        },
      ];
      mockDb.setResults(mockUserBooks);

      const repository = createBookShelfRepository(mockDb.query as never);
      const result = await repository.getUserBooks(100);

      expect(result).toEqual(mockUserBooks);
      expect(result).toHaveLength(2);
    });

    it("should return empty array when user has no books", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([]);

      const repository = createBookShelfRepository(mockDb.query as never);
      const result = await repository.getUserBooks(100);

      expect(result).toEqual([]);
    });
  });

  describe("findUserBookById", () => {
    it("should return user book when found by ID", async () => {
      const mockDb = createMockDb();
      const mockUserBook: UserBook = {
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
        readingStatus: "backlog",
        completedAt: null,
        note: null,
        noteUpdatedAt: null,
        rating: null,
        source: "rakuten",
      };
      mockDb.setResults([mockUserBook]);

      const repository = createBookShelfRepository(mockDb.query as never);
      const result = await repository.findUserBookById(1);

      expect(result).toEqual(mockUserBook);
    });

    it("should return null when user book not found by ID", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([]);

      const repository = createBookShelfRepository(mockDb.query as never);
      const result = await repository.findUserBookById(999);

      expect(result).toBeNull();
    });
  });

  describe("updateUserBook", () => {
    it("should update reading status and return updated user book", async () => {
      const mockDb = createMockDb();
      const updatedUserBook: UserBook = {
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
        readingStatus: "completed",
        completedAt: new Date(),
        note: null,
        noteUpdatedAt: null,
        rating: null,
        source: "rakuten",
      };
      mockDb.setResults([updatedUserBook]);

      const repository = createBookShelfRepository(mockDb.query as never);
      const result = await repository.updateUserBook(1, {
        readingStatus: "completed",
        completedAt: updatedUserBook.completedAt,
      });

      expect(result).toEqual(updatedUserBook);
      expect(mockDb.query.update).toHaveBeenCalled();
    });

    it("should update note and noteUpdatedAt", async () => {
      const mockDb = createMockDb();
      const noteUpdatedAt = new Date();
      const updatedUserBook: UserBook = {
        id: 1,
        userId: 100,
        externalId: "google-book-123",
        title: "Test Book",
        authors: ["Author One"],
        publisher: null,
        publishedDate: null,
        isbn: null,
        coverImageUrl: null,
        addedAt: new Date(),
        readingStatus: "backlog",
        completedAt: null,
        note: "Great book!",
        noteUpdatedAt,
        rating: null,
        source: "rakuten",
      };
      mockDb.setResults([updatedUserBook]);

      const repository = createBookShelfRepository(mockDb.query as never);
      const result = await repository.updateUserBook(1, {
        note: "Great book!",
        noteUpdatedAt,
      });

      expect(result).toEqual(updatedUserBook);
      expect(result?.note).toBe("Great book!");
      expect(result?.noteUpdatedAt).toEqual(noteUpdatedAt);
    });

    it("should return null when user book to update not found", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([]);

      const repository = createBookShelfRepository(mockDb.query as never);
      const result = await repository.updateUserBook(999, {
        readingStatus: "reading",
      });

      expect(result).toBeNull();
    });
  });

  describe("getUserBooksWithPagination", () => {
    it("should be defined as a method on the repository", () => {
      const mockDb = createMockDb();
      const repository = createBookShelfRepository(mockDb.query as never);

      expect(typeof repository.getUserBooksWithPagination).toBe("function");
    });
  });

  describe("ShelfSortField type", () => {
    it("should accept COMPLETED_AT as a valid sort field", () => {
      const sortField: import("./book-shelf-repository.js").ShelfSortField =
        "COMPLETED_AT";
      expect(sortField).toBe("COMPLETED_AT");
    });

    it("should accept PUBLISHED_DATE as a valid sort field", () => {
      const sortField: import("./book-shelf-repository.js").ShelfSortField =
        "PUBLISHED_DATE";
      expect(sortField).toBe("PUBLISHED_DATE");
    });

    it("should accept existing sort fields", () => {
      const addedAt: import("./book-shelf-repository.js").ShelfSortField =
        "ADDED_AT";
      const title: import("./book-shelf-repository.js").ShelfSortField =
        "TITLE";
      const author: import("./book-shelf-repository.js").ShelfSortField =
        "AUTHOR";
      expect(addedAt).toBe("ADDED_AT");
      expect(title).toBe("TITLE");
      expect(author).toBe("AUTHOR");
    });
  });

  describe("types", () => {
    it("should use NewUserBook type for create input", () => {
      const newUserBook: NewUserBook = {
        userId: 100,
        externalId: "test-external-id",
        title: "Test Title",
        authors: [],
      };

      expect(newUserBook.userId).toBe(100);
      expect(newUserBook.externalId).toBe("test-external-id");
      expect(newUserBook.title).toBe("Test Title");
      expect((newUserBook as Record<string, unknown>).id).toBeUndefined();
    });

    it("should use UserBook type for output", () => {
      const userBook: UserBook = {
        id: 1,
        userId: 100,
        externalId: "test-external-id",
        title: "Test Title",
        authors: ["Author"],
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

      expect(userBook.id).toBeDefined();
      expect(userBook.userId).toBe(100);
      expect(userBook.externalId).toBe("test-external-id");
      expect(userBook.addedAt).toBeInstanceOf(Date);
    });
  });
});
