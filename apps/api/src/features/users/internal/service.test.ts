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
        name: null,
        avatarUrl: null,
        bio: null,
        instagramHandle: null,
        handle: null,
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
        name: null,
        avatarUrl: null,
        bio: null,
        instagramHandle: null,
        handle: null,
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
        name: null,
        avatarUrl: null,
        bio: null,
        instagramHandle: null,
        handle: null,
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
          name: null,
          avatarUrl: null,
          bio: null,
          instagramHandle: null,
          handle: null,
          createdAt: new Date(),
          updatedAt: new Date(),
        },
        {
          id: 2,
          email: "user2@example.com",
          firebaseUid: "firebase-uid-2",
          name: null,
          avatarUrl: null,
          bio: null,
          instagramHandle: null,
          handle: null,
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
        name: null,
        avatarUrl: null,
        bio: null,
        instagramHandle: null,
        handle: null,
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
        name: null,
        avatarUrl: null,
        bio: null,
        instagramHandle: null,
        handle: null,
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
        name: null,
        avatarUrl: null,
        bio: null,
        instagramHandle: null,
        handle: null,
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

  describe("updateProfile", () => {
    it("should update user profile with name", async () => {
      const mockRepo = createMockRepository();
      const mockUser: User = {
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
      const updatedUser: User = {
        ...mockUser,
        name: "Updated Name",
        updatedAt: new Date(),
      };
      vi.mocked(mockRepo.findById).mockResolvedValue(mockUser);
      vi.mocked(mockRepo.update).mockResolvedValue(updatedUser);

      const service = createUserService(mockRepo);
      const result = await service.updateProfile({
        userId: 1,
        name: "Updated Name",
      });

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.name).toBe("Updated Name");
      }
      expect(mockRepo.update).toHaveBeenCalledWith(1, { name: "Updated Name" });
    });

    it("should update user profile with avatarUrl", async () => {
      const mockRepo = createMockRepository();
      const mockUser: User = {
        id: 1,
        email: "test@example.com",
        firebaseUid: "firebase-uid-test",
        name: "Test User",
        avatarUrl: null,
        bio: null,
        instagramHandle: null,
        handle: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      const updatedUser: User = {
        ...mockUser,
        avatarUrl: "https://example.com/avatar.jpg",
        updatedAt: new Date(),
      };
      vi.mocked(mockRepo.findById).mockResolvedValue(mockUser);
      vi.mocked(mockRepo.update).mockResolvedValue(updatedUser);

      const service = createUserService(mockRepo);
      const result = await service.updateProfile({
        userId: 1,
        name: "Test User",
        avatarUrl: "https://example.com/avatar.jpg",
      });

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.avatarUrl).toBe("https://example.com/avatar.jpg");
      }
    });

    it("should return error when name is empty", async () => {
      const mockRepo = createMockRepository();
      const service = createUserService(mockRepo);
      const result = await service.updateProfile({
        userId: 1,
        name: "",
      });

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("VALIDATION_ERROR");
        expect(result.error.message).toContain("氏名");
      }
    });

    it("should return error when name is whitespace only", async () => {
      const mockRepo = createMockRepository();
      const service = createUserService(mockRepo);
      const result = await service.updateProfile({
        userId: 1,
        name: "   ",
      });

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("VALIDATION_ERROR");
      }
    });

    it("should return error when user not found", async () => {
      const mockRepo = createMockRepository();
      vi.mocked(mockRepo.findById).mockResolvedValue(null);

      const service = createUserService(mockRepo);
      const result = await service.updateProfile({
        userId: 999,
        name: "Test Name",
      });

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("USER_NOT_FOUND");
      }
    });

    it("should update user profile with bio", async () => {
      const mockRepo = createMockRepository();
      const mockUser: User = {
        id: 1,
        email: "test@example.com",
        firebaseUid: "firebase-uid-test",
        name: "Test User",
        avatarUrl: null,
        bio: null,
        instagramHandle: null,
        handle: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      const updatedUser: User = {
        ...mockUser,
        bio: "本が好きです",
        updatedAt: new Date(),
      };
      vi.mocked(mockRepo.findById).mockResolvedValue(mockUser);
      vi.mocked(mockRepo.update).mockResolvedValue(updatedUser);

      const service = createUserService(mockRepo);
      const result = await service.updateProfile({
        userId: 1,
        name: "Test User",
        bio: "本が好きです",
      });

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.bio).toBe("本が好きです");
      }
    });

    it("should return error when bio exceeds 500 characters", async () => {
      const mockRepo = createMockRepository();
      const service = createUserService(mockRepo);
      const longBio = "あ".repeat(501);
      const result = await service.updateProfile({
        userId: 1,
        name: "Test User",
        bio: longBio,
      });

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("VALIDATION_ERROR");
      }
    });

    it("should update user profile with handle", async () => {
      const mockRepo = createMockRepository();
      const mockUser: User = {
        id: 1,
        email: "test@example.com",
        firebaseUid: "firebase-uid-test",
        name: "Test User",
        avatarUrl: null,
        bio: null,
        instagramHandle: null,
        handle: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      const updatedUser: User = {
        ...mockUser,
        handle: "taro_yamada",
        updatedAt: new Date(),
      };
      vi.mocked(mockRepo.findById).mockResolvedValue(mockUser);
      vi.mocked(mockRepo.update).mockResolvedValue(updatedUser);

      const service = createUserService(mockRepo);
      const result = await service.updateProfile({
        userId: 1,
        name: "Test User",
        handle: "taro_yamada",
      });

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.handle).toBe("taro_yamada");
      }
    });

    it("should return error when handle contains invalid characters", async () => {
      const mockRepo = createMockRepository();
      const service = createUserService(mockRepo);
      const result = await service.updateProfile({
        userId: 1,
        name: "Test User",
        handle: "invalid handle!",
      });

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("VALIDATION_ERROR");
      }
    });

    it("should return error when handle exceeds 30 characters", async () => {
      const mockRepo = createMockRepository();
      const service = createUserService(mockRepo);
      const result = await service.updateProfile({
        userId: 1,
        name: "Test User",
        handle: "a".repeat(31),
      });

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("VALIDATION_ERROR");
      }
    });

    it("should update user profile with instagramHandle", async () => {
      const mockRepo = createMockRepository();
      const mockUser: User = {
        id: 1,
        email: "test@example.com",
        firebaseUid: "firebase-uid-test",
        name: "Test User",
        avatarUrl: null,
        bio: null,
        instagramHandle: null,
        handle: null,
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      const updatedUser: User = {
        ...mockUser,
        instagramHandle: "bookworm_123",
        updatedAt: new Date(),
      };
      vi.mocked(mockRepo.findById).mockResolvedValue(mockUser);
      vi.mocked(mockRepo.update).mockResolvedValue(updatedUser);

      const service = createUserService(mockRepo);
      const result = await service.updateProfile({
        userId: 1,
        name: "Test User",
        instagramHandle: "bookworm_123",
      });

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.instagramHandle).toBe("bookworm_123");
      }
    });
  });

  describe("deleteAccount", () => {
    it("should delete user and return success", async () => {
      const mockRepo = createMockRepository();
      const mockUser: User = {
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
      vi.mocked(mockRepo.findById).mockResolvedValue(mockUser);
      vi.mocked(mockRepo.delete).mockResolvedValue(undefined);

      const service = createUserService(mockRepo);
      const result = await service.deleteAccount({ id: 1 });

      expect(result.success).toBe(true);
      expect(mockRepo.delete).toHaveBeenCalledWith(1);
    });

    it("should return error when user not found", async () => {
      const mockRepo = createMockRepository();
      vi.mocked(mockRepo.findById).mockResolvedValue(null);

      const service = createUserService(mockRepo);
      const result = await service.deleteAccount({ id: 999 });

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("USER_NOT_FOUND");
      }
      expect(mockRepo.delete).not.toHaveBeenCalled();
    });
  });
});
