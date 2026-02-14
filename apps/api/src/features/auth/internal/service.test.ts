import { beforeEach, describe, expect, it, vi } from "vitest";
import type { User } from "../../../db/schema/users.js";
import type { LoggerService } from "../../../logger/index.js";
import type { UserService } from "../../users/index.js";
import type { AuthService, FirebaseAuth } from "./service.js";
import {
  createAuthService,
  mapFirebaseError,
  validatePassword,
} from "./service.js";

function createMockUserService(): UserService {
  return {
    getUserById: vi.fn(),
    getUserByHandle: vi.fn(),
    createUser: vi.fn(),
    getUsers: vi.fn(),
    getUserByFirebaseUid: vi.fn(),
    createUserWithFirebase: vi.fn(),
    updateProfile: vi.fn(),
    deleteAccount: vi.fn(),
  };
}

function createMockLogger(): LoggerService {
  return {
    debug: vi.fn(),
    info: vi.fn(),
    warn: vi.fn(),
    error: vi.fn(),
    child: vi.fn().mockReturnThis(),
  };
}

describe("validatePassword", () => {
  it("should return ok when password is 8 characters or more", () => {
    const result = validatePassword("password");
    expect(result.success).toBe(true);
  });

  it("should return ok when password is exactly 8 characters", () => {
    const result = validatePassword("12345678");
    expect(result.success).toBe(true);
  });

  it("should return ok when password is longer than 8 characters", () => {
    const result = validatePassword("longpassword123");
    expect(result.success).toBe(true);
  });

  it("should return error when password is less than 8 characters", () => {
    const result = validatePassword("short");
    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error.code).toBe("INVALID_PASSWORD");
      expect(result.error.requirements).toContain("8文字以上");
    }
  });

  it("should return error when password is empty", () => {
    const result = validatePassword("");
    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error.code).toBe("INVALID_PASSWORD");
    }
  });

  it("should return error when password is 7 characters", () => {
    const result = validatePassword("1234567");
    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error.code).toBe("INVALID_PASSWORD");
    }
  });
});

describe("mapFirebaseError", () => {
  it("should map auth/email-already-exists to EMAIL_ALREADY_EXISTS", () => {
    const firebaseError = { code: "auth/email-already-exists" };
    const result = mapFirebaseError(firebaseError);

    expect(result.code).toBe("EMAIL_ALREADY_EXISTS");
    expect(result.message).toBe("このメールアドレスは既に使用されています");
  });

  it("should map auth/invalid-password to INVALID_PASSWORD", () => {
    const firebaseError = { code: "auth/invalid-password" };
    const result = mapFirebaseError(firebaseError);

    expect(result.code).toBe("INVALID_PASSWORD");
  });

  it("should map auth/weak-password to INVALID_PASSWORD", () => {
    const firebaseError = { code: "auth/weak-password" };
    const result = mapFirebaseError(firebaseError);

    expect(result.code).toBe("INVALID_PASSWORD");
    expect(result.message).toBe("パスワードは8文字以上で入力してください");
  });

  it("should map auth/internal-error to INTERNAL_ERROR", () => {
    const firebaseError = { code: "auth/internal-error" };
    const result = mapFirebaseError(firebaseError);

    expect(result.code).toBe("INTERNAL_ERROR");
    expect(result.message).toBe("予期しないエラーが発生しました");
  });

  it("should map auth/network-request-failed to NETWORK_ERROR", () => {
    const firebaseError = { code: "auth/network-request-failed" };
    const result = mapFirebaseError(firebaseError);

    expect(result.code).toBe("NETWORK_ERROR");
    expect(result.message).toBe("ネットワークエラーが発生しました");
    if (result.code === "NETWORK_ERROR") {
      expect(result.retryable).toBe(true);
    }
  });

  it("should map unknown error to FIREBASE_ERROR", () => {
    const firebaseError = { code: "auth/unknown-error" };
    const result = mapFirebaseError(firebaseError);

    expect(result.code).toBe("FIREBASE_ERROR");
    if (result.code === "FIREBASE_ERROR") {
      expect(result.originalCode).toBe("auth/unknown-error");
    }
  });
});

function createMockFirebaseAuth(): FirebaseAuth {
  return {
    createUser: vi.fn(),
    signIn: vi.fn(),
    refreshToken: vi.fn(),
    changePassword: vi.fn(),
    sendPasswordResetEmail: vi.fn(),
    deleteUser: vi.fn(),
  };
}

describe("AuthService.register", () => {
  let mockFirebaseAuth: FirebaseAuth;
  let mockUserService: UserService;
  let mockLogger: LoggerService;
  let authService: AuthService;

  beforeEach(() => {
    mockFirebaseAuth = createMockFirebaseAuth();
    mockUserService = createMockUserService();
    mockLogger = createMockLogger();
    authService = createAuthService({
      firebaseAuth: mockFirebaseAuth,
      userService: mockUserService,
      logger: mockLogger,
    });
  });

  it("should register user successfully", async () => {
    const mockUser: User = {
      id: 1,
      email: "test@example.com",
      firebaseUid: "firebase-uid-123",
      name: null,
      avatarUrl: null,
      bio: null,
      instagramHandle: null,
      handle: null,
      createdAt: new Date(),
      updatedAt: new Date(),
    };

    vi.mocked(mockFirebaseAuth.createUser).mockResolvedValue({
      uid: "firebase-uid-123",
      emailVerified: false,
    });
    vi.mocked(mockFirebaseAuth.signIn).mockResolvedValue({
      uid: "firebase-uid-123",
      idToken: "test-id-token",
      refreshToken: "test-refresh-token",
    });
    vi.mocked(mockUserService.createUserWithFirebase).mockResolvedValue({
      success: true,
      data: mockUser,
    });

    const result = await authService.register({
      email: "test@example.com",
      password: "password123",
    });

    expect(result.success).toBe(true);
    if (result.success) {
      expect(result.data.user.email).toBe("test@example.com");
      expect(result.data.firebaseUid).toBe("firebase-uid-123");
      expect(result.data.emailVerified).toBe(false);
      expect(result.data.idToken).toBe("test-id-token");
      expect(result.data.refreshToken).toBe("test-refresh-token");
    }
    expect(mockFirebaseAuth.createUser).toHaveBeenCalledWith(
      "test@example.com",
      "password123",
    );
    expect(mockFirebaseAuth.signIn).toHaveBeenCalledWith(
      "test@example.com",
      "password123",
    );
    expect(mockUserService.createUserWithFirebase).toHaveBeenCalledWith({
      email: "test@example.com",
      firebaseUid: "firebase-uid-123",
    });
  });

  it("should return error when password is too short", async () => {
    const result = await authService.register({
      email: "test@example.com",
      password: "short",
    });

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error.code).toBe("INVALID_PASSWORD");
    }
    expect(mockFirebaseAuth.createUser).not.toHaveBeenCalled();
  });

  it("should return error when email already exists in Firebase", async () => {
    vi.mocked(mockFirebaseAuth.createUser).mockRejectedValue({
      code: "auth/email-already-exists",
    });

    const result = await authService.register({
      email: "existing@example.com",
      password: "password123",
    });

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error.code).toBe("EMAIL_ALREADY_EXISTS");
    }
  });

  it("should return error when email already exists in local database", async () => {
    vi.mocked(mockFirebaseAuth.createUser).mockResolvedValue({
      uid: "firebase-uid-123",
      emailVerified: false,
    });
    vi.mocked(mockUserService.createUserWithFirebase).mockResolvedValue({
      success: false,
      error: {
        code: "EMAIL_ALREADY_EXISTS",
        message: "Email already exists",
      },
    });

    const result = await authService.register({
      email: "existing@example.com",
      password: "password123",
    });

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error.code).toBe("EMAIL_ALREADY_EXISTS");
    }
  });

  it("should handle network error from Firebase", async () => {
    vi.mocked(mockFirebaseAuth.createUser).mockRejectedValue({
      code: "auth/network-request-failed",
    });

    const result = await authService.register({
      email: "test@example.com",
      password: "password123",
    });

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error.code).toBe("NETWORK_ERROR");
      if (result.error.code === "NETWORK_ERROR") {
        expect(result.error.retryable).toBe(true);
      }
    }
  });

  it("should log successful registration", async () => {
    const mockUser: User = {
      id: 1,
      email: "test@example.com",
      firebaseUid: "firebase-uid-123",
      name: null,
      avatarUrl: null,
      bio: null,
      instagramHandle: null,
      handle: null,
      createdAt: new Date(),
      updatedAt: new Date(),
    };

    vi.mocked(mockFirebaseAuth.createUser).mockResolvedValue({
      uid: "firebase-uid-123",
      emailVerified: false,
    });
    vi.mocked(mockFirebaseAuth.signIn).mockResolvedValue({
      uid: "firebase-uid-123",
      idToken: "test-id-token",
      refreshToken: "test-refresh-token",
    });
    vi.mocked(mockUserService.createUserWithFirebase).mockResolvedValue({
      success: true,
      data: mockUser,
    });

    await authService.register({
      email: "test@example.com",
      password: "password123",
    });

    expect(mockLogger.info).toHaveBeenCalledWith(
      "User registered successfully",
      expect.objectContaining({ feature: "auth", userId: "1" }),
    );
  });
});

describe("AuthService.getCurrentUser", () => {
  let mockFirebaseAuth: FirebaseAuth;
  let mockUserService: UserService;
  let mockLogger: LoggerService;
  let authService: AuthService;

  beforeEach(() => {
    mockFirebaseAuth = createMockFirebaseAuth();
    mockUserService = createMockUserService();
    mockLogger = createMockLogger();
    authService = createAuthService({
      firebaseAuth: mockFirebaseAuth,
      userService: mockUserService,
      logger: mockLogger,
    });
  });

  it("should return user when user exists", async () => {
    const mockUser: User = {
      id: 1,
      email: "test@example.com",
      firebaseUid: "firebase-uid-123",
      name: null,
      avatarUrl: null,
      bio: null,
      instagramHandle: null,
      handle: null,
      createdAt: new Date(),
      updatedAt: new Date(),
    };

    vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue({
      success: true,
      data: mockUser,
    });

    const result = await authService.getCurrentUser("firebase-uid-123");

    expect(result.success).toBe(true);
    if (result.success) {
      expect(result.data.id).toBe(1);
      expect(result.data.email).toBe("test@example.com");
      expect(result.data.firebaseUid).toBe("firebase-uid-123");
    }
    expect(mockUserService.getUserByFirebaseUid).toHaveBeenCalledWith(
      "firebase-uid-123",
    );
  });

  it("should return USER_NOT_FOUND when user does not exist", async () => {
    vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue({
      success: false,
      error: {
        code: "USER_NOT_FOUND",
        message: "User with Firebase UID firebase-uid-123 not found",
      },
    });

    const result = await authService.getCurrentUser("firebase-uid-123");

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error.code).toBe("USER_NOT_FOUND");
    }
  });

  it("should log when getting current user", async () => {
    const mockUser: User = {
      id: 1,
      email: "test@example.com",
      firebaseUid: "firebase-uid-123",
      name: null,
      avatarUrl: null,
      bio: null,
      instagramHandle: null,
      handle: null,
      createdAt: new Date(),
      updatedAt: new Date(),
    };

    vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue({
      success: true,
      data: mockUser,
    });

    await authService.getCurrentUser("firebase-uid-123");

    expect(mockLogger.info).toHaveBeenCalledWith(
      "Getting current user",
      expect.objectContaining({
        feature: "auth",
        firebaseUid: "firebase-uid-123",
      }),
    );
  });

  it("should log success when user is found", async () => {
    const mockUser: User = {
      id: 1,
      email: "test@example.com",
      firebaseUid: "firebase-uid-123",
      name: null,
      avatarUrl: null,
      bio: null,
      instagramHandle: null,
      handle: null,
      createdAt: new Date(),
      updatedAt: new Date(),
    };

    vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue({
      success: true,
      data: mockUser,
    });

    await authService.getCurrentUser("firebase-uid-123");

    expect(mockLogger.info).toHaveBeenCalledWith(
      "Current user retrieved successfully",
      expect.objectContaining({
        feature: "auth",
        userId: "1",
      }),
    );
  });

  it("should log warning when user is not found", async () => {
    vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue({
      success: false,
      error: {
        code: "USER_NOT_FOUND",
        message: "User not found",
      },
    });

    await authService.getCurrentUser("firebase-uid-123");

    expect(mockLogger.warn).toHaveBeenCalledWith(
      "User not found for Firebase UID",
      expect.objectContaining({
        feature: "auth",
        firebaseUid: "firebase-uid-123",
      }),
    );
  });

  it("should not log the ID token itself", async () => {
    const mockUser: User = {
      id: 1,
      email: "test@example.com",
      firebaseUid: "firebase-uid-123",
      name: null,
      avatarUrl: null,
      bio: null,
      instagramHandle: null,
      handle: null,
      createdAt: new Date(),
      updatedAt: new Date(),
    };

    vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue({
      success: true,
      data: mockUser,
    });

    await authService.getCurrentUser("firebase-uid-123");

    for (const call of vi.mocked(mockLogger.info).mock.calls) {
      const logData = call[1] as Record<string, unknown>;
      expect(logData).not.toHaveProperty("token");
      expect(logData).not.toHaveProperty("idToken");
    }
  });
});

describe("AuthService.login", () => {
  let mockFirebaseAuth: FirebaseAuth;
  let mockUserService: UserService;
  let mockLogger: LoggerService;
  let authService: AuthService;

  beforeEach(() => {
    mockFirebaseAuth = createMockFirebaseAuth();
    mockUserService = createMockUserService();
    mockLogger = createMockLogger();
    authService = createAuthService({
      firebaseAuth: mockFirebaseAuth,
      userService: mockUserService,
      logger: mockLogger,
    });
  });

  it("should login user successfully and return user with idToken and refreshToken", async () => {
    const mockUser: User = {
      id: 1,
      email: "test@example.com",
      firebaseUid: "firebase-uid-123",
      name: null,
      avatarUrl: null,
      bio: null,
      instagramHandle: null,
      handle: null,
      createdAt: new Date(),
      updatedAt: new Date(),
    };

    vi.mocked(mockFirebaseAuth.signIn).mockResolvedValue({
      uid: "firebase-uid-123",
      idToken: "mock-id-token",
      refreshToken: "mock-refresh-token",
    });
    vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue({
      success: true,
      data: mockUser,
    });

    const result = await authService.login({
      email: "test@example.com",
      password: "password123",
    });

    expect(result.success).toBe(true);
    if (result.success) {
      expect(result.data.user.email).toBe("test@example.com");
      expect(result.data.idToken).toBe("mock-id-token");
      expect(result.data.refreshToken).toBe("mock-refresh-token");
    }
    expect(mockFirebaseAuth.signIn).toHaveBeenCalledWith(
      "test@example.com",
      "password123",
    );
    expect(mockUserService.getUserByFirebaseUid).toHaveBeenCalledWith(
      "firebase-uid-123",
    );
  });

  it("should return INVALID_CREDENTIALS when email/password is wrong", async () => {
    vi.mocked(mockFirebaseAuth.signIn).mockRejectedValue({
      code: "auth/invalid-credential",
    });

    const result = await authService.login({
      email: "test@example.com",
      password: "wrong-password",
    });

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error.code).toBe("INVALID_CREDENTIALS");
    }
  });

  it("should return INVALID_CREDENTIALS when user does not exist in Firebase", async () => {
    vi.mocked(mockFirebaseAuth.signIn).mockRejectedValue({
      code: "auth/user-not-found",
    });

    const result = await authService.login({
      email: "nonexistent@example.com",
      password: "password123",
    });

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error.code).toBe("INVALID_CREDENTIALS");
    }
  });

  it("should return USER_NOT_FOUND when user exists in Firebase but not in local DB", async () => {
    vi.mocked(mockFirebaseAuth.signIn).mockResolvedValue({
      uid: "firebase-uid-123",
      idToken: "mock-id-token",
      refreshToken: "mock-refresh-token",
    });
    vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue({
      success: false,
      error: {
        code: "USER_NOT_FOUND",
        message: "User not found",
      },
    });

    const result = await authService.login({
      email: "test@example.com",
      password: "password123",
    });

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error.code).toBe("USER_NOT_FOUND");
    }
  });

  it("should handle network error from Firebase", async () => {
    vi.mocked(mockFirebaseAuth.signIn).mockRejectedValue({
      code: "auth/network-request-failed",
    });

    const result = await authService.login({
      email: "test@example.com",
      password: "password123",
    });

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error.code).toBe("NETWORK_ERROR");
      if (result.error.code === "NETWORK_ERROR") {
        expect(result.error.retryable).toBe(true);
      }
    }
  });

  it("should log successful login", async () => {
    const mockUser: User = {
      id: 1,
      email: "test@example.com",
      firebaseUid: "firebase-uid-123",
      name: null,
      avatarUrl: null,
      bio: null,
      instagramHandle: null,
      handle: null,
      createdAt: new Date(),
      updatedAt: new Date(),
    };

    vi.mocked(mockFirebaseAuth.signIn).mockResolvedValue({
      uid: "firebase-uid-123",
      idToken: "mock-id-token",
      refreshToken: "mock-refresh-token",
    });
    vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue({
      success: true,
      data: mockUser,
    });

    await authService.login({
      email: "test@example.com",
      password: "password123",
    });

    expect(mockLogger.info).toHaveBeenCalledWith(
      "User logged in successfully",
      expect.objectContaining({ feature: "auth", userId: "1" }),
    );
  });

  it("should not log password in logs", async () => {
    vi.mocked(mockFirebaseAuth.signIn).mockRejectedValue({
      code: "auth/invalid-credential",
    });

    await authService.login({
      email: "test@example.com",
      password: "secret-password",
    });

    for (const call of [
      ...vi.mocked(mockLogger.info).mock.calls,
      ...vi.mocked(mockLogger.warn).mock.calls,
      ...vi.mocked(mockLogger.error).mock.calls,
    ]) {
      const logData = call[1] as Record<string, unknown>;
      expect(logData).not.toHaveProperty("password");
      expect(JSON.stringify(logData)).not.toContain("secret-password");
    }
  });
});

describe("AuthService.refreshToken", () => {
  let mockFirebaseAuth: FirebaseAuth;
  let mockUserService: UserService;
  let mockLogger: LoggerService;
  let authService: AuthService;

  beforeEach(() => {
    mockFirebaseAuth = createMockFirebaseAuth();
    mockUserService = createMockUserService();
    mockLogger = createMockLogger();
    authService = createAuthService({
      firebaseAuth: mockFirebaseAuth,
      userService: mockUserService,
      logger: mockLogger,
    });
  });

  it("should refresh token successfully and return new idToken and refreshToken", async () => {
    vi.mocked(mockFirebaseAuth.refreshToken).mockResolvedValue({
      idToken: "new-id-token",
      refreshToken: "new-refresh-token",
    });

    const result = await authService.refreshToken("old-refresh-token");

    expect(result.success).toBe(true);
    if (result.success) {
      expect(result.data.idToken).toBe("new-id-token");
      expect(result.data.refreshToken).toBe("new-refresh-token");
    }
    expect(mockFirebaseAuth.refreshToken).toHaveBeenCalledWith(
      "old-refresh-token",
    );
  });

  it("should return error when refresh token is invalid", async () => {
    vi.mocked(mockFirebaseAuth.refreshToken).mockRejectedValue({
      code: "auth/invalid-refresh-token",
    });

    const result = await authService.refreshToken("invalid-refresh-token");

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error.code).toBe("INVALID_TOKEN");
    }
  });

  it("should return error when refresh token is expired", async () => {
    vi.mocked(mockFirebaseAuth.refreshToken).mockRejectedValue({
      code: "auth/token-expired",
    });

    const result = await authService.refreshToken("expired-refresh-token");

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error.code).toBe("TOKEN_EXPIRED");
    }
  });

  it("should handle network error", async () => {
    vi.mocked(mockFirebaseAuth.refreshToken).mockRejectedValue({
      code: "auth/network-request-failed",
    });

    const result = await authService.refreshToken("refresh-token");

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error.code).toBe("NETWORK_ERROR");
      if (result.error.code === "NETWORK_ERROR") {
        expect(result.error.retryable).toBe(true);
      }
    }
  });
});

describe("AuthService.changePassword", () => {
  let mockFirebaseAuth: FirebaseAuth;
  let mockUserService: UserService;
  let mockLogger: LoggerService;
  let authService: AuthService;

  beforeEach(() => {
    mockFirebaseAuth = createMockFirebaseAuth();
    mockUserService = createMockUserService();
    mockLogger = createMockLogger();
    authService = createAuthService({
      firebaseAuth: mockFirebaseAuth,
      userService: mockUserService,
      logger: mockLogger,
    });
  });

  it("should change password successfully and return new tokens", async () => {
    vi.mocked(mockFirebaseAuth.signIn).mockResolvedValue({
      uid: "firebase-uid-123",
      idToken: "current-id-token",
      refreshToken: "current-refresh-token",
    });
    vi.mocked(mockFirebaseAuth.changePassword).mockResolvedValue({
      idToken: "new-id-token",
      refreshToken: "new-refresh-token",
    });

    const result = await authService.changePassword({
      email: "test@example.com",
      currentPassword: "oldPassword123",
      newPassword: "newPassword123",
    });

    expect(result.success).toBe(true);
    if (result.success) {
      expect(result.data.idToken).toBe("new-id-token");
      expect(result.data.refreshToken).toBe("new-refresh-token");
    }
    expect(mockFirebaseAuth.signIn).toHaveBeenCalledWith(
      "test@example.com",
      "oldPassword123",
    );
    expect(mockFirebaseAuth.changePassword).toHaveBeenCalledWith(
      "current-id-token",
      "newPassword123",
    );
  });

  it("should return INVALID_CREDENTIALS when current password is wrong", async () => {
    vi.mocked(mockFirebaseAuth.signIn).mockRejectedValue({
      code: "auth/invalid-credential",
    });

    const result = await authService.changePassword({
      email: "test@example.com",
      currentPassword: "wrongPassword",
      newPassword: "newPassword123",
    });

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error.code).toBe("INVALID_CREDENTIALS");
    }
    expect(mockFirebaseAuth.changePassword).not.toHaveBeenCalled();
  });

  it("should return WEAK_PASSWORD when new password is too weak", async () => {
    vi.mocked(mockFirebaseAuth.signIn).mockResolvedValue({
      uid: "firebase-uid-123",
      idToken: "current-id-token",
      refreshToken: "current-refresh-token",
    });
    vi.mocked(mockFirebaseAuth.changePassword).mockRejectedValue({
      code: "auth/weak-password",
    });

    const result = await authService.changePassword({
      email: "test@example.com",
      currentPassword: "oldPassword123",
      newPassword: "weak",
    });

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error.code).toBe("WEAK_PASSWORD");
    }
  });

  it("should handle network error", async () => {
    vi.mocked(mockFirebaseAuth.signIn).mockRejectedValue({
      code: "auth/network-request-failed",
    });

    const result = await authService.changePassword({
      email: "test@example.com",
      currentPassword: "oldPassword",
      newPassword: "newPassword123",
    });

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error.code).toBe("NETWORK_ERROR");
      if (result.error.code === "NETWORK_ERROR") {
        expect(result.error.retryable).toBe(true);
      }
    }
  });

  it("should log password change attempt", async () => {
    vi.mocked(mockFirebaseAuth.signIn).mockResolvedValue({
      uid: "firebase-uid-123",
      idToken: "current-id-token",
      refreshToken: "current-refresh-token",
    });
    vi.mocked(mockFirebaseAuth.changePassword).mockResolvedValue({
      idToken: "new-id-token",
      refreshToken: "new-refresh-token",
    });

    await authService.changePassword({
      email: "test@example.com",
      currentPassword: "oldPassword123",
      newPassword: "newPassword123",
    });

    expect(mockLogger.info).toHaveBeenCalledWith(
      "Password change attempt",
      expect.objectContaining({
        feature: "auth",
        email: "test@example.com",
      }),
    );
  });

  it("should not log passwords in logs", async () => {
    vi.mocked(mockFirebaseAuth.signIn).mockResolvedValue({
      uid: "firebase-uid-123",
      idToken: "current-id-token",
      refreshToken: "current-refresh-token",
    });
    vi.mocked(mockFirebaseAuth.changePassword).mockResolvedValue({
      idToken: "new-id-token",
      refreshToken: "new-refresh-token",
    });

    await authService.changePassword({
      email: "test@example.com",
      currentPassword: "secretOldPassword",
      newPassword: "secretNewPassword",
    });

    for (const call of [
      ...vi.mocked(mockLogger.info).mock.calls,
      ...vi.mocked(mockLogger.warn).mock.calls,
      ...vi.mocked(mockLogger.error).mock.calls,
    ]) {
      const logData = call[1] as Record<string, unknown>;
      expect(logData).not.toHaveProperty("currentPassword");
      expect(logData).not.toHaveProperty("newPassword");
      expect(JSON.stringify(logData)).not.toContain("secretOldPassword");
      expect(JSON.stringify(logData)).not.toContain("secretNewPassword");
    }
  });
});

describe("AuthService.sendPasswordResetEmail", () => {
  let mockFirebaseAuth: FirebaseAuth;
  let mockUserService: UserService;
  let mockLogger: LoggerService;
  let authService: AuthService;

  beforeEach(() => {
    mockFirebaseAuth = createMockFirebaseAuth();
    mockUserService = createMockUserService();
    mockLogger = createMockLogger();
    authService = createAuthService({
      firebaseAuth: mockFirebaseAuth,
      userService: mockUserService,
      logger: mockLogger,
    });
  });

  it("should send password reset email successfully", async () => {
    vi.mocked(mockFirebaseAuth.sendPasswordResetEmail).mockResolvedValue(
      undefined,
    );

    const result = await authService.sendPasswordResetEmail({
      email: "test@example.com",
    });

    expect(result.success).toBe(true);
    expect(mockFirebaseAuth.sendPasswordResetEmail).toHaveBeenCalledWith(
      "test@example.com",
    );
  });

  it("should return USER_NOT_FOUND when email does not exist", async () => {
    vi.mocked(mockFirebaseAuth.sendPasswordResetEmail).mockRejectedValue({
      code: "auth/user-not-found",
    });

    const result = await authService.sendPasswordResetEmail({
      email: "nonexistent@example.com",
    });

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error.code).toBe("USER_NOT_FOUND");
    }
  });

  it("should return INVALID_EMAIL when email format is invalid", async () => {
    vi.mocked(mockFirebaseAuth.sendPasswordResetEmail).mockRejectedValue({
      code: "auth/invalid-email",
    });

    const result = await authService.sendPasswordResetEmail({
      email: "invalid-email",
    });

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error.code).toBe("INVALID_EMAIL");
    }
  });

  it("should handle network error", async () => {
    vi.mocked(mockFirebaseAuth.sendPasswordResetEmail).mockRejectedValue({
      code: "auth/network-request-failed",
    });

    const result = await authService.sendPasswordResetEmail({
      email: "test@example.com",
    });

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error.code).toBe("NETWORK_ERROR");
      if (result.error.code === "NETWORK_ERROR") {
        expect(result.error.retryable).toBe(true);
      }
    }
  });

  it("should log password reset email attempt", async () => {
    vi.mocked(mockFirebaseAuth.sendPasswordResetEmail).mockResolvedValue(
      undefined,
    );

    await authService.sendPasswordResetEmail({
      email: "test@example.com",
    });

    expect(mockLogger.info).toHaveBeenCalledWith(
      "Password reset email attempt",
      expect.objectContaining({
        feature: "auth",
        email: "test@example.com",
      }),
    );
  });

  it("should log success when email is sent", async () => {
    vi.mocked(mockFirebaseAuth.sendPasswordResetEmail).mockResolvedValue(
      undefined,
    );

    await authService.sendPasswordResetEmail({
      email: "test@example.com",
    });

    expect(mockLogger.info).toHaveBeenCalledWith(
      "Password reset email sent successfully",
      expect.objectContaining({
        feature: "auth",
      }),
    );
  });
});

describe("AuthService.deleteAccount", () => {
  let mockFirebaseAuth: FirebaseAuth;
  let mockUserService: UserService;
  let mockLogger: LoggerService;
  let authService: AuthService;

  beforeEach(() => {
    mockFirebaseAuth = createMockFirebaseAuth();
    mockUserService = createMockUserService();
    mockLogger = createMockLogger();
    authService = createAuthService({
      firebaseAuth: mockFirebaseAuth,
      userService: mockUserService,
      logger: mockLogger,
    });
  });

  it("should delete account successfully", async () => {
    const mockUser: User = {
      id: 1,
      email: "test@example.com",
      firebaseUid: "firebase-uid-123",
      name: null,
      avatarUrl: null,
      bio: null,
      instagramHandle: null,
      handle: null,
      createdAt: new Date(),
      updatedAt: new Date(),
    };

    vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue({
      success: true,
      data: mockUser,
    });
    vi.mocked(mockUserService.deleteAccount).mockResolvedValue({
      success: true,
      data: undefined,
    });
    vi.mocked(mockFirebaseAuth.deleteUser).mockResolvedValue(undefined);

    const result = await authService.deleteAccount("firebase-uid-123");

    expect(result.success).toBe(true);
    expect(mockUserService.deleteAccount).toHaveBeenCalledWith({ id: 1 });
    expect(mockFirebaseAuth.deleteUser).toHaveBeenCalledWith(
      "firebase-uid-123",
    );
  });

  it("should return USER_NOT_FOUND when user does not exist", async () => {
    vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue({
      success: false,
      error: {
        code: "USER_NOT_FOUND",
        message: "User not found",
      },
    });

    const result = await authService.deleteAccount("non-existent-uid");

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error.code).toBe("USER_NOT_FOUND");
    }
    expect(mockUserService.deleteAccount).not.toHaveBeenCalled();
    expect(mockFirebaseAuth.deleteUser).not.toHaveBeenCalled();
  });

  it("should return INTERNAL_ERROR when Firebase deleteUser fails", async () => {
    const mockUser: User = {
      id: 1,
      email: "test@example.com",
      firebaseUid: "firebase-uid-123",
      name: null,
      avatarUrl: null,
      bio: null,
      instagramHandle: null,
      handle: null,
      createdAt: new Date(),
      updatedAt: new Date(),
    };

    vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue({
      success: true,
      data: mockUser,
    });
    vi.mocked(mockUserService.deleteAccount).mockResolvedValue({
      success: true,
      data: undefined,
    });
    vi.mocked(mockFirebaseAuth.deleteUser).mockRejectedValue({
      code: "auth/internal-error",
    });

    const result = await authService.deleteAccount("firebase-uid-123");

    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error.code).toBe("INTERNAL_ERROR");
    }
  });

  it("should log successful account deletion", async () => {
    const mockUser: User = {
      id: 1,
      email: "test@example.com",
      firebaseUid: "firebase-uid-123",
      name: null,
      avatarUrl: null,
      bio: null,
      instagramHandle: null,
      handle: null,
      createdAt: new Date(),
      updatedAt: new Date(),
    };

    vi.mocked(mockUserService.getUserByFirebaseUid).mockResolvedValue({
      success: true,
      data: mockUser,
    });
    vi.mocked(mockUserService.deleteAccount).mockResolvedValue({
      success: true,
      data: undefined,
    });
    vi.mocked(mockFirebaseAuth.deleteUser).mockResolvedValue(undefined);

    await authService.deleteAccount("firebase-uid-123");

    expect(mockLogger.info).toHaveBeenCalledWith(
      "Account deleted successfully",
      expect.objectContaining({
        feature: "auth",
        userId: "1",
      }),
    );
  });
});
