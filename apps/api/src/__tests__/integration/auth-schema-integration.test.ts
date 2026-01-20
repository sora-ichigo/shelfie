import type { Server } from "node:http";
import type { ApolloServer } from "@apollo/server";
import type { Express } from "express";
import {
  afterAll,
  beforeAll,
  beforeEach,
  describe,
  expect,
  it,
  vi,
} from "vitest";
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

describe("Auth Feature Schema Integration Tests", () => {
  let server: ApolloServer<GraphQLContext>;
  let app: Express;
  let httpServer: Server;
  let baseUrl: string;

  beforeAll(async () => {
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
  });

  async function executeQuery<T>(
    query: string,
    variables?: Record<string, unknown>,
  ): Promise<GraphQLResponse<T>> {
    const response = await fetch(baseUrl, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ query, variables }),
    });
    return response.json() as Promise<GraphQLResponse<T>>;
  }

  describe("Schema Introspection - Auth Types", () => {
    it("should have AuthErrorCode enum type registered", async () => {
      const result = await executeQuery<{
        __type: { name: string; enumValues: Array<{ name: string }> } | null;
      }>(`
        query {
          __type(name: "AuthErrorCode") {
            name
            enumValues {
              name
            }
          }
        }
      `);

      expect(result.errors).toBeUndefined();
      expect(result.data?.__type).not.toBeNull();
      expect(result.data?.__type?.name).toBe("AuthErrorCode");

      const enumValues =
        result.data?.__type?.enumValues?.map((v) => v.name) ?? [];
      expect(enumValues).toContain("EMAIL_ALREADY_EXISTS");
      expect(enumValues).toContain("INVALID_PASSWORD");
      expect(enumValues).toContain("USER_NOT_FOUND");
      expect(enumValues).toContain("EMAIL_ALREADY_VERIFIED");
      expect(enumValues).toContain("RATE_LIMIT_EXCEEDED");
      expect(enumValues).toContain("NETWORK_ERROR");
      expect(enumValues).toContain("INTERNAL_ERROR");
    });

    it("should have AuthError object type registered", async () => {
      const result = await executeQuery<{
        __type: {
          name: string;
          fields: Array<{ name: string; type: { name: string | null } }>;
        } | null;
      }>(`
        query {
          __type(name: "AuthError") {
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
      expect(result.data?.__type?.name).toBe("AuthError");

      const fieldNames =
        result.data?.__type?.fields?.map((f) => f.name) ?? [];
      expect(fieldNames).toContain("code");
      expect(fieldNames).toContain("message");
      expect(fieldNames).toContain("field");
      expect(fieldNames).toContain("retryable");
    });

    it("should have RegisterUserInput type registered", async () => {
      const result = await executeQuery<{
        __type: {
          name: string;
          inputFields: Array<{ name: string }>;
        } | null;
      }>(`
        query {
          __type(name: "RegisterUserInput") {
            name
            inputFields {
              name
            }
          }
        }
      `);

      expect(result.errors).toBeUndefined();
      expect(result.data?.__type).not.toBeNull();
      expect(result.data?.__type?.name).toBe("RegisterUserInput");

      const fieldNames =
        result.data?.__type?.inputFields?.map((f) => f.name) ?? [];
      expect(fieldNames).toContain("email");
      expect(fieldNames).toContain("password");
    });

    it("should have ResendVerificationEmailInput type registered", async () => {
      const result = await executeQuery<{
        __type: {
          name: string;
          inputFields: Array<{ name: string }>;
        } | null;
      }>(`
        query {
          __type(name: "ResendVerificationEmailInput") {
            name
            inputFields {
              name
            }
          }
        }
      `);

      expect(result.errors).toBeUndefined();
      expect(result.data?.__type).not.toBeNull();
      expect(result.data?.__type?.name).toBe("ResendVerificationEmailInput");

      const fieldNames =
        result.data?.__type?.inputFields?.map((f) => f.name) ?? [];
      expect(fieldNames).toContain("email");
    });

    it("should have User type registered", async () => {
      const result = await executeQuery<{
        __type: {
          name: string;
          fields: Array<{ name: string }>;
        } | null;
      }>(`
        query {
          __type(name: "User") {
            name
            fields {
              name
            }
          }
        }
      `);

      expect(result.errors).toBeUndefined();
      expect(result.data?.__type).not.toBeNull();
      expect(result.data?.__type?.name).toBe("User");

      const fieldNames =
        result.data?.__type?.fields?.map((f) => f.name) ?? [];
      expect(fieldNames).toContain("id");
      expect(fieldNames).toContain("email");
      expect(fieldNames).toContain("createdAt");
      expect(fieldNames).toContain("updatedAt");
    });
  });

  describe("Schema Introspection - Auth Mutations", () => {
    it("should have registerUser mutation available", async () => {
      const result = await executeQuery<{
        __schema: {
          mutationType: {
            fields: Array<{
              name: string;
              args: Array<{ name: string; type: { name: string | null } }>;
            }>;
          } | null;
        };
      }>(`
        query {
          __schema {
            mutationType {
              fields {
                name
                args {
                  name
                  type {
                    name
                  }
                }
              }
            }
          }
        }
      `);

      expect(result.errors).toBeUndefined();
      expect(result.data?.__schema?.mutationType).not.toBeNull();

      const mutationFields =
        result.data?.__schema?.mutationType?.fields ?? [];
      const registerUserMutation = mutationFields.find(
        (f) => f.name === "registerUser",
      );
      expect(registerUserMutation).toBeDefined();
      expect(
        registerUserMutation?.args.find((a) => a.name === "input"),
      ).toBeDefined();
    });

    it("should have resendVerificationEmail mutation available", async () => {
      const result = await executeQuery<{
        __schema: {
          mutationType: {
            fields: Array<{
              name: string;
              args: Array<{ name: string; type: { name: string | null } }>;
            }>;
          } | null;
        };
      }>(`
        query {
          __schema {
            mutationType {
              fields {
                name
                args {
                  name
                  type {
                    name
                  }
                }
              }
            }
          }
        }
      `);

      expect(result.errors).toBeUndefined();

      const mutationFields =
        result.data?.__schema?.mutationType?.fields ?? [];
      const resendMutation = mutationFields.find(
        (f) => f.name === "resendVerificationEmail",
      );
      expect(resendMutation).toBeDefined();
      expect(
        resendMutation?.args.find((a) => a.name === "input"),
      ).toBeDefined();
    });
  });

  describe("Existing Query - Regression Test", () => {
    it("should still have health query working", async () => {
      const result = await executeQuery<{ health: string }>("{ health }");

      expect(result.errors).toBeUndefined();
      expect(result.data?.health).toBe("ok");
    });
  });
});
