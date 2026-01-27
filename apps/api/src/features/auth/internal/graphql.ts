import type { User } from "../../../db/schema/users.js";
import type { Builder } from "../../../graphql/builder.js";
import { UserRef } from "../../users/internal/graphql.js";
import type {
  AuthService,
  AuthServiceError,
  LoginServiceError,
  PasswordChangeServiceError,
  SendPasswordResetEmailServiceError,
} from "./service.js";

export const LOGIN_ERROR_CODES = [
  "INVALID_TOKEN",
  "TOKEN_EXPIRED",
  "USER_NOT_FOUND",
  "UNAUTHENTICATED",
  "INVALID_CREDENTIALS",
] as const;

export type LoginErrorCode = (typeof LOGIN_ERROR_CODES)[number];

export const PASSWORD_CHANGE_ERROR_CODES = [
  "INVALID_CREDENTIALS",
  "WEAK_PASSWORD",
  "NETWORK_ERROR",
  "INTERNAL_ERROR",
] as const;

export type PasswordChangeErrorCode =
  (typeof PASSWORD_CHANGE_ERROR_CODES)[number];

export const PASSWORD_RESET_ERROR_CODES = [
  "USER_NOT_FOUND",
  "INVALID_EMAIL",
  "NETWORK_ERROR",
  "INTERNAL_ERROR",
] as const;

export type PasswordResetErrorCode =
  (typeof PASSWORD_RESET_ERROR_CODES)[number];

export const AUTH_ERROR_CODES = [
  "EMAIL_ALREADY_EXISTS",
  "INVALID_PASSWORD",
  "WEAK_PASSWORD",
  "INVALID_EMAIL",
  "NETWORK_ERROR",
  "INTERNAL_ERROR",
  ...LOGIN_ERROR_CODES,
] as const;

export type AuthErrorCode = (typeof AUTH_ERROR_CODES)[number];

export interface AuthErrorData {
  code: AuthErrorCode;
  message: string;
  field: string | null;
  retryable: boolean;
}

export class AuthError extends Error implements AuthErrorData {
  code: AuthErrorCode;
  field: string | null;
  retryable: boolean;

  constructor(
    code: AuthErrorCode,
    message: string,
    field: string | null = null,
    retryable = false,
  ) {
    super(message);
    this.code = code;
    this.field = field;
    this.retryable = retryable;
    this.name = "AuthError";
  }

  toData(): AuthErrorData {
    return {
      code: this.code,
      message: this.message,
      field: this.field,
      retryable: this.retryable,
    };
  }
}

export function createAuthErrorData(
  code: AuthErrorCode,
  message: string,
  field: string | null = null,
  retryable = false,
): AuthErrorData {
  return { code, message, field, retryable };
}

function mapErrorCodeToField(code: string): string | null {
  switch (code) {
    case "EMAIL_ALREADY_EXISTS":
      return "email";
    case "INVALID_PASSWORD":
      return "password";
    default:
      return null;
  }
}

function isRetryableError(code: string): boolean {
  return code === "NETWORK_ERROR" || code === "TOKEN_EXPIRED";
}

export function mapServiceErrorToAuthError(error: AuthServiceError): AuthError {
  const code = error.code === "FIREBASE_ERROR" ? "INTERNAL_ERROR" : error.code;
  return new AuthError(
    code as AuthErrorCode,
    error.message,
    mapErrorCodeToField(code),
    isRetryableError(code),
  );
}

export function mapLoginErrorToAuthError(error: LoginServiceError): AuthError {
  return new AuthError(
    error.code as AuthErrorCode,
    error.message,
    null,
    isRetryableError(error.code),
  );
}

export function mapPasswordChangeErrorToAuthError(
  error: PasswordChangeServiceError,
): AuthError {
  const field =
    error.code === "INVALID_CREDENTIALS"
      ? "currentPassword"
      : error.code === "WEAK_PASSWORD"
        ? "newPassword"
        : null;
  return new AuthError(
    error.code as AuthErrorCode,
    error.message,
    field,
    isRetryableError(error.code),
  );
}

export function mapPasswordResetErrorToAuthError(
  error: SendPasswordResetEmailServiceError,
): AuthError {
  const field =
    error.code === "INVALID_EMAIL" || error.code === "USER_NOT_FOUND"
      ? "email"
      : null;
  return new AuthError(
    error.code as AuthErrorCode,
    error.message,
    field,
    isRetryableError(error.code),
  );
}

export function mapLoginErrorToAuthErrorData(
  error: LoginServiceError,
): AuthErrorData {
  return createAuthErrorData(
    error.code as AuthErrorCode,
    error.message,
    null,
    isRetryableError(error.code),
  );
}

function createRegisterUserInputRef(builder: Builder) {
  return builder.inputRef<{ email: string; password: string }>(
    "RegisterUserInput",
  );
}

type RegisterUserInputRef = ReturnType<typeof createRegisterUserInputRef>;

function createLoginUserInputRef(builder: Builder) {
  return builder.inputRef<{ email: string; password: string }>(
    "LoginUserInput",
  );
}

type LoginUserInputRef = ReturnType<typeof createLoginUserInputRef>;

interface LoginResultData {
  user: User;
  idToken: string;
  refreshToken: string;
}

interface RefreshTokenResultData {
  idToken: string;
  refreshToken: string;
}

function createLoginResultRef(builder: Builder) {
  return builder.objectRef<LoginResultData>("LoginResult");
}

type LoginResultObjectRef = ReturnType<typeof createLoginResultRef>;

function createRefreshTokenInputRef(builder: Builder) {
  return builder.inputRef<{ refreshToken: string }>("RefreshTokenInput");
}

type RefreshTokenInputRef = ReturnType<typeof createRefreshTokenInputRef>;

function createRefreshTokenResultRef(builder: Builder) {
  return builder.objectRef<RefreshTokenResultData>("RefreshTokenResult");
}

type RefreshTokenResultObjectRef = ReturnType<
  typeof createRefreshTokenResultRef
>;

function createChangePasswordInputRef(builder: Builder) {
  return builder.inputRef<{
    email: string;
    currentPassword: string;
    newPassword: string;
  }>("ChangePasswordInput");
}

type ChangePasswordInputRef = ReturnType<typeof createChangePasswordInputRef>;

interface ChangePasswordResultData {
  idToken: string;
  refreshToken: string;
}

function createChangePasswordResultRef(builder: Builder) {
  return builder.objectRef<ChangePasswordResultData>("ChangePasswordResult");
}

type ChangePasswordResultObjectRef = ReturnType<
  typeof createChangePasswordResultRef
>;

function createSendPasswordResetEmailInputRef(builder: Builder) {
  return builder.inputRef<{ email: string }>("SendPasswordResetEmailInput");
}

type SendPasswordResetEmailInputRef = ReturnType<
  typeof createSendPasswordResetEmailInputRef
>;

interface SendPasswordResetEmailResultData {
  success: boolean;
}

function createSendPasswordResetEmailResultRef(builder: Builder) {
  return builder.objectRef<SendPasswordResetEmailResultData>(
    "SendPasswordResetEmailResult",
  );
}

type SendPasswordResetEmailResultObjectRef = ReturnType<
  typeof createSendPasswordResetEmailResultRef
>;

let AuthErrorCodeEnumRef: ReturnType<Builder["enumType"]> | null = null;
let RegisterUserInputRef: RegisterUserInputRef | null = null;
let LoginUserInputRef: LoginUserInputRef | null = null;
let LoginResultRef: LoginResultObjectRef | null = null;
let RefreshTokenInputRef: RefreshTokenInputRef | null = null;
let RefreshTokenResultRef: RefreshTokenResultObjectRef | null = null;
let ChangePasswordInputRef: ChangePasswordInputRef | null = null;
let ChangePasswordResultRef: ChangePasswordResultObjectRef | null = null;
let SendPasswordResetEmailInputRef: SendPasswordResetEmailInputRef | null =
  null;
let SendPasswordResetEmailResultRef: SendPasswordResetEmailResultObjectRef | null =
  null;

type AuthErrorDataObjectRef = ReturnType<typeof createAuthErrorDataRef>;

function createAuthErrorDataRef(builder: Builder) {
  return builder.objectRef<AuthErrorData>("AuthErrorResult");
}

let AuthErrorDataRef: AuthErrorDataObjectRef | null = null;

export function registerAuthTypes(builder: Builder): void {
  AuthErrorCodeEnumRef = builder.enumType("AuthErrorCode", {
    description: "Error codes for authentication operations",
    values: AUTH_ERROR_CODES.reduce(
      (acc, code) => {
        acc[code] = { value: code };
        return acc;
      },
      {} as Record<AuthErrorCode, { value: AuthErrorCode }>,
    ),
  });

  builder.objectType(AuthError, {
    name: "AuthError",
    description: "Error object for authentication operations",
    fields: (t) => ({
      code: t.field({
        // biome-ignore lint/style/noNonNullAssertion: initialized in registerAuthTypes
        type: AuthErrorCodeEnumRef!,
        description: "Error code",
        resolve: (parent) => parent.code,
      }),
      message: t.exposeString("message", {
        description: "Human-readable error message",
      }),
      field: t.string({
        description: "Field that caused the error, if applicable",
        nullable: true,
        resolve: (parent) => parent.field,
      }),
      retryable: t.boolean({
        description: "Whether the operation can be retried",
        resolve: (parent) => parent.retryable,
      }),
    }),
  });

  AuthErrorDataRef = createAuthErrorDataRef(builder);

  AuthErrorDataRef.implement({
    description: "Error object for query results",
    fields: (t) => ({
      code: t.field({
        // biome-ignore lint/style/noNonNullAssertion: initialized in registerAuthTypes
        type: AuthErrorCodeEnumRef!,
        description: "Error code",
        resolve: (parent) => parent.code,
      }),
      message: t.exposeString("message", {
        description: "Human-readable error message",
      }),
      field: t.string({
        description: "Field that caused the error, if applicable",
        nullable: true,
        resolve: (parent) => parent.field,
      }),
      retryable: t.exposeBoolean("retryable", {
        description: "Whether the operation can be retried",
      }),
    }),
  });

  RegisterUserInputRef = createRegisterUserInputRef(builder);
  RegisterUserInputRef.implement({
    description: "Input for user registration",
    fields: (t) => ({
      email: t.string({ required: true, description: "Email address" }),
      password: t.string({ required: true, description: "Password" }),
    }),
  });

  LoginUserInputRef = createLoginUserInputRef(builder);
  LoginUserInputRef.implement({
    description: "Input for user login",
    fields: (t) => ({
      email: t.string({ required: true, description: "Email address" }),
      password: t.string({ required: true, description: "Password" }),
    }),
  });

  LoginResultRef = createLoginResultRef(builder);
  LoginResultRef.implement({
    description: "Result of successful login",
    fields: (t) => ({
      user: t.field({
        type: UserRef,
        nullable: false,
        description: "Logged in user",
        resolve: (parent) => parent.user,
      }),
      idToken: t.string({
        nullable: false,
        description: "Firebase ID token for API authentication",
        resolve: (parent) => parent.idToken,
      }),
      refreshToken: t.string({
        nullable: false,
        description: "Firebase refresh token for obtaining new ID tokens",
        resolve: (parent) => parent.refreshToken,
      }),
    }),
  });

  RefreshTokenInputRef = createRefreshTokenInputRef(builder);
  RefreshTokenInputRef.implement({
    description: "Input for token refresh",
    fields: (t) => ({
      refreshToken: t.string({ required: true, description: "Refresh token" }),
    }),
  });

  RefreshTokenResultRef = createRefreshTokenResultRef(builder);
  RefreshTokenResultRef.implement({
    description: "Result of successful token refresh",
    fields: (t) => ({
      idToken: t.string({
        nullable: false,
        description: "New Firebase ID token",
        resolve: (parent) => parent.idToken,
      }),
      refreshToken: t.string({
        nullable: false,
        description: "New refresh token",
        resolve: (parent) => parent.refreshToken,
      }),
    }),
  });

  ChangePasswordInputRef = createChangePasswordInputRef(builder);
  ChangePasswordInputRef.implement({
    description: "Input for password change",
    fields: (t) => ({
      email: t.string({ required: true, description: "User email address" }),
      currentPassword: t.string({
        required: true,
        description: "Current password",
      }),
      newPassword: t.string({ required: true, description: "New password" }),
    }),
  });

  ChangePasswordResultRef = createChangePasswordResultRef(builder);
  ChangePasswordResultRef.implement({
    description: "Result of successful password change",
    fields: (t) => ({
      idToken: t.string({
        nullable: false,
        description: "New Firebase ID token",
        resolve: (parent) => parent.idToken,
      }),
      refreshToken: t.string({
        nullable: false,
        description: "New refresh token",
        resolve: (parent) => parent.refreshToken,
      }),
    }),
  });

  SendPasswordResetEmailInputRef =
    createSendPasswordResetEmailInputRef(builder);
  SendPasswordResetEmailInputRef.implement({
    description: "Input for password reset email",
    fields: (t) => ({
      email: t.string({
        required: true,
        description: "Email address to send reset link",
      }),
    }),
  });

  SendPasswordResetEmailResultRef =
    createSendPasswordResetEmailResultRef(builder);
  SendPasswordResetEmailResultRef.implement({
    description: "Result of password reset email request",
    fields: (t) => ({
      success: t.exposeBoolean("success", {
        description: "Whether the email was sent successfully",
      }),
    }),
  });
}

export { AuthErrorDataRef };

export function registerAuthMutations(
  builder: Builder,
  authService: AuthService,
): void {
  builder.mutationType({
    fields: (t) => ({
      registerUser: t.field({
        // biome-ignore lint/style/noNonNullAssertion: initialized in registerAuthTypes
        type: LoginResultRef!,
        description: "Register a new user with email and password",
        errors: {
          types: [AuthError],
        },
        args: {
          input: t.arg({
            // biome-ignore lint/style/noNonNullAssertion: initialized in registerAuthTypes
            type: RegisterUserInputRef!,
            required: true,
          }),
        },
        resolve: async (_parent, { input }): Promise<LoginResultData> => {
          const result = await authService.register({
            email: input.email,
            password: input.password,
          });

          if (!result.success) {
            throw mapServiceErrorToAuthError(result.error);
          }

          return {
            user: result.data.user,
            idToken: result.data.idToken,
            refreshToken: result.data.refreshToken,
          };
        },
      }),
      loginUser: t.field({
        // biome-ignore lint/style/noNonNullAssertion: initialized in registerAuthTypes
        type: LoginResultRef!,
        description: "Login with email and password",
        errors: {
          types: [AuthError],
        },
        args: {
          input: t.arg({
            // biome-ignore lint/style/noNonNullAssertion: initialized in registerAuthTypes
            type: LoginUserInputRef!,
            required: true,
          }),
        },
        resolve: async (_parent, { input }): Promise<LoginResultData> => {
          const result = await authService.login({
            email: input.email,
            password: input.password,
          });

          if (!result.success) {
            throw mapLoginErrorToAuthError(result.error);
          }

          return {
            user: result.data.user,
            idToken: result.data.idToken,
            refreshToken: result.data.refreshToken,
          };
        },
      }),
      refreshToken: t.field({
        // biome-ignore lint/style/noNonNullAssertion: initialized in registerAuthTypes
        type: RefreshTokenResultRef!,
        description: "Refresh ID token using refresh token",
        errors: {
          types: [AuthError],
        },
        args: {
          input: t.arg({
            // biome-ignore lint/style/noNonNullAssertion: initialized in registerAuthTypes
            type: RefreshTokenInputRef!,
            required: true,
          }),
        },
        resolve: async (
          _parent,
          { input },
        ): Promise<RefreshTokenResultData> => {
          const result = await authService.refreshToken(input.refreshToken);

          if (!result.success) {
            throw mapLoginErrorToAuthError(result.error);
          }

          return {
            idToken: result.data.idToken,
            refreshToken: result.data.refreshToken,
          };
        },
      }),
      changePassword: t.field({
        // biome-ignore lint/style/noNonNullAssertion: initialized in registerAuthTypes
        type: ChangePasswordResultRef!,
        description: "Change user password after verifying current password",
        errors: {
          types: [AuthError],
        },
        args: {
          input: t.arg({
            // biome-ignore lint/style/noNonNullAssertion: initialized in registerAuthTypes
            type: ChangePasswordInputRef!,
            required: true,
          }),
        },
        resolve: async (
          _parent,
          { input },
        ): Promise<ChangePasswordResultData> => {
          const result = await authService.changePassword({
            email: input.email,
            currentPassword: input.currentPassword,
            newPassword: input.newPassword,
          });

          if (!result.success) {
            throw mapPasswordChangeErrorToAuthError(result.error);
          }

          return {
            idToken: result.data.idToken,
            refreshToken: result.data.refreshToken,
          };
        },
      }),
      sendPasswordResetEmail: t.field({
        // biome-ignore lint/style/noNonNullAssertion: initialized in registerAuthTypes
        type: SendPasswordResetEmailResultRef!,
        description: "Send password reset email to the specified address",
        errors: {
          types: [AuthError],
        },
        args: {
          input: t.arg({
            // biome-ignore lint/style/noNonNullAssertion: initialized in registerAuthTypes
            type: SendPasswordResetEmailInputRef!,
            required: true,
          }),
        },
        resolve: async (
          _parent,
          { input },
        ): Promise<SendPasswordResetEmailResultData> => {
          const result = await authService.sendPasswordResetEmail({
            email: input.email,
          });

          if (!result.success) {
            throw mapPasswordResetErrorToAuthError(result.error);
          }

          return {
            success: true,
          };
        },
      }),
    }),
  });
}

let MeResultRef: ReturnType<Builder["unionType"]> | null = null;

function isAuthErrorData(value: unknown): value is AuthErrorData {
  return (
    typeof value === "object" &&
    value !== null &&
    "code" in value &&
    "message" in value &&
    "retryable" in value &&
    !(value instanceof Error)
  );
}

export function registerAuthQueries(
  builder: Builder,
  authService: AuthService,
): void {
  MeResultRef = builder.unionType("MeResult", {
    description: "Result of me query - either User or AuthErrorResult",
    // biome-ignore lint/style/noNonNullAssertion: initialized in registerAuthTypes
    types: [UserRef, AuthErrorDataRef!],
    resolveType: (value) => {
      if (isAuthErrorData(value)) {
        return "AuthErrorResult";
      }
      return "User";
    },
  });

  builder.queryFields((t) => ({
    me: t.field({
      // biome-ignore lint/style/noNonNullAssertion: initialized in registerAuthQueries
      type: MeResultRef!,
      nullable: false,
      description: "Get the currently authenticated user",
      // biome-ignore lint/suspicious/noExplicitAny: Pothos type inference issue with union types
      resolve: async (_parent, _args, context): Promise<any> => {
        if (!context.user) {
          return createAuthErrorData(
            "UNAUTHENTICATED",
            "認証が必要です",
            null,
            false,
          );
        }

        const result = await authService.getCurrentUser(context.user.uid);

        if (!result.success) {
          return mapLoginErrorToAuthErrorData(result.error);
        }

        return result.data;
      },
    }),
  }));
}
