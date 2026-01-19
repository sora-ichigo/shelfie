import { describe, expect, it, vi } from "vitest";
import { createAuthFeature, AUTH_FEATURE_NAME } from "./index.js";
import type { UserService } from "../users/service.js";
import type { LoggerService } from "../../logger/index.js";
import type { FirebaseAuth } from "./service.js";

function createMockFirebaseAuth(): FirebaseAuth {
  return {
    createUser: vi.fn(),
    getUserByEmail: vi.fn(),
    generateEmailVerificationLink: vi.fn(),
  };
}

function createMockUserService(): UserService {
  return {
    getUserById: vi.fn(),
    createUser: vi.fn(),
    getUsers: vi.fn(),
    getUserByFirebaseUid: vi.fn(),
    createUserWithFirebase: vi.fn(),
  };
}

function createMockLogger(): LoggerService {
  return {
    debug: vi.fn(),
    info: vi.fn(),
    warn: vi.fn(),
    error: vi.fn(),
    child: vi.fn().mockReturnThis(),
  };
}

describe("Auth Feature Module", () => {
  it("should have correct feature name", () => {
    const feature = createAuthFeature({
      firebaseAuth: createMockFirebaseAuth(),
      userService: createMockUserService(),
      logger: createMockLogger(),
    });

    expect(feature.name).toBe(AUTH_FEATURE_NAME);
    expect(feature.name).toBe("auth");
  });

  it("should provide auth service via public API", () => {
    const feature = createAuthFeature({
      firebaseAuth: createMockFirebaseAuth(),
      userService: createMockUserService(),
      logger: createMockLogger(),
    });

    const api = feature.getPublicApi();
    expect(api.service).toBeDefined();
    expect(typeof api.service.register).toBe("function");
    expect(typeof api.service.resendVerificationEmail).toBe("function");
  });

  it("should have registerTypes method", () => {
    const feature = createAuthFeature({
      firebaseAuth: createMockFirebaseAuth(),
      userService: createMockUserService(),
      logger: createMockLogger(),
    });

    expect(typeof feature.registerTypes).toBe("function");
  });

  it("should have registerMutations method", () => {
    const feature = createAuthFeature({
      firebaseAuth: createMockFirebaseAuth(),
      userService: createMockUserService(),
      logger: createMockLogger(),
    });

    expect(typeof feature.registerMutations).toBe("function");
  });
});
