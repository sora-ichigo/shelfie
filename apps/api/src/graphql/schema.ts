import { createFirebaseAuthAdapter } from "../auth/index.js";
import { config } from "../config/index.js";
import { getDb } from "../db/index.js";
import {
  createAuthService,
  registerAuthMutations,
  registerAuthQueries,
  registerAuthTypes,
} from "../features/auth/index.js";
import {
  createBookSearchService,
  createBookShelfRepository,
  createBookShelfService,
  createExternalBookRepository,
  registerBooksMutations,
  registerBooksQueries,
  registerBooksTypes,
} from "../features/books/index.js";
import {
  createUserRepository,
  createUserService,
  registerUserTypes,
} from "../features/users/index.js";
import { logger } from "../logger/index.js";
import { builder } from "./builder.js";

registerUserTypes(builder);
registerAuthTypes(builder);
registerBooksTypes(builder);

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

const rakutenApplicationId = config.getOrDefault("RAKUTEN_APPLICATION_ID", "");
const externalBookRepository =
  createExternalBookRepository(rakutenApplicationId);
const bookSearchService = createBookSearchService(
  externalBookRepository,
  logger,
);
const bookShelfRepository = createBookShelfRepository(db);
const bookShelfService = createBookShelfService(bookShelfRepository, logger);

registerAuthMutations(builder, authService);
registerAuthQueries(builder, authService);
registerBooksQueries(builder, bookSearchService, bookShelfService, userService);
registerBooksMutations(builder, bookShelfService, userService);

export function buildSchema() {
  return builder.toSchema();
}

export const schema = buildSchema();
