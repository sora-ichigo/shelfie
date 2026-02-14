import { ApolloClient, HttpLink, InMemoryCache } from "@apollo/client";

const API_URL =
  process.env.NEXT_PUBLIC_API_URL ?? "http://localhost:4000/graphql";

export function getClient() {
  return new ApolloClient({
    link: new HttpLink({
      uri: API_URL,
      fetchOptions: { cache: "no-store" },
    }),
    cache: new InMemoryCache(),
    defaultOptions: {
      query: {
        fetchPolicy: "no-cache",
      },
    },
  });
}
