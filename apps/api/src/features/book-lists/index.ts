export type {
  BookList,
  BookListItem,
  NewBookList,
  NewBookListItem,
  BookListRepository,
  CreateBookListInput,
  UpdateBookListInput,
  CreateBookListItemInput,
  FindBookListsOptions,
  FindBookListsResult,
} from "./internal/repository.js";

export { createBookListRepository } from "./internal/repository.js";

export type {
  BookListService,
  BookListErrors,
  CreateBookListServiceInput,
  UpdateBookListServiceInput,
  AddBookToListInput,
  RemoveBookFromListInput,
  ReorderBookInput,
  BookListWithItems,
  BookListSummary,
  GetUserBookListsInput,
  BookListSummaryResult,
} from "./internal/service.js";

export { createBookListService } from "./internal/service.js";
