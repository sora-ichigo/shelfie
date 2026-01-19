import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import {
  type FirebaseAuthConfig,
  getFirebaseAuthConfig,
  initializeFirebaseAuth,
  verifyIdToken,
} from "./firebase";

vi.mock("firebase-admin", () => {
  const mockVerifyIdToken = vi.fn();
  return {
    default: {
      apps: [],
      initializeApp: vi.fn(() => ({
        name: "mock-app",
      })),
      credential: {
        cert: vi.fn((config) => ({
          type: "service_account",
          projectId: config.projectId,
        })),
        applicationDefault: vi.fn(() => ({
          type: "application_default",
        })),
      },
      auth: vi.fn(() => ({
        verifyIdToken: mockVerifyIdToken,
      })),
    },
    __mockVerifyIdToken: mockVerifyIdToken,
  };
});

describe("Firebase Auth", () => {
  const originalEnv = process.env;

  beforeEach(() => {
    vi.resetModules();
    process.env = { ...originalEnv };
  });

  afterEach(() => {
    process.env = originalEnv;
    vi.clearAllMocks();
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
    it("Firebase Admin を初期化する", async () => {
      const config: FirebaseAuthConfig = {
        projectId: "test-project",
        clientEmail: "test@example.iam.gserviceaccount.com",
        privateKey:
          "-----BEGIN PRIVATE KEY-----\ntest\n-----END PRIVATE KEY-----",
      };

      const result = initializeFirebaseAuth(config);

      expect(result.initialized).toBe(true);
    });

    it("設定なしで Application Default Credentials を使用する", () => {
      const result = initializeFirebaseAuth();
      expect(result.initialized).toBe(true);
    });
  });

  describe("verifyIdToken", () => {
    it("有効なトークンを検証して DecodedIdToken を返す", async () => {
      const admin = await import("firebase-admin");
      const mockVerifyIdToken = (
        admin as unknown as { __mockVerifyIdToken: ReturnType<typeof vi.fn> }
      ).__mockVerifyIdToken;

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

      const result = await verifyIdToken("valid-token");

      expect(result).toEqual(mockDecodedToken);
      expect(mockVerifyIdToken).toHaveBeenCalledWith("valid-token");
    });

    it("無効なトークンの場合は null を返す", async () => {
      const admin = await import("firebase-admin");
      const mockVerifyIdToken = (
        admin as unknown as { __mockVerifyIdToken: ReturnType<typeof vi.fn> }
      ).__mockVerifyIdToken;

      mockVerifyIdToken.mockRejectedValueOnce(new Error("Token is invalid"));

      const result = await verifyIdToken("invalid-token");

      expect(result).toBeNull();
    });
  });
});
