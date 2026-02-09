import type {
  GraphQLField,
  GraphQLInputObjectType,
  GraphQLObjectType,
  GraphQLSchema,
} from "graphql";
import { describe, expect, it, vi } from "vitest";
import { createTestBuilder } from "../../../graphql/builder.js";
import type { DeviceTokenService } from "./service.js";
import {
  registerDeviceTokenMutations,
  registerDeviceTokenTypes,
} from "./graphql.js";

function createMockDeviceTokenService(): DeviceTokenService {
  return {
    registerToken: vi.fn(),
    unregisterToken: vi.fn(),
  };
}

function buildTestSchema(
  service?: DeviceTokenService,
): GraphQLSchema {
  const builder = createTestBuilder();
  registerDeviceTokenTypes(builder);

  builder.queryType({
    fields: (t) => ({
      _empty: t.string({ resolve: () => "" }),
    }),
  });

  builder.mutationType({});

  registerDeviceTokenMutations(
    builder,
    service ?? createMockDeviceTokenService(),
  );

  return builder.toSchema();
}

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

describe("DeviceToken GraphQL Types", () => {
  describe("DeviceToken type", () => {
    it("should register DeviceToken type to schema", () => {
      const schema = buildTestSchema();
      const deviceTokenType = schema.getType("DeviceToken");

      expect(deviceTokenType).toBeDefined();
      expect(deviceTokenType?.name).toBe("DeviceToken");
    });

    it("should have id field", () => {
      const schema = buildTestSchema();
      const field = getField(schema, "DeviceToken", "id");

      expect(field).toBeDefined();
    });

    it("should have userId field", () => {
      const schema = buildTestSchema();
      const field = getField(schema, "DeviceToken", "userId");

      expect(field).toBeDefined();
    });

    it("should have platform field", () => {
      const schema = buildTestSchema();
      const field = getField(schema, "DeviceToken", "platform");

      expect(field).toBeDefined();
    });

    it("should have createdAt field", () => {
      const schema = buildTestSchema();
      const field = getField(schema, "DeviceToken", "createdAt");

      expect(field).toBeDefined();
    });
  });

  describe("RegisterDeviceTokenInput type", () => {
    it("should register RegisterDeviceTokenInput to schema", () => {
      const schema = buildTestSchema();
      const inputType = schema.getType(
        "RegisterDeviceTokenInput",
      ) as GraphQLInputObjectType;

      expect(inputType).toBeDefined();
      expect(inputType?.name).toBe("RegisterDeviceTokenInput");
    });

    it("should have token as required String field", () => {
      const schema = buildTestSchema();
      const inputType = schema.getType(
        "RegisterDeviceTokenInput",
      ) as GraphQLInputObjectType;
      const fields = inputType.getFields();

      expect(fields.token).toBeDefined();
      expect(fields.token.type.toString()).toBe("String!");
    });

    it("should have platform as required String field", () => {
      const schema = buildTestSchema();
      const inputType = schema.getType(
        "RegisterDeviceTokenInput",
      ) as GraphQLInputObjectType;
      const fields = inputType.getFields();

      expect(fields.platform).toBeDefined();
      expect(fields.platform.type.toString()).toBe("String!");
    });
  });

  describe("UnregisterDeviceTokenInput type", () => {
    it("should register UnregisterDeviceTokenInput to schema", () => {
      const schema = buildTestSchema();
      const inputType = schema.getType(
        "UnregisterDeviceTokenInput",
      ) as GraphQLInputObjectType;

      expect(inputType).toBeDefined();
      expect(inputType?.name).toBe("UnregisterDeviceTokenInput");
    });

    it("should have token as required String field", () => {
      const schema = buildTestSchema();
      const inputType = schema.getType(
        "UnregisterDeviceTokenInput",
      ) as GraphQLInputObjectType;
      const fields = inputType.getFields();

      expect(fields.token).toBeDefined();
      expect(fields.token.type.toString()).toBe("String!");
    });
  });

  describe("Mutations", () => {
    it("should register registerDeviceToken mutation", () => {
      const schema = buildTestSchema();
      const mutation = getField(schema, "Mutation", "registerDeviceToken");

      expect(mutation).toBeDefined();
    });

    it("should register unregisterDeviceToken mutation", () => {
      const schema = buildTestSchema();
      const mutation = getField(schema, "Mutation", "unregisterDeviceToken");

      expect(mutation).toBeDefined();
    });
  });
});
