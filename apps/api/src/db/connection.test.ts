import type { Pool } from "pg";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";

describe("DatabaseConnection", () => {
  const originalEnv = process.env;

  beforeEach(() => {
    vi.resetModules();
    process.env = { ...originalEnv };
    process.env.DATABASE_URL = "postgres://user:pass@localhost:5432/test";
    process.env.NODE_ENV = "test";
  });

  afterEach(() => {
    process.env = originalEnv;
    vi.restoreAllMocks();
  });

  describe("createDatabaseConnection", () => {
    it("should create a DatabaseConnection instance with default config", async () => {
      const { createDatabaseConnection } = await import("./connection.js");

      const connection = createDatabaseConnection();

      expect(connection).toBeDefined();
      expect(typeof connection.getPool).toBe("function");
      expect(typeof connection.connect).toBe("function");
      expect(typeof connection.disconnect).toBe("function");
      expect(typeof connection.healthCheck).toBe("function");
    });

    it("should use ConfigManager to get connection settings", async () => {
      process.env.DB_POOL_MAX = "10";
      process.env.DB_IDLE_TIMEOUT_MS = "30000";
      process.env.DB_CONNECTION_TIMEOUT_MS = "5000";

      const { createDatabaseConnection } = await import("./connection.js");

      const connection = createDatabaseConnection();

      expect(connection).toBeDefined();
    });
  });

  describe("ConnectionError", () => {
    it("should have proper error structure", async () => {
      const { ConnectionError } = await import("./connection.js");

      const error = new ConnectionError(
        "CONNECTION_FAILED",
        "Failed to connect to database",
        true,
      );

      expect(error.code).toBe("CONNECTION_FAILED");
      expect(error.message).toBe("Failed to connect to database");
      expect(error.retryable).toBe(true);
      expect(error.name).toBe("ConnectionError");
    });

    it("should support TIMEOUT error code", async () => {
      const { ConnectionError } = await import("./connection.js");

      const error = new ConnectionError("TIMEOUT", "Connection timeout", true);

      expect(error.code).toBe("TIMEOUT");
      expect(error.retryable).toBe(true);
    });

    it("should support POOL_EXHAUSTED error code", async () => {
      const { ConnectionError } = await import("./connection.js");

      const error = new ConnectionError(
        "POOL_EXHAUSTED",
        "Connection pool exhausted",
        false,
      );

      expect(error.code).toBe("POOL_EXHAUSTED");
      expect(error.retryable).toBe(false);
    });
  });

  describe("getPool", () => {
    it("should return a Pool instance", async () => {
      const { createDatabaseConnection } = await import("./connection.js");

      const connection = createDatabaseConnection();
      const pool = connection.getPool();

      expect(pool).toBeDefined();
      expect(typeof pool.query).toBe("function");
      expect(typeof pool.connect).toBe("function");
      expect(typeof pool.end).toBe("function");
    });
  });

  describe("createDatabaseConnectionWithPool (dependency injection)", () => {
    it("should attempt to connect and verify connection", async () => {
      const { createDatabaseConnectionWithPool } = await import(
        "./connection.js"
      );

      const mockQuery = vi.fn().mockResolvedValue({ rows: [{ result: 1 }] });
      const mockPool = {
        query: mockQuery,
        connect: vi.fn(),
        end: vi.fn(),
        on: vi.fn(),
      } as unknown as Pool;

      const connection = createDatabaseConnectionWithPool(mockPool);

      await expect(connection.connect()).resolves.toBeUndefined();
      expect(mockQuery).toHaveBeenCalledWith("SELECT 1");
    });

    it("should throw ConnectionError on connection failure", async () => {
      const { createDatabaseConnectionWithPool, ConnectionError } =
        await import("./connection.js");

      const mockQuery = vi
        .fn()
        .mockRejectedValue(new Error("Connection refused"));
      const mockPool = {
        query: mockQuery,
        connect: vi.fn(),
        end: vi.fn(),
        on: vi.fn(),
      } as unknown as Pool;

      const connection = createDatabaseConnectionWithPool(mockPool);

      await expect(connection.connect()).rejects.toThrow(ConnectionError);
    });

    it("should call pool.end() for graceful shutdown", async () => {
      const { createDatabaseConnectionWithPool } = await import(
        "./connection.js"
      );

      const mockEnd = vi.fn().mockResolvedValue(undefined);
      const mockPool = {
        query: vi.fn(),
        connect: vi.fn(),
        end: mockEnd,
        on: vi.fn(),
      } as unknown as Pool;

      const connection = createDatabaseConnectionWithPool(mockPool);

      await connection.disconnect();

      expect(mockEnd).toHaveBeenCalled();
    });

    it("should return true when database is reachable (healthCheck)", async () => {
      const { createDatabaseConnectionWithPool } = await import(
        "./connection.js"
      );

      const mockQuery = vi.fn().mockResolvedValue({ rows: [{ result: 1 }] });
      const mockPool = {
        query: mockQuery,
        connect: vi.fn(),
        end: vi.fn(),
        on: vi.fn(),
      } as unknown as Pool;

      const connection = createDatabaseConnectionWithPool(mockPool);

      const result = await connection.healthCheck();

      expect(result).toBe(true);
      expect(mockQuery).toHaveBeenCalledWith("SELECT 1");
    });

    it("should return false when database is unreachable (healthCheck)", async () => {
      const { createDatabaseConnectionWithPool } = await import(
        "./connection.js"
      );

      const mockQuery = vi
        .fn()
        .mockRejectedValue(new Error("Connection refused"));
      const mockPool = {
        query: mockQuery,
        connect: vi.fn(),
        end: vi.fn(),
        on: vi.fn(),
      } as unknown as Pool;

      const connection = createDatabaseConnectionWithPool(mockPool);

      const result = await connection.healthCheck();

      expect(result).toBe(false);
    });
  });

  describe("retry strategy", () => {
    it("should retry connection on transient failures", async () => {
      const { createDatabaseConnectionWithPool } = await import(
        "./connection.js"
      );

      let callCount = 0;
      const mockQuery = vi.fn().mockImplementation(() => {
        callCount++;
        if (callCount < 3) {
          return Promise.reject(new Error("Connection refused"));
        }
        return Promise.resolve({ rows: [{ result: 1 }] });
      });

      const mockPool = {
        query: mockQuery,
        connect: vi.fn(),
        end: vi.fn(),
        on: vi.fn(),
      } as unknown as Pool;

      const connection = createDatabaseConnectionWithPool(mockPool);

      await expect(
        connection.connect({ maxRetries: 3, retryDelayMs: 10 }),
      ).resolves.toBeUndefined();
      expect(callCount).toBe(3);
    });

    it("should throw after max retries exceeded", async () => {
      const { createDatabaseConnectionWithPool, ConnectionError } =
        await import("./connection.js");

      const mockQuery = vi
        .fn()
        .mockRejectedValue(new Error("Connection refused"));
      const mockPool = {
        query: mockQuery,
        connect: vi.fn(),
        end: vi.fn(),
        on: vi.fn(),
      } as unknown as Pool;

      const connection = createDatabaseConnectionWithPool(mockPool);

      await expect(
        connection.connect({ maxRetries: 2, retryDelayMs: 10 }),
      ).rejects.toThrow(ConnectionError);
      expect(mockQuery).toHaveBeenCalledTimes(2);
    });
  });
});
