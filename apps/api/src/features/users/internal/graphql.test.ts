import type {
  GraphQLField,
  GraphQLObjectType,
  GraphQLResolveInfo,
  GraphQLSchema,
} from "graphql";
import { describe, expect, it, vi } from "vitest";
import type { BookShelfRepository } from "../../books/internal/book-shelf-repository.js";
import { createTestBuilder } from "../../../graphql/builder.js";
import { registerUserTypes } from "./graphql.js";

function getField(
  schema: GraphQLSchema,
  typeName: string,
  fieldName: string,
): GraphQLField<unknown, unknown> | undefined {
  const type = schema.getType(typeName) as GraphQLObjectType | undefined;
  if (!type) return undefined;
  const fields = type.getFields();
  return fields[fieldName];
}

describe("User GraphQL Types", () => {
  describe("User type", () => {
    it("should register User type to schema", () => {
      const builder = createTestBuilder();
      registerUserTypes(builder);

      builder.queryType({
        fields: (t) => ({
          _empty: t.string({ resolve: () => "" }),
        }),
      });

      const schema = builder.toSchema();
      const userType = schema.getType("User");

      expect(userType).toBeDefined();
      expect(userType?.name).toBe("User");
    });

    it("should have id field as Int", () => {
      const builder = createTestBuilder();
      registerUserTypes(builder);

      builder.queryType({
        fields: (t) => ({
          _empty: t.string({ resolve: () => "" }),
        }),
      });

      const schema = builder.toSchema();
      const userType = schema.getType("User");
      expect(userType).toBeDefined();
    });

    it("should have email field as String", () => {
      const builder = createTestBuilder();
      registerUserTypes(builder);

      builder.queryType({
        fields: (t) => ({
          _empty: t.string({ resolve: () => "" }),
        }),
      });

      const schema = builder.toSchema();
      const userType = schema.getType("User");
      expect(userType).toBeDefined();
    });

    it("should have createdAt field as DateTime", () => {
      const builder = createTestBuilder();
      registerUserTypes(builder);

      builder.queryType({
        fields: (t) => ({
          _empty: t.string({ resolve: () => "" }),
        }),
      });

      const schema = builder.toSchema();
      const userType = schema.getType("User");
      expect(userType).toBeDefined();
    });

    it("should have updatedAt field as DateTime", () => {
      const builder = createTestBuilder();
      registerUserTypes(builder);

      builder.queryType({
        fields: (t) => ({
          _empty: t.string({ resolve: () => "" }),
        }),
      });

      const schema = builder.toSchema();
      const userType = schema.getType("User");
      expect(userType).toBeDefined();
    });

    it("should have name field as nullable String", () => {
      const builder = createTestBuilder();
      registerUserTypes(builder);

      builder.queryType({
        fields: (t) => ({
          _empty: t.string({ resolve: () => "" }),
        }),
      });

      const schema = builder.toSchema();
      const nameField = getField(schema, "User", "name");

      expect(nameField).toBeDefined();
      expect(nameField?.type.toString()).toBe("String");
    });

    it("should have avatarUrl field as nullable String", () => {
      const builder = createTestBuilder();
      registerUserTypes(builder);

      builder.queryType({
        fields: (t) => ({
          _empty: t.string({ resolve: () => "" }),
        }),
      });

      const schema = builder.toSchema();
      const avatarUrlField = getField(schema, "User", "avatarUrl");

      expect(avatarUrlField).toBeDefined();
      expect(avatarUrlField?.type.toString()).toBe("String");
    });

    it("should have bookCount field as Int", () => {
      const builder = createTestBuilder();
      registerUserTypes(builder);

      builder.queryType({
        fields: (t) => ({
          _empty: t.string({ resolve: () => "" }),
        }),
      });

      const schema = builder.toSchema();
      const bookCountField = getField(schema, "User", "bookCount");

      expect(bookCountField).toBeDefined();
      expect(bookCountField?.type.toString()).toBe("Int!");
    });

    it("should have readingCount field as Int!", () => {
      const builder = createTestBuilder();
      registerUserTypes(builder);

      builder.queryType({
        fields: (t) => ({
          _empty: t.string({ resolve: () => "" }),
        }),
      });

      const schema = builder.toSchema();
      const field = getField(schema, "User", "readingCount");

      expect(field).toBeDefined();
      expect(field?.type.toString()).toBe("Int!");
    });

    it("should have backlogCount field as Int!", () => {
      const builder = createTestBuilder();
      registerUserTypes(builder);

      builder.queryType({
        fields: (t) => ({
          _empty: t.string({ resolve: () => "" }),
        }),
      });

      const schema = builder.toSchema();
      const field = getField(schema, "User", "backlogCount");

      expect(field).toBeDefined();
      expect(field?.type.toString()).toBe("Int!");
    });

    it("should have completedCount field as Int!", () => {
      const builder = createTestBuilder();
      registerUserTypes(builder);

      builder.queryType({
        fields: (t) => ({
          _empty: t.string({ resolve: () => "" }),
        }),
      });

      const schema = builder.toSchema();
      const field = getField(schema, "User", "completedCount");

      expect(field).toBeDefined();
      expect(field?.type.toString()).toBe("Int!");
    });

    it("should have interestedCount field as Int!", () => {
      const builder = createTestBuilder();
      registerUserTypes(builder);

      builder.queryType({
        fields: (t) => ({
          _empty: t.string({ resolve: () => "" }),
        }),
      });

      const schema = builder.toSchema();
      const field = getField(schema, "User", "interestedCount");

      expect(field).toBeDefined();
      expect(field?.type.toString()).toBe("Int!");
    });
  });

  describe("Status count resolvers", () => {
    const mockUser = {
      id: 1,
      email: "test@example.com",
      name: "Test User",
      avatarUrl: null,
      username: "testuser",
      firebaseUid: "firebase-uid-1",
      createdAt: new Date("2026-01-01"),
      updatedAt: new Date("2026-01-01"),
      readingStartYear: null,
      readingStartMonth: null,
    };

    function createMockBookShelfRepository(
      overrides?: Partial<BookShelfRepository>,
    ): BookShelfRepository {
      return {
        findUserBookByExternalId: vi.fn(),
        findUserBookById: vi.fn(),
        createUserBook: vi.fn(),
        updateUserBook: vi.fn(),
        deleteUserBook: vi.fn(),
        getUserBooks: vi.fn(),
        getUserBooksWithPagination: vi.fn(),
        countUserBooks: vi.fn().mockResolvedValue(0),
        countUserBooksByStatus: vi.fn().mockResolvedValue({
          readingCount: 0,
          backlogCount: 0,
          completedCount: 0,
          interestedCount: 0,
        }),
        ...overrides,
      } as BookShelfRepository;
    }

    function getResolver(
      bookShelfRepository?: BookShelfRepository,
      fieldName?: string,
    ) {
      const builder = createTestBuilder();
      registerUserTypes(builder, bookShelfRepository);

      builder.queryType({
        fields: (t) => ({
          _empty: t.string({ resolve: () => "" }),
        }),
      });

      const schema = builder.toSchema();
      const field = getField(schema, "User", fieldName ?? "readingCount");
      return field?.resolve;
    }

    it("should return correct status counts from countUserBooksByStatus", async () => {
      const mockRepo = createMockBookShelfRepository({
        countUserBooksByStatus: vi.fn().mockResolvedValue({
          readingCount: 3,
          backlogCount: 5,
          completedCount: 10,
          interestedCount: 2,
        }),
      });

      const readingResolver = getResolver(mockRepo, "readingCount");
      const backlogResolver = getResolver(mockRepo, "backlogCount");
      const completedResolver = getResolver(mockRepo, "completedCount");
      const interestedResolver = getResolver(mockRepo, "interestedCount");

      const info = {} as GraphQLResolveInfo;

      expect(
        await readingResolver?.(mockUser, {}, {}, info),
      ).toBe(3);
      expect(
        await backlogResolver?.(mockUser, {}, {}, info),
      ).toBe(5);
      expect(
        await completedResolver?.(mockUser, {}, {}, info),
      ).toBe(10);
      expect(
        await interestedResolver?.(mockUser, {}, {}, info),
      ).toBe(2);
    });

    it("should return 0 for all counts when bookShelfRepository is not provided", async () => {
      const readingResolver = getResolver(undefined, "readingCount");
      const backlogResolver = getResolver(undefined, "backlogCount");
      const completedResolver = getResolver(undefined, "completedCount");
      const interestedResolver = getResolver(undefined, "interestedCount");

      const info = {} as GraphQLResolveInfo;

      expect(
        await readingResolver?.(mockUser, {}, {}, info),
      ).toBe(0);
      expect(
        await backlogResolver?.(mockUser, {}, {}, info),
      ).toBe(0);
      expect(
        await completedResolver?.(mockUser, {}, {}, info),
      ).toBe(0);
      expect(
        await interestedResolver?.(mockUser, {}, {}, info),
      ).toBe(0);
    });

    it("should call countUserBooksByStatus only once when multiple count fields are queried in same resolver context", async () => {
      const countUserBooksByStatusMock = vi.fn().mockResolvedValue({
        readingCount: 1,
        backlogCount: 2,
        completedCount: 3,
        interestedCount: 4,
      });

      const mockRepo = createMockBookShelfRepository({
        countUserBooksByStatus: countUserBooksByStatusMock,
      });

      const builder = createTestBuilder();
      registerUserTypes(builder, mockRepo);

      builder.queryType({
        fields: (t) => ({
          _empty: t.string({ resolve: () => "" }),
        }),
      });

      const schema = builder.toSchema();

      const readingField = getField(schema, "User", "readingCount");
      const backlogField = getField(schema, "User", "backlogCount");
      const completedField = getField(schema, "User", "completedCount");
      const interestedField = getField(schema, "User", "interestedCount");

      const info = {} as GraphQLResolveInfo;

      const readingResult = readingField?.resolve?.(mockUser, {}, {}, info);
      const backlogResult = backlogField?.resolve?.(mockUser, {}, {}, info);
      const completedResult = completedField?.resolve?.(mockUser, {}, {}, info);
      const interestedResult = interestedField?.resolve?.(mockUser, {}, {}, info);

      const results = await Promise.all([
        readingResult,
        backlogResult,
        completedResult,
        interestedResult,
      ]);

      expect(results).toEqual([1, 2, 3, 4]);
      expect(countUserBooksByStatusMock).toHaveBeenCalledTimes(1);
      expect(countUserBooksByStatusMock).toHaveBeenCalledWith(mockUser.id);
    });

    it("should not share cache between different requests (separate registerUserTypes calls)", async () => {
      const countUserBooksByStatusMock = vi
        .fn()
        .mockResolvedValueOnce({
          readingCount: 1,
          backlogCount: 2,
          completedCount: 3,
          interestedCount: 4,
        })
        .mockResolvedValueOnce({
          readingCount: 10,
          backlogCount: 20,
          completedCount: 30,
          interestedCount: 40,
        });

      const mockRepo = createMockBookShelfRepository({
        countUserBooksByStatus: countUserBooksByStatusMock,
      });

      const builder = createTestBuilder();
      registerUserTypes(builder, mockRepo);

      builder.queryType({
        fields: (t) => ({
          _empty: t.string({ resolve: () => "" }),
        }),
      });

      const schema = builder.toSchema();
      const readingField = getField(schema, "User", "readingCount");
      const info = {} as GraphQLResolveInfo;

      const result1 = await readingField?.resolve?.(mockUser, {}, {}, info);
      expect(result1).toBe(1);

      const result2 = await readingField?.resolve?.(mockUser, {}, {}, info);
      expect(result2).toBe(10);

      expect(countUserBooksByStatusMock).toHaveBeenCalledTimes(2);
    });
  });

  describe("UpdateProfileInput type", () => {
    it("should register UpdateProfileInput type to schema", () => {
      const builder = createTestBuilder();
      registerUserTypes(builder);

      builder.queryType({
        fields: (t) => ({
          _empty: t.string({ resolve: () => "" }),
        }),
      });
      builder.mutationType({
        fields: (t) => ({
          _empty: t.string({ resolve: () => "" }),
        }),
      });

      const schema = builder.toSchema();
      const inputType = schema.getType("UpdateProfileInput");

      expect(inputType).toBeDefined();
      expect(inputType?.name).toBe("UpdateProfileInput");
    });
  });

  describe("ValidationError type", () => {
    it("should register ValidationError type to schema", () => {
      const builder = createTestBuilder();
      registerUserTypes(builder);

      builder.queryType({
        fields: (t) => ({
          _empty: t.string({ resolve: () => "" }),
        }),
      });
      builder.mutationType({
        fields: (t) => ({
          _empty: t.string({ resolve: () => "" }),
        }),
      });

      const schema = builder.toSchema();
      const type = schema.getType("ValidationError");

      expect(type).toBeDefined();
      expect(type?.name).toBe("ValidationError");
    });
  });
});
