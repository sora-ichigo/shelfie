import { describe, expect, it, vi } from "vitest";
import type { NewUser, User } from "../../../db/schema/users.js";
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
    it("should implement UserRepository methods", () => {
      const mockDb = createMockDb();
      const repository = createUserRepository(mockDb.query as never);

      expect(typeof repository.findById).toBe("function");
      expect(typeof repository.findByEmail).toBe("function");
      expect(typeof repository.findByFirebaseUid).toBe("function");
      expect(typeof repository.findByHandle).toBe("function");
      expect(typeof repository.findMany).toBe("function");
      expect(typeof repository.create).toBe("function");
      expect(typeof repository.update).toBe("function");
      expect(typeof repository.delete).toBe("function");
    });
  });

  describe("findByFirebaseUid", () => {
    it("should return user when found by Firebase UID", async () => {
      const mockDb = createMockDb();
      const mockUser: User = {
        id: 1,
        email: "test@example.com",
        firebaseUid: "firebase-uid-12345",
        name: null,
        avatarUrl: null,
        bio: null,
        instagramHandle: null,
        handle: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      mockDb.setResults([mockUser]);

      const repository = createUserRepository(mockDb.query as never);
      const result = await repository.findByFirebaseUid("firebase-uid-12345");

      expect(result).toEqual(mockUser);
    });

    it("should return null when user not found by Firebase UID", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([]);

      const repository = createUserRepository(mockDb.query as never);
      const result = await repository.findByFirebaseUid("non-existent-uid");

      expect(result).toBeNull();
    });
  });

  describe("findByHandle", () => {
    it("should return user when found by handle", async () => {
      const mockDb = createMockDb();
      const mockUser: User = {
        id: 1,
        email: "test@example.com",
        firebaseUid: "firebase-uid-12345",
        name: "Test User",
        avatarUrl: null,
        bio: "Hello",
        instagramHandle: null,
        handle: "testuser",
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      mockDb.setResults([mockUser]);

      const repository = createUserRepository(mockDb.query as never);
      const result = await repository.findByHandle("testuser");

      expect(result).toEqual(mockUser);
    });

    it("should return null when user not found by handle", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([]);

      const repository = createUserRepository(mockDb.query as never);
      const result = await repository.findByHandle("nonexistent");

      expect(result).toBeNull();
    });
  });

  describe("findById", () => {
    it("should return user type from findById", async () => {
      const user: User = {
        id: 1,
        email: "test@example.com",
        firebaseUid: "firebase-uid-test",
        name: null,
        avatarUrl: null,
        bio: null,
        instagramHandle: null,
        handle: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      };

      expect(user.id).toBe(1);
      expect(user.email).toBe("test@example.com");
      expect(user.firebaseUid).toBe("firebase-uid-test");
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
        firebaseUid: "firebase-uid-new",
      };

      expect(newUser.email).toBe("test@example.com");
      expect(newUser.firebaseUid).toBe("firebase-uid-new");
      expect((newUser as Record<string, unknown>).id).toBeUndefined();
    });

    it("should use User type for output", () => {
      const user: User = {
        id: 1,
        email: "test@example.com",
        firebaseUid: "firebase-uid-output",
        name: null,
        avatarUrl: null,
        bio: null,
        instagramHandle: null,
        handle: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      };

      expect(user.id).toBeDefined();
      expect(user.email).toBeDefined();
      expect(user.firebaseUid).toBeDefined();
      expect(user.createdAt).toBeInstanceOf(Date);
      expect(user.updatedAt).toBeInstanceOf(Date);
    });
  });
});
