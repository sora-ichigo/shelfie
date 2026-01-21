// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart' show StandardJsonPlugin;
import 'package:ferry_exec/ferry_exec.dart';
import 'package:gql_code_builder_serializers/gql_code_builder_serializers.dart'
    show OperationSerializer;
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    show GAuthErrorCode, GLoginUserInput, GRegisterUserInput;
import 'package:shelfie/core/graphql/custom_serializers.dart'
    show Iso8601DateTimeSerializer;
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
  ..add(GRegisterUserData_registerUser.serializer)
  ..addPlugin(StandardJsonPlugin());
@SerializersFor([
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
  GRegisterUserData,
  GRegisterUserData_registerUser__asAuthError,
  GRegisterUserData_registerUser__asMutationRegisterUserSuccess,
  GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data,
  GRegisterUserData_registerUser__base,
  GRegisterUserInput,
  GRegisterUserReq,
  GRegisterUserVars,
])
final Serializers serializers = _serializersBuilder.build();
