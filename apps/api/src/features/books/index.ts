export type {
  Book,
  BookDetail,
  GoogleBooksVolume,
  GoogleBooksVolumeInfo,
  RakutenBooksItem,
} from "./internal/book-mapper.js";
export {
  mapGoogleBooksVolume,
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
  GetUserBooksInput,
  GetUserBooksResult,
  NewUserBook,
  ReadingStatusValue,
  ShelfSortField,
  SortOrder,
  UpdateUserBookInput,
  UserBook,
} from "./internal/book-shelf-repository.js";
export { createBookShelfRepository } from "./internal/book-shelf-repository.js";
export type {
  AddBookInput,
  AddBookToShelfInput,
  BookShelfErrors,
  BookShelfService,
  MyShelfResult,
  UpdateReadingNoteInput,
  UpdateReadingStatusInput,
} from "./internal/book-shelf-service.js";
export { createBookShelfService } from "./internal/book-shelf-service.js";
export type { CompositeBookRepository } from "./internal/composite-book-repository.js";
export { createCompositeBookRepository } from "./internal/composite-book-repository.js";
export type {
  ExternalApiErrors,
  ExternalBookRepository,
} from "./internal/external-book-repository.js";
export { createExternalBookRepository } from "./internal/external-book-repository.js";
export type { GoogleBooksRepository } from "./internal/google-books-repository.js";
export { createGoogleBooksRepository } from "./internal/google-books-repository.js";

export {
  registerBooksMutations,
  registerBooksQueries,
  registerBooksTypes,
} from "./internal/graphql.js";
