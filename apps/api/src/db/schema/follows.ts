import { sql } from "drizzle-orm";
import {
  check,
  index,
  integer,
  pgTable,
  timestamp,
  unique,
} from "drizzle-orm/pg-core";
import { users } from "./users";

export const FOLLOWS_UNIQUE_NAME = "uq_follow";
export const FOLLOWS_USER_A_INDEX_NAME = "idx_follows_user_a";
export const FOLLOWS_USER_B_INDEX_NAME = "idx_follows_user_b";

export const follows = pgTable(
  "follows",
  {
    id: integer("id").primaryKey().generatedAlwaysAsIdentity(),
    userIdA: integer("user_id_a")
      .notNull()
      .references(() => users.id, { onDelete: "cascade" }),
    userIdB: integer("user_id_b")
      .notNull()
      .references(() => users.id, { onDelete: "cascade" }),
    createdAt: timestamp("created_at").defaultNow().notNull(),
  },
  (table) => [
    unique(FOLLOWS_UNIQUE_NAME).on(table.userIdA, table.userIdB),
    index(FOLLOWS_USER_A_INDEX_NAME).on(table.userIdA),
    index(FOLLOWS_USER_B_INDEX_NAME).on(table.userIdB),
    check("chk_ordered", sql`${table.userIdA} < ${table.userIdB}`),
  ],
);

export type Follow = typeof follows.$inferSelect;
export type NewFollow = typeof follows.$inferInsert;
