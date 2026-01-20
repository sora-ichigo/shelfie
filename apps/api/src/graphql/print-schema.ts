import "dotenv/config";
import { lexicographicSortSchema, printSchema } from "graphql";
import { writeFileSync } from "node:fs";
import { resolve, dirname } from "node:path";
import { fileURLToPath } from "node:url";
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
