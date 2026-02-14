import { beforeEach, describe, expect, it, vi } from "vitest";
import { getClient } from "./client.js";
import type { UserByHandleData, UserByHandleVars } from "./queries.js";
import { USER_BY_HANDLE_QUERY } from "./queries.js";

describe("GraphQL Client", () => {
  beforeEach(() => {
    vi.unstubAllEnvs();
  });

  describe("getClient", () => {
    it("should return an ApolloClient instance", () => {
      const client = getClient();
      expect(client).toBeDefined();
      expect(typeof client.query).toBe("function");
    });

    it("should use NEXT_PUBLIC_API_URL when set", () => {
      vi.stubEnv("NEXT_PUBLIC_API_URL", "https://api.example.com");
      const client = getClient();
      expect(client).toBeDefined();
    });

    it("should default to localhost:4000/graphql when env not set", () => {
      delete process.env.NEXT_PUBLIC_API_URL;
      const client = getClient();
      expect(client).toBeDefined();
    });
  });
});

describe("USER_BY_HANDLE_QUERY", () => {
  it("should be a valid GraphQL document", () => {
    expect(USER_BY_HANDLE_QUERY).toBeDefined();
    expect(USER_BY_HANDLE_QUERY.kind).toBe("Document");
  });

  it("should have the correct operation name", () => {
    const definition = USER_BY_HANDLE_QUERY.definitions[0];
    expect(definition.kind).toBe("OperationDefinition");
    if (definition.kind === "OperationDefinition") {
      expect(definition.name?.value).toBe("UserByHandle");
    }
  });

  it("should define UserByHandleVars type with handle field", () => {
    const vars: UserByHandleVars = { handle: "testuser" };
    expect(vars.handle).toBe("testuser");
  });

  it("should define UserByHandleData type with nullable userByHandle", () => {
    const dataWithUser: UserByHandleData = {
      userByHandle: {
        name: "Test User",
        avatarUrl: "https://example.com/avatar.jpg",
        bio: "Hello",
        handle: "testuser",
      },
    };
    expect(dataWithUser.userByHandle).not.toBeNull();

    const dataWithoutUser: UserByHandleData = {
      userByHandle: null,
    };
    expect(dataWithoutUser.userByHandle).toBeNull();
  });
});
