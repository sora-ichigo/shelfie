import { describe, expect, it, vi } from "vitest";
import type { BookList, BookListItem } from "../../../db/schema/book-lists.js";
import type { UserBook } from "../../../db/schema/books.js";
import type { BookListRepository } from "./repository.js";
import {
  type CreateBookListServiceInput,
  type UpdateBookListServiceInput,
  createBookListService,
} from "./service.js";

function createMockRepository(): BookListRepository & {
  mockCreateBookList: ReturnType<typeof vi.fn>;
  mockFindBookListById: ReturnType<typeof vi.fn>;
  mockFindBookListsByUserId: ReturnType<typeof vi.fn>;
  mockUpdateBookList: ReturnType<typeof vi.fn>;
  mockDeleteBookList: ReturnType<typeof vi.fn>;
  mockCreateBookListItem: ReturnType<typeof vi.fn>;
  mockFindBookListItemsByListId: ReturnType<typeof vi.fn>;
  mockFindBookListItemByListIdAndUserBookId: ReturnType<typeof vi.fn>;
  mockDeleteBookListItem: ReturnType<typeof vi.fn>;
  mockUpdateBookListItemPosition: ReturnType<typeof vi.fn>;
  mockReorderBookListItems: ReturnType<typeof vi.fn>;
  mockGetMaxPositionForList: ReturnType<typeof vi.fn>;
} {
  const mockCreateBookList = vi.fn();
  const mockFindBookListById = vi.fn();
  const mockFindBookListsByUserId = vi.fn();
  const mockUpdateBookList = vi.fn();
  const mockDeleteBookList = vi.fn();
  const mockCreateBookListItem = vi.fn();
  const mockFindBookListItemsByListId = vi.fn();
  const mockFindBookListItemByListIdAndUserBookId = vi.fn();
  const mockDeleteBookListItem = vi.fn();
  const mockUpdateBookListItemPosition = vi.fn();
  const mockReorderBookListItems = vi.fn();
  const mockGetMaxPositionForList = vi.fn();

  return {
    createBookList: mockCreateBookList,
    findBookListById: mockFindBookListById,
    findBookListsByUserId: mockFindBookListsByUserId,
    updateBookList: mockUpdateBookList,
    deleteBookList: mockDeleteBookList,
    createBookListItem: mockCreateBookListItem,
    findBookListItemsByListId: mockFindBookListItemsByListId,
    findBookListItemByListIdAndUserBookId: mockFindBookListItemByListIdAndUserBookId,
    deleteBookListItem: mockDeleteBookListItem,
    updateBookListItemPosition: mockUpdateBookListItemPosition,
    reorderBookListItems: mockReorderBookListItems,
    getMaxPositionForList: mockGetMaxPositionForList,
    mockCreateBookList,
    mockFindBookListById,
    mockFindBookListsByUserId,
    mockUpdateBookList,
    mockDeleteBookList,
    mockCreateBookListItem,
    mockFindBookListItemsByListId,
    mockFindBookListItemByListIdAndUserBookId,
    mockDeleteBookListItem,
    mockUpdateBookListItemPosition,
    mockReorderBookListItems,
    mockGetMaxPositionForList,
  };
}

interface MockBookShelfRepository {
  findUserBookById: ReturnType<typeof vi.fn>;
  mockFindUserBookById: ReturnType<typeof vi.fn>;
}

function createMockBookShelfRepository(): MockBookShelfRepository {
  const mockFindUserBookById = vi.fn();
  return {
    findUserBookById: mockFindUserBookById,
    mockFindUserBookById,
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

describe("BookListService", () => {
  describe("interface compliance", () => {
    it("should implement BookListService methods", () => {
      const mockRepository = createMockRepository();
      const mockBookShelfRepository = createMockBookShelfRepository();
      const mockLogger = createMockLogger();
      const service = createBookListService(
        mockRepository,
        mockBookShelfRepository,
        mockLogger,
      );

      expect(typeof service.createBookList).toBe("function");
      expect(typeof service.getBookList).toBe("function");
      expect(typeof service.getUserBookLists).toBe("function");
      expect(typeof service.updateBookList).toBe("function");
      expect(typeof service.deleteBookList).toBe("function");
      expect(typeof service.addBookToList).toBe("function");
      expect(typeof service.removeBookFromList).toBe("function");
      expect(typeof service.reorderBookInList).toBe("function");
    });
  });

  describe("createBookList", () => {
    it("should create a book list successfully", async () => {
      const mockRepository = createMockRepository();
      const mockBookShelfRepository = createMockBookShelfRepository();
      const mockLogger = createMockLogger();

      const createdBookList: BookList = {
        id: 1,
        userId: 100,
        title: "My Reading List",
        description: "Books I want to read",
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      mockRepository.mockCreateBookList.mockResolvedValue(createdBookList);

      const service = createBookListService(
        mockRepository,
        mockBookShelfRepository,
        mockLogger,
      );

      const input: CreateBookListServiceInput = {
        userId: 100,
        title: "My Reading List",
        description: "Books I want to read",
      };

      const result = await service.createBookList(input);

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data).toEqual(createdBookList);
      }
      expect(mockRepository.mockCreateBookList).toHaveBeenCalledWith({
        userId: 100,
        title: "My Reading List",
        description: "Books I want to read",
      });
      expect(mockLogger.info).toHaveBeenCalledWith(
        "Book list created successfully",
        expect.objectContaining({
          feature: "book-lists",
          userId: "100",
          listId: 1,
        }),
      );
    });

    it("should create a book list with null description", async () => {
      const mockRepository = createMockRepository();
      const mockBookShelfRepository = createMockBookShelfRepository();
      const mockLogger = createMockLogger();

      const createdBookList: BookList = {
        id: 1,
        userId: 100,
        title: "My Reading List",
        description: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      mockRepository.mockCreateBookList.mockResolvedValue(createdBookList);

      const service = createBookListService(
        mockRepository,
        mockBookShelfRepository,
        mockLogger,
      );

      const input: CreateBookListServiceInput = {
        userId: 100,
        title: "My Reading List",
      };

      const result = await service.createBookList(input);

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.description).toBeNull();
      }
    });

    it("should return VALIDATION_ERROR when title is empty", async () => {
      const mockRepository = createMockRepository();
      const mockBookShelfRepository = createMockBookShelfRepository();
      const mockLogger = createMockLogger();

      const service = createBookListService(
        mockRepository,
        mockBookShelfRepository,
        mockLogger,
      );

      const input: CreateBookListServiceInput = {
        userId: 100,
        title: "",
      };

      const result = await service.createBookList(input);

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("VALIDATION_ERROR");
        expect(result.error.message).toContain("Title is required");
      }
      expect(mockRepository.mockCreateBookList).not.toHaveBeenCalled();
    });

    it("should return VALIDATION_ERROR when title is whitespace only", async () => {
      const mockRepository = createMockRepository();
      const mockBookShelfRepository = createMockBookShelfRepository();
      const mockLogger = createMockLogger();

      const service = createBookListService(
        mockRepository,
        mockBookShelfRepository,
        mockLogger,
      );

      const input: CreateBookListServiceInput = {
        userId: 100,
        title: "   ",
      };

      const result = await service.createBookList(input);

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("VALIDATION_ERROR");
      }
      expect(mockRepository.mockCreateBookList).not.toHaveBeenCalled();
    });

    it("should return DATABASE_ERROR when repository throws", async () => {
      const mockRepository = createMockRepository();
      const mockBookShelfRepository = createMockBookShelfRepository();
      const mockLogger = createMockLogger();

      mockRepository.mockCreateBookList.mockRejectedValue(
        new Error("Database connection failed"),
      );

      const service = createBookListService(
        mockRepository,
        mockBookShelfRepository,
        mockLogger,
      );

      const input: CreateBookListServiceInput = {
        userId: 100,
        title: "My Reading List",
      };

      const result = await service.createBookList(input);

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("DATABASE_ERROR");
      }
      expect(mockLogger.error).toHaveBeenCalledWith(
        "Database error while creating book list",
        expect.any(Error),
        expect.objectContaining({
          feature: "book-lists",
          userId: "100",
        }),
      );
    });
  });

  describe("getBookList", () => {
    it("should return book list with items when found", async () => {
      const mockRepository = createMockRepository();
      const mockBookShelfRepository = createMockBookShelfRepository();
      const mockLogger = createMockLogger();

      const bookList: BookList = {
        id: 1,
        userId: 100,
        title: "My Reading List",
        description: "Books to read",
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      mockRepository.mockFindBookListById.mockResolvedValue(bookList);

      const items: BookListItem[] = [
        {
          id: 1,
          listId: 1,
          userBookId: 10,
          position: 0,
          addedAt: new Date(),
        },
        {
          id: 2,
          listId: 1,
          userBookId: 11,
          position: 1,
          addedAt: new Date(),
        },
      ];
      mockRepository.mockFindBookListItemsByListId.mockResolvedValue(items);

      const service = createBookListService(
        mockRepository,
        mockBookShelfRepository,
        mockLogger,
      );

      const result = await service.getBookList(1, 100);

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.id).toBe(1);
        expect(result.data.title).toBe("My Reading List");
        expect(result.data.items).toHaveLength(2);
      }
    });

    it("should return LIST_NOT_FOUND error when list does not exist", async () => {
      const mockRepository = createMockRepository();
      const mockBookShelfRepository = createMockBookShelfRepository();
      const mockLogger = createMockLogger();

      mockRepository.mockFindBookListById.mockResolvedValue(null);

      const service = createBookListService(
        mockRepository,
        mockBookShelfRepository,
        mockLogger,
      );

      const result = await service.getBookList(999, 100);

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("LIST_NOT_FOUND");
      }
    });

    it("should return FORBIDDEN error when user does not own the list", async () => {
      const mockRepository = createMockRepository();
      const mockBookShelfRepository = createMockBookShelfRepository();
      const mockLogger = createMockLogger();

      const bookList: BookList = {
        id: 1,
        userId: 200,
        title: "My Reading List",
        description: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      mockRepository.mockFindBookListById.mockResolvedValue(bookList);

      const service = createBookListService(
        mockRepository,
        mockBookShelfRepository,
        mockLogger,
      );

      const result = await service.getBookList(1, 100);

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("FORBIDDEN");
      }
      expect(mockLogger.warn).toHaveBeenCalledWith(
        "Unauthorized book list access attempt",
        expect.objectContaining({
          feature: "book-lists",
          listId: "1",
          ownerId: "200",
          requesterId: "100",
        }),
      );
    });
  });

  describe("getUserBookLists", () => {
    it("should return all user book lists with summary info", async () => {
      const mockRepository = createMockRepository();
      const mockBookShelfRepository = createMockBookShelfRepository();
      const mockLogger = createMockLogger();

      const bookLists: BookList[] = [
        {
          id: 1,
          userId: 100,
          title: "Reading List 1",
          description: null,
          createdAt: new Date(),
          updatedAt: new Date(),
        },
        {
          id: 2,
          userId: 100,
          title: "Reading List 2",
          description: "Description",
          createdAt: new Date(),
          updatedAt: new Date(),
        },
      ];
      mockRepository.mockFindBookListsByUserId.mockResolvedValue(bookLists);

      const items1: BookListItem[] = [
        { id: 1, listId: 1, userBookId: 10, position: 0, addedAt: new Date() },
        { id: 2, listId: 1, userBookId: 11, position: 1, addedAt: new Date() },
      ];
      const items2: BookListItem[] = [];

      mockRepository.mockFindBookListItemsByListId
        .mockResolvedValueOnce(items1)
        .mockResolvedValueOnce(items2);

      const userBook1: UserBook = {
        id: 10,
        userId: 100,
        externalId: "book-1",
        title: "Book 1",
        authors: [],
        publisher: null,
        publishedDate: null,
        isbn: null,
        coverImageUrl: "https://example.com/cover1.jpg",
        source: "rakuten",
        addedAt: new Date(),
        readingStatus: "backlog",
        completedAt: null,
        note: null,
        noteUpdatedAt: null,
        rating: null,
      };
      const userBook2: UserBook = {
        id: 11,
        userId: 100,
        externalId: "book-2",
        title: "Book 2",
        authors: [],
        publisher: null,
        publishedDate: null,
        isbn: null,
        coverImageUrl: "https://example.com/cover2.jpg",
        source: "rakuten",
        addedAt: new Date(),
        readingStatus: "backlog",
        completedAt: null,
        note: null,
        noteUpdatedAt: null,
        rating: null,
      };

      mockBookShelfRepository.mockFindUserBookById
        .mockResolvedValueOnce(userBook1)
        .mockResolvedValueOnce(userBook2);

      const service = createBookListService(
        mockRepository,
        mockBookShelfRepository,
        mockLogger,
      );

      const result = await service.getUserBookLists(100);

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data).toHaveLength(2);
        expect(result.data[0].bookCount).toBe(2);
        expect(result.data[0].coverImages).toHaveLength(2);
        expect(result.data[1].bookCount).toBe(0);
        expect(result.data[1].coverImages).toHaveLength(0);
      }
    });

    it("should return empty array when user has no lists", async () => {
      const mockRepository = createMockRepository();
      const mockBookShelfRepository = createMockBookShelfRepository();
      const mockLogger = createMockLogger();

      mockRepository.mockFindBookListsByUserId.mockResolvedValue([]);

      const service = createBookListService(
        mockRepository,
        mockBookShelfRepository,
        mockLogger,
      );

      const result = await service.getUserBookLists(100);

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data).toEqual([]);
      }
    });
  });

  describe("updateBookList", () => {
    it("should update book list successfully", async () => {
      const mockRepository = createMockRepository();
      const mockBookShelfRepository = createMockBookShelfRepository();
      const mockLogger = createMockLogger();

      const existingBookList: BookList = {
        id: 1,
        userId: 100,
        title: "Old Title",
        description: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      mockRepository.mockFindBookListById.mockResolvedValue(existingBookList);

      const updatedBookList: BookList = {
        ...existingBookList,
        title: "New Title",
        description: "New description",
        updatedAt: new Date(),
      };
      mockRepository.mockUpdateBookList.mockResolvedValue(updatedBookList);

      const service = createBookListService(
        mockRepository,
        mockBookShelfRepository,
        mockLogger,
      );

      const input: UpdateBookListServiceInput = {
        listId: 1,
        userId: 100,
        title: "New Title",
        description: "New description",
      };

      const result = await service.updateBookList(input);

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.title).toBe("New Title");
        expect(result.data.description).toBe("New description");
      }
    });

    it("should return LIST_NOT_FOUND error when list does not exist", async () => {
      const mockRepository = createMockRepository();
      const mockBookShelfRepository = createMockBookShelfRepository();
      const mockLogger = createMockLogger();

      mockRepository.mockFindBookListById.mockResolvedValue(null);

      const service = createBookListService(
        mockRepository,
        mockBookShelfRepository,
        mockLogger,
      );

      const input: UpdateBookListServiceInput = {
        listId: 999,
        userId: 100,
        title: "New Title",
      };

      const result = await service.updateBookList(input);

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("LIST_NOT_FOUND");
      }
    });

    it("should return FORBIDDEN error when user does not own the list", async () => {
      const mockRepository = createMockRepository();
      const mockBookShelfRepository = createMockBookShelfRepository();
      const mockLogger = createMockLogger();

      const existingBookList: BookList = {
        id: 1,
        userId: 200,
        title: "Old Title",
        description: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      mockRepository.mockFindBookListById.mockResolvedValue(existingBookList);

      const service = createBookListService(
        mockRepository,
        mockBookShelfRepository,
        mockLogger,
      );

      const input: UpdateBookListServiceInput = {
        listId: 1,
        userId: 100,
        title: "New Title",
      };

      const result = await service.updateBookList(input);

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("FORBIDDEN");
      }
    });

    it("should return VALIDATION_ERROR when title is empty", async () => {
      const mockRepository = createMockRepository();
      const mockBookShelfRepository = createMockBookShelfRepository();
      const mockLogger = createMockLogger();

      const existingBookList: BookList = {
        id: 1,
        userId: 100,
        title: "Old Title",
        description: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      mockRepository.mockFindBookListById.mockResolvedValue(existingBookList);

      const service = createBookListService(
        mockRepository,
        mockBookShelfRepository,
        mockLogger,
      );

      const input: UpdateBookListServiceInput = {
        listId: 1,
        userId: 100,
        title: "",
      };

      const result = await service.updateBookList(input);

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("VALIDATION_ERROR");
      }
      expect(mockRepository.mockUpdateBookList).not.toHaveBeenCalled();
    });
  });

  describe("deleteBookList", () => {
    it("should delete book list successfully", async () => {
      const mockRepository = createMockRepository();
      const mockBookShelfRepository = createMockBookShelfRepository();
      const mockLogger = createMockLogger();

      const existingBookList: BookList = {
        id: 1,
        userId: 100,
        title: "My Reading List",
        description: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      mockRepository.mockFindBookListById.mockResolvedValue(existingBookList);
      mockRepository.mockDeleteBookList.mockResolvedValue(true);

      const service = createBookListService(
        mockRepository,
        mockBookShelfRepository,
        mockLogger,
      );

      const result = await service.deleteBookList(1, 100);

      expect(result.success).toBe(true);
      expect(mockRepository.mockDeleteBookList).toHaveBeenCalledWith(1);
      expect(mockLogger.info).toHaveBeenCalledWith(
        "Book list deleted successfully",
        expect.objectContaining({
          feature: "book-lists",
          listId: "1",
          userId: "100",
        }),
      );
    });

    it("should return LIST_NOT_FOUND error when list does not exist", async () => {
      const mockRepository = createMockRepository();
      const mockBookShelfRepository = createMockBookShelfRepository();
      const mockLogger = createMockLogger();

      mockRepository.mockFindBookListById.mockResolvedValue(null);

      const service = createBookListService(
        mockRepository,
        mockBookShelfRepository,
        mockLogger,
      );

      const result = await service.deleteBookList(999, 100);

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("LIST_NOT_FOUND");
      }
      expect(mockRepository.mockDeleteBookList).not.toHaveBeenCalled();
    });

    it("should return FORBIDDEN error when user does not own the list", async () => {
      const mockRepository = createMockRepository();
      const mockBookShelfRepository = createMockBookShelfRepository();
      const mockLogger = createMockLogger();

      const existingBookList: BookList = {
        id: 1,
        userId: 200,
        title: "My Reading List",
        description: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      mockRepository.mockFindBookListById.mockResolvedValue(existingBookList);

      const service = createBookListService(
        mockRepository,
        mockBookShelfRepository,
        mockLogger,
      );

      const result = await service.deleteBookList(1, 100);

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("FORBIDDEN");
      }
      expect(mockRepository.mockDeleteBookList).not.toHaveBeenCalled();
    });
  });

  describe("addBookToList", () => {
    it("should add book to list successfully", async () => {
      const mockRepository = createMockRepository();
      const mockBookShelfRepository = createMockBookShelfRepository();
      const mockLogger = createMockLogger();

      const bookList: BookList = {
        id: 1,
        userId: 100,
        title: "My Reading List",
        description: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      mockRepository.mockFindBookListById.mockResolvedValue(bookList);

      const userBook: UserBook = {
        id: 10,
        userId: 100,
        externalId: "book-1",
        title: "Book 1",
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
      mockBookShelfRepository.mockFindUserBookById.mockResolvedValue(userBook);

      mockRepository.mockFindBookListItemByListIdAndUserBookId.mockResolvedValue(
        null,
      );
      mockRepository.mockGetMaxPositionForList.mockResolvedValue(1);

      const createdItem: BookListItem = {
        id: 1,
        listId: 1,
        userBookId: 10,
        position: 2,
        addedAt: new Date(),
      };
      mockRepository.mockCreateBookListItem.mockResolvedValue(createdItem);

      const service = createBookListService(
        mockRepository,
        mockBookShelfRepository,
        mockLogger,
      );

      const result = await service.addBookToList({
        listId: 1,
        userId: 100,
        userBookId: 10,
      });

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.userBookId).toBe(10);
        expect(result.data.position).toBe(2);
      }
      expect(mockRepository.mockCreateBookListItem).toHaveBeenCalledWith({
        listId: 1,
        userBookId: 10,
        position: 2,
      });
    });

    it("should return DUPLICATE_BOOK error when book already in list", async () => {
      const mockRepository = createMockRepository();
      const mockBookShelfRepository = createMockBookShelfRepository();
      const mockLogger = createMockLogger();

      const bookList: BookList = {
        id: 1,
        userId: 100,
        title: "My Reading List",
        description: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      mockRepository.mockFindBookListById.mockResolvedValue(bookList);

      const userBook: UserBook = {
        id: 10,
        userId: 100,
        externalId: "book-1",
        title: "Book 1",
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
      mockBookShelfRepository.mockFindUserBookById.mockResolvedValue(userBook);

      const existingItem: BookListItem = {
        id: 1,
        listId: 1,
        userBookId: 10,
        position: 0,
        addedAt: new Date(),
      };
      mockRepository.mockFindBookListItemByListIdAndUserBookId.mockResolvedValue(
        existingItem,
      );

      const service = createBookListService(
        mockRepository,
        mockBookShelfRepository,
        mockLogger,
      );

      const result = await service.addBookToList({
        listId: 1,
        userId: 100,
        userBookId: 10,
      });

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("DUPLICATE_BOOK");
      }
      expect(mockRepository.mockCreateBookListItem).not.toHaveBeenCalled();
    });

    it("should return LIST_NOT_FOUND error when list does not exist", async () => {
      const mockRepository = createMockRepository();
      const mockBookShelfRepository = createMockBookShelfRepository();
      const mockLogger = createMockLogger();

      mockRepository.mockFindBookListById.mockResolvedValue(null);

      const service = createBookListService(
        mockRepository,
        mockBookShelfRepository,
        mockLogger,
      );

      const result = await service.addBookToList({
        listId: 999,
        userId: 100,
        userBookId: 10,
      });

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("LIST_NOT_FOUND");
      }
    });

    it("should return FORBIDDEN error when user does not own the list", async () => {
      const mockRepository = createMockRepository();
      const mockBookShelfRepository = createMockBookShelfRepository();
      const mockLogger = createMockLogger();

      const bookList: BookList = {
        id: 1,
        userId: 200,
        title: "My Reading List",
        description: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      mockRepository.mockFindBookListById.mockResolvedValue(bookList);

      const service = createBookListService(
        mockRepository,
        mockBookShelfRepository,
        mockLogger,
      );

      const result = await service.addBookToList({
        listId: 1,
        userId: 100,
        userBookId: 10,
      });

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("FORBIDDEN");
      }
    });
  });

  describe("removeBookFromList", () => {
    it("should remove book from list successfully", async () => {
      const mockRepository = createMockRepository();
      const mockBookShelfRepository = createMockBookShelfRepository();
      const mockLogger = createMockLogger();

      const bookList: BookList = {
        id: 1,
        userId: 100,
        title: "My Reading List",
        description: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      mockRepository.mockFindBookListById.mockResolvedValue(bookList);

      const existingItem: BookListItem = {
        id: 1,
        listId: 1,
        userBookId: 10,
        position: 0,
        addedAt: new Date(),
      };
      mockRepository.mockFindBookListItemByListIdAndUserBookId.mockResolvedValue(
        existingItem,
      );
      mockRepository.mockDeleteBookListItem.mockResolvedValue(true);

      const service = createBookListService(
        mockRepository,
        mockBookShelfRepository,
        mockLogger,
      );

      const result = await service.removeBookFromList({
        listId: 1,
        userId: 100,
        userBookId: 10,
      });

      expect(result.success).toBe(true);
      expect(mockRepository.mockDeleteBookListItem).toHaveBeenCalledWith(1);
    });

    it("should return BOOK_NOT_IN_LIST error when book not in list", async () => {
      const mockRepository = createMockRepository();
      const mockBookShelfRepository = createMockBookShelfRepository();
      const mockLogger = createMockLogger();

      const bookList: BookList = {
        id: 1,
        userId: 100,
        title: "My Reading List",
        description: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      mockRepository.mockFindBookListById.mockResolvedValue(bookList);

      mockRepository.mockFindBookListItemByListIdAndUserBookId.mockResolvedValue(
        null,
      );

      const service = createBookListService(
        mockRepository,
        mockBookShelfRepository,
        mockLogger,
      );

      const result = await service.removeBookFromList({
        listId: 1,
        userId: 100,
        userBookId: 10,
      });

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("BOOK_NOT_IN_LIST");
      }
      expect(mockRepository.mockDeleteBookListItem).not.toHaveBeenCalled();
    });
  });

  describe("reorderBookInList", () => {
    it("should reorder book in list successfully", async () => {
      const mockRepository = createMockRepository();
      const mockBookShelfRepository = createMockBookShelfRepository();
      const mockLogger = createMockLogger();

      const bookList: BookList = {
        id: 1,
        userId: 100,
        title: "My Reading List",
        description: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      mockRepository.mockFindBookListById.mockResolvedValue(bookList);

      mockRepository.mockReorderBookListItems.mockResolvedValue(undefined);

      const service = createBookListService(
        mockRepository,
        mockBookShelfRepository,
        mockLogger,
      );

      const result = await service.reorderBookInList({
        listId: 1,
        userId: 100,
        itemId: 5,
        newPosition: 2,
      });

      expect(result.success).toBe(true);
      expect(mockRepository.mockReorderBookListItems).toHaveBeenCalledWith(
        1,
        5,
        2,
      );
    });

    it("should return LIST_NOT_FOUND error when list does not exist", async () => {
      const mockRepository = createMockRepository();
      const mockBookShelfRepository = createMockBookShelfRepository();
      const mockLogger = createMockLogger();

      mockRepository.mockFindBookListById.mockResolvedValue(null);

      const service = createBookListService(
        mockRepository,
        mockBookShelfRepository,
        mockLogger,
      );

      const result = await service.reorderBookInList({
        listId: 999,
        userId: 100,
        itemId: 5,
        newPosition: 2,
      });

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("LIST_NOT_FOUND");
      }
    });

    it("should return FORBIDDEN error when user does not own the list", async () => {
      const mockRepository = createMockRepository();
      const mockBookShelfRepository = createMockBookShelfRepository();
      const mockLogger = createMockLogger();

      const bookList: BookList = {
        id: 1,
        userId: 200,
        title: "My Reading List",
        description: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      mockRepository.mockFindBookListById.mockResolvedValue(bookList);

      const service = createBookListService(
        mockRepository,
        mockBookShelfRepository,
        mockLogger,
      );

      const result = await service.reorderBookInList({
        listId: 1,
        userId: 100,
        itemId: 5,
        newPosition: 2,
      });

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("FORBIDDEN");
      }
      expect(mockRepository.mockReorderBookListItems).not.toHaveBeenCalled();
    });
  });
});
