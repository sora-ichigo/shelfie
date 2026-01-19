import { defineConfig } from "vitest/config";

export default defineConfig({
  test: {
    include: ["src/**/*.test.ts"],
    setupFiles: ["./vitest.setup.ts"],
    environment: "node",
    globals: false,
    testTimeout: 30000,
    hookTimeout: 30000,
    isolate: false,
    fileParallelism: false,
    env: {
      NODE_ENV: "test",
      DATABASE_URL: "postgres://localhost:5432/shelfie_test",
    },
  },
});
