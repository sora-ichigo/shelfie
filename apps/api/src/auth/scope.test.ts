import { describe, expect, it } from "vitest";
import { GraphQLError } from "graphql";
import {
  requireAuth,
  requireEmailVerified,
  type AuthenticatedContext,
} from "./scope";
import type { GraphQLContext } from "../graphql/context";

describe("Auth Scope", () => {
  describe("requireAuth", () => {
    it("認証済みユーザーの場合は AuthenticatedContext を返す", () => {
      const context: GraphQLContext = {
        requestId: "test-request-id",
        user: {
          uid: "user-123",
          email: "user@example.com",
          emailVerified: true,
        },
      };

      const result = requireAuth(context);

      expect(result.user).toEqual({
        uid: "user-123",
        email: "user@example.com",
        emailVerified: true,
      });
      expect(result.requestId).toBe("test-request-id");
    });

    it("未認証の場合は UNAUTHENTICATED エラーをスローする", () => {
      const context: GraphQLContext = {
        requestId: "test-request-id",
        user: null,
      };

      expect(() => requireAuth(context)).toThrow(GraphQLError);
      expect(() => requireAuth(context)).toThrow("Authentication required");

      try {
        requireAuth(context);
      } catch (error) {
        expect((error as GraphQLError).extensions?.code).toBe("UNAUTHENTICATED");
      }
    });
  });

  describe("requireEmailVerified", () => {
    it("メール確認済みユーザーの場合は AuthenticatedContext を返す", () => {
      const context: GraphQLContext = {
        requestId: "test-request-id",
        user: {
          uid: "user-123",
          email: "user@example.com",
          emailVerified: true,
        },
      };

      const result = requireEmailVerified(context);

      expect(result.user.emailVerified).toBe(true);
    });

    it("メール未確認の場合は FORBIDDEN エラーをスローする", () => {
      const context: GraphQLContext = {
        requestId: "test-request-id",
        user: {
          uid: "user-123",
          email: "user@example.com",
          emailVerified: false,
        },
      };

      expect(() => requireEmailVerified(context)).toThrow(GraphQLError);
      expect(() => requireEmailVerified(context)).toThrow("Email verification required");

      try {
        requireEmailVerified(context);
      } catch (error) {
        expect((error as GraphQLError).extensions?.code).toBe("FORBIDDEN");
      }
    });

    it("未認証の場合は UNAUTHENTICATED エラーをスローする", () => {
      const context: GraphQLContext = {
        requestId: "test-request-id",
        user: null,
      };

      expect(() => requireEmailVerified(context)).toThrow(GraphQLError);
      expect(() => requireEmailVerified(context)).toThrow("Authentication required");
    });
  });
});
