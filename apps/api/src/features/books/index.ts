export type { Book, GoogleBooksVolume } from "./internal/book-mapper.js";
export { mapGoogleBooksVolume } from "./internal/book-mapper.js";

export type {
  ExternalApiErrors,
  ExternalBookRepository,
} from "./internal/external-book-repository.js";
export { createExternalBookRepository } from "./internal/external-book-repository.js";
