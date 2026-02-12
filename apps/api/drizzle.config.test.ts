import { defineConfig } from "drizzle-kit";

export default defineConfig({
  schema: [
    "./src/db/schema/users.ts",
    "./src/db/schema/books.ts",
    "./src/db/schema/device-tokens.ts",
    "./src/db/schema/follow-requests.ts",
    "./src/db/schema/follows.ts",
    "./src/db/schema/notifications.ts",
  ],
  out: "./drizzle/migrations",
  dialect: "postgresql",
  dbCredentials: {
    url: "postgres://shelfie:shelfie@localhost:5432/shelfie_test",
  },
});
