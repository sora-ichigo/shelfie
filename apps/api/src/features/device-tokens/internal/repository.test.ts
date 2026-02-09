import { describe, expect, it, vi } from "vitest";
import type { DeviceToken } from "../../../db/schema/device-tokens.js";
import { createDeviceTokenRepository } from "./repository.js";

function createMockDb() {
  const mockResults: unknown[] = [];

  const thenableThis = () => {
    const obj: Record<string, unknown> = {};
    for (const key of Object.keys(mockQuery)) {
      obj[key] = mockQuery[key as keyof typeof mockQuery];
    }
    // biome-ignore lint/suspicious/noThenProperty: drizzle query builder returns thenable objects
    obj.then = (resolve: (v: unknown) => void) => {
      resolve(mockResults);
      return Promise.resolve(mockResults);
    };
    return obj;
  };

  const mockQuery = {
    select: vi.fn().mockReturnThis(),
    from: vi.fn().mockImplementation(() => thenableThis()),
    where: vi.fn().mockImplementation(() => Promise.resolve(mockResults)),
    insert: vi.fn().mockReturnThis(),
    values: vi.fn().mockReturnThis(),
    returning: vi.fn().mockImplementation(() => Promise.resolve(mockResults)),
    onConflictDoUpdate: vi.fn().mockReturnThis(),
    set: vi.fn().mockReturnThis(),
    delete: vi.fn().mockReturnThis(),
  };

  return {
    query: mockQuery,
    setResults: (results: unknown[]) => {
      mockResults.length = 0;
      mockResults.push(...results);
    },
    clearMocks: () => {
      vi.clearAllMocks();
      mockResults.length = 0;
    },
  };
}

describe("DeviceTokenRepository", () => {
  describe("interface compliance", () => {
    it("should implement all DeviceTokenRepository methods", () => {
      const mockDb = createMockDb();
      const repository = createDeviceTokenRepository(mockDb.query as never);

      expect(typeof repository.upsert).toBe("function");
      expect(typeof repository.deleteByUserAndToken).toBe("function");
      expect(typeof repository.deleteByTokens).toBe("function");
      expect(typeof repository.findByUserId).toBe("function");
      expect(typeof repository.findByUserIds).toBe("function");
      expect(typeof repository.findAll).toBe("function");
    });
  });

  describe("upsert", () => {
    it("should return device token after upsert", async () => {
      const mockDb = createMockDb();
      const mockDeviceToken: DeviceToken = {
        id: 1,
        userId: 42,
        token: "fcm-token-abc",
        platform: "ios",
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      mockDb.setResults([mockDeviceToken]);

      const repository = createDeviceTokenRepository(mockDb.query as never);
      const result = await repository.upsert({
        userId: 42,
        token: "fcm-token-abc",
        platform: "ios",
      });

      expect(result).toEqual(mockDeviceToken);
    });
  });

  describe("deleteByUserAndToken", () => {
    it("should call delete with correct parameters", async () => {
      const mockDb = createMockDb();
      const repository = createDeviceTokenRepository(mockDb.query as never);

      await repository.deleteByUserAndToken(42, "fcm-token-abc");

      expect(mockDb.query.delete).toHaveBeenCalled();
    });
  });

  describe("deleteByTokens", () => {
    it("should not call delete when tokens array is empty", async () => {
      const mockDb = createMockDb();
      const repository = createDeviceTokenRepository(mockDb.query as never);

      await repository.deleteByTokens([]);

      expect(mockDb.query.delete).not.toHaveBeenCalled();
    });
  });

  describe("findByUserId", () => {
    it("should return tokens for a specific user", async () => {
      const mockDb = createMockDb();
      const mockTokens: DeviceToken[] = [
        {
          id: 1,
          userId: 42,
          token: "fcm-token-1",
          platform: "ios",
          createdAt: new Date(),
          updatedAt: new Date(),
        },
        {
          id: 2,
          userId: 42,
          token: "fcm-token-2",
          platform: "android",
          createdAt: new Date(),
          updatedAt: new Date(),
        },
      ];
      mockDb.setResults(mockTokens);

      const repository = createDeviceTokenRepository(mockDb.query as never);
      const result = await repository.findByUserId(42);

      expect(result).toEqual(mockTokens);
      expect(result).toHaveLength(2);
    });

    it("should return empty array when user has no tokens", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([]);

      const repository = createDeviceTokenRepository(mockDb.query as never);
      const result = await repository.findByUserId(999);

      expect(result).toEqual([]);
    });
  });

  describe("findByUserIds", () => {
    it("should return tokens for multiple users", async () => {
      const mockDb = createMockDb();
      const mockTokens: DeviceToken[] = [
        {
          id: 1,
          userId: 1,
          token: "fcm-token-user1",
          platform: "ios",
          createdAt: new Date(),
          updatedAt: new Date(),
        },
        {
          id: 2,
          userId: 2,
          token: "fcm-token-user2",
          platform: "android",
          createdAt: new Date(),
          updatedAt: new Date(),
        },
      ];
      mockDb.setResults(mockTokens);

      const repository = createDeviceTokenRepository(mockDb.query as never);
      const result = await repository.findByUserIds([1, 2]);

      expect(result).toEqual(mockTokens);
    });

    it("should return empty array when userIds is empty", async () => {
      const mockDb = createMockDb();
      const repository = createDeviceTokenRepository(mockDb.query as never);
      const result = await repository.findByUserIds([]);

      expect(result).toEqual([]);
    });
  });

  describe("findAll", () => {
    it("should return all device tokens", async () => {
      const mockDb = createMockDb();
      const mockTokens: DeviceToken[] = [
        {
          id: 1,
          userId: 1,
          token: "fcm-token-1",
          platform: "ios",
          createdAt: new Date(),
          updatedAt: new Date(),
        },
      ];
      mockDb.setResults(mockTokens);

      const repository = createDeviceTokenRepository(mockDb.query as never);
      const result = await repository.findAll();

      expect(result).toEqual(mockTokens);
    });
  });
});
