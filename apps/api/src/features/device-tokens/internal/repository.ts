import { and, eq, inArray } from "drizzle-orm";
import type { NodePgDatabase } from "drizzle-orm/node-postgres";
import {
  type DeviceToken,
  type NewDeviceToken,
  deviceTokens,
} from "../../../db/schema/device-tokens.js";

export type { DeviceToken, NewDeviceToken } from "../../../db/schema/device-tokens.js";

export interface DeviceTokenRepository {
  upsert(data: NewDeviceToken): Promise<DeviceToken>;
  deleteByUserAndToken(userId: number, token: string): Promise<void>;
  deleteByTokens(tokens: string[]): Promise<void>;
  findByUserId(userId: number): Promise<DeviceToken[]>;
  findByUserIds(userIds: number[]): Promise<DeviceToken[]>;
  findAll(): Promise<DeviceToken[]>;
}

export function createDeviceTokenRepository(
  db: NodePgDatabase,
): DeviceTokenRepository {
  return {
    async upsert(data: NewDeviceToken): Promise<DeviceToken> {
      const result = await db
        .insert(deviceTokens)
        .values(data)
        .onConflictDoUpdate({
          target: [deviceTokens.userId, deviceTokens.token],
          set: { updatedAt: new Date() },
        })
        .returning();
      return result[0];
    },

    async deleteByUserAndToken(userId: number, token: string): Promise<void> {
      await db
        .delete(deviceTokens)
        .where(
          and(
            eq(deviceTokens.userId, userId),
            eq(deviceTokens.token, token),
          ),
        );
    },

    async deleteByTokens(tokens: string[]): Promise<void> {
      if (tokens.length === 0) return;
      await db
        .delete(deviceTokens)
        .where(inArray(deviceTokens.token, tokens));
    },

    async findByUserId(userId: number): Promise<DeviceToken[]> {
      return db
        .select()
        .from(deviceTokens)
        .where(eq(deviceTokens.userId, userId));
    },

    async findByUserIds(userIds: number[]): Promise<DeviceToken[]> {
      if (userIds.length === 0) return [];
      return db
        .select()
        .from(deviceTokens)
        .where(inArray(deviceTokens.userId, userIds));
    },

    async findAll(): Promise<DeviceToken[]> {
      return db.select().from(deviceTokens);
    },
  };
}
