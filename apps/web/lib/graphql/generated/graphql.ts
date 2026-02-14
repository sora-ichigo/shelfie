/* eslint-disable */
import type { TypedDocumentNode as DocumentNode } from '@graphql-typed-document-node/core';
export type Maybe<T> = T | null;
export type InputMaybe<T> = T | null | undefined;
export type Exact<T extends { [key: string]: unknown }> = { [K in keyof T]: T[K] };
export type MakeOptional<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]?: Maybe<T[SubKey]> };
export type MakeMaybe<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]: Maybe<T[SubKey]> };
export type MakeEmpty<T extends { [key: string]: unknown }, K extends keyof T> = { [_ in K]?: never };
export type Incremental<T> = T | { [P in keyof T]?: P extends ' $fragmentName' | '__typename' ? T[P] : never };
/** All built-in and custom scalars, mapped to their actual values */
export type Scalars = {
  ID: { input: string; output: string; }
  String: { input: string; output: string; }
  Boolean: { input: boolean; output: boolean; }
  Int: { input: number; output: number; }
  Float: { input: number; output: number; }
  /** A date-time string at UTC, such as 2007-12-03T10:15:30Z, compliant with the `date-time` format outlined in section 5.6 of the RFC 3339 profile of the ISO 8601 standard for representation of dates and times using the Gregorian calendar. */
  DateTime: { input: any; output: any; }
};

/** Input for adding a book to the shelf */
export type AddBookInput = {
  /** The authors of the book */
  authors: Array<Scalars['String']['input']>;
  /** The cover image URL of the book */
  coverImageUrl?: InputMaybe<Scalars['String']['input']>;
  /** The external ID of the book */
  externalId: Scalars['String']['input'];
  /** The ISBN of the book */
  isbn?: InputMaybe<Scalars['String']['input']>;
  /** The publication date of the book */
  publishedDate?: InputMaybe<Scalars['String']['input']>;
  /** The publisher of the book */
  publisher?: InputMaybe<Scalars['String']['input']>;
  /** The initial reading status of the book (defaults to backlog) */
  readingStatus?: InputMaybe<ReadingStatus>;
  /** The source of the book data (rakuten or google) */
  source: BookSource;
  /** The title of the book */
  title: Scalars['String']['input'];
};

export type AppNotification = {
  __typename?: 'AppNotification';
  createdAt: Scalars['DateTime']['output'];
  followRequestId?: Maybe<Scalars['Int']['output']>;
  id: Scalars['Int']['output'];
  incomingFollowStatus: FollowStatus;
  isRead: Scalars['Boolean']['output'];
  outgoingFollowStatus: FollowStatus;
  sender: User;
  type: NotificationType;
};

/** Error object for authentication operations */
export type AuthError = {
  __typename?: 'AuthError';
  /** Error code */
  code?: Maybe<AuthErrorCode>;
  /** Field that caused the error, if applicable */
  field?: Maybe<Scalars['String']['output']>;
  /** Human-readable error message */
  message?: Maybe<Scalars['String']['output']>;
  /** Whether the operation can be retried */
  retryable?: Maybe<Scalars['Boolean']['output']>;
};

/** Error codes for authentication operations */
export enum AuthErrorCode {
  EmailAlreadyExists = 'EMAIL_ALREADY_EXISTS',
  InternalError = 'INTERNAL_ERROR',
  InvalidCredentials = 'INVALID_CREDENTIALS',
  InvalidEmail = 'INVALID_EMAIL',
  InvalidPassword = 'INVALID_PASSWORD',
  InvalidToken = 'INVALID_TOKEN',
  NetworkError = 'NETWORK_ERROR',
  TokenExpired = 'TOKEN_EXPIRED',
  Unauthenticated = 'UNAUTHENTICATED',
  UserNotFound = 'USER_NOT_FOUND',
  WeakPassword = 'WEAK_PASSWORD'
}

/** Error object for query results */
export type AuthErrorResult = {
  __typename?: 'AuthErrorResult';
  /** Error code */
  code?: Maybe<AuthErrorCode>;
  /** Field that caused the error, if applicable */
  field?: Maybe<Scalars['String']['output']>;
  /** Human-readable error message */
  message?: Maybe<Scalars['String']['output']>;
  /** Whether the operation can be retried */
  retryable?: Maybe<Scalars['Boolean']['output']>;
};

/** A book from the search results */
export type Book = {
  __typename?: 'Book';
  /** The authors of the book */
  authors: Array<Scalars['String']['output']>;
  /** The cover image URL of the book */
  coverImageUrl?: Maybe<Scalars['String']['output']>;
  /** The unique identifier of the book */
  id: Scalars['String']['output'];
  /** The ISBN of the book */
  isbn?: Maybe<Scalars['String']['output']>;
  /** The publication date of the book */
  publishedDate?: Maybe<Scalars['String']['output']>;
  /** The publisher of the book */
  publisher?: Maybe<Scalars['String']['output']>;
  /** The source of the book data (rakuten or google) */
  source: BookSource;
  /** The title of the book */
  title: Scalars['String']['output'];
};

/** Detailed information about a book */
export type BookDetail = {
  __typename?: 'BookDetail';
  /** The Amazon URL for the book */
  amazonUrl?: Maybe<Scalars['String']['output']>;
  /** The authors of the book */
  authors: Array<Scalars['String']['output']>;
  /** The categories/genres of the book */
  categories?: Maybe<Array<Scalars['String']['output']>>;
  /** The cover image URL of the book */
  coverImageUrl?: Maybe<Scalars['String']['output']>;
  /** The description of the book */
  description?: Maybe<Scalars['String']['output']>;
  /**
   * The Google Books URL for the book (deprecated, use rakutenBooksUrl)
   * @deprecated Use rakutenBooksUrl instead
   */
  googleBooksUrl?: Maybe<Scalars['String']['output']>;
  /** The unique identifier of the book */
  id: Scalars['String']['output'];
  /** The ISBN of the book */
  isbn?: Maybe<Scalars['String']['output']>;
  /** The number of pages in the book */
  pageCount?: Maybe<Scalars['Int']['output']>;
  /** The publication date of the book */
  publishedDate?: Maybe<Scalars['String']['output']>;
  /** The publisher of the book */
  publisher?: Maybe<Scalars['String']['output']>;
  /** The Rakuten Books URL for the book */
  rakutenBooksUrl?: Maybe<Scalars['String']['output']>;
  /** The title of the book */
  title: Scalars['String']['output'];
  /** The user's reading record for this book (if added to shelf) */
  userBook?: Maybe<UserBook>;
};

/** A book list created by a user */
export type BookList = {
  __typename?: 'BookList';
  /** When the book list was created */
  createdAt: Scalars['DateTime']['output'];
  /** The description of the book list */
  description?: Maybe<Scalars['String']['output']>;
  /** The unique identifier of the book list */
  id: Scalars['Int']['output'];
  /** The title of the book list */
  title: Scalars['String']['output'];
  /** When the book list was last updated */
  updatedAt: Scalars['DateTime']['output'];
};

/** Detailed information about a book list including items */
export type BookListDetail = {
  __typename?: 'BookListDetail';
  /** When the book list was created */
  createdAt: Scalars['DateTime']['output'];
  /** The description of the book list */
  description?: Maybe<Scalars['String']['output']>;
  /** The unique identifier of the book list */
  id: Scalars['Int']['output'];
  /** The items in the book list */
  items: Array<BookListDetailItem>;
  /** Statistics for the book list */
  stats: BookListDetailStats;
  /** The title of the book list */
  title: Scalars['String']['output'];
  /** When the book list was last updated */
  updatedAt: Scalars['DateTime']['output'];
};

/** An item in a book list with user book details */
export type BookListDetailItem = {
  __typename?: 'BookListDetailItem';
  /** When the book was added to the list */
  addedAt: Scalars['DateTime']['output'];
  /** The unique identifier of the book list item */
  id: Scalars['Int']['output'];
  /** The position of the item in the list */
  position: Scalars['Int']['output'];
  /** The user book details (loaded on demand) */
  userBook?: Maybe<BookListDetailUserBook>;
};

/** Statistics for a book list */
export type BookListDetailStats = {
  __typename?: 'BookListDetailStats';
  /** Total number of books in the list */
  bookCount: Scalars['Int']['output'];
  /** Number of completed books in the list */
  completedCount: Scalars['Int']['output'];
  /** Cover images of books in the list (up to 4) */
  coverImages: Array<Scalars['String']['output']>;
};

/** User book information in a book list detail */
export type BookListDetailUserBook = {
  __typename?: 'BookListDetailUserBook';
  /** The authors of the book */
  authors: Array<Scalars['String']['output']>;
  /** The cover image URL of the book */
  coverImageUrl?: Maybe<Scalars['String']['output']>;
  /** The external ID of the book (Google Books or Rakuten) */
  externalId: Scalars['String']['output'];
  /** The unique identifier of the user book */
  id: Scalars['Int']['output'];
  /** The reading status of the book */
  readingStatus: Scalars['String']['output'];
  /** The source of the book (google or rakuten) */
  source: Scalars['String']['output'];
  /** The title of the book */
  title: Scalars['String']['output'];
};

/** Summary information about a book list */
export type BookListSummary = {
  __typename?: 'BookListSummary';
  /** The number of books in the list */
  bookCount: Scalars['Int']['output'];
  /** Cover images of books in the list (up to 4) */
  coverImages: Array<Scalars['String']['output']>;
  /** When the book list was created */
  createdAt: Scalars['DateTime']['output'];
  /** The description of the book list */
  description?: Maybe<Scalars['String']['output']>;
  /** The unique identifier of the book list */
  id: Scalars['Int']['output'];
  /** The title of the book list */
  title: Scalars['String']['output'];
  /** When the book list was last updated */
  updatedAt: Scalars['DateTime']['output'];
};

/** Source of the book data */
export enum BookSource {
  /** Google Books API */
  Google = 'GOOGLE',
  /** Rakuten Books API */
  Rakuten = 'RAKUTEN'
}

/** Input for password change */
export type ChangePasswordInput = {
  /** Current password */
  currentPassword: Scalars['String']['input'];
  /** User email address */
  email: Scalars['String']['input'];
  /** New password */
  newPassword: Scalars['String']['input'];
};

/** Result of successful password change */
export type ChangePasswordResult = {
  __typename?: 'ChangePasswordResult';
  /** New Firebase ID token */
  idToken: Scalars['String']['output'];
  /** New refresh token */
  refreshToken: Scalars['String']['output'];
};

/** Input for creating a new book list */
export type CreateBookListInput = {
  /** The description of the book list */
  description?: InputMaybe<Scalars['String']['input']>;
  /** The title of the book list */
  title: Scalars['String']['input'];
};

/** Result of account deletion */
export type DeleteAccountResult = {
  __typename?: 'DeleteAccountResult';
  /** Whether the account was deleted successfully */
  success?: Maybe<Scalars['Boolean']['output']>;
};

/** A device token for push notifications */
export type DeviceToken = {
  __typename?: 'DeviceToken';
  /** When the device token was registered */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /** The unique identifier of the device token */
  id?: Maybe<Scalars['Int']['output']>;
  /** The platform of the device (ios or android) */
  platform?: Maybe<Scalars['String']['output']>;
  /** The user who owns this device token */
  userId?: Maybe<Scalars['Int']['output']>;
};

export type FollowCounts = {
  __typename?: 'FollowCounts';
  followerCount?: Maybe<Scalars['Int']['output']>;
  followingCount?: Maybe<Scalars['Int']['output']>;
};

export type FollowRequest = {
  __typename?: 'FollowRequest';
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  id?: Maybe<Scalars['Int']['output']>;
  receiverId?: Maybe<Scalars['Int']['output']>;
  senderId?: Maybe<Scalars['Int']['output']>;
  status?: Maybe<FollowRequestStatus>;
};

export enum FollowRequestStatus {
  Approved = 'APPROVED',
  Pending = 'PENDING',
  Rejected = 'REJECTED'
}

export enum FollowStatus {
  FollowedBy = 'FOLLOWED_BY',
  Following = 'FOLLOWING',
  None = 'NONE',
  PendingReceived = 'PENDING_RECEIVED',
  PendingSent = 'PENDING_SENT'
}

/** 画像アップロードサービスのエラー */
export type ImageUploadError = {
  __typename?: 'ImageUploadError';
  /** エラーコード */
  code?: Maybe<Scalars['String']['output']>;
  /** エラーメッセージ */
  message?: Maybe<Scalars['String']['output']>;
};

/** Result containing list IDs that contain a specific user book */
export type ListIdsContainingUserBookResult = {
  __typename?: 'ListIdsContainingUserBookResult';
  /** List IDs containing the user book */
  listIds: Array<Scalars['Int']['output']>;
};

/** Result of successful login */
export type LoginResult = {
  __typename?: 'LoginResult';
  /** Firebase ID token for API authentication */
  idToken: Scalars['String']['output'];
  /** Firebase refresh token for obtaining new ID tokens */
  refreshToken: Scalars['String']['output'];
  /** Logged in user */
  user: User;
};

/** Input for user login */
export type LoginUserInput = {
  /** Email address */
  email: Scalars['String']['input'];
  /** Password */
  password: Scalars['String']['input'];
};

/** Result of me query - either User or AuthErrorResult */
export type MeResult = AuthErrorResult | User;

export type Mutation = {
  __typename?: 'Mutation';
  /** Add a book to a book list */
  addBookToList: BookListDetailItem;
  /** Add a book to the user's shelf */
  addBookToShelf: UserBook;
  approveFollowRequest?: Maybe<MutationApproveFollowRequestResult>;
  /** Cancel a pending follow request */
  cancelFollowRequest?: Maybe<MutationCancelFollowRequestResult>;
  /** Change user password after verifying current password */
  changePassword?: Maybe<MutationChangePasswordResult>;
  /** Create a new book list */
  createBookList: BookList;
  /** Delete the currently authenticated user's account */
  deleteAccount?: Maybe<MutationDeleteAccountResult>;
  /** Delete a book list */
  deleteBookList: Scalars['Boolean']['output'];
  /** Login with email and password */
  loginUser?: Maybe<MutationLoginUserResult>;
  markNotificationsAsRead?: Maybe<Scalars['Boolean']['output']>;
  /** Refresh ID token using refresh token */
  refreshToken?: Maybe<MutationRefreshTokenResult>;
  /** Register a device token for push notifications */
  registerDeviceToken?: Maybe<DeviceToken>;
  /** Register a new user with email and password */
  registerUser?: Maybe<MutationRegisterUserResult>;
  rejectFollowRequest?: Maybe<MutationRejectFollowRequestResult>;
  /** Remove a book from a book list */
  removeBookFromList: Scalars['Boolean']['output'];
  /** Remove a book from the user's shelf */
  removeFromShelf: Scalars['Boolean']['output'];
  /** Reorder a book within a book list */
  reorderBookInList: Scalars['Boolean']['output'];
  sendFollowRequest?: Maybe<MutationSendFollowRequestResult>;
  /** Send password reset email to the specified address */
  sendPasswordResetEmail?: Maybe<MutationSendPasswordResetEmailResult>;
  unfollow?: Maybe<MutationUnfollowResult>;
  /** Unregister a device token */
  unregisterDeviceToken?: Maybe<Scalars['Boolean']['output']>;
  /** Update an existing book list */
  updateBookList: BookList;
  /** Update the rating of a book in the user's shelf */
  updateBookRating: UserBook;
  /** Update the completion date of a book in the user's shelf */
  updateCompletedAt: UserBook;
  /** Update the current user's profile */
  updateProfile?: Maybe<MutationUpdateProfileResult>;
  /** Update the reading note of a book in the user's shelf */
  updateReadingNote: UserBook;
  /** Update the reading status of a book in the user's shelf */
  updateReadingStatus: UserBook;
  /** Update the start date of a book in the user's shelf */
  updateStartedAt: UserBook;
  /** Update the thoughts of a book in the user's shelf */
  updateThoughts: UserBook;
};


export type MutationAddBookToListArgs = {
  listId: Scalars['Int']['input'];
  userBookId: Scalars['Int']['input'];
};


export type MutationAddBookToShelfArgs = {
  bookInput: AddBookInput;
};


export type MutationApproveFollowRequestArgs = {
  requestId: Scalars['Int']['input'];
};


export type MutationCancelFollowRequestArgs = {
  targetUserId: Scalars['Int']['input'];
};


export type MutationChangePasswordArgs = {
  input: ChangePasswordInput;
};


export type MutationCreateBookListArgs = {
  input: CreateBookListInput;
};


export type MutationDeleteBookListArgs = {
  listId: Scalars['Int']['input'];
};


export type MutationLoginUserArgs = {
  input: LoginUserInput;
};


export type MutationRefreshTokenArgs = {
  input: RefreshTokenInput;
};


export type MutationRegisterDeviceTokenArgs = {
  input: RegisterDeviceTokenInput;
};


export type MutationRegisterUserArgs = {
  input: RegisterUserInput;
};


export type MutationRejectFollowRequestArgs = {
  requestId: Scalars['Int']['input'];
};


export type MutationRemoveBookFromListArgs = {
  listId: Scalars['Int']['input'];
  userBookId: Scalars['Int']['input'];
};


export type MutationRemoveFromShelfArgs = {
  userBookId: Scalars['Int']['input'];
};


export type MutationReorderBookInListArgs = {
  itemId: Scalars['Int']['input'];
  listId: Scalars['Int']['input'];
  newPosition: Scalars['Int']['input'];
};


export type MutationSendFollowRequestArgs = {
  receiverId: Scalars['Int']['input'];
};


export type MutationSendPasswordResetEmailArgs = {
  input: SendPasswordResetEmailInput;
};


export type MutationUnfollowArgs = {
  targetUserId: Scalars['Int']['input'];
};


export type MutationUnregisterDeviceTokenArgs = {
  input: UnregisterDeviceTokenInput;
};


export type MutationUpdateBookListArgs = {
  input: UpdateBookListInput;
};


export type MutationUpdateBookRatingArgs = {
  rating?: InputMaybe<Scalars['Int']['input']>;
  userBookId: Scalars['Int']['input'];
};


export type MutationUpdateCompletedAtArgs = {
  completedAt: Scalars['DateTime']['input'];
  userBookId: Scalars['Int']['input'];
};


export type MutationUpdateProfileArgs = {
  input: UpdateProfileInput;
};


export type MutationUpdateReadingNoteArgs = {
  note: Scalars['String']['input'];
  userBookId: Scalars['Int']['input'];
};


export type MutationUpdateReadingStatusArgs = {
  status: ReadingStatus;
  userBookId: Scalars['Int']['input'];
};


export type MutationUpdateStartedAtArgs = {
  startedAt: Scalars['DateTime']['input'];
  userBookId: Scalars['Int']['input'];
};


export type MutationUpdateThoughtsArgs = {
  thoughts: Scalars['String']['input'];
  userBookId: Scalars['Int']['input'];
};

export type MutationApproveFollowRequestResult = MutationApproveFollowRequestSuccess | ValidationError;

export type MutationApproveFollowRequestSuccess = {
  __typename?: 'MutationApproveFollowRequestSuccess';
  data: FollowRequest;
};

export type MutationCancelFollowRequestResult = MutationCancelFollowRequestSuccess | ValidationError;

export type MutationCancelFollowRequestSuccess = {
  __typename?: 'MutationCancelFollowRequestSuccess';
  data: Scalars['Boolean']['output'];
};

export type MutationChangePasswordResult = AuthError | MutationChangePasswordSuccess;

export type MutationChangePasswordSuccess = {
  __typename?: 'MutationChangePasswordSuccess';
  data: ChangePasswordResult;
};

export type MutationDeleteAccountResult = AuthError | MutationDeleteAccountSuccess;

export type MutationDeleteAccountSuccess = {
  __typename?: 'MutationDeleteAccountSuccess';
  data: DeleteAccountResult;
};

export type MutationLoginUserResult = AuthError | MutationLoginUserSuccess;

export type MutationLoginUserSuccess = {
  __typename?: 'MutationLoginUserSuccess';
  data: LoginResult;
};

export type MutationRefreshTokenResult = AuthError | MutationRefreshTokenSuccess;

export type MutationRefreshTokenSuccess = {
  __typename?: 'MutationRefreshTokenSuccess';
  data: RefreshTokenResult;
};

export type MutationRegisterUserResult = AuthError | MutationRegisterUserSuccess;

export type MutationRegisterUserSuccess = {
  __typename?: 'MutationRegisterUserSuccess';
  data: LoginResult;
};

export type MutationRejectFollowRequestResult = MutationRejectFollowRequestSuccess | ValidationError;

export type MutationRejectFollowRequestSuccess = {
  __typename?: 'MutationRejectFollowRequestSuccess';
  data: FollowRequest;
};

export type MutationSendFollowRequestResult = MutationSendFollowRequestSuccess | ValidationError;

export type MutationSendFollowRequestSuccess = {
  __typename?: 'MutationSendFollowRequestSuccess';
  data: FollowRequest;
};

export type MutationSendPasswordResetEmailResult = AuthError | MutationSendPasswordResetEmailSuccess;

export type MutationSendPasswordResetEmailSuccess = {
  __typename?: 'MutationSendPasswordResetEmailSuccess';
  data: SendPasswordResetEmailResult;
};

export type MutationUnfollowResult = MutationUnfollowSuccess | ValidationError;

export type MutationUnfollowSuccess = {
  __typename?: 'MutationUnfollowSuccess';
  data: Scalars['Boolean']['output'];
};

export type MutationUpdateProfileResult = MutationUpdateProfileSuccess | ValidationError;

export type MutationUpdateProfileSuccess = {
  __typename?: 'MutationUpdateProfileSuccess';
  data: User;
};

/** Input for querying user's book lists with pagination */
export type MyBookListsInput = {
  /** Number of items to return (default: 20) */
  limit?: InputMaybe<Scalars['Int']['input']>;
  /** Number of items to skip (default: 0) */
  offset?: InputMaybe<Scalars['Int']['input']>;
};

/** Result of user's book lists query with pagination info */
export type MyBookListsResult = {
  __typename?: 'MyBookListsResult';
  /** Whether there are more book lists to fetch */
  hasMore: Scalars['Boolean']['output'];
  /** List of book list summaries */
  items: Array<BookListSummary>;
  /** Total number of book lists */
  totalCount: Scalars['Int']['output'];
};

/** Input for querying user's book shelf */
export type MyShelfInput = {
  /** Number of items to return (default: 20) */
  limit?: InputMaybe<Scalars['Int']['input']>;
  /** Number of items to skip (default: 0) */
  offset?: InputMaybe<Scalars['Int']['input']>;
  /** Search query to filter books by title or author */
  query?: InputMaybe<Scalars['String']['input']>;
  /** Filter books by reading status */
  readingStatus?: InputMaybe<ReadingStatus>;
  /** Field to sort by */
  sortBy?: InputMaybe<ShelfSortField>;
  /** Sort order direction */
  sortOrder?: InputMaybe<SortOrder>;
};

/** Result of user's book shelf query */
export type MyShelfResult = {
  __typename?: 'MyShelfResult';
  /** Whether there are more books to fetch */
  hasMore: Scalars['Boolean']['output'];
  /** List of books in the shelf */
  items: Array<UserBook>;
  /** Total number of books matching the query */
  totalCount: Scalars['Int']['output'];
};

export enum NotificationType {
  FollowRequestApproved = 'FOLLOW_REQUEST_APPROVED',
  FollowRequestReceived = 'FOLLOW_REQUEST_RECEIVED'
}

export type Query = {
  __typename?: 'Query';
  /** Get detailed information about a book by ID */
  bookDetail: BookDetail;
  /** Get detailed information about a specific book list */
  bookListDetail: BookListDetail;
  followCounts?: Maybe<FollowCounts>;
  followers?: Maybe<Array<User>>;
  following?: Maybe<Array<User>>;
  /** 署名付きアップロードパラメータを取得 */
  getUploadCredentials?: Maybe<QueryGetUploadCredentialsResult>;
  health?: Maybe<Scalars['String']['output']>;
  /** Get list IDs that contain a specific user book */
  listIdsContainingUserBook: ListIdsContainingUserBookResult;
  /** Get the currently authenticated user */
  me: MeResult;
  /** Get all book lists created by the authenticated user */
  myBookLists: MyBookListsResult;
  /** Get books in the user's shelf with pagination, sorting, and search */
  myShelf: MyShelfResult;
  notifications: Array<AppNotification>;
  pendingFollowRequestCount?: Maybe<Scalars['Int']['output']>;
  pendingFollowRequests?: Maybe<Array<FollowRequest>>;
  /** Search for a book by ISBN */
  searchBookByISBN?: Maybe<Book>;
  /** Search for books by keyword (matches title, author, etc.) */
  searchBooks: SearchBooksResult;
  unreadNotificationCount: Scalars['Int']['output'];
  /** Get the user's reading record for a book by external ID */
  userBookByExternalId?: Maybe<UserBook>;
  /** Get book lists of another user (requires following) */
  userBookLists: MyBookListsResult;
  /** Find a user by their handle */
  userByHandle?: Maybe<User>;
  userProfile?: Maybe<UserProfile>;
  /** Get books in another user's shelf (requires following) */
  userShelf: MyShelfResult;
};


export type QueryBookDetailArgs = {
  bookId: Scalars['String']['input'];
  source: BookSource;
};


export type QueryBookListDetailArgs = {
  listId: Scalars['Int']['input'];
};


export type QueryFollowCountsArgs = {
  userId: Scalars['Int']['input'];
};


export type QueryFollowersArgs = {
  cursor?: InputMaybe<Scalars['Int']['input']>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  userId: Scalars['Int']['input'];
};


export type QueryFollowingArgs = {
  cursor?: InputMaybe<Scalars['Int']['input']>;
  limit?: InputMaybe<Scalars['Int']['input']>;
  userId: Scalars['Int']['input'];
};


export type QueryListIdsContainingUserBookArgs = {
  userBookId: Scalars['Int']['input'];
};


export type QueryMyBookListsArgs = {
  input?: InputMaybe<MyBookListsInput>;
};


export type QueryMyShelfArgs = {
  input?: InputMaybe<MyShelfInput>;
};


export type QueryNotificationsArgs = {
  cursor?: InputMaybe<Scalars['Int']['input']>;
  limit?: InputMaybe<Scalars['Int']['input']>;
};


export type QueryPendingFollowRequestsArgs = {
  cursor?: InputMaybe<Scalars['Int']['input']>;
  limit?: InputMaybe<Scalars['Int']['input']>;
};


export type QuerySearchBookByIsbnArgs = {
  isbn: Scalars['String']['input'];
};


export type QuerySearchBooksArgs = {
  limit?: InputMaybe<Scalars['Int']['input']>;
  offset?: InputMaybe<Scalars['Int']['input']>;
  query: Scalars['String']['input'];
};


export type QueryUserBookByExternalIdArgs = {
  externalId: Scalars['String']['input'];
};


export type QueryUserBookListsArgs = {
  input?: InputMaybe<MyBookListsInput>;
  userId: Scalars['Int']['input'];
};


export type QueryUserByHandleArgs = {
  handle: Scalars['String']['input'];
};


export type QueryUserProfileArgs = {
  handle: Scalars['String']['input'];
};


export type QueryUserShelfArgs = {
  input?: InputMaybe<MyShelfInput>;
  userId: Scalars['Int']['input'];
};

export type QueryGetUploadCredentialsResult = ImageUploadError | QueryGetUploadCredentialsSuccess;

export type QueryGetUploadCredentialsSuccess = {
  __typename?: 'QueryGetUploadCredentialsSuccess';
  data: UploadCredentials;
};

/** Reading status of a book in the user's shelf */
export enum ReadingStatus {
  /** Unread (backlog) */
  Backlog = 'BACKLOG',
  /** Finished reading */
  Completed = 'COMPLETED',
  /** @deprecated Use INTERESTED instead. DROP is ignored. */
  Drop = 'DROP',
  /** Interested in reading */
  Interested = 'INTERESTED',
  /** Currently reading */
  Reading = 'READING'
}

/** Input for token refresh */
export type RefreshTokenInput = {
  /** Refresh token */
  refreshToken: Scalars['String']['input'];
};

/** Result of successful token refresh */
export type RefreshTokenResult = {
  __typename?: 'RefreshTokenResult';
  /** New Firebase ID token */
  idToken: Scalars['String']['output'];
  /** New refresh token */
  refreshToken: Scalars['String']['output'];
};

/** Input for registering a device token */
export type RegisterDeviceTokenInput = {
  /** Device platform (ios or android) */
  platform: Scalars['String']['input'];
  /** FCM device token */
  token: Scalars['String']['input'];
};

/** Input for user registration */
export type RegisterUserInput = {
  /** Email address */
  email: Scalars['String']['input'];
  /** Password */
  password: Scalars['String']['input'];
};

/** Search results containing a list of books */
export type SearchBooksResult = {
  __typename?: 'SearchBooksResult';
  /** Whether there are more books to fetch */
  hasMore: Scalars['Boolean']['output'];
  /** The list of books found */
  items: Array<Book>;
  /** The total number of books found */
  totalCount: Scalars['Int']['output'];
};

/** Input for password reset email */
export type SendPasswordResetEmailInput = {
  /** Email address to send reset link */
  email: Scalars['String']['input'];
};

/** Result of password reset email request */
export type SendPasswordResetEmailResult = {
  __typename?: 'SendPasswordResetEmailResult';
  /** Whether the email was sent successfully */
  success?: Maybe<Scalars['Boolean']['output']>;
};

/** Sort field for books in shelf */
export enum ShelfSortField {
  /** Sort by date added to shelf */
  AddedAt = 'ADDED_AT',
  /** Sort by author name */
  Author = 'AUTHOR',
  /** Sort by completion date */
  CompletedAt = 'COMPLETED_AT',
  /** Sort by publication date */
  PublishedDate = 'PUBLISHED_DATE',
  /** Sort by rating */
  Rating = 'RATING',
  /** Sort by book title */
  Title = 'TITLE'
}

/** Sort order direction */
export enum SortOrder {
  /** Ascending order */
  Asc = 'ASC',
  /** Descending order */
  Desc = 'DESC'
}

/** Input for unregistering a device token */
export type UnregisterDeviceTokenInput = {
  /** FCM device token */
  token: Scalars['String']['input'];
};

/** Input for updating an existing book list */
export type UpdateBookListInput = {
  /** The new description of the book list */
  description?: InputMaybe<Scalars['String']['input']>;
  /** The ID of the book list to update */
  listId: Scalars['Int']['input'];
  /** The new title of the book list */
  title?: InputMaybe<Scalars['String']['input']>;
};

/** Input for updating user profile */
export type UpdateProfileInput = {
  /** User avatar image URL */
  avatarUrl?: InputMaybe<Scalars['String']['input']>;
  /** User bio text */
  bio?: InputMaybe<Scalars['String']['input']>;
  /** User unique handle */
  handle?: InputMaybe<Scalars['String']['input']>;
  /** User Instagram handle */
  instagramHandle?: InputMaybe<Scalars['String']['input']>;
  /** User display name */
  name: Scalars['String']['input'];
};

/** 署名付きアップロードパラメータ */
export type UploadCredentials = {
  __typename?: 'UploadCredentials';
  /** 有効期限（Unix timestamp） */
  expire?: Maybe<Scalars['Int']['output']>;
  /** ImageKit Public Key */
  publicKey?: Maybe<Scalars['String']['output']>;
  /** HMAC-SHA1署名 */
  signature?: Maybe<Scalars['String']['output']>;
  /** 一意のアップロードトークン */
  token?: Maybe<Scalars['String']['output']>;
  /** アップロードエンドポイントURL */
  uploadEndpoint?: Maybe<Scalars['String']['output']>;
};

/** A user in the system */
export type User = {
  __typename?: 'User';
  /** The URL of the user's avatar image (128x128) */
  avatarUrl?: Maybe<Scalars['String']['output']>;
  /** The user's bio */
  bio?: Maybe<Scalars['String']['output']>;
  /** The number of books in the user's shelf */
  bookCount: Scalars['Int']['output'];
  /** When the user was created */
  createdAt?: Maybe<Scalars['DateTime']['output']>;
  /** The email address of the user */
  email?: Maybe<Scalars['String']['output']>;
  /** The user's unique handle */
  handle?: Maybe<Scalars['String']['output']>;
  /** The unique identifier of the user */
  id?: Maybe<Scalars['Int']['output']>;
  /** The user's Instagram handle */
  instagramHandle?: Maybe<Scalars['String']['output']>;
  /** The display name of the user */
  name?: Maybe<Scalars['String']['output']>;
  /** When the user was last updated */
  updatedAt?: Maybe<Scalars['DateTime']['output']>;
};

/** A book in the user's shelf */
export type UserBook = {
  __typename?: 'UserBook';
  /** When the book was added to the shelf */
  addedAt: Scalars['DateTime']['output'];
  /** The authors of the book */
  authors: Array<Scalars['String']['output']>;
  /** When the book was marked as completed */
  completedAt?: Maybe<Scalars['DateTime']['output']>;
  /** The cover image URL of the book */
  coverImageUrl?: Maybe<Scalars['String']['output']>;
  /** The external ID of the book */
  externalId: Scalars['String']['output'];
  /** The unique identifier of the user book */
  id: Scalars['Int']['output'];
  /** The ISBN of the book */
  isbn?: Maybe<Scalars['String']['output']>;
  /** User's reading note for the book */
  note?: Maybe<Scalars['String']['output']>;
  /** When the note was last updated */
  noteUpdatedAt?: Maybe<Scalars['DateTime']['output']>;
  /** The publication date of the book */
  publishedDate?: Maybe<Scalars['String']['output']>;
  /** The publisher of the book */
  publisher?: Maybe<Scalars['String']['output']>;
  /** User's rating for the book (1-5) */
  rating?: Maybe<Scalars['Int']['output']>;
  /** The reading status of the book */
  readingStatus: ReadingStatus;
  /** The source of the book data (rakuten or google) */
  source: BookSource;
  /** When the book was started reading */
  startedAt?: Maybe<Scalars['DateTime']['output']>;
  /** User's thoughts/review for the book */
  thoughts?: Maybe<Scalars['String']['output']>;
  /** When the thoughts were last updated */
  thoughtsUpdatedAt?: Maybe<Scalars['DateTime']['output']>;
  /** The title of the book */
  title: Scalars['String']['output'];
};

export type UserProfile = {
  __typename?: 'UserProfile';
  followCounts?: Maybe<FollowCounts>;
  incomingFollowStatus?: Maybe<FollowStatus>;
  isOwnProfile?: Maybe<Scalars['Boolean']['output']>;
  outgoingFollowStatus?: Maybe<FollowStatus>;
  user?: Maybe<User>;
};

/** Validation error for user input */
export type ValidationError = {
  __typename?: 'ValidationError';
  /** Error code */
  code?: Maybe<Scalars['String']['output']>;
  /** Field that caused the error, if applicable */
  field?: Maybe<Scalars['String']['output']>;
  /** Human-readable error message */
  message?: Maybe<Scalars['String']['output']>;
};

export type UserProfilePage_UserFragment = { __typename?: 'User', name?: string | null, avatarUrl?: string | null, bio?: string | null, handle?: string | null } & { ' $fragmentName'?: 'UserProfilePage_UserFragment' };

export type UserByHandleQueryVariables = Exact<{
  handle: Scalars['String']['input'];
}>;


export type UserByHandleQuery = { __typename?: 'Query', userByHandle?: (
    { __typename?: 'User' }
    & { ' $fragmentRefs'?: { 'UserProfilePage_UserFragment': UserProfilePage_UserFragment } }
  ) | null };

export const UserProfilePage_UserFragmentDoc = {"kind":"Document","definitions":[{"kind":"FragmentDefinition","name":{"kind":"Name","value":"UserProfilePage_User"},"typeCondition":{"kind":"NamedType","name":{"kind":"Name","value":"User"}},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"name"}},{"kind":"Field","name":{"kind":"Name","value":"avatarUrl"}},{"kind":"Field","name":{"kind":"Name","value":"bio"}},{"kind":"Field","name":{"kind":"Name","value":"handle"}}]}}]} as unknown as DocumentNode<UserProfilePage_UserFragment, unknown>;
export const UserByHandleDocument = {"kind":"Document","definitions":[{"kind":"OperationDefinition","operation":"query","name":{"kind":"Name","value":"UserByHandle"},"variableDefinitions":[{"kind":"VariableDefinition","variable":{"kind":"Variable","name":{"kind":"Name","value":"handle"}},"type":{"kind":"NonNullType","type":{"kind":"NamedType","name":{"kind":"Name","value":"String"}}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"userByHandle"},"arguments":[{"kind":"Argument","name":{"kind":"Name","value":"handle"},"value":{"kind":"Variable","name":{"kind":"Name","value":"handle"}}}],"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"FragmentSpread","name":{"kind":"Name","value":"UserProfilePage_User"}}]}}]}},{"kind":"FragmentDefinition","name":{"kind":"Name","value":"UserProfilePage_User"},"typeCondition":{"kind":"NamedType","name":{"kind":"Name","value":"User"}},"selectionSet":{"kind":"SelectionSet","selections":[{"kind":"Field","name":{"kind":"Name","value":"name"}},{"kind":"Field","name":{"kind":"Name","value":"avatarUrl"}},{"kind":"Field","name":{"kind":"Name","value":"bio"}},{"kind":"Field","name":{"kind":"Name","value":"handle"}}]}}]} as unknown as DocumentNode<UserByHandleQuery, UserByHandleQueryVariables>;