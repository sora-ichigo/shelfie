import { and, count, desc, eq, lt } from "drizzle-orm";
import type { NodePgDatabase } from "drizzle-orm/node-postgres";
import {
  type AppNotification,
  type NewAppNotification,
  notifications,
} from "../../../db/schema/notifications.js";
import { type User, users } from "../../../db/schema/users.js";

export type {
  AppNotification,
  NewAppNotification,
} from "../../../db/schema/notifications.js";

export interface NotificationWithSender {
  notification: AppNotification;
  sender: User;
}

export interface NotificationRepository {
  create(data: NewAppNotification): Promise<AppNotification>;
  findByRecipient(
    recipientId: number,
    cursor: number | null,
    limit: number,
  ): Promise<NotificationWithSender[]>;
  countUnreadByRecipient(recipientId: number): Promise<number>;
  markAsReadByRecipient(recipientId: number): Promise<void>;
  deleteBySenderAndType(
    senderId: number,
    recipientId: number,
    type: string,
  ): Promise<void>;
}

export function createNotificationRepository(
  db: NodePgDatabase,
): NotificationRepository {
  return {
    async create(data: NewAppNotification): Promise<AppNotification> {
      const result = await db.insert(notifications).values(data).returning();
      return result[0];
    },

    async findByRecipient(
      recipientId: number,
      cursor: number | null,
      limit: number,
    ): Promise<NotificationWithSender[]> {
      const conditions = [eq(notifications.recipientId, recipientId)];
      if (cursor !== null) {
        conditions.push(lt(notifications.id, cursor));
      }

      const result = await db
        .select({
          notification: notifications,
          sender: users,
        })
        .from(notifications)
        .innerJoin(users, eq(notifications.senderId, users.id))
        .where(and(...conditions))
        .orderBy(desc(notifications.createdAt))
        .limit(limit);

      return result;
    },

    async countUnreadByRecipient(recipientId: number): Promise<number> {
      const result = await db
        .select({ count: count() })
        .from(notifications)
        .where(
          and(
            eq(notifications.recipientId, recipientId),
            eq(notifications.isRead, false),
          ),
        );
      return Number(result[0]?.count ?? 0);
    },

    async markAsReadByRecipient(recipientId: number): Promise<void> {
      await db
        .update(notifications)
        .set({ isRead: true })
        .where(
          and(
            eq(notifications.recipientId, recipientId),
            eq(notifications.isRead, false),
          ),
        );
    },

    async deleteBySenderAndType(
      senderId: number,
      recipientId: number,
      type: string,
    ): Promise<void> {
      await db
        .delete(notifications)
        .where(
          and(
            eq(notifications.senderId, senderId),
            eq(notifications.recipientId, recipientId),
            eq(notifications.type, type),
          ),
        );
    },
  };
}
