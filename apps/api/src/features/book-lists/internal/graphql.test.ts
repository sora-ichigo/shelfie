import type {
  GraphQLInputObjectType,
  GraphQLObjectType,
  GraphQLSchema,
} from "graphql";
import { beforeAll, beforeEach, describe, expect, it, vi } from "vitest";
import { err, ok } from "../../../errors/result.js";
import { createTestBuilder } from "../../../graphql/builder.js";
import type { UserService } from "../../users/index.js";
import {
  registerBookListsMutations,
  registerBookListsQueries,
  registerBookListsTypes,
} from "./graphql.js";
import type { BookList } from "./repository.js";
import type {
  BookListDetailItem,
  BookListService,
  BookListSummary,
  BookListWithItems,
} from "./service.js";

function createMockBookListService(): BookListService {
  return {
    createBookList: vi.fn(),
    getBookList: vi.fn(),
    getUserBookLists: vi.fn(),
    updateBookList: vi.fn(),
    deleteBookList: vi.fn(),
    addBookToList: vi.fn(),
    removeBookFromList: vi.fn(),
    reorderBookInList: vi.fn(),
  };
}

function createMockBookShelfRepository() {
  return {
    findUserBookById: vi.fn().mockResolvedValue(null),
  };
}

function createMockUserService(): UserService {
  return {
    getUserById: vi.fn(),
    createUser: vi.fn(),
    getUsers: vi.fn(),
    getUserByFirebaseUid: vi.fn(),
    createUserWithFirebase: vi.fn(),
    updateProfile: vi.fn(),
    deleteAccount: vi.fn(),
  };
}

function createAuthenticatedContext(firebaseUid: string = "test-firebase-uid") {
  return {
    requestId: "test",
    user: {
      uid: firebaseUid,
      email: "test@example.com",
      emailVerified: true,
    },
  };
}

function createUnauthenticatedContext() {
  return {
    requestId: "test",
    user: null,
  };
}

describe("BookLists GraphQL", () => {
  describe("Types", () => {
    let schema: GraphQLSchema;

    beforeAll(() => {
      const builder = createTestBuilder();
      registerBookListsTypes(builder, createMockBookShelfRepository());

      builder.queryType({
        fields: (t) => ({
          _dummy: t.string({ resolve: () => "ok" }),
        }),
      });

      schema = builder.toSchema();
    });

    it("BookList type should have required fields", () => {
      const bookListType = schema.getType("BookList") as GraphQLObjectType;
      expect(bookListType).toBeDefined();

      const fields = bookListType.getFields();
      expect(fields.id).toBeDefined();
      expect(fields.id.type.toString()).toBe("Int!");
      expect(fields.title).toBeDefined();
      expect(fields.title.type.toString()).toBe("String!");
      expect(fields.description).toBeDefined();
      expect(fields.createdAt).toBeDefined();
      expect(fields.updatedAt).toBeDefined();
    });

    it("BookListDetailItem type should have required fields", () => {
      const bookListItemType = schema.getType(
        "BookListDetailItem",
      ) as GraphQLObjectType;
      expect(bookListItemType).toBeDefined();

      const fields = bookListItemType.getFields();
      expect(fields.id).toBeDefined();
      expect(fields.id.type.toString()).toBe("Int!");
      expect(fields.position).toBeDefined();
      expect(fields.position.type.toString()).toBe("Int!");
      expect(fields.addedAt).toBeDefined();
      expect(fields.userBook).toBeDefined();
    });

    it("BookListSummary type should have required fields", () => {
      const bookListSummaryType = schema.getType(
        "BookListSummary",
      ) as GraphQLObjectType;
      expect(bookListSummaryType).toBeDefined();

      const fields = bookListSummaryType.getFields();
      expect(fields.id).toBeDefined();
      expect(fields.title).toBeDefined();
      expect(fields.description).toBeDefined();
      expect(fields.bookCount).toBeDefined();
      expect(fields.bookCount.type.toString()).toBe("Int!");
      expect(fields.coverImages).toBeDefined();
      expect(fields.coverImages.type.toString()).toBe("[String!]!");
    });

    it("BookListDetail type should have required fields", () => {
      const bookListDetailType = schema.getType(
        "BookListDetail",
      ) as GraphQLObjectType;
      expect(bookListDetailType).toBeDefined();

      const fields = bookListDetailType.getFields();
      expect(fields.id).toBeDefined();
      expect(fields.title).toBeDefined();
      expect(fields.description).toBeDefined();
      expect(fields.items).toBeDefined();
      expect(fields.items.type.toString()).toBe("[BookListDetailItem!]!");
    });

    it("CreateBookListInput input type should have required fields", () => {
      const inputType = schema.getType(
        "CreateBookListInput",
      ) as GraphQLInputObjectType;
      expect(inputType).toBeDefined();

      const fields = inputType.getFields();
      expect(fields.title).toBeDefined();
      expect(fields.title.type.toString()).toBe("String!");
      expect(fields.description).toBeDefined();
    });

    it("UpdateBookListInput input type should have required fields", () => {
      const inputType = schema.getType(
        "UpdateBookListInput",
      ) as GraphQLInputObjectType;
      expect(inputType).toBeDefined();

      const fields = inputType.getFields();
      expect(fields.listId).toBeDefined();
      expect(fields.listId.type.toString()).toBe("Int!");
      expect(fields.title).toBeDefined();
      expect(fields.description).toBeDefined();
    });

    it("MyBookListsInput input type should have required fields", () => {
      const inputType = schema.getType(
        "MyBookListsInput",
      ) as GraphQLInputObjectType;
      expect(inputType).toBeDefined();

      const fields = inputType.getFields();
      expect(fields.limit).toBeDefined();
      expect(fields.offset).toBeDefined();
    });

    it("MyBookListsResult type should have required fields", () => {
      const resultType = schema.getType(
        "MyBookListsResult",
      ) as GraphQLObjectType;
      expect(resultType).toBeDefined();

      const fields = resultType.getFields();
      expect(fields.items).toBeDefined();
      expect(fields.totalCount).toBeDefined();
      expect(fields.totalCount.type.toString()).toBe("Int!");
      expect(fields.hasMore).toBeDefined();
      expect(fields.hasMore.type.toString()).toBe("Boolean!");
    });
  });

  describe("Queries", () => {
    let bookListService: BookListService;
    let userService: UserService;

    beforeEach(() => {
      bookListService = createMockBookListService();
      userService = createMockUserService();
    });

    function buildSchemaWithQueries() {
      const builder = createTestBuilder();
      registerBookListsTypes(builder, createMockBookShelfRepository());

      builder.queryType({});
      registerBookListsQueries(builder, bookListService, userService);

      return builder.toSchema();
    }

    describe("myBookLists", () => {
      it("should return user's book lists when authenticated", async () => {
        const schema = buildSchemaWithQueries();
        const mockSummaries: BookListSummary[] = [
          {
            id: 1,
            title: "My Reading List",
            description: "Books I want to read",
            bookCount: 5,
            coverImages: ["http://example.com/cover1.jpg"],
            createdAt: new Date("2026-01-01"),
            updatedAt: new Date("2026-01-01"),
          },
        ];

        vi.mocked(userService.getUserByFirebaseUid).mockResolvedValue(
          ok({
            id: 1,
            firebaseUid: "test-firebase-uid",
            email: "test@example.com",
            name: null,
            avatarUrl: null,
            bio: null,
            instagramHandle: null,
            handle: null,
            createdAt: new Date(),
            updatedAt: new Date(),
          }),
        );
        vi.mocked(bookListService.getUserBookLists).mockResolvedValue(
          ok({ items: mockSummaries, totalCount: 1, hasMore: false }),
        );

        const queryType = schema.getQueryType();
        const myBookListsField = queryType?.getFields().myBookLists;

        const result = await myBookListsField?.resolve?.(
          {},
          {},
          createAuthenticatedContext(),
          {} as never,
        );

        expect(result).toMatchObject({
          items: mockSummaries,
          totalCount: 1,
          hasMore: false,
        });
      });

      it("should return error when not authenticated", async () => {
        const schema = buildSchemaWithQueries();

        const queryType = schema.getQueryType();
        const myBookListsField = queryType?.getFields().myBookLists;

        let error: Error | null = null;
        try {
          await myBookListsField?.resolve?.(
            {},
            {},
            createUnauthenticatedContext(),
            {} as never,
          );
        } catch (e) {
          error = e as Error;
        }

        expect(error).toBeDefined();
        expect(error?.message).toContain("Not authorized");
      });

      it("should accept pagination input", async () => {
        const schema = buildSchemaWithQueries();

        vi.mocked(userService.getUserByFirebaseUid).mockResolvedValue(
          ok({
            id: 1,
            firebaseUid: "test-firebase-uid",
            email: "test@example.com",
            name: null,
            avatarUrl: null,
            bio: null,
            instagramHandle: null,
            handle: null,
            createdAt: new Date(),
            updatedAt: new Date(),
          }),
        );
        vi.mocked(bookListService.getUserBookLists).mockResolvedValue(
          ok({ items: [], totalCount: 0, hasMore: false }),
        );

        const queryType = schema.getQueryType();
        const myBookListsField = queryType?.getFields().myBookLists;

        await myBookListsField?.resolve?.(
          {},
          { input: { limit: 10, offset: 5 } },
          createAuthenticatedContext(),
          {} as never,
        );

        expect(bookListService.getUserBookLists).toHaveBeenCalledWith({
          userId: 1,
          limit: 10,
          offset: 5,
        });
      });
    });

    describe("bookListDetail", () => {
      it("should return book list detail when authenticated and owner", async () => {
        const schema = buildSchemaWithQueries();
        const mockDetail: BookListWithItems = {
          id: 1,
          userId: 1,
          title: "My Reading List",
          description: "Books I want to read",
          createdAt: new Date("2026-01-01"),
          updatedAt: new Date("2026-01-01"),
          items: [
            {
              id: 1,
              userBookId: 10,
              position: 0,
              addedAt: new Date("2026-01-01"),
            },
          ],
          stats: {
            bookCount: 1,
            completedCount: 0,
            coverImages: [],
          },
        };

        vi.mocked(userService.getUserByFirebaseUid).mockResolvedValue(
          ok({
            id: 1,
            firebaseUid: "test-firebase-uid",
            email: "test@example.com",
            name: null,
            avatarUrl: null,
            bio: null,
            instagramHandle: null,
            handle: null,
            createdAt: new Date(),
            updatedAt: new Date(),
          }),
        );
        vi.mocked(bookListService.getBookList).mockResolvedValue(
          ok(mockDetail),
        );

        const queryType = schema.getQueryType();
        const bookListDetailField = queryType?.getFields().bookListDetail;

        const result = await bookListDetailField?.resolve?.(
          {},
          { listId: 1 },
          createAuthenticatedContext(),
          {} as never,
        );

        expect(result).toMatchObject({
          id: 1,
          title: "My Reading List",
          items: expect.arrayContaining([
            expect.objectContaining({ id: 1, position: 0 }),
          ]),
        });
      });

      it("should return error when list not found", async () => {
        const schema = buildSchemaWithQueries();

        vi.mocked(userService.getUserByFirebaseUid).mockResolvedValue(
          ok({
            id: 1,
            firebaseUid: "test-firebase-uid",
            email: "test@example.com",
            name: null,
            avatarUrl: null,
            bio: null,
            instagramHandle: null,
            handle: null,
            createdAt: new Date(),
            updatedAt: new Date(),
          }),
        );
        vi.mocked(bookListService.getBookList).mockResolvedValue(
          err({ code: "LIST_NOT_FOUND", message: "Book list not found" }),
        );

        const queryType = schema.getQueryType();
        const bookListDetailField = queryType?.getFields().bookListDetail;

        await expect(
          bookListDetailField?.resolve?.(
            {},
            { listId: 999 },
            createAuthenticatedContext(),
            {} as never,
          ),
        ).rejects.toThrow("Book list not found");
      });

      it("should return error when accessing others list (FORBIDDEN)", async () => {
        const schema = buildSchemaWithQueries();

        vi.mocked(userService.getUserByFirebaseUid).mockResolvedValue(
          ok({
            id: 2,
            firebaseUid: "test-firebase-uid",
            email: "test@example.com",
            name: null,
            avatarUrl: null,
            bio: null,
            instagramHandle: null,
            handle: null,
            createdAt: new Date(),
            updatedAt: new Date(),
          }),
        );
        vi.mocked(bookListService.getBookList).mockResolvedValue(
          err({
            code: "FORBIDDEN",
            message: "You are not allowed to access this book list",
          }),
        );

        const queryType = schema.getQueryType();
        const bookListDetailField = queryType?.getFields().bookListDetail;

        await expect(
          bookListDetailField?.resolve?.(
            {},
            { listId: 1 },
            createAuthenticatedContext(),
            {} as never,
          ),
        ).rejects.toThrow("You are not allowed to access this book list");
      });
    });
  });

  describe("Mutations", () => {
    let bookListService: BookListService;
    let userService: UserService;

    beforeEach(() => {
      bookListService = createMockBookListService();
      userService = createMockUserService();
    });

    function buildSchemaWithMutations() {
      const builder = createTestBuilder();
      registerBookListsTypes(builder, createMockBookShelfRepository());

      builder.queryType({
        fields: (t) => ({
          _dummy: t.string({ resolve: () => "ok" }),
        }),
      });

      builder.mutationType({});
      registerBookListsMutations(builder, bookListService, userService);

      return builder.toSchema();
    }

    describe("createBookList", () => {
      it("should create a new book list when authenticated", async () => {
        const schema = buildSchemaWithMutations();
        const mockBookList: BookList = {
          id: 1,
          userId: 1,
          title: "New Reading List",
          description: "My new list",
          createdAt: new Date("2026-01-01"),
          updatedAt: new Date("2026-01-01"),
        };

        vi.mocked(userService.getUserByFirebaseUid).mockResolvedValue(
          ok({
            id: 1,
            firebaseUid: "test-firebase-uid",
            email: "test@example.com",
            name: null,
            avatarUrl: null,
            bio: null,
            instagramHandle: null,
            handle: null,
            createdAt: new Date(),
            updatedAt: new Date(),
          }),
        );
        vi.mocked(bookListService.createBookList).mockResolvedValue(
          ok(mockBookList),
        );

        const mutationType = schema.getMutationType();
        const createBookListField = mutationType?.getFields().createBookList;

        const result = await createBookListField?.resolve?.(
          {},
          { input: { title: "New Reading List", description: "My new list" } },
          createAuthenticatedContext(),
          {} as never,
        );

        expect(result).toMatchObject({
          id: 1,
          title: "New Reading List",
        });
        expect(bookListService.createBookList).toHaveBeenCalledWith({
          userId: 1,
          title: "New Reading List",
          description: "My new list",
        });
      });

      it("should return validation error when title is empty", async () => {
        const schema = buildSchemaWithMutations();

        vi.mocked(userService.getUserByFirebaseUid).mockResolvedValue(
          ok({
            id: 1,
            firebaseUid: "test-firebase-uid",
            email: "test@example.com",
            name: null,
            avatarUrl: null,
            bio: null,
            instagramHandle: null,
            handle: null,
            createdAt: new Date(),
            updatedAt: new Date(),
          }),
        );
        vi.mocked(bookListService.createBookList).mockResolvedValue(
          err({ code: "VALIDATION_ERROR", message: "Title is required" }),
        );

        const mutationType = schema.getMutationType();
        const createBookListField = mutationType?.getFields().createBookList;

        await expect(
          createBookListField?.resolve?.(
            {},
            { input: { title: "" } },
            createAuthenticatedContext(),
            {} as never,
          ),
        ).rejects.toThrow("Title is required");
      });
    });

    describe("updateBookList", () => {
      it("should update a book list when authenticated and owner", async () => {
        const schema = buildSchemaWithMutations();
        const mockBookList: BookList = {
          id: 1,
          userId: 1,
          title: "Updated List",
          description: "Updated description",
          createdAt: new Date("2026-01-01"),
          updatedAt: new Date("2026-01-02"),
        };

        vi.mocked(userService.getUserByFirebaseUid).mockResolvedValue(
          ok({
            id: 1,
            firebaseUid: "test-firebase-uid",
            email: "test@example.com",
            name: null,
            avatarUrl: null,
            bio: null,
            instagramHandle: null,
            handle: null,
            createdAt: new Date(),
            updatedAt: new Date(),
          }),
        );
        vi.mocked(bookListService.updateBookList).mockResolvedValue(
          ok(mockBookList),
        );

        const mutationType = schema.getMutationType();
        const updateBookListField = mutationType?.getFields().updateBookList;

        const result = await updateBookListField?.resolve?.(
          {},
          {
            input: {
              listId: 1,
              title: "Updated List",
              description: "Updated description",
            },
          },
          createAuthenticatedContext(),
          {} as never,
        );

        expect(result).toMatchObject({
          id: 1,
          title: "Updated List",
        });
      });
    });

    describe("deleteBookList", () => {
      it("should delete a book list when authenticated and owner", async () => {
        const schema = buildSchemaWithMutations();

        vi.mocked(userService.getUserByFirebaseUid).mockResolvedValue(
          ok({
            id: 1,
            firebaseUid: "test-firebase-uid",
            email: "test@example.com",
            name: null,
            avatarUrl: null,
            bio: null,
            instagramHandle: null,
            handle: null,
            createdAt: new Date(),
            updatedAt: new Date(),
          }),
        );
        vi.mocked(bookListService.deleteBookList).mockResolvedValue(
          ok(undefined),
        );

        const mutationType = schema.getMutationType();
        const deleteBookListField = mutationType?.getFields().deleteBookList;

        const result = await deleteBookListField?.resolve?.(
          {},
          { listId: 1 },
          createAuthenticatedContext(),
          {} as never,
        );

        expect(result).toBe(true);
      });
    });

    describe("addBookToList", () => {
      it("should add a book to a list when authenticated and owner", async () => {
        const schema = buildSchemaWithMutations();
        const mockItem: BookListDetailItem = {
          id: 1,
          userBookId: 10,
          position: 0,
          addedAt: new Date("2026-01-01"),
        };

        vi.mocked(userService.getUserByFirebaseUid).mockResolvedValue(
          ok({
            id: 1,
            firebaseUid: "test-firebase-uid",
            email: "test@example.com",
            name: null,
            avatarUrl: null,
            bio: null,
            instagramHandle: null,
            handle: null,
            createdAt: new Date(),
            updatedAt: new Date(),
          }),
        );
        vi.mocked(bookListService.addBookToList).mockResolvedValue(
          ok(mockItem),
        );

        const mutationType = schema.getMutationType();
        const addBookToListField = mutationType?.getFields().addBookToList;

        const result = await addBookToListField?.resolve?.(
          {},
          { listId: 1, userBookId: 10 },
          createAuthenticatedContext(),
          {} as never,
        );

        expect(result).toMatchObject({
          id: 1,
          position: 0,
        });
      });

      it("should return error when book is already in list (DUPLICATE_BOOK)", async () => {
        const schema = buildSchemaWithMutations();

        vi.mocked(userService.getUserByFirebaseUid).mockResolvedValue(
          ok({
            id: 1,
            firebaseUid: "test-firebase-uid",
            email: "test@example.com",
            name: null,
            avatarUrl: null,
            bio: null,
            instagramHandle: null,
            handle: null,
            createdAt: new Date(),
            updatedAt: new Date(),
          }),
        );
        vi.mocked(bookListService.addBookToList).mockResolvedValue(
          err({
            code: "DUPLICATE_BOOK",
            message: "This book is already in the list",
          }),
        );

        const mutationType = schema.getMutationType();
        const addBookToListField = mutationType?.getFields().addBookToList;

        await expect(
          addBookToListField?.resolve?.(
            {},
            { listId: 1, userBookId: 10 },
            createAuthenticatedContext(),
            {} as never,
          ),
        ).rejects.toThrow("This book is already in the list");
      });
    });

    describe("removeBookFromList", () => {
      it("should remove a book from a list when authenticated and owner", async () => {
        const schema = buildSchemaWithMutations();

        vi.mocked(userService.getUserByFirebaseUid).mockResolvedValue(
          ok({
            id: 1,
            firebaseUid: "test-firebase-uid",
            email: "test@example.com",
            name: null,
            avatarUrl: null,
            bio: null,
            instagramHandle: null,
            handle: null,
            createdAt: new Date(),
            updatedAt: new Date(),
          }),
        );
        vi.mocked(bookListService.removeBookFromList).mockResolvedValue(
          ok(undefined),
        );

        const mutationType = schema.getMutationType();
        const removeBookFromListField =
          mutationType?.getFields().removeBookFromList;

        const result = await removeBookFromListField?.resolve?.(
          {},
          { listId: 1, userBookId: 10 },
          createAuthenticatedContext(),
          {} as never,
        );

        expect(result).toBe(true);
      });

      it("should return error when book is not in list (BOOK_NOT_IN_LIST)", async () => {
        const schema = buildSchemaWithMutations();

        vi.mocked(userService.getUserByFirebaseUid).mockResolvedValue(
          ok({
            id: 1,
            firebaseUid: "test-firebase-uid",
            email: "test@example.com",
            name: null,
            avatarUrl: null,
            bio: null,
            instagramHandle: null,
            handle: null,
            createdAt: new Date(),
            updatedAt: new Date(),
          }),
        );
        vi.mocked(bookListService.removeBookFromList).mockResolvedValue(
          err({
            code: "BOOK_NOT_IN_LIST",
            message: "This book is not in the list",
          }),
        );

        const mutationType = schema.getMutationType();
        const removeBookFromListField =
          mutationType?.getFields().removeBookFromList;

        await expect(
          removeBookFromListField?.resolve?.(
            {},
            { listId: 1, userBookId: 999 },
            createAuthenticatedContext(),
            {} as never,
          ),
        ).rejects.toThrow("This book is not in the list");
      });
    });

    describe("reorderBookInList", () => {
      it("should reorder a book in a list when authenticated and owner", async () => {
        const schema = buildSchemaWithMutations();

        vi.mocked(userService.getUserByFirebaseUid).mockResolvedValue(
          ok({
            id: 1,
            firebaseUid: "test-firebase-uid",
            email: "test@example.com",
            name: null,
            avatarUrl: null,
            bio: null,
            instagramHandle: null,
            handle: null,
            createdAt: new Date(),
            updatedAt: new Date(),
          }),
        );
        vi.mocked(bookListService.reorderBookInList).mockResolvedValue(
          ok(undefined),
        );

        const mutationType = schema.getMutationType();
        const reorderBookInListField =
          mutationType?.getFields().reorderBookInList;

        const result = await reorderBookInListField?.resolve?.(
          {},
          { listId: 1, itemId: 1, newPosition: 2 },
          createAuthenticatedContext(),
          {} as never,
        );

        expect(result).toBe(true);
      });
    });
  });
});
