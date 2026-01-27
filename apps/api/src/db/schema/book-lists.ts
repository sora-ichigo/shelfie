import {
  index,
  integer,
  pgTable,
  text,
  timestamp,
  unique,
} from "drizzle-orm/pg-core";
import { userBooks } from "./books";
import { users } from "./users";

export const BOOK_LISTS_USER_ID_INDEX_NAME = "idx_book_lists_user_id";

export const bookLists = pgTable(
  "book_lists",
  {
    id: integer("id").primaryKey().generatedAlwaysAsIdentity(),
    userId: integer("user_id")
      .notNull()
      .references(() => users.id, { onDelete: "cascade" }),
    title: text("title").notNull(),
    description: text("description"),
    createdAt: timestamp("created_at", { withTimezone: true })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp("updated_at", { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (table) => [index(BOOK_LISTS_USER_ID_INDEX_NAME).on(table.userId)],
);

export type BookList = typeof bookLists.$inferSelect;
export type NewBookList = typeof bookLists.$inferInsert;

export const BOOK_LIST_ITEMS_LIST_ID_INDEX_NAME = "idx_book_list_items_list_id";
export const BOOK_LIST_ITEMS_USER_BOOK_ID_INDEX_NAME =
  "idx_book_list_items_user_book_id";
export const BOOK_LIST_ITEMS_UNIQUE_NAME =
  "book_list_items_list_id_user_book_id_unique";

export const bookListItems = pgTable(
  "book_list_items",
  {
    id: integer("id").primaryKey().generatedAlwaysAsIdentity(),
    listId: integer("list_id")
      .notNull()
      .references(() => bookLists.id, { onDelete: "cascade" }),
    userBookId: integer("user_book_id")
      .notNull()
      .references(() => userBooks.id, { onDelete: "cascade" }),
    position: integer("position").notNull().default(0),
    addedAt: timestamp("added_at", { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (table) => [
    index(BOOK_LIST_ITEMS_LIST_ID_INDEX_NAME).on(table.listId),
    index(BOOK_LIST_ITEMS_USER_BOOK_ID_INDEX_NAME).on(table.userBookId),
    unique(BOOK_LIST_ITEMS_UNIQUE_NAME).on(table.listId, table.userBookId),
  ],
);

export type BookListItem = typeof bookListItems.$inferSelect;
export type NewBookListItem = typeof bookListItems.$inferInsert;
