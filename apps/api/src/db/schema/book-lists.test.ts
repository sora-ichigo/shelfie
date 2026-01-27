import { getTableName } from "drizzle-orm";
import { describe, expect, it } from "vitest";
import {
  BOOK_LIST_ITEMS_LIST_ID_INDEX_NAME,
  BOOK_LIST_ITEMS_UNIQUE_NAME,
  BOOK_LIST_ITEMS_USER_BOOK_ID_INDEX_NAME,
  BOOK_LISTS_USER_ID_INDEX_NAME,
  type BookList,
  type BookListItem,
  bookListItems,
  bookLists,
} from "./book-lists.js";

describe("BookList Schema", () => {
  describe("bookLists table", () => {
    it("should have correct table name", () => {
      expect(getTableName(bookLists)).toBe("book_lists");
    });

    it("should have id column as primary key with identity", () => {
      const idColumn = bookLists.id;
      expect(idColumn.name).toBe("id");
      expect(idColumn.primary).toBe(true);
    });

    it("should have userId column as not null integer", () => {
      const userIdColumn = bookLists.userId;
      expect(userIdColumn.name).toBe("user_id");
      expect(userIdColumn.notNull).toBe(true);
    });

    it("should have title column as not null text", () => {
      const titleColumn = bookLists.title;
      expect(titleColumn.name).toBe("title");
      expect(titleColumn.notNull).toBe(true);
    });

    it("should have description column as nullable text", () => {
      const descriptionColumn = bookLists.description;
      expect(descriptionColumn.name).toBe("description");
      expect(descriptionColumn.notNull).toBe(false);
    });

    it("should have createdAt column with default now", () => {
      const createdAtColumn = bookLists.createdAt;
      expect(createdAtColumn.name).toBe("created_at");
      expect(createdAtColumn.notNull).toBe(true);
      expect(createdAtColumn.hasDefault).toBe(true);
    });

    it("should have updatedAt column with default now", () => {
      const updatedAtColumn = bookLists.updatedAt;
      expect(updatedAtColumn.name).toBe("updated_at");
      expect(updatedAtColumn.notNull).toBe(true);
      expect(updatedAtColumn.hasDefault).toBe(true);
    });

    it("should export index name constant for userId", () => {
      expect(BOOK_LISTS_USER_ID_INDEX_NAME).toBe("idx_book_lists_user_id");
    });
  });

  describe("BookList type", () => {
    it("should have correct type shape", () => {
      const bookList: BookList = {
        id: 1,
        userId: 100,
        title: "My Reading List",
        description: "A collection of books I want to read",
        createdAt: new Date(),
        updatedAt: new Date(),
      };

      expect(bookList.id).toBe(1);
      expect(bookList.userId).toBe(100);
      expect(bookList.title).toBe("My Reading List");
      expect(bookList.description).toBe("A collection of books I want to read");
      expect(bookList.createdAt).toBeInstanceOf(Date);
      expect(bookList.updatedAt).toBeInstanceOf(Date);
    });

    it("should allow null description", () => {
      const bookList: BookList = {
        id: 1,
        userId: 100,
        title: "My Reading List",
        description: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      };

      expect(bookList.description).toBeNull();
    });
  });
});

describe("BookListItem Schema", () => {
  describe("bookListItems table", () => {
    it("should have correct table name", () => {
      expect(getTableName(bookListItems)).toBe("book_list_items");
    });

    it("should have id column as primary key with identity", () => {
      const idColumn = bookListItems.id;
      expect(idColumn.name).toBe("id");
      expect(idColumn.primary).toBe(true);
    });

    it("should have listId column as not null integer", () => {
      const listIdColumn = bookListItems.listId;
      expect(listIdColumn.name).toBe("list_id");
      expect(listIdColumn.notNull).toBe(true);
    });

    it("should have userBookId column as not null integer", () => {
      const userBookIdColumn = bookListItems.userBookId;
      expect(userBookIdColumn.name).toBe("user_book_id");
      expect(userBookIdColumn.notNull).toBe(true);
    });

    it("should have position column as not null with default 0", () => {
      const positionColumn = bookListItems.position;
      expect(positionColumn.name).toBe("position");
      expect(positionColumn.notNull).toBe(true);
      expect(positionColumn.hasDefault).toBe(true);
    });

    it("should have addedAt column with default now", () => {
      const addedAtColumn = bookListItems.addedAt;
      expect(addedAtColumn.name).toBe("added_at");
      expect(addedAtColumn.notNull).toBe(true);
      expect(addedAtColumn.hasDefault).toBe(true);
    });

    it("should export index name constants", () => {
      expect(BOOK_LIST_ITEMS_LIST_ID_INDEX_NAME).toBe(
        "idx_book_list_items_list_id",
      );
      expect(BOOK_LIST_ITEMS_USER_BOOK_ID_INDEX_NAME).toBe(
        "idx_book_list_items_user_book_id",
      );
    });

    it("should export unique constraint name for listId and userBookId", () => {
      expect(BOOK_LIST_ITEMS_UNIQUE_NAME).toBe(
        "book_list_items_list_id_user_book_id_unique",
      );
    });
  });

  describe("BookListItem type", () => {
    it("should have correct type shape", () => {
      const bookListItem: BookListItem = {
        id: 1,
        listId: 10,
        userBookId: 100,
        position: 0,
        addedAt: new Date(),
      };

      expect(bookListItem.id).toBe(1);
      expect(bookListItem.listId).toBe(10);
      expect(bookListItem.userBookId).toBe(100);
      expect(bookListItem.position).toBe(0);
      expect(bookListItem.addedAt).toBeInstanceOf(Date);
    });
  });
});
