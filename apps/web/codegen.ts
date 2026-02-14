import type { CodegenConfig } from "@graphql-codegen/cli";

const config: CodegenConfig = {
  schema: "../api/schema.graphql",
  documents: ["app/**/*.tsx", "lib/**/*.ts"],
  ignoreNoDocuments: true,
  generates: {
    "./lib/graphql/generated/": {
      preset: "client",
      config: {
        useTypeImports: true,
      },
    },
  },
};

export default config;
