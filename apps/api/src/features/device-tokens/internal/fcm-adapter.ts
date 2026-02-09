import type { Messaging } from "firebase-admin/messaging";

export interface FCMBatchResult {
  successCount: number;
  failureCount: number;
  responses: Array<{
    success: boolean;
    error?: { code: string; message: string };
    token: string;
  }>;
}

export interface FCMAdapter {
  sendMulticast(
    tokens: string[],
    notification: { title: string; body: string },
  ): Promise<FCMBatchResult>;
}

export function createFCMAdapter(messaging: Messaging): FCMAdapter {
  return {
    async sendMulticast(
      tokens: string[],
      notification: { title: string; body: string },
    ): Promise<FCMBatchResult> {
      const response = await messaging.sendEachForMulticast({
        tokens,
        notification,
      });

      const responses = response.responses.map((res, index) => ({
        success: res.success,
        error: res.error
          ? { code: res.error.code, message: res.error.message }
          : undefined,
        token: tokens[index],
      }));

      return {
        successCount: response.successCount,
        failureCount: response.failureCount,
        responses,
      };
    },
  };
}
