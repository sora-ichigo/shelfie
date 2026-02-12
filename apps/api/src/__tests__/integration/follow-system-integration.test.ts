import { describe, expect, it, vi } from "vitest";
import type { FollowRequest } from "../../db/schema/follow-requests.js";
import type { Follow } from "../../db/schema/follows.js";
import type { AppNotification } from "../../db/schema/notifications.js";
import type { NotificationService } from "../../features/device-tokens/internal/notification-service.js";
import type { FollowRepository } from "../../features/follows/internal/repository.js";
import { createFollowService } from "../../features/follows/internal/service.js";
import type { NotificationRepository } from "../../features/notifications/internal/repository.js";
import { createNotificationAppService } from "../../features/notifications/internal/service.js";
import type { LoggerService } from "../../logger/index.js";

function createMockFollowRepository(): FollowRepository {
  return {
    createRequest: vi.fn(),
    findRequestById: vi.fn(),
    findRequestBySenderAndReceiver: vi.fn(),
    findPendingRequestsByReceiver: vi.fn(),
    countPendingRequestsByReceiver: vi.fn(),
    updateRequestStatus: vi.fn(),
    createFollow: vi.fn(),
    deleteFollow: vi.fn(),
    findFollow: vi.fn(),
    findFollowing: vi.fn(),
    findFollowers: vi.fn(),
    countFollowing: vi.fn(),
    countFollowers: vi.fn(),
  };
}

function createMockNotificationRepository(): NotificationRepository {
  return {
    create: vi.fn(),
    findByRecipient: vi.fn(),
    countUnreadByRecipient: vi.fn(),
    markAsReadByRecipient: vi.fn(),
  };
}

function createMockPushNotificationService(): NotificationService {
  return {
    sendNotification: vi.fn().mockResolvedValue({
      success: true as const,
      data: {
        totalTargets: 1,
        successCount: 1,
        failureCount: 0,
        invalidTokensRemoved: 0,
        failures: [],
      },
    }),
  };
}

function createMockLogger(): LoggerService {
  return {
    debug: vi.fn(),
    info: vi.fn(),
    warn: vi.fn(),
    error: vi.fn(),
    child: vi.fn().mockReturnThis(),
  };
}

function createMockFollowRequest(
  overrides: Partial<FollowRequest> = {},
): FollowRequest {
  return {
    id: 1,
    senderId: 1,
    receiverId: 2,
    status: "pending",
    createdAt: new Date("2026-01-01T00:00:00Z"),
    updatedAt: new Date("2026-01-01T00:00:00Z"),
    ...overrides,
  };
}

function createMockFollow(overrides: Partial<Follow> = {}): Follow {
  return {
    id: 1,
    userIdA: 1,
    userIdB: 2,
    createdAt: new Date("2026-01-01T00:00:00Z"),
    ...overrides,
  };
}

function createMockNotification(
  overrides: Partial<AppNotification> = {},
): AppNotification {
  return {
    id: 1,
    recipientId: 2,
    senderId: 1,
    type: "follow_request_received",
    isRead: false,
    createdAt: new Date("2026-01-01T00:00:00Z"),
    ...overrides,
  };
}

describe("Follow System Integration", () => {
  describe("フォローリクエスト送信 → 承認 → フォロー関係成立 → フォロー解除の完全フロー", () => {
    it("should complete the full follow lifecycle", async () => {
      const followRepo = createMockFollowRepository();
      const notifRepo = createMockNotificationRepository();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      const notificationAppService = createNotificationAppService(notifRepo);
      const followService = createFollowService(
        followRepo,
        notificationAppService,
        pushService,
        logger,
      );

      // Step 1: フォローリクエスト送信
      const pendingRequest = createMockFollowRequest({
        id: 1,
        senderId: 1,
        receiverId: 2,
        status: "pending",
      });
      vi.mocked(followRepo.findFollow).mockResolvedValue(null);
      vi.mocked(followRepo.findRequestBySenderAndReceiver).mockResolvedValue(
        null,
      );
      vi.mocked(followRepo.createRequest).mockResolvedValue(pendingRequest);
      vi.mocked(notifRepo.create).mockResolvedValue(
        createMockNotification({
          id: 1,
          recipientId: 2,
          senderId: 1,
          type: "follow_request_received",
        }),
      );

      const sendResult = await followService.sendRequest(1, 2);
      expect(sendResult.success).toBe(true);
      if (sendResult.success) {
        expect(sendResult.data.senderId).toBe(1);
        expect(sendResult.data.receiverId).toBe(2);
        expect(sendResult.data.status).toBe("pending");
      }

      // 非同期通知が発行されるのを待つ
      await new Promise((resolve) => setTimeout(resolve, 10));

      expect(notifRepo.create).toHaveBeenCalledWith({
        recipientId: 2,
        senderId: 1,
        type: "follow_request_received",
      });
      expect(pushService.sendNotification).toHaveBeenCalledWith(
        expect.objectContaining({
          userIds: [2],
          data: { type: "follow_request_received" },
        }),
      );

      // Step 2: フォローリクエスト承認
      const approvedRequest = createMockFollowRequest({
        id: 1,
        senderId: 1,
        receiverId: 2,
        status: "approved",
      });
      vi.mocked(followRepo.findRequestById).mockResolvedValue(pendingRequest);
      vi.mocked(followRepo.updateRequestStatus).mockResolvedValue(
        approvedRequest,
      );
      vi.mocked(followRepo.createFollow).mockResolvedValue(
        createMockFollow({ id: 1, userIdA: 1, userIdB: 2 }),
      );
      vi.mocked(notifRepo.create).mockResolvedValue(
        createMockNotification({
          id: 2,
          recipientId: 1,
          senderId: 2,
          type: "follow_request_approved",
        }),
      );

      const approveResult = await followService.approveRequest(1, 2);
      expect(approveResult.success).toBe(true);
      if (approveResult.success) {
        expect(approveResult.data.status).toBe("approved");
      }

      expect(followRepo.createFollow).toHaveBeenCalledWith(1, 2);

      // 非同期通知が発行されるのを待つ
      await new Promise((resolve) => setTimeout(resolve, 10));

      expect(notifRepo.create).toHaveBeenCalledWith({
        recipientId: 1,
        senderId: 2,
        type: "follow_request_approved",
      });

      // Step 3: フォロー関係の存在確認
      vi.mocked(followRepo.findFollow).mockResolvedValue(
        createMockFollow({ id: 1, userIdA: 1, userIdB: 2 }),
      );

      const followStatus = await followService.getFollowStatus(1, 2);
      expect(followStatus).toBe("FOLLOWING");

      // Step 4: フォロー解除
      const unfollowResult = await followService.unfollow(1, 2);
      expect(unfollowResult.success).toBe(true);
      expect(followRepo.deleteFollow).toHaveBeenCalledWith(1, 2);

      // Step 5: フォロー解除後の状態確認
      vi.mocked(followRepo.findFollow).mockResolvedValue(null);
      vi.mocked(followRepo.findRequestBySenderAndReceiver).mockResolvedValue(
        approvedRequest,
      );

      const statusAfterUnfollow = await followService.getFollowStatus(1, 2);
      expect(statusAfterUnfollow).toBe("NONE");
    });
  });

  describe("フォローリクエスト送信 → 通知レコード作成の連携フロー", () => {
    it("should create app notification when follow request is sent", async () => {
      const followRepo = createMockFollowRepository();
      const notifRepo = createMockNotificationRepository();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      const notificationAppService = createNotificationAppService(notifRepo);
      const followService = createFollowService(
        followRepo,
        notificationAppService,
        pushService,
        logger,
      );

      vi.mocked(followRepo.findFollow).mockResolvedValue(null);
      vi.mocked(followRepo.findRequestBySenderAndReceiver).mockResolvedValue(
        null,
      );
      vi.mocked(followRepo.createRequest).mockResolvedValue(
        createMockFollowRequest({ senderId: 10, receiverId: 20 }),
      );
      vi.mocked(notifRepo.create).mockResolvedValue(
        createMockNotification({
          recipientId: 20,
          senderId: 10,
          type: "follow_request_received",
        }),
      );

      const result = await followService.sendRequest(10, 20);
      expect(result.success).toBe(true);

      await new Promise((resolve) => setTimeout(resolve, 10));

      expect(notifRepo.create).toHaveBeenCalledWith({
        recipientId: 20,
        senderId: 10,
        type: "follow_request_received",
      });
    });

    it("should not fail follow request creation when notification creation fails", async () => {
      const followRepo = createMockFollowRepository();
      const notifRepo = createMockNotificationRepository();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      const notificationAppService = createNotificationAppService(notifRepo);
      const followService = createFollowService(
        followRepo,
        notificationAppService,
        pushService,
        logger,
      );

      vi.mocked(followRepo.findFollow).mockResolvedValue(null);
      vi.mocked(followRepo.findRequestBySenderAndReceiver).mockResolvedValue(
        null,
      );
      vi.mocked(followRepo.createRequest).mockResolvedValue(
        createMockFollowRequest(),
      );
      vi.mocked(notifRepo.create).mockRejectedValue(
        new Error("DB connection error"),
      );

      const result = await followService.sendRequest(1, 2);
      expect(result.success).toBe(true);

      await new Promise((resolve) => setTimeout(resolve, 10));

      expect(logger.error).toHaveBeenCalledWith(
        expect.stringContaining("Failed to create app notification"),
        expect.any(Error),
        expect.any(Object),
      );
    });
  });

  describe("フォローリクエスト承認 → 送信者向け通知レコード作成の連携フロー", () => {
    it("should create approved notification for the sender when request is approved", async () => {
      const followRepo = createMockFollowRepository();
      const notifRepo = createMockNotificationRepository();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      const notificationAppService = createNotificationAppService(notifRepo);
      const followService = createFollowService(
        followRepo,
        notificationAppService,
        pushService,
        logger,
      );

      const pendingRequest = createMockFollowRequest({
        id: 5,
        senderId: 10,
        receiverId: 20,
        status: "pending",
      });

      vi.mocked(followRepo.findRequestById).mockResolvedValue(pendingRequest);
      vi.mocked(followRepo.updateRequestStatus).mockResolvedValue(
        createMockFollowRequest({
          id: 5,
          senderId: 10,
          receiverId: 20,
          status: "approved",
        }),
      );
      vi.mocked(followRepo.createFollow).mockResolvedValue(
        createMockFollow({ userIdA: 10, userIdB: 20 }),
      );
      vi.mocked(notifRepo.create).mockResolvedValue(
        createMockNotification({
          recipientId: 10,
          senderId: 20,
          type: "follow_request_approved",
        }),
      );

      const result = await followService.approveRequest(5, 20);
      expect(result.success).toBe(true);

      await new Promise((resolve) => setTimeout(resolve, 10));

      expect(notifRepo.create).toHaveBeenCalledWith({
        recipientId: 10,
        senderId: 20,
        type: "follow_request_approved",
      });
    });
  });

  describe("フォローリクエスト拒否フロー", () => {
    it("should reject request without creating notification or follow", async () => {
      const followRepo = createMockFollowRepository();
      const notifRepo = createMockNotificationRepository();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      const notificationAppService = createNotificationAppService(notifRepo);
      const followService = createFollowService(
        followRepo,
        notificationAppService,
        pushService,
        logger,
      );

      const pendingRequest = createMockFollowRequest({
        id: 3,
        senderId: 1,
        receiverId: 2,
        status: "pending",
      });

      vi.mocked(followRepo.findRequestById).mockResolvedValue(pendingRequest);
      vi.mocked(followRepo.updateRequestStatus).mockResolvedValue(
        createMockFollowRequest({ id: 3, status: "rejected" }),
      );

      const result = await followService.rejectRequest(3, 2);
      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.status).toBe("rejected");
      }

      expect(followRepo.createFollow).not.toHaveBeenCalled();
      expect(notifRepo.create).not.toHaveBeenCalled();
    });
  });

  describe("プッシュ通知送信失敗時のフォールバック", () => {
    it("should not fail follow request when push notification fails", async () => {
      const followRepo = createMockFollowRepository();
      const notifRepo = createMockNotificationRepository();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      vi.mocked(pushService.sendNotification).mockRejectedValue(
        new Error("FCM unavailable"),
      );

      const notificationAppService = createNotificationAppService(notifRepo);
      const followService = createFollowService(
        followRepo,
        notificationAppService,
        pushService,
        logger,
      );

      vi.mocked(followRepo.findFollow).mockResolvedValue(null);
      vi.mocked(followRepo.findRequestBySenderAndReceiver).mockResolvedValue(
        null,
      );
      vi.mocked(followRepo.createRequest).mockResolvedValue(
        createMockFollowRequest(),
      );
      vi.mocked(notifRepo.create).mockResolvedValue(createMockNotification());

      const result = await followService.sendRequest(1, 2);
      expect(result.success).toBe(true);

      await new Promise((resolve) => setTimeout(resolve, 10));

      expect(logger.error).toHaveBeenCalledWith(
        expect.stringContaining("Failed to send push notification"),
        expect.any(Error),
        expect.any(Object),
      );
    });
  });

  describe("フォロー状態の遷移確認", () => {
    it("should transition through all follow states correctly", async () => {
      const followRepo = createMockFollowRepository();
      const notifRepo = createMockNotificationRepository();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      const notificationAppService = createNotificationAppService(notifRepo);
      const followService = createFollowService(
        followRepo,
        notificationAppService,
        pushService,
        logger,
      );

      // NONE 状態
      vi.mocked(followRepo.findFollow).mockResolvedValue(null);
      vi.mocked(followRepo.findRequestBySenderAndReceiver).mockResolvedValue(
        null,
      );
      expect(await followService.getFollowStatus(1, 2)).toBe("NONE");

      // PENDING_SENT 状態（ユーザー1がユーザー2に送信）
      vi.mocked(followRepo.findFollow).mockResolvedValue(null);
      vi.mocked(followRepo.findRequestBySenderAndReceiver)
        .mockResolvedValueOnce(
          createMockFollowRequest({
            senderId: 1,
            receiverId: 2,
            status: "pending",
          }),
        )
        .mockResolvedValueOnce(null);
      expect(await followService.getFollowStatus(1, 2)).toBe("PENDING_SENT");

      // PENDING_RECEIVED 状態（ユーザー2がユーザー1に送信）
      vi.mocked(followRepo.findFollow).mockResolvedValue(null);
      vi.mocked(followRepo.findRequestBySenderAndReceiver).mockReset();
      vi.mocked(followRepo.findRequestBySenderAndReceiver)
        .mockResolvedValueOnce(null)
        .mockResolvedValueOnce(
          createMockFollowRequest({
            senderId: 2,
            receiverId: 1,
            status: "pending",
          }),
        );
      expect(await followService.getFollowStatus(1, 2)).toBe(
        "PENDING_RECEIVED",
      );

      // FOLLOWING 状態
      vi.mocked(followRepo.findFollow).mockResolvedValue(
        createMockFollow({ userIdA: 1, userIdB: 2 }),
      );
      expect(await followService.getFollowStatus(1, 2)).toBe("FOLLOWING");
    });
  });

  describe("フォロー数・フォロワー数の取得", () => {
    it("should return correct follow counts", async () => {
      const followRepo = createMockFollowRepository();
      const notifRepo = createMockNotificationRepository();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      const notificationAppService = createNotificationAppService(notifRepo);
      const followService = createFollowService(
        followRepo,
        notificationAppService,
        pushService,
        logger,
      );

      vi.mocked(followRepo.countFollowing).mockResolvedValue(5);
      vi.mocked(followRepo.countFollowers).mockResolvedValue(10);

      const counts = await followService.getFollowCounts(1);
      expect(counts.followingCount).toBe(5);
      expect(counts.followerCount).toBe(10);
    });
  });

  describe("通知サービスの一覧取得と既読管理", () => {
    it("should manage notification lifecycle: create → list → mark read → count", async () => {
      const notifRepo = createMockNotificationRepository();
      const notificationAppService = createNotificationAppService(notifRepo);

      // Step 1: 通知作成
      vi.mocked(notifRepo.create).mockResolvedValue(
        createMockNotification({
          id: 1,
          recipientId: 2,
          senderId: 1,
          type: "follow_request_received",
          isRead: false,
        }),
      );

      const createResult = await notificationAppService.createNotification({
        recipientId: 2,
        senderId: 1,
        type: "follow_request_received",
      });
      expect(createResult.success).toBe(true);

      // Step 2: 未読件数の確認
      vi.mocked(notifRepo.countUnreadByRecipient).mockResolvedValue(1);
      const unreadCount = await notificationAppService.getUnreadCount(2);
      expect(unreadCount).toBe(1);

      // Step 3: 通知一覧の取得
      const mockUser = {
        id: 1,
        email: "sender@example.com",
        firebaseUid: "uid-1",
        name: "Sender",
        avatarUrl: null,
        bio: null,
        instagramHandle: null,
        handle: "sender",
        createdAt: new Date(),
        updatedAt: new Date(),
      };
      vi.mocked(notifRepo.findByRecipient).mockResolvedValue([
        {
          notification: createMockNotification({ id: 1, isRead: false }),
          sender: mockUser,
        },
      ]);

      const notifications = await notificationAppService.getNotifications(
        2,
        null,
        20,
      );
      expect(notifications).toHaveLength(1);
      expect(notifications[0].notification.type).toBe(
        "follow_request_received",
      );

      // Step 4: 一括既読
      vi.mocked(notifRepo.markAsReadByRecipient).mockResolvedValue(undefined);
      await notificationAppService.markAllAsRead(2);
      expect(notifRepo.markAsReadByRecipient).toHaveBeenCalledWith(2);

      // Step 5: 既読後の未読件数
      vi.mocked(notifRepo.countUnreadByRecipient).mockResolvedValue(0);
      const unreadAfter = await notificationAppService.getUnreadCount(2);
      expect(unreadAfter).toBe(0);
    });
  });

  describe("バリデーションエラーの検証", () => {
    it("should prevent self-follow", async () => {
      const followRepo = createMockFollowRepository();
      const notifRepo = createMockNotificationRepository();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      const notificationAppService = createNotificationAppService(notifRepo);
      const followService = createFollowService(
        followRepo,
        notificationAppService,
        pushService,
        logger,
      );

      const result = await followService.sendRequest(1, 1);
      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("SELF_FOLLOW");
      }
    });

    it("should prevent duplicate follow request", async () => {
      const followRepo = createMockFollowRepository();
      const notifRepo = createMockNotificationRepository();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      const notificationAppService = createNotificationAppService(notifRepo);
      const followService = createFollowService(
        followRepo,
        notificationAppService,
        pushService,
        logger,
      );

      vi.mocked(followRepo.findFollow).mockResolvedValue(null);
      vi.mocked(followRepo.findRequestBySenderAndReceiver).mockResolvedValue(
        createMockFollowRequest({ status: "pending" }),
      );

      const result = await followService.sendRequest(1, 2);
      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("REQUEST_ALREADY_SENT");
      }
    });

    it("should prevent follow request to already-followed user", async () => {
      const followRepo = createMockFollowRepository();
      const notifRepo = createMockNotificationRepository();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      const notificationAppService = createNotificationAppService(notifRepo);
      const followService = createFollowService(
        followRepo,
        notificationAppService,
        pushService,
        logger,
      );

      vi.mocked(followRepo.findFollow).mockResolvedValue(createMockFollow());

      const result = await followService.sendRequest(1, 2);
      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("ALREADY_FOLLOWING");
      }
    });

    it("should prevent approving request not addressed to user", async () => {
      const followRepo = createMockFollowRepository();
      const notifRepo = createMockNotificationRepository();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      const notificationAppService = createNotificationAppService(notifRepo);
      const followService = createFollowService(
        followRepo,
        notificationAppService,
        pushService,
        logger,
      );

      vi.mocked(followRepo.findRequestById).mockResolvedValue(
        createMockFollowRequest({ receiverId: 2 }),
      );

      const result = await followService.approveRequest(1, 999);
      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("REQUEST_NOT_YOURS");
      }
    });

    it("should prevent approving already processed request", async () => {
      const followRepo = createMockFollowRepository();
      const notifRepo = createMockNotificationRepository();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      const notificationAppService = createNotificationAppService(notifRepo);
      const followService = createFollowService(
        followRepo,
        notificationAppService,
        pushService,
        logger,
      );

      vi.mocked(followRepo.findRequestById).mockResolvedValue(
        createMockFollowRequest({ receiverId: 2, status: "approved" }),
      );

      const result = await followService.approveRequest(1, 2);
      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("REQUEST_ALREADY_PROCESSED");
      }
    });

    it("should prevent unfollowing when not following", async () => {
      const followRepo = createMockFollowRepository();
      const notifRepo = createMockNotificationRepository();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      const notificationAppService = createNotificationAppService(notifRepo);
      const followService = createFollowService(
        followRepo,
        notificationAppService,
        pushService,
        logger,
      );

      vi.mocked(followRepo.findFollow).mockResolvedValue(null);

      const result = await followService.unfollow(1, 2);
      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("NOT_FOLLOWING");
      }
    });
  });
});
