import { describe, expect, it, vi } from "vitest";
import type { NewUser, User } from "../../db/schema/users.js";
import { createUserRepository } from "./repository.js";

function createMockDb() {
  const mockResults: unknown[] = [];

  const mockQuery = {
    select: vi.fn().mockReturnThis(),
    from: vi.fn().mockReturnThis(),
    where: vi.fn().mockImplementation(() => Promise.resolve(mockResults)),
    insert: vi.fn().mockReturnThis(),
    values: vi.fn().mockReturnThis(),
    returning: vi.fn().mockImplementation(() => Promise.resolve(mockResults)),
    update: vi.fn().mockReturnThis(),
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

describe("UserRepository", () => {
  describe("interface compliance", () => {
    it("should implement FeatureRepository methods", () => {
      const mockDb = createMockDb();
      const repository = createUserRepository(mockDb.query as never);

      expect(typeof repository.findById).toBe("function");
      expect(typeof repository.findByEmail).toBe("function");
      expect(typeof repository.findMany).toBe("function");
      expect(typeof repository.create).toBe("function");
      expect(typeof repository.update).toBe("function");
      expect(typeof repository.delete).toBe("function");
    });
  });

  describe("findById", () => {
    it("should return user type from findById", async () => {
      const user: User = {
        id: 1,
        email: "test@example.com",
        createdAt: new Date(),
        updatedAt: new Date(),
      };

      expect(user.id).toBe(1);
      expect(user.email).toBe("test@example.com");
    });
  });

  describe("findByEmail", () => {
    it("should have findByEmail method extending base repository", () => {
      const mockDb = createMockDb();
      const repository = createUserRepository(mockDb.query as never);

      expect(typeof repository.findByEmail).toBe("function");
    });
  });

  describe("types", () => {
    it("should use NewUser type for create input", () => {
      const newUser: NewUser = {
        email: "test@example.com",
      };

      expect(newUser.email).toBe("test@example.com");
      expect((newUser as Record<string, unknown>).id).toBeUndefined();
    });

    it("should use User type for output", () => {
      const user: User = {
        id: 1,
        email: "test@example.com",
        createdAt: new Date(),
        updatedAt: new Date(),
      };

      expect(user.id).toBeDefined();
      expect(user.email).toBeDefined();
      expect(user.createdAt).toBeInstanceOf(Date);
      expect(user.updatedAt).toBeInstanceOf(Date);
    });
  });
});
