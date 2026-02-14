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
  | "FOLLOWING"
  | "FOLLOWED_BY";

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
  getFollowStatus(
    userId: number,
    targetUserId: number,
  ): Promise<{ outgoing: FollowStatus; incoming: FollowStatus }>;
  getFollowCounts(
    userId: number,
  ): Promise<{ followingCount: number; followerCount: number }>;
  getFollowStatusBatch(
    userId: number,
    targetUserIds: number[],
  ): Promise<Map<number, { outgoing: FollowStatus; incoming: FollowStatus }>>;
  getFollowRequestIdBatch(
    recipientId: number,
    senderIds: number[],
  ): Promise<Map<number, number | null>>;
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
      if (existingRequest && existingRequest.status === "pending") {
        return err({
          code: "REQUEST_ALREADY_SENT",
          message: "Follow request already sent",
        });
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
          data: { type: "follow_request_received", route: "/notifications" },
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

      const existingRequest = await repository.findRequestBySenderAndReceiver(
        userId,
        targetUserId,
      );
      if (existingRequest) {
        await repository.deleteRequest(existingRequest.id);
      }

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
    ): Promise<{ outgoing: FollowStatus; incoming: FollowStatus }> {
      const outgoingFollow = await repository.findFollow(userId, targetUserId);
      const incomingFollow = await repository.findFollow(targetUserId, userId);

      let outgoing: FollowStatus = "NONE";
      if (outgoingFollow) {
        outgoing = "FOLLOWING";
      } else {
        const sentRequest = await repository.findRequestBySenderAndReceiver(
          userId,
          targetUserId,
        );
        if (sentRequest && sentRequest.status === "pending") {
          outgoing = "PENDING_SENT";
        }
      }

      let incoming: FollowStatus = "NONE";
      if (incomingFollow) {
        incoming = "FOLLOWING";
      } else {
        const receivedRequest = await repository.findRequestBySenderAndReceiver(
          targetUserId,
          userId,
        );
        if (receivedRequest && receivedRequest.status === "pending") {
          incoming = "PENDING_RECEIVED";
        }
      }

      return { outgoing, incoming };
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

    async getFollowStatusBatch(
      userId: number,
      targetUserIds: number[],
    ): Promise<
      Map<number, { outgoing: FollowStatus; incoming: FollowStatus }>
    > {
      const [followingSet, followersSet, pendingSentSet, pendingReceivedSet] =
        await Promise.all([
          repository.findFollowsBatch(userId, targetUserIds),
          repository.findFollowersBatch(userId, targetUserIds),
          repository.findPendingSentRequestsBatch(userId, targetUserIds),
          repository.findPendingReceivedRequestsBatch(userId, targetUserIds),
        ]);

      const result = new Map<
        number,
        { outgoing: FollowStatus; incoming: FollowStatus }
      >();
      for (const targetId of targetUserIds) {
        let outgoing: FollowStatus = "NONE";
        if (followingSet.has(targetId)) {
          outgoing = "FOLLOWING";
        } else if (pendingSentSet.has(targetId)) {
          outgoing = "PENDING_SENT";
        }

        let incoming: FollowStatus = "NONE";
        if (followersSet.has(targetId)) {
          incoming = "FOLLOWING";
        } else if (pendingReceivedSet.has(targetId)) {
          incoming = "PENDING_RECEIVED";
        }

        result.set(targetId, { outgoing, incoming });
      }
      return result;
    },

    async getFollowRequestIdBatch(
      recipientId: number,
      senderIds: number[],
    ): Promise<Map<number, number | null>> {
      const idMap = await repository.findPendingReceivedRequestIdsBatch(
        recipientId,
        senderIds,
      );

      const result = new Map<number, number | null>();
      for (const senderId of senderIds) {
        result.set(senderId, idMap.get(senderId) ?? null);
      }
      return result;
    },
  };
}
