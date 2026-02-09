import {
  index,
  integer,
  pgTable,
  text,
  timestamp,
  uniqueIndex,
} from "drizzle-orm/pg-core";
import { users } from "./users";

export const DEVICE_TOKENS_USER_TOKEN_UNIQUE_INDEX_NAME =
  "idx_device_tokens_user_token";
export const DEVICE_TOKENS_USER_ID_INDEX_NAME = "idx_device_tokens_user_id";

export const deviceTokens = pgTable(
  "device_tokens",
  {
    id: integer("id").primaryKey().generatedAlwaysAsIdentity(),
    userId: integer("user_id")
      .notNull()
      .references(() => users.id, { onDelete: "cascade" }),
    token: text("token").notNull(),
    platform: text("platform").notNull(),
    createdAt: timestamp("created_at").defaultNow().notNull(),
    updatedAt: timestamp("updated_at").defaultNow().notNull(),
  },
  (table) => [
    uniqueIndex(DEVICE_TOKENS_USER_TOKEN_UNIQUE_INDEX_NAME).on(
      table.userId,
      table.token,
    ),
    index(DEVICE_TOKENS_USER_ID_INDEX_NAME).on(table.userId),
  ],
);

export type DeviceToken = typeof deviceTokens.$inferSelect;
export type NewDeviceToken = typeof deviceTokens.$inferInsert;
