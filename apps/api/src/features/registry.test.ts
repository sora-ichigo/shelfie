import { beforeEach, describe, expect, it } from "vitest";
import {
  createFeatureRegistry,
  type FeatureModule,
  type FeatureRegistry,
} from "./registry.js";

describe("Feature Registry", () => {
  let registry: FeatureRegistry;

  beforeEach(() => {
    registry = createFeatureRegistry();
  });

  describe("feature registration", () => {
    it("should register a feature module", () => {
      const mockFeature: FeatureModule<{ test: () => string }> = {
        name: "test-feature",
        registerTypes: () => {},
        getPublicApi: () => ({ test: () => "value" }),
      };

      registry.register(mockFeature);
      expect(registry.has("test-feature")).toBe(true);
    });

    it("should throw error when registering duplicate feature name", () => {
      const feature1: FeatureModule<object> = {
        name: "duplicate",
        registerTypes: () => {},
        getPublicApi: () => ({}),
      };
      const feature2: FeatureModule<object> = {
        name: "duplicate",
        registerTypes: () => {},
        getPublicApi: () => ({}),
      };

      registry.register(feature1);
      expect(() => registry.register(feature2)).toThrow(
        "Feature 'duplicate' is already registered",
      );
    });
  });

  describe("feature access", () => {
    it("should get feature public API by name", () => {
      interface TestApi {
        getValue: () => number;
      }
      const mockFeature: FeatureModule<TestApi> = {
        name: "test-feature",
        registerTypes: () => {},
        getPublicApi: () => ({
          getValue: () => 42,
        }),
      };

      registry.register(mockFeature);
      const api = registry.getPublicApi<TestApi>("test-feature");
      expect(api.getValue()).toBe(42);
    });

    it("should throw error when accessing unregistered feature", () => {
      expect(() => registry.getPublicApi("unknown")).toThrow(
        "Feature 'unknown' is not registered",
      );
    });

    it("should list all registered feature names", () => {
      const feature1: FeatureModule<object> = {
        name: "feature-a",
        registerTypes: () => {},
        getPublicApi: () => ({}),
      };
      const feature2: FeatureModule<object> = {
        name: "feature-b",
        registerTypes: () => {},
        getPublicApi: () => ({}),
      };

      registry.register(feature1);
      registry.register(feature2);

      const names = registry.getFeatureNames();
      expect(names).toContain("feature-a");
      expect(names).toContain("feature-b");
      expect(names).toHaveLength(2);
    });
  });

  describe("schema registration", () => {
    it("should call registerTypes on all features with builder", () => {
      const registeredFeatures: string[] = [];

      const feature1: FeatureModule<object> = {
        name: "feature-a",
        registerTypes: () => {
          registeredFeatures.push("feature-a");
        },
        getPublicApi: () => ({}),
      };
      const feature2: FeatureModule<object> = {
        name: "feature-b",
        registerTypes: () => {
          registeredFeatures.push("feature-b");
        },
        getPublicApi: () => ({}),
      };

      registry.register(feature1);
      registry.register(feature2);

      const mockBuilder = {} as unknown;
      registry.registerAllTypes(mockBuilder);

      expect(registeredFeatures).toContain("feature-a");
      expect(registeredFeatures).toContain("feature-b");
    });
  });

  describe("dependency boundary enforcement", () => {
    it("should provide feature isolation by requiring explicit API access", () => {
      interface FeatureAApi {
        sharedData: () => string;
      }

      const featureA: FeatureModule<FeatureAApi> = {
        name: "feature-a",
        registerTypes: () => {},
        getPublicApi: () => ({
          sharedData: () => "shared",
        }),
      };

      registry.register(featureA);

      const featureAApi = registry.getPublicApi<FeatureAApi>("feature-a");
      expect(featureAApi.sharedData()).toBe("shared");
    });
  });
});
