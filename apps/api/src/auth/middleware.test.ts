import { describe, expect, it, vi } from "vitest";
import {
  extractBearerToken,
  createAuthContext,
  type AuthenticatedUser,
} from "./middleware";

vi.mock("./firebase", () => ({
  verifyIdToken: vi.fn(),
}));

describe("Auth Middleware", () => {
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
      const { verifyIdToken } = await import("./firebase");
      const mockVerifyIdToken = vi.mocked(verifyIdToken);

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

      mockVerifyIdToken.mockResolvedValueOnce(mockDecodedToken);

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
      const { verifyIdToken } = await import("./firebase");
      const mockVerifyIdToken = vi.mocked(verifyIdToken);

      mockVerifyIdToken.mockResolvedValueOnce(null);

      const user = await createAuthContext("Bearer invalid-token");
      expect(user).toBeNull();
    });
  });
});
