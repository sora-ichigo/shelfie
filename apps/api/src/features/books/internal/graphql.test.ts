import type {
  GraphQLInputObjectType,
  GraphQLObjectType,
  GraphQLSchema,
} from "graphql";
import { beforeAll, describe, expect, it, vi } from "vitest";
import { err, ok } from "../../../errors/result.js";
import { createTestBuilder } from "../../../graphql/builder.js";
import type { UserService } from "../../users/index.js";
import type { BookSearchService } from "./book-search-service.js";
import type { BookShelfService } from "./book-shelf-service.js";
import {
  registerBooksMutations,
  registerBooksQueries,
  registerBooksTypes,
} from "./graphql.js";

function createMockSearchService(): BookSearchService {
  return {
    searchBooks: vi.fn(),
    searchBookByISBN: vi.fn(),
  };
}

function createMockShelfService(): BookShelfService {
  return {
    addBookToShelf: vi.fn(),
  };
}

function createMockUserService(): UserService {
  return {
    getUserById: vi.fn(),
    createUser: vi.fn(),
    getUsers: vi.fn(),
    getUserByFirebaseUid: vi.fn(),
    createUserWithFirebase: vi.fn(),
  };
}

describe("BooksGraphQL Types", () => {
  let schema: GraphQLSchema;

  beforeAll(() => {
    const builder = createTestBuilder();
    registerBooksTypes(builder);

    builder.queryType({
      fields: (t) => ({
        _dummy: t.string({ resolve: () => "ok" }),
      }),
    });

    schema = builder.toSchema();
  });

  describe("Book type", () => {
    it("should define Book type with all required fields", () => {
      const bookType = schema.getType("Book") as GraphQLObjectType;

      expect(bookType).toBeDefined();
      const fields = bookType.getFields();

      expect(fields.id).toBeDefined();
      expect(fields.id.type.toString()).toBe("String!");

      expect(fields.title).toBeDefined();
      expect(fields.title.type.toString()).toBe("String!");

      expect(fields.authors).toBeDefined();
      expect(fields.authors.type.toString()).toBe("[String!]!");

      expect(fields.publisher).toBeDefined();
      expect(fields.publisher.type.toString()).toBe("String");

      expect(fields.publishedDate).toBeDefined();
      expect(fields.publishedDate.type.toString()).toBe("String");

      expect(fields.isbn).toBeDefined();
      expect(fields.isbn.type.toString()).toBe("String");

      expect(fields.coverImageUrl).toBeDefined();
      expect(fields.coverImageUrl.type.toString()).toBe("String");
    });
  });

  describe("SearchBooksResult type", () => {
    it("should define SearchBooksResult type with items, totalCount, and hasMore", () => {
      const resultType = schema.getType(
        "SearchBooksResult",
      ) as GraphQLObjectType;

      expect(resultType).toBeDefined();
      const fields = resultType.getFields();

      expect(fields.items).toBeDefined();
      expect(fields.items.type.toString()).toBe("[Book!]!");

      expect(fields.totalCount).toBeDefined();
      expect(fields.totalCount.type.toString()).toBe("Int!");

      expect(fields.hasMore).toBeDefined();
      expect(fields.hasMore.type.toString()).toBe("Boolean!");
    });
  });

  describe("AddBookInput type", () => {
    it("should define AddBookInput input type with all fields", () => {
      const inputType = schema.getType(
        "AddBookInput",
      ) as GraphQLInputObjectType;

      expect(inputType).toBeDefined();
      const fields = inputType.getFields();

      expect(fields.externalId).toBeDefined();
      expect(fields.externalId.type.toString()).toBe("String!");

      expect(fields.title).toBeDefined();
      expect(fields.title.type.toString()).toBe("String!");

      expect(fields.authors).toBeDefined();
      expect(fields.authors.type.toString()).toBe("[String!]!");

      expect(fields.publisher).toBeDefined();
      expect(fields.publisher.type.toString()).toBe("String");

      expect(fields.publishedDate).toBeDefined();
      expect(fields.publishedDate.type.toString()).toBe("String");

      expect(fields.isbn).toBeDefined();
      expect(fields.isbn.type.toString()).toBe("String");

      expect(fields.coverImageUrl).toBeDefined();
      expect(fields.coverImageUrl.type.toString()).toBe("String");
    });
  });

  describe("UserBook type", () => {
    it("should define UserBook type with all required fields", () => {
      const userBookType = schema.getType("UserBook") as GraphQLObjectType;

      expect(userBookType).toBeDefined();
      const fields = userBookType.getFields();

      expect(fields.id).toBeDefined();
      expect(fields.id.type.toString()).toBe("Int!");

      expect(fields.externalId).toBeDefined();
      expect(fields.externalId.type.toString()).toBe("String!");

      expect(fields.title).toBeDefined();
      expect(fields.title.type.toString()).toBe("String!");

      expect(fields.authors).toBeDefined();
      expect(fields.authors.type.toString()).toBe("[String!]!");

      expect(fields.publisher).toBeDefined();
      expect(fields.publisher.type.toString()).toBe("String");

      expect(fields.publishedDate).toBeDefined();
      expect(fields.publishedDate.type.toString()).toBe("String");

      expect(fields.isbn).toBeDefined();
      expect(fields.isbn.type.toString()).toBe("String");

      expect(fields.coverImageUrl).toBeDefined();
      expect(fields.coverImageUrl.type.toString()).toBe("String");

      expect(fields.addedAt).toBeDefined();
      expect(fields.addedAt.type.toString()).toBe("DateTime!");
    });
  });
});

describe("BooksGraphQL Queries Schema", () => {
  const createSchemaWithQueries = (searchService: BookSearchService) => {
    const builder = createTestBuilder();
    registerBooksTypes(builder);

    builder.queryType({});
    registerBooksQueries(builder, searchService);

    return builder.toSchema();
  };

  it("should define searchBooks query with correct parameters", () => {
    const mockSearchService = createMockSearchService();
    const schema = createSchemaWithQueries(mockSearchService);
    const queryType = schema.getQueryType();

    expect(queryType).toBeDefined();
    const fields = queryType?.getFields();
    expect(fields?.searchBooks).toBeDefined();

    const searchBooksField = fields?.searchBooks;
    expect(searchBooksField?.type.toString()).toContain("SearchBooksResult");

    const args = searchBooksField?.args;
    expect(args?.find((a) => a.name === "query")?.type.toString()).toBe(
      "String!",
    );
    expect(args?.find((a) => a.name === "limit")?.type.toString()).toBe("Int");
    expect(args?.find((a) => a.name === "offset")?.type.toString()).toBe("Int");
  });

  it("should define searchBookByISBN query with isbn parameter", () => {
    const mockSearchService = createMockSearchService();
    const schema = createSchemaWithQueries(mockSearchService);
    const queryType = schema.getQueryType();

    expect(queryType).toBeDefined();
    const fields = queryType?.getFields();
    expect(fields?.searchBookByISBN).toBeDefined();

    const searchByISBNField = fields?.searchBookByISBN;
    expect(searchByISBNField?.type.toString()).toBe("Book");

    const args = searchByISBNField?.args;
    expect(args?.find((a) => a.name === "isbn")?.type.toString()).toBe(
      "String!",
    );
  });
});

describe("BooksGraphQL Mutations Schema", () => {
  const createSchemaWithMutations = (
    searchService: BookSearchService,
    shelfService: BookShelfService,
    userService: UserService,
  ) => {
    const builder = createTestBuilder();
    registerBooksTypes(builder);

    builder.queryType({});
    registerBooksQueries(builder, searchService);

    builder.mutationType({});
    registerBooksMutations(builder, shelfService, userService);

    return builder.toSchema();
  };

  it("should define addBookToShelf mutation with bookInput parameter", () => {
    const mockSearchService = createMockSearchService();
    const mockShelfService = createMockShelfService();
    const mockUserService = createMockUserService();
    const schema = createSchemaWithMutations(
      mockSearchService,
      mockShelfService,
      mockUserService,
    );
    const mutationType = schema.getMutationType();

    expect(mutationType).toBeDefined();
    const fields = mutationType?.getFields();
    expect(fields?.addBookToShelf).toBeDefined();

    const addBookField = fields?.addBookToShelf;
    expect(addBookField?.type.toString()).toContain("UserBook");

    const args = addBookField?.args;
    expect(args?.find((a) => a.name === "bookInput")?.type.toString()).toBe(
      "AddBookInput!",
    );
  });
});

describe("BooksGraphQL Resolver Behavior", () => {
  describe("searchBooks resolver", () => {
    it("should call searchService.searchBooks with correct parameters", async () => {
      const mockSearchService = createMockSearchService();
      const mockResult = {
        items: [
          {
            id: "book-1",
            title: "Test Book",
            authors: ["Author"],
            publisher: null,
            publishedDate: null,
            isbn: null,
            coverImageUrl: null,
          },
        ],
        totalCount: 1,
        hasMore: false,
      };
      vi.mocked(mockSearchService.searchBooks).mockResolvedValue(
        ok(mockResult),
      );

      const builder = createTestBuilder();
      registerBooksTypes(builder);
      builder.queryType({});
      registerBooksQueries(builder, mockSearchService);

      const schema = builder.toSchema();
      const queryType = schema.getQueryType();
      const searchBooksField = queryType?.getFields().searchBooks;

      const result = await searchBooksField?.resolve?.(
        {},
        { query: "test", limit: 10, offset: 0 },
        { requestId: "test", user: null },
        {} as never,
      );

      expect(mockSearchService.searchBooks).toHaveBeenCalledWith({
        query: "test",
        limit: 10,
        offset: 0,
      });
      expect(result).toEqual(mockResult);
    });

    it("should throw error when searchService returns error", async () => {
      const mockSearchService = createMockSearchService();
      vi.mocked(mockSearchService.searchBooks).mockResolvedValue(
        err({
          code: "VALIDATION_ERROR",
          message: "Search query cannot be empty",
        }),
      );

      const builder = createTestBuilder();
      registerBooksTypes(builder);
      builder.queryType({});
      registerBooksQueries(builder, mockSearchService);

      const schema = builder.toSchema();
      const queryType = schema.getQueryType();
      const searchBooksField = queryType?.getFields().searchBooks;

      await expect(
        searchBooksField?.resolve?.(
          {},
          { query: "", limit: 10, offset: 0 },
          { requestId: "test", user: null },
          {} as never,
        ),
      ).rejects.toThrow("Search query cannot be empty");
    });
  });

  describe("searchBookByISBN resolver", () => {
    it("should call searchService.searchBookByISBN with isbn", async () => {
      const mockSearchService = createMockSearchService();
      const mockBook = {
        id: "isbn-book",
        title: "ISBN Book",
        authors: ["Author"],
        publisher: null,
        publishedDate: null,
        isbn: "9781234567890",
        coverImageUrl: null,
      };
      vi.mocked(mockSearchService.searchBookByISBN).mockResolvedValue(
        ok(mockBook),
      );

      const builder = createTestBuilder();
      registerBooksTypes(builder);
      builder.queryType({});
      registerBooksQueries(builder, mockSearchService);

      const schema = builder.toSchema();
      const queryType = schema.getQueryType();
      const searchByISBNField = queryType?.getFields().searchBookByISBN;

      const result = await searchByISBNField?.resolve?.(
        {},
        { isbn: "9781234567890" },
        { requestId: "test", user: null },
        {} as never,
      );

      expect(mockSearchService.searchBookByISBN).toHaveBeenCalledWith({
        isbn: "9781234567890",
      });
      expect(result).toEqual(mockBook);
    });

    it("should return null when book not found", async () => {
      const mockSearchService = createMockSearchService();
      vi.mocked(mockSearchService.searchBookByISBN).mockResolvedValue(ok(null));

      const builder = createTestBuilder();
      registerBooksTypes(builder);
      builder.queryType({});
      registerBooksQueries(builder, mockSearchService);

      const schema = builder.toSchema();
      const queryType = schema.getQueryType();
      const searchByISBNField = queryType?.getFields().searchBookByISBN;

      const result = await searchByISBNField?.resolve?.(
        {},
        { isbn: "0000000000" },
        { requestId: "test", user: null },
        {} as never,
      );

      expect(result).toBeNull();
    });

    it("should throw error when searchService returns validation error", async () => {
      const mockSearchService = createMockSearchService();
      vi.mocked(mockSearchService.searchBookByISBN).mockResolvedValue(
        err({
          code: "VALIDATION_ERROR",
          message: "ISBN must be 10 or 13 digits",
        }),
      );

      const builder = createTestBuilder();
      registerBooksTypes(builder);
      builder.queryType({});
      registerBooksQueries(builder, mockSearchService);

      const schema = builder.toSchema();
      const queryType = schema.getQueryType();
      const searchByISBNField = queryType?.getFields().searchBookByISBN;

      await expect(
        searchByISBNField?.resolve?.(
          {},
          { isbn: "invalid" },
          { requestId: "test", user: null },
          {} as never,
        ),
      ).rejects.toThrow("ISBN must be 10 or 13 digits");
    });
  });

  describe("addBookToShelf resolver", () => {
    it("should call shelfService.addBookToShelf with correct input when authenticated", async () => {
      const mockSearchService = createMockSearchService();
      const mockShelfService = createMockShelfService();
      const mockUserService = createMockUserService();
      const mockUserBook = {
        id: 1,
        userId: 100,
        externalId: "book-123",
        title: "Test Book",
        authors: ["Author"],
        publisher: null,
        publishedDate: null,
        isbn: null,
        coverImageUrl: null,
        addedAt: new Date(),
      };
      vi.mocked(mockShelfService.addBookToShelf).mockResolvedValue(
        ok(mockUserBook),
      );
      vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue(
        ok({
          id: 100,
          email: "test@example.com",
          firebaseUid: "firebase-uid",
          createdAt: new Date(),
          updatedAt: new Date(),
        }),
      );

      const builder = createTestBuilder();
      registerBooksTypes(builder);
      builder.queryType({});
      registerBooksQueries(builder, mockSearchService);
      builder.mutationType({});
      registerBooksMutations(builder, mockShelfService, mockUserService);

      const schema = builder.toSchema();
      const mutationType = schema.getMutationType();
      const addBookField = mutationType?.getFields().addBookToShelf;

      const authenticatedContext = {
        requestId: "test",
        user: {
          uid: "firebase-uid",
          email: "test@example.com",
          emailVerified: true,
        },
      };

      const bookInput = {
        externalId: "book-123",
        title: "Test Book",
        authors: ["Author"],
        publisher: null,
        publishedDate: null,
        isbn: null,
        coverImageUrl: null,
      };

      const result = await addBookField?.resolve?.(
        {},
        { bookInput },
        authenticatedContext,
        {} as never,
      );

      expect(mockUserService.getUserByFirebaseUid).toHaveBeenCalledWith(
        "firebase-uid",
      );
      expect(mockShelfService.addBookToShelf).toHaveBeenCalledWith({
        userId: 100,
        bookInput: {
          externalId: "book-123",
          title: "Test Book",
          authors: ["Author"],
          publisher: null,
          publishedDate: null,
          isbn: null,
          coverImageUrl: null,
        },
      });
      expect(result).toEqual(mockUserBook);
    });

    it("should throw error when user is not authenticated", async () => {
      const mockSearchService = createMockSearchService();
      const mockShelfService = createMockShelfService();
      const mockUserService = createMockUserService();

      const builder = createTestBuilder();
      registerBooksTypes(builder);
      builder.queryType({});
      registerBooksQueries(builder, mockSearchService);
      builder.mutationType({});
      registerBooksMutations(builder, mockShelfService, mockUserService);

      const schema = builder.toSchema();
      const mutationType = schema.getMutationType();
      const addBookField = mutationType?.getFields().addBookToShelf;

      const unauthenticatedContext = {
        requestId: "test",
        user: null,
      };

      const bookInput = {
        externalId: "book-123",
        title: "Test Book",
        authors: ["Author"],
      };

      let error: Error | null = null;
      try {
        await addBookField?.resolve?.(
          {},
          { bookInput },
          unauthenticatedContext,
          {} as never,
        );
      } catch (e) {
        error = e as Error;
      }

      expect(error).toBeDefined();
      expect(error?.message).toContain("Not authorized");
      expect(mockShelfService.addBookToShelf).not.toHaveBeenCalled();
    });

    it("should throw error when shelfService returns duplicate error", async () => {
      const mockSearchService = createMockSearchService();
      const mockShelfService = createMockShelfService();
      const mockUserService = createMockUserService();
      vi.mocked(mockShelfService.addBookToShelf).mockResolvedValue(
        err({
          code: "DUPLICATE_BOOK",
          message: "This book is already in your shelf",
        }),
      );
      vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue(
        ok({
          id: 100,
          email: "test@example.com",
          firebaseUid: "firebase-uid",
          createdAt: new Date(),
          updatedAt: new Date(),
        }),
      );

      const builder = createTestBuilder();
      registerBooksTypes(builder);
      builder.queryType({});
      registerBooksQueries(builder, mockSearchService);
      builder.mutationType({});
      registerBooksMutations(builder, mockShelfService, mockUserService);

      const schema = builder.toSchema();
      const mutationType = schema.getMutationType();
      const addBookField = mutationType?.getFields().addBookToShelf;

      const authenticatedContext = {
        requestId: "test",
        user: {
          uid: "firebase-uid",
          email: "test@example.com",
          emailVerified: true,
        },
      };

      const bookInput = {
        externalId: "book-123",
        title: "Test Book",
        authors: ["Author"],
      };

      await expect(
        addBookField?.resolve?.(
          {},
          { bookInput },
          authenticatedContext,
          {} as never,
        ),
      ).rejects.toThrow("This book is already in your shelf");
    });

    it("should throw error when shelfService returns database error", async () => {
      const mockSearchService = createMockSearchService();
      const mockShelfService = createMockShelfService();
      const mockUserService = createMockUserService();
      vi.mocked(mockShelfService.addBookToShelf).mockResolvedValue(
        err({
          code: "DATABASE_ERROR",
          message: "Database connection failed",
        }),
      );
      vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue(
        ok({
          id: 100,
          email: "test@example.com",
          firebaseUid: "firebase-uid",
          createdAt: new Date(),
          updatedAt: new Date(),
        }),
      );

      const builder = createTestBuilder();
      registerBooksTypes(builder);
      builder.queryType({});
      registerBooksQueries(builder, mockSearchService);
      builder.mutationType({});
      registerBooksMutations(builder, mockShelfService, mockUserService);

      const schema = builder.toSchema();
      const mutationType = schema.getMutationType();
      const addBookField = mutationType?.getFields().addBookToShelf;

      const authenticatedContext = {
        requestId: "test",
        user: {
          uid: "firebase-uid",
          email: "test@example.com",
          emailVerified: true,
        },
      };

      const bookInput = {
        externalId: "book-123",
        title: "Test Book",
        authors: ["Author"],
      };

      await expect(
        addBookField?.resolve?.(
          {},
          { bookInput },
          authenticatedContext,
          {} as never,
        ),
      ).rejects.toThrow("Database connection failed");
    });
  });
});
