import { getTableName } from "drizzle-orm";
import { describe, expect, it } from "vitest";
import {
  type NewUser,
  USERS_FIREBASE_UID_INDEX_NAME,
  type User,
  users,
} from "./users.js";

describe("users schema", () => {
  describe("table definition", () => {
    it("should have table name 'users'", () => {
      expect(getTableName(users)).toBe("users");
    });

    it("should have id column as identity primary key", () => {
      const idColumn = users.id;

      expect(idColumn.name).toBe("id");
      expect(idColumn.notNull).toBe(true);
      expect(idColumn.primary).toBe(true);
    });

    it("should have email column as non-null text", () => {
      const emailColumn = users.email;

      expect(emailColumn.name).toBe("email");
      expect(emailColumn.notNull).toBe(true);
    });

    it("should have firebase_uid column as non-null unique text", () => {
      const firebaseUidColumn = users.firebaseUid;

      expect(firebaseUidColumn.name).toBe("firebase_uid");
      expect(firebaseUidColumn.notNull).toBe(true);
      expect(firebaseUidColumn.isUnique).toBe(true);
    });

    it("should have created_at column with default now", () => {
      const createdAtColumn = users.createdAt;

      expect(createdAtColumn.name).toBe("created_at");
      expect(createdAtColumn.notNull).toBe(true);
      expect(createdAtColumn.hasDefault).toBe(true);
    });

    it("should have updated_at column with default now", () => {
      const updatedAtColumn = users.updatedAt;

      expect(updatedAtColumn.name).toBe("updated_at");
      expect(updatedAtColumn.notNull).toBe(true);
      expect(updatedAtColumn.hasDefault).toBe(true);
    });

    it("should have name column as nullable text", () => {
      const nameColumn = users.name;

      expect(nameColumn.name).toBe("name");
      expect(nameColumn.notNull).toBe(false);
    });

    it("should have avatar_url column as nullable text", () => {
      const avatarUrlColumn = users.avatarUrl;

      expect(avatarUrlColumn.name).toBe("avatar_url");
      expect(avatarUrlColumn.notNull).toBe(false);
    });

    it("should have handle column as nullable unique text", () => {
      const handleColumn = users.handle;

      expect(handleColumn.name).toBe("handle");
      expect(handleColumn.notNull).toBe(false);
      expect(handleColumn.isUnique).toBe(true);
    });
  });

  describe("index definition", () => {
    it("should have firebase_uid index name constant", () => {
      expect(USERS_FIREBASE_UID_INDEX_NAME).toBe("idx_users_firebase_uid");
    });
  });

  describe("type inference", () => {
    it("should infer User type for select operations", () => {
      const user: User = {
        id: 1,
        email: "test@example.com",
        firebaseUid: "firebase-uid-123",
        name: "Test User",
        avatarUrl: "https://example.com/avatar.jpg",
        bio: null,
        instagramHandle: null,
        handle: null,
        isPublic: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      };

      expect(user.id).toBe(1);
      expect(user.email).toBe("test@example.com");
      expect(user.firebaseUid).toBe("firebase-uid-123");
      expect(user.name).toBe("Test User");
      expect(user.avatarUrl).toBe("https://example.com/avatar.jpg");
      expect(user.createdAt).toBeInstanceOf(Date);
      expect(user.updatedAt).toBeInstanceOf(Date);
    });

    it("should allow null values for name and avatarUrl in User type", () => {
      const user: User = {
        id: 1,
        email: "test@example.com",
        firebaseUid: "firebase-uid-123",
        name: null,
        avatarUrl: null,
        bio: null,
        instagramHandle: null,
        handle: null,
        isPublic: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      };

      expect(user.name).toBeNull();
      expect(user.avatarUrl).toBeNull();
      expect(user.handle).toBeNull();
    });

    it("should infer NewUser type for insert operations (id should be optional)", () => {
      const newUser: NewUser = {
        email: "new@example.com",
        firebaseUid: "firebase-uid-456",
      };

      expect(newUser.email).toBe("new@example.com");
      expect(newUser.firebaseUid).toBe("firebase-uid-456");
      expect("id" in newUser).toBe(false);
    });

    it("should allow createdAt and updatedAt to be optional in NewUser", () => {
      const newUserMinimal: NewUser = {
        email: "minimal@example.com",
        firebaseUid: "firebase-uid-789",
      };

      expect(newUserMinimal.createdAt).toBeUndefined();
      expect(newUserMinimal.updatedAt).toBeUndefined();
    });

    it("should allow name and avatarUrl to be optional in NewUser", () => {
      const newUser: NewUser = {
        email: "test@example.com",
        firebaseUid: "firebase-uid-123",
        name: "Test User",
        avatarUrl: "https://example.com/avatar.jpg",
      };

      expect(newUser.name).toBe("Test User");
      expect(newUser.avatarUrl).toBe("https://example.com/avatar.jpg");
    });

    it("should require firebaseUid in NewUser", () => {
      const newUser: NewUser = {
        email: "test@example.com",
        firebaseUid: "required-firebase-uid",
      };

      expect(newUser.firebaseUid).toBeDefined();
    });
  });
});
