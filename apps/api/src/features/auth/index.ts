import type { FeatureModule } from "../index.js";
import type { UserService } from "../users/service.js";
import type { LoggerService } from "../../logger/index.js";
import type { Builder } from "../../graphql/builder.js";
import {
  createAuthService,
  type AuthService,
  type FirebaseAuth,
} from "./service.js";
import { registerAuthTypes, registerAuthMutations } from "./types.js";

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

    registerTypes(builder: Builder): void {
      registerAuthTypes(builder);
    },

    registerMutations(builder: Builder): void {
      registerAuthMutations(builder, service);
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
export { registerAuthTypes, registerAuthMutations, AuthError } from "./types.js";
export type { AuthErrorCode } from "./types.js";
