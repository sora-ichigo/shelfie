import admin from "firebase-admin";
import {
  getFirebaseAuthConfig,
  initializeFirebaseAuth,
} from "../auth/firebase.js";
import { closePool, getDb } from "../db/index.js";
import {
  createDeviceTokenRepository,
  createFCMAdapter,
  createNotificationService,
} from "../features/device-tokens/index.js";
import { logger } from "../logger/index.js";
import { parseNotificationArgs } from "./parse-notification-args.js";

async function main() {
  const result = parseNotificationArgs(process.argv.slice(2));

  if (!result.success) {
    console.error(`Error: ${result.error}`);
    process.exit(1);
  }

  const { title, body, userIds } = result.data;

  try {
    const firebaseConfig = getFirebaseAuthConfig();
    initializeFirebaseAuth(firebaseConfig);

    const db = getDb();
    const deviceTokenRepository = createDeviceTokenRepository(db);
    const messaging = admin.messaging();
    const fcmAdapter = createFCMAdapter(messaging);
    const notificationService = createNotificationService(
      deviceTokenRepository,
      fcmAdapter,
      logger,
    );

    console.log(`Sending notification: "${title}"`);
    console.log(
      `Target: ${userIds === "all" ? "all users" : `user IDs: ${userIds.join(", ")}`}`,
    );

    const sendResult = await notificationService.sendNotification({
      title,
      body,
      userIds,
    });

    if (!sendResult.success) {
      console.error(`Error: ${sendResult.error.message}`);
      process.exit(1);
    }

    const {
      totalTargets,
      successCount,
      failureCount,
      invalidTokensRemoved,
      failures,
    } = sendResult.data;

    console.log("\n--- Send Result ---");
    console.log(`Total targets: ${totalTargets}`);
    console.log(`Success: ${successCount}`);
    console.log(`Failure: ${failureCount}`);
    console.log(`Invalid tokens removed: ${invalidTokensRemoved}`);

    if (failures.length > 0) {
      console.log("\n--- Failed Notifications ---");
      for (const failure of failures) {
        console.log(
          `  User ID: ${failure.userId}, Token: ${failure.token}, Error: ${failure.error}`,
        );
      }
    }
  } catch (error) {
    console.error("Unexpected error:", error);
    process.exit(1);
  } finally {
    await closePool();
  }
}

main();
