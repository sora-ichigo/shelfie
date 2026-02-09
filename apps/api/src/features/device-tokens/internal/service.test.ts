import { describe, expect, it, vi } from "vitest";
import type { DeviceToken } from "../../../db/schema/device-tokens.js";
import type { DeviceTokenRepository } from "./repository.js";
import { createDeviceTokenService } from "./service.js";

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

const mockDeviceToken: DeviceToken = {
  id: 1,
  userId: 42,
  token: "fcm-token-abc",
  platform: "ios",
  createdAt: new Date(),
  updatedAt: new Date(),
};

describe("DeviceTokenService", () => {
  describe("registerToken", () => {
    it("should register token and return success", async () => {
      const mockRepo = createMockRepository();
      vi.mocked(mockRepo.upsert).mockResolvedValue(mockDeviceToken);

      const service = createDeviceTokenService(mockRepo);
      const result = await service.registerToken({
        userId: 42,
        token: "fcm-token-abc",
        platform: "ios",
      });

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.userId).toBe(42);
        expect(result.data.token).toBe("fcm-token-abc");
        expect(result.data.platform).toBe("ios");
      }
      expect(mockRepo.upsert).toHaveBeenCalledWith({
        userId: 42,
        token: "fcm-token-abc",
        platform: "ios",
      });
    });

    it("should return error when token is empty", async () => {
      const mockRepo = createMockRepository();
      const service = createDeviceTokenService(mockRepo);

      const result = await service.registerToken({
        userId: 42,
        token: "",
        platform: "ios",
      });

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("INVALID_TOKEN");
      }
      expect(mockRepo.upsert).not.toHaveBeenCalled();
    });
  });

  describe("unregisterToken", () => {
    it("should unregister token and return success", async () => {
      const mockRepo = createMockRepository();
      vi.mocked(mockRepo.deleteByUserAndToken).mockResolvedValue(undefined);

      const service = createDeviceTokenService(mockRepo);
      const result = await service.unregisterToken({
        userId: 42,
        token: "fcm-token-abc",
      });

      expect(result.success).toBe(true);
      expect(mockRepo.deleteByUserAndToken).toHaveBeenCalledWith(
        42,
        "fcm-token-abc",
      );
    });

    it("should return error when token is empty", async () => {
      const mockRepo = createMockRepository();
      const service = createDeviceTokenService(mockRepo);

      const result = await service.unregisterToken({
        userId: 42,
        token: "",
      });

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("INVALID_TOKEN");
      }
      expect(mockRepo.deleteByUserAndToken).not.toHaveBeenCalled();
    });
  });
});
