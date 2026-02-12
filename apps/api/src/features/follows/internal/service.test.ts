import { describe, expect, it, vi } from "vitest";
import type { FollowRequest } from "../../../db/schema/follow-requests.js";
import type { Follow } from "../../../db/schema/follows.js";
import type { AppNotification } from "../../../db/schema/notifications.js";
import type { LoggerService } from "../../../logger/index.js";
import type { NotificationService } from "../../device-tokens/index.js";
import type { NotificationAppService } from "../../notifications/index.js";
import type { FollowRepository } from "./repository.js";
import { createFollowService } from "./service.js";

function createMockFollowRepository(): FollowRepository {
  return {
    createRequest: vi.fn(),
    findRequestById: vi.fn(),
    findRequestBySenderAndReceiver: vi.fn(),
    findPendingRequestsByReceiver: vi.fn(),
    countPendingRequestsByReceiver: vi.fn(),
    updateRequestStatus: vi.fn(),
    deleteRequest: vi.fn(),
    createFollow: vi.fn(),
    deleteFollow: vi.fn(),
    findFollow: vi.fn(),
    findFollowing: vi.fn(),
    findFollowers: vi.fn(),
    countFollowing: vi.fn(),
    countFollowers: vi.fn(),
  };
}

function createMockNotificationAppService(): NotificationAppService {
  return {
    createNotification: vi.fn().mockResolvedValue({
      success: true,
      data: {
        id: 1,
        recipientId: 1,
        senderId: 1,
        type: "follow_request_received",
        isRead: false,
        createdAt: new Date(),
      } satisfies AppNotification,
    }),
    getNotifications: vi.fn(),
    getUnreadCount: vi.fn(),
    markAllAsRead: vi.fn(),
    deleteNotification: vi.fn().mockResolvedValue(undefined),
  };
}

function createMockPushNotificationService(): NotificationService {
  return {
    sendNotification: vi.fn().mockResolvedValue({
      success: true,
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

function _createMockTransactionDb(): unknown {
  return {};
}

const now = new Date();

function createMockFollowRequest(
  overrides: Partial<FollowRequest> = {},
): FollowRequest {
  return {
    id: 1,
    senderId: 1,
    receiverId: 2,
    status: "pending",
    createdAt: now,
    updatedAt: now,
    ...overrides,
  };
}

function createMockFollow(overrides: Partial<Follow> = {}): Follow {
  return {
    id: 1,
    userIdA: 1,
    userIdB: 2,
    createdAt: now,
    ...overrides,
  };
}

describe("FollowService", () => {
  describe("sendRequest", () => {
    it("should create follow request successfully", async () => {
      const repo = createMockFollowRepository();
      const notifService = createMockNotificationAppService();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();
      const mockRequest = createMockFollowRequest();

      vi.mocked(repo.findFollow).mockResolvedValue(null);
      vi.mocked(repo.findRequestBySenderAndReceiver).mockResolvedValue(null);
      vi.mocked(repo.createRequest).mockResolvedValue(mockRequest);

      const service = createFollowService(
        repo,
        notifService,
        pushService,
        logger,
      );
      const result = await service.sendRequest(1, 2);

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.senderId).toBe(1);
        expect(result.data.receiverId).toBe(2);
        expect(result.data.status).toBe("pending");
      }
    });

    it("should create app notification on success", async () => {
      const repo = createMockFollowRepository();
      const notifService = createMockNotificationAppService();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();
      const mockRequest = createMockFollowRequest();

      vi.mocked(repo.findFollow).mockResolvedValue(null);
      vi.mocked(repo.findRequestBySenderAndReceiver).mockResolvedValue(null);
      vi.mocked(repo.createRequest).mockResolvedValue(mockRequest);

      const service = createFollowService(
        repo,
        notifService,
        pushService,
        logger,
      );
      await service.sendRequest(1, 2);

      expect(notifService.createNotification).toHaveBeenCalledWith({
        recipientId: 2,
        senderId: 1,
        type: "follow_request_received",
      });
    });

    it("should send push notification on success", async () => {
      const repo = createMockFollowRepository();
      const notifService = createMockNotificationAppService();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();
      const mockRequest = createMockFollowRequest();

      vi.mocked(repo.findFollow).mockResolvedValue(null);
      vi.mocked(repo.findRequestBySenderAndReceiver).mockResolvedValue(null);
      vi.mocked(repo.createRequest).mockResolvedValue(mockRequest);

      const service = createFollowService(
        repo,
        notifService,
        pushService,
        logger,
      );
      await service.sendRequest(1, 2);

      expect(pushService.sendNotification).toHaveBeenCalledWith(
        expect.objectContaining({
          userIds: [2],
        }),
      );
    });

    it("should return error for self-follow", async () => {
      const repo = createMockFollowRepository();
      const notifService = createMockNotificationAppService();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      const service = createFollowService(
        repo,
        notifService,
        pushService,
        logger,
      );
      const result = await service.sendRequest(1, 1);

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("SELF_FOLLOW");
      }
    });

    it("should return error when already following", async () => {
      const repo = createMockFollowRepository();
      const notifService = createMockNotificationAppService();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      vi.mocked(repo.findFollow).mockResolvedValue(createMockFollow());

      const service = createFollowService(
        repo,
        notifService,
        pushService,
        logger,
      );
      const result = await service.sendRequest(1, 2);

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("ALREADY_FOLLOWING");
      }
    });

    it("should delete old approved request and create new one", async () => {
      const repo = createMockFollowRepository();
      const notifService = createMockNotificationAppService();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();
      const oldRequest = createMockFollowRequest({
        id: 10,
        senderId: 1,
        receiverId: 2,
        status: "approved",
      });
      const newRequest = createMockFollowRequest({
        id: 11,
        senderId: 1,
        receiverId: 2,
        status: "pending",
      });

      vi.mocked(repo.findFollow).mockResolvedValue(null);
      vi.mocked(repo.findRequestBySenderAndReceiver).mockResolvedValue(
        oldRequest,
      );
      vi.mocked(repo.createRequest).mockResolvedValue(newRequest);

      const service = createFollowService(
        repo,
        notifService,
        pushService,
        logger,
      );
      const result = await service.sendRequest(1, 2);

      expect(result.success).toBe(true);
      expect(repo.deleteRequest).toHaveBeenCalledWith(10);
      expect(repo.createRequest).toHaveBeenCalled();
    });

    it("should delete old rejected request and create new one", async () => {
      const repo = createMockFollowRepository();
      const notifService = createMockNotificationAppService();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();
      const oldRequest = createMockFollowRequest({
        id: 10,
        senderId: 1,
        receiverId: 2,
        status: "rejected",
      });
      const newRequest = createMockFollowRequest({
        id: 11,
        senderId: 1,
        receiverId: 2,
        status: "pending",
      });

      vi.mocked(repo.findFollow).mockResolvedValue(null);
      vi.mocked(repo.findRequestBySenderAndReceiver).mockResolvedValue(
        oldRequest,
      );
      vi.mocked(repo.createRequest).mockResolvedValue(newRequest);

      const service = createFollowService(
        repo,
        notifService,
        pushService,
        logger,
      );
      const result = await service.sendRequest(1, 2);

      expect(result.success).toBe(true);
      expect(repo.deleteRequest).toHaveBeenCalledWith(10);
      expect(repo.createRequest).toHaveBeenCalled();
    });

    it("should return error when pending request already exists", async () => {
      const repo = createMockFollowRepository();
      const notifService = createMockNotificationAppService();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      vi.mocked(repo.findFollow).mockResolvedValue(null);
      vi.mocked(repo.findRequestBySenderAndReceiver).mockResolvedValue(
        createMockFollowRequest({ status: "pending" }),
      );

      const service = createFollowService(
        repo,
        notifService,
        pushService,
        logger,
      );
      const result = await service.sendRequest(1, 2);

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("REQUEST_ALREADY_SENT");
      }
    });

    it("should not fail request creation when push notification fails", async () => {
      const repo = createMockFollowRepository();
      const notifService = createMockNotificationAppService();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();
      const mockRequest = createMockFollowRequest();

      vi.mocked(repo.findFollow).mockResolvedValue(null);
      vi.mocked(repo.findRequestBySenderAndReceiver).mockResolvedValue(null);
      vi.mocked(repo.createRequest).mockResolvedValue(mockRequest);
      vi.mocked(pushService.sendNotification).mockRejectedValue(
        new Error("FCM error"),
      );

      const service = createFollowService(
        repo,
        notifService,
        pushService,
        logger,
      );
      const result = await service.sendRequest(1, 2);

      expect(result.success).toBe(true);
      expect(logger.error).toHaveBeenCalled();
    });
  });

  describe("approveRequest", () => {
    it("should approve request and create follow relationship", async () => {
      const repo = createMockFollowRepository();
      const notifService = createMockNotificationAppService();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();
      const pendingRequest = createMockFollowRequest({
        id: 1,
        senderId: 3,
        receiverId: 2,
        status: "pending",
      });
      const approvedRequest = {
        ...pendingRequest,
        status: "approved",
      };

      vi.mocked(repo.findRequestById).mockResolvedValue(pendingRequest);
      vi.mocked(repo.updateRequestStatus).mockResolvedValue(approvedRequest);
      vi.mocked(repo.createFollow).mockResolvedValue(
        createMockFollow({ userIdA: 2, userIdB: 3 }),
      );

      const service = createFollowService(
        repo,
        notifService,
        pushService,
        logger,
      );
      const result = await service.approveRequest(1, 2);

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.status).toBe("approved");
      }
      expect(repo.createFollow).toHaveBeenCalledWith(3, 2);
    });

    it("should create notification for sender on approval", async () => {
      const repo = createMockFollowRepository();
      const notifService = createMockNotificationAppService();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();
      const pendingRequest = createMockFollowRequest({
        senderId: 3,
        receiverId: 2,
        status: "pending",
      });

      vi.mocked(repo.findRequestById).mockResolvedValue(pendingRequest);
      vi.mocked(repo.updateRequestStatus).mockResolvedValue({
        ...pendingRequest,
        status: "approved",
      });
      vi.mocked(repo.createFollow).mockResolvedValue(createMockFollow());

      const service = createFollowService(
        repo,
        notifService,
        pushService,
        logger,
      );
      await service.approveRequest(1, 2);

      expect(notifService.createNotification).toHaveBeenCalledWith({
        recipientId: 3,
        senderId: 2,
        type: "follow_request_approved",
      });
    });

    it("should return error when request not found", async () => {
      const repo = createMockFollowRepository();
      const notifService = createMockNotificationAppService();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      vi.mocked(repo.findRequestById).mockResolvedValue(null);

      const service = createFollowService(
        repo,
        notifService,
        pushService,
        logger,
      );
      const result = await service.approveRequest(999, 2);

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("REQUEST_NOT_FOUND");
      }
    });

    it("should return error when request is not yours", async () => {
      const repo = createMockFollowRepository();
      const notifService = createMockNotificationAppService();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      vi.mocked(repo.findRequestById).mockResolvedValue(
        createMockFollowRequest({ receiverId: 5 }),
      );

      const service = createFollowService(
        repo,
        notifService,
        pushService,
        logger,
      );
      const result = await service.approveRequest(1, 2);

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("REQUEST_NOT_YOURS");
      }
    });

    it("should return error when request is already processed", async () => {
      const repo = createMockFollowRepository();
      const notifService = createMockNotificationAppService();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      vi.mocked(repo.findRequestById).mockResolvedValue(
        createMockFollowRequest({ status: "approved" }),
      );

      const service = createFollowService(
        repo,
        notifService,
        pushService,
        logger,
      );
      const result = await service.approveRequest(1, 2);

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("REQUEST_ALREADY_PROCESSED");
      }
    });
  });

  describe("rejectRequest", () => {
    it("should reject request successfully", async () => {
      const repo = createMockFollowRepository();
      const notifService = createMockNotificationAppService();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();
      const pendingRequest = createMockFollowRequest({
        receiverId: 2,
        status: "pending",
      });
      const rejectedRequest = { ...pendingRequest, status: "rejected" };

      vi.mocked(repo.findRequestById).mockResolvedValue(pendingRequest);
      vi.mocked(repo.updateRequestStatus).mockResolvedValue(rejectedRequest);

      const service = createFollowService(
        repo,
        notifService,
        pushService,
        logger,
      );
      const result = await service.rejectRequest(1, 2);

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.status).toBe("rejected");
      }
    });

    it("should return error when request not found", async () => {
      const repo = createMockFollowRepository();
      const notifService = createMockNotificationAppService();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      vi.mocked(repo.findRequestById).mockResolvedValue(null);

      const service = createFollowService(
        repo,
        notifService,
        pushService,
        logger,
      );
      const result = await service.rejectRequest(999, 2);

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("REQUEST_NOT_FOUND");
      }
    });

    it("should return error when request is not yours", async () => {
      const repo = createMockFollowRepository();
      const notifService = createMockNotificationAppService();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      vi.mocked(repo.findRequestById).mockResolvedValue(
        createMockFollowRequest({ receiverId: 5 }),
      );

      const service = createFollowService(
        repo,
        notifService,
        pushService,
        logger,
      );
      const result = await service.rejectRequest(1, 2);

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("REQUEST_NOT_YOURS");
      }
    });

    it("should return error when request is already processed", async () => {
      const repo = createMockFollowRepository();
      const notifService = createMockNotificationAppService();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      vi.mocked(repo.findRequestById).mockResolvedValue(
        createMockFollowRequest({ status: "rejected" }),
      );

      const service = createFollowService(
        repo,
        notifService,
        pushService,
        logger,
      );
      const result = await service.rejectRequest(1, 2);

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("REQUEST_ALREADY_PROCESSED");
      }
    });
  });

  describe("unfollow", () => {
    it("should unfollow successfully", async () => {
      const repo = createMockFollowRepository();
      const notifService = createMockNotificationAppService();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      vi.mocked(repo.findFollow).mockResolvedValue(createMockFollow());
      vi.mocked(repo.deleteFollow).mockResolvedValue(undefined);

      const service = createFollowService(
        repo,
        notifService,
        pushService,
        logger,
      );
      const result = await service.unfollow(1, 2);

      expect(result.success).toBe(true);
      expect(repo.deleteFollow).toHaveBeenCalledWith(1, 2);
    });

    it("should return error when not following", async () => {
      const repo = createMockFollowRepository();
      const notifService = createMockNotificationAppService();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      vi.mocked(repo.findFollow).mockResolvedValue(null);

      const service = createFollowService(
        repo,
        notifService,
        pushService,
        logger,
      );
      const result = await service.unfollow(1, 2);

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("NOT_FOLLOWING");
      }
    });
  });

  describe("cancelFollowRequest", () => {
    it("should cancel pending follow request successfully", async () => {
      const repo = createMockFollowRepository();
      const notifService = createMockNotificationAppService();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();
      const pendingRequest = createMockFollowRequest({
        id: 5,
        senderId: 1,
        receiverId: 2,
        status: "pending",
      });

      vi.mocked(repo.findRequestBySenderAndReceiver).mockResolvedValue(
        pendingRequest,
      );
      vi.mocked(repo.updateRequestStatus).mockResolvedValue({
        ...pendingRequest,
        status: "rejected",
      });

      const service = createFollowService(
        repo,
        notifService,
        pushService,
        logger,
      );
      const result = await service.cancelFollowRequest(1, 2);

      expect(result.success).toBe(true);
      expect(repo.deleteRequest).toHaveBeenCalledWith(5);
    });

    it("should return error when no pending request exists", async () => {
      const repo = createMockFollowRepository();
      const notifService = createMockNotificationAppService();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      vi.mocked(repo.findRequestBySenderAndReceiver).mockResolvedValue(null);

      const service = createFollowService(
        repo,
        notifService,
        pushService,
        logger,
      );
      const result = await service.cancelFollowRequest(1, 2);

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("REQUEST_NOT_FOUND");
      }
    });

    it("should return error when request is already processed", async () => {
      const repo = createMockFollowRepository();
      const notifService = createMockNotificationAppService();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      vi.mocked(repo.findRequestBySenderAndReceiver).mockResolvedValue(
        createMockFollowRequest({
          senderId: 1,
          receiverId: 2,
          status: "approved",
        }),
      );

      const service = createFollowService(
        repo,
        notifService,
        pushService,
        logger,
      );
      const result = await service.cancelFollowRequest(1, 2);

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("REQUEST_ALREADY_PROCESSED");
      }
    });

    it("should delete follow_request_received notification on cancel", async () => {
      const repo = createMockFollowRepository();
      const notifService = createMockNotificationAppService();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();
      const pendingRequest = createMockFollowRequest({
        id: 5,
        senderId: 1,
        receiverId: 2,
        status: "pending",
      });

      vi.mocked(repo.findRequestBySenderAndReceiver).mockResolvedValue(
        pendingRequest,
      );

      const service = createFollowService(
        repo,
        notifService,
        pushService,
        logger,
      );
      await service.cancelFollowRequest(1, 2);

      expect(notifService.deleteNotification).toHaveBeenCalledWith({
        senderId: 1,
        recipientId: 2,
        type: "follow_request_received",
      });
    });

    it("should not fail cancel when notification deletion fails", async () => {
      const repo = createMockFollowRepository();
      const notifService = createMockNotificationAppService();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();
      const pendingRequest = createMockFollowRequest({
        id: 5,
        senderId: 1,
        receiverId: 2,
        status: "pending",
      });

      vi.mocked(repo.findRequestBySenderAndReceiver).mockResolvedValue(
        pendingRequest,
      );
      vi.mocked(notifService.deleteNotification).mockRejectedValue(
        new Error("DB error"),
      );

      const service = createFollowService(
        repo,
        notifService,
        pushService,
        logger,
      );
      const result = await service.cancelFollowRequest(1, 2);

      expect(result.success).toBe(true);
      expect(logger.error).toHaveBeenCalled();
    });
  });

  describe("getFollowStatus", () => {
    it("should return FOLLOWING when follow exists", async () => {
      const repo = createMockFollowRepository();
      const notifService = createMockNotificationAppService();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      vi.mocked(repo.findFollow).mockResolvedValue(createMockFollow());

      const service = createFollowService(
        repo,
        notifService,
        pushService,
        logger,
      );
      const result = await service.getFollowStatus(1, 2);

      expect(result).toBe("FOLLOWING");
    });

    it("should return PENDING_SENT when sent request exists", async () => {
      const repo = createMockFollowRepository();
      const notifService = createMockNotificationAppService();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      vi.mocked(repo.findFollow).mockResolvedValue(null);
      vi.mocked(repo.findRequestBySenderAndReceiver)
        .mockResolvedValueOnce(
          createMockFollowRequest({
            senderId: 1,
            receiverId: 2,
            status: "pending",
          }),
        )
        .mockResolvedValueOnce(null);

      const service = createFollowService(
        repo,
        notifService,
        pushService,
        logger,
      );
      const result = await service.getFollowStatus(1, 2);

      expect(result).toBe("PENDING_SENT");
    });

    it("should return PENDING_RECEIVED when received request exists", async () => {
      const repo = createMockFollowRepository();
      const notifService = createMockNotificationAppService();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      vi.mocked(repo.findFollow).mockResolvedValue(null);
      vi.mocked(repo.findRequestBySenderAndReceiver)
        .mockResolvedValueOnce(null)
        .mockResolvedValueOnce(
          createMockFollowRequest({
            senderId: 2,
            receiverId: 1,
            status: "pending",
          }),
        );

      const service = createFollowService(
        repo,
        notifService,
        pushService,
        logger,
      );
      const result = await service.getFollowStatus(1, 2);

      expect(result).toBe("PENDING_RECEIVED");
    });

    it("should return NONE when no relationship exists", async () => {
      const repo = createMockFollowRepository();
      const notifService = createMockNotificationAppService();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      vi.mocked(repo.findFollow).mockResolvedValue(null);
      vi.mocked(repo.findRequestBySenderAndReceiver).mockResolvedValue(null);

      const service = createFollowService(
        repo,
        notifService,
        pushService,
        logger,
      );
      const result = await service.getFollowStatus(1, 2);

      expect(result).toBe("NONE");
    });
  });

  describe("getFollowCounts", () => {
    it("should return follow and follower counts", async () => {
      const repo = createMockFollowRepository();
      const notifService = createMockNotificationAppService();
      const pushService = createMockPushNotificationService();
      const logger = createMockLogger();

      vi.mocked(repo.countFollowing).mockResolvedValue(10);
      vi.mocked(repo.countFollowers).mockResolvedValue(5);

      const service = createFollowService(
        repo,
        notifService,
        pushService,
        logger,
      );
      const result = await service.getFollowCounts(1);

      expect(result).toEqual({ followingCount: 10, followerCount: 5 });
    });
  });
});
