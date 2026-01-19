import SchemaBuilder from "@pothos/core";
import ErrorsPlugin from "@pothos/plugin-errors";
import { DateTimeResolver } from "graphql-scalars";
import type { GraphQLContext } from "./context";

export type { GraphQLContext } from "./context";

export interface SchemaTypes {
  Context: GraphQLContext;
  Scalars: {
    DateTime: {
      Input: Date;
      Output: Date;
    };
  };
}

function createBuilder() {
  const builder = new SchemaBuilder<SchemaTypes>({
    plugins: [ErrorsPlugin],
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
