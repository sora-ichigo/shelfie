import { builder } from "./builder.js";
import { createFirebaseAuthAdapter } from "../auth/index.js";
import { getDb } from "../db/index.js";
import { logger } from "../logger/index.js";
import {
  registerAuthTypes,
  registerAuthMutations,
  createAuthService,
} from "../features/auth/index.js";
import {
  registerUserTypes,
  createUserRepository,
  createUserService,
} from "../features/users/index.js";

registerUserTypes(builder);
registerAuthTypes(builder);

builder.queryType({
  fields: (t) => ({
    health: t.string({
      resolve: () => "ok",
    }),
  }),
});

const db = getDb();
const userRepository = createUserRepository(db);
const userService = createUserService(userRepository);
const firebaseAuth = createFirebaseAuthAdapter();
const authService = createAuthService({
  firebaseAuth,
  userService,
  logger,
});

registerAuthMutations(builder, authService);

export function buildSchema() {
  return builder.toSchema();
}

export const schema = buildSchema();
