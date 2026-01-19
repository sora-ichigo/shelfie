import type { DomainError, Result } from "../errors/result.js";

export interface FeatureModule<TPublicApi> {
  name: string;
  registerTypes(builder: unknown): void;
  getPublicApi(): TPublicApi;
}

export interface FeatureService<TInput, TOutput> {
  execute(input: TInput): Promise<Result<TOutput, DomainError>>;
}

export interface FeatureRepository<TEntity, TId> {
  findById(id: TId): Promise<TEntity | null>;
  findMany(filter: Partial<TEntity>): Promise<TEntity[]>;
  create(entity: Omit<TEntity, "id">): Promise<TEntity>;
  update(id: TId, data: Partial<TEntity>): Promise<TEntity>;
  delete(id: TId): Promise<void>;
}

export { createFeatureRegistry, type FeatureRegistry } from "./registry.js";
