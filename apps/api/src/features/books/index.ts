export type {
  Book,
  BookDetail,
  RakutenBooksItem,
} from "./internal/book-mapper.js";
export {
  mapRakutenBooksItem,
  mapRakutenBooksItemToDetail,
} from "./internal/book-mapper.js";
export type {
  BookDetail as BookDetailFromSearchService,
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
  ReadingStatusValue,
  UpdateUserBookInput,
  UserBook,
} from "./internal/book-shelf-repository.js";
export { createBookShelfRepository } from "./internal/book-shelf-repository.js";
export type {
  AddBookInput,
  AddBookToShelfInput,
  BookShelfErrors,
  BookShelfService,
  UpdateReadingNoteInput,
  UpdateReadingStatusInput,
} from "./internal/book-shelf-service.js";
export { createBookShelfService } from "./internal/book-shelf-service.js";
export type {
  ExternalApiErrors,
  ExternalBookRepository,
} from "./internal/external-book-repository.js";
export { createExternalBookRepository } from "./internal/external-book-repository.js";

export {
  registerBooksMutations,
  registerBooksQueries,
  registerBooksTypes,
} from "./internal/graphql.js";
