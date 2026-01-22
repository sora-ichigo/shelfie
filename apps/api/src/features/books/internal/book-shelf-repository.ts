import { and, eq } from "drizzle-orm";
import type { NodePgDatabase } from "drizzle-orm/node-postgres";
import {
  type NewUserBook,
  type UserBook,
  userBooks,
} from "../../../db/schema/books.js";

export type { NewUserBook, UserBook } from "../../../db/schema/books.js";

export interface BookShelfRepository {
  findUserBookByExternalId(
    userId: number,
    externalId: string,
  ): Promise<UserBook | null>;
  createUserBook(userBook: NewUserBook): Promise<UserBook>;
  getUserBooks(userId: number): Promise<UserBook[]>;
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
          and(eq(userBooks.userId, userId), eq(userBooks.externalId, externalId)),
        );
      return result[0] ?? null;
    },

    async createUserBook(userBook: NewUserBook): Promise<UserBook> {
      const result = await db.insert(userBooks).values(userBook).returning();
      return result[0];
    },

    async getUserBooks(userId: number): Promise<UserBook[]> {
      return db.select().from(userBooks).where(eq(userBooks.userId, userId));
    },
  };
}
