import { defineConfig } from "vitest/config";

export default defineConfig({
  test: {
    include: ["src/**/*.test.ts"],
    setupFiles: ["./vitest.setup.ts"],
    environment: "node",
    globals: false,
    testTimeout: 30000,
    hookTimeout: 30000,
    isolate: true,
    fileParallelism: false,
    env: {
      NODE_ENV: "test",
    },
  },
});
