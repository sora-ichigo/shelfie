// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_follow_request.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GCancelFollowRequestData> _$gCancelFollowRequestDataSerializer =
    _$GCancelFollowRequestDataSerializer();
Serializer<GCancelFollowRequestData_cancelFollowRequest__base>
    _$gCancelFollowRequestDataCancelFollowRequestBaseSerializer =
    _$GCancelFollowRequestData_cancelFollowRequest__baseSerializer();
Serializer<
        GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess>
    _$gCancelFollowRequestDataCancelFollowRequestAsMutationCancelFollowRequestSuccessSerializer =
    _$GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccessSerializer();
Serializer<GCancelFollowRequestData_cancelFollowRequest__asValidationError>
    _$gCancelFollowRequestDataCancelFollowRequestAsValidationErrorSerializer =
    _$GCancelFollowRequestData_cancelFollowRequest__asValidationErrorSerializer();

class _$GCancelFollowRequestDataSerializer
    implements StructuredSerializer<GCancelFollowRequestData> {
  @override
  final Iterable<Type> types = const [
    GCancelFollowRequestData,
    _$GCancelFollowRequestData
  ];
  @override
  final String wireName = 'GCancelFollowRequestData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCancelFollowRequestData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.cancelFollowRequest;
    if (value != null) {
      result
        ..add('cancelFollowRequest')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(GCancelFollowRequestData_cancelFollowRequest)));
    }
    return result;
  }

  @override
  GCancelFollowRequestData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GCancelFollowRequestDataBuilder();

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
        case 'cancelFollowRequest':
          result.cancelFollowRequest = serializers.deserialize(value,
                  specifiedType: const FullType(
                      GCancelFollowRequestData_cancelFollowRequest))
              as GCancelFollowRequestData_cancelFollowRequest?;
          break;
      }
    }

    return result.build();
  }
}

class _$GCancelFollowRequestData_cancelFollowRequest__baseSerializer
    implements
        StructuredSerializer<
            GCancelFollowRequestData_cancelFollowRequest__base> {
  @override
  final Iterable<Type> types = const [
    GCancelFollowRequestData_cancelFollowRequest__base,
    _$GCancelFollowRequestData_cancelFollowRequest__base
  ];
  @override
  final String wireName = 'GCancelFollowRequestData_cancelFollowRequest__base';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GCancelFollowRequestData_cancelFollowRequest__base object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GCancelFollowRequestData_cancelFollowRequest__base deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GCancelFollowRequestData_cancelFollowRequest__baseBuilder();

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

class _$GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccessSerializer
    implements
        StructuredSerializer<
            GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess> {
  @override
  final Iterable<Type> types = const [
    GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess,
    _$GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess
  ];
  @override
  final String wireName =
      'GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess';

  @override
  Iterable<Object?> serialize(
      Serializers serializers,
      GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess
          object,
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
  GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess
      deserialize(Serializers serializers, Iterable<Object?> serialized,
          {FullType specifiedType = FullType.unspecified}) {
    final result =
        GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccessBuilder();

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

class _$GCancelFollowRequestData_cancelFollowRequest__asValidationErrorSerializer
    implements
        StructuredSerializer<
            GCancelFollowRequestData_cancelFollowRequest__asValidationError> {
  @override
  final Iterable<Type> types = const [
    GCancelFollowRequestData_cancelFollowRequest__asValidationError,
    _$GCancelFollowRequestData_cancelFollowRequest__asValidationError
  ];
  @override
  final String wireName =
      'GCancelFollowRequestData_cancelFollowRequest__asValidationError';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GCancelFollowRequestData_cancelFollowRequest__asValidationError object,
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
  GCancelFollowRequestData_cancelFollowRequest__asValidationError deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        GCancelFollowRequestData_cancelFollowRequest__asValidationErrorBuilder();

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

class _$GCancelFollowRequestData extends GCancelFollowRequestData {
  @override
  final String G__typename;
  @override
  final GCancelFollowRequestData_cancelFollowRequest? cancelFollowRequest;

  factory _$GCancelFollowRequestData(
          [void Function(GCancelFollowRequestDataBuilder)? updates]) =>
      (GCancelFollowRequestDataBuilder()..update(updates))._build();

  _$GCancelFollowRequestData._(
      {required this.G__typename, this.cancelFollowRequest})
      : super._();
  @override
  GCancelFollowRequestData rebuild(
          void Function(GCancelFollowRequestDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCancelFollowRequestDataBuilder toBuilder() =>
      GCancelFollowRequestDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCancelFollowRequestData &&
        G__typename == other.G__typename &&
        cancelFollowRequest == other.cancelFollowRequest;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, cancelFollowRequest.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCancelFollowRequestData')
          ..add('G__typename', G__typename)
          ..add('cancelFollowRequest', cancelFollowRequest))
        .toString();
  }
}

class GCancelFollowRequestDataBuilder
    implements
        Builder<GCancelFollowRequestData, GCancelFollowRequestDataBuilder> {
  _$GCancelFollowRequestData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GCancelFollowRequestData_cancelFollowRequest? _cancelFollowRequest;
  GCancelFollowRequestData_cancelFollowRequest? get cancelFollowRequest =>
      _$this._cancelFollowRequest;
  set cancelFollowRequest(
          GCancelFollowRequestData_cancelFollowRequest? cancelFollowRequest) =>
      _$this._cancelFollowRequest = cancelFollowRequest;

  GCancelFollowRequestDataBuilder() {
    GCancelFollowRequestData._initializeBuilder(this);
  }

  GCancelFollowRequestDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _cancelFollowRequest = $v.cancelFollowRequest;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCancelFollowRequestData other) {
    _$v = other as _$GCancelFollowRequestData;
  }

  @override
  void update(void Function(GCancelFollowRequestDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCancelFollowRequestData build() => _build();

  _$GCancelFollowRequestData _build() {
    final _$result = _$v ??
        _$GCancelFollowRequestData._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GCancelFollowRequestData', 'G__typename'),
          cancelFollowRequest: cancelFollowRequest,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GCancelFollowRequestData_cancelFollowRequest__base
    extends GCancelFollowRequestData_cancelFollowRequest__base {
  @override
  final String G__typename;

  factory _$GCancelFollowRequestData_cancelFollowRequest__base(
          [void Function(
                  GCancelFollowRequestData_cancelFollowRequest__baseBuilder)?
              updates]) =>
      (GCancelFollowRequestData_cancelFollowRequest__baseBuilder()
            ..update(updates))
          ._build();

  _$GCancelFollowRequestData_cancelFollowRequest__base._(
      {required this.G__typename})
      : super._();
  @override
  GCancelFollowRequestData_cancelFollowRequest__base rebuild(
          void Function(
                  GCancelFollowRequestData_cancelFollowRequest__baseBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCancelFollowRequestData_cancelFollowRequest__baseBuilder toBuilder() =>
      GCancelFollowRequestData_cancelFollowRequest__baseBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCancelFollowRequestData_cancelFollowRequest__base &&
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
            r'GCancelFollowRequestData_cancelFollowRequest__base')
          ..add('G__typename', G__typename))
        .toString();
  }
}

class GCancelFollowRequestData_cancelFollowRequest__baseBuilder
    implements
        Builder<GCancelFollowRequestData_cancelFollowRequest__base,
            GCancelFollowRequestData_cancelFollowRequest__baseBuilder> {
  _$GCancelFollowRequestData_cancelFollowRequest__base? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GCancelFollowRequestData_cancelFollowRequest__baseBuilder() {
    GCancelFollowRequestData_cancelFollowRequest__base._initializeBuilder(this);
  }

  GCancelFollowRequestData_cancelFollowRequest__baseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCancelFollowRequestData_cancelFollowRequest__base other) {
    _$v = other as _$GCancelFollowRequestData_cancelFollowRequest__base;
  }

  @override
  void update(
      void Function(GCancelFollowRequestData_cancelFollowRequest__baseBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GCancelFollowRequestData_cancelFollowRequest__base build() => _build();

  _$GCancelFollowRequestData_cancelFollowRequest__base _build() {
    final _$result = _$v ??
        _$GCancelFollowRequestData_cancelFollowRequest__base._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GCancelFollowRequestData_cancelFollowRequest__base',
              'G__typename'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess
    extends GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess {
  @override
  final String G__typename;
  @override
  final bool data;

  factory _$GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess(
          [void Function(
                  GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccessBuilder)?
              updates]) =>
      (GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccessBuilder()
            ..update(updates))
          ._build();

  _$GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess._(
      {required this.G__typename, required this.data})
      : super._();
  @override
  GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess
      rebuild(
              void Function(
                      GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccessBuilder)
                  updates) =>
          (toBuilder()..update(updates)).build();

  @override
  GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccessBuilder
      toBuilder() =>
          GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccessBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess &&
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
            r'GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess')
          ..add('G__typename', G__typename)
          ..add('data', data))
        .toString();
  }
}

class GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccessBuilder
    implements
        Builder<
            GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess,
            GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccessBuilder> {
  _$GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess?
      _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  bool? _data;
  bool? get data => _$this._data;
  set data(bool? data) => _$this._data = data;

  GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccessBuilder() {
    GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess
        ._initializeBuilder(this);
  }

  GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccessBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _data = $v.data;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess
          other) {
    _$v = other
        as _$GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess;
  }

  @override
  void update(
      void Function(
              GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccessBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess
      build() => _build();

  _$GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess
      _build() {
    final _$result = _$v ??
        _$GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess
            ._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess',
              'G__typename'),
          data: BuiltValueNullFieldError.checkNotNull(
              data,
              r'GCancelFollowRequestData_cancelFollowRequest__asMutationCancelFollowRequestSuccess',
              'data'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GCancelFollowRequestData_cancelFollowRequest__asValidationError
    extends GCancelFollowRequestData_cancelFollowRequest__asValidationError {
  @override
  final String G__typename;
  @override
  final String? message;
  @override
  final String? code;

  factory _$GCancelFollowRequestData_cancelFollowRequest__asValidationError(
          [void Function(
                  GCancelFollowRequestData_cancelFollowRequest__asValidationErrorBuilder)?
              updates]) =>
      (GCancelFollowRequestData_cancelFollowRequest__asValidationErrorBuilder()
            ..update(updates))
          ._build();

  _$GCancelFollowRequestData_cancelFollowRequest__asValidationError._(
      {required this.G__typename, this.message, this.code})
      : super._();
  @override
  GCancelFollowRequestData_cancelFollowRequest__asValidationError rebuild(
          void Function(
                  GCancelFollowRequestData_cancelFollowRequest__asValidationErrorBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCancelFollowRequestData_cancelFollowRequest__asValidationErrorBuilder
      toBuilder() =>
          GCancelFollowRequestData_cancelFollowRequest__asValidationErrorBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GCancelFollowRequestData_cancelFollowRequest__asValidationError &&
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
            r'GCancelFollowRequestData_cancelFollowRequest__asValidationError')
          ..add('G__typename', G__typename)
          ..add('message', message)
          ..add('code', code))
        .toString();
  }
}

class GCancelFollowRequestData_cancelFollowRequest__asValidationErrorBuilder
    implements
        Builder<GCancelFollowRequestData_cancelFollowRequest__asValidationError,
            GCancelFollowRequestData_cancelFollowRequest__asValidationErrorBuilder> {
  _$GCancelFollowRequestData_cancelFollowRequest__asValidationError? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  GCancelFollowRequestData_cancelFollowRequest__asValidationErrorBuilder() {
    GCancelFollowRequestData_cancelFollowRequest__asValidationError
        ._initializeBuilder(this);
  }

  GCancelFollowRequestData_cancelFollowRequest__asValidationErrorBuilder
      get _$this {
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
  void replace(
      GCancelFollowRequestData_cancelFollowRequest__asValidationError other) {
    _$v = other
        as _$GCancelFollowRequestData_cancelFollowRequest__asValidationError;
  }

  @override
  void update(
      void Function(
              GCancelFollowRequestData_cancelFollowRequest__asValidationErrorBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GCancelFollowRequestData_cancelFollowRequest__asValidationError build() =>
      _build();

  _$GCancelFollowRequestData_cancelFollowRequest__asValidationError _build() {
    final _$result = _$v ??
        _$GCancelFollowRequestData_cancelFollowRequest__asValidationError._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GCancelFollowRequestData_cancelFollowRequest__asValidationError',
              'G__typename'),
          message: message,
          code: code,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
