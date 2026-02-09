// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'me.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GGetMeData> _$gGetMeDataSerializer = _$GGetMeDataSerializer();
Serializer<GGetMeData_me__base> _$gGetMeDataMeBaseSerializer =
    _$GGetMeData_me__baseSerializer();
Serializer<GGetMeData_me__asUser> _$gGetMeDataMeAsUserSerializer =
    _$GGetMeData_me__asUserSerializer();
Serializer<GGetMeData_me__asAuthErrorResult>
_$gGetMeDataMeAsAuthErrorResultSerializer =
    _$GGetMeData_me__asAuthErrorResultSerializer();

class _$GGetMeDataSerializer implements StructuredSerializer<GGetMeData> {
  @override
  final Iterable<Type> types = const [GGetMeData, _$GGetMeData];
  @override
  final String wireName = 'GGetMeData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetMeData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'me',
      serializers.serialize(
        object.me,
        specifiedType: const FullType(GGetMeData_me),
      ),
    ];

    return result;
  }

  @override
  GGetMeData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetMeDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'me':
          result.me =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(GGetMeData_me),
                  )!
                  as GGetMeData_me;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetMeData_me__baseSerializer
    implements StructuredSerializer<GGetMeData_me__base> {
  @override
  final Iterable<Type> types = const [
    GGetMeData_me__base,
    _$GGetMeData_me__base,
  ];
  @override
  final String wireName = 'GGetMeData_me__base';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetMeData_me__base object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
    ];

    return result;
  }

  @override
  GGetMeData_me__base deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetMeData_me__baseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetMeData_me__asUserSerializer
    implements StructuredSerializer<GGetMeData_me__asUser> {
  @override
  final Iterable<Type> types = const [
    GGetMeData_me__asUser,
    _$GGetMeData_me__asUser,
  ];
  @override
  final String wireName = 'GGetMeData_me__asUser';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetMeData_me__asUser object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
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
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  GGetMeData_me__asUser deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetMeData_me__asUserBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'id':
          result.id =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'email':
          result.email =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetMeData_me__asAuthErrorResultSerializer
    implements StructuredSerializer<GGetMeData_me__asAuthErrorResult> {
  @override
  final Iterable<Type> types = const [
    GGetMeData_me__asAuthErrorResult,
    _$GGetMeData_me__asAuthErrorResult,
  ];
  @override
  final String wireName = 'GGetMeData_me__asAuthErrorResult';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetMeData_me__asAuthErrorResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
    ];
    Object? value;
    value = object.code;
    if (value != null) {
      result
        ..add('code')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(_i3.GAuthErrorCode),
          ),
        );
    }
    value = object.message;
    if (value != null) {
      result
        ..add('message')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  GGetMeData_me__asAuthErrorResult deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetMeData_me__asAuthErrorResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'code':
          result.code =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(_i3.GAuthErrorCode),
                  )
                  as _i3.GAuthErrorCode?;
          break;
        case 'message':
          result.message =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetMeData extends GGetMeData {
  @override
  final String G__typename;
  @override
  final GGetMeData_me me;

  factory _$GGetMeData([void Function(GGetMeDataBuilder)? updates]) =>
      (GGetMeDataBuilder()..update(updates))._build();

  _$GGetMeData._({required this.G__typename, required this.me}) : super._();
  @override
  GGetMeData rebuild(void Function(GGetMeDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetMeDataBuilder toBuilder() => GGetMeDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetMeData &&
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
    return (newBuiltValueToStringHelper(r'GGetMeData')
          ..add('G__typename', G__typename)
          ..add('me', me))
        .toString();
  }
}

class GGetMeDataBuilder implements Builder<GGetMeData, GGetMeDataBuilder> {
  _$GGetMeData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GGetMeData_me? _me;
  GGetMeData_me? get me => _$this._me;
  set me(GGetMeData_me? me) => _$this._me = me;

  GGetMeDataBuilder() {
    GGetMeData._initializeBuilder(this);
  }

  GGetMeDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _me = $v.me;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetMeData other) {
    _$v = other as _$GGetMeData;
  }

  @override
  void update(void Function(GGetMeDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetMeData build() => _build();

  _$GGetMeData _build() {
    final _$result =
        _$v ??
        _$GGetMeData._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GGetMeData',
            'G__typename',
          ),
          me: BuiltValueNullFieldError.checkNotNull(me, r'GGetMeData', 'me'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GGetMeData_me__base extends GGetMeData_me__base {
  @override
  final String G__typename;

  factory _$GGetMeData_me__base([
    void Function(GGetMeData_me__baseBuilder)? updates,
  ]) => (GGetMeData_me__baseBuilder()..update(updates))._build();

  _$GGetMeData_me__base._({required this.G__typename}) : super._();
  @override
  GGetMeData_me__base rebuild(
    void Function(GGetMeData_me__baseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetMeData_me__baseBuilder toBuilder() =>
      GGetMeData_me__baseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetMeData_me__base && G__typename == other.G__typename;
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
    return (newBuiltValueToStringHelper(
      r'GGetMeData_me__base',
    )..add('G__typename', G__typename)).toString();
  }
}

class GGetMeData_me__baseBuilder
    implements Builder<GGetMeData_me__base, GGetMeData_me__baseBuilder> {
  _$GGetMeData_me__base? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GGetMeData_me__baseBuilder() {
    GGetMeData_me__base._initializeBuilder(this);
  }

  GGetMeData_me__baseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetMeData_me__base other) {
    _$v = other as _$GGetMeData_me__base;
  }

  @override
  void update(void Function(GGetMeData_me__baseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetMeData_me__base build() => _build();

  _$GGetMeData_me__base _build() {
    final _$result =
        _$v ??
        _$GGetMeData_me__base._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GGetMeData_me__base',
            'G__typename',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GGetMeData_me__asUser extends GGetMeData_me__asUser {
  @override
  final String G__typename;
  @override
  final int? id;
  @override
  final String? email;

  factory _$GGetMeData_me__asUser([
    void Function(GGetMeData_me__asUserBuilder)? updates,
  ]) => (GGetMeData_me__asUserBuilder()..update(updates))._build();

  _$GGetMeData_me__asUser._({required this.G__typename, this.id, this.email})
    : super._();
  @override
  GGetMeData_me__asUser rebuild(
    void Function(GGetMeData_me__asUserBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetMeData_me__asUserBuilder toBuilder() =>
      GGetMeData_me__asUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetMeData_me__asUser &&
        G__typename == other.G__typename &&
        id == other.id &&
        email == other.email;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetMeData_me__asUser')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('email', email))
        .toString();
  }
}

class GGetMeData_me__asUserBuilder
    implements Builder<GGetMeData_me__asUser, GGetMeData_me__asUserBuilder> {
  _$GGetMeData_me__asUser? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  GGetMeData_me__asUserBuilder() {
    GGetMeData_me__asUser._initializeBuilder(this);
  }

  GGetMeData_me__asUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetMeData_me__asUser other) {
    _$v = other as _$GGetMeData_me__asUser;
  }

  @override
  void update(void Function(GGetMeData_me__asUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetMeData_me__asUser build() => _build();

  _$GGetMeData_me__asUser _build() {
    final _$result =
        _$v ??
        _$GGetMeData_me__asUser._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GGetMeData_me__asUser',
            'G__typename',
          ),
          id: id,
          email: email,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GGetMeData_me__asAuthErrorResult
    extends GGetMeData_me__asAuthErrorResult {
  @override
  final String G__typename;
  @override
  final _i3.GAuthErrorCode? code;
  @override
  final String? message;

  factory _$GGetMeData_me__asAuthErrorResult([
    void Function(GGetMeData_me__asAuthErrorResultBuilder)? updates,
  ]) => (GGetMeData_me__asAuthErrorResultBuilder()..update(updates))._build();

  _$GGetMeData_me__asAuthErrorResult._({
    required this.G__typename,
    this.code,
    this.message,
  }) : super._();
  @override
  GGetMeData_me__asAuthErrorResult rebuild(
    void Function(GGetMeData_me__asAuthErrorResultBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetMeData_me__asAuthErrorResultBuilder toBuilder() =>
      GGetMeData_me__asAuthErrorResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetMeData_me__asAuthErrorResult &&
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
    return (newBuiltValueToStringHelper(r'GGetMeData_me__asAuthErrorResult')
          ..add('G__typename', G__typename)
          ..add('code', code)
          ..add('message', message))
        .toString();
  }
}

class GGetMeData_me__asAuthErrorResultBuilder
    implements
        Builder<
          GGetMeData_me__asAuthErrorResult,
          GGetMeData_me__asAuthErrorResultBuilder
        > {
  _$GGetMeData_me__asAuthErrorResult? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  _i3.GAuthErrorCode? _code;
  _i3.GAuthErrorCode? get code => _$this._code;
  set code(_i3.GAuthErrorCode? code) => _$this._code = code;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  GGetMeData_me__asAuthErrorResultBuilder() {
    GGetMeData_me__asAuthErrorResult._initializeBuilder(this);
  }

  GGetMeData_me__asAuthErrorResultBuilder get _$this {
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
  void replace(GGetMeData_me__asAuthErrorResult other) {
    _$v = other as _$GGetMeData_me__asAuthErrorResult;
  }

  @override
  void update(void Function(GGetMeData_me__asAuthErrorResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetMeData_me__asAuthErrorResult build() => _build();

  _$GGetMeData_me__asAuthErrorResult _build() {
    final _$result =
        _$v ??
        _$GGetMeData_me__asAuthErrorResult._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GGetMeData_me__asAuthErrorResult',
            'G__typename',
          ),
          code: code,
          message: message,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
