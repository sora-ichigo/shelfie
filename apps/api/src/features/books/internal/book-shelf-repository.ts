import { and, count, eq } from "drizzle-orm";
import type { NodePgDatabase } from "drizzle-orm/node-postgres";
import {
  type NewUserBook,
  type UserBook,
  userBooks,
} from "../../../db/schema/books.js";

export type { NewUserBook, UserBook } from "../../../db/schema/books.js";

export type ReadingStatusValue =
  | "backlog"
  | "reading"
  | "completed"
  | "dropped";

export interface UpdateUserBookInput {
  readingStatus?: ReadingStatusValue;
  completedAt?: Date | null;
  note?: string;
  noteUpdatedAt?: Date;
}

export interface BookShelfRepository {
  findUserBookByExternalId(
    userId: number,
    externalId: string,
  ): Promise<UserBook | null>;
  findUserBookById(id: number): Promise<UserBook | null>;
  createUserBook(userBook: NewUserBook): Promise<UserBook>;
  updateUserBook(
    id: number,
    input: UpdateUserBookInput,
  ): Promise<UserBook | null>;
  deleteUserBook(id: number): Promise<boolean>;
  getUserBooks(userId: number): Promise<UserBook[]>;
  countUserBooks(userId: number): Promise<number>;
}

export function createBookShelfRepository(
  db: NodePgDatabase,
): BookShelfRepository {
  return {
    async findUserBookByExternalId(
      userId: number,
      externalId: string,
    ): Promise<UserBook | null> {
      const result = await db
        .select()
        .from(userBooks)
        .where(
          and(
            eq(userBooks.userId, userId),
            eq(userBooks.externalId, externalId),
          ),
        );
      return result[0] ?? null;
    },

    async findUserBookById(id: number): Promise<UserBook | null> {
      const result = await db
        .select()
        .from(userBooks)
        .where(eq(userBooks.id, id));
      return result[0] ?? null;
    },

    async createUserBook(userBook: NewUserBook): Promise<UserBook> {
      const result = await db.insert(userBooks).values(userBook).returning();
      return result[0];
    },

    async updateUserBook(
      id: number,
      input: UpdateUserBookInput,
    ): Promise<UserBook | null> {
      const result = await db
        .update(userBooks)
        .set(input)
        .where(eq(userBooks.id, id))
        .returning();
      return result[0] ?? null;
    },

    async deleteUserBook(id: number): Promise<boolean> {
      const result = await db
        .delete(userBooks)
        .where(eq(userBooks.id, id))
        .returning();
      return result.length > 0;
    },

    async getUserBooks(userId: number): Promise<UserBook[]> {
      return db.select().from(userBooks).where(eq(userBooks.userId, userId));
    },

    async countUserBooks(userId: number): Promise<number> {
      const result = await db
        .select({ count: count() })
        .from(userBooks)
        .where(eq(userBooks.userId, userId));
      return result[0]?.count ?? 0;
    },
  };
}
