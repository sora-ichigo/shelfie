import path from "node:path";
import dotenv from "dotenv";
import { sql } from "drizzle-orm";
import { drizzle } from "drizzle-orm/node-postgres";
import { Pool } from "pg";

dotenv.config({ path: path.resolve(__dirname, ".env.test.local") });

export async function setup() {
  const url = process.env.DATABASE_URL;
  if (!url) {
    throw new Error("DATABASE_URL is not set for tests");
  }

  const pool = new Pool({ connectionString: url, max: 1 });
  const db = drizzle(pool);

  const tables = await db.execute<{ tablename: string }>(sql`
    SELECT tablename FROM pg_tables WHERE schemaname = 'public' AND tablename != 'drizzle_migrations'
  `);

  if (tables.rows.length === 0) {
    await pool.end();
    throw new Error(
      "No tables found in test database. Please run migrations first:\n" +
        "  pnpm --filter @shelfie/api test:db:migrate",
    );
  }

  await pool.end();
}
