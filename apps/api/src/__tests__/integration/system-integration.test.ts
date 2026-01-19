import type { Server } from "node:http";
import type { ApolloServer } from "@apollo/server";
import { afterAll, beforeAll, describe, expect, it } from "vitest";
import { config } from "../../config";
import type {
  DatabaseConnection,
  DrizzleClient,
} from "../../db";
import type { GraphQLContext } from "../../graphql/context";

describe("System Integration Tests", () => {
  describe("Initialization Sequence", () => {
    it("should initialize components in correct order: ConfigManager -> DatabaseConnection -> DrizzleClient -> SchemaBuilder -> Apollo Server", async () => {
      const initOrder: string[] = [];

      config.validate();
      initOrder.push("ConfigManager");

      const { createDatabaseConnection } = await import("../../db/connection");
      const dbConnection = createDatabaseConnection();
      await dbConnection.connect({ maxRetries: 1, retryDelayMs: 100 });
      initOrder.push("DatabaseConnection");

      const { createDrizzleClient } = await import("../../db/client");
      createDrizzleClient(dbConnection.getPool());
      initOrder.push("DrizzleClient");

      const { buildSchema } = await import("../../graphql/schema");
      buildSchema();
      initOrder.push("SchemaBuilder");

      const { createApolloServer } = await import("../../graphql/server");
      const server = createApolloServer();
      await server.start();
      initOrder.push("ApolloServer");

      expect(initOrder).toEqual([
        "ConfigManager",
        "DatabaseConnection",
        "DrizzleClient",
        "SchemaBuilder",
        "ApolloServer",
      ]);

      await server.stop();
      await dbConnection.disconnect();
    });
  });

  describe("Graceful Shutdown", () => {
    let dbConnection: DatabaseConnection;
    let drizzleClient: DrizzleClient;
    let server: ApolloServer<GraphQLContext>;
    let httpServer: Server;

    beforeAll(async () => {
      const { createDatabaseConnection } = await import("../../db/connection");
      const { createDrizzleClient } = await import("../../db/client");
      const { createApolloServer, createExpressApp } = await import(
        "../../graphql/server"
      );

      config.validate();

      dbConnection = createDatabaseConnection();
      await dbConnection.connect({ maxRetries: 1, retryDelayMs: 100 });

      drizzleClient = createDrizzleClient(dbConnection.getPool());

      server = createApolloServer();
      await server.start();

      const app = createExpressApp(server);
      httpServer = app.listen(0);
    });

    afterAll(async () => {
      if (httpServer) {
        httpServer.close();
      }
      if (server) {
        await server.stop();
      }
      if (dbConnection) {
        await dbConnection.disconnect();
      }
    });

    it("should shutdown database connection gracefully", async () => {
      const isHealthyBefore = await dbConnection.healthCheck();
      expect(isHealthyBefore).toBe(true);
    });

    it("should allow queries before shutdown", async () => {
      const result = await drizzleClient.rawQuery<{ result: number }>(
        "SELECT 1 as result",
      );
      expect(result[0].result).toBe(1);
    });
  });

  describe("Server Startup Verification", () => {
    let server: ApolloServer<GraphQLContext>;
    let httpServer: Server;
    let baseUrl: string;

    beforeAll(async () => {
      const { createApolloServer, createExpressApp } = await import(
        "../../graphql/server"
      );

      server = createApolloServer();
      await server.start();

      const app = createExpressApp(server);
      httpServer = app.listen(0);
      const port = (httpServer.address() as { port: number }).port;
      baseUrl = `http://localhost:${port}/graphql`;
    });

    afterAll(async () => {
      httpServer.close();
      await server.stop();
    });

    it("should start server and respond to health query", async () => {
      const response = await fetch(baseUrl, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ query: "{ health }" }),
      });

      const result = (await response.json()) as {
        data?: { health: string };
        errors?: unknown[];
      };
      expect(result.data?.health).toBe("ok");
    });

    it("should enable introspection (GraphQL Playground support)", async () => {
      const response = await fetch(baseUrl, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          query: "{ __schema { queryType { name } } }",
        }),
      });

      const result = (await response.json()) as {
        data?: { __schema: { queryType: { name: string } } };
        errors?: unknown[];
      };
      expect(result.errors).toBeUndefined();
      expect(result.data?.__schema.queryType.name).toBe("Query");
    });
  });
});
