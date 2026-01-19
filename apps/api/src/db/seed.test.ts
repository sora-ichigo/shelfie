import { existsSync } from "node:fs";
import { resolve } from "node:path";
import { describe, expect, it } from "vitest";

describe("seed.ts", () => {
  it("should exist in the db directory", () => {
    const seedPath = resolve(import.meta.dirname, "seed.ts");
    expect(existsSync(seedPath)).toBe(true);
  });

  it("should export seed function", async () => {
    const seedModule = await import("./seed.js");
    expect(typeof seedModule.seed).toBe("function");
  });

  it("should export clearDatabase function for test cleanup", async () => {
    const seedModule = await import("./seed.js");
    expect(typeof seedModule.clearDatabase).toBe("function");
  });
});

describe("seed data definitions", () => {
  it("should export initial seed data", async () => {
    const seedModule = await import("./seed.js");
    expect(seedModule.seedData).toBeDefined();
    expect(typeof seedModule.seedData).toBe("object");
  });
});
