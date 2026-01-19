import type { User } from "../../db/schema/users.js";
import type { Builder } from "../../graphql/builder.js";
import type { AuthService, AuthServiceError } from "./service.js";
import { UserRef } from "../users/types.js";

export const AUTH_ERROR_CODES = [
  "EMAIL_ALREADY_EXISTS",
  "INVALID_PASSWORD",
  "USER_NOT_FOUND",
  "EMAIL_ALREADY_VERIFIED",
  "RATE_LIMIT_EXCEEDED",
  "NETWORK_ERROR",
  "INTERNAL_ERROR",
] as const;

export type AuthErrorCode = (typeof AUTH_ERROR_CODES)[number];

export class AuthError extends Error {
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
}

function mapErrorCodeToField(code: string): string | null {
  switch (code) {
    case "EMAIL_ALREADY_EXISTS":
    case "USER_NOT_FOUND":
    case "EMAIL_ALREADY_VERIFIED":
      return "email";
    case "INVALID_PASSWORD":
      return "password";
    default:
      return null;
  }
}

function isRetryableError(code: string): boolean {
  return code === "NETWORK_ERROR" || code === "RATE_LIMIT_EXCEEDED";
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

function createRegisterUserInputRef(builder: Builder) {
  return builder.inputRef<{ email: string; password: string }>("RegisterUserInput");
}

function createResendVerificationEmailInputRef(builder: Builder) {
  return builder.inputRef<{ email: string }>("ResendVerificationEmailInput");
}

type RegisterUserInputRef = ReturnType<typeof createRegisterUserInputRef>;
type ResendVerificationEmailInputRef = ReturnType<typeof createResendVerificationEmailInputRef>;

let AuthErrorCodeEnumRef: ReturnType<Builder["enumType"]> | null = null;
let RegisterUserInputRef: RegisterUserInputRef | null = null;
let ResendVerificationEmailInputRef: ResendVerificationEmailInputRef | null = null;

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

  RegisterUserInputRef = createRegisterUserInputRef(builder);
  RegisterUserInputRef.implement({
    description: "Input for user registration",
    fields: (t) => ({
      email: t.string({ required: true, description: "Email address" }),
      password: t.string({ required: true, description: "Password" }),
    }),
  });

  ResendVerificationEmailInputRef = createResendVerificationEmailInputRef(builder);
  ResendVerificationEmailInputRef.implement({
    description: "Input for resending verification email",
    fields: (t) => ({
      email: t.string({ required: true, description: "Email address" }),
    }),
  });
}

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
      resendVerificationEmail: t.boolean({
        description: "Resend verification email to a user",
        errors: {
          types: [AuthError],
        },
        args: {
          input: t.arg({
            type: ResendVerificationEmailInputRef!,
            required: true,
          }),
        },
        resolve: async (_parent, { input }): Promise<boolean> => {
          const result = await authService.resendVerificationEmail({
            email: input.email,
          });

          if (!result.success) {
            throw mapServiceErrorToAuthError(result.error);
          }

          return result.data.success;
        },
      }),
    }),
  });
}
