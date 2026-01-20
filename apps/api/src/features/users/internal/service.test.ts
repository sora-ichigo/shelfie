import { describe, expect, it, vi } from "vitest";
import type { User } from "../../../db/schema/users.js";
import type { UserRepository } from "./repository.js";
import { createUserService } from "./service.js";

function createMockRepository(): UserRepository {
  return {
    findById: vi.fn(),
    findByEmail: vi.fn(),
    findByFirebaseUid: vi.fn(),
    findMany: vi.fn(),
    create: vi.fn(),
    update: vi.fn(),
    delete: vi.fn(),
  };
}

describe("UserService", () => {
  describe("getUserById", () => {
    it("should return user when found", async () => {
      const mockRepo = createMockRepository();
      const mockUser: User = {
        id: 1,
        email: "test@example.com",
        firebaseUid: "firebase-uid-test",
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      vi.mocked(mockRepo.findById).mockResolvedValue(mockUser);

      const service = createUserService(mockRepo);
      const result = await service.getUserById({ id: 1 });

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.id).toBe(1);
        expect(result.data.email).toBe("test@example.com");
        expect(result.data.firebaseUid).toBe("firebase-uid-test");
      }
    });

    it("should return error when user not found", async () => {
      const mockRepo = createMockRepository();
      vi.mocked(mockRepo.findById).mockResolvedValue(null);

      const service = createUserService(mockRepo);
      const result = await service.getUserById({ id: 999 });

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("USER_NOT_FOUND");
      }
    });
  });

  describe("createUser", () => {
    it("should create user and return success", async () => {
      const mockRepo = createMockRepository();
      const mockUser: User = {
        id: 1,
        email: "new@example.com",
        firebaseUid: "firebase-uid-new",
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      vi.mocked(mockRepo.findByEmail).mockResolvedValue(null);
      vi.mocked(mockRepo.create).mockResolvedValue(mockUser);

      const service = createUserService(mockRepo);
      const result = await service.createUser({
        email: "new@example.com",
        firebaseUid: "firebase-uid-new",
      });

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.email).toBe("new@example.com");
        expect(result.data.firebaseUid).toBe("firebase-uid-new");
      }
    });

    it("should return error when email already exists", async () => {
      const mockRepo = createMockRepository();
      const existingUser: User = {
        id: 1,
        email: "existing@example.com",
        firebaseUid: "firebase-uid-existing",
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      vi.mocked(mockRepo.findByEmail).mockResolvedValue(existingUser);

      const service = createUserService(mockRepo);
      const result = await service.createUser({
        email: "existing@example.com",
        firebaseUid: "firebase-uid-new-attempt",
      });

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("EMAIL_ALREADY_EXISTS");
      }
    });
  });

  describe("getUsers", () => {
    it("should return list of users", async () => {
      const mockRepo = createMockRepository();
      const mockUsers: User[] = [
        {
          id: 1,
          email: "user1@example.com",
          firebaseUid: "firebase-uid-1",
          createdAt: new Date(),
          updatedAt: new Date(),
        },
        {
          id: 2,
          email: "user2@example.com",
          firebaseUid: "firebase-uid-2",
          createdAt: new Date(),
          updatedAt: new Date(),
        },
      ];
      vi.mocked(mockRepo.findMany).mockResolvedValue(mockUsers);

      const service = createUserService(mockRepo);
      const result = await service.getUsers();

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data).toHaveLength(2);
      }
    });
  });

  describe("getUserByFirebaseUid", () => {
    it("should return user when found by Firebase UID", async () => {
      const mockRepo = createMockRepository();
      const mockUser: User = {
        id: 1,
        email: "test@example.com",
        firebaseUid: "firebase-uid-12345",
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      vi.mocked(mockRepo.findByFirebaseUid).mockResolvedValue(mockUser);

      const service = createUserService(mockRepo);
      const result = await service.getUserByFirebaseUid("firebase-uid-12345");

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.firebaseUid).toBe("firebase-uid-12345");
        expect(result.data.email).toBe("test@example.com");
      }
    });

    it("should return error when user not found by Firebase UID", async () => {
      const mockRepo = createMockRepository();
      vi.mocked(mockRepo.findByFirebaseUid).mockResolvedValue(null);

      const service = createUserService(mockRepo);
      const result = await service.getUserByFirebaseUid("non-existent-uid");

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("USER_NOT_FOUND");
      }
    });
  });

  describe("createUserWithFirebase", () => {
    it("should create user with Firebase UID and return success", async () => {
      const mockRepo = createMockRepository();
      const mockUser: User = {
        id: 1,
        email: "new@example.com",
        firebaseUid: "firebase-uid-new",
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      vi.mocked(mockRepo.findByEmail).mockResolvedValue(null);
      vi.mocked(mockRepo.create).mockResolvedValue(mockUser);

      const service = createUserService(mockRepo);
      const result = await service.createUserWithFirebase({
        email: "new@example.com",
        firebaseUid: "firebase-uid-new",
      });

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.email).toBe("new@example.com");
        expect(result.data.firebaseUid).toBe("firebase-uid-new");
      }
      expect(mockRepo.create).toHaveBeenCalledWith({
        email: "new@example.com",
        firebaseUid: "firebase-uid-new",
      });
    });

    it("should return error when email already exists", async () => {
      const mockRepo = createMockRepository();
      const existingUser: User = {
        id: 1,
        email: "existing@example.com",
        firebaseUid: "firebase-uid-existing",
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      vi.mocked(mockRepo.findByEmail).mockResolvedValue(existingUser);

      const service = createUserService(mockRepo);
      const result = await service.createUserWithFirebase({
        email: "existing@example.com",
        firebaseUid: "firebase-uid-new-attempt",
      });

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("EMAIL_ALREADY_EXISTS");
      }
    });
  });
});
