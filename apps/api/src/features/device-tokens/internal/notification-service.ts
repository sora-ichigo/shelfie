import { err, ok, type Result } from "../../../errors/result.js";
import type { LoggerService } from "../../../logger/index.js";
import type { FCMAdapter } from "./fcm-adapter.js";
import type { DeviceTokenRepository } from "./repository.js";

const BATCH_SIZE = 500;
const INVALID_TOKEN_ERROR_CODE =
  "messaging/registration-token-not-registered";

export interface SendNotificationInput {
  title: string;
  body: string;
  userIds: number[] | "all";
}

export interface FailedNotification {
  userId: number;
  token: string;
  error: string;
}

export interface SendNotificationResult {
  totalTargets: number;
  successCount: number;
  failureCount: number;
  invalidTokensRemoved: number;
  failures: FailedNotification[];
}

export type NotificationServiceErrors =
  | { code: "NO_TARGETS"; message: string }
  | { code: "FCM_ERROR"; message: string };

export interface NotificationService {
  sendNotification(
    input: SendNotificationInput,
  ): Promise<Result<SendNotificationResult, NotificationServiceErrors>>;
}

export function createNotificationService(
  repository: DeviceTokenRepository,
  fcmAdapter: FCMAdapter,
  logger: LoggerService,
): NotificationService {
  return {
    async sendNotification(
      input: SendNotificationInput,
    ): Promise<Result<SendNotificationResult, NotificationServiceErrors>> {
      const tokens =
        input.userIds === "all"
          ? await repository.findAll()
          : await repository.findByUserIds(input.userIds);

      if (tokens.length === 0) {
        return err({
          code: "NO_TARGETS",
          message: "No target devices found",
        });
      }

      const tokenStrings = tokens.map((t) => t.token);
      const tokenToUserId = new Map(
        tokens.map((t) => [t.token, t.userId]),
      );

      let totalSuccess = 0;
      let totalFailure = 0;
      const allFailures: FailedNotification[] = [];
      const invalidTokens: string[] = [];

      for (let i = 0; i < tokenStrings.length; i += BATCH_SIZE) {
        const batch = tokenStrings.slice(i, i + BATCH_SIZE);
        const batchResult = await fcmAdapter.sendMulticast(batch, {
          title: input.title,
          body: input.body,
        });

        totalSuccess += batchResult.successCount;
        totalFailure += batchResult.failureCount;

        for (const response of batchResult.responses) {
          if (!response.success && response.error) {
            const userId = tokenToUserId.get(response.token) ?? 0;

            allFailures.push({
              userId,
              token: response.token,
              error: response.error.message,
            });

            if (response.error.code === INVALID_TOKEN_ERROR_CODE) {
              invalidTokens.push(response.token);
            }

            logger.error(
              `Failed to send notification to token ${response.token}`,
              undefined,
              {
                userId: String(userId),
                token: response.token,
                errorCode: response.error.code,
                errorMessage: response.error.message,
              },
            );
          }
        }
      }

      if (invalidTokens.length > 0) {
        await repository.deleteByTokens(invalidTokens);
        logger.info(
          `Removed ${invalidTokens.length} invalid device tokens`,
          { count: invalidTokens.length },
        );
      }

      return ok({
        totalTargets: tokens.length,
        successCount: totalSuccess,
        failureCount: totalFailure,
        invalidTokensRemoved: invalidTokens.length,
        failures: allFailures,
      });
    },
  };
}
