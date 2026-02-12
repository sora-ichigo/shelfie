import {
  boolean,
  index,
  integer,
  pgTable,
  text,
  timestamp,
} from "drizzle-orm/pg-core";
import { users } from "./users";

export const NOTIFICATIONS_RECIPIENT_READ_INDEX_NAME =
  "idx_notifications_recipient_read";
export const NOTIFICATIONS_RECIPIENT_CREATED_INDEX_NAME =
  "idx_notifications_recipient_created";

export const notifications = pgTable(
  "notifications",
  {
    id: integer("id").primaryKey().generatedAlwaysAsIdentity(),
    recipientId: integer("recipient_id")
      .notNull()
      .references(() => users.id, { onDelete: "cascade" }),
    senderId: integer("sender_id")
      .notNull()
      .references(() => users.id, { onDelete: "cascade" }),
    type: text("type").notNull(),
    isRead: boolean("is_read").notNull().default(false),
    createdAt: timestamp("created_at").defaultNow().notNull(),
  },
  (table) => [
    index(NOTIFICATIONS_RECIPIENT_READ_INDEX_NAME).on(
      table.recipientId,
      table.isRead,
    ),
    index(NOTIFICATIONS_RECIPIENT_CREATED_INDEX_NAME).on(
      table.recipientId,
      table.createdAt,
    ),
  ],
);

export type AppNotification = typeof notifications.$inferSelect;
export type NewAppNotification = typeof notifications.$inferInsert;
