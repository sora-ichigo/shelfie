import type { NodePgDatabase } from "drizzle-orm/node-postgres";
import type { FeatureModule } from "../index.js";
import { createUserRepository, type UserRepository } from "./repository.js";
import { createUserService, type UserService } from "./service.js";
import { registerUserTypes } from "./types.js";

export const USERS_FEATURE_NAME = "users";

export interface UsersPublicApi {
  service: UserService;
  repository: UserRepository;
}

export function createUsersFeature(
  db: NodePgDatabase,
): FeatureModule<UsersPublicApi> {
  const repository = createUserRepository(db);
  const service = createUserService(repository);

  return {
    name: USERS_FEATURE_NAME,

    registerTypes(builder: unknown): void {
      registerUserTypes(builder);
    },

    getPublicApi(): UsersPublicApi {
      return {
        service,
        repository,
      };
    },
  };
}

export type { UserRepository } from "./repository.js";
export type { UserService } from "./service.js";
