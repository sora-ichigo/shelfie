import { eq } from "drizzle-orm";
import { drizzle, type NodePgDatabase } from "drizzle-orm/node-postgres";
import { beforeAll, describe, expect, it } from "vitest";
import { getGlobalTestPool } from "../../../vitest.setup.js";
import { users } from "../../db/schema/users.js";

describe("Drizzle ORM Integration Tests", () => {
  let db: NodePgDatabase;

  beforeAll(() => {
    const pool = getGlobalTestPool();
    db = drizzle(pool);
  });

  describe("CRUD Operations", () => {
    describe("Create (Insert)", () => {
      it("should insert a single user", async () => {
        const result = await db
          .insert(users)
          .values({
            email: "create-test@example.com",
            firebaseUid: `firebase-${Date.now()}-1`,
          })
          .returning();

        expect(result).toHaveLength(1);
        expect(result[0].email).toBe("create-test@example.com");
        expect(result[0].firebaseUid).toBeDefined();
        expect(result[0].id).toBeGreaterThan(0);
        expect(result[0].createdAt).toBeInstanceOf(Date);
        expect(result[0].updatedAt).toBeInstanceOf(Date);
      });

      it("should insert multiple users", async () => {
        const timestamp = Date.now();
        const result = await db
          .insert(users)
          .values([
            {
              email: "batch1@example.com",
              firebaseUid: `firebase-${timestamp}-b1`,
            },
            {
              email: "batch2@example.com",
              firebaseUid: `firebase-${timestamp}-b2`,
            },
          ])
          .returning();

        expect(result).toHaveLength(2);
        expect(result[0].email).toBe("batch1@example.com");
        expect(result[1].email).toBe("batch2@example.com");
      });
    });

    describe("Read (Select)", () => {
      it("should select all users", async () => {
        await db.insert(users).values({
          email: "select-all@example.com",
          firebaseUid: `firebase-${Date.now()}-selectall`,
        });

        const result = await db.select().from(users);

        expect(result.length).toBeGreaterThan(0);
        expect(result.some((u) => u.email === "select-all@example.com")).toBe(
          true,
        );
      });

      it("should select user by id", async () => {
        const [inserted] = await db
          .insert(users)
          .values({
            email: "select-by-id@example.com",
            firebaseUid: `firebase-${Date.now()}-byid`,
          })
          .returning();

        const result = await db
          .select()
          .from(users)
          .where(eq(users.id, inserted.id));

        expect(result).toHaveLength(1);
        expect(result[0].email).toBe("select-by-id@example.com");
      });

      it("should select user by email", async () => {
        await db.insert(users).values({
          email: "select-by-email@example.com",
          firebaseUid: `firebase-${Date.now()}-byemail`,
        });

        const result = await db
          .select()
          .from(users)
          .where(eq(users.email, "select-by-email@example.com"));

        expect(result).toHaveLength(1);
        expect(result[0].email).toBe("select-by-email@example.com");
      });

      it("should return empty array for non-existent user", async () => {
        const result = await db
          .select()
          .from(users)
          .where(eq(users.id, 999999));

        expect(result).toHaveLength(0);
      });
    });

    describe("Update", () => {
      it("should update user email", async () => {
        const [inserted] = await db
          .insert(users)
          .values({
            email: "before-update@example.com",
            firebaseUid: `firebase-${Date.now()}-update`,
          })
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
        const [inserted] = await db
          .insert(users)
          .values({
            email: "timestamp-test@example.com",
            firebaseUid: `firebase-${Date.now()}-timestamp`,
          })
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
        const [inserted] = await db
          .insert(users)
          .values({
            email: "delete-test@example.com",
            firebaseUid: `firebase-${Date.now()}-delete`,
          })
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
      const result = await db.transaction(async (tx) => {
        const [user] = await tx
          .insert(users)
          .values({
            email: "tx-commit@example.com",
            firebaseUid: `firebase-${Date.now()}-txcommit`,
          })
          .returning();
        return user;
      });

      expect(result.email).toBe("tx-commit@example.com");

      const [found] = await db
        .select()
        .from(users)
        .where(eq(users.id, result.id));
      expect(found).toBeDefined();
    });

    it("should rollback transaction on error", async () => {
      const timestamp = Date.now();
      const emailToCheck = `tx-rollback-${timestamp}@example.com`;

      await expect(
        db.transaction(async (tx) => {
          await tx.insert(users).values({
            email: emailToCheck,
            firebaseUid: `firebase-${timestamp}-txrollback`,
          });
          throw new Error("Force rollback");
        }),
      ).rejects.toThrow("Force rollback");

      const result = await db
        .select()
        .from(users)
        .where(eq(users.email, emailToCheck));
      expect(result).toHaveLength(0);
    });

    it("should support nested operations in transaction", async () => {
      const timestamp = Date.now();
      const result = await db.transaction(async (tx) => {
        const [user1] = await tx
          .insert(users)
          .values({
            email: "tx-nested-1@example.com",
            firebaseUid: `firebase-${timestamp}-nested1`,
          })
          .returning();

        const [user2] = await tx
          .insert(users)
          .values({
            email: "tx-nested-2@example.com",
            firebaseUid: `firebase-${timestamp}-nested2`,
          })
          .returning();

        const allUsers = await tx.select().from(users);

        return { user1, user2, count: allUsers.length };
      });

      expect(result.user1.email).toBe("tx-nested-1@example.com");
      expect(result.user2.email).toBe("tx-nested-2@example.com");
      expect(result.count).toBeGreaterThanOrEqual(2);
    });
  });
});
