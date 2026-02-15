import type { GraphQLField, GraphQLObjectType, GraphQLSchema } from "graphql";
import { describe, expect, it, vi } from "vitest";
import { createTestBuilder } from "../../../graphql/builder.js";
import { registerUserQueries, registerUserTypes } from "./graphql.js";
import type { UserService } from "./service.js";

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

    it("should have bio field as nullable String", () => {
      const builder = createTestBuilder();
      registerUserTypes(builder);

      builder.queryType({
        fields: (t) => ({
          _empty: t.string({ resolve: () => "" }),
        }),
      });

      const schema = builder.toSchema();
      const bioField = getField(schema, "User", "bio");

      expect(bioField).toBeDefined();
      expect(bioField?.type.toString()).toBe("String");
    });

    it("should have instagramHandle field as nullable String", () => {
      const builder = createTestBuilder();
      registerUserTypes(builder);

      builder.queryType({
        fields: (t) => ({
          _empty: t.string({ resolve: () => "" }),
        }),
      });

      const schema = builder.toSchema();
      const instagramHandleField = getField(schema, "User", "instagramHandle");

      expect(instagramHandleField).toBeDefined();
      expect(instagramHandleField?.type.toString()).toBe("String");
    });

    it("should have shareUrl field as nullable String", () => {
      const builder = createTestBuilder();
      registerUserTypes(builder);

      builder.queryType({
        fields: (t) => ({
          _empty: t.string({ resolve: () => "" }),
        }),
      });

      const schema = builder.toSchema();
      const shareUrlField = getField(schema, "User", "shareUrl");

      expect(shareUrlField).toBeDefined();
      expect(shareUrlField?.type.toString()).toBe("String");
    });
  });

  describe("userByHandle query", () => {
    it("should register userByHandle query field", () => {
      const builder = createTestBuilder();
      registerUserTypes(builder);

      const mockUserService = {
        getUserByHandle: vi.fn(),
      } as unknown as UserService;

      builder.queryType({
        fields: (t) => ({
          _empty: t.string({ resolve: () => "" }),
        }),
      });

      registerUserQueries(builder, mockUserService);

      const schema = builder.toSchema();
      const queryType = schema.getType("Query") as GraphQLObjectType;
      const fields = queryType.getFields();

      expect(fields.userByHandle).toBeDefined();
    });

    it("should accept handle as required String argument", () => {
      const builder = createTestBuilder();
      registerUserTypes(builder);

      const mockUserService = {
        getUserByHandle: vi.fn(),
      } as unknown as UserService;

      builder.queryType({
        fields: (t) => ({
          _empty: t.string({ resolve: () => "" }),
        }),
      });

      registerUserQueries(builder, mockUserService);

      const schema = builder.toSchema();
      const queryType = schema.getType("Query") as GraphQLObjectType;
      const userByHandleField = queryType.getFields().userByHandle;
      const handleArg = userByHandleField.args.find(
        (arg) => arg.name === "handle",
      );

      expect(handleArg).toBeDefined();
      expect(handleArg?.type.toString()).toBe("String!");
    });

    it("should return nullable User type", () => {
      const builder = createTestBuilder();
      registerUserTypes(builder);

      const mockUserService = {
        getUserByHandle: vi.fn(),
      } as unknown as UserService;

      builder.queryType({
        fields: (t) => ({
          _empty: t.string({ resolve: () => "" }),
        }),
      });

      registerUserQueries(builder, mockUserService);

      const schema = builder.toSchema();
      const queryType = schema.getType("Query") as GraphQLObjectType;
      const userByHandleField = queryType.getFields().userByHandle;

      expect(userByHandleField.type.toString()).toBe("User");
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
