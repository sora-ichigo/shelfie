// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart' show StandardJsonPlugin;
import 'package:ferry_exec/ferry_exec.dart';
import 'package:gql_code_builder_serializers/gql_code_builder_serializers.dart'
    show OperationSerializer;
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart'
    show GAuthErrorCode, GRegisterUserInput;
import 'package:shelfie/core/graphql/custom_serializers.dart'
    show Iso8601DateTimeSerializer;
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
  ..add(GRegisterUserData_registerUser.serializer)
  ..addPlugin(StandardJsonPlugin());
@SerializersFor([
  GAuthErrorCode,
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
