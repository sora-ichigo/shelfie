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
    createUser: vi.fn(),
    getUsers: vi.fn(),
    getUserByFirebaseUid: vi.fn(),
    createUserWithFirebase: vi.fn(),
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
      createdAt: new Date(),
      updatedAt: new Date(),
    };

    vi.mocked(mockFirebaseAuth.createUser).mockResolvedValue({
      uid: "firebase-uid-123",
      emailVerified: false,
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
    }
    expect(mockFirebaseAuth.createUser).toHaveBeenCalledWith(
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
      createdAt: new Date(),
      updatedAt: new Date(),
    };

    vi.mocked(mockFirebaseAuth.createUser).mockResolvedValue({
      uid: "firebase-uid-123",
      emailVerified: false,
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
