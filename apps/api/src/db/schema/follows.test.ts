import { getTableName, sql } from "drizzle-orm";
import { drizzle } from "drizzle-orm/node-postgres";
import { beforeEach, describe, expect, it } from "vitest";
import { getGlobalTestPool } from "../../../vitest.setup.js";
import {
  FOLLOWS_UNIQUE_NAME,
  FOLLOWS_USER_A_INDEX_NAME,
  FOLLOWS_USER_B_INDEX_NAME,
  type Follow,
  follows,
  type NewFollow,
} from "./follows.js";
import { users } from "./users.js";

function getDb() {
  return drizzle(getGlobalTestPool());
}

describe("follows schema", () => {
  describe("table definition", () => {
    it("should have table name 'follows'", () => {
      expect(getTableName(follows)).toBe("follows");
    });

    it("should have id column as identity primary key", () => {
      const idColumn = follows.id;
      expect(idColumn.name).toBe("id");
      expect(idColumn.notNull).toBe(true);
      expect(idColumn.primary).toBe(true);
    });

    it("should have user_id_a column as non-null integer", () => {
      const userIdAColumn = follows.userIdA;
      expect(userIdAColumn.name).toBe("user_id_a");
      expect(userIdAColumn.notNull).toBe(true);
    });

    it("should have user_id_b column as non-null integer", () => {
      const userIdBColumn = follows.userIdB;
      expect(userIdBColumn.name).toBe("user_id_b");
      expect(userIdBColumn.notNull).toBe(true);
    });

    it("should have created_at column with default now", () => {
      const createdAtColumn = follows.createdAt;
      expect(createdAtColumn.name).toBe("created_at");
      expect(createdAtColumn.notNull).toBe(true);
      expect(createdAtColumn.hasDefault).toBe(true);
    });
  });

  describe("index definitions", () => {
    it("should have unique constraint name constant for user_id_a and user_id_b", () => {
      expect(FOLLOWS_UNIQUE_NAME).toBe("uq_follow");
    });

    it("should have user_a index name constant", () => {
      expect(FOLLOWS_USER_A_INDEX_NAME).toBe("idx_follows_user_a");
    });

    it("should have user_b index name constant", () => {
      expect(FOLLOWS_USER_B_INDEX_NAME).toBe("idx_follows_user_b");
    });
  });

  describe("type inference", () => {
    it("should infer Follow type for select operations", () => {
      const follow: Follow = {
        id: 1,
        userIdA: 5,
        userIdB: 10,
        createdAt: new Date(),
      };

      expect(follow.id).toBe(1);
      expect(follow.userIdA).toBe(5);
      expect(follow.userIdB).toBe(10);
      expect(follow.createdAt).toBeInstanceOf(Date);
    });

    it("should infer NewFollow type for insert operations (id should be optional)", () => {
      const newFollow: NewFollow = {
        userIdA: 5,
        userIdB: 10,
      };

      expect(newFollow.userIdA).toBe(5);
      expect(newFollow.userIdB).toBe(10);
      expect("id" in newFollow).toBe(false);
    });

    it("should allow createdAt to be optional in NewFollow", () => {
      const newFollow: NewFollow = {
        userIdA: 5,
        userIdB: 10,
      };

      expect(newFollow.createdAt).toBeUndefined();
    });
  });

  describe("database constraints", () => {
    let userAId: number;
    let userBId: number;
    let userCId: number;

    beforeEach(async () => {
      const db = getDb();
      const [userA] = await db
        .insert(users)
        .values({
          email: "usera@example.com",
          firebaseUid: "firebase-uid-a",
        })
        .returning();
      const [userB] = await db
        .insert(users)
        .values({
          email: "userb@example.com",
          firebaseUid: "firebase-uid-b",
        })
        .returning();
      const [userC] = await db
        .insert(users)
        .values({
          email: "userc@example.com",
          firebaseUid: "firebase-uid-c",
        })
        .returning();
      userAId = userA.id;
      userBId = userB.id;
      userCId = userC.id;
    });

    it("should create a follow relationship", async () => {
      const db = getDb();
      const [follow] = await db
        .insert(follows)
        .values({
          userIdA: userAId,
          userIdB: userBId,
        })
        .returning();

      expect(follow.id).toBe(1);
      expect(follow.userIdA).toBe(userAId);
      expect(follow.userIdB).toBe(userBId);
      expect(follow.createdAt).toBeInstanceOf(Date);
    });

    it("should enforce unique constraint on user_id_a and user_id_b", async () => {
      const db = getDb();
      await db.insert(follows).values({ userIdA: userAId, userIdB: userBId });

      await expect(
        db.insert(follows).values({ userIdA: userAId, userIdB: userBId }),
      ).rejects.toThrow();
    });

    it("should enforce CHECK constraint that user_id_a < user_id_b", async () => {
      const db = getDb();
      const larger = Math.max(userAId, userBId);
      const smaller = Math.min(userAId, userBId);

      await expect(
        db.insert(follows).values({ userIdA: larger, userIdB: smaller }),
      ).rejects.toThrow();
    });

    it("should reject user_id_a equal to user_id_b", async () => {
      const db = getDb();
      await expect(
        db.insert(follows).values({ userIdA: userAId, userIdB: userAId }),
      ).rejects.toThrow();
    });

    it("should allow multiple follow relationships for same user", async () => {
      const db = getDb();
      const smallerAB = Math.min(userAId, userBId);
      const largerAB = Math.max(userAId, userBId);
      const smallerAC = Math.min(userAId, userCId);
      const largerAC = Math.max(userAId, userCId);

      await db
        .insert(follows)
        .values({ userIdA: smallerAB, userIdB: largerAB });
      await db
        .insert(follows)
        .values({ userIdA: smallerAC, userIdB: largerAC });

      const allFollows = await db.select().from(follows);
      expect(allFollows).toHaveLength(2);
    });

    it("should cascade delete when user_a is deleted", async () => {
      const db = getDb();
      const smaller = Math.min(userAId, userBId);
      const larger = Math.max(userAId, userBId);

      await db.insert(follows).values({ userIdA: smaller, userIdB: larger });

      await db.delete(users).where(sql`id = ${smaller}`);

      const allFollows = await db.select().from(follows);
      expect(allFollows).toHaveLength(0);
    });

    it("should cascade delete when user_b is deleted", async () => {
      const db = getDb();
      const smaller = Math.min(userAId, userBId);
      const larger = Math.max(userAId, userBId);

      await db.insert(follows).values({ userIdA: smaller, userIdB: larger });

      await db.delete(users).where(sql`id = ${larger}`);

      const allFollows = await db.select().from(follows);
      expect(allFollows).toHaveLength(0);
    });
  });
});
