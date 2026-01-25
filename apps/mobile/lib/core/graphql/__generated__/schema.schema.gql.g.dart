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

GAuthErrorCode _$gAuthErrorCodeValueOf(String name) {
  switch (name) {
    case 'EMAIL_ALREADY_EXISTS':
      return _$gAuthErrorCodeEMAIL_ALREADY_EXISTS;
    case 'INTERNAL_ERROR':
      return _$gAuthErrorCodeINTERNAL_ERROR;
    case 'INVALID_CREDENTIALS':
      return _$gAuthErrorCodeINVALID_CREDENTIALS;
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
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GAuthErrorCode> _$gAuthErrorCodeValues =
    BuiltSet<GAuthErrorCode>(const <GAuthErrorCode>[
  _$gAuthErrorCodeEMAIL_ALREADY_EXISTS,
  _$gAuthErrorCodeINTERNAL_ERROR,
  _$gAuthErrorCodeINVALID_CREDENTIALS,
  _$gAuthErrorCodeINVALID_PASSWORD,
  _$gAuthErrorCodeINVALID_TOKEN,
  _$gAuthErrorCodeNETWORK_ERROR,
  _$gAuthErrorCodeTOKEN_EXPIRED,
  _$gAuthErrorCodeUNAUTHENTICATED,
  _$gAuthErrorCodeUSER_NOT_FOUND,
]);

const GReadingStatus _$gReadingStatusBACKLOG =
    const GReadingStatus._('BACKLOG');
const GReadingStatus _$gReadingStatusCOMPLETED =
    const GReadingStatus._('COMPLETED');
const GReadingStatus _$gReadingStatusDROPPED =
    const GReadingStatus._('DROPPED');
const GReadingStatus _$gReadingStatusREADING =
    const GReadingStatus._('READING');

GReadingStatus _$gReadingStatusValueOf(String name) {
  switch (name) {
    case 'BACKLOG':
      return _$gReadingStatusBACKLOG;
    case 'COMPLETED':
      return _$gReadingStatusCOMPLETED;
    case 'DROPPED':
      return _$gReadingStatusDROPPED;
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
  _$gReadingStatusDROPPED,
  _$gReadingStatusREADING,
]);

const GShelfSortField _$gShelfSortFieldADDED_AT =
    const GShelfSortField._('ADDED_AT');
const GShelfSortField _$gShelfSortFieldAUTHOR =
    const GShelfSortField._('AUTHOR');
const GShelfSortField _$gShelfSortFieldTITLE = const GShelfSortField._('TITLE');

GShelfSortField _$gShelfSortFieldValueOf(String name) {
  switch (name) {
    case 'ADDED_AT':
      return _$gShelfSortFieldADDED_AT;
    case 'AUTHOR':
      return _$gShelfSortFieldAUTHOR;
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
Serializer<GLoginUserInput> _$gLoginUserInputSerializer =
    _$GLoginUserInputSerializer();
Serializer<GMyShelfInput> _$gMyShelfInputSerializer =
    _$GMyShelfInputSerializer();
Serializer<GReadingStatus> _$gReadingStatusSerializer =
    _$GReadingStatusSerializer();
Serializer<GRefreshTokenInput> _$gRefreshTokenInputSerializer =
    _$GRefreshTokenInputSerializer();
Serializer<GRegisterUserInput> _$gRegisterUserInputSerializer =
    _$GRegisterUserInputSerializer();
Serializer<GShelfSortField> _$gShelfSortFieldSerializer =
    _$GShelfSortFieldSerializer();
Serializer<GSortOrder> _$gSortOrderSerializer = _$GSortOrderSerializer();
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

class _$GMyShelfInput extends GMyShelfInput {
  @override
  final int? limit;
  @override
  final int? offset;
  @override
  final String? query;
  @override
  final GShelfSortField? sortBy;
  @override
  final GSortOrder? sortOrder;

  factory _$GMyShelfInput([void Function(GMyShelfInputBuilder)? updates]) =>
      (GMyShelfInputBuilder()..update(updates))._build();

  _$GMyShelfInput._(
      {this.limit, this.offset, this.query, this.sortBy, this.sortOrder})
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
        sortBy == other.sortBy &&
        sortOrder == other.sortOrder;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, limit.hashCode);
    _$hash = $jc(_$hash, offset.hashCode);
    _$hash = $jc(_$hash, query.hashCode);
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

class _$GUpdateProfileInput extends GUpdateProfileInput {
  @override
  final String? avatarUrl;
  @override
  final String name;

  factory _$GUpdateProfileInput(
          [void Function(GUpdateProfileInputBuilder)? updates]) =>
      (GUpdateProfileInputBuilder()..update(updates))._build();

  _$GUpdateProfileInput._({this.avatarUrl, required this.name}) : super._();
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
        name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, avatarUrl.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateProfileInput')
          ..add('avatarUrl', avatarUrl)
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

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  GUpdateProfileInputBuilder();

  GUpdateProfileInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _avatarUrl = $v.avatarUrl;
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
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'GUpdateProfileInput', 'name'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
