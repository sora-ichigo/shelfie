import {
  index,
  integer,
  pgEnum,
  pgTable,
  text,
  timestamp,
  unique,
} from "drizzle-orm/pg-core";
import { users } from "./users";

export const readingStatusEnum = pgEnum("reading_status", [
  "backlog",
  "reading",
  "completed",
  "dropped",
]);

export const USER_BOOKS_USER_ID_INDEX_NAME = "idx_user_books_user_id";
export const USER_BOOKS_USER_ID_EXTERNAL_ID_UNIQUE_NAME =
  "user_books_user_id_external_id_unique";

export const userBooks = pgTable(
  "user_books",
  {
    id: integer("id").primaryKey().generatedAlwaysAsIdentity(),
    userId: integer("user_id")
      .notNull()
      .references(() => users.id, { onDelete: "cascade" }),
    externalId: text("external_id").notNull(),
    title: text("title").notNull(),
    authors: text("authors").array().notNull().default([]),
    publisher: text("publisher"),
    publishedDate: text("published_date"),
    isbn: text("isbn"),
    coverImageUrl: text("cover_image_url"),
    addedAt: timestamp("added_at", { withTimezone: true })
      .defaultNow()
      .notNull(),
    readingStatus: readingStatusEnum("reading_status")
      .notNull()
      .default("backlog"),
    completedAt: timestamp("completed_at", { withTimezone: true }),
    note: text("note"),
    noteUpdatedAt: timestamp("note_updated_at", { withTimezone: true }),
    rating: integer("rating"),
  },
  (table) => [
    index(USER_BOOKS_USER_ID_INDEX_NAME).on(table.userId),
    unique(USER_BOOKS_USER_ID_EXTERNAL_ID_UNIQUE_NAME).on(
      table.userId,
      table.externalId,
    ),
  ],
);

export type UserBook = typeof userBooks.$inferSelect;
export type NewUserBook = typeof userBooks.$inferInsert;
