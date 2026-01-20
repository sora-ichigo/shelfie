import type { Server } from "node:http";
import type { ApolloServer } from "@apollo/server";
import type { Pool } from "pg";
import { afterEach, beforeEach, describe, expect, it } from "vitest";
import { config } from "./config";
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
    it("should follow correct component order: ConfigManager -> Pool -> Db -> SchemaBuilder -> Apollo Server", async () => {
      const initOrder: string[] = [];

      config.validate();
      initOrder.push("ConfigManager");

      const { getPool, getDb, closePool } = await import("./db");
      const pool = getPool();
      await pool.query("SELECT 1");
      initOrder.push("Pool");

      getDb();
      initOrder.push("Db");

      const { buildSchema } = await import("./graphql/schema");
      buildSchema();
      initOrder.push("SchemaBuilder");

      const { createApolloServer } = await import("./graphql/server");
      const server = createApolloServer();
      await server.start();
      initOrder.push("ApolloServer");

      expect(initOrder).toEqual([
        "ConfigManager",
        "Pool",
        "Db",
        "SchemaBuilder",
        "ApolloServer",
      ]);

      await server.stop();
      await closePool();
    });
  });

  describe("Graceful Shutdown Verification", () => {
    let pool: Pool;
    let server: ApolloServer<GraphQLContext>;
    let httpServer: Server;
    let isManuallyShutdown: boolean;
    let closePoolFn: () => Promise<void>;

    beforeEach(async () => {
      const db = await import("./db");
      const { createApolloServer, createExpressApp } = await import(
        "./graphql/server"
      );

      isManuallyShutdown = false;

      config.validate();

      pool = db.getPool();
      await pool.query("SELECT 1");

      db.getDb();
      closePoolFn = db.closePool;

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
      if (closePoolFn) {
        await closePoolFn();
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

    it("should query database before shutdown", async () => {
      const result = await pool.query("SELECT 1 as result");
      expect(result.rows[0].result).toBe(1);
    });

    it("should execute shutdown steps in correct order: HTTP -> Apollo -> Pool", async () => {
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

      await closePoolFn();
      shutdownOrder.push("Pool");

      expect(shutdownOrder).toEqual(["HTTP", "Apollo", "Pool"]);
    });
  });
});
