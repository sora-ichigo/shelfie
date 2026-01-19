import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { createCorsOptions, getCorsOrigin, type CorsConfig } from "./cors";

describe("CORS Security", () => {
  const originalEnv = process.env;

  beforeEach(() => {
    vi.resetModules();
    process.env = { ...originalEnv };
  });

  afterEach(() => {
    process.env = originalEnv;
  });

  describe("getCorsOrigin", () => {
    it("開発環境ではデフォルトで localhost:3000 を返す", () => {
      process.env.NODE_ENV = "development";
      delete process.env.CORS_ORIGIN;
      const origin = getCorsOrigin();
      expect(origin).toBe("http://localhost:3000");
    });

    it("環境変数 CORS_ORIGIN が設定されていればその値を返す", () => {
      process.env.CORS_ORIGIN = "https://example.com";
      const origin = getCorsOrigin();
      expect(origin).toBe("https://example.com");
    });

    it("本番環境で CORS_ORIGIN が未設定の場合は undefined を返す", () => {
      process.env.NODE_ENV = "production";
      delete process.env.CORS_ORIGIN;
      const origin = getCorsOrigin();
      expect(origin).toBeUndefined();
    });

    it("複数オリジンをカンマ区切りで指定できる", () => {
      process.env.CORS_ORIGIN = "https://example.com,https://app.example.com";
      const origin = getCorsOrigin();
      expect(origin).toEqual([
        "https://example.com",
        "https://app.example.com",
      ]);
    });
  });

  describe("createCorsOptions", () => {
    it("デフォルトの CORS オプションを生成する", () => {
      process.env.NODE_ENV = "development";
      delete process.env.CORS_ORIGIN;
      const options = createCorsOptions();
      expect(options.origin).toBe("http://localhost:3000");
      expect(options.credentials).toBe(true);
    });

    it("カスタム設定で CORS オプションを生成できる", () => {
      const customConfig: CorsConfig = {
        origin: "https://custom.example.com",
        credentials: false,
        methods: ["GET", "POST"],
      };
      const options = createCorsOptions(customConfig);
      expect(options.origin).toBe("https://custom.example.com");
      expect(options.credentials).toBe(false);
      expect(options.methods).toEqual(["GET", "POST"]);
    });

    it("allowedHeaders を設定できる", () => {
      const config: CorsConfig = {
        origin: "https://example.com",
        allowedHeaders: ["Content-Type", "Authorization", "X-Request-ID"],
      };
      const options = createCorsOptions(config);
      expect(options.allowedHeaders).toEqual([
        "Content-Type",
        "Authorization",
        "X-Request-ID",
      ]);
    });
  });
});
