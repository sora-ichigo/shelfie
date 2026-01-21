import type { User } from "../../../db/schema/users.js";
import type { Builder } from "../../../graphql/builder.js";
import { UserRef } from "../../users/internal/graphql.js";
import type {
  AuthService,
  AuthServiceError,
  LoginServiceError,
} from "./service.js";

export const LOGIN_ERROR_CODES = [
  "INVALID_TOKEN",
  "TOKEN_EXPIRED",
  "USER_NOT_FOUND",
  "UNAUTHENTICATED",
] as const;

export type LoginErrorCode = (typeof LOGIN_ERROR_CODES)[number];

export const AUTH_ERROR_CODES = [
  "EMAIL_ALREADY_EXISTS",
  "INVALID_PASSWORD",
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

let AuthErrorCodeEnumRef: ReturnType<Builder["enumType"]> | null = null;
let RegisterUserInputRef: RegisterUserInputRef | null = null;

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
}

export { AuthErrorDataRef };

export function registerAuthMutations(
  builder: Builder,
  authService: AuthService,
): void {
  builder.mutationType({
    fields: (t) => ({
      registerUser: t.field({
        type: UserRef,
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
        resolve: async (_parent, { input }): Promise<User> => {
          const result = await authService.register({
            email: input.email,
            password: input.password,
          });

          if (!result.success) {
            throw mapServiceErrorToAuthError(result.error);
          }

          return result.data.user;
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
