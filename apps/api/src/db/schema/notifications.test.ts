import { getTableName, sql } from "drizzle-orm";
import { drizzle } from "drizzle-orm/node-postgres";
import { beforeEach, describe, expect, it } from "vitest";
import { getGlobalTestPool } from "../../../vitest.setup.js";
import {
  type AppNotification,
  type NewAppNotification,
  NOTIFICATIONS_RECIPIENT_CREATED_INDEX_NAME,
  NOTIFICATIONS_RECIPIENT_READ_INDEX_NAME,
  notifications,
} from "./notifications.js";
import { users } from "./users.js";

function getDb() {
  return drizzle(getGlobalTestPool());
}

describe("notifications schema", () => {
  describe("table definition", () => {
    it("should have table name 'notifications'", () => {
      expect(getTableName(notifications)).toBe("notifications");
    });

    it("should have id column as identity primary key", () => {
      const idColumn = notifications.id;
      expect(idColumn.name).toBe("id");
      expect(idColumn.notNull).toBe(true);
      expect(idColumn.primary).toBe(true);
    });

    it("should have recipient_id column as non-null integer", () => {
      const recipientIdColumn = notifications.recipientId;
      expect(recipientIdColumn.name).toBe("recipient_id");
      expect(recipientIdColumn.notNull).toBe(true);
    });

    it("should have sender_id column as non-null integer", () => {
      const senderIdColumn = notifications.senderId;
      expect(senderIdColumn.name).toBe("sender_id");
      expect(senderIdColumn.notNull).toBe(true);
    });

    it("should have type column as non-null text", () => {
      const typeColumn = notifications.type;
      expect(typeColumn.name).toBe("type");
      expect(typeColumn.notNull).toBe(true);
    });

    it("should have is_read column as non-null boolean with default false", () => {
      const isReadColumn = notifications.isRead;
      expect(isReadColumn.name).toBe("is_read");
      expect(isReadColumn.notNull).toBe(true);
      expect(isReadColumn.hasDefault).toBe(true);
    });

    it("should have created_at column with default now", () => {
      const createdAtColumn = notifications.createdAt;
      expect(createdAtColumn.name).toBe("created_at");
      expect(createdAtColumn.notNull).toBe(true);
      expect(createdAtColumn.hasDefault).toBe(true);
    });
  });

  describe("index definitions", () => {
    it("should have recipient_read index name constant", () => {
      expect(NOTIFICATIONS_RECIPIENT_READ_INDEX_NAME).toBe(
        "idx_notifications_recipient_read",
      );
    });

    it("should have recipient_created index name constant", () => {
      expect(NOTIFICATIONS_RECIPIENT_CREATED_INDEX_NAME).toBe(
        "idx_notifications_recipient_created",
      );
    });
  });

  describe("type inference", () => {
    it("should infer AppNotification type for select operations", () => {
      const notification: AppNotification = {
        id: 1,
        recipientId: 10,
        senderId: 20,
        type: "follow_request_received",
        isRead: false,
        createdAt: new Date(),
      };

      expect(notification.id).toBe(1);
      expect(notification.recipientId).toBe(10);
      expect(notification.senderId).toBe(20);
      expect(notification.type).toBe("follow_request_received");
      expect(notification.isRead).toBe(false);
      expect(notification.createdAt).toBeInstanceOf(Date);
    });

    it("should infer NewAppNotification type for insert operations (id should be optional)", () => {
      const newNotification: NewAppNotification = {
        recipientId: 10,
        senderId: 20,
        type: "follow_request_approved",
      };

      expect(newNotification.recipientId).toBe(10);
      expect(newNotification.senderId).toBe(20);
      expect(newNotification.type).toBe("follow_request_approved");
      expect("id" in newNotification).toBe(false);
    });

    it("should allow isRead and createdAt to be optional in NewAppNotification", () => {
      const newNotification: NewAppNotification = {
        recipientId: 10,
        senderId: 20,
        type: "follow_request_received",
      };

      expect(newNotification.isRead).toBeUndefined();
      expect(newNotification.createdAt).toBeUndefined();
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

    it("should create a notification with default is_read as false", async () => {
      const db = getDb();
      const [notification] = await db
        .insert(notifications)
        .values({
          recipientId: userAId,
          senderId: userBId,
          type: "follow_request_received",
        })
        .returning();

      expect(notification.id).toBe(1);
      expect(notification.recipientId).toBe(userAId);
      expect(notification.senderId).toBe(userBId);
      expect(notification.type).toBe("follow_request_received");
      expect(notification.isRead).toBe(false);
      expect(notification.createdAt).toBeInstanceOf(Date);
    });

    it("should create a notification with explicit is_read as true", async () => {
      const db = getDb();
      const [notification] = await db
        .insert(notifications)
        .values({
          recipientId: userAId,
          senderId: userBId,
          type: "follow_request_approved",
          isRead: true,
        })
        .returning();

      expect(notification.isRead).toBe(true);
    });

    it("should allow multiple notifications for the same recipient", async () => {
      const db = getDb();
      await db.insert(notifications).values({
        recipientId: userAId,
        senderId: userBId,
        type: "follow_request_received",
      });
      await db.insert(notifications).values({
        recipientId: userAId,
        senderId: userBId,
        type: "follow_request_approved",
      });

      const allNotifications = await db.select().from(notifications);
      expect(allNotifications).toHaveLength(2);
    });

    it("should cascade delete when recipient user is deleted", async () => {
      const db = getDb();
      await db.insert(notifications).values({
        recipientId: userAId,
        senderId: userBId,
        type: "follow_request_received",
      });

      await db.delete(users).where(sql`id = ${userAId}`);

      const allNotifications = await db.select().from(notifications);
      expect(allNotifications).toHaveLength(0);
    });

    it("should cascade delete when sender user is deleted", async () => {
      const db = getDb();
      await db.insert(notifications).values({
        recipientId: userAId,
        senderId: userBId,
        type: "follow_request_received",
      });

      await db.delete(users).where(sql`id = ${userBId}`);

      const allNotifications = await db.select().from(notifications);
      expect(allNotifications).toHaveLength(0);
    });

    it("should store both notification types", async () => {
      const db = getDb();
      const types = [
        "follow_request_received",
        "follow_request_approved",
      ] as const;

      for (const type of types) {
        await db.insert(notifications).values({
          recipientId: userAId,
          senderId: userBId,
          type,
        });
      }

      const allNotifications = await db.select().from(notifications);
      expect(allNotifications).toHaveLength(2);
      expect(allNotifications.map((n) => n.type)).toEqual(
        expect.arrayContaining([
          "follow_request_received",
          "follow_request_approved",
        ]),
      );
    });
  });
});
