import type { NodePgDatabase } from "drizzle-orm/node-postgres";
import { describe, expect, it } from "vitest";
import { createTestBuilder } from "../../graphql/builder.js";
import {
  createUsersFeature,
  USERS_FEATURE_NAME,
  type UsersPublicApi,
} from "./index.js";

describe("Users Feature Module", () => {
  describe("module structure", () => {
    it("should have correct feature name", () => {
      expect(USERS_FEATURE_NAME).toBe("users");
    });

    it("should create feature module with required properties", () => {
      const mockDb = {} as NodePgDatabase;
      const feature = createUsersFeature(mockDb);

      expect(feature.name).toBe("users");
      expect(typeof feature.registerTypes).toBe("function");
      expect(typeof feature.getPublicApi).toBe("function");
    });
  });

  describe("schema registration", () => {
    it("should register User type when registerTypes is called", () => {
      const mockDb = {} as NodePgDatabase;
      const feature = createUsersFeature(mockDb);
      const builder = createTestBuilder();

      feature.registerTypes(builder);

      builder.queryType({
        fields: (t) => ({
          _empty: t.string({ resolve: () => "" }),
        }),
      });

      const schema = builder.toSchema();
      const userType = schema.getType("User");
      expect(userType).toBeDefined();
    });
  });

  describe("public API", () => {
    it("should expose service through public API", () => {
      const mockDb = {} as NodePgDatabase;
      const feature = createUsersFeature(mockDb);
      const publicApi = feature.getPublicApi();

      expect(publicApi.service).toBeDefined();
      expect(typeof publicApi.service.getUserById).toBe("function");
      expect(typeof publicApi.service.createUser).toBe("function");
      expect(typeof publicApi.service.getUsers).toBe("function");
    });

    it("should expose repository through public API", () => {
      const mockDb = {} as NodePgDatabase;
      const feature = createUsersFeature(mockDb);
      const publicApi = feature.getPublicApi();

      expect(publicApi.repository).toBeDefined();
      expect(typeof publicApi.repository.findById).toBe("function");
      expect(typeof publicApi.repository.findByEmail).toBe("function");
    });
  });

  describe("UsersPublicApi type", () => {
    it("should be typed for inter-feature access", () => {
      const mockDb = {} as NodePgDatabase;
      const feature = createUsersFeature(mockDb);
      const api: UsersPublicApi = feature.getPublicApi();

      expect(api.service).toBeDefined();
      expect(api.repository).toBeDefined();
    });
  });
});
