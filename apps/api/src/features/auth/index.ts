export type {
  AuthService,
  AuthServiceError,
  FirebaseAuth,
  RegisterUserInput,
  RegisterUserOutput,
  ResendVerificationInput,
  ResendVerificationOutput,
} from "./internal/service.js";

export type { AuthErrorCode } from "./internal/graphql.js";
export { AUTH_ERROR_CODES, AuthError } from "./internal/graphql.js";

export { createAuthService } from "./internal/service.js";
export { registerAuthTypes, registerAuthMutations } from "./internal/graphql.js";
