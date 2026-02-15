// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_my_profile.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GGetMyProfileData> _$gGetMyProfileDataSerializer =
    _$GGetMyProfileDataSerializer();
Serializer<GGetMyProfileData_me__base> _$gGetMyProfileDataMeBaseSerializer =
    _$GGetMyProfileData_me__baseSerializer();
Serializer<GGetMyProfileData_me__asUser> _$gGetMyProfileDataMeAsUserSerializer =
    _$GGetMyProfileData_me__asUserSerializer();
Serializer<GGetMyProfileData_me__asAuthErrorResult>
    _$gGetMyProfileDataMeAsAuthErrorResultSerializer =
    _$GGetMyProfileData_me__asAuthErrorResultSerializer();

class _$GGetMyProfileDataSerializer
    implements StructuredSerializer<GGetMyProfileData> {
  @override
  final Iterable<Type> types = const [GGetMyProfileData, _$GGetMyProfileData];
  @override
  final String wireName = 'GGetMyProfileData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GGetMyProfileData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'me',
      serializers.serialize(object.me,
          specifiedType: const FullType(GGetMyProfileData_me)),
    ];

    return result;
  }

  @override
  GGetMyProfileData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GGetMyProfileDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'me':
          result.me = serializers.deserialize(value,
                  specifiedType: const FullType(GGetMyProfileData_me))!
              as GGetMyProfileData_me;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetMyProfileData_me__baseSerializer
    implements StructuredSerializer<GGetMyProfileData_me__base> {
  @override
  final Iterable<Type> types = const [
    GGetMyProfileData_me__base,
    _$GGetMyProfileData_me__base
  ];
  @override
  final String wireName = 'GGetMyProfileData_me__base';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GGetMyProfileData_me__base object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GGetMyProfileData_me__base deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GGetMyProfileData_me__baseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetMyProfileData_me__asUserSerializer
    implements StructuredSerializer<GGetMyProfileData_me__asUser> {
  @override
  final Iterable<Type> types = const [
    GGetMyProfileData_me__asUser,
    _$GGetMyProfileData_me__asUser
  ];
  @override
  final String wireName = 'GGetMyProfileData_me__asUser';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GGetMyProfileData_me__asUser object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'bookCount',
      serializers.serialize(object.bookCount,
          specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.email;
    if (value != null) {
      result
        ..add('email')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.avatarUrl;
    if (value != null) {
      result
        ..add('avatarUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.createdAt;
    if (value != null) {
      result
        ..add('createdAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.bio;
    if (value != null) {
      result
        ..add('bio')
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
    value = object.handle;
    if (value != null) {
      result
        ..add('handle')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.shareUrl;
    if (value != null) {
      result
        ..add('shareUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GGetMyProfileData_me__asUser deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GGetMyProfileData_me__asUserBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'avatarUrl':
          result.avatarUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'bookCount':
          result.bookCount = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'bio':
          result.bio = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'instagramHandle':
          result.instagramHandle = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'handle':
          result.handle = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'shareUrl':
          result.shareUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetMyProfileData_me__asAuthErrorResultSerializer
    implements StructuredSerializer<GGetMyProfileData_me__asAuthErrorResult> {
  @override
  final Iterable<Type> types = const [
    GGetMyProfileData_me__asAuthErrorResult,
    _$GGetMyProfileData_me__asAuthErrorResult
  ];
  @override
  final String wireName = 'GGetMyProfileData_me__asAuthErrorResult';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GGetMyProfileData_me__asAuthErrorResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.code;
    if (value != null) {
      result
        ..add('code')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i3.GAuthErrorCode)));
    }
    value = object.message;
    if (value != null) {
      result
        ..add('message')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GGetMyProfileData_me__asAuthErrorResult deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GGetMyProfileData_me__asAuthErrorResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'code':
          result.code = serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GAuthErrorCode))
              as _i3.GAuthErrorCode?;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetMyProfileData extends GGetMyProfileData {
  @override
  final String G__typename;
  @override
  final GGetMyProfileData_me me;

  factory _$GGetMyProfileData(
          [void Function(GGetMyProfileDataBuilder)? updates]) =>
      (GGetMyProfileDataBuilder()..update(updates))._build();

  _$GGetMyProfileData._({required this.G__typename, required this.me})
      : super._();
  @override
  GGetMyProfileData rebuild(void Function(GGetMyProfileDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetMyProfileDataBuilder toBuilder() =>
      GGetMyProfileDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetMyProfileData &&
        G__typename == other.G__typename &&
        me == other.me;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, me.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetMyProfileData')
          ..add('G__typename', G__typename)
          ..add('me', me))
        .toString();
  }
}

class GGetMyProfileDataBuilder
    implements Builder<GGetMyProfileData, GGetMyProfileDataBuilder> {
  _$GGetMyProfileData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GGetMyProfileData_me? _me;
  GGetMyProfileData_me? get me => _$this._me;
  set me(GGetMyProfileData_me? me) => _$this._me = me;

  GGetMyProfileDataBuilder() {
    GGetMyProfileData._initializeBuilder(this);
  }

  GGetMyProfileDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _me = $v.me;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetMyProfileData other) {
    _$v = other as _$GGetMyProfileData;
  }

  @override
  void update(void Function(GGetMyProfileDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetMyProfileData build() => _build();

  _$GGetMyProfileData _build() {
    final _$result = _$v ??
        _$GGetMyProfileData._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GGetMyProfileData', 'G__typename'),
          me: BuiltValueNullFieldError.checkNotNull(
              me, r'GGetMyProfileData', 'me'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GGetMyProfileData_me__base extends GGetMyProfileData_me__base {
  @override
  final String G__typename;

  factory _$GGetMyProfileData_me__base(
          [void Function(GGetMyProfileData_me__baseBuilder)? updates]) =>
      (GGetMyProfileData_me__baseBuilder()..update(updates))._build();

  _$GGetMyProfileData_me__base._({required this.G__typename}) : super._();
  @override
  GGetMyProfileData_me__base rebuild(
          void Function(GGetMyProfileData_me__baseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetMyProfileData_me__baseBuilder toBuilder() =>
      GGetMyProfileData_me__baseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetMyProfileData_me__base &&
        G__typename == other.G__typename;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetMyProfileData_me__base')
          ..add('G__typename', G__typename))
        .toString();
  }
}

class GGetMyProfileData_me__baseBuilder
    implements
        Builder<GGetMyProfileData_me__base, GGetMyProfileData_me__baseBuilder> {
  _$GGetMyProfileData_me__base? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GGetMyProfileData_me__baseBuilder() {
    GGetMyProfileData_me__base._initializeBuilder(this);
  }

  GGetMyProfileData_me__baseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetMyProfileData_me__base other) {
    _$v = other as _$GGetMyProfileData_me__base;
  }

  @override
  void update(void Function(GGetMyProfileData_me__baseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetMyProfileData_me__base build() => _build();

  _$GGetMyProfileData_me__base _build() {
    final _$result = _$v ??
        _$GGetMyProfileData_me__base._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GGetMyProfileData_me__base', 'G__typename'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GGetMyProfileData_me__asUser extends GGetMyProfileData_me__asUser {
  @override
  final String G__typename;
  @override
  final int? id;
  @override
  final String? email;
  @override
  final String? name;
  @override
  final String? avatarUrl;
  @override
  final DateTime? createdAt;
  @override
  final int bookCount;
  @override
  final String? bio;
  @override
  final String? instagramHandle;
  @override
  final String? handle;
  @override
  final String? shareUrl;

  factory _$GGetMyProfileData_me__asUser(
          [void Function(GGetMyProfileData_me__asUserBuilder)? updates]) =>
      (GGetMyProfileData_me__asUserBuilder()..update(updates))._build();

  _$GGetMyProfileData_me__asUser._(
      {required this.G__typename,
      this.id,
      this.email,
      this.name,
      this.avatarUrl,
      this.createdAt,
      required this.bookCount,
      this.bio,
      this.instagramHandle,
      this.handle,
      this.shareUrl})
      : super._();
  @override
  GGetMyProfileData_me__asUser rebuild(
          void Function(GGetMyProfileData_me__asUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetMyProfileData_me__asUserBuilder toBuilder() =>
      GGetMyProfileData_me__asUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetMyProfileData_me__asUser &&
        G__typename == other.G__typename &&
        id == other.id &&
        email == other.email &&
        name == other.name &&
        avatarUrl == other.avatarUrl &&
        createdAt == other.createdAt &&
        bookCount == other.bookCount &&
        bio == other.bio &&
        instagramHandle == other.instagramHandle &&
        handle == other.handle &&
        shareUrl == other.shareUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, avatarUrl.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, bookCount.hashCode);
    _$hash = $jc(_$hash, bio.hashCode);
    _$hash = $jc(_$hash, instagramHandle.hashCode);
    _$hash = $jc(_$hash, handle.hashCode);
    _$hash = $jc(_$hash, shareUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetMyProfileData_me__asUser')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('email', email)
          ..add('name', name)
          ..add('avatarUrl', avatarUrl)
          ..add('createdAt', createdAt)
          ..add('bookCount', bookCount)
          ..add('bio', bio)
          ..add('instagramHandle', instagramHandle)
          ..add('handle', handle)
          ..add('shareUrl', shareUrl))
        .toString();
  }
}

class GGetMyProfileData_me__asUserBuilder
    implements
        Builder<GGetMyProfileData_me__asUser,
            GGetMyProfileData_me__asUserBuilder> {
  _$GGetMyProfileData_me__asUser? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _avatarUrl;
  String? get avatarUrl => _$this._avatarUrl;
  set avatarUrl(String? avatarUrl) => _$this._avatarUrl = avatarUrl;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  int? _bookCount;
  int? get bookCount => _$this._bookCount;
  set bookCount(int? bookCount) => _$this._bookCount = bookCount;

  String? _bio;
  String? get bio => _$this._bio;
  set bio(String? bio) => _$this._bio = bio;

  String? _instagramHandle;
  String? get instagramHandle => _$this._instagramHandle;
  set instagramHandle(String? instagramHandle) =>
      _$this._instagramHandle = instagramHandle;

  String? _handle;
  String? get handle => _$this._handle;
  set handle(String? handle) => _$this._handle = handle;

  String? _shareUrl;
  String? get shareUrl => _$this._shareUrl;
  set shareUrl(String? shareUrl) => _$this._shareUrl = shareUrl;

  GGetMyProfileData_me__asUserBuilder() {
    GGetMyProfileData_me__asUser._initializeBuilder(this);
  }

  GGetMyProfileData_me__asUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _email = $v.email;
      _name = $v.name;
      _avatarUrl = $v.avatarUrl;
      _createdAt = $v.createdAt;
      _bookCount = $v.bookCount;
      _bio = $v.bio;
      _instagramHandle = $v.instagramHandle;
      _handle = $v.handle;
      _shareUrl = $v.shareUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetMyProfileData_me__asUser other) {
    _$v = other as _$GGetMyProfileData_me__asUser;
  }

  @override
  void update(void Function(GGetMyProfileData_me__asUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetMyProfileData_me__asUser build() => _build();

  _$GGetMyProfileData_me__asUser _build() {
    final _$result = _$v ??
        _$GGetMyProfileData_me__asUser._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GGetMyProfileData_me__asUser', 'G__typename'),
          id: id,
          email: email,
          name: name,
          avatarUrl: avatarUrl,
          createdAt: createdAt,
          bookCount: BuiltValueNullFieldError.checkNotNull(
              bookCount, r'GGetMyProfileData_me__asUser', 'bookCount'),
          bio: bio,
          instagramHandle: instagramHandle,
          handle: handle,
          shareUrl: shareUrl,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GGetMyProfileData_me__asAuthErrorResult
    extends GGetMyProfileData_me__asAuthErrorResult {
  @override
  final String G__typename;
  @override
  final _i3.GAuthErrorCode? code;
  @override
  final String? message;

  factory _$GGetMyProfileData_me__asAuthErrorResult(
          [void Function(GGetMyProfileData_me__asAuthErrorResultBuilder)?
              updates]) =>
      (GGetMyProfileData_me__asAuthErrorResultBuilder()..update(updates))
          ._build();

  _$GGetMyProfileData_me__asAuthErrorResult._(
      {required this.G__typename, this.code, this.message})
      : super._();
  @override
  GGetMyProfileData_me__asAuthErrorResult rebuild(
          void Function(GGetMyProfileData_me__asAuthErrorResultBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetMyProfileData_me__asAuthErrorResultBuilder toBuilder() =>
      GGetMyProfileData_me__asAuthErrorResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetMyProfileData_me__asAuthErrorResult &&
        G__typename == other.G__typename &&
        code == other.code &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GGetMyProfileData_me__asAuthErrorResult')
          ..add('G__typename', G__typename)
          ..add('code', code)
          ..add('message', message))
        .toString();
  }
}

class GGetMyProfileData_me__asAuthErrorResultBuilder
    implements
        Builder<GGetMyProfileData_me__asAuthErrorResult,
            GGetMyProfileData_me__asAuthErrorResultBuilder> {
  _$GGetMyProfileData_me__asAuthErrorResult? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  _i3.GAuthErrorCode? _code;
  _i3.GAuthErrorCode? get code => _$this._code;
  set code(_i3.GAuthErrorCode? code) => _$this._code = code;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  GGetMyProfileData_me__asAuthErrorResultBuilder() {
    GGetMyProfileData_me__asAuthErrorResult._initializeBuilder(this);
  }

  GGetMyProfileData_me__asAuthErrorResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _code = $v.code;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetMyProfileData_me__asAuthErrorResult other) {
    _$v = other as _$GGetMyProfileData_me__asAuthErrorResult;
  }

  @override
  void update(
      void Function(GGetMyProfileData_me__asAuthErrorResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetMyProfileData_me__asAuthErrorResult build() => _build();

  _$GGetMyProfileData_me__asAuthErrorResult _build() {
    final _$result = _$v ??
        _$GGetMyProfileData_me__asAuthErrorResult._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GGetMyProfileData_me__asAuthErrorResult', 'G__typename'),
          code: code,
          message: message,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
