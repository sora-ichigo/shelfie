import path from "node:path";
import dotenv from "dotenv";
import { sql } from "drizzle-orm";
import { drizzle } from "drizzle-orm/node-postgres";
import { Pool } from "pg";
import { afterAll, beforeAll, beforeEach } from "vitest";

dotenv.config({ path: path.resolve(__dirname, ".env.test.local") });

let testPool: Pool | null = null;
let migrationChecked = false;

function getTestDatabaseUrl(): string {
  const url = process.env.DATABASE_URL;
  if (!url) {
    throw new Error("DATABASE_URL is not set for tests");
  }
  return url;
}

function getGlobalTestPool(): Pool {
  if (!testPool) {
    testPool = new Pool({
      connectionString: getTestDatabaseUrl(),
      max: 10,
    });
  }
  return testPool;
}

async function checkMigrations(): Promise<void> {
  if (migrationChecked) return;

  const pool = getGlobalTestPool();
  const db = drizzle(pool);

  const tables = await db.execute<{ tablename: string }>(sql`
    SELECT tablename FROM pg_tables WHERE schemaname = 'public' AND tablename != 'drizzle_migrations'
  `);

  if (tables.rows.length === 0) {
    throw new Error(
      "No tables found in test database. Please run migrations first:\n" +
        "  pnpm --filter @shelfie/api test:db:migrate",
    );
  }

  migrationChecked = true;
}

async function cleanupAllTables(): Promise<void> {
  const pool = getGlobalTestPool();
  const db = drizzle(pool);

  const tables = await db.execute<{ tablename: string }>(sql`
    SELECT tablename FROM pg_tables WHERE schemaname = 'public'
  `);

  for (const { tablename } of tables.rows) {
    if (tablename !== "drizzle_migrations") {
      await db.execute(
        sql.raw(`TRUNCATE TABLE "${tablename}" RESTART IDENTITY CASCADE`),
      );
    }
  }
}

async function closeGlobalTestPool(): Promise<void> {
  if (testPool) {
    await testPool.end();
    testPool = null;
  }
}

beforeAll(async () => {
  await checkMigrations();
});

beforeEach(async () => {
  await cleanupAllTables();
});

afterAll(async () => {
  await closeGlobalTestPool();
});

export { getGlobalTestPool, cleanupAllTables };
