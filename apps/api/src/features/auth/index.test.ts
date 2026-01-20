import { describe, expect, it } from "vitest";
import {
  AUTH_ERROR_CODES,
  AuthError,
  createAuthService,
  registerAuthMutations,
  registerAuthTypes,
} from "./index.js";

describe("Auth Feature exports", () => {
  it("should export createAuthService", () => {
    expect(typeof createAuthService).toBe("function");
  });

  it("should export registerAuthTypes", () => {
    expect(typeof registerAuthTypes).toBe("function");
  });

  it("should export registerAuthMutations", () => {
    expect(typeof registerAuthMutations).toBe("function");
  });

  it("should export AUTH_ERROR_CODES", () => {
    expect(AUTH_ERROR_CODES).toContain("EMAIL_ALREADY_EXISTS");
  });

  it("should export AuthError class", () => {
    const error = new AuthError("INTERNAL_ERROR", "test");
    expect(error.code).toBe("INTERNAL_ERROR");
  });
});
