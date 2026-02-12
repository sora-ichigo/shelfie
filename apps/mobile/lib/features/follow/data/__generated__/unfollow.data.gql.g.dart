// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unfollow.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GUnfollowData> _$gUnfollowDataSerializer =
    _$GUnfollowDataSerializer();
Serializer<GUnfollowData_unfollow__base> _$gUnfollowDataUnfollowBaseSerializer =
    _$GUnfollowData_unfollow__baseSerializer();
Serializer<GUnfollowData_unfollow__asMutationUnfollowSuccess>
    _$gUnfollowDataUnfollowAsMutationUnfollowSuccessSerializer =
    _$GUnfollowData_unfollow__asMutationUnfollowSuccessSerializer();
Serializer<GUnfollowData_unfollow__asValidationError>
    _$gUnfollowDataUnfollowAsValidationErrorSerializer =
    _$GUnfollowData_unfollow__asValidationErrorSerializer();

class _$GUnfollowDataSerializer implements StructuredSerializer<GUnfollowData> {
  @override
  final Iterable<Type> types = const [GUnfollowData, _$GUnfollowData];
  @override
  final String wireName = 'GUnfollowData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GUnfollowData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.unfollow;
    if (value != null) {
      result
        ..add('unfollow')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GUnfollowData_unfollow)));
    }
    return result;
  }

  @override
  GUnfollowData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUnfollowDataBuilder();

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
        case 'unfollow':
          result.unfollow = serializers.deserialize(value,
                  specifiedType: const FullType(GUnfollowData_unfollow))
              as GUnfollowData_unfollow?;
          break;
      }
    }

    return result.build();
  }
}

class _$GUnfollowData_unfollow__baseSerializer
    implements StructuredSerializer<GUnfollowData_unfollow__base> {
  @override
  final Iterable<Type> types = const [
    GUnfollowData_unfollow__base,
    _$GUnfollowData_unfollow__base
  ];
  @override
  final String wireName = 'GUnfollowData_unfollow__base';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUnfollowData_unfollow__base object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GUnfollowData_unfollow__base deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUnfollowData_unfollow__baseBuilder();

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

class _$GUnfollowData_unfollow__asMutationUnfollowSuccessSerializer
    implements
        StructuredSerializer<
            GUnfollowData_unfollow__asMutationUnfollowSuccess> {
  @override
  final Iterable<Type> types = const [
    GUnfollowData_unfollow__asMutationUnfollowSuccess,
    _$GUnfollowData_unfollow__asMutationUnfollowSuccess
  ];
  @override
  final String wireName = 'GUnfollowData_unfollow__asMutationUnfollowSuccess';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GUnfollowData_unfollow__asMutationUnfollowSuccess object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'data',
      serializers.serialize(object.data, specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  GUnfollowData_unfollow__asMutationUnfollowSuccess deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUnfollowData_unfollow__asMutationUnfollowSuccessBuilder();

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
        case 'data':
          result.data = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GUnfollowData_unfollow__asValidationErrorSerializer
    implements StructuredSerializer<GUnfollowData_unfollow__asValidationError> {
  @override
  final Iterable<Type> types = const [
    GUnfollowData_unfollow__asValidationError,
    _$GUnfollowData_unfollow__asValidationError
  ];
  @override
  final String wireName = 'GUnfollowData_unfollow__asValidationError';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUnfollowData_unfollow__asValidationError object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.message;
    if (value != null) {
      result
        ..add('message')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.code;
    if (value != null) {
      result
        ..add('code')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GUnfollowData_unfollow__asValidationError deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUnfollowData_unfollow__asValidationErrorBuilder();

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
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'code':
          result.code = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GUnfollowData extends GUnfollowData {
  @override
  final String G__typename;
  @override
  final GUnfollowData_unfollow? unfollow;

  factory _$GUnfollowData([void Function(GUnfollowDataBuilder)? updates]) =>
      (GUnfollowDataBuilder()..update(updates))._build();

  _$GUnfollowData._({required this.G__typename, this.unfollow}) : super._();
  @override
  GUnfollowData rebuild(void Function(GUnfollowDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUnfollowDataBuilder toBuilder() => GUnfollowDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUnfollowData &&
        G__typename == other.G__typename &&
        unfollow == other.unfollow;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, unfollow.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUnfollowData')
          ..add('G__typename', G__typename)
          ..add('unfollow', unfollow))
        .toString();
  }
}

class GUnfollowDataBuilder
    implements Builder<GUnfollowData, GUnfollowDataBuilder> {
  _$GUnfollowData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GUnfollowData_unfollow? _unfollow;
  GUnfollowData_unfollow? get unfollow => _$this._unfollow;
  set unfollow(GUnfollowData_unfollow? unfollow) => _$this._unfollow = unfollow;

  GUnfollowDataBuilder() {
    GUnfollowData._initializeBuilder(this);
  }

  GUnfollowDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _unfollow = $v.unfollow;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUnfollowData other) {
    _$v = other as _$GUnfollowData;
  }

  @override
  void update(void Function(GUnfollowDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUnfollowData build() => _build();

  _$GUnfollowData _build() {
    final _$result = _$v ??
        _$GUnfollowData._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GUnfollowData', 'G__typename'),
          unfollow: unfollow,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GUnfollowData_unfollow__base extends GUnfollowData_unfollow__base {
  @override
  final String G__typename;

  factory _$GUnfollowData_unfollow__base(
          [void Function(GUnfollowData_unfollow__baseBuilder)? updates]) =>
      (GUnfollowData_unfollow__baseBuilder()..update(updates))._build();

  _$GUnfollowData_unfollow__base._({required this.G__typename}) : super._();
  @override
  GUnfollowData_unfollow__base rebuild(
          void Function(GUnfollowData_unfollow__baseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUnfollowData_unfollow__baseBuilder toBuilder() =>
      GUnfollowData_unfollow__baseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUnfollowData_unfollow__base &&
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
    return (newBuiltValueToStringHelper(r'GUnfollowData_unfollow__base')
          ..add('G__typename', G__typename))
        .toString();
  }
}

class GUnfollowData_unfollow__baseBuilder
    implements
        Builder<GUnfollowData_unfollow__base,
            GUnfollowData_unfollow__baseBuilder> {
  _$GUnfollowData_unfollow__base? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GUnfollowData_unfollow__baseBuilder() {
    GUnfollowData_unfollow__base._initializeBuilder(this);
  }

  GUnfollowData_unfollow__baseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUnfollowData_unfollow__base other) {
    _$v = other as _$GUnfollowData_unfollow__base;
  }

  @override
  void update(void Function(GUnfollowData_unfollow__baseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUnfollowData_unfollow__base build() => _build();

  _$GUnfollowData_unfollow__base _build() {
    final _$result = _$v ??
        _$GUnfollowData_unfollow__base._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GUnfollowData_unfollow__base', 'G__typename'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GUnfollowData_unfollow__asMutationUnfollowSuccess
    extends GUnfollowData_unfollow__asMutationUnfollowSuccess {
  @override
  final String G__typename;
  @override
  final bool data;

  factory _$GUnfollowData_unfollow__asMutationUnfollowSuccess(
          [void Function(
                  GUnfollowData_unfollow__asMutationUnfollowSuccessBuilder)?
              updates]) =>
      (GUnfollowData_unfollow__asMutationUnfollowSuccessBuilder()
            ..update(updates))
          ._build();

  _$GUnfollowData_unfollow__asMutationUnfollowSuccess._(
      {required this.G__typename, required this.data})
      : super._();
  @override
  GUnfollowData_unfollow__asMutationUnfollowSuccess rebuild(
          void Function(
                  GUnfollowData_unfollow__asMutationUnfollowSuccessBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUnfollowData_unfollow__asMutationUnfollowSuccessBuilder toBuilder() =>
      GUnfollowData_unfollow__asMutationUnfollowSuccessBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUnfollowData_unfollow__asMutationUnfollowSuccess &&
        G__typename == other.G__typename &&
        data == other.data;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GUnfollowData_unfollow__asMutationUnfollowSuccess')
          ..add('G__typename', G__typename)
          ..add('data', data))
        .toString();
  }
}

class GUnfollowData_unfollow__asMutationUnfollowSuccessBuilder
    implements
        Builder<GUnfollowData_unfollow__asMutationUnfollowSuccess,
            GUnfollowData_unfollow__asMutationUnfollowSuccessBuilder> {
  _$GUnfollowData_unfollow__asMutationUnfollowSuccess? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  bool? _data;
  bool? get data => _$this._data;
  set data(bool? data) => _$this._data = data;

  GUnfollowData_unfollow__asMutationUnfollowSuccessBuilder() {
    GUnfollowData_unfollow__asMutationUnfollowSuccess._initializeBuilder(this);
  }

  GUnfollowData_unfollow__asMutationUnfollowSuccessBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _data = $v.data;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUnfollowData_unfollow__asMutationUnfollowSuccess other) {
    _$v = other as _$GUnfollowData_unfollow__asMutationUnfollowSuccess;
  }

  @override
  void update(
      void Function(GUnfollowData_unfollow__asMutationUnfollowSuccessBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GUnfollowData_unfollow__asMutationUnfollowSuccess build() => _build();

  _$GUnfollowData_unfollow__asMutationUnfollowSuccess _build() {
    final _$result = _$v ??
        _$GUnfollowData_unfollow__asMutationUnfollowSuccess._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GUnfollowData_unfollow__asMutationUnfollowSuccess',
              'G__typename'),
          data: BuiltValueNullFieldError.checkNotNull(data,
              r'GUnfollowData_unfollow__asMutationUnfollowSuccess', 'data'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GUnfollowData_unfollow__asValidationError
    extends GUnfollowData_unfollow__asValidationError {
  @override
  final String G__typename;
  @override
  final String? message;
  @override
  final String? code;

  factory _$GUnfollowData_unfollow__asValidationError(
          [void Function(GUnfollowData_unfollow__asValidationErrorBuilder)?
              updates]) =>
      (GUnfollowData_unfollow__asValidationErrorBuilder()..update(updates))
          ._build();

  _$GUnfollowData_unfollow__asValidationError._(
      {required this.G__typename, this.message, this.code})
      : super._();
  @override
  GUnfollowData_unfollow__asValidationError rebuild(
          void Function(GUnfollowData_unfollow__asValidationErrorBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUnfollowData_unfollow__asValidationErrorBuilder toBuilder() =>
      GUnfollowData_unfollow__asValidationErrorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUnfollowData_unfollow__asValidationError &&
        G__typename == other.G__typename &&
        message == other.message &&
        code == other.code;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GUnfollowData_unfollow__asValidationError')
          ..add('G__typename', G__typename)
          ..add('message', message)
          ..add('code', code))
        .toString();
  }
}

class GUnfollowData_unfollow__asValidationErrorBuilder
    implements
        Builder<GUnfollowData_unfollow__asValidationError,
            GUnfollowData_unfollow__asValidationErrorBuilder> {
  _$GUnfollowData_unfollow__asValidationError? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  GUnfollowData_unfollow__asValidationErrorBuilder() {
    GUnfollowData_unfollow__asValidationError._initializeBuilder(this);
  }

  GUnfollowData_unfollow__asValidationErrorBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _message = $v.message;
      _code = $v.code;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUnfollowData_unfollow__asValidationError other) {
    _$v = other as _$GUnfollowData_unfollow__asValidationError;
  }

  @override
  void update(
      void Function(GUnfollowData_unfollow__asValidationErrorBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GUnfollowData_unfollow__asValidationError build() => _build();

  _$GUnfollowData_unfollow__asValidationError _build() {
    final _$result = _$v ??
        _$GUnfollowData_unfollow__asValidationError._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GUnfollowData_unfollow__asValidationError', 'G__typename'),
          message: message,
          code: code,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
