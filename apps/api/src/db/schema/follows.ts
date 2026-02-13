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
export const FOLLOWS_FOLLOWER_INDEX_NAME = "idx_follows_follower";
export const FOLLOWS_FOLLOWEE_INDEX_NAME = "idx_follows_followee";

export const follows = pgTable(
  "follows",
  {
    id: integer("id").primaryKey().generatedAlwaysAsIdentity(),
    followerId: integer("follower_id")
      .notNull()
      .references(() => users.id, { onDelete: "cascade" }),
    followeeId: integer("followee_id")
      .notNull()
      .references(() => users.id, { onDelete: "cascade" }),
    createdAt: timestamp("created_at").defaultNow().notNull(),
  },
  (table) => [
    unique(FOLLOWS_UNIQUE_NAME).on(table.followerId, table.followeeId),
    index(FOLLOWS_FOLLOWER_INDEX_NAME).on(table.followerId),
    index(FOLLOWS_FOLLOWEE_INDEX_NAME).on(table.followeeId),
    check(
      "chk_no_self_follow",
      sql`${table.followerId} != ${table.followeeId}`,
    ),
  ],
);

export type Follow = typeof follows.$inferSelect;
export type NewFollow = typeof follows.$inferInsert;
