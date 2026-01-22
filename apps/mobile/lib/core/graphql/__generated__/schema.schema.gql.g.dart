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
      throw new ArgumentError(name);
  }
}

final BuiltSet<GAuthErrorCode> _$gAuthErrorCodeValues =
    new BuiltSet<GAuthErrorCode>(const <GAuthErrorCode>[
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
const GReadingStatus _$gReadingStatusREADING =
    const GReadingStatus._('READING');
const GReadingStatus _$gReadingStatusCOMPLETED =
    const GReadingStatus._('COMPLETED');
const GReadingStatus _$gReadingStatusDROPPED =
    const GReadingStatus._('DROPPED');

GReadingStatus _$gReadingStatusValueOf(String name) {
  switch (name) {
    case 'BACKLOG':
      return _$gReadingStatusBACKLOG;
    case 'READING':
      return _$gReadingStatusREADING;
    case 'COMPLETED':
      return _$gReadingStatusCOMPLETED;
    case 'DROPPED':
      return _$gReadingStatusDROPPED;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<GReadingStatus> _$gReadingStatusValues =
    new BuiltSet<GReadingStatus>(const <GReadingStatus>[
  _$gReadingStatusBACKLOG,
  _$gReadingStatusREADING,
  _$gReadingStatusCOMPLETED,
  _$gReadingStatusDROPPED,
]);

Serializer<GAuthErrorCode> _$gAuthErrorCodeSerializer =
    new _$GAuthErrorCodeSerializer();
Serializer<GLoginUserInput> _$gLoginUserInputSerializer =
    new _$GLoginUserInputSerializer();
Serializer<GRefreshTokenInput> _$gRefreshTokenInputSerializer =
    new _$GRefreshTokenInputSerializer();
Serializer<GRegisterUserInput> _$gRegisterUserInputSerializer =
    new _$GRegisterUserInputSerializer();
Serializer<GAddBookInput> _$gAddBookInputSerializer =
    new _$GAddBookInputSerializer();
Serializer<GReadingStatus> _$gReadingStatusSerializer =
    new _$GReadingStatusSerializer();

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
    final result = new GLoginUserInputBuilder();

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
    final result = new GRefreshTokenInputBuilder();

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
    final result = new GRegisterUserInputBuilder();

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

class _$GAddBookInputSerializer implements StructuredSerializer<GAddBookInput> {
  @override
  final Iterable<Type> types = const [GAddBookInput, _$GAddBookInput];
  @override
  final String wireName = 'GAddBookInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, GAddBookInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'externalId',
      serializers.serialize(object.externalId,
          specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'authors',
      serializers.serialize(object.authors,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];
    Object? value;
    value = object.publisher;
    if (value != null) {
      result
        ..add('publisher')
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
    value = object.isbn;
    if (value != null) {
      result
        ..add('isbn')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.coverImageUrl;
    if (value != null) {
      result
        ..add('coverImageUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GAddBookInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAddBookInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'externalId':
          result.externalId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'authors':
          result.authors.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'publisher':
          result.publisher = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'publishedDate':
          result.publishedDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'isbn':
          result.isbn = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'coverImageUrl':
          result.coverImageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
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

class _$GLoginUserInput extends GLoginUserInput {
  @override
  final String email;
  @override
  final String password;

  factory _$GLoginUserInput([void Function(GLoginUserInputBuilder)? updates]) =>
      (new GLoginUserInputBuilder()..update(updates))._build();

  _$GLoginUserInput._({required this.email, required this.password})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(email, r'GLoginUserInput', 'email');
    BuiltValueNullFieldError.checkNotNull(
        password, r'GLoginUserInput', 'password');
  }

  @override
  GLoginUserInput rebuild(void Function(GLoginUserInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GLoginUserInputBuilder toBuilder() =>
      new GLoginUserInputBuilder()..replace(this);

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
    ArgumentError.checkNotNull(other, 'other');
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
        new _$GLoginUserInput._(
            email: BuiltValueNullFieldError.checkNotNull(
                email, r'GLoginUserInput', 'email'),
            password: BuiltValueNullFieldError.checkNotNull(
                password, r'GLoginUserInput', 'password'));
    replace(_$result);
    return _$result;
  }
}

class _$GRefreshTokenInput extends GRefreshTokenInput {
  @override
  final String refreshToken;

  factory _$GRefreshTokenInput(
          [void Function(GRefreshTokenInputBuilder)? updates]) =>
      (new GRefreshTokenInputBuilder()..update(updates))._build();

  _$GRefreshTokenInput._({required this.refreshToken}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        refreshToken, r'GRefreshTokenInput', 'refreshToken');
  }

  @override
  GRefreshTokenInput rebuild(
          void Function(GRefreshTokenInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRefreshTokenInputBuilder toBuilder() =>
      new GRefreshTokenInputBuilder()..replace(this);

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
    ArgumentError.checkNotNull(other, 'other');
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
        new _$GRefreshTokenInput._(
            refreshToken: BuiltValueNullFieldError.checkNotNull(
                refreshToken, r'GRefreshTokenInput', 'refreshToken'));
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
      (new GRegisterUserInputBuilder()..update(updates))._build();

  _$GRegisterUserInput._({required this.email, required this.password})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        email, r'GRegisterUserInput', 'email');
    BuiltValueNullFieldError.checkNotNull(
        password, r'GRegisterUserInput', 'password');
  }

  @override
  GRegisterUserInput rebuild(
          void Function(GRegisterUserInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRegisterUserInputBuilder toBuilder() =>
      new GRegisterUserInputBuilder()..replace(this);

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
    ArgumentError.checkNotNull(other, 'other');
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
        new _$GRegisterUserInput._(
            email: BuiltValueNullFieldError.checkNotNull(
                email, r'GRegisterUserInput', 'email'),
            password: BuiltValueNullFieldError.checkNotNull(
                password, r'GRegisterUserInput', 'password'));
    replace(_$result);
    return _$result;
  }
}

class _$GAddBookInput extends GAddBookInput {
  @override
  final String externalId;
  @override
  final String title;
  @override
  final BuiltList<String> authors;
  @override
  final String? publisher;
  @override
  final String? publishedDate;
  @override
  final String? isbn;
  @override
  final String? coverImageUrl;

  factory _$GAddBookInput([void Function(GAddBookInputBuilder)? updates]) =>
      (new GAddBookInputBuilder()..update(updates))._build();

  _$GAddBookInput._(
      {required this.externalId,
      required this.title,
      required this.authors,
      this.publisher,
      this.publishedDate,
      this.isbn,
      this.coverImageUrl})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        externalId, r'GAddBookInput', 'externalId');
    BuiltValueNullFieldError.checkNotNull(title, r'GAddBookInput', 'title');
    BuiltValueNullFieldError.checkNotNull(authors, r'GAddBookInput', 'authors');
  }

  @override
  GAddBookInput rebuild(void Function(GAddBookInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAddBookInputBuilder toBuilder() => new GAddBookInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAddBookInput &&
        externalId == other.externalId &&
        title == other.title &&
        authors == other.authors &&
        publisher == other.publisher &&
        publishedDate == other.publishedDate &&
        isbn == other.isbn &&
        coverImageUrl == other.coverImageUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, externalId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, authors.hashCode);
    _$hash = $jc(_$hash, publisher.hashCode);
    _$hash = $jc(_$hash, publishedDate.hashCode);
    _$hash = $jc(_$hash, isbn.hashCode);
    _$hash = $jc(_$hash, coverImageUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAddBookInput')
          ..add('externalId', externalId)
          ..add('title', title)
          ..add('authors', authors)
          ..add('publisher', publisher)
          ..add('publishedDate', publishedDate)
          ..add('isbn', isbn)
          ..add('coverImageUrl', coverImageUrl))
        .toString();
  }
}

class GAddBookInputBuilder
    implements Builder<GAddBookInput, GAddBookInputBuilder> {
  _$GAddBookInput? _$v;

  String? _externalId;
  String? get externalId => _$this._externalId;
  set externalId(String? externalId) => _$this._externalId = externalId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  ListBuilder<String>? _authors;
  ListBuilder<String> get authors =>
      _$this._authors ??= new ListBuilder<String>();
  set authors(ListBuilder<String>? authors) => _$this._authors = authors;

  String? _publisher;
  String? get publisher => _$this._publisher;
  set publisher(String? publisher) => _$this._publisher = publisher;

  String? _publishedDate;
  String? get publishedDate => _$this._publishedDate;
  set publishedDate(String? publishedDate) =>
      _$this._publishedDate = publishedDate;

  String? _isbn;
  String? get isbn => _$this._isbn;
  set isbn(String? isbn) => _$this._isbn = isbn;

  String? _coverImageUrl;
  String? get coverImageUrl => _$this._coverImageUrl;
  set coverImageUrl(String? coverImageUrl) =>
      _$this._coverImageUrl = coverImageUrl;

  GAddBookInputBuilder();

  GAddBookInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _externalId = $v.externalId;
      _title = $v.title;
      _authors = $v.authors.toBuilder();
      _publisher = $v.publisher;
      _publishedDate = $v.publishedDate;
      _isbn = $v.isbn;
      _coverImageUrl = $v.coverImageUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAddBookInput other) {
    ArgumentError.checkNotNull(other, 'other');
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
          new _$GAddBookInput._(
              externalId: BuiltValueNullFieldError.checkNotNull(
                  externalId, r'GAddBookInput', 'externalId'),
              title: BuiltValueNullFieldError.checkNotNull(
                  title, r'GAddBookInput', 'title'),
              authors: authors.build(),
              publisher: publisher,
              publishedDate: publishedDate,
              isbn: isbn,
              coverImageUrl: coverImageUrl);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'authors';
        authors.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GAddBookInput', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
