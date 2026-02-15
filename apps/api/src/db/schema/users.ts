import {
  boolean,
  index,
  integer,
  pgTable,
  text,
  timestamp,
} from "drizzle-orm/pg-core";

export const USERS_FIREBASE_UID_INDEX_NAME = "idx_users_firebase_uid";

export const users = pgTable(
  "users",
  {
    id: integer("id").primaryKey().generatedAlwaysAsIdentity(),
    email: text("email").notNull().unique(),
    firebaseUid: text("firebase_uid").notNull().unique(),
    name: text("name"),
    avatarUrl: text("avatar_url"),
    bio: text("bio"),
    instagramHandle: text("instagram_handle"),
    handle: text("handle").unique(),
    isPublic: boolean("is_public").default(false).notNull(),
    createdAt: timestamp("created_at").defaultNow().notNull(),
    updatedAt: timestamp("updated_at").defaultNow().notNull(),
  },
  (table) => [index(USERS_FIREBASE_UID_INDEX_NAME).on(table.firebaseUid)],
);

export type User = typeof users.$inferSelect;
export type NewUser = typeof users.$inferInsert;
