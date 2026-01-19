import { drizzle, type NodePgDatabase } from "drizzle-orm/node-postgres";
import type { Pool } from "pg";

type QueryErrorCode =
  | "QUERY_FAILED"
  | "CONSTRAINT_VIOLATION"
  | "TRANSACTION_FAILED";

export class QueryError extends Error {
  public readonly code: QueryErrorCode;
  public readonly detail?: string;

  constructor(code: QueryErrorCode, message: string, detail?: string) {
    super(message);
    this.name = "QueryError";
    this.code = code;
    this.detail = detail;
  }
}

export interface DrizzleClient {
  getDb(): NodePgDatabase;
  transaction<T>(callback: (tx: NodePgDatabase) => Promise<T>): Promise<T>;
  rawQuery<T>(sql: string, params?: unknown[]): Promise<T[]>;
}

export function createDrizzleClient(pool: Pool): DrizzleClient {
  const db = drizzle(pool);

  return {
    getDb(): NodePgDatabase {
      return db;
    },

    async transaction<T>(
      callback: (tx: NodePgDatabase) => Promise<T>,
    ): Promise<T> {
      try {
        return await db.transaction(callback);
      } catch (err) {
        const message = err instanceof Error ? err.message : String(err);
        throw new QueryError(
          "TRANSACTION_FAILED",
          `Transaction failed: ${message}`,
        );
      }
    },

    async rawQuery<T>(sql: string, params?: unknown[]): Promise<T[]> {
      try {
        const result = await pool.query(sql, params);
        return result.rows as T[];
      } catch (err) {
        const message = err instanceof Error ? err.message : String(err);
        const pgError = err as { code?: string; detail?: string };

        if (pgError.code === "23505" || pgError.code === "23503") {
          throw new QueryError(
            "CONSTRAINT_VIOLATION",
            `Constraint violation: ${message}`,
            pgError.detail,
          );
        }

        throw new QueryError("QUERY_FAILED", `Query failed: ${message}`);
      }
    },
  };
}
