// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:shelfie/core/graphql/__generated__/serializers.gql.dart' as _i1;

part 'schema.schema.gql.g.dart';

abstract class GAddBookInput
    implements Built<GAddBookInput, GAddBookInputBuilder> {
  GAddBookInput._();

  factory GAddBookInput([void Function(GAddBookInputBuilder b) updates]) =
      _$GAddBookInput;

  BuiltList<String> get authors;
  String? get coverImageUrl;
  String get externalId;
  String? get isbn;
  String? get publishedDate;
  String? get publisher;
  String get title;
  static Serializer<GAddBookInput> get serializer => _$gAddBookInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAddBookInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAddBookInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAddBookInput.serializer,
        json,
      );
}

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

class GReadingStatus extends EnumClass {
  const GReadingStatus._(String name) : super(name);

  static const GReadingStatus BACKLOG = _$gReadingStatusBACKLOG;

  static const GReadingStatus COMPLETED = _$gReadingStatusCOMPLETED;

  static const GReadingStatus DROPPED = _$gReadingStatusDROPPED;

  static const GReadingStatus READING = _$gReadingStatusREADING;

  static Serializer<GReadingStatus> get serializer =>
      _$gReadingStatusSerializer;

  static BuiltSet<GReadingStatus> get values => _$gReadingStatusValues;

  static GReadingStatus valueOf(String name) => _$gReadingStatusValueOf(name);
}

abstract class GRefreshTokenInput
    implements Built<GRefreshTokenInput, GRefreshTokenInputBuilder> {
  GRefreshTokenInput._();

  factory GRefreshTokenInput(
          [void Function(GRefreshTokenInputBuilder b) updates]) =
      _$GRefreshTokenInput;

  String get refreshToken;
  static Serializer<GRefreshTokenInput> get serializer =>
      _$gRefreshTokenInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRefreshTokenInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRefreshTokenInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRefreshTokenInput.serializer,
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

abstract class GUpdateProfileInput
    implements Built<GUpdateProfileInput, GUpdateProfileInputBuilder> {
  GUpdateProfileInput._();

  factory GUpdateProfileInput(
          [void Function(GUpdateProfileInputBuilder b) updates]) =
      _$GUpdateProfileInput;

  String get name;
  static Serializer<GUpdateProfileInput> get serializer =>
      _$gUpdateProfileInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateProfileInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateProfileInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateProfileInput.serializer,
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
  'MutationRefreshTokenResult': {
    'AuthError',
    'MutationRefreshTokenSuccess',
  },
  'MutationRegisterUserResult': {
    'AuthError',
    'MutationRegisterUserSuccess',
  },
  'MutationUpdateProfileResult': {
    'MutationUpdateProfileSuccess',
    'ValidationError',
  },
};
