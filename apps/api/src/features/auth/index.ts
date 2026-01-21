export type { AuthErrorCode, LoginErrorCode } from "./internal/graphql.js";
export {
  AUTH_ERROR_CODES,
  AuthError,
  LOGIN_ERROR_CODES,
  mapLoginErrorToAuthError,
  registerAuthMutations,
  registerAuthQueries,
  registerAuthTypes,
} from "./internal/graphql.js";
export type {
  AuthService,
  AuthServiceError,
  FirebaseAuth,
  LoginServiceError,
  RegisterUserInput,
  RegisterUserOutput,
} from "./internal/service.js";
export { createAuthService } from "./internal/service.js";
