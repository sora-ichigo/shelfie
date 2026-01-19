import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";

describe("ConfigManager", () => {
  const originalEnv = process.env;

  beforeEach(() => {
    vi.resetModules();
    process.env = { ...originalEnv };
  });

  afterEach(() => {
    process.env = originalEnv;
  });

  describe("get", () => {
    it("should return the value of an existing environment variable", async () => {
      process.env.DATABASE_URL = "postgres://localhost:5432/test";
      process.env.NODE_ENV = "development";

      const { config } = await import("./index.js");

      expect(config.get("DATABASE_URL")).toBe("postgres://localhost:5432/test");
      expect(config.get("NODE_ENV")).toBe("development");
    });

    it("should return undefined for non-existent optional variables", async () => {
      process.env.DATABASE_URL = "postgres://localhost:5432/test";
      process.env.NODE_ENV = "development";

      const { config } = await import("./index.js");

      expect(config.get("DB_POOL_MAX")).toBeUndefined();
    });
  });

  describe("getOrDefault", () => {
    it("should return the environment variable value if it exists", async () => {
      process.env.DATABASE_URL = "postgres://localhost:5432/test";
      process.env.NODE_ENV = "development";
      process.env.LOG_LEVEL = "debug";

      const { config } = await import("./index.js");

      expect(config.getOrDefault("LOG_LEVEL", "info")).toBe("debug");
    });

    it("should return the default value if the environment variable does not exist", async () => {
      process.env.DATABASE_URL = "postgres://localhost:5432/test";
      process.env.NODE_ENV = "development";

      const { config } = await import("./index.js");

      expect(config.getOrDefault("LOG_LEVEL", "info")).toBe("info");
      expect(config.getOrDefault("PORT", 4000)).toBe(4000);
      expect(config.getOrDefault("DB_POOL_MAX", 20)).toBe(20);
    });

    it("should parse numeric string values to numbers for numeric defaults", async () => {
      process.env.DATABASE_URL = "postgres://localhost:5432/test";
      process.env.NODE_ENV = "development";
      process.env.PORT = "3000";

      const { config } = await import("./index.js");

      expect(config.getOrDefault("PORT", 4000)).toBe(3000);
    });
  });

  describe("validate", () => {
    it("should not throw when all required variables are set", async () => {
      process.env.DATABASE_URL = "postgres://localhost:5432/test";
      process.env.NODE_ENV = "development";

      const { config } = await import("./index.js");

      expect(() => config.validate()).not.toThrow();
    });

    it("should throw ConfigError when DATABASE_URL is missing", async () => {
      process.env.NODE_ENV = "development";
      delete process.env.DATABASE_URL;

      const { config, ConfigError } = await import("./index.js");

      expect(() => config.validate()).toThrow(ConfigError);
      try {
        config.validate();
      } catch (e) {
        expect(e).toBeInstanceOf(ConfigError);
        expect((e as InstanceType<typeof ConfigError>).key).toBe(
          "DATABASE_URL",
        );
        expect((e as InstanceType<typeof ConfigError>).code).toBe(
          "MISSING_REQUIRED",
        );
      }
    });

    it("should throw ConfigError when NODE_ENV is missing", async () => {
      process.env.DATABASE_URL = "postgres://localhost:5432/test";
      delete process.env.NODE_ENV;

      const { config, ConfigError } = await import("./index.js");

      expect(() => config.validate()).toThrow(ConfigError);
      try {
        config.validate();
      } catch (e) {
        expect(e).toBeInstanceOf(ConfigError);
        expect((e as InstanceType<typeof ConfigError>).key).toBe("NODE_ENV");
      }
    });

    it("should throw ConfigError when NODE_ENV has invalid value", async () => {
      process.env.DATABASE_URL = "postgres://localhost:5432/test";
      process.env.NODE_ENV = "invalid";

      const { config, ConfigError } = await import("./index.js");

      expect(() => config.validate()).toThrow(ConfigError);
      try {
        config.validate();
      } catch (e) {
        expect(e).toBeInstanceOf(ConfigError);
        expect((e as InstanceType<typeof ConfigError>).code).toBe(
          "INVALID_VALUE",
        );
      }
    });

    it("should throw ConfigError when LOG_LEVEL has invalid value", async () => {
      process.env.DATABASE_URL = "postgres://localhost:5432/test";
      process.env.NODE_ENV = "development";
      process.env.LOG_LEVEL = "verbose";

      const { config, ConfigError } = await import("./index.js");

      expect(() => config.validate()).toThrow(ConfigError);
      try {
        config.validate();
      } catch (e) {
        expect(e).toBeInstanceOf(ConfigError);
        expect((e as InstanceType<typeof ConfigError>).code).toBe(
          "INVALID_VALUE",
        );
        expect((e as InstanceType<typeof ConfigError>).key).toBe("LOG_LEVEL");
      }
    });
  });

  describe("isDevelopment", () => {
    it("should return true when NODE_ENV is development", async () => {
      process.env.DATABASE_URL = "postgres://localhost:5432/test";
      process.env.NODE_ENV = "development";

      const { config } = await import("./index.js");

      expect(config.isDevelopment()).toBe(true);
    });

    it("should return false when NODE_ENV is production", async () => {
      process.env.DATABASE_URL = "postgres://localhost:5432/test";
      process.env.NODE_ENV = "production";

      const { config } = await import("./index.js");

      expect(config.isDevelopment()).toBe(false);
    });

    it("should return false when NODE_ENV is test", async () => {
      process.env.DATABASE_URL = "postgres://localhost:5432/test";
      process.env.NODE_ENV = "test";

      const { config } = await import("./index.js");

      expect(config.isDevelopment()).toBe(false);
    });
  });

  describe("isProduction", () => {
    it("should return true when NODE_ENV is production", async () => {
      process.env.DATABASE_URL = "postgres://localhost:5432/test";
      process.env.NODE_ENV = "production";

      const { config } = await import("./index.js");

      expect(config.isProduction()).toBe(true);
    });

    it("should return false when NODE_ENV is development", async () => {
      process.env.DATABASE_URL = "postgres://localhost:5432/test";
      process.env.NODE_ENV = "development";

      const { config } = await import("./index.js");

      expect(config.isProduction()).toBe(false);
    });
  });

  describe("isTest", () => {
    it("should return true when NODE_ENV is test", async () => {
      process.env.DATABASE_URL = "postgres://localhost:5432/test";
      process.env.NODE_ENV = "test";

      const { config } = await import("./index.js");

      expect(config.isTest()).toBe(true);
    });

    it("should return false when NODE_ENV is development", async () => {
      process.env.DATABASE_URL = "postgres://localhost:5432/test";
      process.env.NODE_ENV = "development";

      const { config } = await import("./index.js");

      expect(config.isTest()).toBe(false);
    });
  });
});
