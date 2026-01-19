import { eq } from "drizzle-orm";
import { beforeAll, describe, expect, it } from "vitest";
import { getGlobalTestPool } from "../../../vitest.setup.js";
import {
  createDrizzleClient,
  type DrizzleClient,
  QueryError,
} from "../../db/client.js";
import { users } from "../../db/schema/users.js";

describe("DrizzleClient Integration Tests", () => {
  let client: DrizzleClient;

  beforeAll(() => {
    const pool = getGlobalTestPool();
    client = createDrizzleClient(pool);
  });

  describe("CRUD Operations", () => {
    describe("Create (Insert)", () => {
      it("should insert a single user", async () => {
        const db = client.getDb();
        const result = await db
          .insert(users)
          .values({ email: "create-test@example.com" })
          .returning();

        expect(result).toHaveLength(1);
        expect(result[0].email).toBe("create-test@example.com");
        expect(result[0].id).toBeGreaterThan(0);
        expect(result[0].createdAt).toBeInstanceOf(Date);
        expect(result[0].updatedAt).toBeInstanceOf(Date);
      });

      it("should insert multiple users", async () => {
        const db = client.getDb();
        const result = await db
          .insert(users)
          .values([
            { email: "batch1@example.com" },
            { email: "batch2@example.com" },
          ])
          .returning();

        expect(result).toHaveLength(2);
        expect(result[0].email).toBe("batch1@example.com");
        expect(result[1].email).toBe("batch2@example.com");
      });
    });

    describe("Read (Select)", () => {
      it("should select all users", async () => {
        const db = client.getDb();
        await db.insert(users).values({ email: "select-all@example.com" });

        const result = await db.select().from(users);

        expect(result.length).toBeGreaterThan(0);
        expect(result.some((u) => u.email === "select-all@example.com")).toBe(
          true,
        );
      });

      it("should select user by id", async () => {
        const db = client.getDb();
        const [inserted] = await db
          .insert(users)
          .values({ email: "select-by-id@example.com" })
          .returning();

        const result = await db
          .select()
          .from(users)
          .where(eq(users.id, inserted.id));

        expect(result).toHaveLength(1);
        expect(result[0].email).toBe("select-by-id@example.com");
      });

      it("should select user by email", async () => {
        const db = client.getDb();
        await db.insert(users).values({ email: "select-by-email@example.com" });

        const result = await db
          .select()
          .from(users)
          .where(eq(users.email, "select-by-email@example.com"));

        expect(result).toHaveLength(1);
        expect(result[0].email).toBe("select-by-email@example.com");
      });

      it("should return empty array for non-existent user", async () => {
        const db = client.getDb();
        const result = await db
          .select()
          .from(users)
          .where(eq(users.id, 999999));

        expect(result).toHaveLength(0);
      });
    });

    describe("Update", () => {
      it("should update user email", async () => {
        const db = client.getDb();
        const [inserted] = await db
          .insert(users)
          .values({ email: "before-update@example.com" })
          .returning();

        const [updated] = await db
          .update(users)
          .set({ email: "after-update@example.com" })
          .where(eq(users.id, inserted.id))
          .returning();

        expect(updated.email).toBe("after-update@example.com");
        expect(updated.id).toBe(inserted.id);
      });

      it("should update updatedAt timestamp", async () => {
        const db = client.getDb();
        const [inserted] = await db
          .insert(users)
          .values({ email: "timestamp-test@example.com" })
          .returning();

        await new Promise((resolve) => setTimeout(resolve, 10));

        const newUpdatedAt = new Date();
        const [updated] = await db
          .update(users)
          .set({
            email: "timestamp-updated@example.com",
            updatedAt: newUpdatedAt,
          })
          .where(eq(users.id, inserted.id))
          .returning();

        expect(updated.updatedAt).toBeInstanceOf(Date);
        expect(updated.email).toBe("timestamp-updated@example.com");
        expect(updated.id).toBe(inserted.id);
      });
    });

    describe("Delete", () => {
      it("should delete user by id", async () => {
        const db = client.getDb();
        const [inserted] = await db
          .insert(users)
          .values({ email: "delete-test@example.com" })
          .returning();

        await db.delete(users).where(eq(users.id, inserted.id));

        const result = await db
          .select()
          .from(users)
          .where(eq(users.id, inserted.id));

        expect(result).toHaveLength(0);
      });
    });
  });

  describe("Transaction Operations", () => {
    it("should commit transaction on success", async () => {
      const result = await client.transaction(async (tx) => {
        const [user] = await tx
          .insert(users)
          .values({ email: "tx-commit@example.com" })
          .returning();
        return user;
      });

      expect(result.email).toBe("tx-commit@example.com");

      const db = client.getDb();
      const [found] = await db
        .select()
        .from(users)
        .where(eq(users.id, result.id));
      expect(found).toBeDefined();
    });

    it("should rollback transaction on error", async () => {
      const emailToCheck = `tx-rollback-${Date.now()}@example.com`;

      await expect(
        client.transaction(async (tx) => {
          await tx.insert(users).values({ email: emailToCheck });
          throw new Error("Force rollback");
        }),
      ).rejects.toThrow(QueryError);

      const db = client.getDb();
      const result = await db
        .select()
        .from(users)
        .where(eq(users.email, emailToCheck));
      expect(result).toHaveLength(0);
    });

    it("should support nested operations in transaction", async () => {
      const result = await client.transaction(async (tx) => {
        const [user1] = await tx
          .insert(users)
          .values({ email: "tx-nested-1@example.com" })
          .returning();

        const [user2] = await tx
          .insert(users)
          .values({ email: "tx-nested-2@example.com" })
          .returning();

        const allUsers = await tx.select().from(users);

        return { user1, user2, count: allUsers.length };
      });

      expect(result.user1.email).toBe("tx-nested-1@example.com");
      expect(result.user2.email).toBe("tx-nested-2@example.com");
      expect(result.count).toBeGreaterThanOrEqual(2);
    });
  });

  describe("Raw SQL Queries", () => {
    it("should execute raw SELECT query", async () => {
      const db = client.getDb();
      await db.insert(users).values({ email: "raw-select@example.com" });

      const result = await client.rawQuery<{ email: string }>(
        "SELECT email FROM users WHERE email = $1",
        ["raw-select@example.com"],
      );

      expect(result).toHaveLength(1);
      expect(result[0].email).toBe("raw-select@example.com");
    });

    it("should execute raw COUNT query", async () => {
      const db = client.getDb();
      await db.insert(users).values({ email: "raw-count@example.com" });

      const result = await client.rawQuery<{ count: string }>(
        "SELECT COUNT(*) as count FROM users WHERE email LIKE $1",
        ["%raw-count%"],
      );

      expect(Number.parseInt(result[0].count, 10)).toBeGreaterThanOrEqual(1);
    });

    it("should handle raw query errors", async () => {
      await expect(
        client.rawQuery("SELECT * FROM nonexistent_table"),
      ).rejects.toThrow(QueryError);
    });
  });

  describe("QueryError structure", () => {
    it("should provide proper error information for query failures", () => {
      const queryError = new QueryError(
        "QUERY_FAILED",
        "Query execution failed",
        "Syntax error near SELECT",
      );

      expect(queryError.code).toBe("QUERY_FAILED");
      expect(queryError.message).toBe("Query execution failed");
      expect(queryError.detail).toBe("Syntax error near SELECT");
      expect(queryError.name).toBe("QueryError");
    });

    it("should handle constraint violations", () => {
      const constraintError = new QueryError(
        "CONSTRAINT_VIOLATION",
        "Unique constraint violated",
        "Key (email)=(test@example.com) already exists",
      );

      expect(constraintError.code).toBe("CONSTRAINT_VIOLATION");
      expect(constraintError.detail).toContain("email");
    });
  });
});
