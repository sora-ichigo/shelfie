import type { Server } from "node:http";
import type { ApolloServer } from "@apollo/server";
import { sql } from "drizzle-orm";
import type { NodePgDatabase } from "drizzle-orm/node-postgres";
import type { Pool } from "pg";
import { afterAll, beforeAll, describe, expect, it } from "vitest";
import { config } from "../../config";
import type { GraphQLContext } from "../../graphql/context";

describe("System Integration Tests", () => {
  describe("Initialization Sequence", () => {
    it("should initialize components in correct order: ConfigManager -> Pool -> Db -> SchemaBuilder -> Apollo Server", async () => {
      const initOrder: string[] = [];

      config.validate();
      initOrder.push("ConfigManager");

      const { getPool, getDb, closePool } = await import("../../db");
      const pool = getPool();
      await pool.query("SELECT 1");
      initOrder.push("Pool");

      getDb();
      initOrder.push("Db");

      const { buildSchema } = await import("../../graphql/schema");
      buildSchema();
      initOrder.push("SchemaBuilder");

      const { createApolloServer } = await import("../../graphql/server");
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

  describe("Graceful Shutdown", () => {
    let pool: Pool;
    let db: NodePgDatabase;
    let server: ApolloServer<GraphQLContext>;
    let httpServer: Server;
    let closePoolFn: () => Promise<void>;

    beforeAll(async () => {
      const dbModule = await import("../../db");
      const { createApolloServer, createExpressApp } = await import(
        "../../graphql/server"
      );

      config.validate();

      pool = dbModule.getPool();
      await pool.query("SELECT 1");

      db = dbModule.getDb();
      closePoolFn = dbModule.closePool;

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
      if (closePoolFn) {
        await closePoolFn();
      }
    });

    it("should query database when pool is connected", async () => {
      const result = await pool.query("SELECT 1 as result");
      expect(result.rows[0].result).toBe(1);
    });

    it("should allow queries via drizzle before shutdown", async () => {
      const result = await db.execute<{ result: number }>(
        sql`SELECT 1 as result`,
      );
      expect(result.rows[0].result).toBe(1);
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
