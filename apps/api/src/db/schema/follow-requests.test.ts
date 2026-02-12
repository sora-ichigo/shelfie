import { getTableName, sql } from "drizzle-orm";
import { drizzle } from "drizzle-orm/node-postgres";
import { beforeEach, describe, expect, it } from "vitest";
import { getGlobalTestPool } from "../../../vitest.setup.js";
import {
  FOLLOW_REQUESTS_RECEIVER_STATUS_INDEX_NAME,
  FOLLOW_REQUESTS_SENDER_INDEX_NAME,
  FOLLOW_REQUESTS_UNIQUE_NAME,
  type FollowRequest,
  followRequests,
  type NewFollowRequest,
} from "./follow-requests.js";
import { users } from "./users.js";

function getDb() {
  return drizzle(getGlobalTestPool());
}

describe("follow_requests schema", () => {
  describe("table definition", () => {
    it("should have table name 'follow_requests'", () => {
      expect(getTableName(followRequests)).toBe("follow_requests");
    });

    it("should have id column as identity primary key", () => {
      const idColumn = followRequests.id;
      expect(idColumn.name).toBe("id");
      expect(idColumn.notNull).toBe(true);
      expect(idColumn.primary).toBe(true);
    });

    it("should have sender_id column as non-null integer", () => {
      const senderIdColumn = followRequests.senderId;
      expect(senderIdColumn.name).toBe("sender_id");
      expect(senderIdColumn.notNull).toBe(true);
    });

    it("should have receiver_id column as non-null integer", () => {
      const receiverIdColumn = followRequests.receiverId;
      expect(receiverIdColumn.name).toBe("receiver_id");
      expect(receiverIdColumn.notNull).toBe(true);
    });

    it("should have status column as non-null text with default 'pending'", () => {
      const statusColumn = followRequests.status;
      expect(statusColumn.name).toBe("status");
      expect(statusColumn.notNull).toBe(true);
      expect(statusColumn.hasDefault).toBe(true);
    });

    it("should have created_at column with default now", () => {
      const createdAtColumn = followRequests.createdAt;
      expect(createdAtColumn.name).toBe("created_at");
      expect(createdAtColumn.notNull).toBe(true);
      expect(createdAtColumn.hasDefault).toBe(true);
    });

    it("should have updated_at column with default now", () => {
      const updatedAtColumn = followRequests.updatedAt;
      expect(updatedAtColumn.name).toBe("updated_at");
      expect(updatedAtColumn.notNull).toBe(true);
      expect(updatedAtColumn.hasDefault).toBe(true);
    });
  });

  describe("index definitions", () => {
    it("should have unique constraint name constant for sender_id and receiver_id", () => {
      expect(FOLLOW_REQUESTS_UNIQUE_NAME).toBe("uq_follow_request");
    });

    it("should have receiver_status index name constant", () => {
      expect(FOLLOW_REQUESTS_RECEIVER_STATUS_INDEX_NAME).toBe(
        "idx_follow_requests_receiver_status",
      );
    });

    it("should have sender index name constant", () => {
      expect(FOLLOW_REQUESTS_SENDER_INDEX_NAME).toBe(
        "idx_follow_requests_sender",
      );
    });
  });

  describe("type inference", () => {
    it("should infer FollowRequest type for select operations", () => {
      const followRequest: FollowRequest = {
        id: 1,
        senderId: 10,
        receiverId: 20,
        status: "pending",
        createdAt: new Date(),
        updatedAt: new Date(),
      };

      expect(followRequest.id).toBe(1);
      expect(followRequest.senderId).toBe(10);
      expect(followRequest.receiverId).toBe(20);
      expect(followRequest.status).toBe("pending");
      expect(followRequest.createdAt).toBeInstanceOf(Date);
      expect(followRequest.updatedAt).toBeInstanceOf(Date);
    });

    it("should infer NewFollowRequest type for insert operations (id should be optional)", () => {
      const newFollowRequest: NewFollowRequest = {
        senderId: 10,
        receiverId: 20,
      };

      expect(newFollowRequest.senderId).toBe(10);
      expect(newFollowRequest.receiverId).toBe(20);
      expect("id" in newFollowRequest).toBe(false);
    });

    it("should allow status, createdAt and updatedAt to be optional in NewFollowRequest", () => {
      const newFollowRequest: NewFollowRequest = {
        senderId: 10,
        receiverId: 20,
      };

      expect(newFollowRequest.status).toBeUndefined();
      expect(newFollowRequest.createdAt).toBeUndefined();
      expect(newFollowRequest.updatedAt).toBeUndefined();
    });
  });

  describe("database constraints", () => {
    let userAId: number;
    let userBId: number;

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
      userAId = userA.id;
      userBId = userB.id;
    });

    it("should create a follow request with default status 'pending'", async () => {
      const db = getDb();
      const [request] = await db
        .insert(followRequests)
        .values({
          senderId: userAId,
          receiverId: userBId,
        })
        .returning();

      expect(request.id).toBe(1);
      expect(request.senderId).toBe(userAId);
      expect(request.receiverId).toBe(userBId);
      expect(request.status).toBe("pending");
      expect(request.createdAt).toBeInstanceOf(Date);
      expect(request.updatedAt).toBeInstanceOf(Date);
    });

    it("should enforce unique constraint on sender_id and receiver_id", async () => {
      const db = getDb();
      await db
        .insert(followRequests)
        .values({ senderId: userAId, receiverId: userBId });

      await expect(
        db
          .insert(followRequests)
          .values({ senderId: userAId, receiverId: userBId }),
      ).rejects.toThrow();
    });

    it("should prevent self-follow via CHECK constraint", async () => {
      const db = getDb();
      await expect(
        db
          .insert(followRequests)
          .values({ senderId: userAId, receiverId: userAId }),
      ).rejects.toThrow();
    });

    it("should cascade delete when sender user is deleted", async () => {
      const db = getDb();
      await db
        .insert(followRequests)
        .values({ senderId: userAId, receiverId: userBId });

      await db.delete(users).where(sql`id = ${userAId}`);

      const allRequests = await db.select().from(followRequests);
      expect(allRequests).toHaveLength(0);
    });

    it("should cascade delete when receiver user is deleted", async () => {
      const db = getDb();
      await db
        .insert(followRequests)
        .values({ senderId: userAId, receiverId: userBId });

      await db.delete(users).where(sql`id = ${userBId}`);

      const allRequests = await db.select().from(followRequests);
      expect(allRequests).toHaveLength(0);
    });

    it("should allow reverse direction requests (A->B and B->A)", async () => {
      const db = getDb();
      await db
        .insert(followRequests)
        .values({ senderId: userAId, receiverId: userBId });
      await db
        .insert(followRequests)
        .values({ senderId: userBId, receiverId: userAId });

      const allRequests = await db.select().from(followRequests);
      expect(allRequests).toHaveLength(2);
    });

    it("should create a follow request with explicit status", async () => {
      const db = getDb();
      const [request] = await db
        .insert(followRequests)
        .values({
          senderId: userAId,
          receiverId: userBId,
          status: "approved",
        })
        .returning();

      expect(request.status).toBe("approved");
    });
  });
});
