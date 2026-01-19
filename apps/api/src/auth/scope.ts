import { GraphQLError } from "graphql";
import type { GraphQLContext } from "../graphql/context";
import type { AuthenticatedUser } from "./middleware";

export interface AuthenticatedContext {
  requestId: string;
  user: AuthenticatedUser;
}

export function requireAuth(context: GraphQLContext): AuthenticatedContext {
  if (!context.user) {
    throw new GraphQLError("Authentication required", {
      extensions: {
        code: "UNAUTHENTICATED",
      },
    });
  }

  return {
    requestId: context.requestId,
    user: context.user,
  };
}

export function requireEmailVerified(
  context: GraphQLContext,
): AuthenticatedContext {
  const authenticatedContext = requireAuth(context);

  if (!authenticatedContext.user.emailVerified) {
    throw new GraphQLError("Email verification required", {
      extensions: {
        code: "FORBIDDEN",
      },
    });
  }

  return authenticatedContext;
}
