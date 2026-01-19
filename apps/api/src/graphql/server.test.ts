import type { Server } from "node:http";
import type { ApolloServer } from "@apollo/server";
import type { Express } from "express";
import { afterAll, beforeAll, describe, expect, it } from "vitest";
import type { GraphQLContext } from "./context";
import { createApolloServer, createExpressApp } from "./server";

interface GraphQLResponse {
  data?: Record<string, unknown>;
  errors?: Array<{ message: string }>;
}

describe("Apollo Server Integration", () => {
  let server: ApolloServer<GraphQLContext>;
  let app: Express;
  let httpServer: Server;

  beforeAll(async () => {
    server = createApolloServer();
    await server.start();
    app = createExpressApp(server);
    httpServer = app.listen(0);
  });

  afterAll(async () => {
    await server.stop();
    httpServer.close();
  });

  describe("createApolloServer", () => {
    it("should create an Apollo Server instance", () => {
      expect(server).toBeDefined();
    });
  });

  describe("createExpressApp", () => {
    it("should create an Express app with GraphQL middleware", () => {
      expect(app).toBeDefined();
    });
  });

  describe("GraphQL endpoint", () => {
    it("should respond to health query", async () => {
      const port = (httpServer.address() as { port: number }).port;
      const response = await fetch(`http://localhost:${port}/graphql`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          query: "{ health }",
        }),
      });

      const result = (await response.json()) as GraphQLResponse;
      expect(response.status).toBe(200);
      expect(result.data).toBeDefined();
      expect(result.data?.health).toBe("ok");
    });

    it("should handle invalid queries gracefully", async () => {
      const port = (httpServer.address() as { port: number }).port;
      const response = await fetch(`http://localhost:${port}/graphql`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          query: "{ invalidField }",
        }),
      });

      const result = (await response.json()) as GraphQLResponse;
      expect(response.status).toBe(400);
      expect(result.errors).toBeDefined();
      expect(result.errors?.length).toBeGreaterThan(0);
    });
  });
});
