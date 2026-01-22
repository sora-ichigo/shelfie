import {
  afterEach,
  beforeEach,
  describe,
  expect,
  it,
  type Mock,
  vi,
} from "vitest";
import { type AuthenticatedUser, extractBearerToken } from "./middleware";

vi.mock("./firebase", () => ({
  verifyIdToken: vi.fn(),
}));

const mockSelect = vi.fn();
const mockFrom = vi.fn();
const mockWhere = vi.fn();
const mockLimit = vi.fn();

vi.mock("../db", () => ({
  getDb: () => ({
    select: mockSelect,
  }),
  users: { id: "id", firebaseUid: "firebaseUid", email: "email" },
}));

describe("Auth Middleware", () => {
  let createAuthContext: typeof import("./middleware").createAuthContext;
  let mockVerifyIdToken: Mock;
  const originalEnv = process.env;

  beforeEach(async () => {
    vi.resetModules();
    process.env = { ...originalEnv };
    delete process.env.DEV_USER_ID;

    mockSelect.mockReturnValue({ from: mockFrom });
    mockFrom.mockReturnValue({ where: mockWhere });
    mockWhere.mockReturnValue({ limit: mockLimit });
    mockLimit.mockResolvedValue([]);

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

    it("DEV_USER_ID が設定されている場合はDBからユーザーを取得して返す", async () => {
      process.env.DEV_USER_ID = "1";
      mockLimit.mockResolvedValue([
        { firebaseUid: "firebase-uid-123", email: "user@example.com" },
      ]);
      vi.resetModules();
      const middlewareModule = await import("./middleware");

      const user = await middlewareModule.createAuthContext(undefined);

      expect(user).toEqual({
        uid: "firebase-uid-123",
        email: "user@example.com",
        emailVerified: true,
      } satisfies AuthenticatedUser);
      expect(mockVerifyIdToken).not.toHaveBeenCalled();
    });

    it("DEV_USER_ID が数値でない場合は null を返す", async () => {
      process.env.DEV_USER_ID = "not-a-number";
      vi.resetModules();
      const middlewareModule = await import("./middleware");

      const user = await middlewareModule.createAuthContext(undefined);

      expect(user).toBeNull();
    });

    it("DEV_USER_ID のユーザーが存在しない場合は null を返す", async () => {
      process.env.DEV_USER_ID = "999";
      mockLimit.mockResolvedValue([]);
      vi.resetModules();
      const middlewareModule = await import("./middleware");

      const user = await middlewareModule.createAuthContext(undefined);

      expect(user).toBeNull();
    });

    it("DEV_USER_ID が設定されていても本番環境では無視される", async () => {
      process.env.DEV_USER_ID = "1";
      process.env.NODE_ENV = "production";
      vi.resetModules();
      const middlewareModule = await import("./middleware");

      const user = await middlewareModule.createAuthContext(undefined);

      expect(user).toBeNull();
    });

    it("X-Dev-User-Id ヘッダーが設定されている場合はDBからユーザーを取得して返す", async () => {
      mockLimit.mockResolvedValue([
        { firebaseUid: "firebase-uid-456", email: "header-user@example.com" },
      ]);

      const user = await createAuthContext(undefined, "1");

      expect(user).toEqual({
        uid: "firebase-uid-456",
        email: "header-user@example.com",
        emailVerified: true,
      } satisfies AuthenticatedUser);
      expect(mockVerifyIdToken).not.toHaveBeenCalled();
    });

    it("X-Dev-User-Id ヘッダーが数値でない場合は通常の認証フローに進む", async () => {
      mockVerifyIdToken.mockResolvedValue(null);

      const user = await createAuthContext(undefined, "not-a-number");

      expect(user).toBeNull();
    });

    it("X-Dev-User-Id ヘッダーのユーザーが存在しない場合は通常の認証フローに進む", async () => {
      mockLimit.mockResolvedValue([]);
      mockVerifyIdToken.mockResolvedValue(null);

      const user = await createAuthContext(undefined, "999");

      expect(user).toBeNull();
    });

    it("X-Dev-User-Id ヘッダーが設定されていても本番環境では無視される", async () => {
      process.env.NODE_ENV = "production";
      mockLimit.mockResolvedValue([
        { firebaseUid: "firebase-uid-456", email: "header-user@example.com" },
      ]);
      vi.resetModules();
      const middlewareModule = await import("./middleware");

      const user = await middlewareModule.createAuthContext(undefined, "1");

      expect(user).toBeNull();
    });

    it("X-Dev-User-Id ヘッダーが DEV_USER_ID 環境変数より優先される", async () => {
      process.env.DEV_USER_ID = "2";
      mockLimit.mockImplementation(async () => {
        const whereArg = mockWhere.mock.calls[mockWhere.mock.calls.length - 1];
        if (whereArg && JSON.stringify(whereArg).includes("1")) {
          return [
            {
              firebaseUid: "header-user-uid",
              email: "header-user@example.com",
            },
          ];
        }
        return [{ firebaseUid: "env-user-uid", email: "env-user@example.com" }];
      });
      vi.resetModules();
      const middlewareModule = await import("./middleware");

      const user = await middlewareModule.createAuthContext(undefined, "1");

      expect(user).toEqual({
        uid: "header-user-uid",
        email: "header-user@example.com",
        emailVerified: true,
      } satisfies AuthenticatedUser);
    });
  });
});
