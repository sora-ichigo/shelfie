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
  GReadingStatus? get readingStatus;
  GBookSource? get source;
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

  static const GAuthErrorCode INVALID_EMAIL = _$gAuthErrorCodeINVALID_EMAIL;

  static const GAuthErrorCode INVALID_PASSWORD =
      _$gAuthErrorCodeINVALID_PASSWORD;

  static const GAuthErrorCode INVALID_TOKEN = _$gAuthErrorCodeINVALID_TOKEN;

  static const GAuthErrorCode NETWORK_ERROR = _$gAuthErrorCodeNETWORK_ERROR;

  static const GAuthErrorCode TOKEN_EXPIRED = _$gAuthErrorCodeTOKEN_EXPIRED;

  static const GAuthErrorCode UNAUTHENTICATED = _$gAuthErrorCodeUNAUTHENTICATED;

  static const GAuthErrorCode USER_NOT_FOUND = _$gAuthErrorCodeUSER_NOT_FOUND;

  static const GAuthErrorCode WEAK_PASSWORD = _$gAuthErrorCodeWEAK_PASSWORD;

  static Serializer<GAuthErrorCode> get serializer =>
      _$gAuthErrorCodeSerializer;

  static BuiltSet<GAuthErrorCode> get values => _$gAuthErrorCodeValues;

  static GAuthErrorCode valueOf(String name) => _$gAuthErrorCodeValueOf(name);
}

class GBookSource extends EnumClass {
  const GBookSource._(String name) : super(name);

  static const GBookSource GOOGLE = _$gBookSourceGOOGLE;

  static const GBookSource RAKUTEN = _$gBookSourceRAKUTEN;

  static Serializer<GBookSource> get serializer => _$gBookSourceSerializer;

  static BuiltSet<GBookSource> get values => _$gBookSourceValues;

  static GBookSource valueOf(String name) => _$gBookSourceValueOf(name);
}

abstract class GChangePasswordInput
    implements Built<GChangePasswordInput, GChangePasswordInputBuilder> {
  GChangePasswordInput._();

  factory GChangePasswordInput(
          [void Function(GChangePasswordInputBuilder b) updates]) =
      _$GChangePasswordInput;

  String get currentPassword;
  String get email;
  String get newPassword;
  static Serializer<GChangePasswordInput> get serializer =>
      _$gChangePasswordInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChangePasswordInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChangePasswordInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChangePasswordInput.serializer,
        json,
      );
}

abstract class GCreateBookListInput
    implements Built<GCreateBookListInput, GCreateBookListInputBuilder> {
  GCreateBookListInput._();

  factory GCreateBookListInput(
          [void Function(GCreateBookListInputBuilder b) updates]) =
      _$GCreateBookListInput;

  String? get description;
  String get title;
  static Serializer<GCreateBookListInput> get serializer =>
      _$gCreateBookListInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateBookListInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateBookListInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateBookListInput.serializer,
        json,
      );
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

abstract class GMyBookListsInput
    implements Built<GMyBookListsInput, GMyBookListsInputBuilder> {
  GMyBookListsInput._();

  factory GMyBookListsInput(
          [void Function(GMyBookListsInputBuilder b) updates]) =
      _$GMyBookListsInput;

  int? get limit;
  int? get offset;
  static Serializer<GMyBookListsInput> get serializer =>
      _$gMyBookListsInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyBookListsInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyBookListsInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyBookListsInput.serializer,
        json,
      );
}

abstract class GMyShelfInput
    implements Built<GMyShelfInput, GMyShelfInputBuilder> {
  GMyShelfInput._();

  factory GMyShelfInput([void Function(GMyShelfInputBuilder b) updates]) =
      _$GMyShelfInput;

  int? get limit;
  int? get offset;
  String? get query;
  GReadingStatus? get readingStatus;
  GShelfSortField? get sortBy;
  GSortOrder? get sortOrder;
  static Serializer<GMyShelfInput> get serializer => _$gMyShelfInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyShelfInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyShelfInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyShelfInput.serializer,
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

abstract class GSendPasswordResetEmailInput
    implements
        Built<GSendPasswordResetEmailInput,
            GSendPasswordResetEmailInputBuilder> {
  GSendPasswordResetEmailInput._();

  factory GSendPasswordResetEmailInput(
          [void Function(GSendPasswordResetEmailInputBuilder b) updates]) =
      _$GSendPasswordResetEmailInput;

  String get email;
  static Serializer<GSendPasswordResetEmailInput> get serializer =>
      _$gSendPasswordResetEmailInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendPasswordResetEmailInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendPasswordResetEmailInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSendPasswordResetEmailInput.serializer,
        json,
      );
}

class GShelfSortField extends EnumClass {
  const GShelfSortField._(String name) : super(name);

  static const GShelfSortField ADDED_AT = _$gShelfSortFieldADDED_AT;

  static const GShelfSortField AUTHOR = _$gShelfSortFieldAUTHOR;

  static const GShelfSortField TITLE = _$gShelfSortFieldTITLE;

  static Serializer<GShelfSortField> get serializer =>
      _$gShelfSortFieldSerializer;

  static BuiltSet<GShelfSortField> get values => _$gShelfSortFieldValues;

  static GShelfSortField valueOf(String name) => _$gShelfSortFieldValueOf(name);
}

class GSortOrder extends EnumClass {
  const GSortOrder._(String name) : super(name);

  static const GSortOrder ASC = _$gSortOrderASC;

  static const GSortOrder DESC = _$gSortOrderDESC;

  static Serializer<GSortOrder> get serializer => _$gSortOrderSerializer;

  static BuiltSet<GSortOrder> get values => _$gSortOrderValues;

  static GSortOrder valueOf(String name) => _$gSortOrderValueOf(name);
}

abstract class GUpdateBookListInput
    implements Built<GUpdateBookListInput, GUpdateBookListInputBuilder> {
  GUpdateBookListInput._();

  factory GUpdateBookListInput(
          [void Function(GUpdateBookListInputBuilder b) updates]) =
      _$GUpdateBookListInput;

  String? get description;
  int get listId;
  String? get title;
  static Serializer<GUpdateBookListInput> get serializer =>
      _$gUpdateBookListInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateBookListInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateBookListInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateBookListInput.serializer,
        json,
      );
}

abstract class GUpdateProfileInput
    implements Built<GUpdateProfileInput, GUpdateProfileInputBuilder> {
  GUpdateProfileInput._();

  factory GUpdateProfileInput(
          [void Function(GUpdateProfileInputBuilder b) updates]) =
      _$GUpdateProfileInput;

  String? get avatarUrl;
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
  'MutationChangePasswordResult': {
    'AuthError',
    'MutationChangePasswordSuccess',
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
  'MutationSendPasswordResetEmailResult': {
    'AuthError',
    'MutationSendPasswordResetEmailSuccess',
  },
  'MutationUpdateProfileResult': {
    'MutationUpdateProfileSuccess',
    'ValidationError',
  },
  'QueryGetUploadCredentialsResult': {
    'ImageUploadError',
    'QueryGetUploadCredentialsSuccess',
  },
};
