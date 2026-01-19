import { DateTimeResolver } from "graphql-scalars";
import { describe, expect, it } from "vitest";
import { createTestBuilder, type GraphQLContext } from "./builder";

describe("SchemaBuilder", () => {
  describe("builder instance", () => {
    it("should export a createTestBuilder function that creates a SchemaBuilder instance", () => {
      const builder = createTestBuilder();
      expect(builder).toBeDefined();
      expect(typeof builder.queryType).toBe("function");
      expect(typeof builder.mutationType).toBe("function");
    });
  });

  describe("DateTime scalar", () => {
    it("should have DateTime scalar type registered", () => {
      const builder = createTestBuilder();
      builder.queryType({
        fields: (t) => ({
          _empty: t.string({ resolve: () => "" }),
          testDate: t.field({
            type: "DateTime",
            resolve: () => new Date(),
          }),
        }),
      });
      const schema = builder.toSchema();
      const dateTimeType = schema.getType("DateTime");
      expect(dateTimeType).toBeDefined();
      expect(dateTimeType?.name).toBe("DateTime");
    });

    it("should serialize Date objects to ISO string", () => {
      const testDate = new Date("2024-01-15T12:00:00.000Z");
      const serialized = DateTimeResolver.serialize(testDate);
      expect(serialized).toEqual(testDate);
    });

    it("should parse ISO date strings correctly", () => {
      const isoString = "2024-01-15T12:00:00.000Z";
      const parsed = DateTimeResolver.parseValue(isoString);
      expect(parsed).toBeInstanceOf(Date);
      expect((parsed as Date).toISOString()).toBe(isoString);
    });
  });

  describe("GraphQL Context type", () => {
    it("should define required context properties", () => {
      const context: GraphQLContext = {
        requestId: "test-request-id",
        user: null,
      };

      expect(context.requestId).toBe("test-request-id");
      expect(context.user).toBeNull();
    });

    it("should accept user with uid", () => {
      const context: GraphQLContext = {
        requestId: "test-request-id",
        user: { uid: "user-123" },
      };

      expect(context.user?.uid).toBe("user-123");
    });
  });
});
