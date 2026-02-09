import { describe, expect, it, vi } from "vitest";
import type { DeviceToken } from "../../../db/schema/device-tokens.js";
import type { LoggerService } from "../../../logger/index.js";
import type { FCMAdapter } from "./fcm-adapter.js";
import { createNotificationService } from "./notification-service.js";
import type { DeviceTokenRepository } from "./repository.js";

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

function createMockToken(overrides: Partial<DeviceToken> = {}): DeviceToken {
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

describe("NotificationService", () => {
  describe("sendNotification", () => {
    it("should send notification to all users when userIds is 'all'", async () => {
      const mockRepo = createMockRepository();
      const mockFCM = createMockFCMAdapter();
      const mockLogger = createMockLogger();

      const tokens = [
        createMockToken({ id: 1, userId: 1, token: "token-1" }),
        createMockToken({ id: 2, userId: 2, token: "token-2" }),
      ];
      vi.mocked(mockRepo.findAll).mockResolvedValue(tokens);
      vi.mocked(mockFCM.sendMulticast).mockResolvedValue({
        successCount: 2,
        failureCount: 0,
        responses: [
          { success: true, token: "token-1" },
          { success: true, token: "token-2" },
        ],
      });

      const service = createNotificationService(mockRepo, mockFCM, mockLogger);
      const result = await service.sendNotification({
        title: "Test",
        body: "Hello",
        userIds: "all",
      });

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.totalTargets).toBe(2);
        expect(result.data.successCount).toBe(2);
        expect(result.data.failureCount).toBe(0);
        expect(result.data.invalidTokensRemoved).toBe(0);
        expect(result.data.failures).toHaveLength(0);
      }
      expect(mockRepo.findAll).toHaveBeenCalled();
    });

    it("should send notification to specific users when userIds is array", async () => {
      const mockRepo = createMockRepository();
      const mockFCM = createMockFCMAdapter();
      const mockLogger = createMockLogger();

      const tokens = [createMockToken({ id: 1, userId: 1, token: "token-1" })];
      vi.mocked(mockRepo.findByUserIds).mockResolvedValue(tokens);
      vi.mocked(mockFCM.sendMulticast).mockResolvedValue({
        successCount: 1,
        failureCount: 0,
        responses: [{ success: true, token: "token-1" }],
      });

      const service = createNotificationService(mockRepo, mockFCM, mockLogger);
      const result = await service.sendNotification({
        title: "Test",
        body: "Hello",
        userIds: [1],
      });

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.totalTargets).toBe(1);
        expect(result.data.successCount).toBe(1);
      }
      expect(mockRepo.findByUserIds).toHaveBeenCalledWith([1]);
    });

    it("should return NO_TARGETS error when no tokens found", async () => {
      const mockRepo = createMockRepository();
      const mockFCM = createMockFCMAdapter();
      const mockLogger = createMockLogger();

      vi.mocked(mockRepo.findAll).mockResolvedValue([]);

      const service = createNotificationService(mockRepo, mockFCM, mockLogger);
      const result = await service.sendNotification({
        title: "Test",
        body: "Hello",
        userIds: "all",
      });

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("NO_TARGETS");
      }
    });

    it("should batch tokens into chunks of 500", async () => {
      const mockRepo = createMockRepository();
      const mockFCM = createMockFCMAdapter();
      const mockLogger = createMockLogger();

      const tokens = Array.from({ length: 600 }, (_, i) =>
        createMockToken({ id: i + 1, userId: i + 1, token: `token-${i}` }),
      );
      vi.mocked(mockRepo.findAll).mockResolvedValue(tokens);
      vi.mocked(mockFCM.sendMulticast).mockResolvedValue({
        successCount: 500,
        failureCount: 0,
        responses: Array.from({ length: 500 }, (_, i) => ({
          success: true,
          token: `token-${i}`,
        })),
      });

      const service = createNotificationService(mockRepo, mockFCM, mockLogger);
      await service.sendNotification({
        title: "Test",
        body: "Hello",
        userIds: "all",
      });

      expect(mockFCM.sendMulticast).toHaveBeenCalledTimes(2);
    });

    it("should detect and remove invalid tokens", async () => {
      const mockRepo = createMockRepository();
      const mockFCM = createMockFCMAdapter();
      const mockLogger = createMockLogger();

      const tokens = [
        createMockToken({ id: 1, userId: 1, token: "valid-token" }),
        createMockToken({ id: 2, userId: 2, token: "invalid-token" }),
      ];
      vi.mocked(mockRepo.findAll).mockResolvedValue(tokens);
      vi.mocked(mockFCM.sendMulticast).mockResolvedValue({
        successCount: 1,
        failureCount: 1,
        responses: [
          { success: true, token: "valid-token" },
          {
            success: false,
            token: "invalid-token",
            error: {
              code: "messaging/registration-token-not-registered",
              message: "Token not registered",
            },
          },
        ],
      });
      vi.mocked(mockRepo.deleteByTokens).mockResolvedValue(undefined);

      const service = createNotificationService(mockRepo, mockFCM, mockLogger);
      const result = await service.sendNotification({
        title: "Test",
        body: "Hello",
        userIds: "all",
      });

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.invalidTokensRemoved).toBe(1);
        expect(result.data.failureCount).toBe(1);
        expect(result.data.failures).toHaveLength(1);
        expect(result.data.failures[0].token).toBe("invalid-token");
      }
      expect(mockRepo.deleteByTokens).toHaveBeenCalledWith(["invalid-token"]);
    });

    it("should log errors for failed sends", async () => {
      const mockRepo = createMockRepository();
      const mockFCM = createMockFCMAdapter();
      const mockLogger = createMockLogger();

      const tokens = [createMockToken({ id: 1, userId: 1, token: "token-1" })];
      vi.mocked(mockRepo.findAll).mockResolvedValue(tokens);
      vi.mocked(mockFCM.sendMulticast).mockResolvedValue({
        successCount: 0,
        failureCount: 1,
        responses: [
          {
            success: false,
            token: "token-1",
            error: {
              code: "messaging/internal-error",
              message: "Internal error",
            },
          },
        ],
      });

      const service = createNotificationService(mockRepo, mockFCM, mockLogger);
      await service.sendNotification({
        title: "Test",
        body: "Hello",
        userIds: "all",
      });

      expect(mockLogger.error).toHaveBeenCalled();
    });
  });
});
