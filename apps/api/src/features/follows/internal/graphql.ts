import type { FollowRequest } from "../../../db/schema/follow-requests.js";
import type { User } from "../../../db/schema/users.js";
import type { Builder } from "../../../graphql/builder.js";
import { UserRef, ValidationError } from "../../users/internal/graphql.js";
import type { UserService } from "../../users/internal/service.js";
import type { FollowRepository } from "./repository.js";
import type { FollowService, FollowStatus } from "./service.js";

interface FollowCountsData {
  followingCount: number;
  followerCount: number;
}

interface UserProfileData {
  user: User;
  outgoingFollowStatus: FollowStatus;
  incomingFollowStatus: FollowStatus;
  followCounts: FollowCountsData;
  isOwnProfile: boolean;
}

type FollowRequestStatusEnumRef = ReturnType<
  typeof createFollowRequestStatusEnumRef
>;
type FollowStatusEnumRef = ReturnType<typeof createFollowStatusEnumRef>;
type FollowRequestObjectRef = ReturnType<typeof createFollowRequestRef>;
type FollowCountsObjectRef = ReturnType<typeof createFollowCountsRef>;
type UserProfileObjectRef = ReturnType<typeof createUserProfileRef>;

function createFollowRequestStatusEnumRef(builder: Builder) {
  return builder.enumType("FollowRequestStatus", {
    values: ["PENDING", "APPROVED", "REJECTED"] as const,
  });
}

function createFollowStatusEnumRef(builder: Builder) {
  return builder.enumType("FollowStatus", {
    values: [
      "NONE",
      "PENDING",
      "PENDING_SENT",
      "PENDING_RECEIVED",
      "FOLLOWING",
      "FOLLOWED_BY",
    ] as const,
  });
}

function createFollowRequestRef(builder: Builder) {
  return builder.objectRef<FollowRequest>("FollowRequest");
}

function createFollowCountsRef(builder: Builder) {
  return builder.objectRef<FollowCountsData>("FollowCounts");
}

function createUserProfileRef(builder: Builder) {
  return builder.objectRef<UserProfileData>("UserProfile");
}

let FollowRequestStatusRef: FollowRequestStatusEnumRef;
export let FollowStatusRef: FollowStatusEnumRef;
let FollowRequestRef: FollowRequestObjectRef;
let FollowCountsRef: FollowCountsObjectRef;
let UserProfileRef: UserProfileObjectRef;

export function registerFollowTypes(builder: Builder): void {
  FollowRequestStatusRef = createFollowRequestStatusEnumRef(builder);
  FollowStatusRef = createFollowStatusEnumRef(builder);

  FollowRequestRef = createFollowRequestRef(builder);
  FollowRequestRef.implement({
    fields: (t) => ({
      id: t.exposeInt("id"),
      senderId: t.exposeInt("senderId"),
      receiverId: t.exposeInt("receiverId"),
      status: t.field({
        type: FollowRequestStatusRef,
        resolve: (parent) =>
          parent.status.toUpperCase() as "PENDING" | "APPROVED" | "REJECTED",
      }),
      createdAt: t.expose("createdAt", { type: "DateTime" }),
    }),
  });

  FollowCountsRef = createFollowCountsRef(builder);
  FollowCountsRef.implement({
    fields: (t) => ({
      followingCount: t.exposeInt("followingCount"),
      followerCount: t.exposeInt("followerCount"),
    }),
  });

  UserProfileRef = createUserProfileRef(builder);
  UserProfileRef.implement({
    fields: (t) => ({
      user: t.field({
        type: UserRef,
        resolve: (parent) => parent.user,
      }),
      outgoingFollowStatus: t.field({
        type: FollowStatusRef,
        resolve: (parent) => parent.outgoingFollowStatus,
      }),
      incomingFollowStatus: t.field({
        type: FollowStatusRef,
        resolve: (parent) => parent.incomingFollowStatus,
      }),
      followCounts: t.field({
        type: FollowCountsRef,
        resolve: (parent) => parent.followCounts,
      }),
      isOwnProfile: t.exposeBoolean("isOwnProfile"),
    }),
  });
}

export function registerFollowQueries(
  builder: Builder,
  followService: FollowService,
  followRepository?: FollowRepository,
  userService?: UserService,
): void {
  builder.queryFields((t) => ({
    pendingFollowRequests: t.field({
      type: [FollowRequestRef],
      authScopes: { loggedIn: true },
      args: {
        cursor: t.arg.int({ required: false }),
        limit: t.arg.int({ required: false, defaultValue: 20 }),
      },
      resolve: async (_parent, { cursor, limit }, context) => {
        if (!context.user || !userService) {
          throw new Error("Authentication required");
        }
        const userResult = await userService.getUserByFirebaseUid(
          context.user.uid,
        );
        if (!userResult.success) throw new Error("User not found");

        if (!followRepository) throw new Error("Repository not available");
        return followRepository.findPendingRequestsByReceiver(
          userResult.data.id,
          cursor ?? null,
          limit ?? 20,
        );
      },
    }),

    pendingFollowRequestCount: t.int({
      authScopes: { loggedIn: true },
      resolve: async (_parent, _args, context) => {
        if (!context.user || !userService) {
          throw new Error("Authentication required");
        }
        const userResult = await userService.getUserByFirebaseUid(
          context.user.uid,
        );
        if (!userResult.success) throw new Error("User not found");

        if (!followRepository) throw new Error("Repository not available");
        return followRepository.countPendingRequestsByReceiver(
          userResult.data.id,
        );
      },
    }),

    following: t.field({
      type: [UserRef],
      authScopes: { loggedIn: true },
      args: {
        userId: t.arg.int({ required: true }),
        cursor: t.arg.int({ required: false }),
        limit: t.arg.int({ required: false, defaultValue: 20 }),
      },
      resolve: async (_parent, { userId, cursor, limit }) => {
        if (!followRepository) throw new Error("Repository not available");
        const results = await followRepository.findFollowing(
          userId,
          cursor ?? null,
          limit ?? 20,
        );
        return results.map((r) => r.user);
      },
    }),

    followers: t.field({
      type: [UserRef],
      authScopes: { loggedIn: true },
      args: {
        userId: t.arg.int({ required: true }),
        cursor: t.arg.int({ required: false }),
        limit: t.arg.int({ required: false, defaultValue: 20 }),
      },
      resolve: async (_parent, { userId, cursor, limit }) => {
        if (!followRepository) throw new Error("Repository not available");
        const results = await followRepository.findFollowers(
          userId,
          cursor ?? null,
          limit ?? 20,
        );
        return results.map((r) => r.user);
      },
    }),

    followCounts: t.field({
      type: FollowCountsRef,
      authScopes: { loggedIn: true },
      args: {
        userId: t.arg.int({ required: true }),
      },
      resolve: async (_parent, { userId }) => {
        return followService.getFollowCounts(userId);
      },
    }),

    userProfile: t.field({
      type: UserProfileRef,
      nullable: true,
      authScopes: { loggedIn: true },
      args: {
        handle: t.arg.string({ required: true }),
      },
      resolve: async (_parent, { handle }, context) => {
        if (!context.user || !userService) {
          throw new Error("Authentication required");
        }
        const currentUserResult = await userService.getUserByFirebaseUid(
          context.user.uid,
        );
        if (!currentUserResult.success) throw new Error("User not found");

        const usersResult = await userService.getUsers();
        if (!usersResult.success) return null;

        const targetUser = usersResult.data.find((u) => u.handle === handle);
        if (!targetUser) return null;

        const isOwnProfile = currentUserResult.data.id === targetUser.id;
        const { outgoing, incoming } = isOwnProfile
          ? { outgoing: "NONE" as const, incoming: "NONE" as const }
          : await followService.getFollowStatus(
              currentUserResult.data.id,
              targetUser.id,
            );
        const followCounts = await followService.getFollowCounts(targetUser.id);

        return {
          user: targetUser,
          outgoingFollowStatus: outgoing,
          incomingFollowStatus: incoming,
          followCounts,
          isOwnProfile,
        };
      },
    }),
  }));
}

export function registerFollowMutations(
  builder: Builder,
  followService: FollowService,
  userService?: UserService,
): void {
  builder.mutationFields((t) => ({
    sendFollowRequest: t.field({
      type: FollowRequestRef,
      errors: { types: [ValidationError] },
      authScopes: { loggedIn: true },
      args: {
        receiverId: t.arg.int({ required: true }),
      },
      resolve: async (_parent, { receiverId }, context) => {
        if (!context.user || !userService) {
          throw new ValidationError("認証が必要です");
        }
        const userResult = await userService.getUserByFirebaseUid(
          context.user.uid,
        );
        if (!userResult.success) {
          throw new ValidationError("ユーザーが見つかりません");
        }

        const result = await followService.sendRequest(
          userResult.data.id,
          receiverId,
        );
        if (!result.success) {
          throw new ValidationError(result.error.message);
        }
        return result.data;
      },
    }),

    approveFollowRequest: t.field({
      type: FollowRequestRef,
      errors: { types: [ValidationError] },
      authScopes: { loggedIn: true },
      args: {
        requestId: t.arg.int({ required: true }),
      },
      resolve: async (_parent, { requestId }, context) => {
        if (!context.user || !userService) {
          throw new ValidationError("認証が必要です");
        }
        const userResult = await userService.getUserByFirebaseUid(
          context.user.uid,
        );
        if (!userResult.success) {
          throw new ValidationError("ユーザーが見つかりません");
        }

        const result = await followService.approveRequest(
          requestId,
          userResult.data.id,
        );
        if (!result.success) {
          throw new ValidationError(result.error.message);
        }
        return result.data;
      },
    }),

    rejectFollowRequest: t.field({
      type: FollowRequestRef,
      errors: { types: [ValidationError] },
      authScopes: { loggedIn: true },
      args: {
        requestId: t.arg.int({ required: true }),
      },
      resolve: async (_parent, { requestId }, context) => {
        if (!context.user || !userService) {
          throw new ValidationError("認証が必要です");
        }
        const userResult = await userService.getUserByFirebaseUid(
          context.user.uid,
        );
        if (!userResult.success) {
          throw new ValidationError("ユーザーが見つかりません");
        }

        const result = await followService.rejectRequest(
          requestId,
          userResult.data.id,
        );
        if (!result.success) {
          throw new ValidationError(result.error.message);
        }
        return result.data;
      },
    }),

    unfollow: t.field({
      type: "Boolean",
      errors: { types: [ValidationError] },
      authScopes: { loggedIn: true },
      args: {
        targetUserId: t.arg.int({ required: true }),
      },
      resolve: async (_parent, { targetUserId }, context) => {
        if (!context.user || !userService) {
          throw new ValidationError("認証が必要です");
        }
        const userResult = await userService.getUserByFirebaseUid(
          context.user.uid,
        );
        if (!userResult.success) {
          throw new ValidationError("ユーザーが見つかりません");
        }

        const result = await followService.unfollow(
          userResult.data.id,
          targetUserId,
        );
        if (!result.success) {
          throw new ValidationError(result.error.message);
        }
        return true;
      },
    }),

    cancelFollowRequest: t.field({
      type: "Boolean",
      description: "Cancel a pending follow request",
      errors: { types: [ValidationError] },
      authScopes: { loggedIn: true },
      args: {
        targetUserId: t.arg.int({ required: true }),
      },
      resolve: async (_parent, { targetUserId }, context) => {
        if (!context.user || !userService) {
          throw new ValidationError("認証が必要です");
        }
        const userResult = await userService.getUserByFirebaseUid(
          context.user.uid,
        );
        if (!userResult.success) {
          throw new ValidationError("ユーザーが見つかりません");
        }

        const result = await followService.cancelFollowRequest(
          userResult.data.id,
          targetUserId,
        );
        if (!result.success) {
          throw new ValidationError(result.error.message);
        }
        return true;
      },
    }),
  }));
}
