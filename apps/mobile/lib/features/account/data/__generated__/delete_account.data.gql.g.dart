// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_account.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GDeleteAccountData> _$gDeleteAccountDataSerializer =
    _$GDeleteAccountDataSerializer();
Serializer<GDeleteAccountData_deleteAccount__base>
    _$gDeleteAccountDataDeleteAccountBaseSerializer =
    _$GDeleteAccountData_deleteAccount__baseSerializer();
Serializer<GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess>
    _$gDeleteAccountDataDeleteAccountAsMutationDeleteAccountSuccessSerializer =
    _$GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccessSerializer();
Serializer<
        GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data>
    _$gDeleteAccountDataDeleteAccountAsMutationDeleteAccountSuccessDataSerializer =
    _$GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_dataSerializer();
Serializer<GDeleteAccountData_deleteAccount__asAuthError>
    _$gDeleteAccountDataDeleteAccountAsAuthErrorSerializer =
    _$GDeleteAccountData_deleteAccount__asAuthErrorSerializer();

class _$GDeleteAccountDataSerializer
    implements StructuredSerializer<GDeleteAccountData> {
  @override
  final Iterable<Type> types = const [GDeleteAccountData, _$GDeleteAccountData];
  @override
  final String wireName = 'GDeleteAccountData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GDeleteAccountData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.deleteAccount;
    if (value != null) {
      result
        ..add('deleteAccount')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GDeleteAccountData_deleteAccount)));
    }
    return result;
  }

  @override
  GDeleteAccountData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GDeleteAccountDataBuilder();

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
        case 'deleteAccount':
          result.deleteAccount = serializers.deserialize(value,
                  specifiedType:
                      const FullType(GDeleteAccountData_deleteAccount))
              as GDeleteAccountData_deleteAccount?;
          break;
      }
    }

    return result.build();
  }
}

class _$GDeleteAccountData_deleteAccount__baseSerializer
    implements StructuredSerializer<GDeleteAccountData_deleteAccount__base> {
  @override
  final Iterable<Type> types = const [
    GDeleteAccountData_deleteAccount__base,
    _$GDeleteAccountData_deleteAccount__base
  ];
  @override
  final String wireName = 'GDeleteAccountData_deleteAccount__base';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GDeleteAccountData_deleteAccount__base object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GDeleteAccountData_deleteAccount__base deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GDeleteAccountData_deleteAccount__baseBuilder();

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

class _$GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccessSerializer
    implements
        StructuredSerializer<
            GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess> {
  @override
  final Iterable<Type> types = const [
    GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess,
    _$GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess
  ];
  @override
  final String wireName =
      'GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data)),
    ];

    return result;
  }

  @override
  GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccessBuilder();

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
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data))!
              as GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data);
          break;
      }
    }

    return result.build();
  }
}

class _$GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_dataSerializer
    implements
        StructuredSerializer<
            GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data> {
  @override
  final Iterable<Type> types = const [
    GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data,
    _$GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data
  ];
  @override
  final String wireName =
      'GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data';

  @override
  Iterable<Object?> serialize(
      Serializers serializers,
      GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data
          object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.success;
    if (value != null) {
      result
        ..add('success')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data
      deserialize(Serializers serializers, Iterable<Object?> serialized,
          {FullType specifiedType = FullType.unspecified}) {
    final result =
        GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_dataBuilder();

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
        case 'success':
          result.success = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
      }
    }

    return result.build();
  }
}

class _$GDeleteAccountData_deleteAccount__asAuthErrorSerializer
    implements
        StructuredSerializer<GDeleteAccountData_deleteAccount__asAuthError> {
  @override
  final Iterable<Type> types = const [
    GDeleteAccountData_deleteAccount__asAuthError,
    _$GDeleteAccountData_deleteAccount__asAuthError
  ];
  @override
  final String wireName = 'GDeleteAccountData_deleteAccount__asAuthError';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GDeleteAccountData_deleteAccount__asAuthError object,
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
  GDeleteAccountData_deleteAccount__asAuthError deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GDeleteAccountData_deleteAccount__asAuthErrorBuilder();

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

class _$GDeleteAccountData extends GDeleteAccountData {
  @override
  final String G__typename;
  @override
  final GDeleteAccountData_deleteAccount? deleteAccount;

  factory _$GDeleteAccountData(
          [void Function(GDeleteAccountDataBuilder)? updates]) =>
      (GDeleteAccountDataBuilder()..update(updates))._build();

  _$GDeleteAccountData._({required this.G__typename, this.deleteAccount})
      : super._();
  @override
  GDeleteAccountData rebuild(
          void Function(GDeleteAccountDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GDeleteAccountDataBuilder toBuilder() =>
      GDeleteAccountDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GDeleteAccountData &&
        G__typename == other.G__typename &&
        deleteAccount == other.deleteAccount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, deleteAccount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GDeleteAccountData')
          ..add('G__typename', G__typename)
          ..add('deleteAccount', deleteAccount))
        .toString();
  }
}

class GDeleteAccountDataBuilder
    implements Builder<GDeleteAccountData, GDeleteAccountDataBuilder> {
  _$GDeleteAccountData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GDeleteAccountData_deleteAccount? _deleteAccount;
  GDeleteAccountData_deleteAccount? get deleteAccount => _$this._deleteAccount;
  set deleteAccount(GDeleteAccountData_deleteAccount? deleteAccount) =>
      _$this._deleteAccount = deleteAccount;

  GDeleteAccountDataBuilder() {
    GDeleteAccountData._initializeBuilder(this);
  }

  GDeleteAccountDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _deleteAccount = $v.deleteAccount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GDeleteAccountData other) {
    _$v = other as _$GDeleteAccountData;
  }

  @override
  void update(void Function(GDeleteAccountDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GDeleteAccountData build() => _build();

  _$GDeleteAccountData _build() {
    final _$result = _$v ??
        _$GDeleteAccountData._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GDeleteAccountData', 'G__typename'),
          deleteAccount: deleteAccount,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GDeleteAccountData_deleteAccount__base
    extends GDeleteAccountData_deleteAccount__base {
  @override
  final String G__typename;

  factory _$GDeleteAccountData_deleteAccount__base(
          [void Function(GDeleteAccountData_deleteAccount__baseBuilder)?
              updates]) =>
      (GDeleteAccountData_deleteAccount__baseBuilder()..update(updates))
          ._build();

  _$GDeleteAccountData_deleteAccount__base._({required this.G__typename})
      : super._();
  @override
  GDeleteAccountData_deleteAccount__base rebuild(
          void Function(GDeleteAccountData_deleteAccount__baseBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GDeleteAccountData_deleteAccount__baseBuilder toBuilder() =>
      GDeleteAccountData_deleteAccount__baseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GDeleteAccountData_deleteAccount__base &&
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
    return (newBuiltValueToStringHelper(
            r'GDeleteAccountData_deleteAccount__base')
          ..add('G__typename', G__typename))
        .toString();
  }
}

class GDeleteAccountData_deleteAccount__baseBuilder
    implements
        Builder<GDeleteAccountData_deleteAccount__base,
            GDeleteAccountData_deleteAccount__baseBuilder> {
  _$GDeleteAccountData_deleteAccount__base? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GDeleteAccountData_deleteAccount__baseBuilder() {
    GDeleteAccountData_deleteAccount__base._initializeBuilder(this);
  }

  GDeleteAccountData_deleteAccount__baseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GDeleteAccountData_deleteAccount__base other) {
    _$v = other as _$GDeleteAccountData_deleteAccount__base;
  }

  @override
  void update(
      void Function(GDeleteAccountData_deleteAccount__baseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GDeleteAccountData_deleteAccount__base build() => _build();

  _$GDeleteAccountData_deleteAccount__base _build() {
    final _$result = _$v ??
        _$GDeleteAccountData_deleteAccount__base._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GDeleteAccountData_deleteAccount__base', 'G__typename'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess
    extends GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess {
  @override
  final String G__typename;
  @override
  final GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data
      data;

  factory _$GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess(
          [void Function(
                  GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccessBuilder)?
              updates]) =>
      (GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccessBuilder()
            ..update(updates))
          ._build();

  _$GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess._(
      {required this.G__typename, required this.data})
      : super._();
  @override
  GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess rebuild(
          void Function(
                  GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccessBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccessBuilder
      toBuilder() =>
          GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccessBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess &&
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
            r'GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess')
          ..add('G__typename', G__typename)
          ..add('data', data))
        .toString();
  }
}

class GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccessBuilder
    implements
        Builder<
            GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess,
            GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccessBuilder> {
  _$GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_dataBuilder?
      _data;
  GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_dataBuilder
      get data => _$this._data ??=
          GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_dataBuilder();
  set data(
          GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_dataBuilder?
              data) =>
      _$this._data = data;

  GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccessBuilder() {
    GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess
        ._initializeBuilder(this);
  }

  GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccessBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess other) {
    _$v = other
        as _$GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess;
  }

  @override
  void update(
      void Function(
              GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccessBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess build() =>
      _build();

  _$GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess _build() {
    _$GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess _$result;
    try {
      _$result = _$v ??
          _$GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess',
                'G__typename'),
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data
    extends GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data {
  @override
  final String G__typename;
  @override
  final bool? success;

  factory _$GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data(
          [void Function(
                  GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_dataBuilder)?
              updates]) =>
      (GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_dataBuilder()
            ..update(updates))
          ._build();

  _$GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data._(
      {required this.G__typename, this.success})
      : super._();
  @override
  GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data rebuild(
          void Function(
                  GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_dataBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_dataBuilder
      toBuilder() =>
          GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_dataBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data &&
        G__typename == other.G__typename &&
        success == other.success;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, success.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data')
          ..add('G__typename', G__typename)
          ..add('success', success))
        .toString();
  }
}

class GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_dataBuilder
    implements
        Builder<
            GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data,
            GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_dataBuilder> {
  _$GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_dataBuilder() {
    GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data
        ._initializeBuilder(this);
  }

  GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_dataBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _success = $v.success;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data
          other) {
    _$v = other
        as _$GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data;
  }

  @override
  void update(
      void Function(
              GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_dataBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data
      build() => _build();

  _$GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data
      _build() {
    final _$result = _$v ??
        _$GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data
            ._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GDeleteAccountData_deleteAccount__asMutationDeleteAccountSuccess_data',
              'G__typename'),
          success: success,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GDeleteAccountData_deleteAccount__asAuthError
    extends GDeleteAccountData_deleteAccount__asAuthError {
  @override
  final String G__typename;
  @override
  final _i3.GAuthErrorCode? code;
  @override
  final String? message;

  factory _$GDeleteAccountData_deleteAccount__asAuthError(
          [void Function(GDeleteAccountData_deleteAccount__asAuthErrorBuilder)?
              updates]) =>
      (GDeleteAccountData_deleteAccount__asAuthErrorBuilder()..update(updates))
          ._build();

  _$GDeleteAccountData_deleteAccount__asAuthError._(
      {required this.G__typename, this.code, this.message})
      : super._();
  @override
  GDeleteAccountData_deleteAccount__asAuthError rebuild(
          void Function(GDeleteAccountData_deleteAccount__asAuthErrorBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GDeleteAccountData_deleteAccount__asAuthErrorBuilder toBuilder() =>
      GDeleteAccountData_deleteAccount__asAuthErrorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GDeleteAccountData_deleteAccount__asAuthError &&
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
            r'GDeleteAccountData_deleteAccount__asAuthError')
          ..add('G__typename', G__typename)
          ..add('code', code)
          ..add('message', message))
        .toString();
  }
}

class GDeleteAccountData_deleteAccount__asAuthErrorBuilder
    implements
        Builder<GDeleteAccountData_deleteAccount__asAuthError,
            GDeleteAccountData_deleteAccount__asAuthErrorBuilder> {
  _$GDeleteAccountData_deleteAccount__asAuthError? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  _i3.GAuthErrorCode? _code;
  _i3.GAuthErrorCode? get code => _$this._code;
  set code(_i3.GAuthErrorCode? code) => _$this._code = code;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  GDeleteAccountData_deleteAccount__asAuthErrorBuilder() {
    GDeleteAccountData_deleteAccount__asAuthError._initializeBuilder(this);
  }

  GDeleteAccountData_deleteAccount__asAuthErrorBuilder get _$this {
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
  void replace(GDeleteAccountData_deleteAccount__asAuthError other) {
    _$v = other as _$GDeleteAccountData_deleteAccount__asAuthError;
  }

  @override
  void update(
      void Function(GDeleteAccountData_deleteAccount__asAuthErrorBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GDeleteAccountData_deleteAccount__asAuthError build() => _build();

  _$GDeleteAccountData_deleteAccount__asAuthError _build() {
    final _$result = _$v ??
        _$GDeleteAccountData_deleteAccount__asAuthError._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GDeleteAccountData_deleteAccount__asAuthError', 'G__typename'),
          code: code,
          message: message,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
