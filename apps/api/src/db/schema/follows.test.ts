import { getTableName, sql } from "drizzle-orm";
import { drizzle } from "drizzle-orm/node-postgres";
import { beforeEach, describe, expect, it } from "vitest";
import { getGlobalTestPool } from "../../../vitest.setup.js";
import {
  FOLLOWS_FOLLOWEE_INDEX_NAME,
  FOLLOWS_FOLLOWER_INDEX_NAME,
  FOLLOWS_UNIQUE_NAME,
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

    it("should have follower_id column as non-null integer", () => {
      const followerIdColumn = follows.followerId;
      expect(followerIdColumn.name).toBe("follower_id");
      expect(followerIdColumn.notNull).toBe(true);
    });

    it("should have followee_id column as non-null integer", () => {
      const followeeIdColumn = follows.followeeId;
      expect(followeeIdColumn.name).toBe("followee_id");
      expect(followeeIdColumn.notNull).toBe(true);
    });

    it("should have created_at column with default now", () => {
      const createdAtColumn = follows.createdAt;
      expect(createdAtColumn.name).toBe("created_at");
      expect(createdAtColumn.notNull).toBe(true);
      expect(createdAtColumn.hasDefault).toBe(true);
    });
  });

  describe("index definitions", () => {
    it("should have unique constraint name constant for follower_id and followee_id", () => {
      expect(FOLLOWS_UNIQUE_NAME).toBe("uq_follow");
    });

    it("should have follower index name constant", () => {
      expect(FOLLOWS_FOLLOWER_INDEX_NAME).toBe("idx_follows_follower");
    });

    it("should have followee index name constant", () => {
      expect(FOLLOWS_FOLLOWEE_INDEX_NAME).toBe("idx_follows_followee");
    });
  });

  describe("type inference", () => {
    it("should infer Follow type for select operations", () => {
      const follow: Follow = {
        id: 1,
        followerId: 5,
        followeeId: 10,
        createdAt: new Date(),
      };

      expect(follow.id).toBe(1);
      expect(follow.followerId).toBe(5);
      expect(follow.followeeId).toBe(10);
      expect(follow.createdAt).toBeInstanceOf(Date);
    });

    it("should infer NewFollow type for insert operations (id should be optional)", () => {
      const newFollow: NewFollow = {
        followerId: 5,
        followeeId: 10,
      };

      expect(newFollow.followerId).toBe(5);
      expect(newFollow.followeeId).toBe(10);
      expect("id" in newFollow).toBe(false);
    });

    it("should allow createdAt to be optional in NewFollow", () => {
      const newFollow: NewFollow = {
        followerId: 5,
        followeeId: 10,
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

    it("should create a follow relationship (A follows B)", async () => {
      const db = getDb();
      const [follow] = await db
        .insert(follows)
        .values({
          followerId: userAId,
          followeeId: userBId,
        })
        .returning();

      expect(follow.id).toBe(1);
      expect(follow.followerId).toBe(userAId);
      expect(follow.followeeId).toBe(userBId);
      expect(follow.createdAt).toBeInstanceOf(Date);
    });

    it("should allow reverse follow relationship (B follows A)", async () => {
      const db = getDb();
      await db
        .insert(follows)
        .values({ followerId: userAId, followeeId: userBId });
      const [reverseFollow] = await db
        .insert(follows)
        .values({ followerId: userBId, followeeId: userAId })
        .returning();

      expect(reverseFollow.followerId).toBe(userBId);
      expect(reverseFollow.followeeId).toBe(userAId);

      const allFollows = await db.select().from(follows);
      expect(allFollows).toHaveLength(2);
    });

    it("should enforce unique constraint on same direction (follower_id, followee_id)", async () => {
      const db = getDb();
      await db
        .insert(follows)
        .values({ followerId: userAId, followeeId: userBId });

      await expect(
        db.insert(follows).values({ followerId: userAId, followeeId: userBId }),
      ).rejects.toThrow();
    });

    it("should enforce CHECK constraint that follower_id != followee_id (no self-follow)", async () => {
      const db = getDb();
      await expect(
        db.insert(follows).values({ followerId: userAId, followeeId: userAId }),
      ).rejects.toThrow();
    });

    it("should allow multiple follow relationships for same user", async () => {
      const db = getDb();
      await db
        .insert(follows)
        .values({ followerId: userAId, followeeId: userBId });
      await db
        .insert(follows)
        .values({ followerId: userAId, followeeId: userCId });

      const allFollows = await db.select().from(follows);
      expect(allFollows).toHaveLength(2);
    });

    it("should cascade delete when follower is deleted", async () => {
      const db = getDb();
      await db
        .insert(follows)
        .values({ followerId: userAId, followeeId: userBId });

      await db.delete(users).where(sql`id = ${userAId}`);

      const allFollows = await db.select().from(follows);
      expect(allFollows).toHaveLength(0);
    });

    it("should cascade delete when followee is deleted", async () => {
      const db = getDb();
      await db
        .insert(follows)
        .values({ followerId: userAId, followeeId: userBId });

      await db.delete(users).where(sql`id = ${userBId}`);

      const allFollows = await db.select().from(follows);
      expect(allFollows).toHaveLength(0);
    });
  });
});
