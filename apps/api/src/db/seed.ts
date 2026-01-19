import { drizzle } from "drizzle-orm/node-postgres";
import { Pool } from "pg";
import { sql } from "drizzle-orm";
import * as schema from "./schema/index.js";
import { config } from "../config/index.js";

export interface SeedData {
  users: Array<{
    email: string;
  }>;
}

export const seedData: SeedData = {
  users: [{ email: "admin@example.com" }, { email: "user@example.com" }],
};

async function createPool(): Promise<Pool> {
  const connectionString = config.get("DATABASE_URL");
  if (!connectionString) {
    throw new Error("DATABASE_URL is not set");
  }
  return new Pool({ connectionString });
}

export async function seed(pool?: Pool): Promise<void> {
  const poolToUse = pool ?? (await createPool());
  const shouldClosePool = !pool;

  try {
    const db = drizzle(poolToUse);

    console.log("Seeding database...");

    for (const userData of seedData.users) {
      const existing = await db
        .select()
        .from(schema.users)
        .where(sql`${schema.users.email} = ${userData.email}`)
        .limit(1);

      if (existing.length === 0) {
        await db.insert(schema.users).values(userData);
        console.log(`  Created user: ${userData.email}`);
      } else {
        console.log(`  User already exists: ${userData.email}`);
      }
    }

    console.log("Seeding completed.");
  } finally {
    if (shouldClosePool) {
      await poolToUse.end();
    }
  }
}

export async function clearDatabase(pool?: Pool): Promise<void> {
  const poolToUse = pool ?? (await createPool());
  const shouldClosePool = !pool;

  try {
    const db = drizzle(poolToUse);

    console.log("Clearing database...");

    await db.delete(schema.users);
    console.log("  Cleared users table");

    console.log("Database cleared.");
  } finally {
    if (shouldClosePool) {
      await poolToUse.end();
    }
  }
}

const isMainModule = import.meta.url === `file://${process.argv[1]}`;
if (isMainModule) {
  seed()
    .then(() => process.exit(0))
    .catch((err) => {
      console.error("Seed failed:", err);
      process.exit(1);
    });
}
