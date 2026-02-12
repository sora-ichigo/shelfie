import { describe, expect, it, vi } from "vitest";
import type {
  AppNotification,
  NewAppNotification,
} from "../../../db/schema/notifications.js";
import type { User } from "../../../db/schema/users.js";
import { createNotificationRepository } from "./repository.js";

function createMockDb() {
  const mockResults: unknown[] = [];

  const resolveResults = () => Promise.resolve(mockResults);

  const mockQuery: Record<string, ReturnType<typeof vi.fn>> = {};

  const chainMethods = [
    "select",
    "from",
    "where",
    "orderBy",
    "limit",
    "offset",
    "insert",
    "values",
    "update",
    "set",
    "innerJoin",
    "leftJoin",
  ];

  for (const method of chainMethods) {
    mockQuery[method] = vi.fn().mockReturnValue(
      new Proxy(
        {},
        {
          get: (_target, prop: string) => {
            if (prop === "then") {
              return resolveResults().then.bind(resolveResults());
            }
            if (mockQuery[prop]) {
              return mockQuery[prop];
            }
            return vi.fn().mockReturnThis();
          },
        },
      ),
    );
  }

  mockQuery.returning = vi
    .fn()
    .mockImplementation(() => Promise.resolve(mockResults));

  return {
    query: mockQuery,
    setResults: (results: unknown[]) => {
      mockResults.length = 0;
      mockResults.push(...results);
    },
    clearMocks: () => {
      vi.clearAllMocks();
      mockResults.length = 0;
    },
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

const mockUser: User = {
  id: 3,
  email: "sender@example.com",
  firebaseUid: "firebase-uid-sender",
  name: "Sender User",
  avatarUrl: null,
  bio: null,
  instagramHandle: null,
  handle: "sender",
  createdAt: new Date(),
  updatedAt: new Date(),
};

describe("NotificationRepository", () => {
  describe("interface compliance", () => {
    it("should implement all NotificationRepository methods", () => {
      const mockDb = createMockDb();
      const repository = createNotificationRepository(mockDb.query as never);

      expect(typeof repository.create).toBe("function");
      expect(typeof repository.findByRecipient).toBe("function");
      expect(typeof repository.countUnreadByRecipient).toBe("function");
      expect(typeof repository.markAsReadByRecipient).toBe("function");
    });
  });

  describe("create", () => {
    it("should create a notification and return it", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([mockNotification]);

      const repository = createNotificationRepository(mockDb.query as never);
      const input: NewAppNotification = {
        recipientId: 2,
        senderId: 3,
        type: "follow_request_received",
      };

      const result = await repository.create(input);

      expect(result).toEqual(mockNotification);
      expect(mockDb.query.insert).toHaveBeenCalled();
    });

    it("should create a notification with follow_request_approved type", async () => {
      const mockDb = createMockDb();
      const approvedNotification: AppNotification = {
        ...mockNotification,
        type: "follow_request_approved",
      };
      mockDb.setResults([approvedNotification]);

      const repository = createNotificationRepository(mockDb.query as never);
      const input: NewAppNotification = {
        recipientId: 2,
        senderId: 3,
        type: "follow_request_approved",
      };

      const result = await repository.create(input);

      expect(result.type).toBe("follow_request_approved");
    });
  });

  describe("findByRecipient", () => {
    it("should return notifications with sender info for a recipient", async () => {
      const mockDb = createMockDb();
      const notificationWithSender = {
        notification: mockNotification,
        sender: mockUser,
      };
      mockDb.setResults([notificationWithSender]);

      const repository = createNotificationRepository(mockDb.query as never);
      const result = await repository.findByRecipient(2, null, 20);

      expect(result).toEqual([notificationWithSender]);
    });

    it("should return empty array when no notifications exist", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([]);

      const repository = createNotificationRepository(mockDb.query as never);
      const result = await repository.findByRecipient(2, null, 20);

      expect(result).toEqual([]);
    });

    it("should accept cursor parameter for pagination", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([]);

      const repository = createNotificationRepository(mockDb.query as never);
      const result = await repository.findByRecipient(2, 10, 20);

      expect(result).toEqual([]);
    });
  });

  describe("countUnreadByRecipient", () => {
    it("should return count of unread notifications", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([{ count: 5 }]);

      const repository = createNotificationRepository(mockDb.query as never);
      const result = await repository.countUnreadByRecipient(2);

      expect(result).toBe(5);
    });

    it("should return 0 when no unread notifications exist", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([{ count: 0 }]);

      const repository = createNotificationRepository(mockDb.query as never);
      const result = await repository.countUnreadByRecipient(2);

      expect(result).toBe(0);
    });
  });

  describe("markAsReadByRecipient", () => {
    it("should mark all unread notifications as read for a recipient", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([]);

      const repository = createNotificationRepository(mockDb.query as never);
      await repository.markAsReadByRecipient(2);

      expect(mockDb.query.update).toHaveBeenCalled();
    });
  });
});
