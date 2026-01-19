import { afterAll, beforeAll, describe, expect, it } from "vitest";
import {
  ConnectionError,
  createDatabaseConnection,
  type DatabaseConnection,
} from "./connection.js";
import { closeTestPool } from "./test-utils.js";

describe("DatabaseConnection", () => {
  let connection: DatabaseConnection;

  beforeAll(() => {
    connection = createDatabaseConnection();
  });

  afterAll(async () => {
    await connection.disconnect();
    await closeTestPool();
  });

  describe("createDatabaseConnection", () => {
    it("should create a DatabaseConnection instance", () => {
      expect(connection).toBeDefined();
      expect(typeof connection.getPool).toBe("function");
      expect(typeof connection.connect).toBe("function");
      expect(typeof connection.disconnect).toBe("function");
      expect(typeof connection.healthCheck).toBe("function");
    });
  });

  describe("ConnectionError", () => {
    it("should have proper error structure", () => {
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

    it("should support TIMEOUT error code", () => {
      const error = new ConnectionError("TIMEOUT", "Connection timeout", true);

      expect(error.code).toBe("TIMEOUT");
      expect(error.retryable).toBe(true);
    });

    it("should support POOL_EXHAUSTED error code", () => {
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
    it("should return a Pool instance", () => {
      const pool = connection.getPool();

      expect(pool).toBeDefined();
      expect(typeof pool.query).toBe("function");
      expect(typeof pool.connect).toBe("function");
      expect(typeof pool.end).toBe("function");
    });
  });

  describe("connect", () => {
    it("should connect to the database successfully", async () => {
      await expect(connection.connect()).resolves.toBeUndefined();
    });

    it("should execute SELECT 1 to verify connection", async () => {
      await connection.connect();

      const pool = connection.getPool();
      const result = await pool.query("SELECT 1 as result");

      expect(result.rows[0].result).toBe(1);
    });
  });

  describe("healthCheck", () => {
    it("should return true when database is reachable", async () => {
      const result = await connection.healthCheck();

      expect(result).toBe(true);
    });
  });

  describe("disconnect", () => {
    it("should disconnect from the database gracefully", async () => {
      const tempConnection = createDatabaseConnection();
      await tempConnection.connect();

      await expect(tempConnection.disconnect()).resolves.toBeUndefined();
    });
  });
});
