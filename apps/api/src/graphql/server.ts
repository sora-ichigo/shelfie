import { randomUUID } from "node:crypto";
import { ApolloServer } from "@apollo/server";
import { expressMiddleware } from "@as-integrations/express4";
import express, { type Express } from "express";
import type { GraphQLContext } from "./context";
import { schema } from "./schema";

export function createApolloServer() {
  return new ApolloServer<GraphQLContext>({
    schema,
    introspection: true,
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
        return {
          requestId,
          user: null,
        };
      },
    }),
  );

  return app;
}

export async function startServer(port: number = 4000) {
  const server = createApolloServer();
  await server.start();

  const app = createExpressApp(server);

  return new Promise<{
    server: ApolloServer<GraphQLContext>;
    httpServer: ReturnType<Express["listen"]>;
  }>((resolve) => {
    const httpServer = app.listen(port, () => {
      console.log(`Server running at http://localhost:${port}/graphql`);
      resolve({ server, httpServer });
    });
  });
}
