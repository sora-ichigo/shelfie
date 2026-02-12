import { sql } from "drizzle-orm";
import {
  check,
  index,
  integer,
  pgTable,
  text,
  timestamp,
  unique,
} from "drizzle-orm/pg-core";
import { users } from "./users";

export const FOLLOW_REQUESTS_UNIQUE_NAME = "uq_follow_request";
export const FOLLOW_REQUESTS_RECEIVER_STATUS_INDEX_NAME =
  "idx_follow_requests_receiver_status";
export const FOLLOW_REQUESTS_SENDER_INDEX_NAME = "idx_follow_requests_sender";

export const followRequests = pgTable(
  "follow_requests",
  {
    id: integer("id").primaryKey().generatedAlwaysAsIdentity(),
    senderId: integer("sender_id")
      .notNull()
      .references(() => users.id, { onDelete: "cascade" }),
    receiverId: integer("receiver_id")
      .notNull()
      .references(() => users.id, { onDelete: "cascade" }),
    status: text("status").notNull().default("pending"),
    createdAt: timestamp("created_at").defaultNow().notNull(),
    updatedAt: timestamp("updated_at").defaultNow().notNull(),
  },
  (table) => [
    unique(FOLLOW_REQUESTS_UNIQUE_NAME).on(table.senderId, table.receiverId),
    index(FOLLOW_REQUESTS_RECEIVER_STATUS_INDEX_NAME).on(
      table.receiverId,
      table.status,
    ),
    index(FOLLOW_REQUESTS_SENDER_INDEX_NAME).on(table.senderId),
    check("chk_no_self_request", sql`${table.senderId} != ${table.receiverId}`),
  ],
);

export type FollowRequest = typeof followRequests.$inferSelect;
export type NewFollowRequest = typeof followRequests.$inferInsert;
