import { defineConfig } from "vite";

export default defineConfig({
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
