import type {
  GraphQLEnumType,
  GraphQLField,
  GraphQLObjectType,
  GraphQLSchema,
} from "graphql";
import { describe, expect, it, vi } from "vitest";
import { createTestBuilder } from "../../../graphql/builder.js";
import { registerUserTypes } from "../../users/internal/graphql.js";
import {
  registerFollowMutations,
  registerFollowQueries,
  registerFollowTypes,
} from "./graphql.js";
import type { FollowService } from "./service.js";

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

function buildTestSchema(service?: FollowService): GraphQLSchema {
  const builder = createTestBuilder();
  registerUserTypes(builder);
  registerFollowTypes(builder);

  builder.queryType({});
  builder.mutationType({});

  const followService = service ?? createMockFollowService();
  registerFollowQueries(builder, followService);
  registerFollowMutations(builder, followService);

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

describe("Follow GraphQL Types", () => {
  describe("FollowRequestStatus enum", () => {
    it("should register FollowRequestStatus enum to schema", () => {
      const schema = buildTestSchema();
      const enumType = schema.getType("FollowRequestStatus") as GraphQLEnumType;

      expect(enumType).toBeDefined();
      expect(enumType?.name).toBe("FollowRequestStatus");
    });

    it("should have PENDING, APPROVED, REJECTED values", () => {
      const schema = buildTestSchema();
      const enumType = schema.getType("FollowRequestStatus") as GraphQLEnumType;
      const values = enumType.getValues().map((v) => v.name);

      expect(values).toContain("PENDING");
      expect(values).toContain("APPROVED");
      expect(values).toContain("REJECTED");
    });
  });

  describe("FollowStatus enum", () => {
    it("should register FollowStatus enum to schema", () => {
      const schema = buildTestSchema();
      const enumType = schema.getType("FollowStatus") as GraphQLEnumType;

      expect(enumType).toBeDefined();
      expect(enumType?.name).toBe("FollowStatus");
    });

    it("should have NONE, PENDING_SENT, PENDING_RECEIVED, FOLLOWING, FOLLOWED_BY values", () => {
      const schema = buildTestSchema();
      const enumType = schema.getType("FollowStatus") as GraphQLEnumType;
      const values = enumType.getValues().map((v) => v.name);

      expect(values).toContain("NONE");
      expect(values).toContain("PENDING_SENT");
      expect(values).toContain("PENDING_RECEIVED");
      expect(values).toContain("FOLLOWING");
      expect(values).toContain("FOLLOWED_BY");
      expect(values).not.toContain("PENDING");
    });
  });

  describe("FollowRequest type", () => {
    it("should register FollowRequest type to schema", () => {
      const schema = buildTestSchema();
      const type = schema.getType("FollowRequest");

      expect(type).toBeDefined();
      expect(type?.name).toBe("FollowRequest");
    });

    it("should have id field", () => {
      const schema = buildTestSchema();
      const field = getField(schema, "FollowRequest", "id");
      expect(field).toBeDefined();
    });

    it("should have status field", () => {
      const schema = buildTestSchema();
      const field = getField(schema, "FollowRequest", "status");
      expect(field).toBeDefined();
    });

    it("should have createdAt field", () => {
      const schema = buildTestSchema();
      const field = getField(schema, "FollowRequest", "createdAt");
      expect(field).toBeDefined();
    });
  });

  describe("FollowCounts type", () => {
    it("should register FollowCounts type to schema", () => {
      const schema = buildTestSchema();
      const type = schema.getType("FollowCounts");

      expect(type).toBeDefined();
      expect(type?.name).toBe("FollowCounts");
    });

    it("should have followingCount field", () => {
      const schema = buildTestSchema();
      const field = getField(schema, "FollowCounts", "followingCount");
      expect(field).toBeDefined();
    });

    it("should have followerCount field", () => {
      const schema = buildTestSchema();
      const field = getField(schema, "FollowCounts", "followerCount");
      expect(field).toBeDefined();
    });
  });

  describe("UserProfile type", () => {
    it("should register UserProfile type to schema", () => {
      const schema = buildTestSchema();
      const type = schema.getType("UserProfile");

      expect(type).toBeDefined();
      expect(type?.name).toBe("UserProfile");
    });

    it("should have outgoingFollowStatus field", () => {
      const schema = buildTestSchema();
      const field = getField(schema, "UserProfile", "outgoingFollowStatus");
      expect(field).toBeDefined();
    });

    it("should have incomingFollowStatus field", () => {
      const schema = buildTestSchema();
      const field = getField(schema, "UserProfile", "incomingFollowStatus");
      expect(field).toBeDefined();
    });

    it("should have isOwnProfile field", () => {
      const schema = buildTestSchema();
      const field = getField(schema, "UserProfile", "isOwnProfile");
      expect(field).toBeDefined();
    });
  });

  describe("Queries", () => {
    it("should register pendingFollowRequests query", () => {
      const schema = buildTestSchema();
      const query = getField(schema, "Query", "pendingFollowRequests");
      expect(query).toBeDefined();
    });

    it("should register pendingFollowRequestCount query", () => {
      const schema = buildTestSchema();
      const query = getField(schema, "Query", "pendingFollowRequestCount");
      expect(query).toBeDefined();
    });

    it("should register following query", () => {
      const schema = buildTestSchema();
      const query = getField(schema, "Query", "following");
      expect(query).toBeDefined();
    });

    it("should register followers query", () => {
      const schema = buildTestSchema();
      const query = getField(schema, "Query", "followers");
      expect(query).toBeDefined();
    });

    it("should register followCounts query", () => {
      const schema = buildTestSchema();
      const query = getField(schema, "Query", "followCounts");
      expect(query).toBeDefined();
    });

    it("should register userProfile query", () => {
      const schema = buildTestSchema();
      const query = getField(schema, "Query", "userProfile");
      expect(query).toBeDefined();
    });
  });

  describe("Mutations", () => {
    it("should register sendFollowRequest mutation", () => {
      const schema = buildTestSchema();
      const mutation = getField(schema, "Mutation", "sendFollowRequest");
      expect(mutation).toBeDefined();
    });

    it("should register approveFollowRequest mutation", () => {
      const schema = buildTestSchema();
      const mutation = getField(schema, "Mutation", "approveFollowRequest");
      expect(mutation).toBeDefined();
    });

    it("should register rejectFollowRequest mutation", () => {
      const schema = buildTestSchema();
      const mutation = getField(schema, "Mutation", "rejectFollowRequest");
      expect(mutation).toBeDefined();
    });

    it("should register unfollow mutation", () => {
      const schema = buildTestSchema();
      const mutation = getField(schema, "Mutation", "unfollow");
      expect(mutation).toBeDefined();
    });
  });
});
