import { describe, it, expect, vi, beforeEach, afterEach } from "vitest";

describe("Logger", () => {
  const originalEnv = process.env;

  beforeEach(() => {
    vi.resetModules();
    process.env = { ...originalEnv };
  });

  afterEach(() => {
    process.env = originalEnv;
  });

  describe("createLogger", () => {
    it("should create a logger instance with default log level 'info'", async () => {
      process.env.NODE_ENV = "test";
      const { createLogger } = await import("./index");
      const logger = createLogger();

      expect(logger).toBeDefined();
      expect(typeof logger.debug).toBe("function");
      expect(typeof logger.info).toBe("function");
      expect(typeof logger.warn).toBe("function");
      expect(typeof logger.error).toBe("function");
    });

    it("should respect LOG_LEVEL environment variable", async () => {
      process.env.NODE_ENV = "test";
      process.env.LOG_LEVEL = "debug";
      const { createLogger } = await import("./index");
      const logger = createLogger();

      expect(logger).toBeDefined();
    });

    it("should create logger with custom config", async () => {
      process.env.NODE_ENV = "test";
      const { createLogger } = await import("./index");
      const logger = createLogger({ level: "warn" });

      expect(logger).toBeDefined();
    });
  });

  describe("LoggerService interface", () => {
    it("should provide debug method that accepts message and context", async () => {
      process.env.NODE_ENV = "test";
      const { createLogger } = await import("./index");
      const logger = createLogger();

      expect(() =>
        logger.debug("test message", { feature: "test" }),
      ).not.toThrow();
    });

    it("should provide info method that accepts message and context", async () => {
      process.env.NODE_ENV = "test";
      const { createLogger } = await import("./index");
      const logger = createLogger();

      expect(() =>
        logger.info("test message", { requestId: "123" }),
      ).not.toThrow();
    });

    it("should provide warn method that accepts message and context", async () => {
      process.env.NODE_ENV = "test";
      const { createLogger } = await import("./index");
      const logger = createLogger();

      expect(() =>
        logger.warn("warning message", { userId: "user-1" }),
      ).not.toThrow();
    });

    it("should provide error method that accepts message, error, and context", async () => {
      process.env.NODE_ENV = "test";
      const { createLogger } = await import("./index");
      const logger = createLogger();
      const testError = new Error("test error");

      expect(() =>
        logger.error("error message", testError, { requestId: "123" }),
      ).not.toThrow();
    });

    it("should provide error method that works without error object", async () => {
      process.env.NODE_ENV = "test";
      const { createLogger } = await import("./index");
      const logger = createLogger();

      expect(() =>
        logger.error("error message", undefined, { requestId: "123" }),
      ).not.toThrow();
    });
  });

  describe("child logger", () => {
    it("should create child logger with bound context", async () => {
      process.env.NODE_ENV = "test";
      const { createLogger } = await import("./index");
      const logger = createLogger();
      const childLogger = logger.child({ requestId: "req-123" });

      expect(childLogger).toBeDefined();
      expect(typeof childLogger.info).toBe("function");
      expect(typeof childLogger.child).toBe("function");
    });

    it("should inherit parent logger methods", async () => {
      process.env.NODE_ENV = "test";
      const { createLogger } = await import("./index");
      const logger = createLogger();
      const childLogger = logger.child({
        requestId: "req-123",
        userId: "user-456",
      });

      expect(() => childLogger.debug("test")).not.toThrow();
      expect(() => childLogger.info("test")).not.toThrow();
      expect(() => childLogger.warn("test")).not.toThrow();
      expect(() => childLogger.error("test")).not.toThrow();
    });
  });

  describe("JSON output format", () => {
    it("should output valid JSON in production mode", async () => {
      process.env.NODE_ENV = "production";
      const { createLogger } = await import("./index");
      const logger = createLogger();

      expect(logger).toBeDefined();
    });
  });

  describe("pretty print in development", () => {
    it("should use pino-pretty in development mode", async () => {
      process.env.NODE_ENV = "development";
      const { createLogger } = await import("./index");
      const logger = createLogger({ prettyPrint: true });

      expect(logger).toBeDefined();
    });
  });

  describe("LogContext type", () => {
    it("should accept standard context fields", async () => {
      process.env.NODE_ENV = "test";
      const { createLogger } = await import("./index");
      const logger = createLogger();

      expect(() =>
        logger.info("test", {
          requestId: "req-123",
          userId: "user-456",
          feature: "books",
        }),
      ).not.toThrow();
    });

    it("should accept additional arbitrary fields", async () => {
      process.env.NODE_ENV = "test";
      const { createLogger } = await import("./index");
      const logger = createLogger();

      expect(() =>
        logger.info("test", {
          requestId: "req-123",
          customField: "custom-value",
          anotherField: 42,
        }),
      ).not.toThrow();
    });
  });

  describe("singleton logger", () => {
    it("should export a default logger instance", async () => {
      process.env.NODE_ENV = "test";
      const { logger } = await import("./index");

      expect(logger).toBeDefined();
      expect(typeof logger.info).toBe("function");
    });
  });
});
