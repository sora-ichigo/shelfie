import type { Server } from "node:http";
import type { ApolloServer } from "@apollo/server";
import { config } from "./config";
import { closePool, getDb, getPool } from "./db";
import type { GraphQLContext } from "./graphql/context";
import { createApolloServer, createExpressApp } from "./graphql/server";
import { logger } from "./logger";

interface ServerComponents {
  apolloServer: ApolloServer<GraphQLContext>;
  httpServer: Server;
}

let components: ServerComponents | null = null;

async function initialize(): Promise<ServerComponents> {
  logger.info("Starting server initialization...");

  logger.info("Step 1/4: Validating configuration...");
  config.validate();
  logger.info("Configuration validated successfully");

  logger.info("Step 2/4: Establishing database connection...");
  const pool = getPool();
  await pool.query("SELECT 1");
  logger.info("Database connection established");

  logger.info("Step 3/4: Building GraphQL schema...");
  const apolloServer = createApolloServer();
  logger.info("GraphQL schema built");

  logger.info("Step 4/4: Starting Apollo Server...");
  await apolloServer.start();
  logger.info("Apollo Server started");

  const port = config.getOrDefault("PORT", 4000);
  const app = createExpressApp(apolloServer);

  return new Promise((resolve) => {
    const httpServer = app.listen(port, () => {
      logger.info(`Server running at http://localhost:${port}/graphql`);
      resolve({
        apolloServer,
        httpServer,
      });
    });
  });
}

async function shutdown(): Promise<void> {
  if (!components) {
    logger.warn("Shutdown called but no components initialized");
    return;
  }

  logger.info("Starting graceful shutdown...");

  try {
    const currentComponents = components;

    logger.info("Step 1/3: Stopping HTTP server...");
    await new Promise<void>((resolve, reject) => {
      currentComponents.httpServer.close((err) => {
        if (err) reject(err);
        else resolve();
      });
    });
    logger.info("HTTP server stopped");

    logger.info("Step 2/3: Stopping Apollo Server...");
    await currentComponents.apolloServer.stop();
    logger.info("Apollo Server stopped");

    logger.info("Step 3/3: Closing database connection...");
    await closePool();
    logger.info("Database connection closed");

    logger.info("Graceful shutdown completed");
  } catch (err) {
    logger.error(
      "Error during graceful shutdown",
      err instanceof Error ? err : new Error(String(err)),
    );
    throw err;
  }

  components = null;
}

function setupShutdownHandlers(): void {
  let isShuttingDown = false;

  const handleShutdown = async (signal: string) => {
    if (isShuttingDown) {
      logger.warn(`Received ${signal} but shutdown already in progress`);
      return;
    }

    isShuttingDown = true;
    logger.info(`Received ${signal}, initiating graceful shutdown...`);

    try {
      await shutdown();
      process.exit(0);
    } catch {
      process.exit(1);
    }
  };

  process.on("SIGTERM", () => handleShutdown("SIGTERM"));
  process.on("SIGINT", () => handleShutdown("SIGINT"));

  process.on("uncaughtException", (err) => {
    logger.error("Uncaught exception", err);
    handleShutdown("uncaughtException").catch(() => process.exit(1));
  });

  process.on("unhandledRejection", (reason) => {
    const err = reason instanceof Error ? reason : new Error(String(reason));
    logger.error("Unhandled rejection", err);
    handleShutdown("unhandledRejection").catch(() => process.exit(1));
  });
}

async function main(): Promise<void> {
  try {
    setupShutdownHandlers();
    components = await initialize();
  } catch (err) {
    logger.error(
      "Failed to start server",
      err instanceof Error ? err : new Error(String(err)),
    );
    process.exit(1);
  }
}

main();

export { initialize, shutdown, type ServerComponents, getDb, getPool };
