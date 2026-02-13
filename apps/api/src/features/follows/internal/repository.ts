import { and, count, desc, eq, inArray, lt, sql } from "drizzle-orm";
import type { NodePgDatabase } from "drizzle-orm/node-postgres";
import {
  type FollowRequest,
  followRequests,
  type NewFollowRequest,
} from "../../../db/schema/follow-requests.js";
import { type Follow, follows } from "../../../db/schema/follows.js";
import { type User, users } from "../../../db/schema/users.js";

export type {
  FollowRequest,
  NewFollowRequest,
} from "../../../db/schema/follow-requests.js";
export type { Follow } from "../../../db/schema/follows.js";

export type FollowRequestStatus = "pending" | "approved" | "rejected";

export interface FollowWithUser {
  followId: number;
  user: User;
  createdAt: Date;
}

export interface FollowRepository {
  createRequest(data: NewFollowRequest): Promise<FollowRequest>;
  findRequestById(id: number): Promise<FollowRequest | null>;
  findRequestBySenderAndReceiver(
    senderId: number,
    receiverId: number,
  ): Promise<FollowRequest | null>;
  findPendingRequestsByReceiver(
    receiverId: number,
    cursor: number | null,
    limit: number,
  ): Promise<FollowRequest[]>;
  countPendingRequestsByReceiver(receiverId: number): Promise<number>;
  updateRequestStatus(
    id: number,
    status: FollowRequestStatus,
  ): Promise<FollowRequest>;
  deleteRequest(id: number): Promise<void>;
  createFollow(followerId: number, followeeId: number): Promise<Follow>;
  deleteFollow(followerId: number, followeeId: number): Promise<void>;
  findFollow(followerId: number, followeeId: number): Promise<Follow | null>;
  findFollowing(
    userId: number,
    cursor: number | null,
    limit: number,
  ): Promise<FollowWithUser[]>;
  findFollowers(
    userId: number,
    cursor: number | null,
    limit: number,
  ): Promise<FollowWithUser[]>;
  countFollowing(userId: number): Promise<number>;
  countFollowers(userId: number): Promise<number>;
  findFollowsBatch(userId: number, targetIds: number[]): Promise<Set<number>>;
  findFollowersBatch(userId: number, targetIds: number[]): Promise<Set<number>>;
  findPendingSentRequestsBatch(
    senderId: number,
    receiverIds: number[],
  ): Promise<Set<number>>;
  findPendingReceivedRequestsBatch(
    receiverId: number,
    senderIds: number[],
  ): Promise<Set<number>>;
}

export function createFollowRepository(db: NodePgDatabase): FollowRepository {
  async function findFollowUsersBy(
    filterColumn: "followerId" | "followeeId",
    otherColumn: "followerId" | "followeeId",
    userId: number,
    cursor: number | null,
    limit: number,
  ): Promise<FollowWithUser[]> {
    const conditions = [eq(follows[filterColumn], userId)];
    if (cursor !== null) {
      conditions.push(lt(follows.id, cursor));
    }

    const followResults = await db
      .select()
      .from(follows)
      .where(and(...conditions))
      .orderBy(desc(follows.id))
      .limit(limit);

    if (followResults.length === 0) return [];

    const otherUserIds = followResults.map((f) => f[otherColumn]);

    const userResults = await db
      .select()
      .from(users)
      .where(
        otherUserIds.length === 1
          ? eq(users.id, otherUserIds[0])
          : sql`${users.id} IN (${sql.join(
              otherUserIds.map((id) => sql`${id}`),
              sql`, `,
            )})`,
      );

    const userMap = new Map(userResults.map((u) => [u.id, u]));

    return followResults
      .map((f) => {
        const user = userMap.get(f[otherColumn]);
        if (!user) return null;
        return {
          followId: f.id,
          user,
          createdAt: f.createdAt,
        };
      })
      .filter((item): item is FollowWithUser => item !== null);
  }

  return {
    async createRequest(data: NewFollowRequest): Promise<FollowRequest> {
      const result = await db.insert(followRequests).values(data).returning();
      return result[0];
    },

    async findRequestById(id: number): Promise<FollowRequest | null> {
      const result = await db
        .select()
        .from(followRequests)
        .where(eq(followRequests.id, id));
      return result[0] ?? null;
    },

    async findRequestBySenderAndReceiver(
      senderId: number,
      receiverId: number,
    ): Promise<FollowRequest | null> {
      const result = await db
        .select()
        .from(followRequests)
        .where(
          and(
            eq(followRequests.senderId, senderId),
            eq(followRequests.receiverId, receiverId),
          ),
        );
      return result[0] ?? null;
    },

    async findPendingRequestsByReceiver(
      receiverId: number,
      cursor: number | null,
      limit: number,
    ): Promise<FollowRequest[]> {
      const conditions = [
        eq(followRequests.receiverId, receiverId),
        eq(followRequests.status, "pending"),
      ];
      if (cursor !== null) {
        conditions.push(lt(followRequests.id, cursor));
      }

      return db
        .select()
        .from(followRequests)
        .where(and(...conditions))
        .orderBy(desc(followRequests.id))
        .limit(limit);
    },

    async countPendingRequestsByReceiver(receiverId: number): Promise<number> {
      const result = await db
        .select({ count: count() })
        .from(followRequests)
        .where(
          and(
            eq(followRequests.receiverId, receiverId),
            eq(followRequests.status, "pending"),
          ),
        );
      return result[0]?.count ?? 0;
    },

    async updateRequestStatus(
      id: number,
      status: FollowRequestStatus,
    ): Promise<FollowRequest> {
      const result = await db
        .update(followRequests)
        .set({ status, updatedAt: new Date() })
        .where(eq(followRequests.id, id))
        .returning();
      return result[0];
    },

    async deleteRequest(id: number): Promise<void> {
      await db.delete(followRequests).where(eq(followRequests.id, id));
    },

    async createFollow(
      followerId: number,
      followeeId: number,
    ): Promise<Follow> {
      const result = await db
        .insert(follows)
        .values({ followerId, followeeId })
        .returning();
      return result[0];
    },

    async deleteFollow(followerId: number, followeeId: number): Promise<void> {
      await db
        .delete(follows)
        .where(
          and(
            eq(follows.followerId, followerId),
            eq(follows.followeeId, followeeId),
          ),
        );
    },

    async findFollow(
      followerId: number,
      followeeId: number,
    ): Promise<Follow | null> {
      const result = await db
        .select()
        .from(follows)
        .where(
          and(
            eq(follows.followerId, followerId),
            eq(follows.followeeId, followeeId),
          ),
        );
      return result[0] ?? null;
    },

    async findFollowing(
      userId: number,
      cursor: number | null,
      limit: number,
    ): Promise<FollowWithUser[]> {
      return findFollowUsersBy(
        "followerId",
        "followeeId",
        userId,
        cursor,
        limit,
      );
    },

    async findFollowers(
      userId: number,
      cursor: number | null,
      limit: number,
    ): Promise<FollowWithUser[]> {
      return findFollowUsersBy(
        "followeeId",
        "followerId",
        userId,
        cursor,
        limit,
      );
    },

    async countFollowing(userId: number): Promise<number> {
      const result = await db
        .select({ count: count() })
        .from(follows)
        .where(eq(follows.followerId, userId));
      return result[0]?.count ?? 0;
    },

    async countFollowers(userId: number): Promise<number> {
      const result = await db
        .select({ count: count() })
        .from(follows)
        .where(eq(follows.followeeId, userId));
      return result[0]?.count ?? 0;
    },

    async findFollowsBatch(
      userId: number,
      targetIds: number[],
    ): Promise<Set<number>> {
      if (targetIds.length === 0) return new Set();

      const result = await db
        .select()
        .from(follows)
        .where(
          and(
            eq(follows.followerId, userId),
            inArray(follows.followeeId, targetIds),
          ),
        );

      return new Set(result.map((f) => f.followeeId));
    },

    async findFollowersBatch(
      userId: number,
      targetIds: number[],
    ): Promise<Set<number>> {
      if (targetIds.length === 0) return new Set();

      const result = await db
        .select()
        .from(follows)
        .where(
          and(
            inArray(follows.followerId, targetIds),
            eq(follows.followeeId, userId),
          ),
        );

      return new Set(result.map((f) => f.followerId));
    },

    async findPendingSentRequestsBatch(
      senderId: number,
      receiverIds: number[],
    ): Promise<Set<number>> {
      if (receiverIds.length === 0) return new Set();

      const result = await db
        .select()
        .from(followRequests)
        .where(
          and(
            eq(followRequests.senderId, senderId),
            inArray(followRequests.receiverId, receiverIds),
            eq(followRequests.status, "pending"),
          ),
        );

      return new Set(result.map((r) => r.receiverId));
    },

    async findPendingReceivedRequestsBatch(
      receiverId: number,
      senderIds: number[],
    ): Promise<Set<number>> {
      if (senderIds.length === 0) return new Set();

      const result = await db
        .select()
        .from(followRequests)
        .where(
          and(
            eq(followRequests.receiverId, receiverId),
            inArray(followRequests.senderId, senderIds),
            eq(followRequests.status, "pending"),
          ),
        );

      return new Set(result.map((r) => r.senderId));
    },
  };
}
