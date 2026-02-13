// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema.schema.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GAuthErrorCode _$gAuthErrorCodeEMAIL_ALREADY_EXISTS =
    const GAuthErrorCode._('EMAIL_ALREADY_EXISTS');
const GAuthErrorCode _$gAuthErrorCodeINTERNAL_ERROR =
    const GAuthErrorCode._('INTERNAL_ERROR');
const GAuthErrorCode _$gAuthErrorCodeINVALID_CREDENTIALS =
    const GAuthErrorCode._('INVALID_CREDENTIALS');
const GAuthErrorCode _$gAuthErrorCodeINVALID_EMAIL =
    const GAuthErrorCode._('INVALID_EMAIL');
const GAuthErrorCode _$gAuthErrorCodeINVALID_PASSWORD =
    const GAuthErrorCode._('INVALID_PASSWORD');
const GAuthErrorCode _$gAuthErrorCodeINVALID_TOKEN =
    const GAuthErrorCode._('INVALID_TOKEN');
const GAuthErrorCode _$gAuthErrorCodeNETWORK_ERROR =
    const GAuthErrorCode._('NETWORK_ERROR');
const GAuthErrorCode _$gAuthErrorCodeTOKEN_EXPIRED =
    const GAuthErrorCode._('TOKEN_EXPIRED');
const GAuthErrorCode _$gAuthErrorCodeUNAUTHENTICATED =
    const GAuthErrorCode._('UNAUTHENTICATED');
const GAuthErrorCode _$gAuthErrorCodeUSER_NOT_FOUND =
    const GAuthErrorCode._('USER_NOT_FOUND');
const GAuthErrorCode _$gAuthErrorCodeWEAK_PASSWORD =
    const GAuthErrorCode._('WEAK_PASSWORD');

GAuthErrorCode _$gAuthErrorCodeValueOf(String name) {
  switch (name) {
    case 'EMAIL_ALREADY_EXISTS':
      return _$gAuthErrorCodeEMAIL_ALREADY_EXISTS;
    case 'INTERNAL_ERROR':
      return _$gAuthErrorCodeINTERNAL_ERROR;
    case 'INVALID_CREDENTIALS':
      return _$gAuthErrorCodeINVALID_CREDENTIALS;
    case 'INVALID_EMAIL':
      return _$gAuthErrorCodeINVALID_EMAIL;
    case 'INVALID_PASSWORD':
      return _$gAuthErrorCodeINVALID_PASSWORD;
    case 'INVALID_TOKEN':
      return _$gAuthErrorCodeINVALID_TOKEN;
    case 'NETWORK_ERROR':
      return _$gAuthErrorCodeNETWORK_ERROR;
    case 'TOKEN_EXPIRED':
      return _$gAuthErrorCodeTOKEN_EXPIRED;
    case 'UNAUTHENTICATED':
      return _$gAuthErrorCodeUNAUTHENTICATED;
    case 'USER_NOT_FOUND':
      return _$gAuthErrorCodeUSER_NOT_FOUND;
    case 'WEAK_PASSWORD':
      return _$gAuthErrorCodeWEAK_PASSWORD;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GAuthErrorCode> _$gAuthErrorCodeValues =
    BuiltSet<GAuthErrorCode>(const <GAuthErrorCode>[
  _$gAuthErrorCodeEMAIL_ALREADY_EXISTS,
  _$gAuthErrorCodeINTERNAL_ERROR,
  _$gAuthErrorCodeINVALID_CREDENTIALS,
  _$gAuthErrorCodeINVALID_EMAIL,
  _$gAuthErrorCodeINVALID_PASSWORD,
  _$gAuthErrorCodeINVALID_TOKEN,
  _$gAuthErrorCodeNETWORK_ERROR,
  _$gAuthErrorCodeTOKEN_EXPIRED,
  _$gAuthErrorCodeUNAUTHENTICATED,
  _$gAuthErrorCodeUSER_NOT_FOUND,
  _$gAuthErrorCodeWEAK_PASSWORD,
]);

const GBookSource _$gBookSourceGOOGLE = const GBookSource._('GOOGLE');
const GBookSource _$gBookSourceRAKUTEN = const GBookSource._('RAKUTEN');

GBookSource _$gBookSourceValueOf(String name) {
  switch (name) {
    case 'GOOGLE':
      return _$gBookSourceGOOGLE;
    case 'RAKUTEN':
      return _$gBookSourceRAKUTEN;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GBookSource> _$gBookSourceValues =
    BuiltSet<GBookSource>(const <GBookSource>[
  _$gBookSourceGOOGLE,
  _$gBookSourceRAKUTEN,
]);

const GFollowRequestStatus _$gFollowRequestStatusAPPROVED =
    const GFollowRequestStatus._('APPROVED');
const GFollowRequestStatus _$gFollowRequestStatusPENDING =
    const GFollowRequestStatus._('PENDING');
const GFollowRequestStatus _$gFollowRequestStatusREJECTED =
    const GFollowRequestStatus._('REJECTED');

GFollowRequestStatus _$gFollowRequestStatusValueOf(String name) {
  switch (name) {
    case 'APPROVED':
      return _$gFollowRequestStatusAPPROVED;
    case 'PENDING':
      return _$gFollowRequestStatusPENDING;
    case 'REJECTED':
      return _$gFollowRequestStatusREJECTED;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GFollowRequestStatus> _$gFollowRequestStatusValues =
    BuiltSet<GFollowRequestStatus>(const <GFollowRequestStatus>[
  _$gFollowRequestStatusAPPROVED,
  _$gFollowRequestStatusPENDING,
  _$gFollowRequestStatusREJECTED,
]);

const GFollowStatus _$gFollowStatusFOLLOWING =
    const GFollowStatus._('FOLLOWING');
const GFollowStatus _$gFollowStatusNONE = const GFollowStatus._('NONE');
const GFollowStatus _$gFollowStatusPENDING = const GFollowStatus._('PENDING');
const GFollowStatus _$gFollowStatusPENDING_RECEIVED =
    const GFollowStatus._('PENDING_RECEIVED');
const GFollowStatus _$gFollowStatusPENDING_SENT =
    const GFollowStatus._('PENDING_SENT');

GFollowStatus _$gFollowStatusValueOf(String name) {
  switch (name) {
    case 'FOLLOWING':
      return _$gFollowStatusFOLLOWING;
    case 'NONE':
      return _$gFollowStatusNONE;
    case 'PENDING':
      return _$gFollowStatusPENDING;
    case 'PENDING_RECEIVED':
      return _$gFollowStatusPENDING_RECEIVED;
    case 'PENDING_SENT':
      return _$gFollowStatusPENDING_SENT;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GFollowStatus> _$gFollowStatusValues =
    BuiltSet<GFollowStatus>(const <GFollowStatus>[
  _$gFollowStatusFOLLOWING,
  _$gFollowStatusNONE,
  _$gFollowStatusPENDING,
  _$gFollowStatusPENDING_RECEIVED,
  _$gFollowStatusPENDING_SENT,
]);

const GNotificationType _$gNotificationTypeFOLLOW_REQUEST_APPROVED =
    const GNotificationType._('FOLLOW_REQUEST_APPROVED');
const GNotificationType _$gNotificationTypeFOLLOW_REQUEST_RECEIVED =
    const GNotificationType._('FOLLOW_REQUEST_RECEIVED');

GNotificationType _$gNotificationTypeValueOf(String name) {
  switch (name) {
    case 'FOLLOW_REQUEST_APPROVED':
      return _$gNotificationTypeFOLLOW_REQUEST_APPROVED;
    case 'FOLLOW_REQUEST_RECEIVED':
      return _$gNotificationTypeFOLLOW_REQUEST_RECEIVED;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GNotificationType> _$gNotificationTypeValues =
    BuiltSet<GNotificationType>(const <GNotificationType>[
  _$gNotificationTypeFOLLOW_REQUEST_APPROVED,
  _$gNotificationTypeFOLLOW_REQUEST_RECEIVED,
]);

const GReadingStatus _$gReadingStatusBACKLOG =
    const GReadingStatus._('BACKLOG');
const GReadingStatus _$gReadingStatusCOMPLETED =
    const GReadingStatus._('COMPLETED');
const GReadingStatus _$gReadingStatusDROP = const GReadingStatus._('DROP');
const GReadingStatus _$gReadingStatusINTERESTED =
    const GReadingStatus._('INTERESTED');
const GReadingStatus _$gReadingStatusREADING =
    const GReadingStatus._('READING');

GReadingStatus _$gReadingStatusValueOf(String name) {
  switch (name) {
    case 'BACKLOG':
      return _$gReadingStatusBACKLOG;
    case 'COMPLETED':
      return _$gReadingStatusCOMPLETED;
    case 'DROP':
      return _$gReadingStatusDROP;
    case 'INTERESTED':
      return _$gReadingStatusINTERESTED;
    case 'READING':
      return _$gReadingStatusREADING;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GReadingStatus> _$gReadingStatusValues =
    BuiltSet<GReadingStatus>(const <GReadingStatus>[
  _$gReadingStatusBACKLOG,
  _$gReadingStatusCOMPLETED,
  _$gReadingStatusDROP,
  _$gReadingStatusINTERESTED,
  _$gReadingStatusREADING,
]);

const GShelfSortField _$gShelfSortFieldADDED_AT =
    const GShelfSortField._('ADDED_AT');
const GShelfSortField _$gShelfSortFieldAUTHOR =
    const GShelfSortField._('AUTHOR');
const GShelfSortField _$gShelfSortFieldCOMPLETED_AT =
    const GShelfSortField._('COMPLETED_AT');
const GShelfSortField _$gShelfSortFieldPUBLISHED_DATE =
    const GShelfSortField._('PUBLISHED_DATE');
const GShelfSortField _$gShelfSortFieldRATING =
    const GShelfSortField._('RATING');
const GShelfSortField _$gShelfSortFieldTITLE = const GShelfSortField._('TITLE');

GShelfSortField _$gShelfSortFieldValueOf(String name) {
  switch (name) {
    case 'ADDED_AT':
      return _$gShelfSortFieldADDED_AT;
    case 'AUTHOR':
      return _$gShelfSortFieldAUTHOR;
    case 'COMPLETED_AT':
      return _$gShelfSortFieldCOMPLETED_AT;
    case 'PUBLISHED_DATE':
      return _$gShelfSortFieldPUBLISHED_DATE;
    case 'RATING':
      return _$gShelfSortFieldRATING;
    case 'TITLE':
      return _$gShelfSortFieldTITLE;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GShelfSortField> _$gShelfSortFieldValues =
    BuiltSet<GShelfSortField>(const <GShelfSortField>[
  _$gShelfSortFieldADDED_AT,
  _$gShelfSortFieldAUTHOR,
  _$gShelfSortFieldCOMPLETED_AT,
  _$gShelfSortFieldPUBLISHED_DATE,
  _$gShelfSortFieldRATING,
  _$gShelfSortFieldTITLE,
]);

const GSortOrder _$gSortOrderASC = const GSortOrder._('ASC');
const GSortOrder _$gSortOrderDESC = const GSortOrder._('DESC');

GSortOrder _$gSortOrderValueOf(String name) {
  switch (name) {
    case 'ASC':
      return _$gSortOrderASC;
    case 'DESC':
      return _$gSortOrderDESC;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GSortOrder> _$gSortOrderValues =
    BuiltSet<GSortOrder>(const <GSortOrder>[
  _$gSortOrderASC,
  _$gSortOrderDESC,
]);

Serializer<GAddBookInput> _$gAddBookInputSerializer =
    _$GAddBookInputSerializer();
Serializer<GAuthErrorCode> _$gAuthErrorCodeSerializer =
    _$GAuthErrorCodeSerializer();
Serializer<GBookSource> _$gBookSourceSerializer = _$GBookSourceSerializer();
Serializer<GChangePasswordInput> _$gChangePasswordInputSerializer =
    _$GChangePasswordInputSerializer();
Serializer<GCreateBookListInput> _$gCreateBookListInputSerializer =
    _$GCreateBookListInputSerializer();
Serializer<GFollowRequestStatus> _$gFollowRequestStatusSerializer =
    _$GFollowRequestStatusSerializer();
Serializer<GFollowStatus> _$gFollowStatusSerializer =
    _$GFollowStatusSerializer();
Serializer<GLoginUserInput> _$gLoginUserInputSerializer =
    _$GLoginUserInputSerializer();
Serializer<GNotificationType> _$gNotificationTypeSerializer =
    _$GNotificationTypeSerializer();
Serializer<GMyBookListsInput> _$gMyBookListsInputSerializer =
    _$GMyBookListsInputSerializer();
Serializer<GMyShelfInput> _$gMyShelfInputSerializer =
    _$GMyShelfInputSerializer();
Serializer<GReadingStatus> _$gReadingStatusSerializer =
    _$GReadingStatusSerializer();
Serializer<GRefreshTokenInput> _$gRefreshTokenInputSerializer =
    _$GRefreshTokenInputSerializer();
Serializer<GRegisterDeviceTokenInput> _$gRegisterDeviceTokenInputSerializer =
    _$GRegisterDeviceTokenInputSerializer();
Serializer<GRegisterUserInput> _$gRegisterUserInputSerializer =
    _$GRegisterUserInputSerializer();
Serializer<GSendPasswordResetEmailInput>
    _$gSendPasswordResetEmailInputSerializer =
    _$GSendPasswordResetEmailInputSerializer();
Serializer<GShelfSortField> _$gShelfSortFieldSerializer =
    _$GShelfSortFieldSerializer();
Serializer<GSortOrder> _$gSortOrderSerializer = _$GSortOrderSerializer();
Serializer<GUnregisterDeviceTokenInput>
    _$gUnregisterDeviceTokenInputSerializer =
    _$GUnregisterDeviceTokenInputSerializer();
Serializer<GUpdateBookListInput> _$gUpdateBookListInputSerializer =
    _$GUpdateBookListInputSerializer();
Serializer<GUpdateProfileInput> _$gUpdateProfileInputSerializer =
    _$GUpdateProfileInputSerializer();

class _$GAddBookInputSerializer implements StructuredSerializer<GAddBookInput> {
  @override
  final Iterable<Type> types = const [GAddBookInput, _$GAddBookInput];
  @override
  final String wireName = 'GAddBookInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, GAddBookInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'authors',
      serializers.serialize(object.authors,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'externalId',
      serializers.serialize(object.externalId,
          specifiedType: const FullType(String)),
      'source',
      serializers.serialize(object.source,
          specifiedType: const FullType(GBookSource)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.coverImageUrl;
    if (value != null) {
      result
        ..add('coverImageUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.isbn;
    if (value != null) {
      result
        ..add('isbn')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.publishedDate;
    if (value != null) {
      result
        ..add('publishedDate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.publisher;
    if (value != null) {
      result
        ..add('publisher')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.readingStatus;
    if (value != null) {
      result
        ..add('readingStatus')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GReadingStatus)));
    }
    return result;
  }

  @override
  GAddBookInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GAddBookInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'authors':
          result.authors.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'coverImageUrl':
          result.coverImageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'externalId':
          result.externalId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'isbn':
          result.isbn = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'publishedDate':
          result.publishedDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'publisher':
          result.publisher = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'readingStatus':
          result.readingStatus = serializers.deserialize(value,
              specifiedType: const FullType(GReadingStatus)) as GReadingStatus?;
          break;
        case 'source':
          result.source = serializers.deserialize(value,
              specifiedType: const FullType(GBookSource))! as GBookSource;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GAuthErrorCodeSerializer
    implements PrimitiveSerializer<GAuthErrorCode> {
  @override
  final Iterable<Type> types = const <Type>[GAuthErrorCode];
  @override
  final String wireName = 'GAuthErrorCode';

  @override
  Object serialize(Serializers serializers, GAuthErrorCode object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GAuthErrorCode deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GAuthErrorCode.valueOf(serialized as String);
}

class _$GBookSourceSerializer implements PrimitiveSerializer<GBookSource> {
  @override
  final Iterable<Type> types = const <Type>[GBookSource];
  @override
  final String wireName = 'GBookSource';

  @override
  Object serialize(Serializers serializers, GBookSource object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GBookSource deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GBookSource.valueOf(serialized as String);
}

class _$GChangePasswordInputSerializer
    implements StructuredSerializer<GChangePasswordInput> {
  @override
  final Iterable<Type> types = const [
    GChangePasswordInput,
    _$GChangePasswordInput
  ];
  @override
  final String wireName = 'GChangePasswordInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GChangePasswordInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'currentPassword',
      serializers.serialize(object.currentPassword,
          specifiedType: const FullType(String)),
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'newPassword',
      serializers.serialize(object.newPassword,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GChangePasswordInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GChangePasswordInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'currentPassword':
          result.currentPassword = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'newPassword':
          result.newPassword = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateBookListInputSerializer
    implements StructuredSerializer<GCreateBookListInput> {
  @override
  final Iterable<Type> types = const [
    GCreateBookListInput,
    _$GCreateBookListInput
  ];
  @override
  final String wireName = 'GCreateBookListInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateBookListInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GCreateBookListInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GCreateBookListInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GFollowRequestStatusSerializer
    implements PrimitiveSerializer<GFollowRequestStatus> {
  @override
  final Iterable<Type> types = const <Type>[GFollowRequestStatus];
  @override
  final String wireName = 'GFollowRequestStatus';

  @override
  Object serialize(Serializers serializers, GFollowRequestStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GFollowRequestStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GFollowRequestStatus.valueOf(serialized as String);
}

class _$GFollowStatusSerializer implements PrimitiveSerializer<GFollowStatus> {
  @override
  final Iterable<Type> types = const <Type>[GFollowStatus];
  @override
  final String wireName = 'GFollowStatus';

  @override
  Object serialize(Serializers serializers, GFollowStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GFollowStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GFollowStatus.valueOf(serialized as String);
}

class _$GLoginUserInputSerializer
    implements StructuredSerializer<GLoginUserInput> {
  @override
  final Iterable<Type> types = const [GLoginUserInput, _$GLoginUserInput];
  @override
  final String wireName = 'GLoginUserInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, GLoginUserInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'password',
      serializers.serialize(object.password,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GLoginUserInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GLoginUserInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GNotificationTypeSerializer
    implements PrimitiveSerializer<GNotificationType> {
  @override
  final Iterable<Type> types = const <Type>[GNotificationType];
  @override
  final String wireName = 'GNotificationType';

  @override
  Object serialize(Serializers serializers, GNotificationType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GNotificationType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GNotificationType.valueOf(serialized as String);
}

class _$GMyBookListsInputSerializer
    implements StructuredSerializer<GMyBookListsInput> {
  @override
  final Iterable<Type> types = const [GMyBookListsInput, _$GMyBookListsInput];
  @override
  final String wireName = 'GMyBookListsInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, GMyBookListsInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.limit;
    if (value != null) {
      result
        ..add('limit')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.offset;
    if (value != null) {
      result
        ..add('offset')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  GMyBookListsInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMyBookListsInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'limit':
          result.limit = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'offset':
          result.offset = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$GMyShelfInputSerializer implements StructuredSerializer<GMyShelfInput> {
  @override
  final Iterable<Type> types = const [GMyShelfInput, _$GMyShelfInput];
  @override
  final String wireName = 'GMyShelfInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, GMyShelfInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.limit;
    if (value != null) {
      result
        ..add('limit')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.offset;
    if (value != null) {
      result
        ..add('offset')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.query;
    if (value != null) {
      result
        ..add('query')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.readingStatus;
    if (value != null) {
      result
        ..add('readingStatus')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GReadingStatus)));
    }
    value = object.sortBy;
    if (value != null) {
      result
        ..add('sortBy')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GShelfSortField)));
    }
    value = object.sortOrder;
    if (value != null) {
      result
        ..add('sortOrder')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GSortOrder)));
    }
    return result;
  }

  @override
  GMyShelfInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMyShelfInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'limit':
          result.limit = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'offset':
          result.offset = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'query':
          result.query = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'readingStatus':
          result.readingStatus = serializers.deserialize(value,
              specifiedType: const FullType(GReadingStatus)) as GReadingStatus?;
          break;
        case 'sortBy':
          result.sortBy = serializers.deserialize(value,
                  specifiedType: const FullType(GShelfSortField))
              as GShelfSortField?;
          break;
        case 'sortOrder':
          result.sortOrder = serializers.deserialize(value,
              specifiedType: const FullType(GSortOrder)) as GSortOrder?;
          break;
      }
    }

    return result.build();
  }
}

class _$GReadingStatusSerializer
    implements PrimitiveSerializer<GReadingStatus> {
  @override
  final Iterable<Type> types = const <Type>[GReadingStatus];
  @override
  final String wireName = 'GReadingStatus';

  @override
  Object serialize(Serializers serializers, GReadingStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GReadingStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GReadingStatus.valueOf(serialized as String);
}

class _$GRefreshTokenInputSerializer
    implements StructuredSerializer<GRefreshTokenInput> {
  @override
  final Iterable<Type> types = const [GRefreshTokenInput, _$GRefreshTokenInput];
  @override
  final String wireName = 'GRefreshTokenInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GRefreshTokenInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'refreshToken',
      serializers.serialize(object.refreshToken,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GRefreshTokenInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GRefreshTokenInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'refreshToken':
          result.refreshToken = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GRegisterDeviceTokenInputSerializer
    implements StructuredSerializer<GRegisterDeviceTokenInput> {
  @override
  final Iterable<Type> types = const [
    GRegisterDeviceTokenInput,
    _$GRegisterDeviceTokenInput
  ];
  @override
  final String wireName = 'GRegisterDeviceTokenInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GRegisterDeviceTokenInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'platform',
      serializers.serialize(object.platform,
          specifiedType: const FullType(String)),
      'token',
      serializers.serialize(object.token,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GRegisterDeviceTokenInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GRegisterDeviceTokenInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'platform':
          result.platform = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'token':
          result.token = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GRegisterUserInputSerializer
    implements StructuredSerializer<GRegisterUserInput> {
  @override
  final Iterable<Type> types = const [GRegisterUserInput, _$GRegisterUserInput];
  @override
  final String wireName = 'GRegisterUserInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GRegisterUserInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'password',
      serializers.serialize(object.password,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GRegisterUserInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GRegisterUserInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GSendPasswordResetEmailInputSerializer
    implements StructuredSerializer<GSendPasswordResetEmailInput> {
  @override
  final Iterable<Type> types = const [
    GSendPasswordResetEmailInput,
    _$GSendPasswordResetEmailInput
  ];
  @override
  final String wireName = 'GSendPasswordResetEmailInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSendPasswordResetEmailInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GSendPasswordResetEmailInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GSendPasswordResetEmailInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GShelfSortFieldSerializer
    implements PrimitiveSerializer<GShelfSortField> {
  @override
  final Iterable<Type> types = const <Type>[GShelfSortField];
  @override
  final String wireName = 'GShelfSortField';

  @override
  Object serialize(Serializers serializers, GShelfSortField object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GShelfSortField deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GShelfSortField.valueOf(serialized as String);
}

class _$GSortOrderSerializer implements PrimitiveSerializer<GSortOrder> {
  @override
  final Iterable<Type> types = const <Type>[GSortOrder];
  @override
  final String wireName = 'GSortOrder';

  @override
  Object serialize(Serializers serializers, GSortOrder object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GSortOrder deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GSortOrder.valueOf(serialized as String);
}

class _$GUnregisterDeviceTokenInputSerializer
    implements StructuredSerializer<GUnregisterDeviceTokenInput> {
  @override
  final Iterable<Type> types = const [
    GUnregisterDeviceTokenInput,
    _$GUnregisterDeviceTokenInput
  ];
  @override
  final String wireName = 'GUnregisterDeviceTokenInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUnregisterDeviceTokenInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'token',
      serializers.serialize(object.token,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GUnregisterDeviceTokenInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUnregisterDeviceTokenInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'token':
          result.token = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateBookListInputSerializer
    implements StructuredSerializer<GUpdateBookListInput> {
  @override
  final Iterable<Type> types = const [
    GUpdateBookListInput,
    _$GUpdateBookListInput
  ];
  @override
  final String wireName = 'GUpdateBookListInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateBookListInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'listId',
      serializers.serialize(object.listId, specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.title;
    if (value != null) {
      result
        ..add('title')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GUpdateBookListInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUpdateBookListInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'listId':
          result.listId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateProfileInputSerializer
    implements StructuredSerializer<GUpdateProfileInput> {
  @override
  final Iterable<Type> types = const [
    GUpdateProfileInput,
    _$GUpdateProfileInput
  ];
  @override
  final String wireName = 'GUpdateProfileInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateProfileInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.avatarUrl;
    if (value != null) {
      result
        ..add('avatarUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.bio;
    if (value != null) {
      result
        ..add('bio')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.handle;
    if (value != null) {
      result
        ..add('handle')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.instagramHandle;
    if (value != null) {
      result
        ..add('instagramHandle')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GUpdateProfileInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUpdateProfileInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'avatarUrl':
          result.avatarUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'bio':
          result.bio = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'handle':
          result.handle = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'instagramHandle':
          result.instagramHandle = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GAddBookInput extends GAddBookInput {
  @override
  final BuiltList<String> authors;
  @override
  final String? coverImageUrl;
  @override
  final String externalId;
  @override
  final String? isbn;
  @override
  final String? publishedDate;
  @override
  final String? publisher;
  @override
  final GReadingStatus? readingStatus;
  @override
  final GBookSource source;
  @override
  final String title;

  factory _$GAddBookInput([void Function(GAddBookInputBuilder)? updates]) =>
      (GAddBookInputBuilder()..update(updates))._build();

  _$GAddBookInput._(
      {required this.authors,
      this.coverImageUrl,
      required this.externalId,
      this.isbn,
      this.publishedDate,
      this.publisher,
      this.readingStatus,
      required this.source,
      required this.title})
      : super._();
  @override
  GAddBookInput rebuild(void Function(GAddBookInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAddBookInputBuilder toBuilder() => GAddBookInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAddBookInput &&
        authors == other.authors &&
        coverImageUrl == other.coverImageUrl &&
        externalId == other.externalId &&
        isbn == other.isbn &&
        publishedDate == other.publishedDate &&
        publisher == other.publisher &&
        readingStatus == other.readingStatus &&
        source == other.source &&
        title == other.title;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, authors.hashCode);
    _$hash = $jc(_$hash, coverImageUrl.hashCode);
    _$hash = $jc(_$hash, externalId.hashCode);
    _$hash = $jc(_$hash, isbn.hashCode);
    _$hash = $jc(_$hash, publishedDate.hashCode);
    _$hash = $jc(_$hash, publisher.hashCode);
    _$hash = $jc(_$hash, readingStatus.hashCode);
    _$hash = $jc(_$hash, source.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAddBookInput')
          ..add('authors', authors)
          ..add('coverImageUrl', coverImageUrl)
          ..add('externalId', externalId)
          ..add('isbn', isbn)
          ..add('publishedDate', publishedDate)
          ..add('publisher', publisher)
          ..add('readingStatus', readingStatus)
          ..add('source', source)
          ..add('title', title))
        .toString();
  }
}

class GAddBookInputBuilder
    implements Builder<GAddBookInput, GAddBookInputBuilder> {
  _$GAddBookInput? _$v;

  ListBuilder<String>? _authors;
  ListBuilder<String> get authors => _$this._authors ??= ListBuilder<String>();
  set authors(ListBuilder<String>? authors) => _$this._authors = authors;

  String? _coverImageUrl;
  String? get coverImageUrl => _$this._coverImageUrl;
  set coverImageUrl(String? coverImageUrl) =>
      _$this._coverImageUrl = coverImageUrl;

  String? _externalId;
  String? get externalId => _$this._externalId;
  set externalId(String? externalId) => _$this._externalId = externalId;

  String? _isbn;
  String? get isbn => _$this._isbn;
  set isbn(String? isbn) => _$this._isbn = isbn;

  String? _publishedDate;
  String? get publishedDate => _$this._publishedDate;
  set publishedDate(String? publishedDate) =>
      _$this._publishedDate = publishedDate;

  String? _publisher;
  String? get publisher => _$this._publisher;
  set publisher(String? publisher) => _$this._publisher = publisher;

  GReadingStatus? _readingStatus;
  GReadingStatus? get readingStatus => _$this._readingStatus;
  set readingStatus(GReadingStatus? readingStatus) =>
      _$this._readingStatus = readingStatus;

  GBookSource? _source;
  GBookSource? get source => _$this._source;
  set source(GBookSource? source) => _$this._source = source;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  GAddBookInputBuilder();

  GAddBookInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _authors = $v.authors.toBuilder();
      _coverImageUrl = $v.coverImageUrl;
      _externalId = $v.externalId;
      _isbn = $v.isbn;
      _publishedDate = $v.publishedDate;
      _publisher = $v.publisher;
      _readingStatus = $v.readingStatus;
      _source = $v.source;
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAddBookInput other) {
    _$v = other as _$GAddBookInput;
  }

  @override
  void update(void Function(GAddBookInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAddBookInput build() => _build();

  _$GAddBookInput _build() {
    _$GAddBookInput _$result;
    try {
      _$result = _$v ??
          _$GAddBookInput._(
            authors: authors.build(),
            coverImageUrl: coverImageUrl,
            externalId: BuiltValueNullFieldError.checkNotNull(
                externalId, r'GAddBookInput', 'externalId'),
            isbn: isbn,
            publishedDate: publishedDate,
            publisher: publisher,
            readingStatus: readingStatus,
            source: BuiltValueNullFieldError.checkNotNull(
                source, r'GAddBookInput', 'source'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'GAddBookInput', 'title'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'authors';
        authors.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GAddBookInput', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GChangePasswordInput extends GChangePasswordInput {
  @override
  final String currentPassword;
  @override
  final String email;
  @override
  final String newPassword;

  factory _$GChangePasswordInput(
          [void Function(GChangePasswordInputBuilder)? updates]) =>
      (GChangePasswordInputBuilder()..update(updates))._build();

  _$GChangePasswordInput._(
      {required this.currentPassword,
      required this.email,
      required this.newPassword})
      : super._();
  @override
  GChangePasswordInput rebuild(
          void Function(GChangePasswordInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GChangePasswordInputBuilder toBuilder() =>
      GChangePasswordInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GChangePasswordInput &&
        currentPassword == other.currentPassword &&
        email == other.email &&
        newPassword == other.newPassword;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, currentPassword.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, newPassword.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GChangePasswordInput')
          ..add('currentPassword', currentPassword)
          ..add('email', email)
          ..add('newPassword', newPassword))
        .toString();
  }
}

class GChangePasswordInputBuilder
    implements Builder<GChangePasswordInput, GChangePasswordInputBuilder> {
  _$GChangePasswordInput? _$v;

  String? _currentPassword;
  String? get currentPassword => _$this._currentPassword;
  set currentPassword(String? currentPassword) =>
      _$this._currentPassword = currentPassword;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _newPassword;
  String? get newPassword => _$this._newPassword;
  set newPassword(String? newPassword) => _$this._newPassword = newPassword;

  GChangePasswordInputBuilder();

  GChangePasswordInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _currentPassword = $v.currentPassword;
      _email = $v.email;
      _newPassword = $v.newPassword;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GChangePasswordInput other) {
    _$v = other as _$GChangePasswordInput;
  }

  @override
  void update(void Function(GChangePasswordInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GChangePasswordInput build() => _build();

  _$GChangePasswordInput _build() {
    final _$result = _$v ??
        _$GChangePasswordInput._(
          currentPassword: BuiltValueNullFieldError.checkNotNull(
              currentPassword, r'GChangePasswordInput', 'currentPassword'),
          email: BuiltValueNullFieldError.checkNotNull(
              email, r'GChangePasswordInput', 'email'),
          newPassword: BuiltValueNullFieldError.checkNotNull(
              newPassword, r'GChangePasswordInput', 'newPassword'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GCreateBookListInput extends GCreateBookListInput {
  @override
  final String? description;
  @override
  final String title;

  factory _$GCreateBookListInput(
          [void Function(GCreateBookListInputBuilder)? updates]) =>
      (GCreateBookListInputBuilder()..update(updates))._build();

  _$GCreateBookListInput._({this.description, required this.title}) : super._();
  @override
  GCreateBookListInput rebuild(
          void Function(GCreateBookListInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateBookListInputBuilder toBuilder() =>
      GCreateBookListInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateBookListInput &&
        description == other.description &&
        title == other.title;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateBookListInput')
          ..add('description', description)
          ..add('title', title))
        .toString();
  }
}

class GCreateBookListInputBuilder
    implements Builder<GCreateBookListInput, GCreateBookListInputBuilder> {
  _$GCreateBookListInput? _$v;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  GCreateBookListInputBuilder();

  GCreateBookListInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _description = $v.description;
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateBookListInput other) {
    _$v = other as _$GCreateBookListInput;
  }

  @override
  void update(void Function(GCreateBookListInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateBookListInput build() => _build();

  _$GCreateBookListInput _build() {
    final _$result = _$v ??
        _$GCreateBookListInput._(
          description: description,
          title: BuiltValueNullFieldError.checkNotNull(
              title, r'GCreateBookListInput', 'title'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GLoginUserInput extends GLoginUserInput {
  @override
  final String email;
  @override
  final String password;

  factory _$GLoginUserInput([void Function(GLoginUserInputBuilder)? updates]) =>
      (GLoginUserInputBuilder()..update(updates))._build();

  _$GLoginUserInput._({required this.email, required this.password})
      : super._();
  @override
  GLoginUserInput rebuild(void Function(GLoginUserInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GLoginUserInputBuilder toBuilder() => GLoginUserInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GLoginUserInput &&
        email == other.email &&
        password == other.password;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GLoginUserInput')
          ..add('email', email)
          ..add('password', password))
        .toString();
  }
}

class GLoginUserInputBuilder
    implements Builder<GLoginUserInput, GLoginUserInputBuilder> {
  _$GLoginUserInput? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  GLoginUserInputBuilder();

  GLoginUserInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GLoginUserInput other) {
    _$v = other as _$GLoginUserInput;
  }

  @override
  void update(void Function(GLoginUserInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GLoginUserInput build() => _build();

  _$GLoginUserInput _build() {
    final _$result = _$v ??
        _$GLoginUserInput._(
          email: BuiltValueNullFieldError.checkNotNull(
              email, r'GLoginUserInput', 'email'),
          password: BuiltValueNullFieldError.checkNotNull(
              password, r'GLoginUserInput', 'password'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GMyBookListsInput extends GMyBookListsInput {
  @override
  final int? limit;
  @override
  final int? offset;

  factory _$GMyBookListsInput(
          [void Function(GMyBookListsInputBuilder)? updates]) =>
      (GMyBookListsInputBuilder()..update(updates))._build();

  _$GMyBookListsInput._({this.limit, this.offset}) : super._();
  @override
  GMyBookListsInput rebuild(void Function(GMyBookListsInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMyBookListsInputBuilder toBuilder() =>
      GMyBookListsInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyBookListsInput &&
        limit == other.limit &&
        offset == other.offset;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, limit.hashCode);
    _$hash = $jc(_$hash, offset.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMyBookListsInput')
          ..add('limit', limit)
          ..add('offset', offset))
        .toString();
  }
}

class GMyBookListsInputBuilder
    implements Builder<GMyBookListsInput, GMyBookListsInputBuilder> {
  _$GMyBookListsInput? _$v;

  int? _limit;
  int? get limit => _$this._limit;
  set limit(int? limit) => _$this._limit = limit;

  int? _offset;
  int? get offset => _$this._offset;
  set offset(int? offset) => _$this._offset = offset;

  GMyBookListsInputBuilder();

  GMyBookListsInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _limit = $v.limit;
      _offset = $v.offset;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMyBookListsInput other) {
    _$v = other as _$GMyBookListsInput;
  }

  @override
  void update(void Function(GMyBookListsInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMyBookListsInput build() => _build();

  _$GMyBookListsInput _build() {
    final _$result = _$v ??
        _$GMyBookListsInput._(
          limit: limit,
          offset: offset,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GMyShelfInput extends GMyShelfInput {
  @override
  final int? limit;
  @override
  final int? offset;
  @override
  final String? query;
  @override
  final GReadingStatus? readingStatus;
  @override
  final GShelfSortField? sortBy;
  @override
  final GSortOrder? sortOrder;

  factory _$GMyShelfInput([void Function(GMyShelfInputBuilder)? updates]) =>
      (GMyShelfInputBuilder()..update(updates))._build();

  _$GMyShelfInput._(
      {this.limit,
      this.offset,
      this.query,
      this.readingStatus,
      this.sortBy,
      this.sortOrder})
      : super._();
  @override
  GMyShelfInput rebuild(void Function(GMyShelfInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMyShelfInputBuilder toBuilder() => GMyShelfInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyShelfInput &&
        limit == other.limit &&
        offset == other.offset &&
        query == other.query &&
        readingStatus == other.readingStatus &&
        sortBy == other.sortBy &&
        sortOrder == other.sortOrder;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, limit.hashCode);
    _$hash = $jc(_$hash, offset.hashCode);
    _$hash = $jc(_$hash, query.hashCode);
    _$hash = $jc(_$hash, readingStatus.hashCode);
    _$hash = $jc(_$hash, sortBy.hashCode);
    _$hash = $jc(_$hash, sortOrder.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMyShelfInput')
          ..add('limit', limit)
          ..add('offset', offset)
          ..add('query', query)
          ..add('readingStatus', readingStatus)
          ..add('sortBy', sortBy)
          ..add('sortOrder', sortOrder))
        .toString();
  }
}

class GMyShelfInputBuilder
    implements Builder<GMyShelfInput, GMyShelfInputBuilder> {
  _$GMyShelfInput? _$v;

  int? _limit;
  int? get limit => _$this._limit;
  set limit(int? limit) => _$this._limit = limit;

  int? _offset;
  int? get offset => _$this._offset;
  set offset(int? offset) => _$this._offset = offset;

  String? _query;
  String? get query => _$this._query;
  set query(String? query) => _$this._query = query;

  GReadingStatus? _readingStatus;
  GReadingStatus? get readingStatus => _$this._readingStatus;
  set readingStatus(GReadingStatus? readingStatus) =>
      _$this._readingStatus = readingStatus;

  GShelfSortField? _sortBy;
  GShelfSortField? get sortBy => _$this._sortBy;
  set sortBy(GShelfSortField? sortBy) => _$this._sortBy = sortBy;

  GSortOrder? _sortOrder;
  GSortOrder? get sortOrder => _$this._sortOrder;
  set sortOrder(GSortOrder? sortOrder) => _$this._sortOrder = sortOrder;

  GMyShelfInputBuilder();

  GMyShelfInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _limit = $v.limit;
      _offset = $v.offset;
      _query = $v.query;
      _readingStatus = $v.readingStatus;
      _sortBy = $v.sortBy;
      _sortOrder = $v.sortOrder;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMyShelfInput other) {
    _$v = other as _$GMyShelfInput;
  }

  @override
  void update(void Function(GMyShelfInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMyShelfInput build() => _build();

  _$GMyShelfInput _build() {
    final _$result = _$v ??
        _$GMyShelfInput._(
          limit: limit,
          offset: offset,
          query: query,
          readingStatus: readingStatus,
          sortBy: sortBy,
          sortOrder: sortOrder,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GRefreshTokenInput extends GRefreshTokenInput {
  @override
  final String refreshToken;

  factory _$GRefreshTokenInput(
          [void Function(GRefreshTokenInputBuilder)? updates]) =>
      (GRefreshTokenInputBuilder()..update(updates))._build();

  _$GRefreshTokenInput._({required this.refreshToken}) : super._();
  @override
  GRefreshTokenInput rebuild(
          void Function(GRefreshTokenInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRefreshTokenInputBuilder toBuilder() =>
      GRefreshTokenInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRefreshTokenInput && refreshToken == other.refreshToken;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, refreshToken.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GRefreshTokenInput')
          ..add('refreshToken', refreshToken))
        .toString();
  }
}

class GRefreshTokenInputBuilder
    implements Builder<GRefreshTokenInput, GRefreshTokenInputBuilder> {
  _$GRefreshTokenInput? _$v;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(String? refreshToken) => _$this._refreshToken = refreshToken;

  GRefreshTokenInputBuilder();

  GRefreshTokenInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _refreshToken = $v.refreshToken;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRefreshTokenInput other) {
    _$v = other as _$GRefreshTokenInput;
  }

  @override
  void update(void Function(GRefreshTokenInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRefreshTokenInput build() => _build();

  _$GRefreshTokenInput _build() {
    final _$result = _$v ??
        _$GRefreshTokenInput._(
          refreshToken: BuiltValueNullFieldError.checkNotNull(
              refreshToken, r'GRefreshTokenInput', 'refreshToken'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GRegisterDeviceTokenInput extends GRegisterDeviceTokenInput {
  @override
  final String platform;
  @override
  final String token;

  factory _$GRegisterDeviceTokenInput(
          [void Function(GRegisterDeviceTokenInputBuilder)? updates]) =>
      (GRegisterDeviceTokenInputBuilder()..update(updates))._build();

  _$GRegisterDeviceTokenInput._({required this.platform, required this.token})
      : super._();
  @override
  GRegisterDeviceTokenInput rebuild(
          void Function(GRegisterDeviceTokenInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRegisterDeviceTokenInputBuilder toBuilder() =>
      GRegisterDeviceTokenInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRegisterDeviceTokenInput &&
        platform == other.platform &&
        token == other.token;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, platform.hashCode);
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GRegisterDeviceTokenInput')
          ..add('platform', platform)
          ..add('token', token))
        .toString();
  }
}

class GRegisterDeviceTokenInputBuilder
    implements
        Builder<GRegisterDeviceTokenInput, GRegisterDeviceTokenInputBuilder> {
  _$GRegisterDeviceTokenInput? _$v;

  String? _platform;
  String? get platform => _$this._platform;
  set platform(String? platform) => _$this._platform = platform;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  GRegisterDeviceTokenInputBuilder();

  GRegisterDeviceTokenInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _platform = $v.platform;
      _token = $v.token;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRegisterDeviceTokenInput other) {
    _$v = other as _$GRegisterDeviceTokenInput;
  }

  @override
  void update(void Function(GRegisterDeviceTokenInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRegisterDeviceTokenInput build() => _build();

  _$GRegisterDeviceTokenInput _build() {
    final _$result = _$v ??
        _$GRegisterDeviceTokenInput._(
          platform: BuiltValueNullFieldError.checkNotNull(
              platform, r'GRegisterDeviceTokenInput', 'platform'),
          token: BuiltValueNullFieldError.checkNotNull(
              token, r'GRegisterDeviceTokenInput', 'token'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GRegisterUserInput extends GRegisterUserInput {
  @override
  final String email;
  @override
  final String password;

  factory _$GRegisterUserInput(
          [void Function(GRegisterUserInputBuilder)? updates]) =>
      (GRegisterUserInputBuilder()..update(updates))._build();

  _$GRegisterUserInput._({required this.email, required this.password})
      : super._();
  @override
  GRegisterUserInput rebuild(
          void Function(GRegisterUserInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRegisterUserInputBuilder toBuilder() =>
      GRegisterUserInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRegisterUserInput &&
        email == other.email &&
        password == other.password;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GRegisterUserInput')
          ..add('email', email)
          ..add('password', password))
        .toString();
  }
}

class GRegisterUserInputBuilder
    implements Builder<GRegisterUserInput, GRegisterUserInputBuilder> {
  _$GRegisterUserInput? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  GRegisterUserInputBuilder();

  GRegisterUserInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRegisterUserInput other) {
    _$v = other as _$GRegisterUserInput;
  }

  @override
  void update(void Function(GRegisterUserInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRegisterUserInput build() => _build();

  _$GRegisterUserInput _build() {
    final _$result = _$v ??
        _$GRegisterUserInput._(
          email: BuiltValueNullFieldError.checkNotNull(
              email, r'GRegisterUserInput', 'email'),
          password: BuiltValueNullFieldError.checkNotNull(
              password, r'GRegisterUserInput', 'password'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GSendPasswordResetEmailInput extends GSendPasswordResetEmailInput {
  @override
  final String email;

  factory _$GSendPasswordResetEmailInput(
          [void Function(GSendPasswordResetEmailInputBuilder)? updates]) =>
      (GSendPasswordResetEmailInputBuilder()..update(updates))._build();

  _$GSendPasswordResetEmailInput._({required this.email}) : super._();
  @override
  GSendPasswordResetEmailInput rebuild(
          void Function(GSendPasswordResetEmailInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSendPasswordResetEmailInputBuilder toBuilder() =>
      GSendPasswordResetEmailInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSendPasswordResetEmailInput && email == other.email;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSendPasswordResetEmailInput')
          ..add('email', email))
        .toString();
  }
}

class GSendPasswordResetEmailInputBuilder
    implements
        Builder<GSendPasswordResetEmailInput,
            GSendPasswordResetEmailInputBuilder> {
  _$GSendPasswordResetEmailInput? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  GSendPasswordResetEmailInputBuilder();

  GSendPasswordResetEmailInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSendPasswordResetEmailInput other) {
    _$v = other as _$GSendPasswordResetEmailInput;
  }

  @override
  void update(void Function(GSendPasswordResetEmailInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSendPasswordResetEmailInput build() => _build();

  _$GSendPasswordResetEmailInput _build() {
    final _$result = _$v ??
        _$GSendPasswordResetEmailInput._(
          email: BuiltValueNullFieldError.checkNotNull(
              email, r'GSendPasswordResetEmailInput', 'email'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GUnregisterDeviceTokenInput extends GUnregisterDeviceTokenInput {
  @override
  final String token;

  factory _$GUnregisterDeviceTokenInput(
          [void Function(GUnregisterDeviceTokenInputBuilder)? updates]) =>
      (GUnregisterDeviceTokenInputBuilder()..update(updates))._build();

  _$GUnregisterDeviceTokenInput._({required this.token}) : super._();
  @override
  GUnregisterDeviceTokenInput rebuild(
          void Function(GUnregisterDeviceTokenInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUnregisterDeviceTokenInputBuilder toBuilder() =>
      GUnregisterDeviceTokenInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUnregisterDeviceTokenInput && token == other.token;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUnregisterDeviceTokenInput')
          ..add('token', token))
        .toString();
  }
}

class GUnregisterDeviceTokenInputBuilder
    implements
        Builder<GUnregisterDeviceTokenInput,
            GUnregisterDeviceTokenInputBuilder> {
  _$GUnregisterDeviceTokenInput? _$v;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  GUnregisterDeviceTokenInputBuilder();

  GUnregisterDeviceTokenInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _token = $v.token;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUnregisterDeviceTokenInput other) {
    _$v = other as _$GUnregisterDeviceTokenInput;
  }

  @override
  void update(void Function(GUnregisterDeviceTokenInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUnregisterDeviceTokenInput build() => _build();

  _$GUnregisterDeviceTokenInput _build() {
    final _$result = _$v ??
        _$GUnregisterDeviceTokenInput._(
          token: BuiltValueNullFieldError.checkNotNull(
              token, r'GUnregisterDeviceTokenInput', 'token'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateBookListInput extends GUpdateBookListInput {
  @override
  final String? description;
  @override
  final int listId;
  @override
  final String? title;

  factory _$GUpdateBookListInput(
          [void Function(GUpdateBookListInputBuilder)? updates]) =>
      (GUpdateBookListInputBuilder()..update(updates))._build();

  _$GUpdateBookListInput._({this.description, required this.listId, this.title})
      : super._();
  @override
  GUpdateBookListInput rebuild(
          void Function(GUpdateBookListInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateBookListInputBuilder toBuilder() =>
      GUpdateBookListInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateBookListInput &&
        description == other.description &&
        listId == other.listId &&
        title == other.title;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, listId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateBookListInput')
          ..add('description', description)
          ..add('listId', listId)
          ..add('title', title))
        .toString();
  }
}

class GUpdateBookListInputBuilder
    implements Builder<GUpdateBookListInput, GUpdateBookListInputBuilder> {
  _$GUpdateBookListInput? _$v;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  int? _listId;
  int? get listId => _$this._listId;
  set listId(int? listId) => _$this._listId = listId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  GUpdateBookListInputBuilder();

  GUpdateBookListInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _description = $v.description;
      _listId = $v.listId;
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateBookListInput other) {
    _$v = other as _$GUpdateBookListInput;
  }

  @override
  void update(void Function(GUpdateBookListInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateBookListInput build() => _build();

  _$GUpdateBookListInput _build() {
    final _$result = _$v ??
        _$GUpdateBookListInput._(
          description: description,
          listId: BuiltValueNullFieldError.checkNotNull(
              listId, r'GUpdateBookListInput', 'listId'),
          title: title,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateProfileInput extends GUpdateProfileInput {
  @override
  final String? avatarUrl;
  @override
  final String? bio;
  @override
  final String? handle;
  @override
  final String? instagramHandle;
  @override
  final String name;

  factory _$GUpdateProfileInput(
          [void Function(GUpdateProfileInputBuilder)? updates]) =>
      (GUpdateProfileInputBuilder()..update(updates))._build();

  _$GUpdateProfileInput._(
      {this.avatarUrl,
      this.bio,
      this.handle,
      this.instagramHandle,
      required this.name})
      : super._();
  @override
  GUpdateProfileInput rebuild(
          void Function(GUpdateProfileInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateProfileInputBuilder toBuilder() =>
      GUpdateProfileInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateProfileInput &&
        avatarUrl == other.avatarUrl &&
        bio == other.bio &&
        handle == other.handle &&
        instagramHandle == other.instagramHandle &&
        name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, avatarUrl.hashCode);
    _$hash = $jc(_$hash, bio.hashCode);
    _$hash = $jc(_$hash, handle.hashCode);
    _$hash = $jc(_$hash, instagramHandle.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateProfileInput')
          ..add('avatarUrl', avatarUrl)
          ..add('bio', bio)
          ..add('handle', handle)
          ..add('instagramHandle', instagramHandle)
          ..add('name', name))
        .toString();
  }
}

class GUpdateProfileInputBuilder
    implements Builder<GUpdateProfileInput, GUpdateProfileInputBuilder> {
  _$GUpdateProfileInput? _$v;

  String? _avatarUrl;
  String? get avatarUrl => _$this._avatarUrl;
  set avatarUrl(String? avatarUrl) => _$this._avatarUrl = avatarUrl;

  String? _bio;
  String? get bio => _$this._bio;
  set bio(String? bio) => _$this._bio = bio;

  String? _handle;
  String? get handle => _$this._handle;
  set handle(String? handle) => _$this._handle = handle;

  String? _instagramHandle;
  String? get instagramHandle => _$this._instagramHandle;
  set instagramHandle(String? instagramHandle) =>
      _$this._instagramHandle = instagramHandle;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  GUpdateProfileInputBuilder();

  GUpdateProfileInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _avatarUrl = $v.avatarUrl;
      _bio = $v.bio;
      _handle = $v.handle;
      _instagramHandle = $v.instagramHandle;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateProfileInput other) {
    _$v = other as _$GUpdateProfileInput;
  }

  @override
  void update(void Function(GUpdateProfileInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateProfileInput build() => _build();

  _$GUpdateProfileInput _build() {
    final _$result = _$v ??
        _$GUpdateProfileInput._(
          avatarUrl: avatarUrl,
          bio: bio,
          handle: handle,
          instagramHandle: instagramHandle,
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'GUpdateProfileInput', 'name'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
