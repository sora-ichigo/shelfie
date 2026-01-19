import SchemaBuilder from "@pothos/core";
import { DateTimeResolver } from "graphql-scalars";
import type { GraphQLContext } from "./context";

export type { GraphQLContext } from "./context";

interface SchemaTypes {
  Context: GraphQLContext;
  Scalars: {
    DateTime: {
      Input: Date;
      Output: Date;
    };
  };
}

function createBuilder() {
  const builder = new SchemaBuilder<SchemaTypes>({});

  builder.addScalarType("DateTime", DateTimeResolver, {});

  return builder;
}

export const builder = createBuilder();

export function createTestBuilder() {
  return createBuilder();
}
