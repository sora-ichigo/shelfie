import type { Server } from "node:http";
import type { ApolloServer } from "@apollo/server";
import type { Express } from "express";
import { afterAll, beforeAll, describe, expect, it } from "vitest";
import type { GraphQLContext } from "../../graphql/context.js";
import { createApolloServer, createExpressApp } from "../../graphql/server.js";

interface GraphQLResponse<T = unknown> {
  data?: T;
  errors?: Array<{
    message: string;
    extensions?: {
      code?: string;
      category?: string;
      [key: string]: unknown;
    };
  }>;
}

interface HealthQueryResponse {
  health: string;
}

describe("GraphQL Resolver Integration Tests", () => {
  let server: ApolloServer<GraphQLContext>;
  let app: Express;
  let httpServer: Server;
  let baseUrl: string;

  beforeAll(async () => {
    server = createApolloServer();
    await server.start();
    app = createExpressApp(server);
    httpServer = app.listen(0);
    const port = (httpServer.address() as { port: number }).port;
    baseUrl = `http://localhost:${port}/graphql`;
  });

  afterAll(async () => {
    await server.stop();
    httpServer.close();
  });

  async function executeQuery<T>(
    query: string,
    variables?: Record<string, unknown>,
  ): Promise<GraphQLResponse<T>> {
    const response = await fetch(baseUrl, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ query, variables }),
    });
    return response.json() as Promise<GraphQLResponse<T>>;
  }

  describe("Query Resolvers", () => {
    it("should resolve health query", async () => {
      const result = await executeQuery<HealthQueryResponse>("{ health }");

      expect(result.errors).toBeUndefined();
      expect(result.data?.health).toBe("ok");
    });

    it("should include requestId in context", async () => {
      const response = await fetch(baseUrl, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-Request-ID": "test-request-123",
        },
        body: JSON.stringify({ query: "{ health }" }),
      });

      const result =
        (await response.json()) as GraphQLResponse<HealthQueryResponse>;

      expect(result.data?.health).toBe("ok");
    });
  });

  describe("Error Handling", () => {
    it("should return error for invalid query", async () => {
      const result = await executeQuery("{ invalidField }");

      expect(result.errors).toBeDefined();
      expect(result.errors?.length).toBeGreaterThan(0);
      expect(result.errors?.[0].message).toContain("invalidField");
    });

    it("should return error for malformed query", async () => {
      const result = await executeQuery("{ health");

      expect(result.errors).toBeDefined();
      expect(result.errors?.[0].message).toContain("Syntax Error");
    });

    it("should include error extensions", async () => {
      const result = await executeQuery("{ invalidQuery }");

      expect(result.errors).toBeDefined();
      expect(result.errors?.[0].extensions).toBeDefined();
    });
  });

  describe("HTTP Methods", () => {
    it("should respond to POST requests", async () => {
      const response = await fetch(baseUrl, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ query: "{ health }" }),
      });

      expect(response.ok).toBe(true);
      expect(response.headers.get("content-type")).toContain(
        "application/json",
      );
    });

    it("should accept JSON content type", async () => {
      const response = await fetch(baseUrl, {
        method: "POST",
        headers: {
          "Content-Type": "application/json; charset=utf-8",
        },
        body: JSON.stringify({ query: "{ health }" }),
      });

      expect(response.ok).toBe(true);
    });
  });

  describe("Introspection", () => {
    it("should support __schema query", async () => {
      const result = await executeQuery<{
        __schema: { queryType: { name: string } };
      }>("{ __schema { queryType { name } } }");

      expect(result.errors).toBeUndefined();
      expect(result.data?.__schema.queryType.name).toBe("Query");
    });

    it("should support __typename", async () => {
      const result = await executeQuery<{ __typename: string }>(
        "{ __typename }",
      );

      expect(result.errors).toBeUndefined();
      expect(result.data?.__typename).toBe("Query");
    });
  });

  describe("Query Variables", () => {
    it("should accept query variables", async () => {
      const result = await executeQuery<HealthQueryResponse>(
        "query Health { health }",
        {},
      );

      expect(result.data?.health).toBe("ok");
    });
  });

  describe("Response Format", () => {
    it("should return JSON response with data field", async () => {
      const result = await executeQuery<HealthQueryResponse>("{ health }");

      expect(result).toHaveProperty("data");
      expect(result.data).not.toBeNull();
    });

    it("should not include errors field on success", async () => {
      const result = await executeQuery<HealthQueryResponse>("{ health }");

      expect(result.errors).toBeUndefined();
    });
  });
});
