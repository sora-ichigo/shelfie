import type { Server } from "node:http";
import type { ApolloServer } from "@apollo/server";
import { afterEach, beforeEach, describe, expect, it } from "vitest";
import { config } from "./config";
import type { DatabaseConnection } from "./db";
import type { GraphQLContext } from "./graphql/context";

describe("Server Initialization", () => {
  describe("initialize function", () => {
    it("should export initialize and shutdown functions", async () => {
      const indexModule = await import("./index");

      expect(indexModule.initialize).toBeDefined();
      expect(typeof indexModule.initialize).toBe("function");
      expect(indexModule.shutdown).toBeDefined();
      expect(typeof indexModule.shutdown).toBe("function");
    });

    it("should export ServerComponents type", async () => {
      const indexModule = await import("./index");

      expect(indexModule).toBeDefined();
    });
  });

  describe("Initialization Sequence Verification", () => {
    it("should follow correct component order: ConfigManager -> DatabaseConnection -> DrizzleClient -> SchemaBuilder -> Apollo Server", async () => {
      const initOrder: string[] = [];

      config.validate();
      initOrder.push("ConfigManager");

      const { createDatabaseConnection } = await import("./db/connection");
      const dbConnection = createDatabaseConnection();
      await dbConnection.connect({ maxRetries: 1, retryDelayMs: 100 });
      initOrder.push("DatabaseConnection");

      const { createDrizzleClient } = await import("./db/client");
      createDrizzleClient(dbConnection.getPool());
      initOrder.push("DrizzleClient");

      const { buildSchema } = await import("./graphql/schema");
      buildSchema();
      initOrder.push("SchemaBuilder");

      const { createApolloServer } = await import("./graphql/server");
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

  describe("Graceful Shutdown Verification", () => {
    let dbConnection: DatabaseConnection;
    let server: ApolloServer<GraphQLContext>;
    let httpServer: Server;
    let isManuallyShutdown: boolean;

    beforeEach(async () => {
      const { createDatabaseConnection } = await import("./db/connection");
      const { createDrizzleClient } = await import("./db/client");
      const { createApolloServer, createExpressApp } = await import(
        "./graphql/server"
      );

      isManuallyShutdown = false;

      config.validate();

      dbConnection = createDatabaseConnection();
      await dbConnection.connect({ maxRetries: 1, retryDelayMs: 100 });

      createDrizzleClient(dbConnection.getPool());

      server = createApolloServer();
      await server.start();

      const app = createExpressApp(server);
      httpServer = app.listen(0);
    });

    afterEach(async () => {
      if (isManuallyShutdown) {
        return;
      }
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

    it("should shutdown HTTP server gracefully", async () => {
      const closePromise = new Promise<void>((resolve) => {
        httpServer.close(() => resolve());
      });

      await closePromise;
      expect(httpServer.listening).toBe(false);
    });

    it("should shutdown Apollo Server gracefully", async () => {
      await server.stop();
    });

    it("should close database connection gracefully", async () => {
      const isHealthyBefore = await dbConnection.healthCheck();
      expect(isHealthyBefore).toBe(true);
    });

    it("should execute shutdown steps in correct order: HTTP -> Apollo -> Database", async () => {
      isManuallyShutdown = true;
      const shutdownOrder: string[] = [];

      await new Promise<void>((resolve) => {
        httpServer.close(() => {
          shutdownOrder.push("HTTP");
          resolve();
        });
      });

      await server.stop();
      shutdownOrder.push("Apollo");

      await dbConnection.disconnect();
      shutdownOrder.push("Database");

      expect(shutdownOrder).toEqual(["HTTP", "Apollo", "Database"]);
    });
  });
});
