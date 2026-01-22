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
