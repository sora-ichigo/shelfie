import { getTableName } from "drizzle-orm";
import { describe, expect, it } from "vitest";
import {
  DEVICE_TOKENS_USER_ID_INDEX_NAME,
  DEVICE_TOKENS_USER_TOKEN_UNIQUE_INDEX_NAME,
  type DeviceToken,
  type NewDeviceToken,
  deviceTokens,
} from "./device-tokens.js";

describe("device_tokens schema", () => {
  describe("table definition", () => {
    it("should have table name 'device_tokens'", () => {
      expect(getTableName(deviceTokens)).toBe("device_tokens");
    });

    it("should have id column as identity primary key", () => {
      const idColumn = deviceTokens.id;

      expect(idColumn.name).toBe("id");
      expect(idColumn.notNull).toBe(true);
      expect(idColumn.primary).toBe(true);
    });

    it("should have user_id column as non-null integer with cascade delete", () => {
      const userIdColumn = deviceTokens.userId;

      expect(userIdColumn.name).toBe("user_id");
      expect(userIdColumn.notNull).toBe(true);
    });

    it("should have token column as non-null text", () => {
      const tokenColumn = deviceTokens.token;

      expect(tokenColumn.name).toBe("token");
      expect(tokenColumn.notNull).toBe(true);
    });

    it("should have platform column as non-null text", () => {
      const platformColumn = deviceTokens.platform;

      expect(platformColumn.name).toBe("platform");
      expect(platformColumn.notNull).toBe(true);
    });

    it("should have created_at column with default now", () => {
      const createdAtColumn = deviceTokens.createdAt;

      expect(createdAtColumn.name).toBe("created_at");
      expect(createdAtColumn.notNull).toBe(true);
      expect(createdAtColumn.hasDefault).toBe(true);
    });

    it("should have updated_at column with default now", () => {
      const updatedAtColumn = deviceTokens.updatedAt;

      expect(updatedAtColumn.name).toBe("updated_at");
      expect(updatedAtColumn.notNull).toBe(true);
      expect(updatedAtColumn.hasDefault).toBe(true);
    });
  });

  describe("index definitions", () => {
    it("should have user_token unique index name constant", () => {
      expect(DEVICE_TOKENS_USER_TOKEN_UNIQUE_INDEX_NAME).toBe(
        "idx_device_tokens_user_token",
      );
    });

    it("should have user_id index name constant", () => {
      expect(DEVICE_TOKENS_USER_ID_INDEX_NAME).toBe(
        "idx_device_tokens_user_id",
      );
    });
  });

  describe("type inference", () => {
    it("should infer DeviceToken type for select operations", () => {
      const deviceToken: DeviceToken = {
        id: 1,
        userId: 42,
        token: "fcm-token-abc123",
        platform: "ios",
        createdAt: new Date(),
        updatedAt: new Date(),
      };

      expect(deviceToken.id).toBe(1);
      expect(deviceToken.userId).toBe(42);
      expect(deviceToken.token).toBe("fcm-token-abc123");
      expect(deviceToken.platform).toBe("ios");
      expect(deviceToken.createdAt).toBeInstanceOf(Date);
      expect(deviceToken.updatedAt).toBeInstanceOf(Date);
    });

    it("should infer NewDeviceToken type for insert operations (id should be optional)", () => {
      const newDeviceToken: NewDeviceToken = {
        userId: 42,
        token: "fcm-token-abc123",
        platform: "android",
      };

      expect(newDeviceToken.userId).toBe(42);
      expect(newDeviceToken.token).toBe("fcm-token-abc123");
      expect(newDeviceToken.platform).toBe("android");
      expect("id" in newDeviceToken).toBe(false);
    });

    it("should allow createdAt and updatedAt to be optional in NewDeviceToken", () => {
      const newDeviceToken: NewDeviceToken = {
        userId: 42,
        token: "fcm-token-abc123",
        platform: "ios",
      };

      expect(newDeviceToken.createdAt).toBeUndefined();
      expect(newDeviceToken.updatedAt).toBeUndefined();
    });
  });
});
