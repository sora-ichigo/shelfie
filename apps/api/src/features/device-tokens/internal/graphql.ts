import type { DeviceToken } from "../../../db/schema/device-tokens.js";
import type { Builder } from "../../../graphql/builder.js";
import type { UserService } from "../../users/internal/service.js";
import type { DeviceTokenService } from "./service.js";

type DeviceTokenObjectRef = ReturnType<typeof createDeviceTokenRef>;

function createDeviceTokenRef(builder: Builder) {
  return builder.objectRef<DeviceToken>("DeviceToken");
}

export let DeviceTokenRef: DeviceTokenObjectRef;

function createRegisterDeviceTokenInputRef(builder: Builder) {
  return builder.inputRef<{ token: string; platform: string }>(
    "RegisterDeviceTokenInput",
  );
}

function createUnregisterDeviceTokenInputRef(builder: Builder) {
  return builder.inputRef<{ token: string }>("UnregisterDeviceTokenInput");
}

type RegisterDeviceTokenInputRef = ReturnType<
  typeof createRegisterDeviceTokenInputRef
>;
type UnregisterDeviceTokenInputRef = ReturnType<
  typeof createUnregisterDeviceTokenInputRef
>;

let RegisterInputRef: RegisterDeviceTokenInputRef | null = null;
let UnregisterInputRef: UnregisterDeviceTokenInputRef | null = null;

export function registerDeviceTokenTypes(builder: Builder): void {
  DeviceTokenRef = createDeviceTokenRef(builder);

  DeviceTokenRef.implement({
    description: "A device token for push notifications",
    fields: (t) => ({
      id: t.exposeInt("id", {
        description: "The unique identifier of the device token",
      }),
      userId: t.exposeInt("userId", {
        description: "The user who owns this device token",
      }),
      platform: t.exposeString("platform", {
        description: "The platform of the device (ios or android)",
      }),
      createdAt: t.expose("createdAt", {
        type: "DateTime",
        description: "When the device token was registered",
      }),
    }),
  });

  RegisterInputRef = createRegisterDeviceTokenInputRef(builder);
  RegisterInputRef.implement({
    description: "Input for registering a device token",
    fields: (t) => ({
      token: t.string({ required: true, description: "FCM device token" }),
      platform: t.string({
        required: true,
        description: "Device platform (ios or android)",
      }),
    }),
  });

  UnregisterInputRef = createUnregisterDeviceTokenInputRef(builder);
  UnregisterInputRef.implement({
    description: "Input for unregistering a device token",
    fields: (t) => ({
      token: t.string({ required: true, description: "FCM device token" }),
    }),
  });
}

export function registerDeviceTokenMutations(
  builder: Builder,
  deviceTokenService: DeviceTokenService,
  userService?: UserService,
): void {
  builder.mutationFields((t) => ({
    registerDeviceToken: t.field({
      type: DeviceTokenRef,
      description: "Register a device token for push notifications",
      authScopes: {
        loggedIn: true,
      },
      args: {
        input: t.arg({
          // biome-ignore lint/style/noNonNullAssertion: initialized in registerDeviceTokenTypes
          type: RegisterInputRef!,
          required: true,
        }),
      },
      resolve: async (_parent, { input }, context): Promise<DeviceToken> => {
        if (!context.user) {
          throw new Error("Authentication required");
        }

        let userId: number;
        if (userService) {
          const userResult = await userService.getUserByFirebaseUid(
            context.user.uid,
          );
          if (!userResult.success) {
            throw new Error("User not found");
          }
          userId = userResult.data.id;
        } else {
          throw new Error("UserService not available");
        }

        const result = await deviceTokenService.registerToken({
          userId,
          token: input.token,
          platform: input.platform as "ios" | "android",
        });

        if (!result.success) {
          throw new Error(result.error.message);
        }

        return result.data;
      },
    }),

    unregisterDeviceToken: t.field({
      type: "Boolean",
      description: "Unregister a device token",
      authScopes: {
        loggedIn: true,
      },
      args: {
        input: t.arg({
          // biome-ignore lint/style/noNonNullAssertion: initialized in registerDeviceTokenTypes
          type: UnregisterInputRef!,
          required: true,
        }),
      },
      resolve: async (_parent, { input }, context): Promise<boolean> => {
        if (!context.user) {
          throw new Error("Authentication required");
        }

        let userId: number;
        if (userService) {
          const userResult = await userService.getUserByFirebaseUid(
            context.user.uid,
          );
          if (!userResult.success) {
            throw new Error("User not found");
          }
          userId = userResult.data.id;
        } else {
          throw new Error("UserService not available");
        }

        const result = await deviceTokenService.unregisterToken({
          userId,
          token: input.token,
        });

        if (!result.success) {
          throw new Error(result.error.message);
        }

        return true;
      },
    }),
  }));
}
