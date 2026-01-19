import { afterAll, afterEach, beforeAll, describe, expect, it } from "vitest";
import {
  createDrizzleClient,
  type DrizzleClient,
  QueryError,
} from "./client.js";
import { users } from "./schema/users.js";
import { closeTestPool, getTestPool } from "./test-utils.js";

describe("DrizzleClient", () => {
  let client: DrizzleClient;

  beforeAll(async () => {
    const pool = getTestPool();
    client = createDrizzleClient(pool);
  });

  afterAll(async () => {
    await closeTestPool();
  });

  describe("createDrizzleClient", () => {
    it("should create a Drizzle client from a Pool instance", () => {
      expect(client).toBeDefined();
      expect(typeof client.getDb).toBe("function");
      expect(typeof client.transaction).toBe("function");
      expect(typeof client.rawQuery).toBe("function");
    });
  });

  describe("getDb", () => {
    it("should return a Drizzle database instance", () => {
      const db = client.getDb();

      expect(db).toBeDefined();
    });

    it("should allow inserting and selecting data", async () => {
      const db = client.getDb();

      await db
        .insert(users)
        .values({ email: "test@example.com", firebaseUid: "firebase-uid-1" });

      const result = await db.select().from(users);

      expect(result).toHaveLength(1);
      expect(result[0].email).toBe("test@example.com");
      expect(result[0].firebaseUid).toBe("firebase-uid-1");
      expect(result[0].id).toBe(1);
    });
  });

  describe("transaction", () => {
    it("should execute callback within a transaction context", async () => {
      const result = await client.transaction(async (tx) => {
        await tx
          .insert(users)
          .values({ email: "tx@example.com", firebaseUid: "firebase-uid-tx" });
        const inserted = await tx.select().from(users);
        return inserted[0];
      });

      expect(result.email).toBe("tx@example.com");
      expect(result.firebaseUid).toBe("firebase-uid-tx");
    });

    it("should rollback on error", async () => {
      await expect(
        client.transaction(async (tx) => {
          await tx.insert(users).values({
            email: "rollback@example.com",
            firebaseUid: "firebase-uid-rollback",
          });
          throw new Error("Force rollback");
        }),
      ).rejects.toThrow(QueryError);

      const db = client.getDb();
      const result = await db.select().from(users);

      expect(result).toHaveLength(0);
    });
  });

  describe("rawQuery", () => {
    it("should execute raw SQL query", async () => {
      const db = client.getDb();
      await db
        .insert(users)
        .values({ email: "raw@example.com", firebaseUid: "firebase-uid-raw" });

      const result = await client.rawQuery<{ id: number; email: string }>(
        "SELECT id, email FROM users WHERE email = $1",
        ["raw@example.com"],
      );

      expect(result).toHaveLength(1);
      expect(result[0].email).toBe("raw@example.com");
    });

    it("should execute raw SQL query without params", async () => {
      const db = client.getDb();
      await db
        .insert(users)
        .values({ email: "count@example.com", firebaseUid: "firebase-uid-cnt" });

      const result = await client.rawQuery<{ count: string }>(
        "SELECT count(*) FROM users",
      );

      expect(Number.parseInt(result[0].count, 10)).toBe(1);
    });
  });

  describe("QueryError", () => {
    it("should have proper error structure for QUERY_FAILED", () => {
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

    it("should have proper error structure for CONSTRAINT_VIOLATION", () => {
      const error = new QueryError(
        "CONSTRAINT_VIOLATION",
        "Unique constraint violated",
      );

      expect(error.code).toBe("CONSTRAINT_VIOLATION");
      expect(error.message).toBe("Unique constraint violated");
      expect(error.detail).toBeUndefined();
    });

    it("should have proper error structure for TRANSACTION_FAILED", () => {
      const error = new QueryError("TRANSACTION_FAILED", "Transaction aborted");

      expect(error.code).toBe("TRANSACTION_FAILED");
      expect(error.message).toBe("Transaction aborted");
    });
  });
});
