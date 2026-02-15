import { describe, expect, it, vi } from "vitest";
import type { AppNotification } from "../../../db/schema/notifications.js";
import type { User } from "../../../db/schema/users.js";
import type {
  NotificationRepository,
  NotificationWithSender,
} from "./repository.js";
import { createNotificationAppService } from "./service.js";

function createMockRepository(): NotificationRepository {
  return {
    create: vi.fn(),
    findByRecipient: vi.fn(),
    countUnreadByRecipient: vi.fn(),
    markAsReadById: vi.fn(),
    deleteBySenderAndType: vi.fn(),
  };
}

const mockNotification: AppNotification = {
  id: 1,
  recipientId: 2,
  senderId: 3,
  type: "follow_request_received",
  isRead: false,
  createdAt: new Date("2026-01-01T00:00:00Z"),
};

const mockSender: User = {
  id: 3,
  email: "sender@example.com",
  firebaseUid: "firebase-uid-sender",
  name: "Sender User",
  avatarUrl: null,
  bio: null,
  instagramHandle: null,
  handle: "sender",
  isPublic: false,
  createdAt: new Date(),
  updatedAt: new Date(),
};

describe("NotificationAppService", () => {
  describe("createNotification", () => {
    it("should create a follow_request_received notification", async () => {
      const mockRepo = createMockRepository();
      vi.mocked(mockRepo.create).mockResolvedValue(mockNotification);

      const service = createNotificationAppService(mockRepo);
      const result = await service.createNotification({
        recipientId: 2,
        senderId: 3,
        type: "follow_request_received",
      });

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.recipientId).toBe(2);
        expect(result.data.senderId).toBe(3);
        expect(result.data.type).toBe("follow_request_received");
      }
      expect(mockRepo.create).toHaveBeenCalledWith({
        recipientId: 2,
        senderId: 3,
        type: "follow_request_received",
      });
    });

    it("should create a follow_request_approved notification", async () => {
      const mockRepo = createMockRepository();
      const approvedNotification: AppNotification = {
        ...mockNotification,
        type: "follow_request_approved",
      };
      vi.mocked(mockRepo.create).mockResolvedValue(approvedNotification);

      const service = createNotificationAppService(mockRepo);
      const result = await service.createNotification({
        recipientId: 2,
        senderId: 3,
        type: "follow_request_approved",
      });

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.type).toBe("follow_request_approved");
      }
    });

    it("should return error for invalid notification type", async () => {
      const mockRepo = createMockRepository();

      const service = createNotificationAppService(mockRepo);
      const result = await service.createNotification({
        recipientId: 2,
        senderId: 3,
        type: "invalid_type" as "follow_request_received",
      });

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("INVALID_INPUT");
      }
      expect(mockRepo.create).not.toHaveBeenCalled();
    });

    it("should return error when recipientId equals senderId", async () => {
      const mockRepo = createMockRepository();

      const service = createNotificationAppService(mockRepo);
      const result = await service.createNotification({
        recipientId: 2,
        senderId: 2,
        type: "follow_request_received",
      });

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("INVALID_INPUT");
      }
      expect(mockRepo.create).not.toHaveBeenCalled();
    });
  });

  describe("getNotifications", () => {
    it("should return notifications with sender info", async () => {
      const mockRepo = createMockRepository();
      const notificationsWithSender: NotificationWithSender[] = [
        { notification: mockNotification, sender: mockSender },
      ];
      vi.mocked(mockRepo.findByRecipient).mockResolvedValue(
        notificationsWithSender,
      );

      const service = createNotificationAppService(mockRepo);
      const result = await service.getNotifications(2, null, 20);

      expect(result).toEqual(notificationsWithSender);
      expect(mockRepo.findByRecipient).toHaveBeenCalledWith(2, null, 20);
    });

    it("should return empty array when no notifications", async () => {
      const mockRepo = createMockRepository();
      vi.mocked(mockRepo.findByRecipient).mockResolvedValue([]);

      const service = createNotificationAppService(mockRepo);
      const result = await service.getNotifications(2, null, 20);

      expect(result).toEqual([]);
    });

    it("should pass cursor for pagination", async () => {
      const mockRepo = createMockRepository();
      vi.mocked(mockRepo.findByRecipient).mockResolvedValue([]);

      const service = createNotificationAppService(mockRepo);
      await service.getNotifications(2, 10, 20);

      expect(mockRepo.findByRecipient).toHaveBeenCalledWith(2, 10, 20);
    });
  });

  describe("getUnreadCount", () => {
    it("should return unread count", async () => {
      const mockRepo = createMockRepository();
      vi.mocked(mockRepo.countUnreadByRecipient).mockResolvedValue(5);

      const service = createNotificationAppService(mockRepo);
      const result = await service.getUnreadCount(2);

      expect(result).toBe(5);
      expect(mockRepo.countUnreadByRecipient).toHaveBeenCalledWith(2);
    });

    it("should return 0 when no unread notifications", async () => {
      const mockRepo = createMockRepository();
      vi.mocked(mockRepo.countUnreadByRecipient).mockResolvedValue(0);

      const service = createNotificationAppService(mockRepo);
      const result = await service.getUnreadCount(2);

      expect(result).toBe(0);
    });
  });

  describe("markAsRead", () => {
    it("should mark a specific notification as read", async () => {
      const mockRepo = createMockRepository();
      vi.mocked(mockRepo.markAsReadById).mockResolvedValue(undefined);

      const service = createNotificationAppService(mockRepo);
      await service.markAsRead(1, 2);

      expect(mockRepo.markAsReadById).toHaveBeenCalledWith(1, 2);
    });
  });

  describe("deleteNotification", () => {
    it("should delete notification by sender, recipient and type", async () => {
      const mockRepo = createMockRepository();
      vi.mocked(mockRepo.deleteBySenderAndType).mockResolvedValue(undefined);

      const service = createNotificationAppService(mockRepo);
      await service.deleteNotification({
        senderId: 3,
        recipientId: 2,
        type: "follow_request_received",
      });

      expect(mockRepo.deleteBySenderAndType).toHaveBeenCalledWith(
        3,
        2,
        "follow_request_received",
      );
    });
  });
});
