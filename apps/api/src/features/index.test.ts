import { describe, expect, it } from "vitest";
import type { FeatureModule, FeatureRepository, FeatureService } from "./index";

describe("Feature Module Template", () => {
  describe("FeatureModule interface", () => {
    it("should define name property for feature identification", () => {
      const mockModule: FeatureModule<{ testMethod: () => string }> = {
        name: "test-feature",
        registerTypes: () => {},
        getPublicApi: () => ({ testMethod: () => "test" }),
      };

      expect(mockModule.name).toBe("test-feature");
    });

    it("should define registerTypes method for Pothos schema registration", () => {
      const mockModule: FeatureModule<object> = {
        name: "test-feature",
        registerTypes: (_builder) => {},
        getPublicApi: () => ({}),
      };

      expect(typeof mockModule.registerTypes).toBe("function");
    });

    it("should define getPublicApi method for inter-feature access", () => {
      interface TestApi {
        getData: () => string;
      }
      const mockModule: FeatureModule<TestApi> = {
        name: "test-feature",
        registerTypes: () => {},
        getPublicApi: () => ({
          getData: () => "data",
        }),
      };

      const api = mockModule.getPublicApi();
      expect(api.getData()).toBe("data");
    });
  });

  describe("FeatureService interface", () => {
    it("should define execute method with Result return type pattern", async () => {
      interface Input {
        id: string;
      }
      interface Output {
        name: string;
      }

      const mockService: FeatureService<Input, Output> = {
        execute: async (_input) => ({
          success: true,
          data: { name: "test" },
        }),
      };

      const result = await mockService.execute({ id: "1" });
      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.name).toBe("test");
      }
    });

    it("should support error result from service execution", async () => {
      interface Input {
        id: string;
      }
      interface Output {
        name: string;
      }

      const mockService: FeatureService<Input, Output> = {
        execute: async (_input) => ({
          success: false,
          error: { code: "NOT_FOUND", message: "Entity not found" },
        }),
      };

      const result = await mockService.execute({ id: "999" });
      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("NOT_FOUND");
      }
    });
  });

  describe("FeatureRepository interface", () => {
    it("should define standard CRUD methods", () => {
      interface TestEntity {
        id: number;
        name: string;
      }

      const mockRepository: FeatureRepository<TestEntity, number> = {
        findById: async (_id) => null,
        findMany: async (_filter) => [],
        create: async (entity) => ({ id: 1, ...entity }) as TestEntity,
        update: async (id, _data) => ({ id, name: "updated" }),
        delete: async (_id) => {},
      };

      expect(typeof mockRepository.findById).toBe("function");
      expect(typeof mockRepository.findMany).toBe("function");
      expect(typeof mockRepository.create).toBe("function");
      expect(typeof mockRepository.update).toBe("function");
      expect(typeof mockRepository.delete).toBe("function");
    });

    it("should return entity or null from findById", async () => {
      interface TestEntity {
        id: number;
        name: string;
      }

      const mockRepository: FeatureRepository<TestEntity, number> = {
        findById: async (id) => (id === 1 ? { id: 1, name: "found" } : null),
        findMany: async () => [],
        create: async (entity) => ({ id: 1, ...entity }) as TestEntity,
        update: async (id, data) => ({ id, ...data }) as TestEntity,
        delete: async () => {},
      };

      const found = await mockRepository.findById(1);
      expect(found).toEqual({ id: 1, name: "found" });

      const notFound = await mockRepository.findById(999);
      expect(notFound).toBeNull();
    });

    it("should return array from findMany", async () => {
      interface TestEntity {
        id: number;
        name: string;
      }

      const mockRepository: FeatureRepository<TestEntity, number> = {
        findById: async () => null,
        findMany: async () => [
          { id: 1, name: "first" },
          { id: 2, name: "second" },
        ],
        create: async (entity) => ({ id: 1, ...entity }) as TestEntity,
        update: async (id, data) => ({ id, ...data }) as TestEntity,
        delete: async () => {},
      };

      const entities = await mockRepository.findMany({});
      expect(entities).toHaveLength(2);
    });
  });
});
