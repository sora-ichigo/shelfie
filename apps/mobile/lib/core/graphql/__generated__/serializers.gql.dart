// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart' show StandardJsonPlugin;
import 'package:ferry_exec/ferry_exec.dart';
import 'package:gql_code_builder_serializers/gql_code_builder_serializers.dart'
    show OperationSerializer;
import 'package:shelfie/core/auth/__generated__/me.data.gql.dart'
    show
        GGetMeData_me,
        GGetMeData,
        GGetMeData_me__asAuthErrorResult,
        GGetMeData_me__asUser,
        GGetMeData_me__base;
import 'package:shelfie/core/auth/__generated__/me.req.gql.dart' show GGetMeReq;
import 'package:shelfie/core/auth/__generated__/me.var.gql.dart'
    show GGetMeVars;
import 'package:shelfie/core/auth/__generated__/refresh_token.data.gql.dart'
    show
        GRefreshTokenData_refreshToken,
        GRefreshTokenData,
        GRefreshTokenData_refreshToken__asAuthError,
        GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess,
        GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data,
        GRefreshTokenData_refreshToken__base;
import 'package:shelfie/core/auth/__generated__/refresh_token.req.gql.dart'
    show GRefreshTokenReq;
import 'package:shelfie/core/auth/__generated__/refresh_token.var.gql.dart'
    show GRefreshTokenVars;
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    show
        GAddBookInput,
        GAuthErrorCode,
        GBookSource,
        GChangePasswordInput,
        GCreateBookListInput,
        GLoginUserInput,
        GMyBookListsInput,
        GMyShelfInput,
        GReadingStatus,
        GRefreshTokenInput,
        GRegisterDeviceTokenInput,
        GRegisterUserInput,
        GSendPasswordResetEmailInput,
        GShelfSortField,
        GSortOrder,
        GUnregisterDeviceTokenInput,
        GUpdateBookListInput,
        GUpdateProfileInput;
import 'package:shelfie/core/graphql/custom_serializers.dart'
    show Iso8601DateTimeSerializer;
import 'package:shelfie/core/state/__generated__/my_shelf.data.gql.dart'
    show GMyShelfData, GMyShelfData_myShelf, GMyShelfData_myShelf_items;
import 'package:shelfie/core/state/__generated__/my_shelf.req.gql.dart'
    show GMyShelfReq;
import 'package:shelfie/core/state/__generated__/my_shelf.var.gql.dart'
    show GMyShelfVars;
import 'package:shelfie/features/account/data/__generated__/change_password.data.gql.dart'
    show
        GChangePasswordData_changePassword,
        GChangePasswordData,
        GChangePasswordData_changePassword__asAuthError,
        GChangePasswordData_changePassword__asMutationChangePasswordSuccess,
        GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data,
        GChangePasswordData_changePassword__base;
import 'package:shelfie/features/account/data/__generated__/change_password.req.gql.dart'
    show GChangePasswordReq;
import 'package:shelfie/features/account/data/__generated__/change_password.var.gql.dart'
    show GChangePasswordVars;
import 'package:shelfie/features/account/data/__generated__/delete_account.data.gql.dart'
    show
        GDeleteAccountData_deleteAccount,
        GDeleteAccountData,
        GDeleteAccountData_deleteAccount__asAuthError,
        GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess,
        GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data,
        GDeleteAccountData_deleteAccount__base;
import 'package:shelfie/features/account/data/__generated__/delete_account.req.gql.dart'
    show GDeleteAccountReq;
import 'package:shelfie/features/account/data/__generated__/delete_account.var.gql.dart'
    show GDeleteAccountVars;
import 'package:shelfie/features/account/data/__generated__/get_my_profile.data.gql.dart'
    show
        GGetMyProfileData_me,
        GGetMyProfileData,
        GGetMyProfileData_me__asAuthErrorResult,
        GGetMyProfileData_me__asUser,
        GGetMyProfileData_me__base;
import 'package:shelfie/features/account/data/__generated__/get_my_profile.req.gql.dart'
    show GGetMyProfileReq;
import 'package:shelfie/features/account/data/__generated__/get_my_profile.var.gql.dart'
    show GGetMyProfileVars;
import 'package:shelfie/features/account/data/__generated__/get_upload_credentials.data.gql.dart'
    show
        GGetUploadCredentialsData_getUploadCredentials,
        GGetUploadCredentialsData,
        GGetUploadCredentialsData_getUploadCredentials__asImageUploadError,
        GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess,
        GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data,
        GGetUploadCredentialsData_getUploadCredentials__base;
import 'package:shelfie/features/account/data/__generated__/get_upload_credentials.req.gql.dart'
    show GGetUploadCredentialsReq;
import 'package:shelfie/features/account/data/__generated__/get_upload_credentials.var.gql.dart'
    show GGetUploadCredentialsVars;
import 'package:shelfie/features/account/data/__generated__/send_password_reset_email.data.gql.dart'
    show
        GSendPasswordResetEmailData_sendPasswordResetEmail,
        GSendPasswordResetEmailData,
        GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError,
        GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess,
        GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data,
        GSendPasswordResetEmailData_sendPasswordResetEmail__base;
import 'package:shelfie/features/account/data/__generated__/send_password_reset_email.req.gql.dart'
    show GSendPasswordResetEmailReq;
import 'package:shelfie/features/account/data/__generated__/send_password_reset_email.var.gql.dart'
    show GSendPasswordResetEmailVars;
import 'package:shelfie/features/account/data/__generated__/update_profile.data.gql.dart'
    show
        GUpdateProfileData_updateProfile,
        GUpdateProfileData,
        GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess,
        GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data,
        GUpdateProfileData_updateProfile__asValidationError,
        GUpdateProfileData_updateProfile__base;
import 'package:shelfie/features/account/data/__generated__/update_profile.req.gql.dart'
    show GUpdateProfileReq;
import 'package:shelfie/features/account/data/__generated__/update_profile.var.gql.dart'
    show GUpdateProfileVars;
import 'package:shelfie/features/book_detail/data/__generated__/book_detail.data.gql.dart'
    show
        GBookDetailData,
        GBookDetailData_bookDetail,
        GBookDetailData_bookDetail_userBook;
import 'package:shelfie/features/book_detail/data/__generated__/book_detail.req.gql.dart'
    show GBookDetailReq;
import 'package:shelfie/features/book_detail/data/__generated__/book_detail.var.gql.dart'
    show GBookDetailVars;
import 'package:shelfie/features/book_detail/data/__generated__/remove_from_shelf.data.gql.dart'
    show GRemoveFromShelfData;
import 'package:shelfie/features/book_detail/data/__generated__/remove_from_shelf.req.gql.dart'
    show GRemoveFromShelfReq;
import 'package:shelfie/features/book_detail/data/__generated__/remove_from_shelf.var.gql.dart'
    show GRemoveFromShelfVars;
import 'package:shelfie/features/book_detail/data/__generated__/update_completed_at.data.gql.dart'
    show GUpdateCompletedAtData, GUpdateCompletedAtData_updateCompletedAt;
import 'package:shelfie/features/book_detail/data/__generated__/update_completed_at.req.gql.dart'
    show GUpdateCompletedAtReq;
import 'package:shelfie/features/book_detail/data/__generated__/update_completed_at.var.gql.dart'
    show GUpdateCompletedAtVars;
import 'package:shelfie/features/book_detail/data/__generated__/update_rating.data.gql.dart'
    show GUpdateBookRatingData, GUpdateBookRatingData_updateBookRating;
import 'package:shelfie/features/book_detail/data/__generated__/update_rating.req.gql.dart'
    show GUpdateBookRatingReq;
import 'package:shelfie/features/book_detail/data/__generated__/update_rating.var.gql.dart'
    show GUpdateBookRatingVars;
import 'package:shelfie/features/book_detail/data/__generated__/update_reading_note.data.gql.dart'
    show GUpdateReadingNoteData, GUpdateReadingNoteData_updateReadingNote;
import 'package:shelfie/features/book_detail/data/__generated__/update_reading_note.req.gql.dart'
    show GUpdateReadingNoteReq;
import 'package:shelfie/features/book_detail/data/__generated__/update_reading_note.var.gql.dart'
    show GUpdateReadingNoteVars;
import 'package:shelfie/features/book_detail/data/__generated__/update_reading_status.data.gql.dart'
    show GUpdateReadingStatusData, GUpdateReadingStatusData_updateReadingStatus;
import 'package:shelfie/features/book_detail/data/__generated__/update_reading_status.req.gql.dart'
    show GUpdateReadingStatusReq;
import 'package:shelfie/features/book_detail/data/__generated__/update_reading_status.var.gql.dart'
    show GUpdateReadingStatusVars;
import 'package:shelfie/features/book_detail/data/__generated__/update_started_at.data.gql.dart'
    show GUpdateStartedAtData, GUpdateStartedAtData_updateStartedAt;
import 'package:shelfie/features/book_detail/data/__generated__/update_started_at.req.gql.dart'
    show GUpdateStartedAtReq;
import 'package:shelfie/features/book_detail/data/__generated__/update_started_at.var.gql.dart'
    show GUpdateStartedAtVars;
import 'package:shelfie/features/book_list/data/__generated__/add_book_to_list.data.gql.dart'
    show
        GAddBookToListData,
        GAddBookToListData_addBookToList,
        GAddBookToListData_addBookToList_userBook;
import 'package:shelfie/features/book_list/data/__generated__/add_book_to_list.req.gql.dart'
    show GAddBookToListReq;
import 'package:shelfie/features/book_list/data/__generated__/add_book_to_list.var.gql.dart'
    show GAddBookToListVars;
import 'package:shelfie/features/book_list/data/__generated__/book_list_detail.data.gql.dart'
    show
        GBookListDetailData,
        GBookListDetailData_bookListDetail,
        GBookListDetailData_bookListDetail_items,
        GBookListDetailData_bookListDetail_items_userBook,
        GBookListDetailData_bookListDetail_stats;
import 'package:shelfie/features/book_list/data/__generated__/book_list_detail.req.gql.dart'
    show GBookListDetailReq;
import 'package:shelfie/features/book_list/data/__generated__/book_list_detail.var.gql.dart'
    show GBookListDetailVars;
import 'package:shelfie/features/book_list/data/__generated__/create_book_list.data.gql.dart'
    show GCreateBookListData, GCreateBookListData_createBookList;
import 'package:shelfie/features/book_list/data/__generated__/create_book_list.req.gql.dart'
    show GCreateBookListReq;
import 'package:shelfie/features/book_list/data/__generated__/create_book_list.var.gql.dart'
    show GCreateBookListVars;
import 'package:shelfie/features/book_list/data/__generated__/delete_book_list.data.gql.dart'
    show GDeleteBookListData;
import 'package:shelfie/features/book_list/data/__generated__/delete_book_list.req.gql.dart'
    show GDeleteBookListReq;
import 'package:shelfie/features/book_list/data/__generated__/delete_book_list.var.gql.dart'
    show GDeleteBookListVars;
import 'package:shelfie/features/book_list/data/__generated__/my_book_lists.data.gql.dart'
    show
        GMyBookListsData,
        GMyBookListsData_myBookLists,
        GMyBookListsData_myBookLists_items;
import 'package:shelfie/features/book_list/data/__generated__/my_book_lists.req.gql.dart'
    show GMyBookListsReq;
import 'package:shelfie/features/book_list/data/__generated__/my_book_lists.var.gql.dart'
    show GMyBookListsVars;
import 'package:shelfie/features/book_list/data/__generated__/remove_book_from_list.data.gql.dart'
    show GRemoveBookFromListData;
import 'package:shelfie/features/book_list/data/__generated__/remove_book_from_list.req.gql.dart'
    show GRemoveBookFromListReq;
import 'package:shelfie/features/book_list/data/__generated__/remove_book_from_list.var.gql.dart'
    show GRemoveBookFromListVars;
import 'package:shelfie/features/book_list/data/__generated__/reorder_book_in_list.data.gql.dart'
    show GReorderBookInListData;
import 'package:shelfie/features/book_list/data/__generated__/reorder_book_in_list.req.gql.dart'
    show GReorderBookInListReq;
import 'package:shelfie/features/book_list/data/__generated__/reorder_book_in_list.var.gql.dart'
    show GReorderBookInListVars;
import 'package:shelfie/features/book_list/data/__generated__/update_book_list.data.gql.dart'
    show GUpdateBookListData, GUpdateBookListData_updateBookList;
import 'package:shelfie/features/book_list/data/__generated__/update_book_list.req.gql.dart'
    show GUpdateBookListReq;
import 'package:shelfie/features/book_list/data/__generated__/update_book_list.var.gql.dart'
    show GUpdateBookListVars;
import 'package:shelfie/features/book_search/data/__generated__/add_book_to_shelf.data.gql.dart'
    show GAddBookToShelfData, GAddBookToShelfData_addBookToShelf;
import 'package:shelfie/features/book_search/data/__generated__/add_book_to_shelf.req.gql.dart'
    show GAddBookToShelfReq;
import 'package:shelfie/features/book_search/data/__generated__/add_book_to_shelf.var.gql.dart'
    show GAddBookToShelfVars;
import 'package:shelfie/features/book_search/data/__generated__/search_book_by_isbn.data.gql.dart'
    show GSearchBookByISBNData, GSearchBookByISBNData_searchBookByISBN;
import 'package:shelfie/features/book_search/data/__generated__/search_book_by_isbn.req.gql.dart'
    show GSearchBookByISBNReq;
import 'package:shelfie/features/book_search/data/__generated__/search_book_by_isbn.var.gql.dart'
    show GSearchBookByISBNVars;
import 'package:shelfie/features/book_search/data/__generated__/search_books.data.gql.dart'
    show
        GSearchBooksData,
        GSearchBooksData_searchBooks,
        GSearchBooksData_searchBooks_items;
import 'package:shelfie/features/book_search/data/__generated__/search_books.req.gql.dart'
    show GSearchBooksReq;
import 'package:shelfie/features/book_search/data/__generated__/search_books.var.gql.dart'
    show GSearchBooksVars;
import 'package:shelfie/features/book_shelf/data/__generated__/my_shelf_paginated.data.gql.dart'
    show
        GMyShelfPaginatedData,
        GMyShelfPaginatedData_myShelf,
        GMyShelfPaginatedData_myShelf_items;
import 'package:shelfie/features/book_shelf/data/__generated__/my_shelf_paginated.req.gql.dart'
    show GMyShelfPaginatedReq;
import 'package:shelfie/features/book_shelf/data/__generated__/my_shelf_paginated.var.gql.dart'
    show GMyShelfPaginatedVars;
import 'package:shelfie/features/login/data/__generated__/login_user.data.gql.dart'
    show
        GLoginUserData_loginUser,
        GLoginUserData,
        GLoginUserData_loginUser__asAuthError,
        GLoginUserData_loginUser__asMutationLoginUserSuccess,
        GLoginUserData_loginUser__asMutationLoginUserSuccess_data,
        GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user,
        GLoginUserData_loginUser__base;
import 'package:shelfie/features/login/data/__generated__/login_user.req.gql.dart'
    show GLoginUserReq;
import 'package:shelfie/features/login/data/__generated__/login_user.var.gql.dart'
    show GLoginUserVars;
import 'package:shelfie/features/push_notification/data/__generated__/register_device_token.data.gql.dart'
    show GRegisterDeviceTokenData, GRegisterDeviceTokenData_registerDeviceToken;
import 'package:shelfie/features/push_notification/data/__generated__/register_device_token.req.gql.dart'
    show GRegisterDeviceTokenReq;
import 'package:shelfie/features/push_notification/data/__generated__/register_device_token.var.gql.dart'
    show GRegisterDeviceTokenVars;
import 'package:shelfie/features/push_notification/data/__generated__/unregister_device_token.data.gql.dart'
    show GUnregisterDeviceTokenData;
import 'package:shelfie/features/push_notification/data/__generated__/unregister_device_token.req.gql.dart'
    show GUnregisterDeviceTokenReq;
import 'package:shelfie/features/push_notification/data/__generated__/unregister_device_token.var.gql.dart'
    show GUnregisterDeviceTokenVars;
import 'package:shelfie/features/registration/data/__generated__/register_user.data.gql.dart'
    show
        GRegisterUserData_registerUser,
        GRegisterUserData,
        GRegisterUserData_registerUser__asAuthError,
        GRegisterUserData_registerUser__asMutationRegisterUserSuccess,
        GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data,
        GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user,
        GRegisterUserData_registerUser__base;
import 'package:shelfie/features/registration/data/__generated__/register_user.req.gql.dart'
    show GRegisterUserReq;
import 'package:shelfie/features/registration/data/__generated__/register_user.var.gql.dart'
    show GRegisterUserVars;

part 'serializers.gql.g.dart';

final SerializersBuilder _serializersBuilder = _$serializers.toBuilder()
  ..add(OperationSerializer())
  ..add(Iso8601DateTimeSerializer())
  ..add(GChangePasswordData_changePassword.serializer)
  ..add(GDeleteAccountData_deleteAccount.serializer)
  ..add(GGetMeData_me.serializer)
  ..add(GGetMyProfileData_me.serializer)
  ..add(GGetUploadCredentialsData_getUploadCredentials.serializer)
  ..add(GLoginUserData_loginUser.serializer)
  ..add(GRefreshTokenData_refreshToken.serializer)
  ..add(GRegisterUserData_registerUser.serializer)
  ..add(GSendPasswordResetEmailData_sendPasswordResetEmail.serializer)
  ..add(GUpdateProfileData_updateProfile.serializer)
  ..addPlugin(StandardJsonPlugin());
@SerializersFor([
  GAddBookInput,
  GAddBookToListData,
  GAddBookToListData_addBookToList,
  GAddBookToListData_addBookToList_userBook,
  GAddBookToListReq,
  GAddBookToListVars,
  GAddBookToShelfData,
  GAddBookToShelfData_addBookToShelf,
  GAddBookToShelfReq,
  GAddBookToShelfVars,
  GAuthErrorCode,
  GBookDetailData,
  GBookDetailData_bookDetail,
  GBookDetailData_bookDetail_userBook,
  GBookDetailReq,
  GBookDetailVars,
  GBookListDetailData,
  GBookListDetailData_bookListDetail,
  GBookListDetailData_bookListDetail_items,
  GBookListDetailData_bookListDetail_items_userBook,
  GBookListDetailData_bookListDetail_stats,
  GBookListDetailReq,
  GBookListDetailVars,
  GBookSource,
  GChangePasswordData,
  GChangePasswordData_changePassword__asAuthError,
  GChangePasswordData_changePassword__asMutationChangePasswordSuccess,
  GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data,
  GChangePasswordData_changePassword__base,
  GChangePasswordInput,
  GChangePasswordReq,
  GChangePasswordVars,
  GCreateBookListData,
  GCreateBookListData_createBookList,
  GCreateBookListInput,
  GCreateBookListReq,
  GCreateBookListVars,
  GDeleteAccountData,
  GDeleteAccountData_deleteAccount__asAuthError,
  GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess,
  GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data,
  GDeleteAccountData_deleteAccount__base,
  GDeleteAccountReq,
  GDeleteAccountVars,
  GDeleteBookListData,
  GDeleteBookListReq,
  GDeleteBookListVars,
  GGetMeData,
  GGetMeData_me__asAuthErrorResult,
  GGetMeData_me__asUser,
  GGetMeData_me__base,
  GGetMeReq,
  GGetMeVars,
  GGetMyProfileData,
  GGetMyProfileData_me__asAuthErrorResult,
  GGetMyProfileData_me__asUser,
  GGetMyProfileData_me__base,
  GGetMyProfileReq,
  GGetMyProfileVars,
  GGetUploadCredentialsData,
  GGetUploadCredentialsData_getUploadCredentials__asImageUploadError,
  GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess,
  GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data,
  GGetUploadCredentialsData_getUploadCredentials__base,
  GGetUploadCredentialsReq,
  GGetUploadCredentialsVars,
  GLoginUserData,
  GLoginUserData_loginUser__asAuthError,
  GLoginUserData_loginUser__asMutationLoginUserSuccess,
  GLoginUserData_loginUser__asMutationLoginUserSuccess_data,
  GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user,
  GLoginUserData_loginUser__base,
  GLoginUserInput,
  GLoginUserReq,
  GLoginUserVars,
  GMyBookListsData,
  GMyBookListsData_myBookLists,
  GMyBookListsData_myBookLists_items,
  GMyBookListsInput,
  GMyBookListsReq,
  GMyBookListsVars,
  GMyShelfData,
  GMyShelfData_myShelf,
  GMyShelfData_myShelf_items,
  GMyShelfInput,
  GMyShelfPaginatedData,
  GMyShelfPaginatedData_myShelf,
  GMyShelfPaginatedData_myShelf_items,
  GMyShelfPaginatedReq,
  GMyShelfPaginatedVars,
  GMyShelfReq,
  GMyShelfVars,
  GReadingStatus,
  GRefreshTokenData,
  GRefreshTokenData_refreshToken__asAuthError,
  GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess,
  GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data,
  GRefreshTokenData_refreshToken__base,
  GRefreshTokenInput,
  GRefreshTokenReq,
  GRefreshTokenVars,
  GRegisterDeviceTokenData,
  GRegisterDeviceTokenData_registerDeviceToken,
  GRegisterDeviceTokenInput,
  GRegisterDeviceTokenReq,
  GRegisterDeviceTokenVars,
  GRegisterUserData,
  GRegisterUserData_registerUser__asAuthError,
  GRegisterUserData_registerUser__asMutationRegisterUserSuccess,
  GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data,
  GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user,
  GRegisterUserData_registerUser__base,
  GRegisterUserInput,
  GRegisterUserReq,
  GRegisterUserVars,
  GRemoveBookFromListData,
  GRemoveBookFromListReq,
  GRemoveBookFromListVars,
  GRemoveFromShelfData,
  GRemoveFromShelfReq,
  GRemoveFromShelfVars,
  GReorderBookInListData,
  GReorderBookInListReq,
  GReorderBookInListVars,
  GSearchBookByISBNData,
  GSearchBookByISBNData_searchBookByISBN,
  GSearchBookByISBNReq,
  GSearchBookByISBNVars,
  GSearchBooksData,
  GSearchBooksData_searchBooks,
  GSearchBooksData_searchBooks_items,
  GSearchBooksReq,
  GSearchBooksVars,
  GSendPasswordResetEmailData,
  GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError,
  GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess,
  GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data,
  GSendPasswordResetEmailData_sendPasswordResetEmail__base,
  GSendPasswordResetEmailInput,
  GSendPasswordResetEmailReq,
  GSendPasswordResetEmailVars,
  GShelfSortField,
  GSortOrder,
  GUnregisterDeviceTokenData,
  GUnregisterDeviceTokenInput,
  GUnregisterDeviceTokenReq,
  GUnregisterDeviceTokenVars,
  GUpdateBookListData,
  GUpdateBookListData_updateBookList,
  GUpdateBookListInput,
  GUpdateBookListReq,
  GUpdateBookListVars,
  GUpdateBookRatingData,
  GUpdateBookRatingData_updateBookRating,
  GUpdateBookRatingReq,
  GUpdateBookRatingVars,
  GUpdateCompletedAtData,
  GUpdateCompletedAtData_updateCompletedAt,
  GUpdateCompletedAtReq,
  GUpdateCompletedAtVars,
  GUpdateProfileData,
  GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess,
  GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data,
  GUpdateProfileData_updateProfile__asValidationError,
  GUpdateProfileData_updateProfile__base,
  GUpdateProfileInput,
  GUpdateProfileReq,
  GUpdateProfileVars,
  GUpdateReadingNoteData,
  GUpdateReadingNoteData_updateReadingNote,
  GUpdateReadingNoteReq,
  GUpdateReadingNoteVars,
  GUpdateReadingStatusData,
  GUpdateReadingStatusData_updateReadingStatus,
  GUpdateReadingStatusReq,
  GUpdateReadingStatusVars,
  GUpdateStartedAtData,
  GUpdateStartedAtData_updateStartedAt,
  GUpdateStartedAtReq,
  GUpdateStartedAtVars,
])
final Serializers serializers = _serializersBuilder.build();
