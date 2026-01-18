import { getTableName } from "drizzle-orm";
import { describe, expect, it } from "vitest";
import { type NewUser, type User, users } from "./users.js";

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
  });

  describe("type inference", () => {
    it("should infer User type for select operations", () => {
      const user: User = {
        id: 1,
        email: "test@example.com",
        createdAt: new Date(),
        updatedAt: new Date(),
      };

      expect(user.id).toBe(1);
      expect(user.email).toBe("test@example.com");
      expect(user.createdAt).toBeInstanceOf(Date);
      expect(user.updatedAt).toBeInstanceOf(Date);
    });

    it("should infer NewUser type for insert operations (id should be optional)", () => {
      const newUser: NewUser = {
        email: "new@example.com",
      };

      expect(newUser.email).toBe("new@example.com");
      expect("id" in newUser).toBe(false);
    });

    it("should allow createdAt and updatedAt to be optional in NewUser", () => {
      const newUserMinimal: NewUser = {
        email: "minimal@example.com",
      };

      expect(newUserMinimal.createdAt).toBeUndefined();
      expect(newUserMinimal.updatedAt).toBeUndefined();
    });
  });
});
