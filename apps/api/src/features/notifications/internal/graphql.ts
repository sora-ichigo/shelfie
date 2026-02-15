import type { Builder } from "../../../graphql/builder.js";
import { FollowStatusRef } from "../../follows/internal/graphql.js";
import type { FollowService } from "../../follows/internal/service.js";
import { UserRef } from "../../users/internal/graphql.js";
import type { UserService } from "../../users/internal/service.js";
import type { NotificationWithSender } from "./repository.js";
import type { NotificationAppService } from "./service.js";

type AppNotificationObjectRef = ReturnType<typeof createAppNotificationRef>;

function createAppNotificationRef(builder: Builder) {
  return builder.objectRef<NotificationWithSender>("AppNotification");
}

export let AppNotificationRef: AppNotificationObjectRef;

export function registerNotificationTypes(builder: Builder): void {
  const NotificationTypeEnum = builder.enumType("NotificationType", {
    values: {
      FOLLOW_REQUEST_RECEIVED: {
        value: "follow_request_received",
      },
      FOLLOW_REQUEST_APPROVED: {
        value: "follow_request_approved",
      },
      NEW_FOLLOWER: {
        value: "new_follower",
      },
    } as const,
  });

  AppNotificationRef = createAppNotificationRef(builder);
  AppNotificationRef.implement({
    fields: (t) => ({
      id: t.int({
        nullable: false,
        resolve: (parent) => parent.notification.id,
      }),
      sender: t.field({
        type: UserRef,
        nullable: false,
        resolve: (parent) => parent.sender,
      }),
      type: t.field({
        type: NotificationTypeEnum,
        nullable: false,
        resolve: (parent) =>
          parent.notification.type as
            | "follow_request_received"
            | "follow_request_approved"
            | "new_follower",
      }),
      isRead: t.boolean({
        nullable: false,
        resolve: (parent) => parent.notification.isRead,
      }),
      createdAt: t.field({
        type: "DateTime",
        nullable: false,
        resolve: (parent) => parent.notification.createdAt,
      }),
    }),
  });
}

async function resolveUserId(
  context: { user: { uid: string } | null },
  userService: UserService,
): Promise<number> {
  if (!context.user) {
    throw new Error("Authentication required");
  }
  const userResult = await userService.getUserByFirebaseUid(context.user.uid);
  if (!userResult.success) {
    throw new Error("User not found");
  }
  return userResult.data.id;
}

export function registerNotificationQueries(
  builder: Builder,
  notificationService: NotificationAppService,
  userService: UserService,
): void {
  builder.queryFields((t) => ({
    notifications: t.field({
      type: [AppNotificationRef],
      nullable: false,
      authScopes: {
        loggedIn: true,
      },
      args: {
        cursor: t.arg.int({ required: false }),
        limit: t.arg.int({ required: false }),
      },
      resolve: async (_parent, { cursor, limit }, context) => {
        const userId = await resolveUserId(context, userService);
        return notificationService.getNotifications(
          userId,
          cursor ?? null,
          limit ?? 20,
        );
      },
    }),
    unreadNotificationCount: t.int({
      nullable: false,
      authScopes: {
        loggedIn: true,
      },
      resolve: async (_parent, _args, context) => {
        const userId = await resolveUserId(context, userService);
        return notificationService.getUnreadCount(userId);
      },
    }),
  }));
}

export function registerNotificationOutgoingFollowStatusField(
  builder: Builder,
  followService: FollowService,
): void {
  builder.objectField(AppNotificationRef, "outgoingFollowStatus", (t) =>
    t.loadable({
      type: FollowStatusRef,
      nullable: false,
      load: async (keys: string[]) => {
        const parsed = keys.map((k) => {
          const [recipientId, senderId] = k.split(":").map(Number);
          return { recipientId, senderId };
        });
        const recipientId = parsed[0].recipientId;
        const senderIds = parsed.map((p) => p.senderId);
        const statusMap = await followService.getFollowStatusBatch(
          recipientId,
          senderIds,
        );
        return keys.map((k) => {
          const senderId = Number(k.split(":")[1]);
          return statusMap.get(senderId)?.outgoing ?? "NONE";
        });
      },
      resolve: (parent) =>
        `${parent.notification.recipientId}:${parent.notification.senderId}`,
    }),
  );
}

export function registerNotificationIncomingFollowStatusField(
  builder: Builder,
  followService: FollowService,
): void {
  builder.objectField(AppNotificationRef, "incomingFollowStatus", (t) =>
    t.loadable({
      type: FollowStatusRef,
      nullable: false,
      load: async (keys: string[]) => {
        const parsed = keys.map((k) => {
          const [recipientId, senderId] = k.split(":").map(Number);
          return { recipientId, senderId };
        });
        const recipientId = parsed[0].recipientId;
        const senderIds = parsed.map((p) => p.senderId);
        const statusMap = await followService.getFollowStatusBatch(
          recipientId,
          senderIds,
        );
        return keys.map((k) => {
          const senderId = Number(k.split(":")[1]);
          return statusMap.get(senderId)?.incoming ?? "NONE";
        });
      },
      resolve: (parent) =>
        `${parent.notification.recipientId}:${parent.notification.senderId}`,
    }),
  );
}

export function registerNotificationFollowRequestIdField(
  builder: Builder,
  followService: FollowService,
): void {
  builder.objectField(AppNotificationRef, "followRequestId", (t) =>
    t.loadable({
      type: "Int",
      nullable: true,
      load: async (keys: string[]) => {
        const parsed = keys.map((k) => {
          const [recipientId, senderId] = k.split(":").map(Number);
          return { recipientId, senderId };
        });
        const recipientId = parsed[0].recipientId;
        const senderIds = parsed.map((p) => p.senderId);
        const idMap = await followService.getFollowRequestIdBatch(
          recipientId,
          senderIds,
        );
        return keys.map((k) => {
          const senderId = Number(k.split(":")[1]);
          return idMap.get(senderId) ?? null;
        });
      },
      resolve: (parent) =>
        `${parent.notification.recipientId}:${parent.notification.senderId}`,
    }),
  );
}

export function registerNotificationMutations(
  builder: Builder,
  notificationService: NotificationAppService,
  userService: UserService,
): void {
  builder.mutationFields((t) => ({
    markNotificationAsRead: t.boolean({
      authScopes: {
        loggedIn: true,
      },
      args: {
        notificationId: t.arg.int({ required: true }),
      },
      resolve: async (_parent, { notificationId }, context) => {
        const userId = await resolveUserId(context, userService);
        await notificationService.markAsRead(notificationId, userId);
        return true;
      },
    }),
  }));
}
