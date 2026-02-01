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
  createBookListRepository,
  createBookListService,
  registerBookListsMutations,
  registerBookListsQueries,
  registerBookListsTypes,
} from "../features/book-lists/index.js";
import {
  createBookSearchService,
  createBookShelfRepository,
  createBookShelfService,
  createExternalBookRepository,
  createGoogleBooksRepository,
  registerBooksMutations,
  registerBooksQueries,
  registerBooksTypes,
} from "../features/books/index.js";
import {
  registerImageUploadQueries,
  registerImageUploadTypes,
} from "../features/image-upload/index.js";
import {
  createUserRepository,
  createUserService,
  registerUserMutations,
  registerUserTypes,
} from "../features/users/index.js";
import { logger } from "../logger/index.js";
import { builder } from "./builder.js";

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
const googleBooksApiKey = config.getOrDefault("GOOGLE_BOOKS_API_KEY", "");
const externalBookRepository =
  createExternalBookRepository(rakutenApplicationId);
const googleBooksRepository = createGoogleBooksRepository(googleBooksApiKey);
const bookSearchService = createBookSearchService(
  externalBookRepository,
  logger,
  googleBooksRepository,
);
const bookShelfRepository = createBookShelfRepository(db);
const bookShelfService = createBookShelfService(bookShelfRepository, logger);
const bookListRepository = createBookListRepository(db);
const bookListService = createBookListService(
  bookListRepository,
  bookShelfRepository,
  logger,
);

registerUserTypes(builder, bookShelfRepository);
registerAuthTypes(builder);
registerBooksTypes(builder);
registerImageUploadTypes(builder);
registerBookListsTypes(builder, bookShelfRepository);

builder.queryType({
  fields: (t) => ({
    health: t.string({
      resolve: () => "ok",
    }),
  }),
});

registerAuthMutations(builder, authService);
registerAuthQueries(builder, authService);
registerBooksQueries(builder, bookSearchService, bookShelfService, userService);
registerBooksMutations(builder, bookShelfService, userService);
registerUserMutations(builder, userService);
registerImageUploadQueries(builder);
registerBookListsQueries(builder, bookListService, userService);
registerBookListsMutations(builder, bookListService, userService);

export function buildSchema() {
  return builder.toSchema();
}

export const schema = buildSchema();
