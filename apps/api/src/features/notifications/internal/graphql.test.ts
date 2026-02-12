import type {
  GraphQLEnumType,
  GraphQLField,
  GraphQLObjectType,
  GraphQLSchema,
} from "graphql";
import { describe, expect, it, vi } from "vitest";
import { createTestBuilder } from "../../../graphql/builder.js";
import { registerUserTypes } from "../../users/internal/graphql.js";
import type { UserService } from "../../users/internal/service.js";
import {
  registerNotificationMutations,
  registerNotificationQueries,
  registerNotificationTypes,
} from "./graphql.js";
import type { NotificationAppService } from "./service.js";

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

function createMockService(): NotificationAppService {
  return {
    createNotification: vi.fn(),
    getNotifications: vi.fn(),
    getUnreadCount: vi.fn(),
    markAllAsRead: vi.fn(),
    deleteNotification: vi.fn(),
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

function buildTestSchema(mockService?: NotificationAppService) {
  const builder = createTestBuilder();
  const service = mockService ?? createMockService();
  const userService = createMockUserService();

  registerUserTypes(builder);
  registerNotificationTypes(builder);

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

  registerNotificationQueries(builder, service, userService);
  registerNotificationMutations(builder, service, userService);

  return builder.toSchema();
}

describe("Notification GraphQL Types", () => {
  describe("NotificationType enum", () => {
    it("should register NotificationType enum to schema", () => {
      const schema = buildTestSchema();
      const enumType = schema.getType("NotificationType") as
        | GraphQLEnumType
        | undefined;

      expect(enumType).toBeDefined();
      expect(enumType?.name).toBe("NotificationType");
    });

    it("should have FOLLOW_REQUEST_RECEIVED value", () => {
      const schema = buildTestSchema();
      const enumType = schema.getType("NotificationType") as GraphQLEnumType;
      const values = enumType.getValues().map((v) => v.name);

      expect(values).toContain("FOLLOW_REQUEST_RECEIVED");
    });

    it("should have FOLLOW_REQUEST_APPROVED value", () => {
      const schema = buildTestSchema();
      const enumType = schema.getType("NotificationType") as GraphQLEnumType;
      const values = enumType.getValues().map((v) => v.name);

      expect(values).toContain("FOLLOW_REQUEST_APPROVED");
    });
  });

  describe("AppNotification type", () => {
    it("should register AppNotification type to schema", () => {
      const schema = buildTestSchema();
      const type = schema.getType("AppNotification");

      expect(type).toBeDefined();
      expect(type?.name).toBe("AppNotification");
    });

    it("should have id field as Int!", () => {
      const schema = buildTestSchema();
      const field = getField(schema, "AppNotification", "id");

      expect(field).toBeDefined();
      expect(field?.type.toString()).toBe("Int!");
    });

    it("should have sender field as User!", () => {
      const schema = buildTestSchema();
      const field = getField(schema, "AppNotification", "sender");

      expect(field).toBeDefined();
      expect(field?.type.toString()).toBe("User!");
    });

    it("should have type field as NotificationType!", () => {
      const schema = buildTestSchema();
      const field = getField(schema, "AppNotification", "type");

      expect(field).toBeDefined();
      expect(field?.type.toString()).toBe("NotificationType!");
    });

    it("should have isRead field as Boolean!", () => {
      const schema = buildTestSchema();
      const field = getField(schema, "AppNotification", "isRead");

      expect(field).toBeDefined();
      expect(field?.type.toString()).toBe("Boolean!");
    });

    it("should have createdAt field as DateTime!", () => {
      const schema = buildTestSchema();
      const field = getField(schema, "AppNotification", "createdAt");

      expect(field).toBeDefined();
      expect(field?.type.toString()).toBe("DateTime!");
    });
  });

  describe("Queries", () => {
    it("should register notifications query", () => {
      const schema = buildTestSchema();
      const queryType = schema.getQueryType();
      const fields = queryType?.getFields();

      expect(fields?.notifications).toBeDefined();
    });

    it("should register unreadNotificationCount query", () => {
      const schema = buildTestSchema();
      const queryType = schema.getQueryType();
      const fields = queryType?.getFields();

      expect(fields?.unreadNotificationCount).toBeDefined();
    });

    it("notifications query should return [AppNotification!]!", () => {
      const schema = buildTestSchema();
      const queryType = schema.getQueryType();
      const field = queryType?.getFields().notifications;

      expect(field?.type.toString()).toBe("[AppNotification!]!");
    });

    it("unreadNotificationCount query should return Int!", () => {
      const schema = buildTestSchema();
      const queryType = schema.getQueryType();
      const field = queryType?.getFields().unreadNotificationCount;

      expect(field?.type.toString()).toBe("Int!");
    });
  });

  describe("Mutations", () => {
    it("should register markNotificationsAsRead mutation", () => {
      const schema = buildTestSchema();
      const mutationType = schema.getMutationType();
      const fields = mutationType?.getFields();

      expect(fields?.markNotificationsAsRead).toBeDefined();
    });
  });
});
