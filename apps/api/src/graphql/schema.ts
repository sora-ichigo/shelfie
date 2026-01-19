import { builder } from "./builder";

builder.queryType({
  fields: (t) => ({
    health: t.string({
      resolve: () => "ok",
    }),
  }),
});

export function buildSchema() {
  return builder.toSchema();
}

export const schema = buildSchema();
