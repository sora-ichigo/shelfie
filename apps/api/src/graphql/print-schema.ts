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

const mobileOutputPath = resolve(
  __dirname,
  "../../../../apps/mobile/lib/core/graphql/schema.graphql",
);
const apiOutputPath = resolve(__dirname, "../../schema.graphql");

writeFileSync(mobileOutputPath, sdl);
writeFileSync(apiOutputPath, sdl);

console.log(`Schema written to ${mobileOutputPath}`);
console.log(`Schema written to ${apiOutputPath}`);
