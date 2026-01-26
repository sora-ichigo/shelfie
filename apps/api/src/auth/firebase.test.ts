import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import {
  type FirebaseAuthConfig,
  createFirebaseAuthAdapter,
  getFirebaseAuthConfig,
  initializeFirebaseAuth,
} from "./firebase";

describe("Firebase Auth", () => {
  const originalEnv = process.env;

  beforeEach(() => {
    process.env = { ...originalEnv };
  });

  afterEach(() => {
    process.env = originalEnv;
  });

  describe("getFirebaseAuthConfig", () => {
    it("環境変数から Firebase 設定を読み取る", () => {
      process.env.FIREBASE_PROJECT_ID = "test-project";
      process.env.FIREBASE_CLIENT_EMAIL =
        "test@example.iam.gserviceaccount.com";
      process.env.FIREBASE_PRIVATE_KEY =
        "-----BEGIN PRIVATE KEY-----\ntest\n-----END PRIVATE KEY-----";

      const config = getFirebaseAuthConfig();

      expect(config).toEqual({
        projectId: "test-project",
        clientEmail: "test@example.iam.gserviceaccount.com",
        privateKey:
          "-----BEGIN PRIVATE KEY-----\ntest\n-----END PRIVATE KEY-----",
      });
    });

    it("FIREBASE_PROJECT_ID が未設定の場合は undefined を返す", () => {
      delete process.env.FIREBASE_PROJECT_ID;
      const config = getFirebaseAuthConfig();
      expect(config).toBeUndefined();
    });

    it("privateKey のエスケープされた改行を変換する", () => {
      process.env.FIREBASE_PROJECT_ID = "test-project";
      process.env.FIREBASE_CLIENT_EMAIL =
        "test@example.iam.gserviceaccount.com";
      process.env.FIREBASE_PRIVATE_KEY =
        "-----BEGIN PRIVATE KEY-----\\ntest\\n-----END PRIVATE KEY-----";

      const config = getFirebaseAuthConfig();

      expect(config?.privateKey).toBe(
        "-----BEGIN PRIVATE KEY-----\ntest\n-----END PRIVATE KEY-----",
      );
    });
  });

  describe("initializeFirebaseAuth", () => {
    it("設定なしの場合は initialized: true を返す（Application Default Credentials を使用）", () => {
      const result = initializeFirebaseAuth();
      expect(result.initialized).toBe(true);
    });

    it("FirebaseAuthConfig の型が正しいことを確認", () => {
      const config: FirebaseAuthConfig = {
        projectId: "test-project",
        clientEmail: "test@example.iam.gserviceaccount.com",
        privateKey: "test-key",
      };
      expect(config.projectId).toBe("test-project");
      expect(config.clientEmail).toBe("test@example.iam.gserviceaccount.com");
      expect(config.privateKey).toBe("test-key");
    });

    it("既に初期化済みの場合は再初期化しない", () => {
      const result1 = initializeFirebaseAuth();
      const result2 = initializeFirebaseAuth();
      expect(result1.initialized).toBe(true);
      expect(result2.initialized).toBe(true);
    });
  });

  describe("FirebaseAuthAdapter.changePassword", () => {
    const originalEnv = process.env;
    const originalFetch = globalThis.fetch;

    beforeEach(() => {
      process.env = { ...originalEnv };
      process.env.FIREBASE_WEB_API_KEY = "test-api-key";
    });

    afterEach(() => {
      process.env = originalEnv;
      globalThis.fetch = originalFetch;
    });

    it("パスワード変更成功時に新しいトークンを返す", async () => {
      const mockResponse = {
        idToken: "new-id-token",
        refreshToken: "new-refresh-token",
      };
      globalThis.fetch = vi.fn().mockResolvedValue({
        ok: true,
        json: () => Promise.resolve(mockResponse),
      });

      const adapter = createFirebaseAuthAdapter();
      const result = await adapter.changePassword(
        "current-id-token",
        "newPassword123",
      );

      expect(result).toEqual({
        idToken: "new-id-token",
        refreshToken: "new-refresh-token",
      });
      expect(globalThis.fetch).toHaveBeenCalledWith(
        "https://identitytoolkit.googleapis.com/v1/accounts:update?key=test-api-key",
        {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            idToken: "current-id-token",
            password: "newPassword123",
            returnSecureToken: true,
          }),
        },
      );
    });

    it("FIREBASE_WEB_API_KEY が未設定の場合はエラーをスローする", async () => {
      delete process.env.FIREBASE_WEB_API_KEY;

      const adapter = createFirebaseAuthAdapter();

      await expect(
        adapter.changePassword("id-token", "newPassword"),
      ).rejects.toEqual({ code: "auth/internal-error" });
    });

    it("Firebase エラーレスポンス時に適切なエラーコードをスローする", async () => {
      const mockErrorResponse = {
        error: {
          code: 400,
          message: "INVALID_ID_TOKEN",
          errors: [],
        },
      };
      globalThis.fetch = vi.fn().mockResolvedValue({
        ok: false,
        json: () => Promise.resolve(mockErrorResponse),
      });

      const adapter = createFirebaseAuthAdapter();

      await expect(
        adapter.changePassword("invalid-token", "newPassword"),
      ).rejects.toEqual({ code: "auth/invalid-id-token" });
    });

    it("WEAK_PASSWORD エラーを適切にマッピングする", async () => {
      const mockErrorResponse = {
        error: {
          code: 400,
          message: "WEAK_PASSWORD",
          errors: [],
        },
      };
      globalThis.fetch = vi.fn().mockResolvedValue({
        ok: false,
        json: () => Promise.resolve(mockErrorResponse),
      });

      const adapter = createFirebaseAuthAdapter();

      await expect(
        adapter.changePassword("id-token", "weak"),
      ).rejects.toEqual({ code: "auth/weak-password" });
    });

    it("CREDENTIAL_TOO_OLD_LOGIN_AGAIN エラーを適切にマッピングする", async () => {
      const mockErrorResponse = {
        error: {
          code: 400,
          message: "CREDENTIAL_TOO_OLD_LOGIN_AGAIN",
          errors: [],
        },
      };
      globalThis.fetch = vi.fn().mockResolvedValue({
        ok: false,
        json: () => Promise.resolve(mockErrorResponse),
      });

      const adapter = createFirebaseAuthAdapter();

      await expect(
        adapter.changePassword("id-token", "newPassword"),
      ).rejects.toEqual({ code: "auth/requires-recent-login" });
    });
  });

  describe("FirebaseAuthAdapter.sendPasswordResetEmail", () => {
    const originalEnv = process.env;
    const originalFetch = globalThis.fetch;

    beforeEach(() => {
      process.env = { ...originalEnv };
      process.env.FIREBASE_WEB_API_KEY = "test-api-key";
    });

    afterEach(() => {
      process.env = originalEnv;
      globalThis.fetch = originalFetch;
    });

    it("パスワードリセットメール送信が成功する", async () => {
      const mockResponse = {
        email: "user@example.com",
      };
      globalThis.fetch = vi.fn().mockResolvedValue({
        ok: true,
        json: () => Promise.resolve(mockResponse),
      });

      const adapter = createFirebaseAuthAdapter();
      await adapter.sendPasswordResetEmail("user@example.com");

      expect(globalThis.fetch).toHaveBeenCalledWith(
        "https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=test-api-key",
        {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            requestType: "PASSWORD_RESET",
            email: "user@example.com",
          }),
        },
      );
    });

    it("FIREBASE_WEB_API_KEY が未設定の場合はエラーをスローする", async () => {
      delete process.env.FIREBASE_WEB_API_KEY;

      const adapter = createFirebaseAuthAdapter();

      await expect(
        adapter.sendPasswordResetEmail("user@example.com"),
      ).rejects.toEqual({ code: "auth/internal-error" });
    });

    it("EMAIL_NOT_FOUND エラーを適切にマッピングする", async () => {
      const mockErrorResponse = {
        error: {
          code: 400,
          message: "EMAIL_NOT_FOUND",
          errors: [],
        },
      };
      globalThis.fetch = vi.fn().mockResolvedValue({
        ok: false,
        json: () => Promise.resolve(mockErrorResponse),
      });

      const adapter = createFirebaseAuthAdapter();

      await expect(
        adapter.sendPasswordResetEmail("nonexistent@example.com"),
      ).rejects.toEqual({ code: "auth/user-not-found" });
    });

    it("INVALID_EMAIL エラーを適切にマッピングする", async () => {
      const mockErrorResponse = {
        error: {
          code: 400,
          message: "INVALID_EMAIL",
          errors: [],
        },
      };
      globalThis.fetch = vi.fn().mockResolvedValue({
        ok: false,
        json: () => Promise.resolve(mockErrorResponse),
      });

      const adapter = createFirebaseAuthAdapter();

      await expect(
        adapter.sendPasswordResetEmail("invalid-email"),
      ).rejects.toEqual({ code: "auth/invalid-email" });
    });
  });
});
