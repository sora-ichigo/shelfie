// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_email_change.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GRequestEmailChangeData> _$gRequestEmailChangeDataSerializer =
    new _$GRequestEmailChangeDataSerializer();
Serializer<GRequestEmailChangeData_requestEmailChange__base>
    _$gRequestEmailChangeDataRequestEmailChangeBaseSerializer =
    new _$GRequestEmailChangeData_requestEmailChange__baseSerializer();
Serializer<
        GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess>
    _$gRequestEmailChangeDataRequestEmailChangeAsMutationRequestEmailChangeSuccessSerializer =
    new _$GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccessSerializer();
Serializer<
        GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data>
    _$gRequestEmailChangeDataRequestEmailChangeAsMutationRequestEmailChangeSuccessDataSerializer =
    new _$GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_dataSerializer();
Serializer<GRequestEmailChangeData_requestEmailChange__asValidationError>
    _$gRequestEmailChangeDataRequestEmailChangeAsValidationErrorSerializer =
    new _$GRequestEmailChangeData_requestEmailChange__asValidationErrorSerializer();

class _$GRequestEmailChangeDataSerializer
    implements StructuredSerializer<GRequestEmailChangeData> {
  @override
  final Iterable<Type> types = const [
    GRequestEmailChangeData,
    _$GRequestEmailChangeData
  ];
  @override
  final String wireName = 'GRequestEmailChangeData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GRequestEmailChangeData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.requestEmailChange;
    if (value != null) {
      result
        ..add('requestEmailChange')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(GRequestEmailChangeData_requestEmailChange)));
    }
    return result;
  }

  @override
  GRequestEmailChangeData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GRequestEmailChangeDataBuilder();

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
        case 'requestEmailChange':
          result.requestEmailChange = serializers.deserialize(value,
                  specifiedType: const FullType(
                      GRequestEmailChangeData_requestEmailChange))
              as GRequestEmailChangeData_requestEmailChange?;
          break;
      }
    }

    return result.build();
  }
}

class _$GRequestEmailChangeData_requestEmailChange__baseSerializer
    implements
        StructuredSerializer<GRequestEmailChangeData_requestEmailChange__base> {
  @override
  final Iterable<Type> types = const [
    GRequestEmailChangeData_requestEmailChange__base,
    _$GRequestEmailChangeData_requestEmailChange__base
  ];
  @override
  final String wireName = 'GRequestEmailChangeData_requestEmailChange__base';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GRequestEmailChangeData_requestEmailChange__base object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GRequestEmailChangeData_requestEmailChange__base deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GRequestEmailChangeData_requestEmailChange__baseBuilder();

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

class _$GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccessSerializer
    implements
        StructuredSerializer<
            GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess> {
  @override
  final Iterable<Type> types = const [
    GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess,
    _$GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess
  ];
  @override
  final String wireName =
      'GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess';

  @override
  Iterable<Object?> serialize(
      Serializers serializers,
      GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess
          object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data)),
    ];

    return result;
  }

  @override
  GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess
      deserialize(Serializers serializers, Iterable<Object?> serialized,
          {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccessBuilder();

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
                      GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data))!
              as GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data);
          break;
      }
    }

    return result.build();
  }
}

class _$GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_dataSerializer
    implements
        StructuredSerializer<
            GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data> {
  @override
  final Iterable<Type> types = const [
    GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data,
    _$GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data
  ];
  @override
  final String wireName =
      'GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data';

  @override
  Iterable<Object?> serialize(
      Serializers serializers,
      GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data
          object,
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
    return result;
  }

  @override
  GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data
      deserialize(Serializers serializers, Iterable<Object?> serialized,
          {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_dataBuilder();

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
      }
    }

    return result.build();
  }
}

class _$GRequestEmailChangeData_requestEmailChange__asValidationErrorSerializer
    implements
        StructuredSerializer<
            GRequestEmailChangeData_requestEmailChange__asValidationError> {
  @override
  final Iterable<Type> types = const [
    GRequestEmailChangeData_requestEmailChange__asValidationError,
    _$GRequestEmailChangeData_requestEmailChange__asValidationError
  ];
  @override
  final String wireName =
      'GRequestEmailChangeData_requestEmailChange__asValidationError';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GRequestEmailChangeData_requestEmailChange__asValidationError object,
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
            specifiedType: const FullType(String)));
    }
    value = object.message;
    if (value != null) {
      result
        ..add('message')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.field;
    if (value != null) {
      result
        ..add('field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GRequestEmailChangeData_requestEmailChange__asValidationError deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GRequestEmailChangeData_requestEmailChange__asValidationErrorBuilder();

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
              specifiedType: const FullType(String)) as String?;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'field':
          result.field = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GRequestEmailChangeData extends GRequestEmailChangeData {
  @override
  final String G__typename;
  @override
  final GRequestEmailChangeData_requestEmailChange? requestEmailChange;

  factory _$GRequestEmailChangeData(
          [void Function(GRequestEmailChangeDataBuilder)? updates]) =>
      (new GRequestEmailChangeDataBuilder()..update(updates))._build();

  _$GRequestEmailChangeData._(
      {required this.G__typename, this.requestEmailChange})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GRequestEmailChangeData', 'G__typename');
  }

  @override
  GRequestEmailChangeData rebuild(
          void Function(GRequestEmailChangeDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRequestEmailChangeDataBuilder toBuilder() =>
      new GRequestEmailChangeDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRequestEmailChangeData &&
        G__typename == other.G__typename &&
        requestEmailChange == other.requestEmailChange;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, requestEmailChange.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GRequestEmailChangeData')
          ..add('G__typename', G__typename)
          ..add('requestEmailChange', requestEmailChange))
        .toString();
  }
}

class GRequestEmailChangeDataBuilder
    implements
        Builder<GRequestEmailChangeData, GRequestEmailChangeDataBuilder> {
  _$GRequestEmailChangeData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GRequestEmailChangeData_requestEmailChange? _requestEmailChange;
  GRequestEmailChangeData_requestEmailChange? get requestEmailChange =>
      _$this._requestEmailChange;
  set requestEmailChange(
          GRequestEmailChangeData_requestEmailChange? requestEmailChange) =>
      _$this._requestEmailChange = requestEmailChange;

  GRequestEmailChangeDataBuilder() {
    GRequestEmailChangeData._initializeBuilder(this);
  }

  GRequestEmailChangeDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _requestEmailChange = $v.requestEmailChange;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRequestEmailChangeData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GRequestEmailChangeData;
  }

  @override
  void update(void Function(GRequestEmailChangeDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRequestEmailChangeData build() => _build();

  _$GRequestEmailChangeData _build() {
    final _$result = _$v ??
        new _$GRequestEmailChangeData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GRequestEmailChangeData', 'G__typename'),
            requestEmailChange: requestEmailChange);
    replace(_$result);
    return _$result;
  }
}

class _$GRequestEmailChangeData_requestEmailChange__base
    extends GRequestEmailChangeData_requestEmailChange__base {
  @override
  final String G__typename;

  factory _$GRequestEmailChangeData_requestEmailChange__base(
          [void Function(
                  GRequestEmailChangeData_requestEmailChange__baseBuilder)?
              updates]) =>
      (new GRequestEmailChangeData_requestEmailChange__baseBuilder()
            ..update(updates))
          ._build();

  _$GRequestEmailChangeData_requestEmailChange__base._(
      {required this.G__typename})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(G__typename,
        r'GRequestEmailChangeData_requestEmailChange__base', 'G__typename');
  }

  @override
  GRequestEmailChangeData_requestEmailChange__base rebuild(
          void Function(GRequestEmailChangeData_requestEmailChange__baseBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRequestEmailChangeData_requestEmailChange__baseBuilder toBuilder() =>
      new GRequestEmailChangeData_requestEmailChange__baseBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRequestEmailChangeData_requestEmailChange__base &&
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
            r'GRequestEmailChangeData_requestEmailChange__base')
          ..add('G__typename', G__typename))
        .toString();
  }
}

class GRequestEmailChangeData_requestEmailChange__baseBuilder
    implements
        Builder<GRequestEmailChangeData_requestEmailChange__base,
            GRequestEmailChangeData_requestEmailChange__baseBuilder> {
  _$GRequestEmailChangeData_requestEmailChange__base? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GRequestEmailChangeData_requestEmailChange__baseBuilder() {
    GRequestEmailChangeData_requestEmailChange__base._initializeBuilder(this);
  }

  GRequestEmailChangeData_requestEmailChange__baseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRequestEmailChangeData_requestEmailChange__base other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GRequestEmailChangeData_requestEmailChange__base;
  }

  @override
  void update(
      void Function(GRequestEmailChangeData_requestEmailChange__baseBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GRequestEmailChangeData_requestEmailChange__base build() => _build();

  _$GRequestEmailChangeData_requestEmailChange__base _build() {
    final _$result = _$v ??
        new _$GRequestEmailChangeData_requestEmailChange__base._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GRequestEmailChangeData_requestEmailChange__base',
                'G__typename'));
    replace(_$result);
    return _$result;
  }
}

class _$GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess
    extends GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess {
  @override
  final String G__typename;
  @override
  final GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data
      data;

  factory _$GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess(
          [void Function(
                  GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccessBuilder)?
              updates]) =>
      (new GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccessBuilder()
            ..update(updates))
          ._build();

  _$GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess._(
      {required this.G__typename, required this.data})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename,
        r'GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess',
        'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        data,
        r'GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess',
        'data');
  }

  @override
  GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess
      rebuild(
              void Function(
                      GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccessBuilder)
                  updates) =>
          (toBuilder()..update(updates)).build();

  @override
  GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccessBuilder
      toBuilder() =>
          new GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccessBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess &&
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
            r'GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess')
          ..add('G__typename', G__typename)
          ..add('data', data))
        .toString();
  }
}

class GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccessBuilder
    implements
        Builder<
            GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess,
            GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccessBuilder> {
  _$GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess?
      _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_dataBuilder?
      _data;
  GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_dataBuilder
      get data => _$this._data ??=
          new GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_dataBuilder();
  set data(
          GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_dataBuilder?
              data) =>
      _$this._data = data;

  GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccessBuilder() {
    GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess
        ._initializeBuilder(this);
  }

  GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccessBuilder
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
      GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess
          other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other
        as _$GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess;
  }

  @override
  void update(
      void Function(
              GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccessBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess
      build() => _build();

  _$GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess
      _build() {
    _$GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess
        _$result;
    try {
      _$result = _$v ??
          new _$GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess
              ._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename,
                  r'GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess',
                  'G__typename'),
              data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data
    extends GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data {
  @override
  final String G__typename;
  @override
  final String? message;

  factory _$GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data(
          [void Function(
                  GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_dataBuilder)?
              updates]) =>
      (new GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_dataBuilder()
            ..update(updates))
          ._build();

  _$GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data._(
      {required this.G__typename, this.message})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename,
        r'GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data',
        'G__typename');
  }

  @override
  GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data
      rebuild(
              void Function(
                      GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_dataBuilder)
                  updates) =>
          (toBuilder()..update(updates)).build();

  @override
  GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_dataBuilder
      toBuilder() =>
          new GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_dataBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data &&
        G__typename == other.G__typename &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data')
          ..add('G__typename', G__typename)
          ..add('message', message))
        .toString();
  }
}

class GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_dataBuilder
    implements
        Builder<
            GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data,
            GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_dataBuilder> {
  _$GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data?
      _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_dataBuilder() {
    GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data
        ._initializeBuilder(this);
  }

  GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_dataBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data
          other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other
        as _$GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data;
  }

  @override
  void update(
      void Function(
              GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_dataBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data
      build() => _build();

  _$GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data
      _build() {
    final _$result = _$v ??
        new _$GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data
            ._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GRequestEmailChangeData_requestEmailChange__asMutationRequestEmailChangeSuccess_data',
                'G__typename'),
            message: message);
    replace(_$result);
    return _$result;
  }
}

class _$GRequestEmailChangeData_requestEmailChange__asValidationError
    extends GRequestEmailChangeData_requestEmailChange__asValidationError {
  @override
  final String G__typename;
  @override
  final String? code;
  @override
  final String? message;
  @override
  final String? field;

  factory _$GRequestEmailChangeData_requestEmailChange__asValidationError(
          [void Function(
                  GRequestEmailChangeData_requestEmailChange__asValidationErrorBuilder)?
              updates]) =>
      (new GRequestEmailChangeData_requestEmailChange__asValidationErrorBuilder()
            ..update(updates))
          ._build();

  _$GRequestEmailChangeData_requestEmailChange__asValidationError._(
      {required this.G__typename, this.code, this.message, this.field})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename,
        r'GRequestEmailChangeData_requestEmailChange__asValidationError',
        'G__typename');
  }

  @override
  GRequestEmailChangeData_requestEmailChange__asValidationError rebuild(
          void Function(
                  GRequestEmailChangeData_requestEmailChange__asValidationErrorBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRequestEmailChangeData_requestEmailChange__asValidationErrorBuilder
      toBuilder() =>
          new GRequestEmailChangeData_requestEmailChange__asValidationErrorBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GRequestEmailChangeData_requestEmailChange__asValidationError &&
        G__typename == other.G__typename &&
        code == other.code &&
        message == other.message &&
        field == other.field;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, field.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GRequestEmailChangeData_requestEmailChange__asValidationError')
          ..add('G__typename', G__typename)
          ..add('code', code)
          ..add('message', message)
          ..add('field', field))
        .toString();
  }
}

class GRequestEmailChangeData_requestEmailChange__asValidationErrorBuilder
    implements
        Builder<GRequestEmailChangeData_requestEmailChange__asValidationError,
            GRequestEmailChangeData_requestEmailChange__asValidationErrorBuilder> {
  _$GRequestEmailChangeData_requestEmailChange__asValidationError? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _field;
  String? get field => _$this._field;
  set field(String? field) => _$this._field = field;

  GRequestEmailChangeData_requestEmailChange__asValidationErrorBuilder() {
    GRequestEmailChangeData_requestEmailChange__asValidationError
        ._initializeBuilder(this);
  }

  GRequestEmailChangeData_requestEmailChange__asValidationErrorBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _code = $v.code;
      _message = $v.message;
      _field = $v.field;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GRequestEmailChangeData_requestEmailChange__asValidationError other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other
        as _$GRequestEmailChangeData_requestEmailChange__asValidationError;
  }

  @override
  void update(
      void Function(
              GRequestEmailChangeData_requestEmailChange__asValidationErrorBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GRequestEmailChangeData_requestEmailChange__asValidationError build() =>
      _build();

  _$GRequestEmailChangeData_requestEmailChange__asValidationError _build() {
    final _$result = _$v ??
        new _$GRequestEmailChangeData_requestEmailChange__asValidationError._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GRequestEmailChangeData_requestEmailChange__asValidationError',
                'G__typename'),
            code: code,
            message: message,
            field: field);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
