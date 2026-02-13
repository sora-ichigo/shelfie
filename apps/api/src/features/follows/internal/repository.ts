import { and, count, desc, eq, inArray, lt, or, sql } from "drizzle-orm";
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
  createFollow(userIdA: number, userIdB: number): Promise<Follow>;
  deleteFollow(userIdA: number, userIdB: number): Promise<void>;
  findFollow(userId1: number, userId2: number): Promise<Follow | null>;
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
  async function findFollowUsers(
    userId: number,
    cursor: number | null,
    limit: number,
  ): Promise<FollowWithUser[]> {
    const conditions = [
      or(eq(follows.userIdA, userId), eq(follows.userIdB, userId)),
    ];
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

    const otherUserIds = followResults.map((f) =>
      f.userIdA === userId ? f.userIdB : f.userIdA,
    );

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
        const otherUserId = f.userIdA === userId ? f.userIdB : f.userIdA;
        const user = userMap.get(otherUserId);
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

    async createFollow(userIdA: number, userIdB: number): Promise<Follow> {
      const [a, b] =
        userIdA < userIdB ? [userIdA, userIdB] : [userIdB, userIdA];
      const result = await db
        .insert(follows)
        .values({ userIdA: a, userIdB: b })
        .returning();
      return result[0];
    },

    async deleteFollow(userIdA: number, userIdB: number): Promise<void> {
      const [a, b] =
        userIdA < userIdB ? [userIdA, userIdB] : [userIdB, userIdA];
      await db
        .delete(follows)
        .where(and(eq(follows.userIdA, a), eq(follows.userIdB, b)));
    },

    async findFollow(userId1: number, userId2: number): Promise<Follow | null> {
      const [a, b] =
        userId1 < userId2 ? [userId1, userId2] : [userId2, userId1];
      const result = await db
        .select()
        .from(follows)
        .where(and(eq(follows.userIdA, a), eq(follows.userIdB, b)));
      return result[0] ?? null;
    },

    findFollowing: findFollowUsers,
    findFollowers: findFollowUsers,

    async countFollowing(userId: number): Promise<number> {
      const result = await db
        .select({ count: count() })
        .from(follows)
        .where(or(eq(follows.userIdA, userId), eq(follows.userIdB, userId)));
      return result[0]?.count ?? 0;
    },

    async countFollowers(userId: number): Promise<number> {
      const result = await db
        .select({ count: count() })
        .from(follows)
        .where(or(eq(follows.userIdA, userId), eq(follows.userIdB, userId)));
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
          or(
            and(
              eq(follows.userIdA, userId),
              inArray(follows.userIdB, targetIds),
            ),
            and(
              eq(follows.userIdB, userId),
              inArray(follows.userIdA, targetIds),
            ),
          ),
        );

      return new Set(
        result.map((f) => (f.userIdA === userId ? f.userIdB : f.userIdA)),
      );
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
