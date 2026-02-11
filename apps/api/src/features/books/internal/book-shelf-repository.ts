import {
  and,
  asc,
  count,
  desc,
  eq,
  ilike,
  or,
  type SQL,
  sql,
} from "drizzle-orm";
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
  | "interested";

export interface UpdateUserBookInput {
  readingStatus?: ReadingStatusValue;
  startedAt?: Date | null;
  completedAt?: Date | null;
  note?: string;
  noteUpdatedAt?: Date;
  rating?: number | null;
}

export type ShelfSortField =
  | "ADDED_AT"
  | "TITLE"
  | "AUTHOR"
  | "COMPLETED_AT"
  | "PUBLISHED_DATE"
  | "RATING";
export type SortOrder = "ASC" | "DESC";

export interface GetUserBooksInput {
  query?: string;
  sortBy?: ShelfSortField;
  sortOrder?: SortOrder;
  limit?: number;
  offset?: number;
  readingStatus?: ReadingStatusValue;
}

export interface GetUserBooksResult {
  items: UserBook[];
  totalCount: number;
}

export interface StatusCounts {
  readingCount: number;
  backlogCount: number;
  completedCount: number;
  interestedCount: number;
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
  getUserBooksWithPagination(
    userId: number,
    input: GetUserBooksInput,
  ): Promise<GetUserBooksResult>;
  countUserBooks(userId: number): Promise<number>;
  countUserBooksByStatus(userId: number): Promise<StatusCounts>;
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

    async getUserBooksWithPagination(
      userId: number,
      input: GetUserBooksInput,
    ): Promise<GetUserBooksResult> {
      const {
        query,
        sortBy = "ADDED_AT",
        sortOrder = "DESC",
        limit = 20,
        offset = 0,
        readingStatus,
      } = input;

      const conditions = [eq(userBooks.userId, userId)];

      if (readingStatus) {
        conditions.push(eq(userBooks.readingStatus, readingStatus));
      }

      if (query && query.trim() !== "") {
        const searchPattern = `%${query}%`;
        const searchCondition = or(
          ilike(userBooks.title, searchPattern),
          sql`EXISTS (SELECT 1 FROM unnest(${userBooks.authors}) AS author WHERE author ILIKE ${searchPattern})`,
        );
        if (searchCondition) {
          conditions.push(searchCondition);
        }
      }

      const whereClause = and(...conditions);

      const simpleColumnMap = {
        ADDED_AT: userBooks.addedAt,
        TITLE: userBooks.title,
        AUTHOR: sql`${userBooks.authors}[1]`,
      } as const;

      let orderByClause: SQL;
      if (sortBy === "COMPLETED_AT") {
        orderByClause =
          sortOrder === "ASC"
            ? sql`${userBooks.completedAt} ASC NULLS LAST`
            : sql`${userBooks.completedAt} DESC NULLS LAST`;
      } else if (sortBy === "PUBLISHED_DATE") {
        orderByClause =
          sortOrder === "ASC"
            ? sql`CASE WHEN ${userBooks.publishedDate} IS NULL OR ${userBooks.publishedDate} = '' THEN 1 ELSE 0 END, ${userBooks.publishedDate} ASC`
            : sql`CASE WHEN ${userBooks.publishedDate} IS NULL OR ${userBooks.publishedDate} = '' THEN 1 ELSE 0 END, ${userBooks.publishedDate} DESC`;
      } else if (sortBy === "RATING") {
        orderByClause =
          sortOrder === "ASC"
            ? sql`${userBooks.rating} ASC NULLS LAST`
            : sql`${userBooks.rating} DESC NULLS LAST`;
      } else {
        const sortColumn =
          simpleColumnMap[sortBy as keyof typeof simpleColumnMap];
        orderByClause =
          sortOrder === "ASC" ? asc(sortColumn) : desc(sortColumn);
      }

      const [items, countResult] = await Promise.all([
        db
          .select()
          .from(userBooks)
          .where(whereClause)
          .orderBy(orderByClause)
          .limit(limit)
          .offset(offset),
        db.select({ count: count() }).from(userBooks).where(whereClause),
      ]);

      return {
        items,
        totalCount: countResult[0]?.count ?? 0,
      };
    },

    async countUserBooks(userId: number): Promise<number> {
      const result = await db
        .select({ count: count() })
        .from(userBooks)
        .where(eq(userBooks.userId, userId));
      return result[0]?.count ?? 0;
    },

    async countUserBooksByStatus(userId: number): Promise<StatusCounts> {
      const rows = await db
        .select({
          readingStatus: userBooks.readingStatus,
          count: count(),
        })
        .from(userBooks)
        .where(eq(userBooks.userId, userId))
        .groupBy(userBooks.readingStatus);

      const counts: StatusCounts = {
        readingCount: 0,
        backlogCount: 0,
        completedCount: 0,
        interestedCount: 0,
      };

      for (const row of rows) {
        switch (row.readingStatus) {
          case "reading":
            counts.readingCount = row.count;
            break;
          case "backlog":
            counts.backlogCount = row.count;
            break;
          case "completed":
            counts.completedCount = row.count;
            break;
          case "interested":
            counts.interestedCount = row.count;
            break;
        }
      }

      return counts;
    },
  };
}
