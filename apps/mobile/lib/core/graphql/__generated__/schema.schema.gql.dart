// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'schema.schema.gql.g.dart';

class GAuthErrorCode extends EnumClass {
  const GAuthErrorCode._(String name) : super(name);

  static const GAuthErrorCode EMAIL_ALREADY_EXISTS =
      _$gAuthErrorCodeEMAIL_ALREADY_EXISTS;

  static const GAuthErrorCode INTERNAL_ERROR = _$gAuthErrorCodeINTERNAL_ERROR;

  static const GAuthErrorCode INVALID_CREDENTIALS =
      _$gAuthErrorCodeINVALID_CREDENTIALS;

  static const GAuthErrorCode INVALID_PASSWORD =
      _$gAuthErrorCodeINVALID_PASSWORD;

  static const GAuthErrorCode INVALID_TOKEN = _$gAuthErrorCodeINVALID_TOKEN;

  static const GAuthErrorCode NETWORK_ERROR = _$gAuthErrorCodeNETWORK_ERROR;

  static const GAuthErrorCode TOKEN_EXPIRED = _$gAuthErrorCodeTOKEN_EXPIRED;

  static const GAuthErrorCode UNAUTHENTICATED = _$gAuthErrorCodeUNAUTHENTICATED;

  static const GAuthErrorCode USER_NOT_FOUND = _$gAuthErrorCodeUSER_NOT_FOUND;

  static Serializer<GAuthErrorCode> get serializer =>
      _$gAuthErrorCodeSerializer;

  static BuiltSet<GAuthErrorCode> get values => _$gAuthErrorCodeValues;

  static GAuthErrorCode valueOf(String name) => _$gAuthErrorCodeValueOf(name);
}

abstract class GLoginUserInput
    implements Built<GLoginUserInput, GLoginUserInputBuilder> {
  GLoginUserInput._();

  factory GLoginUserInput([void Function(GLoginUserInputBuilder b) updates]) =
      _$GLoginUserInput;

  String get email;
  String get password;
  static Serializer<GLoginUserInput> get serializer =>
      _$gLoginUserInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GLoginUserInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GLoginUserInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GLoginUserInput.serializer,
        json,
      );
}

abstract class GRegisterUserInput
    implements Built<GRegisterUserInput, GRegisterUserInputBuilder> {
  GRegisterUserInput._();

  factory GRegisterUserInput(
          [void Function(GRegisterUserInputBuilder b) updates]) =
      _$GRegisterUserInput;

  String get email;
  String get password;
  static Serializer<GRegisterUserInput> get serializer =>
      _$gRegisterUserInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRegisterUserInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRegisterUserInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRegisterUserInput.serializer,
        json,
      );
}

const Map<String, Set<String>> possibleTypesMap = {
  'MeResult': {
    'AuthErrorResult',
    'User',
  },
  'MutationLoginUserResult': {
    'AuthError',
    'MutationLoginUserSuccess',
  },
  'MutationRegisterUserResult': {
    'AuthError',
    'MutationRegisterUserSuccess',
  },
};
