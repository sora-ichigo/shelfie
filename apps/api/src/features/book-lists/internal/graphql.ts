import { GraphQLError } from "graphql";
import type { BookList, BookListItem } from "../../../db/schema/book-lists.js";
import type {
  AuthenticatedContext,
  Builder,
} from "../../../graphql/builder.js";
import type { UserService } from "../../users/index.js";
import type {
  BookListService,
  BookListSummary,
  BookListSummaryResult,
  BookListWithItems,
} from "./service.js";

interface CreateBookListInputData {
  title: string;
  description?: string | null;
}

interface UpdateBookListInputData {
  listId: number;
  title?: string | null;
  description?: string | null;
}

interface MyBookListsInputData {
  limit?: number | null;
  offset?: number | null;
}

type BookListObjectRef = ReturnType<typeof createBookListRef>;
type BookListItemObjectRef = ReturnType<typeof createBookListItemRef>;
type BookListSummaryObjectRef = ReturnType<typeof createBookListSummaryRef>;
type BookListDetailObjectRef = ReturnType<typeof createBookListDetailRef>;
type CreateBookListInputRef = ReturnType<typeof createCreateBookListInputRef>;
type UpdateBookListInputRef = ReturnType<typeof createUpdateBookListInputRef>;
type MyBookListsInputRef = ReturnType<typeof createMyBookListsInputRef>;
type MyBookListsResultRef = ReturnType<typeof createMyBookListsResultRef>;

function createBookListRef(builder: Builder) {
  return builder.objectRef<BookList>("BookList");
}

function createBookListItemRef(builder: Builder) {
  return builder.objectRef<BookListItem>("BookListItem");
}

function createBookListSummaryRef(builder: Builder) {
  return builder.objectRef<BookListSummary>("BookListSummary");
}

function createBookListDetailRef(builder: Builder) {
  return builder.objectRef<BookListWithItems>("BookListDetail");
}

function createCreateBookListInputRef(builder: Builder) {
  return builder.inputRef<CreateBookListInputData>("CreateBookListInput");
}

function createUpdateBookListInputRef(builder: Builder) {
  return builder.inputRef<UpdateBookListInputData>("UpdateBookListInput");
}

function createMyBookListsInputRef(builder: Builder) {
  return builder.inputRef<MyBookListsInputData>("MyBookListsInput");
}

function createMyBookListsResultRef(builder: Builder) {
  return builder.objectRef<BookListSummaryResult>("MyBookListsResult");
}

let BookListRef: BookListObjectRef;
let BookListItemRef: BookListItemObjectRef;
let BookListSummaryRef: BookListSummaryObjectRef;
let BookListDetailRef: BookListDetailObjectRef;
let CreateBookListInputRef: CreateBookListInputRef;
let UpdateBookListInputRef: UpdateBookListInputRef;
let MyBookListsInputRef: MyBookListsInputRef;
let MyBookListsResultRef: MyBookListsResultRef;

export function registerBookListsTypes(builder: Builder): void {
  BookListRef = createBookListRef(builder);
  BookListItemRef = createBookListItemRef(builder);
  BookListSummaryRef = createBookListSummaryRef(builder);
  BookListDetailRef = createBookListDetailRef(builder);
  CreateBookListInputRef = createCreateBookListInputRef(builder);
  UpdateBookListInputRef = createUpdateBookListInputRef(builder);
  MyBookListsInputRef = createMyBookListsInputRef(builder);
  MyBookListsResultRef = createMyBookListsResultRef(builder);

  BookListRef.implement({
    description: "A book list created by a user",
    fields: (t) => ({
      id: t.exposeInt("id", {
        description: "The unique identifier of the book list",
        nullable: false,
      }),
      title: t.exposeString("title", {
        description: "The title of the book list",
        nullable: false,
      }),
      description: t.string({
        nullable: true,
        description: "The description of the book list",
        resolve: (parent) => parent.description,
      }),
      createdAt: t.expose("createdAt", {
        type: "DateTime",
        description: "When the book list was created",
        nullable: false,
      }),
      updatedAt: t.expose("updatedAt", {
        type: "DateTime",
        description: "When the book list was last updated",
        nullable: false,
      }),
    }),
  });

  BookListItemRef.implement({
    description: "An item in a book list",
    fields: (t) => ({
      id: t.exposeInt("id", {
        description: "The unique identifier of the book list item",
        nullable: false,
      }),
      position: t.exposeInt("position", {
        description: "The position of the item in the list",
        nullable: false,
      }),
      addedAt: t.expose("addedAt", {
        type: "DateTime",
        description: "When the book was added to the list",
        nullable: false,
      }),
    }),
  });

  BookListSummaryRef.implement({
    description: "Summary information about a book list",
    fields: (t) => ({
      id: t.exposeInt("id", {
        description: "The unique identifier of the book list",
        nullable: false,
      }),
      title: t.exposeString("title", {
        description: "The title of the book list",
        nullable: false,
      }),
      description: t.string({
        nullable: true,
        description: "The description of the book list",
        resolve: (parent) => parent.description,
      }),
      bookCount: t.exposeInt("bookCount", {
        description: "The number of books in the list",
        nullable: false,
      }),
      coverImages: t.exposeStringList("coverImages", {
        description: "Cover images of books in the list (up to 4)",
        nullable: false,
      }),
      createdAt: t.expose("createdAt", {
        type: "DateTime",
        description: "When the book list was created",
        nullable: false,
      }),
      updatedAt: t.expose("updatedAt", {
        type: "DateTime",
        description: "When the book list was last updated",
        nullable: false,
      }),
    }),
  });

  BookListDetailRef.implement({
    description: "Detailed information about a book list including items",
    fields: (t) => ({
      id: t.exposeInt("id", {
        description: "The unique identifier of the book list",
        nullable: false,
      }),
      title: t.exposeString("title", {
        description: "The title of the book list",
        nullable: false,
      }),
      description: t.string({
        nullable: true,
        description: "The description of the book list",
        resolve: (parent) => parent.description,
      }),
      items: t.field({
        type: [BookListItemRef],
        nullable: false,
        description: "The items in the book list",
        resolve: (parent) => parent.items,
      }),
      createdAt: t.expose("createdAt", {
        type: "DateTime",
        description: "When the book list was created",
        nullable: false,
      }),
      updatedAt: t.expose("updatedAt", {
        type: "DateTime",
        description: "When the book list was last updated",
        nullable: false,
      }),
    }),
  });

  CreateBookListInputRef.implement({
    description: "Input for creating a new book list",
    fields: (t) => ({
      title: t.string({
        required: true,
        description: "The title of the book list",
      }),
      description: t.string({
        required: false,
        description: "The description of the book list",
      }),
    }),
  });

  UpdateBookListInputRef.implement({
    description: "Input for updating an existing book list",
    fields: (t) => ({
      listId: t.int({
        required: true,
        description: "The ID of the book list to update",
      }),
      title: t.string({
        required: false,
        description: "The new title of the book list",
      }),
      description: t.string({
        required: false,
        description: "The new description of the book list",
      }),
    }),
  });

  MyBookListsInputRef.implement({
    description: "Input for querying user's book lists with pagination",
    fields: (t) => ({
      limit: t.int({
        required: false,
        description: "Number of items to return (default: 20)",
      }),
      offset: t.int({
        required: false,
        description: "Number of items to skip (default: 0)",
      }),
    }),
  });

  MyBookListsResultRef.implement({
    description: "Result of user's book lists query with pagination info",
    fields: (t) => ({
      items: t.field({
        type: [BookListSummaryRef],
        nullable: false,
        description: "List of book list summaries",
        resolve: (parent) => parent.items,
      }),
      totalCount: t.exposeInt("totalCount", {
        description: "Total number of book lists",
        nullable: false,
      }),
      hasMore: t.exposeBoolean("hasMore", {
        description: "Whether there are more book lists to fetch",
        nullable: false,
      }),
    }),
  });
}

export function registerBookListsQueries(
  builder: Builder,
  bookListService: BookListService,
  userService: UserService,
): void {
  builder.queryFields((t) => ({
    myBookLists: t.field({
      type: MyBookListsResultRef,
      nullable: false,
      description: "Get all book lists created by the authenticated user",
      authScopes: {
        loggedIn: true,
      },
      args: {
        input: t.arg({
          type: MyBookListsInputRef,
          required: false,
        }),
      },
      resolve: async (
        _parent,
        args,
        context,
      ): Promise<BookListSummaryResult> => {
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

        const input = args.input ?? {};
        const result = await bookListService.getUserBookLists({
          userId: userResult.data.id,
          limit: input.limit ?? undefined,
          offset: input.offset ?? undefined,
        });

        if (!result.success) {
          throw new GraphQLError(result.error.message, {
            extensions: { code: result.error.code },
          });
        }

        return result.data;
      },
    }),
    bookListDetail: t.field({
      type: BookListDetailRef,
      nullable: false,
      description: "Get detailed information about a specific book list",
      authScopes: {
        loggedIn: true,
      },
      args: {
        listId: t.arg.int({ required: true }),
      },
      resolve: async (_parent, args, context): Promise<BookListWithItems> => {
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

        const result = await bookListService.getBookList(
          args.listId,
          userResult.data.id,
        );

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

export function registerBookListsMutations(
  builder: Builder,
  bookListService: BookListService,
  userService: UserService,
): void {
  builder.mutationFields((t) => ({
    createBookList: t.field({
      type: BookListRef,
      nullable: false,
      description: "Create a new book list",
      authScopes: {
        loggedIn: true,
      },
      args: {
        input: t.arg({
          type: CreateBookListInputRef,
          required: true,
        }),
      },
      resolve: async (_parent, args, context): Promise<BookList> => {
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

        const result = await bookListService.createBookList({
          userId: userResult.data.id,
          title: args.input.title,
          description: args.input.description ?? null,
        });

        if (!result.success) {
          throw new GraphQLError(result.error.message, {
            extensions: { code: result.error.code },
          });
        }

        return result.data;
      },
    }),
    updateBookList: t.field({
      type: BookListRef,
      nullable: false,
      description: "Update an existing book list",
      authScopes: {
        loggedIn: true,
      },
      args: {
        input: t.arg({
          type: UpdateBookListInputRef,
          required: true,
        }),
      },
      resolve: async (_parent, args, context): Promise<BookList> => {
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

        const result = await bookListService.updateBookList({
          listId: args.input.listId,
          userId: userResult.data.id,
          title: args.input.title ?? undefined,
          description: args.input.description,
        });

        if (!result.success) {
          throw new GraphQLError(result.error.message, {
            extensions: { code: result.error.code },
          });
        }

        return result.data;
      },
    }),
    deleteBookList: t.field({
      type: "Boolean",
      nullable: false,
      description: "Delete a book list",
      authScopes: {
        loggedIn: true,
      },
      args: {
        listId: t.arg.int({ required: true }),
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

        const result = await bookListService.deleteBookList(
          args.listId,
          userResult.data.id,
        );

        if (!result.success) {
          throw new GraphQLError(result.error.message, {
            extensions: { code: result.error.code },
          });
        }

        return true;
      },
    }),
    addBookToList: t.field({
      type: BookListItemRef,
      nullable: false,
      description: "Add a book to a book list",
      authScopes: {
        loggedIn: true,
      },
      args: {
        listId: t.arg.int({ required: true }),
        userBookId: t.arg.int({ required: true }),
      },
      resolve: async (_parent, args, context): Promise<BookListItem> => {
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

        const result = await bookListService.addBookToList({
          listId: args.listId,
          userId: userResult.data.id,
          userBookId: args.userBookId,
        });

        if (!result.success) {
          throw new GraphQLError(result.error.message, {
            extensions: { code: result.error.code },
          });
        }

        return result.data;
      },
    }),
    removeBookFromList: t.field({
      type: "Boolean",
      nullable: false,
      description: "Remove a book from a book list",
      authScopes: {
        loggedIn: true,
      },
      args: {
        listId: t.arg.int({ required: true }),
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

        const result = await bookListService.removeBookFromList({
          listId: args.listId,
          userId: userResult.data.id,
          userBookId: args.userBookId,
        });

        if (!result.success) {
          throw new GraphQLError(result.error.message, {
            extensions: { code: result.error.code },
          });
        }

        return true;
      },
    }),
    reorderBookInList: t.field({
      type: "Boolean",
      nullable: false,
      description: "Reorder a book within a book list",
      authScopes: {
        loggedIn: true,
      },
      args: {
        listId: t.arg.int({ required: true }),
        itemId: t.arg.int({ required: true }),
        newPosition: t.arg.int({ required: true }),
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

        const result = await bookListService.reorderBookInList({
          listId: args.listId,
          userId: userResult.data.id,
          itemId: args.itemId,
          newPosition: args.newPosition,
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
