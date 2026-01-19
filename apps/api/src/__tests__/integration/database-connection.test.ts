import { afterAll, beforeAll, describe, expect, it } from "vitest";
import { getGlobalTestPool } from "../../../vitest.setup.js";
import {
  ConnectionError,
  createDatabaseConnection,
  createDatabaseConnectionWithPool,
  type DatabaseConnection,
} from "../../db/connection.js";

describe("DatabaseConnection Integration Tests", () => {
  describe("connection lifecycle", () => {
    let connection: DatabaseConnection;

    beforeAll(() => {
      connection = createDatabaseConnection();
    });

    afterAll(async () => {
      await connection.disconnect();
    });

    it("should establish connection successfully", async () => {
      await expect(connection.connect()).resolves.toBeUndefined();
    });

    it("should execute queries after connection", async () => {
      const pool = connection.getPool();
      const result = await pool.query("SELECT 1 + 1 as sum");
      expect(result.rows[0].sum).toBe(2);
    });

    it("should pass health check when connected", async () => {
      const isHealthy = await connection.healthCheck();
      expect(isHealthy).toBe(true);
    });

    it("should disconnect gracefully", async () => {
      const tempConnection = createDatabaseConnection();
      await tempConnection.connect();
      await expect(tempConnection.disconnect()).resolves.toBeUndefined();
    });
  });

  describe("connection with existing pool", () => {
    it("should work with an existing pool instance", async () => {
      const pool = getGlobalTestPool();
      const connection = createDatabaseConnectionWithPool(pool);

      await expect(connection.connect()).resolves.toBeUndefined();

      const isHealthy = await connection.healthCheck();
      expect(isHealthy).toBe(true);
    });
  });

  describe("connection errors", () => {
    it("should fail with invalid connection string", async () => {
      const originalEnv = process.env.DATABASE_URL;

      process.env.DATABASE_URL =
        "postgres://invalid:invalid@nonexistent-host:5432/invalid";

      try {
        const connection = createDatabaseConnection();
        await expect(
          connection.connect({ maxRetries: 1, retryDelayMs: 100 }),
        ).rejects.toThrow(ConnectionError);
      } finally {
        process.env.DATABASE_URL = originalEnv;
      }
    });

    it("should retry on connection failure", async () => {
      const originalEnv = process.env.DATABASE_URL;

      process.env.DATABASE_URL =
        "postgres://invalid:invalid@127.0.0.1:9999/invalid";

      const startTime = Date.now();

      try {
        const connection = createDatabaseConnection();
        await expect(
          connection.connect({ maxRetries: 2, retryDelayMs: 100 }),
        ).rejects.toThrow(ConnectionError);

        const elapsed = Date.now() - startTime;
        expect(elapsed).toBeGreaterThanOrEqual(100);
      } finally {
        process.env.DATABASE_URL = originalEnv;
      }
    });
  });

  describe("ConnectionError structure", () => {
    it("should have correct error codes for different failure types", () => {
      const connectionFailed = new ConnectionError(
        "CONNECTION_FAILED",
        "Failed to connect",
        true,
      );
      expect(connectionFailed.code).toBe("CONNECTION_FAILED");
      expect(connectionFailed.retryable).toBe(true);

      const timeout = new ConnectionError(
        "TIMEOUT",
        "Connection timed out",
        true,
      );
      expect(timeout.code).toBe("TIMEOUT");
      expect(timeout.retryable).toBe(true);

      const poolExhausted = new ConnectionError(
        "POOL_EXHAUSTED",
        "No available connections",
        false,
      );
      expect(poolExhausted.code).toBe("POOL_EXHAUSTED");
      expect(poolExhausted.retryable).toBe(false);
    });
  });
});
