import type { UserBook } from "../../../db/schema/books.js";
import { err, ok, type Result } from "../../../errors/result.js";
import type { LoggerService } from "../../../logger/index.js";
import type { BookShelfRepository } from "./book-shelf-repository.js";

export type BookShelfErrors =
  | { code: "DUPLICATE_BOOK"; message: string }
  | { code: "BOOK_NOT_FOUND"; message: string }
  | { code: "DATABASE_ERROR"; message: string };

export interface AddBookInput {
  externalId: string;
  title: string;
  authors: string[];
  publisher: string | null;
  publishedDate: string | null;
  isbn: string | null;
  coverImageUrl: string | null;
}

export interface AddBookToShelfInput {
  userId: number;
  bookInput: AddBookInput;
}

export interface BookShelfService {
  addBookToShelf(
    input: AddBookToShelfInput,
  ): Promise<Result<UserBook, BookShelfErrors>>;

  getUserBookByExternalId(
    userId: number,
    externalId: string,
  ): Promise<Result<UserBook | null, BookShelfErrors>>;
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

        const userBook = await repository.createUserBook({
          userId,
          externalId: bookInput.externalId,
          title: bookInput.title,
          authors: bookInput.authors,
          publisher: bookInput.publisher,
          publishedDate: bookInput.publishedDate,
          isbn: bookInput.isbn,
          coverImageUrl: bookInput.coverImageUrl,
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
  };
}
