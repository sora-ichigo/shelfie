import fs from "node:fs";
import path from "node:path";
import { drizzle, type NodePgDatabase } from "drizzle-orm/node-postgres";
import { Pool, type PoolConfig } from "pg";
import { config } from "../config/index.js";

export * from "./schema/index.js";

let pool: Pool | null = null;
let db: NodePgDatabase | null = null;

function getDatabaseUrl(): string {
  const url = config.get("DATABASE_URL");
  if (!url) {
    throw new Error("DATABASE_URL environment variable is not set");
  }
  return url;
}

function getSslConfig(): PoolConfig["ssl"] {
  if (config.isTest() || config.isDevelopment()) {
    return undefined;
  }

  const certPath = path.join(import.meta.dirname, "../certs/supabase-ca.crt");
  if (fs.existsSync(certPath)) {
    return { ca: fs.readFileSync(certPath).toString() };
  }

  return true;
}

export function getPool(): Pool {
  if (!pool) {
    pool = new Pool({
      connectionString: getDatabaseUrl(),
      ssl: getSslConfig(),
      max: config.getOrDefault("DB_POOL_MAX", 20),
      idleTimeoutMillis: config.getOrDefault("DB_IDLE_TIMEOUT_MS", 30000),
      connectionTimeoutMillis: config.getOrDefault(
        "DB_CONNECTION_TIMEOUT_MS",
        5000,
      ),
    });

    pool.on("error", (err) => {
      console.error("Unexpected error on idle client", err);
    });
  }
  return pool;
}

export function getDb(): NodePgDatabase {
  if (!db) {
    db = drizzle(getPool());
  }
  return db;
}

export async function closePool(): Promise<void> {
  if (pool) {
    await pool.end();
    pool = null;
    db = null;
  }
}

export function createDb(customPool: Pool): NodePgDatabase {
  return drizzle(customPool);
}
