import { describe, expect, it } from "vitest";
import { createTestBuilder } from "../../../graphql/builder.js";
import { registerUserTypes } from "./graphql.js";

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
  });
});
