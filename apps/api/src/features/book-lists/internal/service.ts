import type { BookList, BookListItem } from "../../../db/schema/book-lists.js";
import { err, ok, type Result } from "../../../errors/result.js";
import type { LoggerService } from "../../../logger/index.js";
import type { BookListRepository } from "./repository.js";

export type BookListErrors =
  | { code: "LIST_NOT_FOUND"; message: string }
  | { code: "FORBIDDEN"; message: string }
  | { code: "DUPLICATE_BOOK"; message: string }
  | { code: "BOOK_NOT_IN_LIST"; message: string }
  | { code: "VALIDATION_ERROR"; message: string }
  | { code: "DATABASE_ERROR"; message: string };

export interface CreateBookListServiceInput {
  userId: number;
  title: string;
  description?: string | null;
}

export interface UpdateBookListServiceInput {
  listId: number;
  userId: number;
  title?: string;
  description?: string | null;
}

export interface AddBookToListInput {
  listId: number;
  userId: number;
  userBookId: number;
}

export interface RemoveBookFromListInput {
  listId: number;
  userId: number;
  userBookId: number;
}

export interface ReorderBookInput {
  listId: number;
  userId: number;
  itemId: number;
  newPosition: number;
}

export interface BookListDetailItem {
  id: number;
  userBookId: number;
  position: number;
  addedAt: Date;
}

export interface BookListDetailStats {
  bookCount: number;
  completedCount: number;
  coverImages: string[];
}

export interface BookListWithItems {
  id: number;
  userId: number;
  title: string;
  description: string | null;
  createdAt: Date;
  updatedAt: Date;
  items: BookListDetailItem[];
  stats: BookListDetailStats;
}

export interface BookListSummary {
  id: number;
  title: string;
  description: string | null;
  bookCount: number;
  coverImages: string[];
  createdAt: Date;
  updatedAt: Date;
}

export interface GetUserBookListsInput {
  userId: number;
  limit?: number;
  offset?: number;
}

export interface BookListSummaryResult {
  items: BookListSummary[];
  totalCount: number;
  hasMore: boolean;
}

interface BookShelfRepositoryMinimal {
  findUserBookById(id: number): Promise<{
    id: number;
    userId: number;
    title: string;
    authors: string[];
    coverImageUrl: string | null;
    readingStatus: string;
  } | null>;
}

export interface BookListService {
  createBookList(
    input: CreateBookListServiceInput,
  ): Promise<Result<BookList, BookListErrors>>;
  getBookList(
    listId: number,
    userId: number,
  ): Promise<Result<BookListWithItems, BookListErrors>>;
  getUserBookLists(
    input: GetUserBookListsInput,
  ): Promise<Result<BookListSummaryResult, BookListErrors>>;
  updateBookList(
    input: UpdateBookListServiceInput,
  ): Promise<Result<BookList, BookListErrors>>;
  deleteBookList(
    listId: number,
    userId: number,
  ): Promise<Result<void, BookListErrors>>;

  addBookToList(
    input: AddBookToListInput,
  ): Promise<Result<BookListDetailItem, BookListErrors>>;
  removeBookFromList(
    input: RemoveBookFromListInput,
  ): Promise<Result<void, BookListErrors>>;
  reorderBookInList(
    input: ReorderBookInput,
  ): Promise<Result<void, BookListErrors>>;
}

export function createBookListService(
  repository: BookListRepository,
  bookShelfRepository: BookShelfRepositoryMinimal,
  logger: LoggerService,
): BookListService {
  return {
    async createBookList(
      input: CreateBookListServiceInput,
    ): Promise<Result<BookList, BookListErrors>> {
      const { userId, title, description } = input;

      if (!title || title.trim() === "") {
        return err({
          code: "VALIDATION_ERROR",
          message: "Title is required",
        });
      }

      try {
        const bookList = await repository.createBookList({
          userId,
          title: title.trim(),
          description: description ?? null,
        });

        logger.info("Book list created successfully", {
          feature: "book-lists",
          userId: String(userId),
          listId: bookList.id,
        });

        return ok(bookList);
      } catch (error) {
        logger.error(
          "Database error while creating book list",
          error instanceof Error ? error : new Error(String(error)),
          {
            feature: "book-lists",
            userId: String(userId),
          },
        );

        return err({
          code: "DATABASE_ERROR",
          message:
            error instanceof Error
              ? error.message
              : "Unknown database error occurred",
        });
      }
    },

    async getBookList(
      listId: number,
      userId: number,
    ): Promise<Result<BookListWithItems, BookListErrors>> {
      try {
        const bookList = await repository.findBookListById(listId);

        if (bookList === null) {
          return err({
            code: "LIST_NOT_FOUND",
            message: "Book list not found",
          });
        }

        if (bookList.userId !== userId) {
          logger.warn("Unauthorized book list access attempt", {
            feature: "book-lists",
            listId: String(listId),
            ownerId: String(bookList.userId),
            requesterId: String(userId),
          });

          return err({
            code: "FORBIDDEN",
            message: "You are not allowed to access this book list",
          });
        }

        const rawItems = await repository.findBookListItemsByListId(listId);

        const items: BookListDetailItem[] = [];
        const coverImages: string[] = [];
        let completedCount = 0;

        for (const item of rawItems) {
          items.push({
            id: item.id,
            userBookId: item.userBookId,
            position: item.position,
            addedAt: item.addedAt,
          });

          const userBook = await bookShelfRepository.findUserBookById(
            item.userBookId,
          );

          if (userBook) {
            if (userBook.coverImageUrl && coverImages.length < 4) {
              coverImages.push(userBook.coverImageUrl);
            }

            if (userBook.readingStatus === "completed") {
              completedCount++;
            }
          }
        }

        return ok({
          id: bookList.id,
          userId: bookList.userId,
          title: bookList.title,
          description: bookList.description,
          createdAt: bookList.createdAt,
          updatedAt: bookList.updatedAt,
          items,
          stats: {
            bookCount: items.length,
            completedCount,
            coverImages,
          },
        });
      } catch (error) {
        logger.error(
          "Database error while fetching book list",
          error instanceof Error ? error : new Error(String(error)),
          {
            feature: "book-lists",
            listId: String(listId),
            userId: String(userId),
          },
        );

        return err({
          code: "DATABASE_ERROR",
          message:
            error instanceof Error
              ? error.message
              : "Unknown database error occurred",
        });
      }
    },

    async getUserBookLists(
      input: GetUserBookListsInput,
    ): Promise<Result<BookListSummaryResult, BookListErrors>> {
      const { userId, limit = 20, offset = 0 } = input;

      try {
        const { items: bookLists, totalCount } =
          await repository.findBookListsByUserId(userId, { limit, offset });

        const summaries: BookListSummary[] = [];

        for (const list of bookLists) {
          const items = await repository.findBookListItemsByListId(list.id);
          const coverImages: string[] = [];

          for (const item of items.slice(0, 4)) {
            const userBook = await bookShelfRepository.findUserBookById(
              item.userBookId,
            );
            if (userBook?.coverImageUrl) {
              coverImages.push(userBook.coverImageUrl);
            }
          }

          summaries.push({
            id: list.id,
            title: list.title,
            description: list.description,
            bookCount: items.length,
            coverImages,
            createdAt: list.createdAt,
            updatedAt: list.updatedAt,
          });
        }

        const hasMore = offset + summaries.length < totalCount;

        return ok({ items: summaries, totalCount, hasMore });
      } catch (error) {
        logger.error(
          "Database error while fetching user book lists",
          error instanceof Error ? error : new Error(String(error)),
          {
            feature: "book-lists",
            userId: String(userId),
          },
        );

        return err({
          code: "DATABASE_ERROR",
          message:
            error instanceof Error
              ? error.message
              : "Unknown database error occurred",
        });
      }
    },

    async updateBookList(
      input: UpdateBookListServiceInput,
    ): Promise<Result<BookList, BookListErrors>> {
      const { listId, userId, title, description } = input;

      try {
        const bookList = await repository.findBookListById(listId);

        if (bookList === null) {
          return err({
            code: "LIST_NOT_FOUND",
            message: "Book list not found",
          });
        }

        if (bookList.userId !== userId) {
          logger.warn("Unauthorized book list update attempt", {
            feature: "book-lists",
            listId: String(listId),
            ownerId: String(bookList.userId),
            requesterId: String(userId),
          });

          return err({
            code: "FORBIDDEN",
            message: "You are not allowed to update this book list",
          });
        }

        if (title !== undefined && title.trim() === "") {
          return err({
            code: "VALIDATION_ERROR",
            message: "Title cannot be empty",
          });
        }

        const updateData: { title?: string; description?: string | null } = {};
        if (title !== undefined) {
          updateData.title = title.trim();
        }
        if (description !== undefined) {
          updateData.description = description;
        }

        const updatedBookList = await repository.updateBookList(
          listId,
          updateData,
        );

        if (updatedBookList === null) {
          return err({
            code: "DATABASE_ERROR",
            message: "Failed to update book list",
          });
        }

        logger.info("Book list updated successfully", {
          feature: "book-lists",
          listId: String(listId),
          userId: String(userId),
        });

        return ok(updatedBookList);
      } catch (error) {
        logger.error(
          "Database error while updating book list",
          error instanceof Error ? error : new Error(String(error)),
          {
            feature: "book-lists",
            listId: String(listId),
            userId: String(userId),
          },
        );

        return err({
          code: "DATABASE_ERROR",
          message:
            error instanceof Error
              ? error.message
              : "Unknown database error occurred",
        });
      }
    },

    async deleteBookList(
      listId: number,
      userId: number,
    ): Promise<Result<void, BookListErrors>> {
      try {
        const bookList = await repository.findBookListById(listId);

        if (bookList === null) {
          return err({
            code: "LIST_NOT_FOUND",
            message: "Book list not found",
          });
        }

        if (bookList.userId !== userId) {
          logger.warn("Unauthorized book list delete attempt", {
            feature: "book-lists",
            listId: String(listId),
            ownerId: String(bookList.userId),
            requesterId: String(userId),
          });

          return err({
            code: "FORBIDDEN",
            message: "You are not allowed to delete this book list",
          });
        }

        const deleted = await repository.deleteBookList(listId);

        if (!deleted) {
          return err({
            code: "DATABASE_ERROR",
            message: "Failed to delete book list",
          });
        }

        logger.info("Book list deleted successfully", {
          feature: "book-lists",
          listId: String(listId),
          userId: String(userId),
        });

        return ok(undefined);
      } catch (error) {
        logger.error(
          "Database error while deleting book list",
          error instanceof Error ? error : new Error(String(error)),
          {
            feature: "book-lists",
            listId: String(listId),
            userId: String(userId),
          },
        );

        return err({
          code: "DATABASE_ERROR",
          message:
            error instanceof Error
              ? error.message
              : "Unknown database error occurred",
        });
      }
    },

    async addBookToList(
      input: AddBookToListInput,
    ): Promise<Result<BookListDetailItem, BookListErrors>> {
      const { listId, userId, userBookId } = input;

      try {
        const bookList = await repository.findBookListById(listId);

        if (bookList === null) {
          return err({
            code: "LIST_NOT_FOUND",
            message: "Book list not found",
          });
        }

        if (bookList.userId !== userId) {
          logger.warn("Unauthorized add book to list attempt", {
            feature: "book-lists",
            listId: String(listId),
            ownerId: String(bookList.userId),
            requesterId: String(userId),
          });

          return err({
            code: "FORBIDDEN",
            message: "You are not allowed to add books to this list",
          });
        }

        const userBook = await bookShelfRepository.findUserBookById(userBookId);

        if (userBook === null) {
          return err({
            code: "LIST_NOT_FOUND",
            message: "User book not found",
          });
        }

        if (userBook.userId !== userId) {
          return err({
            code: "FORBIDDEN",
            message: "You can only add your own books to the list",
          });
        }

        const existingItem =
          await repository.findBookListItemByListIdAndUserBookId(
            listId,
            userBookId,
          );

        if (existingItem !== null) {
          logger.info("Duplicate book detected in list", {
            feature: "book-lists",
            listId: String(listId),
            userBookId: String(userBookId),
          });

          return err({
            code: "DUPLICATE_BOOK",
            message: "This book is already in the list",
          });
        }

        const maxPosition = await repository.getMaxPositionForList(listId);
        const newPosition = maxPosition + 1;

        const item = await repository.createBookListItem({
          listId,
          userBookId,
          position: newPosition,
        });

        logger.info("Book added to list successfully", {
          feature: "book-lists",
          listId: String(listId),
          userBookId: String(userBookId),
          position: newPosition,
        });

        return ok({
          id: item.id,
          userBookId: item.userBookId,
          position: item.position,
          addedAt: item.addedAt,
        });
      } catch (error) {
        logger.error(
          "Database error while adding book to list",
          error instanceof Error ? error : new Error(String(error)),
          {
            feature: "book-lists",
            listId: String(listId),
            userBookId: String(userBookId),
          },
        );

        return err({
          code: "DATABASE_ERROR",
          message:
            error instanceof Error
              ? error.message
              : "Unknown database error occurred",
        });
      }
    },

    async removeBookFromList(
      input: RemoveBookFromListInput,
    ): Promise<Result<void, BookListErrors>> {
      const { listId, userId, userBookId } = input;

      try {
        const bookList = await repository.findBookListById(listId);

        if (bookList === null) {
          return err({
            code: "LIST_NOT_FOUND",
            message: "Book list not found",
          });
        }

        if (bookList.userId !== userId) {
          logger.warn("Unauthorized remove book from list attempt", {
            feature: "book-lists",
            listId: String(listId),
            ownerId: String(bookList.userId),
            requesterId: String(userId),
          });

          return err({
            code: "FORBIDDEN",
            message: "You are not allowed to remove books from this list",
          });
        }

        const item = await repository.findBookListItemByListIdAndUserBookId(
          listId,
          userBookId,
        );

        if (item === null) {
          return err({
            code: "BOOK_NOT_IN_LIST",
            message: "This book is not in the list",
          });
        }

        const deleted = await repository.deleteBookListItem(item.id);

        if (!deleted) {
          return err({
            code: "DATABASE_ERROR",
            message: "Failed to remove book from list",
          });
        }

        logger.info("Book removed from list successfully", {
          feature: "book-lists",
          listId: String(listId),
          userBookId: String(userBookId),
        });

        return ok(undefined);
      } catch (error) {
        logger.error(
          "Database error while removing book from list",
          error instanceof Error ? error : new Error(String(error)),
          {
            feature: "book-lists",
            listId: String(listId),
            userBookId: String(userBookId),
          },
        );

        return err({
          code: "DATABASE_ERROR",
          message:
            error instanceof Error
              ? error.message
              : "Unknown database error occurred",
        });
      }
    },

    async reorderBookInList(
      input: ReorderBookInput,
    ): Promise<Result<void, BookListErrors>> {
      const { listId, userId, itemId, newPosition } = input;

      try {
        const bookList = await repository.findBookListById(listId);

        if (bookList === null) {
          return err({
            code: "LIST_NOT_FOUND",
            message: "Book list not found",
          });
        }

        if (bookList.userId !== userId) {
          logger.warn("Unauthorized reorder book in list attempt", {
            feature: "book-lists",
            listId: String(listId),
            ownerId: String(bookList.userId),
            requesterId: String(userId),
          });

          return err({
            code: "FORBIDDEN",
            message: "You are not allowed to reorder books in this list",
          });
        }

        await repository.reorderBookListItems(listId, itemId, newPosition);

        logger.info("Book reordered in list successfully", {
          feature: "book-lists",
          listId: String(listId),
          itemId: String(itemId),
          newPosition,
        });

        return ok(undefined);
      } catch (error) {
        logger.error(
          "Database error while reordering book in list",
          error instanceof Error ? error : new Error(String(error)),
          {
            feature: "book-lists",
            listId: String(listId),
            itemId: String(itemId),
          },
        );

        return err({
          code: "DATABASE_ERROR",
          message:
            error instanceof Error
              ? error.message
              : "Unknown database error occurred",
        });
      }
    },
  };
}
