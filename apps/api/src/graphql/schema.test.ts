import { describe, expect, it } from "vitest";
import { buildSchema, schema } from "./schema";

describe("GraphQL Schema", () => {
  describe("schema export", () => {
    it("should export a valid GraphQL schema", () => {
      expect(schema).toBeDefined();
      expect(schema.getQueryType()).toBeDefined();
    });

    it("should have Query type", () => {
      const queryType = schema.getQueryType();
      expect(queryType).toBeDefined();
      expect(queryType?.name).toBe("Query");
    });
  });

  describe("buildSchema function", () => {
    it("should return a valid GraphQL schema", () => {
      const builtSchema = buildSchema();
      expect(builtSchema).toBeDefined();
      expect(builtSchema.getQueryType()).toBeDefined();
    });
  });

  describe("health query", () => {
    it("should have health query field", () => {
      const queryType = schema.getQueryType();
      const healthField = queryType?.getFields().health;
      expect(healthField).toBeDefined();
    });
  });

  describe("DateTime scalar in schema", () => {
    it("should have DateTime scalar type available", () => {
      const dateTimeType = schema.getType("DateTime");
      expect(dateTimeType).toBeDefined();
      expect(dateTimeType?.name).toBe("DateTime");
    });
  });
});
