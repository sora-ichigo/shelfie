// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (new Serializers().toBuilder()
      ..add(FetchPolicy.serializer)
      ..add(GAddBookInput.serializer)
      ..add(GAddBookToShelfData.serializer)
      ..add(GAddBookToShelfData_addBookToShelf.serializer)
      ..add(GAddBookToShelfReq.serializer)
      ..add(GAddBookToShelfVars.serializer)
      ..add(GAuthErrorCode.serializer)
      ..add(GBookDetailData.serializer)
      ..add(GBookDetailData_bookDetail.serializer)
      ..add(GBookDetailData_bookDetail_userBook.serializer)
      ..add(GBookDetailReq.serializer)
      ..add(GBookDetailVars.serializer)
      ..add(GGetMeData.serializer)
      ..add(GGetMeData_me__asAuthErrorResult.serializer)
      ..add(GGetMeData_me__asUser.serializer)
      ..add(GGetMeData_me__base.serializer)
      ..add(GGetMeReq.serializer)
      ..add(GGetMeVars.serializer)
      ..add(GGetMyProfileData.serializer)
      ..add(GGetMyProfileData_me__asAuthErrorResult.serializer)
      ..add(GGetMyProfileData_me__asUser.serializer)
      ..add(GGetMyProfileData_me__base.serializer)
      ..add(GGetMyProfileReq.serializer)
      ..add(GGetMyProfileVars.serializer)
      ..add(GLoginUserData.serializer)
      ..add(GLoginUserData_loginUser__asAuthError.serializer)
      ..add(GLoginUserData_loginUser__asMutationLoginUserSuccess.serializer)
      ..add(
          GLoginUserData_loginUser__asMutationLoginUserSuccess_data.serializer)
      ..add(GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user
          .serializer)
      ..add(GLoginUserData_loginUser__base.serializer)
      ..add(GLoginUserInput.serializer)
      ..add(GLoginUserReq.serializer)
      ..add(GLoginUserVars.serializer)
      ..add(GMyShelfData.serializer)
      ..add(GMyShelfData_myShelf.serializer)
      ..add(GMyShelfData_myShelf_items.serializer)
      ..add(GMyShelfInput.serializer)
      ..add(GMyShelfPaginatedData.serializer)
      ..add(GMyShelfPaginatedData_myShelf.serializer)
      ..add(GMyShelfPaginatedData_myShelf_items.serializer)
      ..add(GMyShelfPaginatedReq.serializer)
      ..add(GMyShelfPaginatedVars.serializer)
      ..add(GMyShelfReq.serializer)
      ..add(GMyShelfVars.serializer)
      ..add(GReadingStatus.serializer)
      ..add(GRefreshTokenData.serializer)
      ..add(GRefreshTokenData_refreshToken__asAuthError.serializer)
      ..add(GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess
          .serializer)
      ..add(GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data
          .serializer)
      ..add(GRefreshTokenData_refreshToken__base.serializer)
      ..add(GRefreshTokenInput.serializer)
      ..add(GRefreshTokenReq.serializer)
      ..add(GRefreshTokenVars.serializer)
      ..add(GRegisterUserData.serializer)
      ..add(GRegisterUserData_registerUser__asAuthError.serializer)
      ..add(GRegisterUserData_registerUser__asMutationRegisterUserSuccess
          .serializer)
      ..add(GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data
          .serializer)
      ..add(GRegisterUserData_registerUser__base.serializer)
      ..add(GRegisterUserInput.serializer)
      ..add(GRegisterUserReq.serializer)
      ..add(GRegisterUserVars.serializer)
      ..add(GRemoveFromShelfData.serializer)
      ..add(GRemoveFromShelfReq.serializer)
      ..add(GRemoveFromShelfVars.serializer)
      ..add(GSearchBookByISBNData.serializer)
      ..add(GSearchBookByISBNData_searchBookByISBN.serializer)
      ..add(GSearchBookByISBNReq.serializer)
      ..add(GSearchBookByISBNVars.serializer)
      ..add(GSearchBooksData.serializer)
      ..add(GSearchBooksData_searchBooks.serializer)
      ..add(GSearchBooksData_searchBooks_items.serializer)
      ..add(GSearchBooksReq.serializer)
      ..add(GSearchBooksVars.serializer)
      ..add(GShelfSortField.serializer)
      ..add(GSortOrder.serializer)
      ..add(GUpdateProfileData.serializer)
      ..add(GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess
          .serializer)
      ..add(
          GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data
              .serializer)
      ..add(GUpdateProfileData_updateProfile__asValidationError.serializer)
      ..add(GUpdateProfileData_updateProfile__base.serializer)
      ..add(GUpdateProfileInput.serializer)
      ..add(GUpdateProfileReq.serializer)
      ..add(GUpdateProfileVars.serializer)
      ..add(GUpdateReadingNoteData.serializer)
      ..add(GUpdateReadingNoteData_updateReadingNote.serializer)
      ..add(GUpdateReadingNoteReq.serializer)
      ..add(GUpdateReadingNoteVars.serializer)
      ..add(GUpdateReadingStatusData.serializer)
      ..add(GUpdateReadingStatusData_updateReadingStatus.serializer)
      ..add(GUpdateReadingStatusReq.serializer)
      ..add(GUpdateReadingStatusVars.serializer)
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GMyShelfData_myShelf_items)]),
          () => new ListBuilder<GMyShelfData_myShelf_items>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GMyShelfPaginatedData_myShelf_items)]),
          () => new ListBuilder<GMyShelfPaginatedData_myShelf_items>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GSearchBooksData_searchBooks_items)]),
          () => new ListBuilder<GSearchBooksData_searchBooks_items>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>()))
    .build();

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
