import SchemaBuilder from "@pothos/core";
import DataloaderPlugin from "@pothos/plugin-dataloader";
import ErrorsPlugin from "@pothos/plugin-errors";
import ScopeAuthPlugin from "@pothos/plugin-scope-auth";
import { DateTimeResolver } from "graphql-scalars";
import type { AuthenticatedUser } from "../auth/index.js";
import type { GraphQLContext } from "./context";

export type { GraphQLContext } from "./context";

export interface AuthenticatedContext extends GraphQLContext {
  user: AuthenticatedUser;
}

export interface SchemaTypes {
  Context: GraphQLContext;
  AuthScopes: {
    loggedIn: boolean;
    emailVerified: boolean;
  };
  AuthContexts: {
    loggedIn: AuthenticatedContext;
    emailVerified: AuthenticatedContext;
  };
  Scalars: {
    DateTime: {
      Input: Date;
      Output: Date;
    };
  };
}

function createBuilder() {
  const builder = new SchemaBuilder<SchemaTypes>({
    plugins: [ScopeAuthPlugin, ErrorsPlugin, DataloaderPlugin],
    scopeAuth: {
      authScopes: (context) => ({
        loggedIn: !!context.user,
        emailVerified: !!context.user?.emailVerified,
      }),
      unauthorizedError: (_parent, _context, _info, result) => {
        return new Error(result.message);
      },
    },
    errors: {
      defaultTypes: [],
    },
  });

  builder.addScalarType("DateTime", DateTimeResolver, {});

  return builder;
}

export const builder = createBuilder();

export type Builder = typeof builder;

export function createTestBuilder() {
  return createBuilder();
}
