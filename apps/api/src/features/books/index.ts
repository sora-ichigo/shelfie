export type { Book, GoogleBooksVolume } from "./internal/book-mapper.js";
export { mapGoogleBooksVolume } from "./internal/book-mapper.js";

export type {
  ExternalApiErrors,
  ExternalBookRepository,
} from "./internal/external-book-repository.js";
export { createExternalBookRepository } from "./internal/external-book-repository.js";

export type {
  BookSearchErrors,
  BookSearchService,
  SearchBooksInput,
  SearchBooksResult,
  SearchByISBNInput,
} from "./internal/book-search-service.js";
export { createBookSearchService } from "./internal/book-search-service.js";

export type {
  BookShelfRepository,
  NewUserBook,
  UserBook,
} from "./internal/book-shelf-repository.js";
export { createBookShelfRepository } from "./internal/book-shelf-repository.js";

export type {
  AddBookInput,
  AddBookToShelfInput,
  BookShelfErrors,
  BookShelfService,
} from "./internal/book-shelf-service.js";
export { createBookShelfService } from "./internal/book-shelf-service.js";
