import type { Pool } from "pg";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";

describe("DrizzleClient", () => {
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

  describe("createDrizzleClient", () => {
    it("should create a Drizzle client from a Pool instance", async () => {
      const { createDrizzleClient } = await import("./client.js");

      const mockPool = {
        query: vi.fn(),
        connect: vi.fn(),
        end: vi.fn(),
        on: vi.fn(),
      } as unknown as Pool;

      const client = createDrizzleClient(mockPool);

      expect(client).toBeDefined();
      expect(typeof client.getDb).toBe("function");
      expect(typeof client.transaction).toBe("function");
      expect(typeof client.rawQuery).toBe("function");
    });
  });

  describe("getDb", () => {
    it("should return a Drizzle database instance", async () => {
      const { createDrizzleClient } = await import("./client.js");

      const mockPool = {
        query: vi.fn(),
        connect: vi.fn(),
        end: vi.fn(),
        on: vi.fn(),
      } as unknown as Pool;

      const client = createDrizzleClient(mockPool);
      const db = client.getDb();

      expect(db).toBeDefined();
    });
  });

  describe("transaction", () => {
    it("should execute callback within a transaction context", async () => {
      const { createDrizzleClient } = await import("./client.js");

      const mockPool = {
        query: vi.fn(),
        connect: vi.fn(),
        end: vi.fn(),
        on: vi.fn(),
      } as unknown as Pool;

      const client = createDrizzleClient(mockPool);

      const callback = vi.fn().mockResolvedValue("result");

      const result = await client.transaction(callback);

      expect(callback).toHaveBeenCalled();
      expect(result).toBe("result");
    });
  });

  describe("rawQuery", () => {
    it("should execute raw SQL query", async () => {
      const { createDrizzleClient } = await import("./client.js");

      const mockQueryResult = { rows: [{ id: 1, name: "test" }] };
      const mockQuery = vi.fn().mockResolvedValue(mockQueryResult);
      const mockPool = {
        query: mockQuery,
        connect: vi.fn(),
        end: vi.fn(),
        on: vi.fn(),
      } as unknown as Pool;

      const client = createDrizzleClient(mockPool);

      const result = await client.rawQuery<{ id: number; name: string }>(
        "SELECT * FROM users WHERE id = $1",
        [1],
      );

      expect(result).toEqual([{ id: 1, name: "test" }]);
      expect(mockQuery).toHaveBeenCalledWith(
        "SELECT * FROM users WHERE id = $1",
        [1],
      );
    });

    it("should execute raw SQL query without params", async () => {
      const { createDrizzleClient } = await import("./client.js");

      const mockQueryResult = { rows: [{ count: 10 }] };
      const mockQuery = vi.fn().mockResolvedValue(mockQueryResult);
      const mockPool = {
        query: mockQuery,
        connect: vi.fn(),
        end: vi.fn(),
        on: vi.fn(),
      } as unknown as Pool;

      const client = createDrizzleClient(mockPool);

      const result = await client.rawQuery<{ count: number }>(
        "SELECT count(*) FROM users",
      );

      expect(result).toEqual([{ count: 10 }]);
      expect(mockQuery).toHaveBeenCalledWith(
        "SELECT count(*) FROM users",
        undefined,
      );
    });
  });

  describe("QueryError", () => {
    it("should have proper error structure for QUERY_FAILED", async () => {
      const { QueryError } = await import("./client.js");

      const error = new QueryError(
        "QUERY_FAILED",
        "Failed to execute query",
        "Syntax error",
      );

      expect(error.code).toBe("QUERY_FAILED");
      expect(error.message).toBe("Failed to execute query");
      expect(error.detail).toBe("Syntax error");
      expect(error.name).toBe("QueryError");
    });

    it("should have proper error structure for CONSTRAINT_VIOLATION", async () => {
      const { QueryError } = await import("./client.js");

      const error = new QueryError(
        "CONSTRAINT_VIOLATION",
        "Unique constraint violated",
      );

      expect(error.code).toBe("CONSTRAINT_VIOLATION");
      expect(error.message).toBe("Unique constraint violated");
      expect(error.detail).toBeUndefined();
    });

    it("should have proper error structure for TRANSACTION_FAILED", async () => {
      const { QueryError } = await import("./client.js");

      const error = new QueryError("TRANSACTION_FAILED", "Transaction aborted");

      expect(error.code).toBe("TRANSACTION_FAILED");
      expect(error.message).toBe("Transaction aborted");
    });
  });
});
