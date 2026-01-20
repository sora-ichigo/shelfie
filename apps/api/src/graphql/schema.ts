import { createFirebaseAuthAdapter } from "../auth/index.js";
import { getDb } from "../db/index.js";
import {
  createAuthService,
  registerAuthMutations,
  registerAuthTypes,
} from "../features/auth/index.js";
import {
  createUserRepository,
  createUserService,
  registerUserTypes,
} from "../features/users/index.js";
import { logger } from "../logger/index.js";
import { builder } from "./builder.js";

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
