import type { Server } from "node:http";
import type { ApolloServer } from "@apollo/server";
import type { Express } from "express";
import { afterAll, afterEach, beforeAll, describe, expect, it } from "vitest";
import { config } from "../../config";
import type { DatabaseConnection, DrizzleClient } from "../../db";
import { users } from "../../db/schema";
import type { GraphQLContext } from "../../graphql/context";

interface GraphQLResponse<T = unknown> {
  data?: T;
  errors?: Array<{
    message: string;
    extensions?: {
      code?: string;
      category?: string;
      timestamp?: string;
      [key: string]: unknown;
    };
  }>;
}

describe("End-to-End Validation Tests", () => {
  let dbConnection: DatabaseConnection;
  let drizzleClient: DrizzleClient;
  let server: ApolloServer<GraphQLContext>;
  let app: Express;
  let httpServer: Server;
  let baseUrl: string;

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

    app = createExpressApp(server);
    httpServer = app.listen(0);
    const port = (httpServer.address() as { port: number }).port;
    baseUrl = `http://localhost:${port}/graphql`;
  });

  afterAll(async () => {
    httpServer.close();
    await server.stop();
    await dbConnection.disconnect();
  });

  async function executeQuery<T>(
    query: string,
    variables?: Record<string, unknown>,
  ): Promise<GraphQLResponse<T>> {
    const response = await fetch(baseUrl, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ query, variables }),
    });
    return response.json() as Promise<GraphQLResponse<T>>;
  }

  describe("Requirement 1.5: GraphQL Playground Verification", () => {
    it("should respond to introspection queries (GraphQL Playground requirement)", async () => {
      const result = await executeQuery<{
        __schema: {
          types: Array<{ name: string }>;
        };
      }>("{ __schema { types { name } } }");

      expect(result.errors).toBeUndefined();
      expect(result.data?.__schema.types).toBeDefined();
      expect(result.data?.__schema.types.length).toBeGreaterThan(0);
    });

    it("should expose Query type with health field", async () => {
      const result = await executeQuery<{
        __type: {
          fields: Array<{ name: string; type: { name: string } }>;
        };
      }>('{ __type(name: "Query") { fields { name type { name } } } }');

      expect(result.errors).toBeUndefined();
      const healthField = result.data?.__type.fields.find(
        (f) => f.name === "health",
      );
      expect(healthField).toBeDefined();
    });
  });

  describe("Requirement 2.4: Database Operations (CRUD) Verification", () => {
    const testEmail = `test-${Date.now()}@example.com`;

    afterEach(async () => {
      const db = drizzleClient.getDb();
      const { eq } = await import("drizzle-orm");
      await db.delete(users).where(eq(users.email, testEmail));
    });

    it("should CREATE records in database", async () => {
      const db = drizzleClient.getDb();
      const result = await db
        .insert(users)
        .values({ email: testEmail })
        .returning();

      expect(result).toHaveLength(1);
      expect(result[0].email).toBe(testEmail);
      expect(result[0].id).toBeDefined();
    });

    it("should READ records from database", async () => {
      const db = drizzleClient.getDb();
      const { eq } = await import("drizzle-orm");

      await db.insert(users).values({ email: testEmail });

      const result = await db
        .select()
        .from(users)
        .where(eq(users.email, testEmail));

      expect(result).toHaveLength(1);
      expect(result[0].email).toBe(testEmail);
    });

    it("should UPDATE records in database", async () => {
      const db = drizzleClient.getDb();
      const { eq } = await import("drizzle-orm");

      const [inserted] = await db
        .insert(users)
        .values({ email: testEmail })
        .returning();

      const updatedEmail = `updated-${testEmail}`;
      const result = await db
        .update(users)
        .set({ email: updatedEmail })
        .where(eq(users.id, inserted.id))
        .returning();

      expect(result).toHaveLength(1);
      expect(result[0].email).toBe(updatedEmail);

      await db.delete(users).where(eq(users.email, updatedEmail));
    });

    it("should DELETE records from database", async () => {
      const db = drizzleClient.getDb();
      const { eq } = await import("drizzle-orm");

      await db.insert(users).values({ email: testEmail });

      await db.delete(users).where(eq(users.email, testEmail));

      const result = await db
        .select()
        .from(users)
        .where(eq(users.email, testEmail));

      expect(result).toHaveLength(0);
    });

    it("should support transactions", async () => {
      const db = drizzleClient.getDb();
      const { eq } = await import("drizzle-orm");

      let insertedId: number | null = null;

      try {
        await drizzleClient.transaction(async (tx) => {
          const [inserted] = await tx
            .insert(users)
            .values({ email: testEmail })
            .returning();
          insertedId = inserted.id;

          const [found] = await tx
            .select()
            .from(users)
            .where(eq(users.id, inserted.id));
          expect(found.email).toBe(testEmail);
        });

        if (insertedId !== null) {
          const [found] = await db
            .select()
            .from(users)
            .where(eq(users.id, insertedId));
          expect(found.email).toBe(testEmail);
        }
      } finally {
        if (insertedId !== null) {
          await db.delete(users).where(eq(users.id, insertedId));
        }
      }
    });
  });

  describe("Requirement 7.1 & 7.4: Error Handling Verification", () => {
    it("should return GraphQL error with standard format for invalid queries", async () => {
      const result = await executeQuery("{ nonExistentField }");

      expect(result.errors).toBeDefined();
      expect(result.errors?.length).toBeGreaterThan(0);
      expect(result.errors?.[0].extensions).toBeDefined();
    });

    it("should include error code in extensions", async () => {
      const result = await executeQuery("{ nonExistentField }");

      expect(result.errors?.[0].extensions?.code).toBeDefined();
    });

    it("should include timestamp in error extensions", async () => {
      const result = await executeQuery("{ nonExistentField }");

      expect(result.errors?.[0].extensions?.timestamp).toBeDefined();
    });

    it("should include category in error extensions", async () => {
      const result = await executeQuery("{ nonExistentField }");

      expect(result.errors?.[0].extensions?.category).toBeDefined();
    });

    it("should handle syntax errors gracefully", async () => {
      const result = await executeQuery("{ health");

      expect(result.errors).toBeDefined();
      expect(result.errors?.[0].message).toContain("Syntax Error");
    });
  });

  describe("Requirement 7.5: Logging Verification", () => {
    it("should log via Pino logger (verified by no uncaught exceptions)", async () => {
      const { logger } = await import("../../logger");

      expect(() => {
        logger.info("Test log message");
        logger.debug("Debug message", { requestId: "test-123" });
        logger.warn("Warning message");
        logger.error("Error message", new Error("Test error"));
      }).not.toThrow();
    });
  });

  describe("Full System Integration Verification", () => {
    it("should execute full request flow: HTTP -> GraphQL -> Response", async () => {
      const response = await fetch(baseUrl, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-Request-ID": "e2e-test-request-id",
        },
        body: JSON.stringify({ query: "{ health }" }),
      });

      expect(response.ok).toBe(true);
      expect(response.headers.get("content-type")).toContain(
        "application/json",
      );

      const result = (await response.json()) as GraphQLResponse<{
        health: string;
      }>;
      expect(result.data?.health).toBe("ok");
    });

    it("should handle concurrent requests", async () => {
      const requests = Array.from({ length: 10 }, () =>
        executeQuery<{ health: string }>("{ health }"),
      );

      const results = await Promise.all(requests);

      for (const result of results) {
        expect(result.errors).toBeUndefined();
        expect(result.data?.health).toBe("ok");
      }
    });
  });
});
