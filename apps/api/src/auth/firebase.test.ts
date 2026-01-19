import { afterEach, beforeEach, describe, expect, it } from "vitest";
import {
  type FirebaseAuthConfig,
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
});
