import { GraphQLError } from "graphql";
import type { UserBook } from "../../../db/schema/books.js";
import type {
  AuthenticatedContext,
  Builder,
} from "../../../graphql/builder.js";
import type { UserService } from "../../users/index.js";
import {
  type Book,
  type BookDetail,
  type BookSource,
  enhanceRakutenImageUrl,
} from "./book-mapper.js";
import type { BookSearchService } from "./book-search-service.js";
import type { BookShelfService } from "./book-shelf-service.js";

interface BookDetailWithUserBook extends BookDetail {
  userBook: UserBook | null;
}

export type ReadingStatusValue =
  | "backlog"
  | "reading"
  | "completed"
  | "interested"
  | "dropped";

type BookSourceValue = "rakuten" | "google";

interface AddBookInputData {
  externalId: string;
  title: string;
  authors: string[];
  publisher?: string | null;
  publishedDate?: string | null;
  isbn?: string | null;
  coverImageUrl?: string | null;
  source: BookSourceValue;
  readingStatus?: ReadingStatusValue | null;
}

type BookObjectRef = ReturnType<typeof createBookRef>;
type SearchBooksResultRef = ReturnType<typeof createSearchBooksResultRef>;
type AddBookInputRef = ReturnType<typeof createAddBookInputRef>;
type UserBookObjectRef = ReturnType<typeof createUserBookRef>;
type ReadingStatusEnumRef = ReturnType<typeof createReadingStatusEnumRef>;
type BookSourceEnumRef = ReturnType<typeof createBookSourceEnumRef>;
type BookDetailObjectRef = ReturnType<typeof createBookDetailRef>;
type ShelfSortFieldEnumRef = ReturnType<typeof createShelfSortFieldEnumRef>;
type SortOrderEnumRef = ReturnType<typeof createSortOrderEnumRef>;
type MyShelfInputRef = ReturnType<typeof createMyShelfInputRef>;
type MyShelfResultRef = ReturnType<typeof createMyShelfResultRef>;

function createBookRef(builder: Builder) {
  return builder.objectRef<Book>("Book");
}

function createReadingStatusEnumRef(builder: Builder) {
  return builder.enumType("ReadingStatus", {
    description: "Reading status of a book in the user's shelf",
    values: {
      BACKLOG: {
        value: "backlog" as ReadingStatusValue,
        description: "Unread (backlog)",
      },
      READING: {
        value: "reading" as ReadingStatusValue,
        description: "Currently reading",
      },
      COMPLETED: {
        value: "completed" as ReadingStatusValue,
        description: "Finished reading",
      },
      INTERESTED: {
        value: "interested" as ReadingStatusValue,
        description: "Interested in reading",
      },
      DROP: {
        value: "dropped" as ReadingStatusValue,
        deprecationReason: "Use INTERESTED instead. DROP is ignored.",
      },
    } as const,
  });
}

function createBookSourceEnumRef(builder: Builder) {
  return builder.enumType("BookSource", {
    description: "Source of the book data",
    values: {
      RAKUTEN: {
        value: "rakuten" as BookSource,
        description: "Rakuten Books API",
      },
      GOOGLE: {
        value: "google" as BookSource,
        description: "Google Books API",
      },
    } as const,
  });
}

function createSearchBooksResultRef(builder: Builder) {
  return builder.objectRef<{
    items: Book[];
    totalCount: number;
    hasMore: boolean;
  }>("SearchBooksResult");
}

function createAddBookInputRef(builder: Builder) {
  return builder.inputRef<AddBookInputData>("AddBookInput");
}

function createUserBookRef(builder: Builder) {
  return builder.objectRef<UserBook>("UserBook");
}

function createBookDetailRef(builder: Builder) {
  return builder.objectRef<BookDetailWithUserBook>("BookDetail");
}

export type ShelfSortFieldValue = "ADDED_AT" | "TITLE" | "AUTHOR";
export type SortOrderValue = "ASC" | "DESC";

function createShelfSortFieldEnumRef(builder: Builder) {
  return builder.enumType("ShelfSortField", {
    description: "Sort field for books in shelf",
    values: {
      ADDED_AT: {
        value: "ADDED_AT" as ShelfSortFieldValue,
        description: "Sort by date added to shelf",
      },
      TITLE: {
        value: "TITLE" as ShelfSortFieldValue,
        description: "Sort by book title",
      },
      AUTHOR: {
        value: "AUTHOR" as ShelfSortFieldValue,
        description: "Sort by author name",
      },
    } as const,
  });
}

function createSortOrderEnumRef(builder: Builder) {
  return builder.enumType("SortOrder", {
    description: "Sort order direction",
    values: {
      ASC: {
        value: "ASC" as SortOrderValue,
        description: "Ascending order",
      },
      DESC: {
        value: "DESC" as SortOrderValue,
        description: "Descending order",
      },
    } as const,
  });
}

interface MyShelfInputData {
  query?: string | null;
  sortBy?: ShelfSortFieldValue | null;
  sortOrder?: SortOrderValue | null;
  limit?: number | null;
  offset?: number | null;
  readingStatus?: ReadingStatusValue | null;
}

function createMyShelfInputRef(builder: Builder) {
  return builder.inputRef<MyShelfInputData>("MyShelfInput");
}

interface MyShelfResultData {
  items: UserBook[];
  totalCount: number;
  hasMore: boolean;
}

function createMyShelfResultRef(builder: Builder) {
  return builder.objectRef<MyShelfResultData>("MyShelfResult");
}

let BookRef: BookObjectRef;
let SearchBooksResultRef: SearchBooksResultRef;
let AddBookInputRef: AddBookInputRef;
let UserBookRef: UserBookObjectRef;
let ReadingStatusRef: ReadingStatusEnumRef;
let BookSourceRef: BookSourceEnumRef;
let BookDetailRef: BookDetailObjectRef;
let ShelfSortFieldRef: ShelfSortFieldEnumRef;
let SortOrderRef: SortOrderEnumRef;
let MyShelfInputRef: MyShelfInputRef;
let MyShelfResultRef: MyShelfResultRef;

export function registerBooksTypes(builder: Builder): void {
  ReadingStatusRef = createReadingStatusEnumRef(builder);
  BookSourceRef = createBookSourceEnumRef(builder);
  BookRef = createBookRef(builder);

  BookRef.implement({
    description: "A book from the search results",
    fields: (t) => ({
      id: t.exposeString("id", {
        description: "The unique identifier of the book",
        nullable: false,
      }),
      title: t.exposeString("title", {
        description: "The title of the book",
        nullable: false,
      }),
      authors: t.exposeStringList("authors", {
        description: "The authors of the book",
        nullable: false,
      }),
      publisher: t.string({
        nullable: true,
        description: "The publisher of the book",
        resolve: (parent) => parent.publisher,
      }),
      publishedDate: t.string({
        nullable: true,
        description: "The publication date of the book",
        resolve: (parent) => parent.publishedDate,
      }),
      isbn: t.string({
        nullable: true,
        description: "The ISBN of the book",
        resolve: (parent) => parent.isbn,
      }),
      coverImageUrl: t.string({
        nullable: true,
        description: "The cover image URL of the book",
        resolve: (parent) => enhanceRakutenImageUrl(parent.coverImageUrl),
      }),
      source: t.field({
        type: BookSourceRef,
        nullable: false,
        description: "The source of the book data (rakuten or google)",
        resolve: (parent) => parent.source,
      }),
    }),
  });

  SearchBooksResultRef = createSearchBooksResultRef(builder);

  SearchBooksResultRef.implement({
    description: "Search results containing a list of books",
    fields: (t) => ({
      items: t.field({
        type: [BookRef],
        nullable: false,
        description: "The list of books found",
        resolve: (parent) => parent.items,
      }),
      totalCount: t.exposeInt("totalCount", {
        description: "The total number of books found",
        nullable: false,
      }),
      hasMore: t.exposeBoolean("hasMore", {
        description: "Whether there are more books to fetch",
        nullable: false,
      }),
    }),
  });

  AddBookInputRef = createAddBookInputRef(builder);

  AddBookInputRef.implement({
    description: "Input for adding a book to the shelf",
    fields: (t) => ({
      externalId: t.string({
        required: true,
        description: "The external ID of the book",
      }),
      title: t.string({
        required: true,
        description: "The title of the book",
      }),
      authors: t.stringList({
        required: true,
        description: "The authors of the book",
      }),
      publisher: t.string({
        required: false,
        description: "The publisher of the book",
      }),
      publishedDate: t.string({
        required: false,
        description: "The publication date of the book",
      }),
      isbn: t.string({
        required: false,
        description: "The ISBN of the book",
      }),
      coverImageUrl: t.string({
        required: false,
        description: "The cover image URL of the book",
      }),
      source: t.field({
        type: BookSourceRef,
        required: true,
        description: "The source of the book data (rakuten or google)",
      }),
      readingStatus: t.field({
        type: ReadingStatusRef,
        required: false,
        description:
          "The initial reading status of the book (defaults to backlog)",
      }),
    }),
  });

  UserBookRef = createUserBookRef(builder);

  UserBookRef.implement({
    description: "A book in the user's shelf",
    fields: (t) => ({
      id: t.exposeInt("id", {
        description: "The unique identifier of the user book",
        nullable: false,
      }),
      externalId: t.exposeString("externalId", {
        description: "The external ID of the book",
        nullable: false,
      }),
      title: t.exposeString("title", {
        description: "The title of the book",
        nullable: false,
      }),
      authors: t.exposeStringList("authors", {
        description: "The authors of the book",
        nullable: false,
      }),
      publisher: t.string({
        nullable: true,
        description: "The publisher of the book",
        resolve: (parent) => parent.publisher,
      }),
      publishedDate: t.string({
        nullable: true,
        description: "The publication date of the book",
        resolve: (parent) => parent.publishedDate,
      }),
      isbn: t.string({
        nullable: true,
        description: "The ISBN of the book",
        resolve: (parent) => parent.isbn,
      }),
      coverImageUrl: t.string({
        nullable: true,
        description: "The cover image URL of the book",
        resolve: (parent) => enhanceRakutenImageUrl(parent.coverImageUrl),
      }),
      addedAt: t.expose("addedAt", {
        type: "DateTime",
        description: "When the book was added to the shelf",
        nullable: false,
      }),
      readingStatus: t.field({
        type: ReadingStatusRef,
        nullable: false,
        description: "The reading status of the book",
        resolve: (parent) => parent.readingStatus,
      }),
      completedAt: t.expose("completedAt", {
        type: "DateTime",
        description: "When the book was marked as completed",
        nullable: true,
      }),
      note: t.string({
        nullable: true,
        description: "User's reading note for the book",
        resolve: (parent) => parent.note,
      }),
      noteUpdatedAt: t.expose("noteUpdatedAt", {
        type: "DateTime",
        description: "When the note was last updated",
        nullable: true,
      }),
      rating: t.int({
        nullable: true,
        description: "User's rating for the book (1-5)",
        resolve: (parent) => parent.rating,
      }),
      source: t.field({
        type: BookSourceRef,
        nullable: false,
        description: "The source of the book data (rakuten or google)",
        resolve: (parent) => parent.source,
      }),
    }),
  });

  BookDetailRef = createBookDetailRef(builder);

  ShelfSortFieldRef = createShelfSortFieldEnumRef(builder);
  SortOrderRef = createSortOrderEnumRef(builder);

  MyShelfInputRef = createMyShelfInputRef(builder);

  MyShelfInputRef.implement({
    description: "Input for querying user's book shelf",
    fields: (t) => ({
      query: t.string({
        required: false,
        description: "Search query to filter books by title or author",
      }),
      sortBy: t.field({
        type: ShelfSortFieldRef,
        required: false,
        description: "Field to sort by",
      }),
      sortOrder: t.field({
        type: SortOrderRef,
        required: false,
        description: "Sort order direction",
      }),
      limit: t.int({
        required: false,
        description: "Number of items to return (default: 20)",
      }),
      offset: t.int({
        required: false,
        description: "Number of items to skip (default: 0)",
      }),
      readingStatus: t.field({
        type: ReadingStatusRef,
        required: false,
        description: "Filter books by reading status",
      }),
    }),
  });

  MyShelfResultRef = createMyShelfResultRef(builder);

  MyShelfResultRef.implement({
    description: "Result of user's book shelf query",
    fields: (t) => ({
      items: t.field({
        type: [UserBookRef],
        nullable: false,
        description: "List of books in the shelf",
        resolve: (parent) => parent.items,
      }),
      totalCount: t.exposeInt("totalCount", {
        description: "Total number of books matching the query",
        nullable: false,
      }),
      hasMore: t.exposeBoolean("hasMore", {
        description: "Whether there are more books to fetch",
        nullable: false,
      }),
    }),
  });

  BookDetailRef.implement({
    description: "Detailed information about a book",
    fields: (t) => ({
      id: t.exposeString("id", {
        description: "The unique identifier of the book",
        nullable: false,
      }),
      title: t.exposeString("title", {
        description: "The title of the book",
        nullable: false,
      }),
      authors: t.exposeStringList("authors", {
        description: "The authors of the book",
        nullable: false,
      }),
      publisher: t.string({
        nullable: true,
        description: "The publisher of the book",
        resolve: (parent) => parent.publisher,
      }),
      publishedDate: t.string({
        nullable: true,
        description: "The publication date of the book",
        resolve: (parent) => parent.publishedDate,
      }),
      pageCount: t.int({
        nullable: true,
        description: "The number of pages in the book",
        resolve: (parent) => parent.pageCount,
      }),
      categories: t.stringList({
        nullable: true,
        description: "The categories/genres of the book",
        resolve: (parent) => parent.categories,
      }),
      description: t.string({
        nullable: true,
        description: "The description of the book",
        resolve: (parent) => parent.description,
      }),
      isbn: t.string({
        nullable: true,
        description: "The ISBN of the book",
        resolve: (parent) => parent.isbn,
      }),
      coverImageUrl: t.string({
        nullable: true,
        description: "The cover image URL of the book",
        resolve: (parent) => enhanceRakutenImageUrl(parent.coverImageUrl),
      }),
      amazonUrl: t.string({
        nullable: true,
        description: "The Amazon URL for the book",
        resolve: (parent) => parent.amazonUrl,
      }),
      googleBooksUrl: t.string({
        nullable: true,
        description:
          "The Google Books URL for the book (deprecated, use rakutenBooksUrl)",
        deprecationReason: "Use rakutenBooksUrl instead",
        resolve: (parent) => parent.googleBooksUrl,
      }),
      rakutenBooksUrl: t.string({
        nullable: true,
        description: "The Rakuten Books URL for the book",
        resolve: (parent) => parent.rakutenBooksUrl,
      }),
      userBook: t.field({
        type: UserBookRef,
        nullable: true,
        description:
          "The user's reading record for this book (if added to shelf)",
        resolve: (parent) => parent.userBook,
      }),
    }),
  });
}

export function registerBooksQueries(
  builder: Builder,
  searchService: BookSearchService,
  shelfService?: BookShelfService,
  userService?: UserService,
): void {
  builder.queryFields((t) => ({
    searchBooks: t.field({
      type: SearchBooksResultRef,
      nullable: false,
      description: "Search for books by keyword (matches title, author, etc.)",
      args: {
        query: t.arg.string({ required: true }),
        limit: t.arg.int({ required: false }),
        offset: t.arg.int({ required: false }),
      },
      resolve: async (_parent, args) => {
        const result = await searchService.searchBooks({
          query: args.query,
          limit: args.limit ?? undefined,
          offset: args.offset ?? undefined,
        });

        if (!result.success) {
          throw new GraphQLError(result.error.message, {
            extensions: { code: result.error.code },
          });
        }

        return result.data;
      },
    }),
    searchBookByISBN: t.field({
      type: BookRef,
      nullable: true,
      description: "Search for a book by ISBN",
      args: {
        isbn: t.arg.string({ required: true }),
      },
      resolve: async (_parent, args) => {
        const result = await searchService.searchBookByISBN({
          isbn: args.isbn,
        });

        if (!result.success) {
          throw new GraphQLError(result.error.message, {
            extensions: { code: result.error.code },
          });
        }

        return result.data;
      },
    }),
    bookDetail: t.field({
      type: BookDetailRef,
      nullable: false,
      description: "Get detailed information about a book by ID",
      args: {
        bookId: t.arg.string({ required: true }),
        source: t.arg({
          type: BookSourceRef,
          required: true,
          description: "The source of the book (rakuten or google)",
        }),
      },
      resolve: async (
        _parent,
        args,
        context,
      ): Promise<BookDetailWithUserBook> => {
        const authenticatedContext = context as AuthenticatedContext;

        const bookResult = await searchService.getBookDetail(
          args.bookId,
          args.source,
        );

        if (!bookResult.success) {
          throw new GraphQLError(bookResult.error.message, {
            extensions: { code: bookResult.error.code },
          });
        }

        let userBook: UserBook | null = null;

        if (shelfService && userService && authenticatedContext.user?.uid) {
          const userResult = await userService.getUserByFirebaseUid(
            authenticatedContext.user.uid,
          );

          if (userResult.success) {
            const userBookResult = await shelfService.getUserBookByExternalId(
              userResult.data.id,
              args.bookId,
            );

            if (userBookResult.success) {
              userBook = userBookResult.data;
            }
          }
        }

        return {
          ...bookResult.data,
          userBook,
        };
      },
    }),
    userBookByExternalId: t.field({
      type: UserBookRef,
      nullable: true,
      description: "Get the user's reading record for a book by external ID",
      authScopes: {
        loggedIn: true,
      },
      args: {
        externalId: t.arg.string({ required: true }),
      },
      resolve: async (_parent, args, context): Promise<UserBook | null> => {
        const authenticatedContext = context as AuthenticatedContext;

        if (!authenticatedContext.user?.uid) {
          throw new GraphQLError("Authentication required", {
            extensions: { code: "UNAUTHENTICATED" },
          });
        }

        if (!shelfService || !userService) {
          throw new GraphQLError("Service unavailable", {
            extensions: { code: "INTERNAL_ERROR" },
          });
        }

        const userResult = await userService.getUserByFirebaseUid(
          authenticatedContext.user.uid,
        );

        if (!userResult.success) {
          throw new GraphQLError("User not found", {
            extensions: { code: "USER_NOT_FOUND" },
          });
        }

        const userBookResult = await shelfService.getUserBookByExternalId(
          userResult.data.id,
          args.externalId,
        );

        if (!userBookResult.success) {
          throw new GraphQLError(userBookResult.error.message, {
            extensions: { code: userBookResult.error.code },
          });
        }

        return userBookResult.data;
      },
    }),
    myShelf: t.field({
      type: MyShelfResultRef,
      nullable: false,
      description:
        "Get books in the user's shelf with pagination, sorting, and search",
      authScopes: {
        loggedIn: true,
      },
      args: {
        input: t.arg({
          type: MyShelfInputRef,
          required: false,
        }),
      },
      resolve: async (_parent, args, context): Promise<MyShelfResultData> => {
        const authenticatedContext = context as AuthenticatedContext;

        if (!authenticatedContext.user?.uid) {
          throw new GraphQLError("Authentication required", {
            extensions: { code: "UNAUTHENTICATED" },
          });
        }

        if (!shelfService || !userService) {
          throw new GraphQLError("Service unavailable", {
            extensions: { code: "INTERNAL_ERROR" },
          });
        }

        const userResult = await userService.getUserByFirebaseUid(
          authenticatedContext.user.uid,
        );

        if (!userResult.success) {
          throw new GraphQLError("User not found", {
            extensions: { code: "USER_NOT_FOUND" },
          });
        }

        const input = args.input ?? {};
        const readingStatus =
          input.readingStatus && input.readingStatus !== "dropped"
            ? input.readingStatus
            : undefined;
        const userBooksResult = await shelfService.getUserBooksWithPagination(
          userResult.data.id,
          {
            query: input.query ?? undefined,
            sortBy: input.sortBy ?? undefined,
            sortOrder: input.sortOrder ?? undefined,
            limit: input.limit ?? undefined,
            offset: input.offset ?? undefined,
            readingStatus,
          },
        );

        if (!userBooksResult.success) {
          throw new GraphQLError(userBooksResult.error.message, {
            extensions: { code: userBooksResult.error.code },
          });
        }

        return userBooksResult.data;
      },
    }),
  }));
}

export function registerBooksMutations(
  builder: Builder,
  shelfService: BookShelfService,
  userService: UserService,
): void {
  builder.mutationFields((t) => ({
    addBookToShelf: t.field({
      type: UserBookRef,
      nullable: false,
      description: "Add a book to the user's shelf",
      authScopes: {
        loggedIn: true,
      },
      args: {
        bookInput: t.arg({
          type: AddBookInputRef,
          required: true,
        }),
      },
      resolve: async (_parent, args, context): Promise<UserBook> => {
        const authenticatedContext = context as AuthenticatedContext;

        if (!authenticatedContext.user?.uid) {
          throw new GraphQLError("Authentication required", {
            extensions: { code: "UNAUTHENTICATED" },
          });
        }

        const userResult = await userService.getUserByFirebaseUid(
          authenticatedContext.user.uid,
        );

        if (!userResult.success) {
          throw new GraphQLError("User not found", {
            extensions: { code: "USER_NOT_FOUND" },
          });
        }

        const result = await shelfService.addBookToShelf({
          userId: userResult.data.id,
          bookInput: {
            externalId: args.bookInput.externalId,
            title: args.bookInput.title,
            authors: args.bookInput.authors,
            publisher: args.bookInput.publisher ?? null,
            publishedDate: args.bookInput.publishedDate ?? null,
            isbn: args.bookInput.isbn ?? null,
            coverImageUrl: args.bookInput.coverImageUrl ?? null,
            source: args.bookInput.source,
            readingStatus: args.bookInput.readingStatus ?? undefined,
          },
        });

        if (!result.success) {
          throw new GraphQLError(result.error.message, {
            extensions: { code: result.error.code },
          });
        }

        return result.data;
      },
    }),
    updateReadingStatus: t.field({
      type: UserBookRef,
      nullable: false,
      description: "Update the reading status of a book in the user's shelf",
      authScopes: {
        loggedIn: true,
      },
      args: {
        userBookId: t.arg.int({ required: true }),
        status: t.arg({
          type: ReadingStatusRef,
          required: true,
        }),
      },
      resolve: async (_parent, args, context): Promise<UserBook> => {
        const authenticatedContext = context as AuthenticatedContext;

        if (!authenticatedContext.user?.uid) {
          throw new GraphQLError("Authentication required", {
            extensions: { code: "UNAUTHENTICATED" },
          });
        }

        const userResult = await userService.getUserByFirebaseUid(
          authenticatedContext.user.uid,
        );

        if (!userResult.success) {
          throw new GraphQLError("User not found", {
            extensions: { code: "USER_NOT_FOUND" },
          });
        }

        const result = await shelfService.updateReadingStatus({
          userBookId: args.userBookId,
          userId: userResult.data.id,
          status: args.status,
        });

        if (!result.success) {
          throw new GraphQLError(result.error.message, {
            extensions: { code: result.error.code },
          });
        }

        return result.data;
      },
    }),
    updateReadingNote: t.field({
      type: UserBookRef,
      nullable: false,
      description: "Update the reading note of a book in the user's shelf",
      authScopes: {
        loggedIn: true,
      },
      args: {
        userBookId: t.arg.int({ required: true }),
        note: t.arg.string({ required: true }),
      },
      resolve: async (_parent, args, context): Promise<UserBook> => {
        const authenticatedContext = context as AuthenticatedContext;

        if (!authenticatedContext.user?.uid) {
          throw new GraphQLError("Authentication required", {
            extensions: { code: "UNAUTHENTICATED" },
          });
        }

        const userResult = await userService.getUserByFirebaseUid(
          authenticatedContext.user.uid,
        );

        if (!userResult.success) {
          throw new GraphQLError("User not found", {
            extensions: { code: "USER_NOT_FOUND" },
          });
        }

        const result = await shelfService.updateReadingNote({
          userBookId: args.userBookId,
          userId: userResult.data.id,
          note: args.note,
        });

        if (!result.success) {
          throw new GraphQLError(result.error.message, {
            extensions: { code: result.error.code },
          });
        }

        return result.data;
      },
    }),
    updateBookRating: t.field({
      type: UserBookRef,
      nullable: false,
      description: "Update the rating of a book in the user's shelf",
      authScopes: {
        loggedIn: true,
      },
      args: {
        userBookId: t.arg.int({ required: true }),
        rating: t.arg.int({ required: false }),
      },
      resolve: async (_parent, args, context): Promise<UserBook> => {
        const authenticatedContext = context as AuthenticatedContext;

        if (!authenticatedContext.user?.uid) {
          throw new GraphQLError("Authentication required", {
            extensions: { code: "UNAUTHENTICATED" },
          });
        }

        if (args.rating != null && (args.rating < 1 || args.rating > 5)) {
          throw new GraphQLError("Rating must be between 1 and 5", {
            extensions: { code: "BAD_USER_INPUT" },
          });
        }

        const userResult = await userService.getUserByFirebaseUid(
          authenticatedContext.user.uid,
        );

        if (!userResult.success) {
          throw new GraphQLError("User not found", {
            extensions: { code: "USER_NOT_FOUND" },
          });
        }

        const result = await shelfService.updateRating({
          userBookId: args.userBookId,
          userId: userResult.data.id,
          rating: args.rating ?? null,
        });

        if (!result.success) {
          throw new GraphQLError(result.error.message, {
            extensions: { code: result.error.code },
          });
        }

        return result.data;
      },
    }),
    removeFromShelf: t.field({
      type: "Boolean",
      nullable: false,
      description: "Remove a book from the user's shelf",
      authScopes: {
        loggedIn: true,
      },
      args: {
        userBookId: t.arg.int({ required: true }),
      },
      resolve: async (_parent, args, context): Promise<boolean> => {
        const authenticatedContext = context as AuthenticatedContext;

        if (!authenticatedContext.user?.uid) {
          throw new GraphQLError("Authentication required", {
            extensions: { code: "UNAUTHENTICATED" },
          });
        }

        const userResult = await userService.getUserByFirebaseUid(
          authenticatedContext.user.uid,
        );

        if (!userResult.success) {
          throw new GraphQLError("User not found", {
            extensions: { code: "USER_NOT_FOUND" },
          });
        }

        const result = await shelfService.removeFromShelf({
          userBookId: args.userBookId,
          userId: userResult.data.id,
        });

        if (!result.success) {
          throw new GraphQLError(result.error.message, {
            extensions: { code: result.error.code },
          });
        }

        return true;
      },
    }),
  }));
}
