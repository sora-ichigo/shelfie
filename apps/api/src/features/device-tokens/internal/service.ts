import { err, ok, type Result } from "../../../errors/result.js";
import type { DeviceToken, DeviceTokenRepository } from "./repository.js";

export type DeviceTokenServiceErrors =
  | { code: "USER_NOT_FOUND"; message: string }
  | { code: "INVALID_TOKEN"; message: string };

export interface RegisterDeviceTokenInput {
  userId: number;
  token: string;
  platform: "ios" | "android";
}

export interface UnregisterDeviceTokenInput {
  userId: number;
  token: string;
}

export interface DeviceTokenService {
  registerToken(
    input: RegisterDeviceTokenInput,
  ): Promise<Result<DeviceToken, DeviceTokenServiceErrors>>;
  unregisterToken(
    input: UnregisterDeviceTokenInput,
  ): Promise<Result<void, DeviceTokenServiceErrors>>;
}

export function createDeviceTokenService(
  repository: DeviceTokenRepository,
): DeviceTokenService {
  return {
    async registerToken(
      input: RegisterDeviceTokenInput,
    ): Promise<Result<DeviceToken, DeviceTokenServiceErrors>> {
      if (!input.token) {
        return err({
          code: "INVALID_TOKEN",
          message: "Token must not be empty",
        });
      }

      const deviceToken = await repository.upsert({
        userId: input.userId,
        token: input.token,
        platform: input.platform,
      });

      return ok(deviceToken);
    },

    async unregisterToken(
      input: UnregisterDeviceTokenInput,
    ): Promise<Result<void, DeviceTokenServiceErrors>> {
      if (!input.token) {
        return err({
          code: "INVALID_TOKEN",
          message: "Token must not be empty",
        });
      }

      await repository.deleteByUserAndToken(input.userId, input.token);
      return ok(undefined);
    },
  };
}
