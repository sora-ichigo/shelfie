import { existsSync } from "node:fs";
import { resolve } from "node:path";
import { describe, expect, it } from "vitest";

describe("drizzle.config.ts", () => {
  it("should exist in the api package root", () => {
    const configPath = resolve(import.meta.dirname, "drizzle.config.ts");
    expect(existsSync(configPath)).toBe(true);
  });

  it("should export a valid drizzle config", async () => {
    const config = await import("./drizzle.config.js");
    expect(config.default).toBeDefined();
  });

  it("should have schema path pointing to db/schema", async () => {
    const config = await import("./drizzle.config.js");
    expect(config.default.schema).toContain("db/schema");
  });

  it("should have migrations output directory set to drizzle/migrations", async () => {
    const config = await import("./drizzle.config.js");
    expect(config.default.out).toBe("./drizzle/migrations");
  });

  it("should use postgresql dialect", async () => {
    const config = await import("./drizzle.config.js");
    expect(config.default.dialect).toBe("postgresql");
  });

  it("should have dbCredentials configured", async () => {
    const config = await import("./drizzle.config.js");
    expect(config.default.dbCredentials).toBeDefined();
    expect(config.default.dbCredentials.url).toBeDefined();
  });
});
