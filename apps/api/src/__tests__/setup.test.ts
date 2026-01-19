import { sql } from "drizzle-orm";
import { drizzle } from "drizzle-orm/node-postgres";
import { describe, expect, it } from "vitest";
import { getGlobalTestPool } from "../../vitest.setup";

describe("Test Setup", () => {
  describe("database connection", () => {
    it("should have a valid DATABASE_URL", () => {
      expect(process.env.DATABASE_URL).toBeDefined();
      expect(process.env.DATABASE_URL).toContain("postgres");
    });

    it("should connect to the test database successfully", async () => {
      const pool = getGlobalTestPool();
      const result = await pool.query("SELECT 1 as value");

      expect(result.rows[0].value).toBe(1);
    });

    it("should have access to Drizzle ORM", async () => {
      const pool = getGlobalTestPool();
      const db = drizzle(pool);

      const result = await db.execute<{ value: number }>(
        sql`SELECT 1 as value`,
      );

      expect(result.rows[0].value).toBe(1);
    });
  });

  describe("migrations", () => {
    it("should have users table created", async () => {
      const pool = getGlobalTestPool();
      const result = await pool.query(`
        SELECT EXISTS (
          SELECT FROM information_schema.tables
          WHERE table_schema = 'public'
          AND table_name = 'users'
        ) as exists
      `);

      expect(result.rows[0].exists).toBe(true);
    });

    it("should have correct users table schema", async () => {
      const pool = getGlobalTestPool();
      const result = await pool.query(`
        SELECT column_name, data_type
        FROM information_schema.columns
        WHERE table_name = 'users'
        ORDER BY ordinal_position
      `);

      const columns = result.rows.map(
        (row: { column_name: string; data_type: string }) => ({
          name: row.column_name,
          type: row.data_type,
        }),
      );

      expect(columns).toContainEqual({ name: "id", type: "integer" });
      expect(columns).toContainEqual({ name: "email", type: "text" });
      expect(columns).toContainEqual({
        name: "created_at",
        type: "timestamp without time zone",
      });
      expect(columns).toContainEqual({
        name: "updated_at",
        type: "timestamp without time zone",
      });
    });
  });

  describe("data cleanup", () => {
    it("should start each test with empty tables", async () => {
      const pool = getGlobalTestPool();
      const db = drizzle(pool);

      const result = await db.execute<{ count: string }>(
        sql`SELECT count(*) FROM users`,
      );

      expect(Number.parseInt(result.rows[0].count, 10)).toBe(0);
    });

    it("should cleanup data between tests", async () => {
      const pool = getGlobalTestPool();
      const db = drizzle(pool);

      await db.execute(
        sql`INSERT INTO users (email) VALUES ('test@example.com')`,
      );

      const resultAfterInsert = await db.execute<{ count: string }>(
        sql`SELECT count(*) FROM users`,
      );
      expect(Number.parseInt(resultAfterInsert.rows[0].count, 10)).toBe(1);
    });
  });

  describe("environment", () => {
    it("should be running in test environment", () => {
      expect(process.env.NODE_ENV).toBe("test");
    });
  });
});
