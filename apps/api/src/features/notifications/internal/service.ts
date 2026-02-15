import type { AppNotification } from "../../../db/schema/notifications.js";
import { err, ok, type Result } from "../../../errors/result.js";
import type {
  NotificationRepository,
  NotificationWithSender,
} from "./repository.js";

export type NotificationType =
  | "follow_request_received"
  | "follow_request_approved"
  | "new_follower";

const VALID_NOTIFICATION_TYPES: ReadonlySet<string> = new Set([
  "follow_request_received",
  "follow_request_approved",
  "new_follower",
]);

export interface CreateNotificationInput {
  recipientId: number;
  senderId: number;
  type: NotificationType;
}

export type NotificationServiceErrors = {
  code: "INVALID_INPUT";
  message: string;
};

export interface DeleteNotificationInput {
  senderId: number;
  recipientId: number;
  type: NotificationType;
}

export interface NotificationAppService {
  createNotification(
    input: CreateNotificationInput,
  ): Promise<Result<AppNotification, NotificationServiceErrors>>;
  getNotifications(
    recipientId: number,
    cursor: number | null,
    limit: number,
  ): Promise<NotificationWithSender[]>;
  getUnreadCount(recipientId: number): Promise<number>;
  markAsRead(notificationId: number, recipientId: number): Promise<void>;
  deleteNotification(input: DeleteNotificationInput): Promise<void>;
}

export function createNotificationAppService(
  repository: NotificationRepository,
): NotificationAppService {
  return {
    async createNotification(
      input: CreateNotificationInput,
    ): Promise<Result<AppNotification, NotificationServiceErrors>> {
      if (!VALID_NOTIFICATION_TYPES.has(input.type)) {
        return err({
          code: "INVALID_INPUT",
          message: `Invalid notification type: ${input.type}`,
        });
      }

      if (input.recipientId === input.senderId) {
        return err({
          code: "INVALID_INPUT",
          message: "Recipient and sender cannot be the same user",
        });
      }

      const notification = await repository.create({
        recipientId: input.recipientId,
        senderId: input.senderId,
        type: input.type,
      });

      return ok(notification);
    },

    async getNotifications(
      recipientId: number,
      cursor: number | null,
      limit: number,
    ): Promise<NotificationWithSender[]> {
      return repository.findByRecipient(recipientId, cursor, limit);
    },

    async getUnreadCount(recipientId: number): Promise<number> {
      return repository.countUnreadByRecipient(recipientId);
    },

    async markAsRead(
      notificationId: number,
      recipientId: number,
    ): Promise<void> {
      return repository.markAsReadById(notificationId, recipientId);
    },

    async deleteNotification(input: DeleteNotificationInput): Promise<void> {
      await repository.deleteBySenderAndType(
        input.senderId,
        input.recipientId,
        input.type,
      );
    },
  };
}
