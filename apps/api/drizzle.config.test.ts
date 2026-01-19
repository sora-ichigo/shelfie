import { defineConfig } from "drizzle-kit";

export default defineConfig({
  schema: ["./src/db/schema/users.ts"],
  out: "./drizzle/migrations",
  dialect: "postgresql",
  dbCredentials: {
    url: "postgres://shelfie:shelfie@localhost:5432/shelfie_test",
  },
});
