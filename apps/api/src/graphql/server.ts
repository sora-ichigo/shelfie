import { randomUUID } from "node:crypto";
import { ApolloServer } from "@apollo/server";
import { ApolloServerPluginLandingPageLocalDefault } from "@apollo/server/plugin/landingPage/default";
import { expressMiddleware } from "@as-integrations/express4";
import express, { type Express } from "express";
import { createAuthContext } from "../auth";
import { config } from "../config";
import { createErrorHandler } from "../errors";
import { logger } from "../logger";
import type { GraphQLContext } from "./context";
import { schema } from "./schema";

export function createApolloServer() {
  const errorHandler = createErrorHandler(logger, config.isProduction());

  return new ApolloServer<GraphQLContext>({
    schema,
    introspection: true,
    formatError: (formattedError, error) =>
      errorHandler.formatError(formattedError, error),
    plugins: config.isProduction()
      ? []
      : [
          ApolloServerPluginLandingPageLocalDefault({
            embed: {
              initialState: {
                sharedHeaders: {
                  "X-Dev-User-Id": "1",
                },
              },
            },
          }),
        ],
  });
}

export function createExpressApp(
  server: ApolloServer<GraphQLContext>,
): Express {
  const app = express();

  app.use(
    "/graphql",
    express.json(),
    expressMiddleware(server, {
      context: async ({ req }) => {
        const requestId =
          (req.headers["x-request-id"] as string) || randomUUID();
        const authHeader = req.headers.authorization;
        const devUserIdHeader = req.headers["x-dev-user-id"] as
          | string
          | undefined;
        const user = await createAuthContext(authHeader, devUserIdHeader);
        return {
          requestId,
          user,
        };
      },
    }),
  );

  return app;
}
