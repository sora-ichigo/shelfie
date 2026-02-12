import type { FollowRequest } from "../../../db/schema/follow-requests.js";
import { err, ok, type Result } from "../../../errors/result.js";
import type { LoggerService } from "../../../logger/index.js";
import type { NotificationService } from "../../device-tokens/index.js";
import type { NotificationAppService } from "../../notifications/index.js";
import type { FollowRepository } from "./repository.js";

export type FollowStatus =
  | "NONE"
  | "PENDING_SENT"
  | "PENDING_RECEIVED"
  | "FOLLOWING";

export type FollowServiceErrors =
  | { code: "SELF_FOLLOW"; message: string }
  | { code: "ALREADY_FOLLOWING"; message: string }
  | { code: "REQUEST_ALREADY_SENT"; message: string }
  | { code: "REQUEST_NOT_FOUND"; message: string }
  | { code: "REQUEST_NOT_YOURS"; message: string }
  | { code: "REQUEST_ALREADY_PROCESSED"; message: string }
  | { code: "NOT_FOLLOWING"; message: string }
  | { code: "USER_NOT_FOUND"; message: string };

export interface FollowService {
  sendRequest(
    senderId: number,
    receiverId: number,
  ): Promise<Result<FollowRequest, FollowServiceErrors>>;
  approveRequest(
    requestId: number,
    userId: number,
  ): Promise<Result<FollowRequest, FollowServiceErrors>>;
  rejectRequest(
    requestId: number,
    userId: number,
  ): Promise<Result<FollowRequest, FollowServiceErrors>>;
  unfollow(
    userId: number,
    targetUserId: number,
  ): Promise<Result<void, FollowServiceErrors>>;
  cancelFollowRequest(
    senderId: number,
    receiverId: number,
  ): Promise<Result<void, FollowServiceErrors>>;
  getFollowStatus(userId: number, targetUserId: number): Promise<FollowStatus>;
  getFollowCounts(
    userId: number,
  ): Promise<{ followingCount: number; followerCount: number }>;
}

export function createFollowService(
  repository: FollowRepository,
  notificationAppService: NotificationAppService,
  pushNotificationService: NotificationService,
  logger: LoggerService,
): FollowService {
  function validateRequest(
    request: FollowRequest | null,
    userId: number,
  ): Result<FollowRequest, FollowServiceErrors> {
    if (!request) {
      return err({
        code: "REQUEST_NOT_FOUND",
        message: "Follow request not found",
      });
    }
    if (request.receiverId !== userId) {
      return err({
        code: "REQUEST_NOT_YOURS",
        message: "This follow request is not addressed to you",
      });
    }
    if (request.status !== "pending") {
      return err({
        code: "REQUEST_ALREADY_PROCESSED",
        message: "This follow request has already been processed",
      });
    }
    return ok(request);
  }

  return {
    async sendRequest(
      senderId: number,
      receiverId: number,
    ): Promise<Result<FollowRequest, FollowServiceErrors>> {
      if (senderId === receiverId) {
        return err({
          code: "SELF_FOLLOW",
          message: "Cannot send a follow request to yourself",
        });
      }

      const existingFollow = await repository.findFollow(senderId, receiverId);
      if (existingFollow) {
        return err({
          code: "ALREADY_FOLLOWING",
          message: "Already following this user",
        });
      }

      const existingRequest = await repository.findRequestBySenderAndReceiver(
        senderId,
        receiverId,
      );
      if (existingRequest) {
        if (existingRequest.status === "pending") {
          return err({
            code: "REQUEST_ALREADY_SENT",
            message: "Follow request already sent",
          });
        }
        await repository.deleteRequest(existingRequest.id);
      }

      const request = await repository.createRequest({
        senderId,
        receiverId,
      });

      notificationAppService
        .createNotification({
          recipientId: receiverId,
          senderId,
          type: "follow_request_received",
        })
        .catch((error) => {
          logger.error(
            "Failed to create app notification for follow request",
            error instanceof Error ? error : undefined,
            { senderId: String(senderId), receiverId: String(receiverId) },
          );
        });

      pushNotificationService
        .sendNotification({
          title: "フォローリクエスト",
          body: "新しいフォローリクエストが届きました",
          userIds: [receiverId],
          data: { type: "follow_request_received" },
        })
        .catch((error) => {
          logger.error(
            "Failed to send push notification for follow request",
            error instanceof Error ? error : undefined,
            { senderId: String(senderId), receiverId: String(receiverId) },
          );
        });

      return ok(request);
    },

    async approveRequest(
      requestId: number,
      userId: number,
    ): Promise<Result<FollowRequest, FollowServiceErrors>> {
      const request = await repository.findRequestById(requestId);
      const validation = validateRequest(request, userId);
      if (!validation.success) {
        return validation;
      }

      const updatedRequest = await repository.updateRequestStatus(
        requestId,
        "approved",
      );
      await repository.createFollow(
        validation.data.senderId,
        validation.data.receiverId,
      );

      notificationAppService
        .createNotification({
          recipientId: validation.data.senderId,
          senderId: userId,
          type: "follow_request_approved",
        })
        .catch((error) => {
          logger.error(
            "Failed to create app notification for follow approval",
            error instanceof Error ? error : undefined,
            { requestId: String(requestId), userId: String(userId) },
          );
        });

      return ok(updatedRequest);
    },

    async rejectRequest(
      requestId: number,
      userId: number,
    ): Promise<Result<FollowRequest, FollowServiceErrors>> {
      const request = await repository.findRequestById(requestId);
      const validation = validateRequest(request, userId);
      if (!validation.success) {
        return validation;
      }

      const updatedRequest = await repository.updateRequestStatus(
        requestId,
        "rejected",
      );
      return ok(updatedRequest);
    },

    async unfollow(
      userId: number,
      targetUserId: number,
    ): Promise<Result<void, FollowServiceErrors>> {
      const existingFollow = await repository.findFollow(userId, targetUserId);
      if (!existingFollow) {
        return err({
          code: "NOT_FOLLOWING",
          message: "Not following this user",
        });
      }

      await repository.deleteFollow(userId, targetUserId);
      return ok(undefined);
    },

    async cancelFollowRequest(
      senderId: number,
      receiverId: number,
    ): Promise<Result<void, FollowServiceErrors>> {
      const request = await repository.findRequestBySenderAndReceiver(
        senderId,
        receiverId,
      );
      if (!request) {
        return err({
          code: "REQUEST_NOT_FOUND",
          message: "Follow request not found",
        });
      }
      if (request.status !== "pending") {
        return err({
          code: "REQUEST_ALREADY_PROCESSED",
          message: "Follow request has already been processed",
        });
      }

      await repository.deleteRequest(request.id);

      notificationAppService
        .deleteNotification({
          senderId,
          recipientId: receiverId,
          type: "follow_request_received",
        })
        .catch((error) => {
          logger.error(
            "Failed to delete app notification for cancelled follow request",
            error instanceof Error ? error : undefined,
            { senderId: String(senderId), receiverId: String(receiverId) },
          );
        });

      return ok(undefined);
    },

    async getFollowStatus(
      userId: number,
      targetUserId: number,
    ): Promise<FollowStatus> {
      const existingFollow = await repository.findFollow(userId, targetUserId);
      if (existingFollow) {
        return "FOLLOWING";
      }

      const sentRequest = await repository.findRequestBySenderAndReceiver(
        userId,
        targetUserId,
      );
      if (sentRequest && sentRequest.status === "pending") {
        return "PENDING_SENT";
      }

      const receivedRequest = await repository.findRequestBySenderAndReceiver(
        targetUserId,
        userId,
      );
      if (receivedRequest && receivedRequest.status === "pending") {
        return "PENDING_RECEIVED";
      }

      return "NONE";
    },

    async getFollowCounts(
      userId: number,
    ): Promise<{ followingCount: number; followerCount: number }> {
      const [followingCount, followerCount] = await Promise.all([
        repository.countFollowing(userId),
        repository.countFollowers(userId),
      ]);
      return { followingCount, followerCount };
    },
  };
}
