import admin from "firebase-admin";
import { createFirebaseAuthAdapter } from "../auth/index.js";
import { config } from "../config/index.js";
import { getDb } from "../db/index.js";
import {
  createAuthService,
  registerAuthMutations,
  registerAuthQueries,
  registerAuthTypes,
} from "../features/auth/index.js";
import {
  createBookListRepository,
  createBookListService,
  registerBookListsMutations,
  registerBookListsQueries,
  registerBookListsTypes,
} from "../features/book-lists/index.js";
import {
  createBookSearchService,
  createBookShelfRepository,
  createBookShelfService,
  createExternalBookRepository,
  createGoogleBooksRepository,
  registerBooksMutations,
  registerBooksQueries,
  registerBooksTypes,
} from "../features/books/index.js";
import {
  createDeviceTokenRepository,
  createDeviceTokenService,
  createFCMAdapter,
  createNotificationService,
  registerDeviceTokenMutations,
  registerDeviceTokenTypes,
} from "../features/device-tokens/index.js";
import {
  createFollowRepository,
  createFollowService,
  registerFollowMutations,
  registerFollowQueries,
  registerFollowTypes,
} from "../features/follows/index.js";
import {
  registerImageUploadQueries,
  registerImageUploadTypes,
} from "../features/image-upload/index.js";
import {
  createNotificationAppService,
  createNotificationRepository,
  registerNotificationFollowRequestIdField,
  registerNotificationFollowStatusField,
  registerNotificationMutations,
  registerNotificationQueries,
  registerNotificationTypes,
} from "../features/notifications/index.js";
import {
  createUserRepository,
  createUserService,
  registerUserMutations,
  registerUserTypes,
} from "../features/users/index.js";
import { logger } from "../logger/index.js";
import { builder } from "./builder.js";

const db = getDb();
const userRepository = createUserRepository(db);
const userService = createUserService(userRepository);
const firebaseAuth = createFirebaseAuthAdapter();
const authService = createAuthService({
  firebaseAuth,
  userService,
  logger,
});

const rakutenApplicationId = config.getOrDefault("RAKUTEN_APPLICATION_ID", "");
const rakutenSubApplicationId = config.get("RAKUTEN_APPLICATION_ID_SUB");
const googleBooksApiKey = config.getOrDefault("GOOGLE_BOOKS_API_KEY", "");
const externalBookRepository = createExternalBookRepository(
  rakutenApplicationId,
  rakutenSubApplicationId,
);
const googleBooksRepository = createGoogleBooksRepository(googleBooksApiKey);
const bookSearchService = createBookSearchService(
  externalBookRepository,
  logger,
  googleBooksRepository,
);
const bookShelfRepository = createBookShelfRepository(db);
const bookShelfService = createBookShelfService(bookShelfRepository, logger);
const bookListRepository = createBookListRepository(db);
const bookListService = createBookListService(
  bookListRepository,
  bookShelfRepository,
  logger,
);

registerUserTypes(builder, bookShelfRepository);
registerAuthTypes(builder);
registerBooksTypes(builder);
registerImageUploadTypes(builder);
registerBookListsTypes(builder, bookShelfRepository);
registerDeviceTokenTypes(builder);
registerNotificationTypes(builder);
registerFollowTypes(builder);

builder.queryType({
  fields: (t) => ({
    health: t.string({
      resolve: () => "ok",
    }),
  }),
});

registerAuthMutations(builder, authService);
registerAuthQueries(builder, authService);
registerBooksMutations(builder, bookShelfService, userService);
registerUserMutations(builder, userService);
registerImageUploadQueries(builder);
registerBookListsMutations(builder, bookListService, userService);

const deviceTokenRepository = createDeviceTokenRepository(db);
const deviceTokenService = createDeviceTokenService(deviceTokenRepository);
registerDeviceTokenMutations(builder, deviceTokenService, userService);

const notificationRepository = createNotificationRepository(db);
const notificationAppService = createNotificationAppService(
  notificationRepository,
);
registerNotificationQueries(builder, notificationAppService, userService);
registerNotificationMutations(builder, notificationAppService, userService);

const followRepository = createFollowRepository(db);
let pushNotificationService: ReturnType<typeof createNotificationService>;
try {
  const messaging = admin.messaging();
  const fcmAdapter = createFCMAdapter(messaging);
  pushNotificationService = createNotificationService(
    deviceTokenRepository,
    fcmAdapter,
    logger,
  );
} catch {
  logger.warn("Firebase Messaging not available, push notifications disabled");
  pushNotificationService = {
    sendNotification: async () => ({
      success: true as const,
      data: {
        totalTargets: 0,
        successCount: 0,
        failureCount: 0,
        invalidTokensRemoved: 0,
        failures: [],
      },
    }),
  };
}
const followService = createFollowService(
  followRepository,
  notificationAppService,
  pushNotificationService,
  logger,
);
registerBooksQueries(
  builder,
  bookSearchService,
  bookShelfService,
  userService,
  followService,
);
registerBookListsQueries(builder, bookListService, userService, followService);
registerFollowQueries(builder, followService, followRepository, userService);
registerFollowMutations(builder, followService, userService);
registerNotificationFollowStatusField(builder, followService);
registerNotificationFollowRequestIdField(builder, followService);

export function buildSchema() {
  return builder.toSchema();
}

export const schema = buildSchema();
