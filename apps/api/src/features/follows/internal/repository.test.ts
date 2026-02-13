import { describe, expect, it, vi } from "vitest";
import type { FollowRequest } from "../../../db/schema/follow-requests.js";
import type { Follow } from "../../../db/schema/follows.js";
import { createFollowRepository } from "./repository.js";

function createMockDb() {
  const mockResults: unknown[] = [];

  const thenableThis = () => {
    const obj: Record<string, unknown> = {};
    for (const key of Object.keys(mockQuery)) {
      obj[key] = mockQuery[key as keyof typeof mockQuery];
    }
    // biome-ignore lint/suspicious/noThenProperty: drizzle query builder returns thenable objects
    obj.then = (resolve: (v: unknown) => void) => {
      resolve(mockResults);
      return Promise.resolve(mockResults);
    };
    return obj;
  };

  const mockQuery = {
    select: vi.fn().mockImplementation(() => thenableThis()),
    from: vi.fn().mockImplementation(() => thenableThis()),
    where: vi.fn().mockImplementation(() => thenableThis()),
    insert: vi.fn().mockReturnThis(),
    values: vi.fn().mockReturnThis(),
    returning: vi.fn().mockImplementation(() => Promise.resolve(mockResults)),
    delete: vi.fn().mockReturnThis(),
    update: vi.fn().mockReturnThis(),
    set: vi.fn().mockReturnThis(),
    orderBy: vi.fn().mockImplementation(() => thenableThis()),
    limit: vi.fn().mockImplementation(() => Promise.resolve(mockResults)),
    innerJoin: vi.fn().mockImplementation(() => thenableThis()),
  };

  return {
    query: mockQuery,
    setResults: (results: unknown[]) => {
      mockResults.length = 0;
      mockResults.push(...results);
    },
    clearMocks: () => {
      vi.clearAllMocks();
      mockResults.length = 0;
    },
  };
}

const now = new Date();

function createMockFollowRequest(
  overrides: Partial<FollowRequest> = {},
): FollowRequest {
  return {
    id: 1,
    senderId: 1,
    receiverId: 2,
    status: "pending",
    createdAt: now,
    updatedAt: now,
    ...overrides,
  };
}

function createMockFollow(overrides: Partial<Follow> = {}): Follow {
  return {
    id: 1,
    userIdA: 1,
    userIdB: 2,
    createdAt: now,
    ...overrides,
  };
}

describe("FollowRepository", () => {
  describe("interface compliance", () => {
    it("should implement all FollowRepository methods", () => {
      const mockDb = createMockDb();
      const repository = createFollowRepository(mockDb.query as never);

      expect(typeof repository.createRequest).toBe("function");
      expect(typeof repository.findRequestById).toBe("function");
      expect(typeof repository.findRequestBySenderAndReceiver).toBe("function");
      expect(typeof repository.findPendingRequestsByReceiver).toBe("function");
      expect(typeof repository.countPendingRequestsByReceiver).toBe("function");
      expect(typeof repository.updateRequestStatus).toBe("function");
      expect(typeof repository.createFollow).toBe("function");
      expect(typeof repository.deleteFollow).toBe("function");
      expect(typeof repository.findFollow).toBe("function");
      expect(typeof repository.findFollowing).toBe("function");
      expect(typeof repository.findFollowers).toBe("function");
      expect(typeof repository.countFollowing).toBe("function");
      expect(typeof repository.countFollowers).toBe("function");
    });
  });

  describe("createRequest", () => {
    it("should return created follow request", async () => {
      const mockDb = createMockDb();
      const mockRequest = createMockFollowRequest();
      mockDb.setResults([mockRequest]);

      const repository = createFollowRepository(mockDb.query as never);
      const result = await repository.createRequest({
        senderId: 1,
        receiverId: 2,
      });

      expect(result).toEqual(mockRequest);
    });
  });

  describe("findRequestById", () => {
    it("should return follow request when found", async () => {
      const mockDb = createMockDb();
      const mockRequest = createMockFollowRequest();
      mockDb.setResults([mockRequest]);

      const repository = createFollowRepository(mockDb.query as never);
      const result = await repository.findRequestById(1);

      expect(result).toEqual(mockRequest);
    });

    it("should return null when not found", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([]);

      const repository = createFollowRepository(mockDb.query as never);
      const result = await repository.findRequestById(999);

      expect(result).toBeNull();
    });
  });

  describe("findRequestBySenderAndReceiver", () => {
    it("should return follow request when found", async () => {
      const mockDb = createMockDb();
      const mockRequest = createMockFollowRequest();
      mockDb.setResults([mockRequest]);

      const repository = createFollowRepository(mockDb.query as never);
      const result = await repository.findRequestBySenderAndReceiver(1, 2);

      expect(result).toEqual(mockRequest);
    });

    it("should return null when not found", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([]);

      const repository = createFollowRepository(mockDb.query as never);
      const result = await repository.findRequestBySenderAndReceiver(1, 2);

      expect(result).toBeNull();
    });
  });

  describe("findPendingRequestsByReceiver", () => {
    it("should return pending requests for receiver", async () => {
      const mockDb = createMockDb();
      const requests = [
        createMockFollowRequest({ id: 3 }),
        createMockFollowRequest({ id: 2 }),
      ];
      mockDb.setResults(requests);

      const repository = createFollowRepository(mockDb.query as never);
      const result = await repository.findPendingRequestsByReceiver(
        2,
        null,
        20,
      );

      expect(result).toEqual(requests);
      expect(result).toHaveLength(2);
    });

    it("should return empty array when no pending requests", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([]);

      const repository = createFollowRepository(mockDb.query as never);
      const result = await repository.findPendingRequestsByReceiver(
        2,
        null,
        20,
      );

      expect(result).toEqual([]);
    });
  });

  describe("countPendingRequestsByReceiver", () => {
    it("should return count of pending requests", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([{ count: 5 }]);

      const repository = createFollowRepository(mockDb.query as never);
      const result = await repository.countPendingRequestsByReceiver(2);

      expect(result).toBe(5);
    });

    it("should return 0 when no pending requests", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([{ count: 0 }]);

      const repository = createFollowRepository(mockDb.query as never);
      const result = await repository.countPendingRequestsByReceiver(2);

      expect(result).toBe(0);
    });
  });

  describe("updateRequestStatus", () => {
    it("should return updated follow request", async () => {
      const mockDb = createMockDb();
      const updatedRequest = createMockFollowRequest({ status: "approved" });
      mockDb.setResults([updatedRequest]);

      const repository = createFollowRepository(mockDb.query as never);
      const result = await repository.updateRequestStatus(1, "approved");

      expect(result).toEqual(updatedRequest);
      expect(result.status).toBe("approved");
    });
  });

  describe("createFollow", () => {
    it("should return created follow with normalized ids (a < b)", async () => {
      const mockDb = createMockDb();
      const mockFollow = createMockFollow({ userIdA: 1, userIdB: 2 });
      mockDb.setResults([mockFollow]);

      const repository = createFollowRepository(mockDb.query as never);
      const result = await repository.createFollow(1, 2);

      expect(result).toEqual(mockFollow);
      expect(result.userIdA).toBeLessThan(result.userIdB);
    });

    it("should normalize user ids when first is larger", async () => {
      const mockDb = createMockDb();
      const mockFollow = createMockFollow({ userIdA: 2, userIdB: 5 });
      mockDb.setResults([mockFollow]);

      const repository = createFollowRepository(mockDb.query as never);
      const result = await repository.createFollow(5, 2);

      expect(mockDb.query.values).toHaveBeenCalled();
      expect(result).toEqual(mockFollow);
    });
  });

  describe("deleteFollow", () => {
    it("should call delete with normalized ids", async () => {
      const mockDb = createMockDb();
      const repository = createFollowRepository(mockDb.query as never);

      await repository.deleteFollow(1, 2);

      expect(mockDb.query.delete).toHaveBeenCalled();
    });
  });

  describe("findFollow", () => {
    it("should return follow when found", async () => {
      const mockDb = createMockDb();
      const mockFollow = createMockFollow();
      mockDb.setResults([mockFollow]);

      const repository = createFollowRepository(mockDb.query as never);
      const result = await repository.findFollow(1, 2);

      expect(result).toEqual(mockFollow);
    });

    it("should return follow when ids are in reverse order", async () => {
      const mockDb = createMockDb();
      const mockFollow = createMockFollow({ userIdA: 1, userIdB: 2 });
      mockDb.setResults([mockFollow]);

      const repository = createFollowRepository(mockDb.query as never);
      const result = await repository.findFollow(2, 1);

      expect(result).toEqual(mockFollow);
    });

    it("should return null when not found", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([]);

      const repository = createFollowRepository(mockDb.query as never);
      const result = await repository.findFollow(1, 2);

      expect(result).toBeNull();
    });
  });

  describe("findFollowing", () => {
    it("should return empty array when no following", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([]);

      const repository = createFollowRepository(mockDb.query as never);
      const result = await repository.findFollowing(1, null, 20);

      expect(result).toEqual([]);
    });
  });

  describe("findFollowers", () => {
    it("should return empty array when no followers", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([]);

      const repository = createFollowRepository(mockDb.query as never);
      const result = await repository.findFollowers(2, null, 20);

      expect(result).toEqual([]);
    });
  });

  describe("countFollowing", () => {
    it("should return count of following users", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([{ count: 3 }]);

      const repository = createFollowRepository(mockDb.query as never);
      const result = await repository.countFollowing(1);

      expect(result).toBe(3);
    });

    it("should return 0 when not following anyone", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([{ count: 0 }]);

      const repository = createFollowRepository(mockDb.query as never);
      const result = await repository.countFollowing(1);

      expect(result).toBe(0);
    });
  });

  describe("countFollowers", () => {
    it("should return count of followers", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([{ count: 7 }]);

      const repository = createFollowRepository(mockDb.query as never);
      const result = await repository.countFollowers(1);

      expect(result).toBe(7);
    });

    it("should return 0 when no followers", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([{ count: 0 }]);

      const repository = createFollowRepository(mockDb.query as never);
      const result = await repository.countFollowers(1);

      expect(result).toBe(0);
    });
  });

  describe("findFollowsBatch", () => {
    it("should return set of followed target ids", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([
        createMockFollow({ userIdA: 1, userIdB: 3 }),
        createMockFollow({ userIdA: 1, userIdB: 5 }),
      ]);

      const repository = createFollowRepository(mockDb.query as never);
      const result = await repository.findFollowsBatch(1, [3, 5, 7]);

      expect(result).toBeInstanceOf(Set);
      expect(result.has(3)).toBe(true);
      expect(result.has(5)).toBe(true);
      expect(result.has(7)).toBe(false);
    });

    it("should return empty set when no targets", async () => {
      const mockDb = createMockDb();
      const repository = createFollowRepository(mockDb.query as never);
      const result = await repository.findFollowsBatch(1, []);

      expect(result.size).toBe(0);
    });
  });

  describe("findPendingSentRequestsBatch", () => {
    it("should return set of receiver ids with pending sent requests", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([
        createMockFollowRequest({
          senderId: 1,
          receiverId: 3,
          status: "pending",
        }),
      ]);

      const repository = createFollowRepository(mockDb.query as never);
      const result = await repository.findPendingSentRequestsBatch(1, [3, 5]);

      expect(result.has(3)).toBe(true);
      expect(result.has(5)).toBe(false);
    });

    it("should return empty set when no targets", async () => {
      const mockDb = createMockDb();
      const repository = createFollowRepository(mockDb.query as never);
      const result = await repository.findPendingSentRequestsBatch(1, []);

      expect(result.size).toBe(0);
    });
  });

  describe("findPendingReceivedRequestsBatch", () => {
    it("should return set of sender ids with pending received requests", async () => {
      const mockDb = createMockDb();
      mockDb.setResults([
        createMockFollowRequest({
          senderId: 3,
          receiverId: 1,
          status: "pending",
        }),
      ]);

      const repository = createFollowRepository(mockDb.query as never);
      const result = await repository.findPendingReceivedRequestsBatch(
        1,
        [3, 5],
      );

      expect(result.has(3)).toBe(true);
      expect(result.has(5)).toBe(false);
    });

    it("should return empty set when no targets", async () => {
      const mockDb = createMockDb();
      const repository = createFollowRepository(mockDb.query as never);
      const result = await repository.findPendingReceivedRequestsBatch(1, []);

      expect(result.size).toBe(0);
    });
  });
});
