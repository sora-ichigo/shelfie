import { beforeEach, describe, expect, it, vi } from "vitest";
import { fetchUserByHandle } from "./fetch-user";

vi.mock("./client", () => ({
  getClient: vi.fn(),
}));

import { getClient } from "./client";

describe("fetchUserByHandle", () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it("should return user data when user exists", async () => {
    const mockUser = {
      __typename: "User" as const,
      name: "Test User",
      avatarUrl: "https://example.com/avatar.jpg",
      bio: "Book lover",
      handle: "testuser",
    };

    const mockQuery = vi.fn().mockResolvedValue({
      data: { userByHandle: mockUser },
    });

    vi.mocked(getClient).mockReturnValue({ query: mockQuery } as never);

    const result = await fetchUserByHandle("testuser");

    expect(result).toEqual(mockUser);
    expect(mockQuery).toHaveBeenCalledWith(
      expect.objectContaining({
        variables: { handle: "testuser" },
      }),
    );
  });

  it("should return null when user does not exist", async () => {
    const mockQuery = vi.fn().mockResolvedValue({
      data: { userByHandle: null },
    });

    vi.mocked(getClient).mockReturnValue({ query: mockQuery } as never);

    const result = await fetchUserByHandle("nonexistent");

    expect(result).toBeNull();
  });

  it("should return null when query throws an error", async () => {
    const mockQuery = vi.fn().mockRejectedValue(new Error("Network error"));

    vi.mocked(getClient).mockReturnValue({ query: mockQuery } as never);

    const result = await fetchUserByHandle("testuser");

    expect(result).toBeNull();
  });
});
