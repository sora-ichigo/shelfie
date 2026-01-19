export interface FeatureModule<TPublicApi> {
  name: string;
  registerTypes(builder: unknown): void;
  getPublicApi(): TPublicApi;
}

export interface FeatureRegistry {
  register<TPublicApi>(feature: FeatureModule<TPublicApi>): void;
  has(featureName: string): boolean;
  getPublicApi<TPublicApi>(featureName: string): TPublicApi;
  getFeatureNames(): string[];
  registerAllTypes(builder: unknown): void;
}

export function createFeatureRegistry(): FeatureRegistry {
  const features = new Map<string, FeatureModule<unknown>>();

  return {
    register<TPublicApi>(feature: FeatureModule<TPublicApi>): void {
      if (features.has(feature.name)) {
        throw new Error(`Feature '${feature.name}' is already registered`);
      }
      features.set(feature.name, feature as FeatureModule<unknown>);
    },

    has(featureName: string): boolean {
      return features.has(featureName);
    },

    getPublicApi<TPublicApi>(featureName: string): TPublicApi {
      const feature = features.get(featureName);
      if (!feature) {
        throw new Error(`Feature '${featureName}' is not registered`);
      }
      return feature.getPublicApi() as TPublicApi;
    },

    getFeatureNames(): string[] {
      return Array.from(features.keys());
    },

    registerAllTypes(builder: unknown): void {
      for (const feature of features.values()) {
        feature.registerTypes(builder);
      }
    },
  };
}
