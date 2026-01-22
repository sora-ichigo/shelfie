import { sql } from "drizzle-orm";
import { drizzle } from "drizzle-orm/node-postgres";
import { Pool } from "pg";
import { config } from "../config/index.js";

let testPool: Pool | null = null;

export function getTestDatabaseUrl(): string {
  const url = config.get("DATABASE_URL");
  if (!url) {
    throw new Error("DATABASE_URL is not set for tests");
  }
  return url;
}

export function getTestPool(): Pool {
  if (!testPool) {
    testPool = new Pool({
      connectionString: getTestDatabaseUrl(),
      max: 5,
    });
  }
  return testPool;
}

export async function setupTestDatabase(): Promise<void> {
  const pool = getTestPool();
  const db = drizzle(pool);

  await db.execute(sql`
    CREATE TABLE IF NOT EXISTS users (
      id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
      email TEXT NOT NULL UNIQUE,
      firebase_uid TEXT NOT NULL UNIQUE,
      created_at TIMESTAMP NOT NULL DEFAULT NOW(),
      updated_at TIMESTAMP NOT NULL DEFAULT NOW()
    )
  `);

  await db.execute(sql`
    CREATE INDEX IF NOT EXISTS idx_users_firebase_uid ON users(firebase_uid)
  `);

  await db.execute(sql`
    CREATE TABLE IF NOT EXISTS user_books (
      id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
      user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
      external_id TEXT NOT NULL,
      title TEXT NOT NULL,
      authors TEXT[] NOT NULL DEFAULT '{}',
      publisher TEXT,
      published_date TEXT,
      isbn TEXT,
      cover_image_url TEXT,
      added_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
      UNIQUE(user_id, external_id)
    )
  `);

  await db.execute(sql`
    CREATE INDEX IF NOT EXISTS idx_user_books_user_id ON user_books(user_id)
  `);
}

export async function cleanupTestDatabase(): Promise<void> {
  const pool = getTestPool();
  const db = drizzle(pool);

  await db.execute(sql`TRUNCATE TABLE user_books RESTART IDENTITY CASCADE`);
  await db.execute(sql`TRUNCATE TABLE users RESTART IDENTITY CASCADE`);
}

export async function dropTestTables(): Promise<void> {
  const pool = getTestPool();
  const db = drizzle(pool);

  await db.execute(sql`DROP TABLE IF EXISTS user_books CASCADE`);
  await db.execute(sql`DROP TABLE IF EXISTS users CASCADE`);
}

export async function closeTestPool(): Promise<void> {
  if (testPool) {
    await testPool.end();
    testPool = null;
  }
}
