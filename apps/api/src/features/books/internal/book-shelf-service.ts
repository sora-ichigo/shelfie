import type { UserBook } from "../../../db/schema/books.js";
import { err, ok, type Result } from "../../../errors/result.js";
import type { LoggerService } from "../../../logger/index.js";
import type {
  BookShelfRepository,
  GetUserBooksInput,
  ReadingStatusValue,
} from "./book-shelf-repository.js";

export type BookShelfErrors =
  | { code: "DUPLICATE_BOOK"; message: string }
  | { code: "BOOK_NOT_FOUND"; message: string }
  | { code: "FORBIDDEN"; message: string }
  | { code: "DATABASE_ERROR"; message: string };

export type BookSourceValue = "rakuten" | "google";

export interface AddBookInput {
  externalId: string;
  title: string;
  authors: string[];
  publisher: string | null;
  publishedDate: string | null;
  isbn: string | null;
  coverImageUrl: string | null;
  source?: BookSourceValue;
  readingStatus?: ReadingStatusValue;
}

export interface AddBookToShelfInput {
  userId: number;
  bookInput: AddBookInput;
}

export interface UpdateReadingStatusInput {
  userBookId: number;
  userId: number;
  status: ReadingStatusValue;
}

export interface UpdateReadingNoteInput {
  userBookId: number;
  userId: number;
  note: string;
}

export interface UpdateRatingInput {
  userBookId: number;
  userId: number;
  rating: number;
}

export interface RemoveFromShelfInput {
  userBookId: number;
  userId: number;
}

export interface MyShelfResult {
  items: UserBook[];
  totalCount: number;
  hasMore: boolean;
}

export interface BookShelfService {
  addBookToShelf(
    input: AddBookToShelfInput,
  ): Promise<Result<UserBook, BookShelfErrors>>;

  getUserBookByExternalId(
    userId: number,
    externalId: string,
  ): Promise<Result<UserBook | null, BookShelfErrors>>;

  getUserBooks(userId: number): Promise<Result<UserBook[], BookShelfErrors>>;

  getUserBooksWithPagination(
    userId: number,
    input: GetUserBooksInput,
  ): Promise<Result<MyShelfResult, BookShelfErrors>>;

  updateReadingStatus(
    input: UpdateReadingStatusInput,
  ): Promise<Result<UserBook, BookShelfErrors>>;

  updateReadingNote(
    input: UpdateReadingNoteInput,
  ): Promise<Result<UserBook, BookShelfErrors>>;

  updateRating(
    input: UpdateRatingInput,
  ): Promise<Result<UserBook, BookShelfErrors>>;

  removeFromShelf(
    input: RemoveFromShelfInput,
  ): Promise<Result<void, BookShelfErrors>>;
}

function resolveCompletedAt(status: ReadingStatusValue): Date | null {
  return status === "completed" ? new Date() : null;
}

export function createBookShelfService(
  repository: BookShelfRepository,
  logger: LoggerService,
): BookShelfService {
  return {
    async addBookToShelf(
      input: AddBookToShelfInput,
    ): Promise<Result<UserBook, BookShelfErrors>> {
      const { userId, bookInput } = input;
      const { externalId } = bookInput;

      try {
        const existingBook = await repository.findUserBookByExternalId(
          userId,
          externalId,
        );

        if (existingBook !== null) {
          logger.info("Duplicate book detected", {
            feature: "books",
            userId: String(userId),
            externalId,
          });

          return err({
            code: "DUPLICATE_BOOK",
            message: "This book is already in your shelf",
          });
        }

        const readingStatus = bookInput.readingStatus ?? "backlog";
        const completedAt = resolveCompletedAt(readingStatus);
        const userBook = await repository.createUserBook({
          userId,
          externalId: bookInput.externalId,
          title: bookInput.title,
          authors: bookInput.authors,
          publisher: bookInput.publisher,
          publishedDate: bookInput.publishedDate,
          isbn: bookInput.isbn,
          coverImageUrl: bookInput.coverImageUrl,
          source: bookInput.source ?? "rakuten",
          readingStatus,
          ...(completedAt !== null && { completedAt }),
        });

        logger.info("Book added to shelf successfully", {
          feature: "books",
          userId: String(userId),
          externalId,
          userBookId: userBook.id,
        });

        return ok(userBook);
      } catch (error) {
        logger.error(
          "Database error while adding book to shelf",
          error instanceof Error ? error : new Error(String(error)),
          {
            feature: "books",
            userId: String(userId),
            externalId,
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

    async getUserBookByExternalId(
      userId: number,
      externalId: string,
    ): Promise<Result<UserBook | null, BookShelfErrors>> {
      try {
        const userBook = await repository.findUserBookByExternalId(
          userId,
          externalId,
        );

        return ok(userBook);
      } catch (error) {
        logger.error(
          "Database error while fetching user book by external ID",
          error instanceof Error ? error : new Error(String(error)),
          {
            feature: "books",
            userId: String(userId),
            externalId,
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

    async getUserBooks(
      userId: number,
    ): Promise<Result<UserBook[], BookShelfErrors>> {
      try {
        const userBooks = await repository.getUserBooks(userId);
        return ok(userBooks);
      } catch (error) {
        logger.error(
          "Database error while fetching user books",
          error instanceof Error ? error : new Error(String(error)),
          {
            feature: "books",
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

    async getUserBooksWithPagination(
      userId: number,
      input: GetUserBooksInput,
    ): Promise<Result<MyShelfResult, BookShelfErrors>> {
      try {
        const { items, totalCount } =
          await repository.getUserBooksWithPagination(userId, input);

        const offset = input.offset ?? 0;
        const hasMore = offset + items.length < totalCount;

        return ok({
          items,
          totalCount,
          hasMore,
        });
      } catch (error) {
        logger.error(
          "Database error while fetching user books with pagination",
          error instanceof Error ? error : new Error(String(error)),
          {
            feature: "books",
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

    async updateReadingStatus(
      input: UpdateReadingStatusInput,
    ): Promise<Result<UserBook, BookShelfErrors>> {
      const { userBookId, userId, status } = input;

      try {
        const userBook = await repository.findUserBookById(userBookId);

        if (userBook === null) {
          return err({
            code: "BOOK_NOT_FOUND",
            message: "Book not found in shelf",
          });
        }

        if (userBook.userId !== userId) {
          logger.warn("Unauthorized reading status update attempt", {
            feature: "books",
            userBookId: String(userBookId),
            ownerId: String(userBook.userId),
            requesterId: String(userId),
          });

          return err({
            code: "FORBIDDEN",
            message: "You are not allowed to update this book",
          });
        }

        const updatedBook = await repository.updateUserBook(userBookId, {
          readingStatus: status,
          completedAt: resolveCompletedAt(status),
        });

        if (updatedBook === null) {
          return err({
            code: "DATABASE_ERROR",
            message: "Failed to update reading status",
          });
        }

        logger.info("Reading status updated successfully", {
          feature: "books",
          userBookId: String(userBookId),
          userId: String(userId),
          status,
        });

        return ok(updatedBook);
      } catch (error) {
        logger.error(
          "Database error while updating reading status",
          error instanceof Error ? error : new Error(String(error)),
          {
            feature: "books",
            userBookId: String(userBookId),
            userId: String(userId),
            status,
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

    async updateReadingNote(
      input: UpdateReadingNoteInput,
    ): Promise<Result<UserBook, BookShelfErrors>> {
      const { userBookId, userId, note } = input;

      try {
        const userBook = await repository.findUserBookById(userBookId);

        if (userBook === null) {
          return err({
            code: "BOOK_NOT_FOUND",
            message: "Book not found in shelf",
          });
        }

        if (userBook.userId !== userId) {
          logger.warn("Unauthorized reading note update attempt", {
            feature: "books",
            userBookId: String(userBookId),
            ownerId: String(userBook.userId),
            requesterId: String(userId),
          });

          return err({
            code: "FORBIDDEN",
            message: "You are not allowed to update this book",
          });
        }

        const updatedBook = await repository.updateUserBook(userBookId, {
          note,
          noteUpdatedAt: new Date(),
        });

        if (updatedBook === null) {
          return err({
            code: "DATABASE_ERROR",
            message: "Failed to update reading note",
          });
        }

        logger.info("Reading note updated successfully", {
          feature: "books",
          userBookId: String(userBookId),
          userId: String(userId),
        });

        return ok(updatedBook);
      } catch (error) {
        logger.error(
          "Database error while updating reading note",
          error instanceof Error ? error : new Error(String(error)),
          {
            feature: "books",
            userBookId: String(userBookId),
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

    async updateRating(
      input: UpdateRatingInput,
    ): Promise<Result<UserBook, BookShelfErrors>> {
      const { userBookId, userId, rating } = input;

      try {
        const userBook = await repository.findUserBookById(userBookId);

        if (userBook === null) {
          return err({
            code: "BOOK_NOT_FOUND",
            message: "Book not found in shelf",
          });
        }

        if (userBook.userId !== userId) {
          logger.warn("Unauthorized rating update attempt", {
            feature: "books",
            userBookId: String(userBookId),
            ownerId: String(userBook.userId),
            requesterId: String(userId),
          });

          return err({
            code: "FORBIDDEN",
            message: "You are not allowed to update this book",
          });
        }

        const updatedBook = await repository.updateUserBook(userBookId, {
          rating,
        });

        if (updatedBook === null) {
          return err({
            code: "DATABASE_ERROR",
            message: "Failed to update rating",
          });
        }

        logger.info("Rating updated successfully", {
          feature: "books",
          userBookId: String(userBookId),
          userId: String(userId),
          rating: String(rating),
        });

        return ok(updatedBook);
      } catch (error) {
        logger.error(
          "Database error while updating rating",
          error instanceof Error ? error : new Error(String(error)),
          {
            feature: "books",
            userBookId: String(userBookId),
            userId: String(userId),
            rating: String(rating),
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

    async removeFromShelf(
      input: RemoveFromShelfInput,
    ): Promise<Result<void, BookShelfErrors>> {
      const { userBookId, userId } = input;

      try {
        const userBook = await repository.findUserBookById(userBookId);

        if (userBook === null) {
          return err({
            code: "BOOK_NOT_FOUND",
            message: "Book not found in shelf",
          });
        }

        if (userBook.userId !== userId) {
          logger.warn("Unauthorized remove from shelf attempt", {
            feature: "books",
            userBookId: String(userBookId),
            ownerId: String(userBook.userId),
            requesterId: String(userId),
          });

          return err({
            code: "FORBIDDEN",
            message: "You are not allowed to remove this book",
          });
        }

        const deleted = await repository.deleteUserBook(userBookId);

        if (!deleted) {
          return err({
            code: "DATABASE_ERROR",
            message: "Failed to remove book from shelf",
          });
        }

        logger.info("Book removed from shelf successfully", {
          feature: "books",
          userBookId: String(userBookId),
          userId: String(userId),
        });

        return ok(undefined);
      } catch (error) {
        logger.error(
          "Database error while removing book from shelf",
          error instanceof Error ? error : new Error(String(error)),
          {
            feature: "books",
            userBookId: String(userBookId),
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
  };
}
