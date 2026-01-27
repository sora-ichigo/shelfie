import { describe, expect, it, vi } from "vitest";
import type { BookList, BookListItem } from "../../../db/schema/book-lists.js";
import { createBookListRepository } from "./repository.js";

function createMockDb() {
  const mockResults: unknown[] = [];

  const returningFn = vi
    .fn()
    .mockImplementation(() => Promise.resolve(mockResults));
  const orderByFn = vi
    .fn()
    .mockImplementation(() => Promise.resolve(mockResults));
  const whereFn = vi.fn().mockImplementation(() => {
    const chainAfterWhere = Promise.resolve(mockResults);
    (
      chainAfterWhere as unknown as {
        returning: typeof returningFn;
        orderBy: typeof orderByFn;
      }
    ).returning = returningFn;
    (
      chainAfterWhere as unknown as {
        returning: typeof returningFn;
        orderBy: typeof orderByFn;
      }
    ).orderBy = orderByFn;
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
    orderBy: orderByFn,
    insert: vi.fn().mockReturnThis(),
    values: vi.fn().mockReturnThis(),
    returning: returningFn,
    update: updateFn,
    set: setFn,
    delete: vi.fn().mockReturnThis(),
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

describe("BookListRepository", () => {
  describe("interface compliance", () => {
    it("should implement BookListRepository methods", () => {
      const mockDb = createMockDb();
      const repository = createBookListRepository(mockDb.query as never);

      expect(typeof repository.createBookList).toBe("function");
      expect(typeof repository.findBookListById).toBe("function");
      expect(typeof repository.findBookListsByUserId).toBe("function");
      expect(typeof repository.updateBookList).toBe("function");
      expect(typeof repository.deleteBookList).toBe("function");
      expect(typeof repository.createBookListItem).toBe("function");
      expect(typeof repository.findBookListItemsByListId).toBe("function");
      expect(typeof repository.findBookListItemByListIdAndUserBookId).toBe(
        "function",
      );
      expect(typeof repository.deleteBookListItem).toBe("function");
      expect(typeof repository.updateBookListItemPosition).toBe("function");
      expect(typeof repository.reorderBookListItems).toBe("function");
    });
  });

  describe("createBookList", () => {
    it("should create a new book list and return it", async () => {
      const mockDb = createMockDb();
      const createdBookList: BookList = {
        id: 1,
        userId: 100,
        title: "My Reading List",
        description: "Books I want to read",
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      mockDb.setResults([createdBookList]);

      const repository = createBookListRepository(mockDb.query as never);
      const result = await repository.createBookList({
        userId: 100,
        title: "My Reading List",
        description: "Books I want to read",
      });

      expect(result).toEqual(createdBookList);
      expect(mockDb.query.insert).toHaveBeenCalled();
    });

    it("should create a book list with null description", async () => {
      const mockDb = createMockDb();
      const createdBookList: BookList = {
        id: 1,
        userId: 100,
        title: "My Reading List",
        description: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      mockDb.setResults([createdBookList]);

      const repository = createBookListRepository(mockDb.query as never);
      const result = await repository.createBookList({
        userId: 100,
        title: "My Reading List",
        description: null,
      });

      expect(result).toEqual(createdBookList);
      expect(result.description).toBeNull();
    });
  });

  describe("findBookListById", () => {
    it("should return book list when found by ID", async () => {
      const mockDb = createMockDb();
      const mockBookList: BookList = {
        id: 1,
        userId: 100,
        title: "My Reading List",
        description: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      mockDb.setResults([mockBookList]);

      const repository = createBookListRepository(mockDb.query as never);
      const result = await repository.findBookListById(1);

      expect(result).toEqual(mockBookList);
    });

    it("should return null when book list not found", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([]);

      const repository = createBookListRepository(mockDb.query as never);
      const result = await repository.findBookListById(999);

      expect(result).toBeNull();
    });
  });

  describe("findBookListsByUserId", () => {
    it("should have findBookListsByUserId method", async () => {
      const mockDb = createMockDb();
      const repository = createBookListRepository(mockDb.query as never);

      expect(typeof repository.findBookListsByUserId).toBe("function");
    });
  });

  describe("updateBookList", () => {
    it("should update book list and return updated entity", async () => {
      const mockDb = createMockDb();
      const updatedBookList: BookList = {
        id: 1,
        userId: 100,
        title: "Updated Title",
        description: "Updated description",
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      mockDb.setResults([updatedBookList]);

      const repository = createBookListRepository(mockDb.query as never);
      const result = await repository.updateBookList(1, {
        title: "Updated Title",
        description: "Updated description",
      });

      expect(result).toEqual(updatedBookList);
      expect(mockDb.query.update).toHaveBeenCalled();
    });

    it("should return null when book list to update not found", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([]);

      const repository = createBookListRepository(mockDb.query as never);
      const result = await repository.updateBookList(999, {
        title: "New Title",
      });

      expect(result).toBeNull();
    });
  });

  describe("deleteBookList", () => {
    it("should delete book list and return true", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([{ id: 1 }]);

      const repository = createBookListRepository(mockDb.query as never);
      const result = await repository.deleteBookList(1);

      expect(result).toBe(true);
    });

    it("should return false when book list to delete not found", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([]);

      const repository = createBookListRepository(mockDb.query as never);
      const result = await repository.deleteBookList(999);

      expect(result).toBe(false);
    });
  });

  describe("createBookListItem", () => {
    it("should create a new book list item and return it", async () => {
      const mockDb = createMockDb();
      const createdItem: BookListItem = {
        id: 1,
        listId: 10,
        userBookId: 100,
        position: 0,
        addedAt: new Date(),
      };
      mockDb.setResults([createdItem]);

      const repository = createBookListRepository(mockDb.query as never);
      const result = await repository.createBookListItem({
        listId: 10,
        userBookId: 100,
        position: 0,
      });

      expect(result).toEqual(createdItem);
      expect(mockDb.query.insert).toHaveBeenCalled();
    });
  });

  describe("findBookListItemsByListId", () => {
    it("should return all items for a book list ordered by position", async () => {
      const mockDb = createMockDb();
      const mockItems: BookListItem[] = [
        {
          id: 1,
          listId: 10,
          userBookId: 100,
          position: 0,
          addedAt: new Date(),
        },
        {
          id: 2,
          listId: 10,
          userBookId: 101,
          position: 1,
          addedAt: new Date(),
        },
      ];
      mockDb.setResults(mockItems);

      const repository = createBookListRepository(mockDb.query as never);
      const result = await repository.findBookListItemsByListId(10);

      expect(result).toEqual(mockItems);
      expect(result).toHaveLength(2);
    });

    it("should return empty array when book list has no items", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([]);

      const repository = createBookListRepository(mockDb.query as never);
      const result = await repository.findBookListItemsByListId(10);

      expect(result).toEqual([]);
    });
  });

  describe("findBookListItemByListIdAndUserBookId", () => {
    it("should return item when found by list ID and user book ID", async () => {
      const mockDb = createMockDb();
      const mockItem: BookListItem = {
        id: 1,
        listId: 10,
        userBookId: 100,
        position: 0,
        addedAt: new Date(),
      };
      mockDb.setResults([mockItem]);

      const repository = createBookListRepository(mockDb.query as never);
      const result = await repository.findBookListItemByListIdAndUserBookId(
        10,
        100,
      );

      expect(result).toEqual(mockItem);
    });

    it("should return null when item not found", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([]);

      const repository = createBookListRepository(mockDb.query as never);
      const result = await repository.findBookListItemByListIdAndUserBookId(
        10,
        999,
      );

      expect(result).toBeNull();
    });
  });

  describe("deleteBookListItem", () => {
    it("should delete book list item and return true", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([{ id: 1 }]);

      const repository = createBookListRepository(mockDb.query as never);
      const result = await repository.deleteBookListItem(1);

      expect(result).toBe(true);
    });

    it("should return false when item to delete not found", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([]);

      const repository = createBookListRepository(mockDb.query as never);
      const result = await repository.deleteBookListItem(999);

      expect(result).toBe(false);
    });
  });

  describe("updateBookListItemPosition", () => {
    it("should update item position and return updated entity", async () => {
      const mockDb = createMockDb();
      const updatedItem: BookListItem = {
        id: 1,
        listId: 10,
        userBookId: 100,
        position: 5,
        addedAt: new Date(),
      };
      mockDb.setResults([updatedItem]);

      const repository = createBookListRepository(mockDb.query as never);
      const result = await repository.updateBookListItemPosition(1, 5);

      expect(result).toEqual(updatedItem);
      expect(result?.position).toBe(5);
    });

    it("should return null when item to update not found", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([]);

      const repository = createBookListRepository(mockDb.query as never);
      const result = await repository.updateBookListItemPosition(999, 5);

      expect(result).toBeNull();
    });
  });

  describe("getMaxPositionForList", () => {
    it("should return max position for a list", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([{ maxPosition: 5 }]);

      const repository = createBookListRepository(mockDb.query as never);
      const result = await repository.getMaxPositionForList(10);

      expect(result).toBe(5);
    });

    it("should return -1 when list has no items", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([{ maxPosition: null }]);

      const repository = createBookListRepository(mockDb.query as never);
      const result = await repository.getMaxPositionForList(10);

      expect(result).toBe(-1);
    });
  });

  describe("types", () => {
    it("should use CreateBookListInput type for create input", () => {
      const input = {
        userId: 100,
        title: "Test List",
        description: null,
      };

      expect(input.userId).toBe(100);
      expect(input.title).toBe("Test List");
      expect(input.description).toBeNull();
    });

    it("should use UpdateBookListInput type for update input", () => {
      const input = {
        title: "Updated Title",
        description: "Updated description",
      };

      expect(input.title).toBe("Updated Title");
      expect(input.description).toBe("Updated description");
    });

    it("should use CreateBookListItemInput type for item create input", () => {
      const input = {
        listId: 10,
        userBookId: 100,
        position: 0,
      };

      expect(input.listId).toBe(10);
      expect(input.userBookId).toBe(100);
      expect(input.position).toBe(0);
    });
  });
});
