import { ApolloServer } from "@apollo/server";
import { expressMiddleware } from "@as-integrations/express4";
import express from "express";

const typeDefs = `#graphql
  type Query {
    hello: String
  }
`;

const resolvers = {
  Query: {
    hello: () => "Hello from Shelfie API!",
  },
};

async function main() {
  const app = express();
  const server = new ApolloServer({ typeDefs, resolvers });

  await server.start();

  app.use("/graphql", express.json(), expressMiddleware(server));

  const port = process.env.PORT || 4000;
  app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}/graphql`);
  });
}

main();
