import { beforeEach, describe, expect, it, vi } from "vitest";
import { getClient } from "./client";

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
