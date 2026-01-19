import type { FeatureModule } from "../index.js";
import type { UserService } from "../users/service.js";
import type { LoggerService } from "../../logger/index.js";
import {
  createAuthService,
  type AuthService,
  type FirebaseAuth,
} from "./service.js";

export const AUTH_FEATURE_NAME = "auth";

export interface AuthPublicApi {
  service: AuthService;
}

export interface AuthFeatureDependencies {
  firebaseAuth: FirebaseAuth;
  userService: UserService;
  logger: LoggerService;
}

export function createAuthFeature(
  deps: AuthFeatureDependencies,
): FeatureModule<AuthPublicApi> {
  const service = createAuthService({
    firebaseAuth: deps.firebaseAuth,
    userService: deps.userService,
    logger: deps.logger,
  });

  return {
    name: AUTH_FEATURE_NAME,

    registerTypes(_builder: unknown): void {
      // GraphQL types will be registered in Task 4
    },

    getPublicApi(): AuthPublicApi {
      return {
        service,
      };
    },
  };
}

export type { AuthService, FirebaseAuth } from "./service.js";
export type {
  RegisterUserInput,
  RegisterUserOutput,
  ResendVerificationInput,
  ResendVerificationOutput,
  AuthServiceError,
} from "./service.js";
