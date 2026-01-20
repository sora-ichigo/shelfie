import "dotenv/config";
import { writeFileSync } from "node:fs";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { lexicographicSortSchema, printSchema } from "graphql";
import { buildSchema } from "./schema.js";

const __dirname = dirname(fileURLToPath(import.meta.url));

const schema = buildSchema();
const sortedSchema = lexicographicSortSchema(schema);
const sdl = printSchema(sortedSchema);

const outputPath = resolve(
  __dirname,
  "../../../../apps/mobile/lib/core/graphql/schema.graphql",
);

writeFileSync(outputPath, sdl);

console.log(`Schema written to ${outputPath}`);
