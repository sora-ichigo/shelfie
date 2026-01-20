export type { AuthErrorCode } from "./internal/graphql.js";
export {
  AUTH_ERROR_CODES,
  AuthError,
  registerAuthMutations,
  registerAuthTypes,
} from "./internal/graphql.js";
export type {
  AuthService,
  AuthServiceError,
  FirebaseAuth,
  RegisterUserInput,
  RegisterUserOutput,
  ResendVerificationInput,
  ResendVerificationOutput,
} from "./internal/service.js";
export { createAuthService } from "./internal/service.js";
