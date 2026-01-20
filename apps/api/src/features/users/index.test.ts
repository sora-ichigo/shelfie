import { describe, expect, it } from "vitest";
import { createUserRepository, createUserService } from "./index.js";

describe("Users Feature exports", () => {
  it("should export createUserRepository", () => {
    expect(typeof createUserRepository).toBe("function");
  });

  it("should export createUserService", () => {
    expect(typeof createUserService).toBe("function");
  });
});
