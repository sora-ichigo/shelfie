export type {
  AuthErrorCode,
  LoginErrorCode,
  PasswordChangeErrorCode,
  PasswordResetErrorCode,
} from "./internal/graphql.js";
export {
  AUTH_ERROR_CODES,
  AuthError,
  LOGIN_ERROR_CODES,
  mapLoginErrorToAuthError,
  mapPasswordChangeErrorToAuthError,
  mapPasswordResetErrorToAuthError,
  PASSWORD_CHANGE_ERROR_CODES,
  PASSWORD_RESET_ERROR_CODES,
  registerAuthMutations,
  registerAuthQueries,
  registerAuthTypes,
} from "./internal/graphql.js";
export type {
  AuthService,
  AuthServiceError,
  ChangePasswordInput,
  ChangePasswordOutput,
  FirebaseAuth,
  LoginServiceError,
  PasswordChangeServiceError,
  RegisterUserInput,
  RegisterUserOutput,
  SendPasswordResetEmailInput,
  SendPasswordResetEmailServiceError,
} from "./internal/service.js";
export { createAuthService } from "./internal/service.js";
