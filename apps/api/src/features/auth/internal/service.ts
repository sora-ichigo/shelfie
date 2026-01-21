import type { User } from "../../../db/schema/users.js";
import { err, ok, type Result } from "../../../errors/result.js";
import type { LoggerService } from "../../../logger/index.js";
import type { UserService } from "../../users/index.js";

export interface RegisterUserInput {
  email: string;
  password: string;
}

export interface RegisterUserOutput {
  user: User;
  firebaseUid: string;
  emailVerified: boolean;
}

export type AuthServiceError =
  | { code: "EMAIL_ALREADY_EXISTS"; message: string }
  | { code: "INVALID_PASSWORD"; message: string; requirements: string[] }
  | { code: "NETWORK_ERROR"; message: string; retryable: boolean }
  | { code: "FIREBASE_ERROR"; message: string; originalCode: string }
  | { code: "INTERNAL_ERROR"; message: string };

export type LoginServiceError =
  | { code: "USER_NOT_FOUND"; message: string }
  | { code: "INTERNAL_ERROR"; message: string };

export interface FirebaseAuth {
  createUser(
    email: string,
    password: string,
  ): Promise<{ uid: string; emailVerified: boolean }>;
}

export interface AuthService {
  register(
    input: RegisterUserInput,
  ): Promise<Result<RegisterUserOutput, AuthServiceError>>;
  getCurrentUser(firebaseUid: string): Promise<Result<User, LoginServiceError>>;
}

const MIN_PASSWORD_LENGTH = 8;

export function validatePassword(
  password: string,
): Result<void, Extract<AuthServiceError, { code: "INVALID_PASSWORD" }>> {
  if (password.length < MIN_PASSWORD_LENGTH) {
    return err({
      code: "INVALID_PASSWORD",
      message: `パスワードは${MIN_PASSWORD_LENGTH}文字以上で入力してください`,
      requirements: [`${MIN_PASSWORD_LENGTH}文字以上`],
    });
  }
  return ok(undefined);
}

export function mapFirebaseError(firebaseError: {
  code: string;
}): AuthServiceError {
  const { code } = firebaseError;

  switch (code) {
    case "auth/email-already-exists":
      return {
        code: "EMAIL_ALREADY_EXISTS",
        message: "このメールアドレスは既に使用されています",
      };
    case "auth/invalid-password":
      return {
        code: "INVALID_PASSWORD",
        message: "パスワードが無効です",
        requirements: [],
      };
    case "auth/weak-password":
      return {
        code: "INVALID_PASSWORD",
        message: "パスワードは8文字以上で入力してください",
        requirements: ["8文字以上"],
      };
    case "auth/internal-error":
      return {
        code: "INTERNAL_ERROR",
        message: "予期しないエラーが発生しました",
      };
    case "auth/network-request-failed":
      return {
        code: "NETWORK_ERROR",
        message: "ネットワークエラーが発生しました",
        retryable: true,
      };
    default:
      return {
        code: "FIREBASE_ERROR",
        message: "Firebase認証でエラーが発生しました",
        originalCode: code,
      };
  }
}

export interface AuthServiceDependencies {
  firebaseAuth: FirebaseAuth;
  userService: UserService;
  logger: LoggerService;
}

export function createAuthService(deps: AuthServiceDependencies): AuthService {
  const { firebaseAuth, userService, logger } = deps;

  return {
    async register(
      input: RegisterUserInput,
    ): Promise<Result<RegisterUserOutput, AuthServiceError>> {
      const passwordResult = validatePassword(input.password);
      if (!passwordResult.success) {
        return passwordResult as Result<RegisterUserOutput, AuthServiceError>;
      }

      let firebaseUser: { uid: string; emailVerified: boolean };
      try {
        firebaseUser = await firebaseAuth.createUser(
          input.email,
          input.password,
        );
      } catch (error) {
        const firebaseError = error as { code?: string };
        if (firebaseError.code) {
          logger.error("Firebase createUser failed", error as Error, {
            feature: "auth",
            errorCode: firebaseError.code,
          });
          return err(mapFirebaseError(firebaseError as { code: string }));
        }
        logger.error(
          "Unknown error during Firebase createUser",
          error as Error,
          {
            feature: "auth",
          },
        );
        return err({
          code: "INTERNAL_ERROR",
          message: "予期しないエラーが発生しました",
        });
      }

      const userResult = await userService.createUserWithFirebase({
        email: input.email,
        firebaseUid: firebaseUser.uid,
      });

      if (!userResult.success) {
        logger.error("Failed to create user in local database", undefined, {
          feature: "auth",
          firebaseUid: firebaseUser.uid,
          errorCode: userResult.error.code,
        });
        if (userResult.error.code === "EMAIL_ALREADY_EXISTS") {
          return err({
            code: "EMAIL_ALREADY_EXISTS",
            message: "このメールアドレスは既に使用されています",
          });
        }
        return err({
          code: "INTERNAL_ERROR",
          message: "ユーザー作成中にエラーが発生しました",
        });
      }

      logger.info("User registered successfully", {
        feature: "auth",
        userId: String(userResult.data.id),
      });

      return ok({
        user: userResult.data,
        firebaseUid: firebaseUser.uid,
        emailVerified: firebaseUser.emailVerified,
      });
    },

    async getCurrentUser(
      firebaseUid: string,
    ): Promise<Result<User, LoginServiceError>> {
      logger.info("Getting current user", {
        feature: "auth",
        firebaseUid,
      });

      const userResult = await userService.getUserByFirebaseUid(firebaseUid);

      if (!userResult.success) {
        logger.warn("User not found for Firebase UID", {
          feature: "auth",
          firebaseUid,
        });
        return err({
          code: "USER_NOT_FOUND",
          message: "ユーザーが見つかりません",
        });
      }

      logger.info("Current user retrieved successfully", {
        feature: "auth",
        userId: String(userResult.data.id),
      });

      return ok(userResult.data);
    },
  };
}
