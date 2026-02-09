import { describe, expect, it, vi } from "vitest";
import type { DeviceToken } from "../../db/schema/device-tokens.js";
import type { FCMAdapter } from "../../features/device-tokens/internal/fcm-adapter.js";
import { createNotificationService } from "../../features/device-tokens/internal/notification-service.js";
import type { DeviceTokenRepository } from "../../features/device-tokens/internal/repository.js";
import { createDeviceTokenService } from "../../features/device-tokens/internal/service.js";
import type { LoggerService } from "../../logger/index.js";

function createMockRepository(): DeviceTokenRepository {
  return {
    upsert: vi.fn(),
    deleteByUserAndToken: vi.fn(),
    deleteByTokens: vi.fn(),
    findByUserId: vi.fn(),
    findByUserIds: vi.fn(),
    findAll: vi.fn(),
  };
}

function createMockFCMAdapter(): FCMAdapter {
  return {
    sendMulticast: vi.fn(),
  };
}

function createMockLogger(): LoggerService {
  return {
    debug: vi.fn(),
    info: vi.fn(),
    warn: vi.fn(),
    error: vi.fn(),
    child: vi.fn().mockReturnThis(),
  };
}

function createMockDeviceToken(
  overrides: Partial<DeviceToken> = {},
): DeviceToken {
  return {
    id: 1,
    userId: 1,
    token: "fcm-token-1",
    platform: "ios",
    createdAt: new Date(),
    updatedAt: new Date(),
    ...overrides,
  };
}

describe("Notification Integration (mocked FCM)", () => {
  describe("token registration through notification send", () => {
    it("should register tokens and send notification in a complete flow", async () => {
      const mockRepo = createMockRepository();
      const mockFCM = createMockFCMAdapter();
      const mockLogger = createMockLogger();

      const deviceTokenService = createDeviceTokenService(mockRepo);
      const notificationService = createNotificationService(
        mockRepo,
        mockFCM,
        mockLogger,
      );

      const registeredToken = createMockDeviceToken({
        id: 1,
        userId: 1,
        token: "user1-token",
      });
      vi.mocked(mockRepo.upsert).mockResolvedValue(registeredToken);

      const registerResult = await deviceTokenService.registerToken({
        userId: 1,
        token: "user1-token",
        platform: "ios",
      });
      expect(registerResult.success).toBe(true);

      vi.mocked(mockRepo.findAll).mockResolvedValue([registeredToken]);
      vi.mocked(mockFCM.sendMulticast).mockResolvedValue({
        successCount: 1,
        failureCount: 0,
        responses: [{ success: true, token: "user1-token" }],
      });

      const sendResult = await notificationService.sendNotification({
        title: "Welcome",
        body: "Hello!",
        userIds: "all",
      });

      expect(sendResult.success).toBe(true);
      if (sendResult.success) {
        expect(sendResult.data.totalTargets).toBe(1);
        expect(sendResult.data.successCount).toBe(1);
        expect(sendResult.data.failureCount).toBe(0);
      }
    });
  });

  describe("send to specific users", () => {
    it("should send notification only to specified user IDs", async () => {
      const mockRepo = createMockRepository();
      const mockFCM = createMockFCMAdapter();
      const mockLogger = createMockLogger();

      const notificationService = createNotificationService(
        mockRepo,
        mockFCM,
        mockLogger,
      );

      const userTokens = [
        createMockDeviceToken({ id: 1, userId: 1, token: "token-user1" }),
        createMockDeviceToken({ id: 2, userId: 2, token: "token-user2" }),
      ];
      vi.mocked(mockRepo.findByUserIds).mockResolvedValue(userTokens);
      vi.mocked(mockFCM.sendMulticast).mockResolvedValue({
        successCount: 2,
        failureCount: 0,
        responses: [
          { success: true, token: "token-user1" },
          { success: true, token: "token-user2" },
        ],
      });

      const result = await notificationService.sendNotification({
        title: "Update",
        body: "New feature!",
        userIds: [1, 2],
      });

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.totalTargets).toBe(2);
        expect(result.data.successCount).toBe(2);
      }
      expect(mockRepo.findByUserIds).toHaveBeenCalledWith([1, 2]);
    });
  });

  describe("invalid token cleanup during send", () => {
    it("should remove invalid tokens and report failures", async () => {
      const mockRepo = createMockRepository();
      const mockFCM = createMockFCMAdapter();
      const mockLogger = createMockLogger();

      const notificationService = createNotificationService(
        mockRepo,
        mockFCM,
        mockLogger,
      );

      const tokens = [
        createMockDeviceToken({ id: 1, userId: 1, token: "valid-token" }),
        createMockDeviceToken({ id: 2, userId: 2, token: "stale-token" }),
        createMockDeviceToken({ id: 3, userId: 3, token: "error-token" }),
      ];
      vi.mocked(mockRepo.findAll).mockResolvedValue(tokens);
      vi.mocked(mockFCM.sendMulticast).mockResolvedValue({
        successCount: 1,
        failureCount: 2,
        responses: [
          { success: true, token: "valid-token" },
          {
            success: false,
            token: "stale-token",
            error: {
              code: "messaging/registration-token-not-registered",
              message: "Token not registered",
            },
          },
          {
            success: false,
            token: "error-token",
            error: {
              code: "messaging/internal-error",
              message: "Internal error",
            },
          },
        ],
      });
      vi.mocked(mockRepo.deleteByTokens).mockResolvedValue(undefined);

      const result = await notificationService.sendNotification({
        title: "Test",
        body: "Body",
        userIds: "all",
      });

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.successCount).toBe(1);
        expect(result.data.failureCount).toBe(2);
        expect(result.data.invalidTokensRemoved).toBe(1);
        expect(result.data.failures).toHaveLength(2);
      }

      expect(mockRepo.deleteByTokens).toHaveBeenCalledWith(["stale-token"]);
    });
  });

  describe("unregister token flow", () => {
    it("should unregister a token so it is not included in future sends", async () => {
      const mockRepo = createMockRepository();
      const mockFCM = createMockFCMAdapter();
      const mockLogger = createMockLogger();

      const deviceTokenService = createDeviceTokenService(mockRepo);
      const notificationService = createNotificationService(
        mockRepo,
        mockFCM,
        mockLogger,
      );

      vi.mocked(mockRepo.deleteByUserAndToken).mockResolvedValue(undefined);
      const unregisterResult = await deviceTokenService.unregisterToken({
        userId: 1,
        token: "old-token",
      });
      expect(unregisterResult.success).toBe(true);
      expect(mockRepo.deleteByUserAndToken).toHaveBeenCalledWith(
        1,
        "old-token",
      );

      vi.mocked(mockRepo.findAll).mockResolvedValue([]);
      const sendResult = await notificationService.sendNotification({
        title: "Test",
        body: "Body",
        userIds: "all",
      });

      expect(sendResult.success).toBe(false);
      if (!sendResult.success) {
        expect(sendResult.error.code).toBe("NO_TARGETS");
      }
    });
  });
});
