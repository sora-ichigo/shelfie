import type {
  GraphQLEnumType,
  GraphQLInputObjectType,
  GraphQLObjectType,
  GraphQLSchema,
} from "graphql";
import { beforeAll, describe, expect, it, vi } from "vitest";
import { err, ok } from "../../../errors/result.js";
import { createTestBuilder } from "../../../graphql/builder.js";
import type { FollowService } from "../../follows/index.js";
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
    getBookDetail: vi.fn(),
  };
}

function createMockShelfService(): BookShelfService {
  return {
    addBookToShelf: vi.fn(),
    getUserBookByExternalId: vi.fn(),
    getUserBooks: vi.fn(),
    getUserBooksWithPagination: vi.fn(),
    updateReadingStatus: vi.fn(),
    updateReadingNote: vi.fn(),
    updateRating: vi.fn(),
    updateStartedAt: vi.fn(),
    updateCompletedAt: vi.fn(),
    updateThoughts: vi.fn(),
    removeFromShelf: vi.fn(),
  };
}

function createMockUserService(): UserService {
  return {
    getUserById: vi.fn(),
    getUserByHandle: vi.fn(),
    createUser: vi.fn(),
    getUsers: vi.fn(),
    getUserByFirebaseUid: vi.fn(),
    createUserWithFirebase: vi.fn(),
    updateProfile: vi.fn(),
    deleteAccount: vi.fn(),
  };
}

function createMockFollowService(): FollowService {
  return {
    sendRequest: vi.fn(),
    approveRequest: vi.fn(),
    rejectRequest: vi.fn(),
    unfollow: vi.fn(),
    cancelFollowRequest: vi.fn(),
    getFollowStatus: vi.fn(),
    getFollowCounts: vi.fn(),
    getFollowStatusBatch: vi.fn(),
    getFollowRequestIdBatch: vi.fn(),
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

    it("should define UserBook type with reading record fields", () => {
      const userBookType = schema.getType("UserBook") as GraphQLObjectType;

      expect(userBookType).toBeDefined();
      const fields = userBookType.getFields();

      expect(fields.readingStatus).toBeDefined();
      expect(fields.readingStatus.type.toString()).toBe("ReadingStatus!");

      expect(fields.completedAt).toBeDefined();
      expect(fields.completedAt.type.toString()).toBe("DateTime");

      expect(fields.note).toBeDefined();
      expect(fields.note.type.toString()).toBe("String");

      expect(fields.noteUpdatedAt).toBeDefined();
      expect(fields.noteUpdatedAt.type.toString()).toBe("DateTime");

      expect(fields.thoughts).toBeDefined();
      expect(fields.thoughts.type.toString()).toBe("String");

      expect(fields.thoughtsUpdatedAt).toBeDefined();
      expect(fields.thoughtsUpdatedAt.type.toString()).toBe("DateTime");
    });
  });

  describe("ReadingStatus enum", () => {
    it("should define ReadingStatus enum with all reading states", () => {
      const readingStatusEnum = schema.getType(
        "ReadingStatus",
      ) as GraphQLEnumType;

      expect(readingStatusEnum).toBeDefined();

      const values = readingStatusEnum.getValues();
      const valueNames = values.map((v) => v.name);

      expect(valueNames).toContain("BACKLOG");
      expect(valueNames).toContain("READING");
      expect(valueNames).toContain("COMPLETED");
      expect(valueNames).toContain("INTERESTED");
      expect(valueNames).toContain("DROP");
      expect(values).toHaveLength(5);

      const dropValue = values.find((v) => v.name === "DROP");
      expect(dropValue?.deprecationReason).toBe(
        "Use INTERESTED instead. DROP is ignored.",
      );
    });

    it("should map ReadingStatus enum values to database values", () => {
      const readingStatusEnum = schema.getType(
        "ReadingStatus",
      ) as GraphQLEnumType;

      const backlogValue = readingStatusEnum.getValue("BACKLOG");
      expect(backlogValue?.value).toBe("backlog");

      const readingValue = readingStatusEnum.getValue("READING");
      expect(readingValue?.value).toBe("reading");

      const completedValue = readingStatusEnum.getValue("COMPLETED");
      expect(completedValue?.value).toBe("completed");

      const interestedValue = readingStatusEnum.getValue("INTERESTED");
      expect(interestedValue?.value).toBe("interested");

      const dropValue = readingStatusEnum.getValue("DROP");
      expect(dropValue?.value).toBe("dropped");
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

  it("should define bookDetail query with bookId parameter", () => {
    const mockSearchService = createMockSearchService();
    const mockShelfService = createMockShelfService();
    const mockUserService = createMockUserService();

    const builder = createTestBuilder();
    registerBooksTypes(builder);
    builder.queryType({});
    registerBooksQueries(
      builder,
      mockSearchService,
      mockShelfService,
      mockUserService,
    );
    const schema = builder.toSchema();

    const queryType = schema.getQueryType();
    expect(queryType).toBeDefined();

    const fields = queryType?.getFields();
    expect(fields?.bookDetail).toBeDefined();

    const bookDetailField = fields?.bookDetail;
    expect(bookDetailField?.type.toString()).toBe("BookDetail!");

    const args = bookDetailField?.args;
    expect(args?.find((a) => a.name === "bookId")?.type.toString()).toBe(
      "String!",
    );
  });

  it("should define userBookByExternalId query with externalId parameter", () => {
    const mockSearchService = createMockSearchService();
    const mockShelfService = createMockShelfService();
    const mockUserService = createMockUserService();

    const builder = createTestBuilder();
    registerBooksTypes(builder);
    builder.queryType({});
    registerBooksQueries(
      builder,
      mockSearchService,
      mockShelfService,
      mockUserService,
    );
    const schema = builder.toSchema();

    const queryType = schema.getQueryType();
    expect(queryType).toBeDefined();

    const fields = queryType?.getFields();
    expect(fields?.userBookByExternalId).toBeDefined();

    const userBookByExternalIdField = fields?.userBookByExternalId;
    expect(userBookByExternalIdField?.type.toString()).toBe("UserBook");

    const args = userBookByExternalIdField?.args;
    expect(args?.find((a) => a.name === "externalId")?.type.toString()).toBe(
      "String!",
    );
  });
});

describe("BookDetail type", () => {
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

  it("should define BookDetail type with all book info fields", () => {
    const bookDetailType = schema.getType("BookDetail") as GraphQLObjectType;

    expect(bookDetailType).toBeDefined();
    const fields = bookDetailType.getFields();

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

    expect(fields.pageCount).toBeDefined();
    expect(fields.pageCount.type.toString()).toBe("Int");

    expect(fields.categories).toBeDefined();
    expect(fields.categories.type.toString()).toBe("[String!]");

    expect(fields.description).toBeDefined();
    expect(fields.description.type.toString()).toBe("String");

    expect(fields.isbn).toBeDefined();
    expect(fields.isbn.type.toString()).toBe("String");

    expect(fields.coverImageUrl).toBeDefined();
    expect(fields.coverImageUrl.type.toString()).toBe("String");

    expect(fields.amazonUrl).toBeDefined();
    expect(fields.amazonUrl.type.toString()).toBe("String");

    expect(fields.googleBooksUrl).toBeDefined();
    expect(fields.googleBooksUrl.type.toString()).toBe("String");

    expect(fields.rakutenBooksUrl).toBeDefined();
    expect(fields.rakutenBooksUrl.type.toString()).toBe("String");

    expect(fields.userBook).toBeDefined();
    expect(fields.userBook.type.toString()).toBe("UserBook");
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

  it("should define updateReadingStatus mutation with userBookId and status parameters", () => {
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
    expect(fields?.updateReadingStatus).toBeDefined();

    const updateStatusField = fields?.updateReadingStatus;
    expect(updateStatusField?.type.toString()).toContain("UserBook");

    const args = updateStatusField?.args;
    expect(args?.find((a) => a.name === "userBookId")?.type.toString()).toBe(
      "Int!",
    );
    expect(args?.find((a) => a.name === "status")?.type.toString()).toBe(
      "ReadingStatus!",
    );
  });

  it("should define updateReadingNote mutation with userBookId and note parameters", () => {
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
    expect(fields?.updateReadingNote).toBeDefined();

    const updateNoteField = fields?.updateReadingNote;
    expect(updateNoteField?.type.toString()).toContain("UserBook");

    const args = updateNoteField?.args;
    expect(args?.find((a) => a.name === "userBookId")?.type.toString()).toBe(
      "Int!",
    );
    expect(args?.find((a) => a.name === "note")?.type.toString()).toBe(
      "String!",
    );
  });

  it("should define updateCompletedAt mutation with userBookId and completedAt parameters", () => {
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
    expect(fields?.updateCompletedAt).toBeDefined();

    const updateCompletedAtField = fields?.updateCompletedAt;
    expect(updateCompletedAtField?.type.toString()).toContain("UserBook");

    const args = updateCompletedAtField?.args;
    expect(args?.find((a) => a.name === "userBookId")?.type.toString()).toBe(
      "Int!",
    );
    expect(args?.find((a) => a.name === "completedAt")?.type.toString()).toBe(
      "DateTime!",
    );
  });
});

describe("MyShelf enhanced query types", () => {
  let schema: GraphQLSchema;

  beforeAll(() => {
    const mockSearchService = createMockSearchService();
    const mockShelfService = createMockShelfService();
    const mockUserService = createMockUserService();

    const builder = createTestBuilder();
    registerBooksTypes(builder);
    builder.queryType({});
    registerBooksQueries(
      builder,
      mockSearchService,
      mockShelfService,
      mockUserService,
    );

    schema = builder.toSchema();
  });

  describe("ShelfSortField enum", () => {
    it("should define ShelfSortField enum with ADDED_AT, TITLE, AUTHOR values", () => {
      const shelfSortFieldEnum = schema.getType(
        "ShelfSortField",
      ) as GraphQLEnumType;

      expect(shelfSortFieldEnum).toBeDefined();

      const values = shelfSortFieldEnum.getValues();
      const valueNames = values.map((v) => v.name);

      expect(valueNames).toContain("ADDED_AT");
      expect(valueNames).toContain("TITLE");
      expect(valueNames).toContain("AUTHOR");
      expect(valueNames).toContain("COMPLETED_AT");
      expect(valueNames).toContain("PUBLISHED_DATE");
      expect(valueNames).toContain("RATING");
      expect(values).toHaveLength(6);
    });
  });

  describe("SortOrder enum", () => {
    it("should define SortOrder enum with ASC, DESC values", () => {
      const sortOrderEnum = schema.getType("SortOrder") as GraphQLEnumType;

      expect(sortOrderEnum).toBeDefined();

      const values = sortOrderEnum.getValues();
      const valueNames = values.map((v) => v.name);

      expect(valueNames).toContain("ASC");
      expect(valueNames).toContain("DESC");
      expect(values).toHaveLength(2);
    });
  });

  describe("MyShelfInput type", () => {
    it("should define MyShelfInput input type with query, sortBy, sortOrder, limit, offset, readingStatus fields", () => {
      const inputType = schema.getType(
        "MyShelfInput",
      ) as GraphQLInputObjectType;

      expect(inputType).toBeDefined();
      const fields = inputType.getFields();

      expect(fields.query).toBeDefined();
      expect(fields.query.type.toString()).toBe("String");

      expect(fields.sortBy).toBeDefined();
      expect(fields.sortBy.type.toString()).toBe("ShelfSortField");

      expect(fields.sortOrder).toBeDefined();
      expect(fields.sortOrder.type.toString()).toBe("SortOrder");

      expect(fields.limit).toBeDefined();
      expect(fields.limit.type.toString()).toBe("Int");

      expect(fields.offset).toBeDefined();
      expect(fields.offset.type.toString()).toBe("Int");

      expect(fields.readingStatus).toBeDefined();
      expect(fields.readingStatus.type.toString()).toBe("ReadingStatus");
    });
  });

  describe("MyShelfResult type", () => {
    it("should define MyShelfResult type with items, totalCount, hasMore fields", () => {
      const resultType = schema.getType("MyShelfResult") as GraphQLObjectType;

      expect(resultType).toBeDefined();
      const fields = resultType.getFields();

      expect(fields.items).toBeDefined();
      expect(fields.items.type.toString()).toBe("[UserBook!]!");

      expect(fields.totalCount).toBeDefined();
      expect(fields.totalCount.type.toString()).toBe("Int!");

      expect(fields.hasMore).toBeDefined();
      expect(fields.hasMore.type.toString()).toBe("Boolean!");
    });
  });

  describe("myShelf query with input", () => {
    it("should accept MyShelfInput as optional argument", () => {
      const queryType = schema.getQueryType();
      expect(queryType).toBeDefined();

      const fields = queryType?.getFields();
      expect(fields?.myShelf).toBeDefined();

      const myShelfField = fields?.myShelf;
      expect(myShelfField?.type.toString()).toBe("MyShelfResult!");

      const args = myShelfField?.args;
      expect(args?.find((a) => a.name === "input")?.type.toString()).toBe(
        "MyShelfInput",
      );
    });
  });
});

describe("Public queries (guest mode - no auth required)", () => {
  describe("searchBooks resolver with unauthenticated context", () => {
    it("should succeed when user is null (guest mode)", async () => {
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
            source: "rakuten" as const,
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
        {
          requestId: "test",
          user: null,
        },
        {} as never,
      );

      expect(mockSearchService.searchBooks).toHaveBeenCalledWith({
        query: "test",
        limit: 10,
        offset: 0,
      });
      expect(result).toEqual(mockResult);
    });
  });

  describe("searchBookByISBN resolver with unauthenticated context", () => {
    it("should succeed when user is null (guest mode)", async () => {
      const mockSearchService = createMockSearchService();
      const mockBook = {
        id: "isbn-book",
        title: "ISBN Book",
        authors: ["Author"],
        publisher: null,
        publishedDate: null,
        isbn: "9781234567890",
        coverImageUrl: null,
        source: "rakuten" as const,
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
        {
          requestId: "test",
          user: null,
        },
        {} as never,
      );

      expect(mockSearchService.searchBookByISBN).toHaveBeenCalledWith({
        isbn: "9781234567890",
      });
      expect(result).toEqual(mockBook);
    });
  });

  describe("bookDetail resolver with unauthenticated context", () => {
    it("should return book detail with userBook as null when user is null (guest mode)", async () => {
      const mockSearchService = createMockSearchService();
      const mockShelfService = createMockShelfService();
      const mockUserService = createMockUserService();

      const mockBookDetail = {
        id: "book-123",
        title: "Test Book",
        authors: ["Author"],
        publisher: "Publisher",
        publishedDate: "2024-01-01",
        pageCount: 200,
        categories: ["Fiction"],
        description: "A test book",
        isbn: "9781234567890",
        coverImageUrl: "https://example.com/cover.jpg",
        amazonUrl: "https://amazon.com/dp/1234567890",
        googleBooksUrl: null,
        rakutenBooksUrl: "https://books.rakuten.co.jp/rb/12345678/",
      };

      vi.mocked(mockSearchService.getBookDetail).mockResolvedValue(
        ok(mockBookDetail),
      );

      const builder = createTestBuilder();
      registerBooksTypes(builder);
      builder.queryType({});
      registerBooksQueries(
        builder,
        mockSearchService,
        mockShelfService,
        mockUserService,
      );

      const schema = builder.toSchema();
      const queryType = schema.getQueryType();
      const bookDetailField = queryType?.getFields().bookDetail;

      const result = await bookDetailField?.resolve?.(
        {},
        { bookId: "book-123", source: "rakuten" },
        {
          requestId: "test",
          user: null,
        },
        {} as never,
      );

      expect(mockSearchService.getBookDetail).toHaveBeenCalledWith(
        "book-123",
        "rakuten",
      );
      expect(mockShelfService.getUserBookByExternalId).not.toHaveBeenCalled();
      expect(result).toMatchObject({
        ...mockBookDetail,
        userBook: null,
      });
    });
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
            source: "rakuten" as const,
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
        {
          requestId: "test",
          user: {
            uid: "test-uid",
            email: "test@example.com",
            emailVerified: true,
          },
        },
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
          {
            requestId: "test",
            user: {
              uid: "test-uid",
              email: "test@example.com",
              emailVerified: true,
            },
          },
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
        source: "rakuten" as const,
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
        {
          requestId: "test",
          user: {
            uid: "test-uid",
            email: "test@example.com",
            emailVerified: true,
          },
        },
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
        {
          requestId: "test",
          user: {
            uid: "test-uid",
            email: "test@example.com",
            emailVerified: true,
          },
        },
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
          {
            requestId: "test",
            user: {
              uid: "test-uid",
              email: "test@example.com",
              emailVerified: true,
            },
          },
          {} as never,
        ),
      ).rejects.toThrow("ISBN must be 10 or 13 digits");
    });
  });

  describe("bookDetail resolver", () => {
    it("should return book detail with userBook when user has the book in shelf", async () => {
      const mockSearchService = createMockSearchService();
      const mockShelfService = createMockShelfService();
      const mockUserService = createMockUserService();

      const mockBookDetail = {
        id: "book-123",
        title: "Test Book",
        authors: ["Author"],
        publisher: "Publisher",
        publishedDate: "2024-01-01",
        pageCount: 200,
        categories: ["Fiction"],
        description: "A test book",
        isbn: "9781234567890",
        coverImageUrl: "https://example.com/cover.jpg",
        amazonUrl: "https://amazon.com/dp/1234567890",
        googleBooksUrl: null,
        rakutenBooksUrl: "https://books.rakuten.co.jp/rb/12345678/",
      };

      const mockUserBook = {
        id: 1,
        userId: 100,
        externalId: "book-123",
        title: "Test Book",
        authors: ["Author"],
        publisher: "Publisher",
        publishedDate: "2024-01-01",
        isbn: "9781234567890",
        coverImageUrl: "https://example.com/cover.jpg",
        addedAt: new Date(),
        readingStatus: "reading" as const,
        startedAt: null,
        completedAt: null,
        note: null,
        noteUpdatedAt: null,
        thoughts: null,
        thoughtsUpdatedAt: null,
        rating: null,
        source: "rakuten" as const,
      };

      vi.mocked(mockSearchService.getBookDetail).mockResolvedValue(
        ok(mockBookDetail),
      );
      vi.mocked(mockShelfService.getUserBookByExternalId).mockResolvedValue(
        ok(mockUserBook),
      );
      vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue(
        ok({
          id: 100,
          email: "test@example.com",
          firebaseUid: "firebase-uid",
          name: null,
          avatarUrl: null,
          bio: null,
          instagramHandle: null,
          handle: null,
          createdAt: new Date(),
          updatedAt: new Date(),
        }),
      );

      const builder = createTestBuilder();
      registerBooksTypes(builder);
      builder.queryType({});
      registerBooksQueries(
        builder,
        mockSearchService,
        mockShelfService,
        mockUserService,
      );

      const schema = builder.toSchema();
      const queryType = schema.getQueryType();
      const bookDetailField = queryType?.getFields().bookDetail;

      const result = await bookDetailField?.resolve?.(
        {},
        { bookId: "book-123" },
        {
          requestId: "test",
          user: {
            uid: "firebase-uid",
            email: "test@example.com",
            emailVerified: true,
          },
        },
        {} as never,
      );

      expect(mockSearchService.getBookDetail).toHaveBeenCalledWith(
        "book-123",
        undefined,
      );
      expect(mockShelfService.getUserBookByExternalId).toHaveBeenCalledWith(
        100,
        "book-123",
      );
      expect(result).toMatchObject({
        ...mockBookDetail,
        userBook: mockUserBook,
      });
    });

    it("should return book detail without userBook when user does not have the book", async () => {
      const mockSearchService = createMockSearchService();
      const mockShelfService = createMockShelfService();
      const mockUserService = createMockUserService();

      const mockBookDetail = {
        id: "book-123",
        title: "Test Book",
        authors: ["Author"],
        publisher: null,
        publishedDate: null,
        pageCount: null,
        categories: null,
        description: null,
        isbn: null,
        coverImageUrl: null,
        amazonUrl: null,
        googleBooksUrl: null,
        rakutenBooksUrl: null,
      };

      vi.mocked(mockSearchService.getBookDetail).mockResolvedValue(
        ok(mockBookDetail),
      );
      vi.mocked(mockShelfService.getUserBookByExternalId).mockResolvedValue(
        ok(null),
      );
      vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue(
        ok({
          id: 100,
          email: "test@example.com",
          firebaseUid: "firebase-uid",
          name: null,
          avatarUrl: null,
          bio: null,
          instagramHandle: null,
          handle: null,
          createdAt: new Date(),
          updatedAt: new Date(),
        }),
      );

      const builder = createTestBuilder();
      registerBooksTypes(builder);
      builder.queryType({});
      registerBooksQueries(
        builder,
        mockSearchService,
        mockShelfService,
        mockUserService,
      );

      const schema = builder.toSchema();
      const queryType = schema.getQueryType();
      const bookDetailField = queryType?.getFields().bookDetail;

      const result = await bookDetailField?.resolve?.(
        {},
        { bookId: "book-123" },
        {
          requestId: "test",
          user: {
            uid: "firebase-uid",
            email: "test@example.com",
            emailVerified: true,
          },
        },
        {} as never,
      );

      expect(result).toMatchObject({
        ...mockBookDetail,
        userBook: null,
      });
    });

    it("should throw error when book not found", async () => {
      const mockSearchService = createMockSearchService();
      const mockShelfService = createMockShelfService();
      const mockUserService = createMockUserService();

      vi.mocked(mockSearchService.getBookDetail).mockResolvedValue(
        err({
          code: "NOT_FOUND",
          message: "Book not found",
        }),
      );

      const builder = createTestBuilder();
      registerBooksTypes(builder);
      builder.queryType({});
      registerBooksQueries(
        builder,
        mockSearchService,
        mockShelfService,
        mockUserService,
      );

      const schema = builder.toSchema();
      const queryType = schema.getQueryType();
      const bookDetailField = queryType?.getFields().bookDetail;

      await expect(
        bookDetailField?.resolve?.(
          {},
          { bookId: "nonexistent" },
          {
            requestId: "test",
            user: {
              uid: "firebase-uid",
              email: "test@example.com",
              emailVerified: true,
            },
          },
          {} as never,
        ),
      ).rejects.toThrow("Book not found");
    });
  });

  describe("userBookByExternalId resolver", () => {
    it("should return user book when authenticated user has the book", async () => {
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
        readingStatus: "backlog" as const,
        startedAt: null,
        completedAt: null,
        note: null,
        noteUpdatedAt: null,
        thoughts: null,
        thoughtsUpdatedAt: null,
        rating: null,
        source: "rakuten" as const,
      };

      vi.mocked(mockShelfService.getUserBookByExternalId).mockResolvedValue(
        ok(mockUserBook),
      );
      vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue(
        ok({
          id: 100,
          email: "test@example.com",
          firebaseUid: "firebase-uid",
          name: null,
          avatarUrl: null,
          bio: null,
          instagramHandle: null,
          handle: null,
          createdAt: new Date(),
          updatedAt: new Date(),
        }),
      );

      const builder = createTestBuilder();
      registerBooksTypes(builder);
      builder.queryType({});
      registerBooksQueries(
        builder,
        mockSearchService,
        mockShelfService,
        mockUserService,
      );

      const schema = builder.toSchema();
      const queryType = schema.getQueryType();
      const userBookByExternalIdField =
        queryType?.getFields().userBookByExternalId;

      const result = await userBookByExternalIdField?.resolve?.(
        {},
        { externalId: "book-123" },
        {
          requestId: "test",
          user: {
            uid: "firebase-uid",
            email: "test@example.com",
            emailVerified: true,
          },
        },
        {} as never,
      );

      expect(mockShelfService.getUserBookByExternalId).toHaveBeenCalledWith(
        100,
        "book-123",
      );
      expect(result).toEqual(mockUserBook);
    });

    it("should return null when user does not have the book", async () => {
      const mockSearchService = createMockSearchService();
      const mockShelfService = createMockShelfService();
      const mockUserService = createMockUserService();

      vi.mocked(mockShelfService.getUserBookByExternalId).mockResolvedValue(
        ok(null),
      );
      vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue(
        ok({
          id: 100,
          email: "test@example.com",
          firebaseUid: "firebase-uid",
          name: null,
          avatarUrl: null,
          bio: null,
          instagramHandle: null,
          handle: null,
          createdAt: new Date(),
          updatedAt: new Date(),
        }),
      );

      const builder = createTestBuilder();
      registerBooksTypes(builder);
      builder.queryType({});
      registerBooksQueries(
        builder,
        mockSearchService,
        mockShelfService,
        mockUserService,
      );

      const schema = builder.toSchema();
      const queryType = schema.getQueryType();
      const userBookByExternalIdField =
        queryType?.getFields().userBookByExternalId;

      const result = await userBookByExternalIdField?.resolve?.(
        {},
        { externalId: "nonexistent" },
        {
          requestId: "test",
          user: {
            uid: "firebase-uid",
            email: "test@example.com",
            emailVerified: true,
          },
        },
        {} as never,
      );

      expect(result).toBeNull();
    });

    it("should throw error when user is not authenticated", async () => {
      const mockSearchService = createMockSearchService();
      const mockShelfService = createMockShelfService();
      const mockUserService = createMockUserService();

      const builder = createTestBuilder();
      registerBooksTypes(builder);
      builder.queryType({});
      registerBooksQueries(
        builder,
        mockSearchService,
        mockShelfService,
        mockUserService,
      );

      const schema = builder.toSchema();
      const queryType = schema.getQueryType();
      const userBookByExternalIdField =
        queryType?.getFields().userBookByExternalId;

      let error: Error | null = null;
      try {
        await userBookByExternalIdField?.resolve?.(
          {},
          { externalId: "book-123" },
          {
            requestId: "test",
            user: null,
          },
          {} as never,
        );
      } catch (e) {
        error = e as Error;
      }

      expect(error).toBeDefined();
      expect(error?.message).toContain("Not authorized");
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
        readingStatus: "backlog" as const,
        startedAt: null,
        completedAt: null,
        note: null,
        noteUpdatedAt: null,
        thoughts: null,
        thoughtsUpdatedAt: null,
        rating: null,
        source: "rakuten" as const,
      };
      vi.mocked(mockShelfService.addBookToShelf).mockResolvedValue(
        ok(mockUserBook),
      );
      vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue(
        ok({
          id: 100,
          email: "test@example.com",
          firebaseUid: "firebase-uid",
          name: null,
          avatarUrl: null,
          bio: null,
          instagramHandle: null,
          handle: null,
          createdAt: new Date(),
          updatedAt: new Date(),
        }),
      );

      const builder = createTestBuilder();
      registerBooksTypes(builder);
      builder.queryType({});
      registerBooksQueries(
        builder,
        mockSearchService,
        mockShelfService,
        mockUserService,
      );
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
          name: null,
          avatarUrl: null,
          bio: null,
          instagramHandle: null,
          handle: null,
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
          name: null,
          avatarUrl: null,
          bio: null,
          instagramHandle: null,
          handle: null,
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

  describe("updateReadingStatus resolver", () => {
    it("should call shelfService.updateReadingStatus with correct input when authenticated", async () => {
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
        readingStatus: "reading" as const,
        startedAt: null,
        completedAt: null,
        note: null,
        noteUpdatedAt: null,
        thoughts: null,
        thoughtsUpdatedAt: null,
        rating: null,
        source: "rakuten" as const,
      };
      vi.mocked(mockShelfService.updateReadingStatus).mockResolvedValue(
        ok(mockUserBook),
      );
      vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue(
        ok({
          id: 100,
          email: "test@example.com",
          firebaseUid: "firebase-uid",
          name: null,
          avatarUrl: null,
          bio: null,
          instagramHandle: null,
          handle: null,
          createdAt: new Date(),
          updatedAt: new Date(),
        }),
      );

      const builder = createTestBuilder();
      registerBooksTypes(builder);
      builder.queryType({});
      registerBooksQueries(
        builder,
        mockSearchService,
        mockShelfService,
        mockUserService,
      );
      builder.mutationType({});
      registerBooksMutations(builder, mockShelfService, mockUserService);

      const schema = builder.toSchema();
      const mutationType = schema.getMutationType();
      const updateStatusField = mutationType?.getFields().updateReadingStatus;

      const authenticatedContext = {
        requestId: "test",
        user: {
          uid: "firebase-uid",
          email: "test@example.com",
          emailVerified: true,
        },
      };

      const result = await updateStatusField?.resolve?.(
        {},
        { userBookId: 1, status: "reading" },
        authenticatedContext,
        {} as never,
      );

      expect(mockUserService.getUserByFirebaseUid).toHaveBeenCalledWith(
        "firebase-uid",
      );
      expect(mockShelfService.updateReadingStatus).toHaveBeenCalledWith({
        userBookId: 1,
        userId: 100,
        status: "reading",
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
      const updateStatusField = mutationType?.getFields().updateReadingStatus;

      const unauthenticatedContext = {
        requestId: "test",
        user: null,
      };

      let error: Error | null = null;
      try {
        await updateStatusField?.resolve?.(
          {},
          { userBookId: 1, status: "reading" },
          unauthenticatedContext,
          {} as never,
        );
      } catch (e) {
        error = e as Error;
      }

      expect(error).toBeDefined();
      expect(error?.message).toContain("Not authorized");
      expect(mockShelfService.updateReadingStatus).not.toHaveBeenCalled();
    });

    it("should throw error when shelfService returns not found error", async () => {
      const mockSearchService = createMockSearchService();
      const mockShelfService = createMockShelfService();
      const mockUserService = createMockUserService();
      vi.mocked(mockShelfService.updateReadingStatus).mockResolvedValue(
        err({
          code: "BOOK_NOT_FOUND",
          message: "Book not found in shelf",
        }),
      );
      vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue(
        ok({
          id: 100,
          email: "test@example.com",
          firebaseUid: "firebase-uid",
          name: null,
          avatarUrl: null,
          bio: null,
          instagramHandle: null,
          handle: null,
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
      const updateStatusField = mutationType?.getFields().updateReadingStatus;

      const authenticatedContext = {
        requestId: "test",
        user: {
          uid: "firebase-uid",
          email: "test@example.com",
          emailVerified: true,
        },
      };

      await expect(
        updateStatusField?.resolve?.(
          {},
          { userBookId: 999, status: "reading" },
          authenticatedContext,
          {} as never,
        ),
      ).rejects.toThrow("Book not found in shelf");
    });

    it("should throw error when shelfService returns forbidden error", async () => {
      const mockSearchService = createMockSearchService();
      const mockShelfService = createMockShelfService();
      const mockUserService = createMockUserService();
      vi.mocked(mockShelfService.updateReadingStatus).mockResolvedValue(
        err({
          code: "FORBIDDEN",
          message: "You are not allowed to update this book",
        }),
      );
      vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue(
        ok({
          id: 100,
          email: "test@example.com",
          firebaseUid: "firebase-uid",
          name: null,
          avatarUrl: null,
          bio: null,
          instagramHandle: null,
          handle: null,
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
      const updateStatusField = mutationType?.getFields().updateReadingStatus;

      const authenticatedContext = {
        requestId: "test",
        user: {
          uid: "firebase-uid",
          email: "test@example.com",
          emailVerified: true,
        },
      };

      await expect(
        updateStatusField?.resolve?.(
          {},
          { userBookId: 1, status: "reading" },
          authenticatedContext,
          {} as never,
        ),
      ).rejects.toThrow("You are not allowed to update this book");
    });
  });

  describe("updateReadingNote resolver", () => {
    it("should call shelfService.updateReadingNote with correct input when authenticated", async () => {
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
        readingStatus: "reading" as const,
        startedAt: null,
        completedAt: null,
        note: "Great book!",
        noteUpdatedAt: new Date(),
        thoughts: null,
        thoughtsUpdatedAt: null,
        rating: null,
        source: "rakuten" as const,
      };
      vi.mocked(mockShelfService.updateReadingNote).mockResolvedValue(
        ok(mockUserBook),
      );
      vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue(
        ok({
          id: 100,
          email: "test@example.com",
          firebaseUid: "firebase-uid",
          name: null,
          avatarUrl: null,
          bio: null,
          instagramHandle: null,
          handle: null,
          createdAt: new Date(),
          updatedAt: new Date(),
        }),
      );

      const builder = createTestBuilder();
      registerBooksTypes(builder);
      builder.queryType({});
      registerBooksQueries(
        builder,
        mockSearchService,
        mockShelfService,
        mockUserService,
      );
      builder.mutationType({});
      registerBooksMutations(builder, mockShelfService, mockUserService);

      const schema = builder.toSchema();
      const mutationType = schema.getMutationType();
      const updateNoteField = mutationType?.getFields().updateReadingNote;

      const authenticatedContext = {
        requestId: "test",
        user: {
          uid: "firebase-uid",
          email: "test@example.com",
          emailVerified: true,
        },
      };

      const result = await updateNoteField?.resolve?.(
        {},
        { userBookId: 1, note: "Great book!" },
        authenticatedContext,
        {} as never,
      );

      expect(mockUserService.getUserByFirebaseUid).toHaveBeenCalledWith(
        "firebase-uid",
      );
      expect(mockShelfService.updateReadingNote).toHaveBeenCalledWith({
        userBookId: 1,
        userId: 100,
        note: "Great book!",
      });
      expect(result).toEqual(mockUserBook);
    });

    it("should allow empty note (delete note)", async () => {
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
        readingStatus: "reading" as const,
        startedAt: null,
        completedAt: null,
        note: "",
        noteUpdatedAt: new Date(),
        thoughts: null,
        thoughtsUpdatedAt: null,
        rating: null,
        source: "rakuten" as const,
      };
      vi.mocked(mockShelfService.updateReadingNote).mockResolvedValue(
        ok(mockUserBook),
      );
      vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue(
        ok({
          id: 100,
          email: "test@example.com",
          firebaseUid: "firebase-uid",
          name: null,
          avatarUrl: null,
          bio: null,
          instagramHandle: null,
          handle: null,
          createdAt: new Date(),
          updatedAt: new Date(),
        }),
      );

      const builder = createTestBuilder();
      registerBooksTypes(builder);
      builder.queryType({});
      registerBooksQueries(
        builder,
        mockSearchService,
        mockShelfService,
        mockUserService,
      );
      builder.mutationType({});
      registerBooksMutations(builder, mockShelfService, mockUserService);

      const schema = builder.toSchema();
      const mutationType = schema.getMutationType();
      const updateNoteField = mutationType?.getFields().updateReadingNote;

      const authenticatedContext = {
        requestId: "test",
        user: {
          uid: "firebase-uid",
          email: "test@example.com",
          emailVerified: true,
        },
      };

      const result = await updateNoteField?.resolve?.(
        {},
        { userBookId: 1, note: "" },
        authenticatedContext,
        {} as never,
      );

      expect(mockShelfService.updateReadingNote).toHaveBeenCalledWith({
        userBookId: 1,
        userId: 100,
        note: "",
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
      const updateNoteField = mutationType?.getFields().updateReadingNote;

      const unauthenticatedContext = {
        requestId: "test",
        user: null,
      };

      let error: Error | null = null;
      try {
        await updateNoteField?.resolve?.(
          {},
          { userBookId: 1, note: "Some note" },
          unauthenticatedContext,
          {} as never,
        );
      } catch (e) {
        error = e as Error;
      }

      expect(error).toBeDefined();
      expect(error?.message).toContain("Not authorized");
      expect(mockShelfService.updateReadingNote).not.toHaveBeenCalled();
    });

    it("should throw error when shelfService returns not found error", async () => {
      const mockSearchService = createMockSearchService();
      const mockShelfService = createMockShelfService();
      const mockUserService = createMockUserService();
      vi.mocked(mockShelfService.updateReadingNote).mockResolvedValue(
        err({
          code: "BOOK_NOT_FOUND",
          message: "Book not found in shelf",
        }),
      );
      vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue(
        ok({
          id: 100,
          email: "test@example.com",
          firebaseUid: "firebase-uid",
          name: null,
          avatarUrl: null,
          bio: null,
          instagramHandle: null,
          handle: null,
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
      const updateNoteField = mutationType?.getFields().updateReadingNote;

      const authenticatedContext = {
        requestId: "test",
        user: {
          uid: "firebase-uid",
          email: "test@example.com",
          emailVerified: true,
        },
      };

      await expect(
        updateNoteField?.resolve?.(
          {},
          { userBookId: 999, note: "Some note" },
          authenticatedContext,
          {} as never,
        ),
      ).rejects.toThrow("Book not found in shelf");
    });

    it("should throw error when shelfService returns forbidden error", async () => {
      const mockSearchService = createMockSearchService();
      const mockShelfService = createMockShelfService();
      const mockUserService = createMockUserService();
      vi.mocked(mockShelfService.updateReadingNote).mockResolvedValue(
        err({
          code: "FORBIDDEN",
          message: "You are not allowed to update this book",
        }),
      );
      vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue(
        ok({
          id: 100,
          email: "test@example.com",
          firebaseUid: "firebase-uid",
          name: null,
          avatarUrl: null,
          bio: null,
          instagramHandle: null,
          handle: null,
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
      const updateNoteField = mutationType?.getFields().updateReadingNote;

      const authenticatedContext = {
        requestId: "test",
        user: {
          uid: "firebase-uid",
          email: "test@example.com",
          emailVerified: true,
        },
      };

      await expect(
        updateNoteField?.resolve?.(
          {},
          { userBookId: 1, note: "Some note" },
          authenticatedContext,
          {} as never,
        ),
      ).rejects.toThrow("You are not allowed to update this book");
    });
  });

  describe("updateStartedAt resolver", () => {
    it("should call shelfService.updateStartedAt with correct input when authenticated", async () => {
      const mockSearchService = createMockSearchService();
      const mockShelfService = createMockShelfService();
      const mockUserService = createMockUserService();
      const startedAt = new Date("2024-06-20");
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
        readingStatus: "reading" as const,
        startedAt,
        completedAt: null,
        note: null,
        noteUpdatedAt: null,
        thoughts: null,
        thoughtsUpdatedAt: null,
        rating: null,
        source: "rakuten" as const,
      };
      vi.mocked(mockShelfService.updateStartedAt).mockResolvedValue(
        ok(mockUserBook),
      );
      vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue(
        ok({
          id: 100,
          email: "test@example.com",
          firebaseUid: "firebase-uid",
          name: null,
          avatarUrl: null,
          bio: null,
          instagramHandle: null,
          handle: null,
          createdAt: new Date(),
          updatedAt: new Date(),
        }),
      );

      const builder = createTestBuilder();
      registerBooksTypes(builder);
      builder.queryType({});
      registerBooksQueries(
        builder,
        mockSearchService,
        mockShelfService,
        mockUserService,
      );
      builder.mutationType({});
      registerBooksMutations(builder, mockShelfService, mockUserService);

      const schema = builder.toSchema();
      const mutationType = schema.getMutationType();
      const updateStartedAtField = mutationType?.getFields().updateStartedAt;

      const authenticatedContext = {
        requestId: "test",
        user: {
          uid: "firebase-uid",
          email: "test@example.com",
          emailVerified: true,
        },
      };

      const result = await updateStartedAtField?.resolve?.(
        {},
        { userBookId: 1, startedAt },
        authenticatedContext,
        {} as never,
      );

      expect(mockUserService.getUserByFirebaseUid).toHaveBeenCalledWith(
        "firebase-uid",
      );
      expect(mockShelfService.updateStartedAt).toHaveBeenCalledWith({
        userBookId: 1,
        userId: 100,
        startedAt,
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
      const updateStartedAtField = mutationType?.getFields().updateStartedAt;

      const unauthenticatedContext = {
        requestId: "test",
        user: null,
      };

      let error: Error | null = null;
      try {
        await updateStartedAtField?.resolve?.(
          {},
          { userBookId: 1, startedAt: new Date() },
          unauthenticatedContext,
          {} as never,
        );
      } catch (e) {
        error = e as Error;
      }

      expect(error).toBeDefined();
      expect(error?.message).toContain("Not authorized");
      expect(mockShelfService.updateStartedAt).not.toHaveBeenCalled();
    });
  });

  describe("updateCompletedAt resolver", () => {
    it("should call shelfService.updateCompletedAt with correct input when authenticated", async () => {
      const mockSearchService = createMockSearchService();
      const mockShelfService = createMockShelfService();
      const mockUserService = createMockUserService();
      const completedAt = new Date("2024-06-20");
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
        readingStatus: "completed" as const,
        startedAt: null,
        completedAt,
        note: null,
        noteUpdatedAt: null,
        thoughts: null,
        thoughtsUpdatedAt: null,
        rating: null,
        source: "rakuten" as const,
      };
      vi.mocked(mockShelfService.updateCompletedAt).mockResolvedValue(
        ok(mockUserBook),
      );
      vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue(
        ok({
          id: 100,
          email: "test@example.com",
          firebaseUid: "firebase-uid",
          name: null,
          avatarUrl: null,
          bio: null,
          instagramHandle: null,
          handle: null,
          createdAt: new Date(),
          updatedAt: new Date(),
        }),
      );

      const builder = createTestBuilder();
      registerBooksTypes(builder);
      builder.queryType({});
      registerBooksQueries(
        builder,
        mockSearchService,
        mockShelfService,
        mockUserService,
      );
      builder.mutationType({});
      registerBooksMutations(builder, mockShelfService, mockUserService);

      const schema = builder.toSchema();
      const mutationType = schema.getMutationType();
      const updateCompletedAtField =
        mutationType?.getFields().updateCompletedAt;

      const authenticatedContext = {
        requestId: "test",
        user: {
          uid: "firebase-uid",
          email: "test@example.com",
          emailVerified: true,
        },
      };

      const result = await updateCompletedAtField?.resolve?.(
        {},
        { userBookId: 1, completedAt },
        authenticatedContext,
        {} as never,
      );

      expect(mockUserService.getUserByFirebaseUid).toHaveBeenCalledWith(
        "firebase-uid",
      );
      expect(mockShelfService.updateCompletedAt).toHaveBeenCalledWith({
        userBookId: 1,
        userId: 100,
        completedAt,
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
      const updateCompletedAtField =
        mutationType?.getFields().updateCompletedAt;

      const unauthenticatedContext = {
        requestId: "test",
        user: null,
      };

      let error: Error | null = null;
      try {
        await updateCompletedAtField?.resolve?.(
          {},
          { userBookId: 1, completedAt: new Date() },
          unauthenticatedContext,
          {} as never,
        );
      } catch (e) {
        error = e as Error;
      }

      expect(error).toBeDefined();
      expect(error?.message).toContain("Not authorized");
      expect(mockShelfService.updateCompletedAt).not.toHaveBeenCalled();
    });
  });

  describe("myShelf resolver (enhanced)", () => {
    it("should call shelfService.getUserBooksWithPagination with input parameters", async () => {
      const mockSearchService = createMockSearchService();
      const mockShelfService = createMockShelfService();
      const mockUserService = createMockUserService();

      const mockUserBooks = [
        {
          id: 1,
          userId: 100,
          externalId: "book-1",
          title: "Test Book 1",
          authors: ["Author 1"],
          publisher: null,
          publishedDate: null,
          isbn: null,
          coverImageUrl: "https://example.com/cover1.jpg",
          addedAt: new Date(),
          readingStatus: "reading" as const,
          startedAt: null,
          completedAt: null,
          note: null,
          noteUpdatedAt: null,
          thoughts: null,
          thoughtsUpdatedAt: null,
          rating: null,
          source: "rakuten" as const,
        },
      ];

      const mockResult = {
        items: mockUserBooks,
        totalCount: 25,
        hasMore: true,
      };

      vi.mocked(mockShelfService.getUserBooksWithPagination).mockResolvedValue(
        ok(mockResult),
      );
      vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue(
        ok({
          id: 100,
          email: "test@example.com",
          firebaseUid: "firebase-uid",
          name: null,
          avatarUrl: null,
          bio: null,
          instagramHandle: null,
          handle: null,
          createdAt: new Date(),
          updatedAt: new Date(),
        }),
      );

      const builder = createTestBuilder();
      registerBooksTypes(builder);
      builder.queryType({});
      registerBooksQueries(
        builder,
        mockSearchService,
        mockShelfService,
        mockUserService,
      );

      const schema = builder.toSchema();
      const queryType = schema.getQueryType();
      const myShelfField = queryType?.getFields().myShelf;

      const result = await myShelfField?.resolve?.(
        {},
        {
          input: {
            query: "JavaScript",
            sortBy: "TITLE",
            sortOrder: "ASC",
            limit: 20,
            offset: 0,
          },
        },
        {
          requestId: "test",
          user: {
            uid: "firebase-uid",
            email: "test@example.com",
            emailVerified: true,
          },
        },
        {} as never,
      );

      expect(mockUserService.getUserByFirebaseUid).toHaveBeenCalledWith(
        "firebase-uid",
      );
      expect(mockShelfService.getUserBooksWithPagination).toHaveBeenCalledWith(
        100,
        {
          query: "JavaScript",
          sortBy: "TITLE",
          sortOrder: "ASC",
          limit: 20,
          offset: 0,
        },
      );
      expect(result).toEqual(mockResult);
    });

    it("should pass readingStatus filter to shelfService", async () => {
      const mockSearchService = createMockSearchService();
      const mockShelfService = createMockShelfService();
      const mockUserService = createMockUserService();

      const mockResult = {
        items: [],
        totalCount: 0,
        hasMore: false,
      };

      vi.mocked(mockShelfService.getUserBooksWithPagination).mockResolvedValue(
        ok(mockResult),
      );
      vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue(
        ok({
          id: 100,
          email: "test@example.com",
          firebaseUid: "firebase-uid",
          name: null,
          avatarUrl: null,
          bio: null,
          instagramHandle: null,
          handle: null,
          createdAt: new Date(),
          updatedAt: new Date(),
        }),
      );

      const builder = createTestBuilder();
      registerBooksTypes(builder);
      builder.queryType({});
      registerBooksQueries(
        builder,
        mockSearchService,
        mockShelfService,
        mockUserService,
      );

      const schema = builder.toSchema();
      const queryType = schema.getQueryType();
      const myShelfField = queryType?.getFields().myShelf;

      await myShelfField?.resolve?.(
        {},
        {
          input: {
            readingStatus: "reading",
            limit: 20,
            offset: 0,
          },
        },
        {
          requestId: "test",
          user: {
            uid: "firebase-uid",
            email: "test@example.com",
            emailVerified: true,
          },
        },
        {} as never,
      );

      expect(mockShelfService.getUserBooksWithPagination).toHaveBeenCalledWith(
        100,
        {
          readingStatus: "reading",
          limit: 20,
          offset: 0,
        },
      );
    });

    it("should pass readingStatus combined with sortBy/limit/offset to shelfService", async () => {
      const mockSearchService = createMockSearchService();
      const mockShelfService = createMockShelfService();
      const mockUserService = createMockUserService();

      const mockResult = {
        items: [],
        totalCount: 0,
        hasMore: false,
      };

      vi.mocked(mockShelfService.getUserBooksWithPagination).mockResolvedValue(
        ok(mockResult),
      );
      vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue(
        ok({
          id: 100,
          email: "test@example.com",
          firebaseUid: "firebase-uid",
          name: null,
          avatarUrl: null,
          bio: null,
          instagramHandle: null,
          handle: null,
          createdAt: new Date(),
          updatedAt: new Date(),
        }),
      );

      const builder = createTestBuilder();
      registerBooksTypes(builder);
      builder.queryType({});
      registerBooksQueries(
        builder,
        mockSearchService,
        mockShelfService,
        mockUserService,
      );

      const schema = builder.toSchema();
      const queryType = schema.getQueryType();
      const myShelfField = queryType?.getFields().myShelf;

      await myShelfField?.resolve?.(
        {},
        {
          input: {
            readingStatus: "completed",
            sortBy: "TITLE",
            sortOrder: "DESC",
            limit: 10,
            offset: 5,
          },
        },
        {
          requestId: "test",
          user: {
            uid: "firebase-uid",
            email: "test@example.com",
            emailVerified: true,
          },
        },
        {} as never,
      );

      expect(mockShelfService.getUserBooksWithPagination).toHaveBeenCalledWith(
        100,
        {
          readingStatus: "completed",
          sortBy: "TITLE",
          sortOrder: "DESC",
          limit: 10,
          offset: 5,
        },
      );
    });

    it("should use default values when input is not provided", async () => {
      const mockSearchService = createMockSearchService();
      const mockShelfService = createMockShelfService();
      const mockUserService = createMockUserService();

      const mockResult = {
        items: [],
        totalCount: 0,
        hasMore: false,
      };

      vi.mocked(mockShelfService.getUserBooksWithPagination).mockResolvedValue(
        ok(mockResult),
      );
      vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue(
        ok({
          id: 100,
          email: "test@example.com",
          firebaseUid: "firebase-uid",
          name: null,
          avatarUrl: null,
          bio: null,
          instagramHandle: null,
          handle: null,
          createdAt: new Date(),
          updatedAt: new Date(),
        }),
      );

      const builder = createTestBuilder();
      registerBooksTypes(builder);
      builder.queryType({});
      registerBooksQueries(
        builder,
        mockSearchService,
        mockShelfService,
        mockUserService,
      );

      const schema = builder.toSchema();
      const queryType = schema.getQueryType();
      const myShelfField = queryType?.getFields().myShelf;

      const result = await myShelfField?.resolve?.(
        {},
        {},
        {
          requestId: "test",
          user: {
            uid: "firebase-uid",
            email: "test@example.com",
            emailVerified: true,
          },
        },
        {} as never,
      );

      expect(mockShelfService.getUserBooksWithPagination).toHaveBeenCalledWith(
        100,
        {},
      );
      expect(result).toEqual(mockResult);
    });

    it("should return MyShelfResult with items including coverImageUrl", async () => {
      const mockSearchService = createMockSearchService();
      const mockShelfService = createMockShelfService();
      const mockUserService = createMockUserService();

      const mockUserBooks = [
        {
          id: 1,
          userId: 100,
          externalId: "book-1",
          title: "Test Book 1",
          authors: ["Author 1"],
          publisher: null,
          publishedDate: null,
          isbn: null,
          coverImageUrl: "https://example.com/cover1.jpg",
          addedAt: new Date(),
          readingStatus: "reading" as const,
          startedAt: null,
          completedAt: null,
          note: null,
          noteUpdatedAt: null,
          thoughts: null,
          thoughtsUpdatedAt: null,
          rating: null,
          source: "rakuten" as const,
        },
      ];

      const mockResult = {
        items: mockUserBooks,
        totalCount: 1,
        hasMore: false,
      };

      vi.mocked(mockShelfService.getUserBooksWithPagination).mockResolvedValue(
        ok(mockResult),
      );
      vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue(
        ok({
          id: 100,
          email: "test@example.com",
          firebaseUid: "firebase-uid",
          name: null,
          avatarUrl: null,
          bio: null,
          instagramHandle: null,
          handle: null,
          createdAt: new Date(),
          updatedAt: new Date(),
        }),
      );

      const builder = createTestBuilder();
      registerBooksTypes(builder);
      builder.queryType({});
      registerBooksQueries(
        builder,
        mockSearchService,
        mockShelfService,
        mockUserService,
      );

      const schema = builder.toSchema();
      const queryType = schema.getQueryType();
      const myShelfField = queryType?.getFields().myShelf;

      const result = await myShelfField?.resolve?.(
        {},
        {},
        {
          requestId: "test",
          user: {
            uid: "firebase-uid",
            email: "test@example.com",
            emailVerified: true,
          },
        },
        {} as never,
      );

      expect(result).toMatchObject({
        items: expect.arrayContaining([
          expect.objectContaining({
            coverImageUrl: "https://example.com/cover1.jpg",
          }),
        ]),
        totalCount: 1,
        hasMore: false,
      });
    });

    it("should throw error when user is not authenticated", async () => {
      const mockSearchService = createMockSearchService();
      const mockShelfService = createMockShelfService();
      const mockUserService = createMockUserService();

      const builder = createTestBuilder();
      registerBooksTypes(builder);
      builder.queryType({});
      registerBooksQueries(
        builder,
        mockSearchService,
        mockShelfService,
        mockUserService,
      );

      const schema = builder.toSchema();
      const queryType = schema.getQueryType();
      const myShelfField = queryType?.getFields().myShelf;

      let error: Error | null = null;
      try {
        await myShelfField?.resolve?.(
          {},
          {},
          {
            requestId: "test",
            user: null,
          },
          {} as never,
        );
      } catch (e) {
        error = e as Error;
      }

      expect(error).toBeDefined();
      expect(error?.message).toContain("Not authorized");
      expect(
        mockShelfService.getUserBooksWithPagination,
      ).not.toHaveBeenCalled();
    });

    it("should throw error when shelfService returns database error", async () => {
      const mockSearchService = createMockSearchService();
      const mockShelfService = createMockShelfService();
      const mockUserService = createMockUserService();

      vi.mocked(mockShelfService.getUserBooksWithPagination).mockResolvedValue(
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
          name: null,
          avatarUrl: null,
          bio: null,
          instagramHandle: null,
          handle: null,
          createdAt: new Date(),
          updatedAt: new Date(),
        }),
      );

      const builder = createTestBuilder();
      registerBooksTypes(builder);
      builder.queryType({});
      registerBooksQueries(
        builder,
        mockSearchService,
        mockShelfService,
        mockUserService,
      );

      const schema = builder.toSchema();
      const queryType = schema.getQueryType();
      const myShelfField = queryType?.getFields().myShelf;

      await expect(
        myShelfField?.resolve?.(
          {},
          {},
          {
            requestId: "test",
            user: {
              uid: "firebase-uid",
              email: "test@example.com",
              emailVerified: true,
            },
          },
          {} as never,
        ),
      ).rejects.toThrow("Database connection failed");
    });
  });
});

describe("userShelf query", () => {
  it("should return shelf data when user is following the target", async () => {
    const mockSearchService = createMockSearchService();
    const mockShelfService = createMockShelfService();
    const mockUserService = createMockUserService();
    const mockFollowService = createMockFollowService();

    const mockUserBooks = [
      {
        id: 1,
        userId: 200,
        externalId: "book-1",
        title: "Test Book",
        authors: ["Author"],
        publisher: null,
        publishedDate: null,
        isbn: null,
        coverImageUrl: null,
        addedAt: new Date(),
        readingStatus: "reading" as const,
        startedAt: null,
        completedAt: null,
        note: null,
        noteUpdatedAt: null,
        thoughts: null,
        thoughtsUpdatedAt: null,
        rating: null,
        source: "rakuten" as const,
      },
    ];

    const mockResult = {
      items: mockUserBooks,
      totalCount: 1,
      hasMore: false,
    };

    vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue(
      ok({
        id: 100,
        email: "test@example.com",
        firebaseUid: "firebase-uid",
        name: null,
        avatarUrl: null,
        bio: null,
        instagramHandle: null,
        handle: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      }),
    );
    vi.mocked(mockFollowService.getFollowStatus).mockResolvedValue({
      outgoing: "FOLLOWING",
      incoming: "NONE",
    });
    vi.mocked(mockShelfService.getUserBooksWithPagination).mockResolvedValue(
      ok(mockResult),
    );

    const builder = createTestBuilder();
    registerBooksTypes(builder);
    builder.queryType({});
    registerBooksQueries(
      builder,
      mockSearchService,
      mockShelfService,
      mockUserService,
      mockFollowService,
    );

    const schema = builder.toSchema();
    const queryType = schema.getQueryType();
    const userShelfField = queryType?.getFields().userShelf;

    expect(userShelfField).toBeDefined();

    const result = await userShelfField?.resolve?.(
      {},
      { userId: 200, input: { limit: 20, offset: 0 } },
      {
        requestId: "test",
        user: {
          uid: "firebase-uid",
          email: "test@example.com",
          emailVerified: true,
        },
      },
      {} as never,
    );

    expect(mockFollowService.getFollowStatus).toHaveBeenCalledWith(100, 200);
    expect(mockShelfService.getUserBooksWithPagination).toHaveBeenCalledWith(
      200,
      { limit: 20, offset: 0 },
    );
    expect(result).toEqual(mockResult);
  });

  it("should throw FORBIDDEN error when user is not following the target", async () => {
    const mockSearchService = createMockSearchService();
    const mockShelfService = createMockShelfService();
    const mockUserService = createMockUserService();
    const mockFollowService = createMockFollowService();

    vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue(
      ok({
        id: 100,
        email: "test@example.com",
        firebaseUid: "firebase-uid",
        name: null,
        avatarUrl: null,
        bio: null,
        instagramHandle: null,
        handle: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      }),
    );
    vi.mocked(mockFollowService.getFollowStatus).mockResolvedValue({
      outgoing: "NONE",
      incoming: "NONE",
    });

    const builder = createTestBuilder();
    registerBooksTypes(builder);
    builder.queryType({});
    registerBooksQueries(
      builder,
      mockSearchService,
      mockShelfService,
      mockUserService,
      mockFollowService,
    );

    const schema = builder.toSchema();
    const queryType = schema.getQueryType();
    const userShelfField = queryType?.getFields().userShelf;

    await expect(
      userShelfField?.resolve?.(
        {},
        { userId: 200 },
        {
          requestId: "test",
          user: {
            uid: "firebase-uid",
            email: "test@example.com",
            emailVerified: true,
          },
        },
        {} as never,
      ),
    ).rejects.toThrow();

    expect(mockShelfService.getUserBooksWithPagination).not.toHaveBeenCalled();
  });

  it("should return shelf data when viewing own profile without follow check", async () => {
    const mockSearchService = createMockSearchService();
    const mockShelfService = createMockShelfService();
    const mockUserService = createMockUserService();
    const mockFollowService = createMockFollowService();

    const mockUserBooks = [
      {
        id: 1,
        userId: 100,
        externalId: "book-1",
        title: "My Book",
        authors: ["Author"],
        publisher: null,
        publishedDate: null,
        isbn: null,
        coverImageUrl: null,
        addedAt: new Date(),
        readingStatus: "reading" as const,
        startedAt: null,
        completedAt: null,
        note: null,
        noteUpdatedAt: null,
        thoughts: null,
        thoughtsUpdatedAt: null,
        rating: null,
        source: "rakuten" as const,
      },
    ];

    const mockResult = {
      items: mockUserBooks,
      totalCount: 1,
      hasMore: false,
    };

    vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue(
      ok({
        id: 100,
        email: "test@example.com",
        firebaseUid: "firebase-uid",
        name: null,
        avatarUrl: null,
        bio: null,
        instagramHandle: null,
        handle: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      }),
    );
    vi.mocked(mockShelfService.getUserBooksWithPagination).mockResolvedValue(
      ok(mockResult),
    );

    const builder = createTestBuilder();
    registerBooksTypes(builder);
    builder.queryType({});
    registerBooksQueries(
      builder,
      mockSearchService,
      mockShelfService,
      mockUserService,
      mockFollowService,
    );

    const schema = builder.toSchema();
    const queryType = schema.getQueryType();
    const userShelfField = queryType?.getFields().userShelf;

    const result = await userShelfField?.resolve?.(
      {},
      { userId: 100, input: { limit: 20, offset: 0 } },
      {
        requestId: "test",
        user: {
          uid: "firebase-uid",
          email: "test@example.com",
          emailVerified: true,
        },
      },
      {} as never,
    );

    expect(mockFollowService.getFollowStatus).not.toHaveBeenCalled();
    expect(mockShelfService.getUserBooksWithPagination).toHaveBeenCalledWith(
      100,
      { limit: 20, offset: 0 },
    );
    expect(result).toEqual(mockResult);
  });
});
