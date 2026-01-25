import type { Server } from "node:http";
import type { ApolloServer } from "@apollo/server";
import type { Express } from "express";
import { afterAll, beforeAll, describe, expect, it } from "vitest";
import type { GraphQLContext } from "../../graphql/context.js";
import { createApolloServer, createExpressApp } from "../../graphql/server.js";

interface GraphQLResponse<T = unknown> {
  data?: T;
  errors?: Array<{
    message: string;
    extensions?: {
      code?: string;
      category?: string;
      [key: string]: unknown;
    };
  }>;
}

describe("Image Upload Feature Integration Tests", () => {
  let server: ApolloServer<GraphQLContext>;
  let app: Express;
  let httpServer: Server;
  let baseUrl: string;
  const originalEnv = process.env;

  beforeAll(async () => {
    process.env = { ...originalEnv };
    process.env.IMAGEKIT_PUBLIC_KEY = "test-public-key";
    process.env.IMAGEKIT_PRIVATE_KEY = "test-private-key";
    process.env.IMAGEKIT_URL_ENDPOINT = "https://ik.imagekit.io/test";

    server = createApolloServer();
    await server.start();
    app = createExpressApp(server);
    httpServer = app.listen(0);
    const port = (httpServer.address() as { port: number }).port;
    baseUrl = `http://localhost:${port}/graphql`;
  });

  afterAll(async () => {
    await server.stop();
    httpServer.close();
    process.env = originalEnv;
  });

  async function executeQuery<T>(
    query: string,
    variables?: Record<string, unknown>,
    headers?: Record<string, string>,
  ): Promise<GraphQLResponse<T>> {
    const response = await fetch(baseUrl, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        ...headers,
      },
      body: JSON.stringify({ query, variables }),
    });
    return response.json() as Promise<GraphQLResponse<T>>;
  }

  describe("Schema Introspection - UploadCredentials Type", () => {
    it("should have UploadCredentials type registered", async () => {
      const result = await executeQuery<{
        __type: {
          name: string;
          fields: Array<{ name: string; type: { name: string | null } }>;
        } | null;
      }>(`
        query {
          __type(name: "UploadCredentials") {
            name
            fields {
              name
              type {
                name
              }
            }
          }
        }
      `);

      expect(result.errors).toBeUndefined();
      expect(result.data?.__type).not.toBeNull();
      expect(result.data?.__type?.name).toBe("UploadCredentials");

      const fieldNames = result.data?.__type?.fields?.map((f) => f.name) ?? [];
      expect(fieldNames).toContain("token");
      expect(fieldNames).toContain("signature");
      expect(fieldNames).toContain("expire");
      expect(fieldNames).toContain("publicKey");
      expect(fieldNames).toContain("uploadEndpoint");
    });

    it("should have ImageUploadError type registered", async () => {
      const result = await executeQuery<{
        __type: {
          name: string;
          fields: Array<{ name: string }>;
        } | null;
      }>(`
        query {
          __type(name: "ImageUploadError") {
            name
            fields {
              name
            }
          }
        }
      `);

      expect(result.errors).toBeUndefined();
      expect(result.data?.__type).not.toBeNull();
      expect(result.data?.__type?.name).toBe("ImageUploadError");

      const fieldNames = result.data?.__type?.fields?.map((f) => f.name) ?? [];
      expect(fieldNames).toContain("code");
      expect(fieldNames).toContain("message");
    });
  });

  describe("Schema Introspection - getUploadCredentials Query", () => {
    it("should have getUploadCredentials query available", async () => {
      const result = await executeQuery<{
        __schema: {
          queryType: {
            fields: Array<{
              name: string;
              type: { name: string | null; kind: string };
            }>;
          } | null;
        };
      }>(`
        query {
          __schema {
            queryType {
              fields {
                name
                type {
                  name
                  kind
                }
              }
            }
          }
        }
      `);

      expect(result.errors).toBeUndefined();
      expect(result.data?.__schema?.queryType).not.toBeNull();

      const queryFields = result.data?.__schema?.queryType?.fields ?? [];
      const getUploadCredentialsQuery = queryFields.find(
        (f) => f.name === "getUploadCredentials",
      );
      expect(getUploadCredentialsQuery).toBeDefined();
    });
  });

  describe("getUploadCredentials Query Execution", () => {
    it("should return authentication error when not authenticated", async () => {
      const result = await executeQuery<{
        getUploadCredentials:
          | {
              __typename: "QueryGetUploadCredentialsSuccess";
              data: { token: string };
            }
          | { __typename: "ImageUploadError"; code: string; message: string };
      }>(`
        query {
          getUploadCredentials {
            ... on QueryGetUploadCredentialsSuccess {
              __typename
              data {
                token
                signature
                expire
                publicKey
                uploadEndpoint
              }
            }
            ... on ImageUploadError {
              __typename
              code
              message
            }
          }
        }
      `);

      expect(result.errors).toBeDefined();
      expect(result.errors?.[0]?.message).toContain("Not authorized");
    });
  });
});
