import { defineConfig } from "vite";

export default defineConfig({
  resolve: {
    dedupe: ["graphql"],
  },
  build: {
    target: "node24",
    ssr: true,
    outDir: "dist",
    rollupOptions: {
      input: "src/index.ts",
      output: {
        entryFileNames: "index.js",
      },
    },
  },
});
