import { and, asc, eq, max, sql } from "drizzle-orm";
import type { NodePgDatabase } from "drizzle-orm/node-postgres";
import {
  type BookList,
  type BookListItem,
  bookListItems,
  bookLists,
  type NewBookList,
  type NewBookListItem,
} from "../../../db/schema/book-lists.js";

export type { BookList, BookListItem, NewBookList, NewBookListItem };

export interface CreateBookListInput {
  userId: number;
  title: string;
  description: string | null;
}

export interface UpdateBookListInput {
  title?: string;
  description?: string | null;
}

export interface CreateBookListItemInput {
  listId: number;
  userBookId: number;
  position: number;
}

export interface FindBookListsOptions {
  limit?: number;
  offset?: number;
}

export interface FindBookListsResult {
  items: BookList[];
  totalCount: number;
}

export interface BookListRepository {
  createBookList(input: CreateBookListInput): Promise<BookList>;
  findBookListById(id: number): Promise<BookList | null>;
  findBookListsByUserId(
    userId: number,
    options?: FindBookListsOptions,
  ): Promise<FindBookListsResult>;
  updateBookList(
    id: number,
    input: UpdateBookListInput,
  ): Promise<BookList | null>;
  deleteBookList(id: number): Promise<boolean>;

  createBookListItem(input: CreateBookListItemInput): Promise<BookListItem>;
  findBookListItemsByListId(listId: number): Promise<BookListItem[]>;
  findBookListItemByListIdAndUserBookId(
    listId: number,
    userBookId: number,
  ): Promise<BookListItem | null>;
  deleteBookListItem(id: number): Promise<boolean>;
  updateBookListItemPosition(
    id: number,
    position: number,
  ): Promise<BookListItem | null>;
  reorderBookListItems(
    listId: number,
    itemId: number,
    newPosition: number,
  ): Promise<void>;
  getMaxPositionForList(listId: number): Promise<number>;
  findListIdsContainingUserBook(userBookId: number): Promise<number[]>;
}

export function createBookListRepository(
  db: NodePgDatabase,
): BookListRepository {
  return {
    async createBookList(input: CreateBookListInput): Promise<BookList> {
      const result = await db
        .insert(bookLists)
        .values({
          userId: input.userId,
          title: input.title,
          description: input.description,
        })
        .returning();
      return result[0];
    },

    async findBookListById(id: number): Promise<BookList | null> {
      const result = await db
        .select()
        .from(bookLists)
        .where(eq(bookLists.id, id));
      return result[0] ?? null;
    },

    async findBookListsByUserId(
      userId: number,
      options?: FindBookListsOptions,
    ): Promise<FindBookListsResult> {
      const limit = options?.limit ?? 20;
      const offset = options?.offset ?? 0;

      const countResult = await db
        .select({ count: sql<number>`count(*)::int` })
        .from(bookLists)
        .where(eq(bookLists.userId, userId));
      const totalCount = countResult[0]?.count ?? 0;

      const items = await db
        .select()
        .from(bookLists)
        .where(eq(bookLists.userId, userId))
        .orderBy(asc(bookLists.createdAt))
        .limit(limit)
        .offset(offset);

      return { items, totalCount };
    },

    async updateBookList(
      id: number,
      input: UpdateBookListInput,
    ): Promise<BookList | null> {
      const result = await db
        .update(bookLists)
        .set({
          ...input,
          updatedAt: new Date(),
        })
        .where(eq(bookLists.id, id))
        .returning();
      return result[0] ?? null;
    },

    async deleteBookList(id: number): Promise<boolean> {
      const result = await db
        .delete(bookLists)
        .where(eq(bookLists.id, id))
        .returning();
      return result.length > 0;
    },

    async createBookListItem(
      input: CreateBookListItemInput,
    ): Promise<BookListItem> {
      const result = await db
        .insert(bookListItems)
        .values({
          listId: input.listId,
          userBookId: input.userBookId,
          position: input.position,
        })
        .returning();
      return result[0];
    },

    async findBookListItemsByListId(listId: number): Promise<BookListItem[]> {
      return db
        .select()
        .from(bookListItems)
        .where(eq(bookListItems.listId, listId))
        .orderBy(asc(bookListItems.position));
    },

    async findBookListItemByListIdAndUserBookId(
      listId: number,
      userBookId: number,
    ): Promise<BookListItem | null> {
      const result = await db
        .select()
        .from(bookListItems)
        .where(
          and(
            eq(bookListItems.listId, listId),
            eq(bookListItems.userBookId, userBookId),
          ),
        );
      return result[0] ?? null;
    },

    async deleteBookListItem(id: number): Promise<boolean> {
      const result = await db
        .delete(bookListItems)
        .where(eq(bookListItems.id, id))
        .returning();
      return result.length > 0;
    },

    async updateBookListItemPosition(
      id: number,
      position: number,
    ): Promise<BookListItem | null> {
      const result = await db
        .update(bookListItems)
        .set({ position })
        .where(eq(bookListItems.id, id))
        .returning();
      return result[0] ?? null;
    },

    async reorderBookListItems(
      listId: number,
      itemId: number,
      newPosition: number,
    ): Promise<void> {
      const item = await db
        .select()
        .from(bookListItems)
        .where(eq(bookListItems.id, itemId));

      if (item.length === 0) {
        return;
      }

      const currentItem = item[0];
      const oldPosition = currentItem.position;

      if (oldPosition === newPosition) {
        return;
      }

      if (newPosition > oldPosition) {
        await db
          .update(bookListItems)
          .set({
            position: sql`${bookListItems.position} - 1`,
          })
          .where(
            and(
              eq(bookListItems.listId, listId),
              sql`${bookListItems.position} > ${oldPosition}`,
              sql`${bookListItems.position} <= ${newPosition}`,
            ),
          );
      } else {
        await db
          .update(bookListItems)
          .set({
            position: sql`${bookListItems.position} + 1`,
          })
          .where(
            and(
              eq(bookListItems.listId, listId),
              sql`${bookListItems.position} >= ${newPosition}`,
              sql`${bookListItems.position} < ${oldPosition}`,
            ),
          );
      }

      await db
        .update(bookListItems)
        .set({ position: newPosition })
        .where(eq(bookListItems.id, itemId));
    },

    async getMaxPositionForList(listId: number): Promise<number> {
      const result = await db
        .select({ maxPosition: max(bookListItems.position) })
        .from(bookListItems)
        .where(eq(bookListItems.listId, listId));
      return result[0]?.maxPosition ?? -1;
    },

    async findListIdsContainingUserBook(userBookId: number): Promise<number[]> {
      const result = await db
        .selectDistinct({ listId: bookListItems.listId })
        .from(bookListItems)
        .where(eq(bookListItems.userBookId, userBookId));
      return result.map((r) => r.listId);
    },
  };
}
