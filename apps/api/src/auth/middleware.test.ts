import { afterEach, beforeEach, describe, expect, it, type Mock, vi } from "vitest";
import { type AuthenticatedUser, extractBearerToken } from "./middleware";

vi.mock("./firebase", () => ({
  verifyIdToken: vi.fn(),
}));

describe("Auth Middleware", () => {
  let createAuthContext: typeof import("./middleware").createAuthContext;
  let mockVerifyIdToken: Mock;
  const originalEnv = process.env;

  beforeEach(async () => {
    vi.resetModules();
    process.env = { ...originalEnv };
    delete process.env.DEV_USER_ID;
    const firebaseModule = await import("./firebase");
    mockVerifyIdToken = vi.mocked(firebaseModule.verifyIdToken);
    mockVerifyIdToken.mockReset();
    const middlewareModule = await import("./middleware");
    createAuthContext = middlewareModule.createAuthContext;
  });

  afterEach(() => {
    process.env = originalEnv;
  });

  describe("extractBearerToken", () => {
    it("Authorization ヘッダーから Bearer トークンを抽出する", () => {
      const authHeader = "Bearer abc123xyz";
      const token = extractBearerToken(authHeader);
      expect(token).toBe("abc123xyz");
    });

    it("Bearer プレフィックスがない場合は null を返す", () => {
      const authHeader = "Basic abc123xyz";
      const token = extractBearerToken(authHeader);
      expect(token).toBeNull();
    });

    it("空文字列の場合は null を返す", () => {
      const token = extractBearerToken("");
      expect(token).toBeNull();
    });

    it("undefined の場合は null を返す", () => {
      const token = extractBearerToken(undefined);
      expect(token).toBeNull();
    });

    it("Bearer のみの場合は空文字列を返す", () => {
      const token = extractBearerToken("Bearer ");
      expect(token).toBe("");
    });
  });

  describe("createAuthContext", () => {
    it("有効なトークンで認証済みユーザーを返す", async () => {
      const mockDecodedToken = {
        uid: "user-123",
        email: "user@example.com",
        email_verified: true,
        aud: "test-project",
        iss: "https://securetoken.google.com/test-project",
        sub: "user-123",
        iat: 1234567890,
        exp: 1234567890 + 3600,
        auth_time: 1234567890,
        firebase: {
          identities: {},
          sign_in_provider: "password",
        },
      };

      mockVerifyIdToken.mockResolvedValue(mockDecodedToken);

      const user = await createAuthContext("Bearer valid-token");

      expect(user).toEqual({
        uid: "user-123",
        email: "user@example.com",
        emailVerified: true,
      } satisfies AuthenticatedUser);
    });

    it("トークンがない場合は null を返す", async () => {
      const user = await createAuthContext(undefined);
      expect(user).toBeNull();
    });

    it("無効なトークンの場合は null を返す", async () => {
      mockVerifyIdToken.mockResolvedValue(null);

      const user = await createAuthContext("Bearer invalid-token");
      expect(user).toBeNull();
    });

    it("DEV_USER_ID が設定されている場合は開発用ユーザーを返す", async () => {
      process.env.DEV_USER_ID = "dev-user-123";
      vi.resetModules();
      const middlewareModule = await import("./middleware");

      const user = await middlewareModule.createAuthContext(undefined);

      expect(user).toEqual({
        uid: "dev-user-123",
        email: "dev@example.com",
        emailVerified: true,
      } satisfies AuthenticatedUser);
      expect(mockVerifyIdToken).not.toHaveBeenCalled();
    });

    it("DEV_USER_ID が設定されていても本番環境では無視される", async () => {
      process.env.DEV_USER_ID = "dev-user-123";
      process.env.NODE_ENV = "production";
      vi.resetModules();
      const middlewareModule = await import("./middleware");

      const user = await middlewareModule.createAuthContext(undefined);

      expect(user).toBeNull();
    });
  });
});
