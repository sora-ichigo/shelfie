// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart' show StandardJsonPlugin;
import 'package:ferry_exec/ferry_exec.dart';
import 'package:gql_code_builder_serializers/gql_code_builder_serializers.dart'
    show OperationSerializer;
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
        GLoginUserInput,
        GRefreshTokenInput,
        GRegisterUserInput;
import 'package:shelfie/core/graphql/custom_serializers.dart'
    show Iso8601DateTimeSerializer;
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
import 'package:shelfie/features/registration/data/__generated__/register_user.data.gql.dart'
    show
        GRegisterUserData_registerUser,
        GRegisterUserData,
        GRegisterUserData_registerUser__asAuthError,
        GRegisterUserData_registerUser__asMutationRegisterUserSuccess,
        GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data,
        GRegisterUserData_registerUser__base;
import 'package:shelfie/features/registration/data/__generated__/register_user.req.gql.dart'
    show GRegisterUserReq;
import 'package:shelfie/features/registration/data/__generated__/register_user.var.gql.dart'
    show GRegisterUserVars;

part 'serializers.gql.g.dart';

final SerializersBuilder _serializersBuilder = _$serializers.toBuilder()
  ..add(OperationSerializer())
  ..add(Iso8601DateTimeSerializer())
  ..add(GLoginUserData_loginUser.serializer)
  ..add(GRefreshTokenData_refreshToken.serializer)
  ..add(GRegisterUserData_registerUser.serializer)
  ..addPlugin(StandardJsonPlugin());
@SerializersFor([
  GAddBookInput,
  GAddBookToShelfData,
  GAddBookToShelfData_addBookToShelf,
  GAddBookToShelfReq,
  GAddBookToShelfVars,
  GAuthErrorCode,
  GLoginUserData,
  GLoginUserData_loginUser__asAuthError,
  GLoginUserData_loginUser__asMutationLoginUserSuccess,
  GLoginUserData_loginUser__asMutationLoginUserSuccess_data,
  GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user,
  GLoginUserData_loginUser__base,
  GLoginUserInput,
  GLoginUserReq,
  GLoginUserVars,
  GRefreshTokenData,
  GRefreshTokenData_refreshToken__asAuthError,
  GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess,
  GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data,
  GRefreshTokenData_refreshToken__base,
  GRefreshTokenInput,
  GRefreshTokenReq,
  GRefreshTokenVars,
  GRegisterUserData,
  GRegisterUserData_registerUser__asAuthError,
  GRegisterUserData_registerUser__asMutationRegisterUserSuccess,
  GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data,
  GRegisterUserData_registerUser__base,
  GRegisterUserInput,
  GRegisterUserReq,
  GRegisterUserVars,
  GSearchBookByISBNData,
  GSearchBookByISBNData_searchBookByISBN,
  GSearchBookByISBNReq,
  GSearchBookByISBNVars,
  GSearchBooksData,
  GSearchBooksData_searchBooks,
  GSearchBooksData_searchBooks_items,
  GSearchBooksReq,
  GSearchBooksVars,
])
final Serializers serializers = _serializersBuilder.build();
