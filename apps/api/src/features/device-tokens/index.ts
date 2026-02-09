export type {
  DeviceToken,
  NewDeviceToken,
  DeviceTokenRepository,
} from "./internal/repository.js";
export { createDeviceTokenRepository } from "./internal/repository.js";

export type { DeviceTokenService } from "./internal/service.js";
export { createDeviceTokenService } from "./internal/service.js";

export type { FCMAdapter } from "./internal/fcm-adapter.js";
export { createFCMAdapter } from "./internal/fcm-adapter.js";

export type { NotificationService } from "./internal/notification-service.js";
export { createNotificationService } from "./internal/notification-service.js";

export {
  registerDeviceTokenTypes,
  registerDeviceTokenMutations,
} from "./internal/graphql.js";
