import { GraphQLError } from "graphql";
import type { UserBook } from "../../../db/schema/books.js";
import type {
  AuthenticatedContext,
  Builder,
} from "../../../graphql/builder.js";
import type { UserService } from "../../users/index.js";
import type { Book } from "./book-mapper.js";
import type { BookSearchService } from "./book-search-service.js";
import type { BookShelfService } from "./book-shelf-service.js";

interface AddBookInputData {
  externalId: string;
  title: string;
  authors: string[];
  publisher?: string | null;
  publishedDate?: string | null;
  isbn?: string | null;
  coverImageUrl?: string | null;
}

type BookObjectRef = ReturnType<typeof createBookRef>;
type SearchBooksResultRef = ReturnType<typeof createSearchBooksResultRef>;
type AddBookInputRef = ReturnType<typeof createAddBookInputRef>;
type UserBookObjectRef = ReturnType<typeof createUserBookRef>;

function createBookRef(builder: Builder) {
  return builder.objectRef<Book>("Book");
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

let BookRef: BookObjectRef;
let SearchBooksResultRef: SearchBooksResultRef;
let AddBookInputRef: AddBookInputRef;
let UserBookRef: UserBookObjectRef;

export function registerBooksTypes(builder: Builder): void {
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
        resolve: (parent) => parent.coverImageUrl,
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
        resolve: (parent) => parent.coverImageUrl,
      }),
      addedAt: t.expose("addedAt", {
        type: "DateTime",
        description: "When the book was added to the shelf",
        nullable: false,
      }),
    }),
  });
}

export function registerBooksQueries(
  builder: Builder,
  searchService: BookSearchService,
): void {
  builder.queryFields((t) => ({
    searchBooks: t.field({
      type: SearchBooksResultRef,
      nullable: false,
      description: "Search for books by keyword",
      authScopes: {
        loggedIn: true,
      },
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
      authScopes: {
        loggedIn: true,
      },
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
  }));
}
