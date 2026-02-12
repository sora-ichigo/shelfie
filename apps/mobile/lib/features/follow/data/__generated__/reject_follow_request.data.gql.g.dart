// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reject_follow_request.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GRejectFollowRequestData> _$gRejectFollowRequestDataSerializer =
    _$GRejectFollowRequestDataSerializer();
Serializer<GRejectFollowRequestData_rejectFollowRequest__base>
    _$gRejectFollowRequestDataRejectFollowRequestBaseSerializer =
    _$GRejectFollowRequestData_rejectFollowRequest__baseSerializer();
Serializer<
        GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess>
    _$gRejectFollowRequestDataRejectFollowRequestAsMutationRejectFollowRequestSuccessSerializer =
    _$GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccessSerializer();
Serializer<
        GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data>
    _$gRejectFollowRequestDataRejectFollowRequestAsMutationRejectFollowRequestSuccessDataSerializer =
    _$GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_dataSerializer();
Serializer<GRejectFollowRequestData_rejectFollowRequest__asValidationError>
    _$gRejectFollowRequestDataRejectFollowRequestAsValidationErrorSerializer =
    _$GRejectFollowRequestData_rejectFollowRequest__asValidationErrorSerializer();

class _$GRejectFollowRequestDataSerializer
    implements StructuredSerializer<GRejectFollowRequestData> {
  @override
  final Iterable<Type> types = const [
    GRejectFollowRequestData,
    _$GRejectFollowRequestData
  ];
  @override
  final String wireName = 'GRejectFollowRequestData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GRejectFollowRequestData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.rejectFollowRequest;
    if (value != null) {
      result
        ..add('rejectFollowRequest')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(GRejectFollowRequestData_rejectFollowRequest)));
    }
    return result;
  }

  @override
  GRejectFollowRequestData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GRejectFollowRequestDataBuilder();

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
        case 'rejectFollowRequest':
          result.rejectFollowRequest = serializers.deserialize(value,
                  specifiedType: const FullType(
                      GRejectFollowRequestData_rejectFollowRequest))
              as GRejectFollowRequestData_rejectFollowRequest?;
          break;
      }
    }

    return result.build();
  }
}

class _$GRejectFollowRequestData_rejectFollowRequest__baseSerializer
    implements
        StructuredSerializer<
            GRejectFollowRequestData_rejectFollowRequest__base> {
  @override
  final Iterable<Type> types = const [
    GRejectFollowRequestData_rejectFollowRequest__base,
    _$GRejectFollowRequestData_rejectFollowRequest__base
  ];
  @override
  final String wireName = 'GRejectFollowRequestData_rejectFollowRequest__base';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GRejectFollowRequestData_rejectFollowRequest__base object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GRejectFollowRequestData_rejectFollowRequest__base deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GRejectFollowRequestData_rejectFollowRequest__baseBuilder();

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

class _$GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccessSerializer
    implements
        StructuredSerializer<
            GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess> {
  @override
  final Iterable<Type> types = const [
    GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess,
    _$GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess
  ];
  @override
  final String wireName =
      'GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess';

  @override
  Iterable<Object?> serialize(
      Serializers serializers,
      GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess
          object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data)),
    ];

    return result;
  }

  @override
  GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess
      deserialize(Serializers serializers, Iterable<Object?> serialized,
          {FullType specifiedType = FullType.unspecified}) {
    final result =
        GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccessBuilder();

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
                      GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data))!
              as GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data);
          break;
      }
    }

    return result.build();
  }
}

class _$GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_dataSerializer
    implements
        StructuredSerializer<
            GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data> {
  @override
  final Iterable<Type> types = const [
    GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data,
    _$GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data
  ];
  @override
  final String wireName =
      'GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data';

  @override
  Iterable<Object?> serialize(
      Serializers serializers,
      GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data
          object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'senderId',
      serializers.serialize(object.senderId,
          specifiedType: const FullType(int)),
      'receiverId',
      serializers.serialize(object.receiverId,
          specifiedType: const FullType(int)),
      'status',
      serializers.serialize(object.status,
          specifiedType: const FullType(_i3.GFollowRequestStatus)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(DateTime)),
    ];

    return result;
  }

  @override
  GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data
      deserialize(Serializers serializers, Iterable<Object?> serialized,
          {FullType specifiedType = FullType.unspecified}) {
    final result =
        GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_dataBuilder();

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
              specifiedType: const FullType(int))! as int;
          break;
        case 'senderId':
          result.senderId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'receiverId':
          result.receiverId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GFollowRequestStatus))!
              as _i3.GFollowRequestStatus;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
      }
    }

    return result.build();
  }
}

class _$GRejectFollowRequestData_rejectFollowRequest__asValidationErrorSerializer
    implements
        StructuredSerializer<
            GRejectFollowRequestData_rejectFollowRequest__asValidationError> {
  @override
  final Iterable<Type> types = const [
    GRejectFollowRequestData_rejectFollowRequest__asValidationError,
    _$GRejectFollowRequestData_rejectFollowRequest__asValidationError
  ];
  @override
  final String wireName =
      'GRejectFollowRequestData_rejectFollowRequest__asValidationError';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GRejectFollowRequestData_rejectFollowRequest__asValidationError object,
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
  GRejectFollowRequestData_rejectFollowRequest__asValidationError deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        GRejectFollowRequestData_rejectFollowRequest__asValidationErrorBuilder();

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

class _$GRejectFollowRequestData extends GRejectFollowRequestData {
  @override
  final String G__typename;
  @override
  final GRejectFollowRequestData_rejectFollowRequest? rejectFollowRequest;

  factory _$GRejectFollowRequestData(
          [void Function(GRejectFollowRequestDataBuilder)? updates]) =>
      (GRejectFollowRequestDataBuilder()..update(updates))._build();

  _$GRejectFollowRequestData._(
      {required this.G__typename, this.rejectFollowRequest})
      : super._();
  @override
  GRejectFollowRequestData rebuild(
          void Function(GRejectFollowRequestDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRejectFollowRequestDataBuilder toBuilder() =>
      GRejectFollowRequestDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRejectFollowRequestData &&
        G__typename == other.G__typename &&
        rejectFollowRequest == other.rejectFollowRequest;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, rejectFollowRequest.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GRejectFollowRequestData')
          ..add('G__typename', G__typename)
          ..add('rejectFollowRequest', rejectFollowRequest))
        .toString();
  }
}

class GRejectFollowRequestDataBuilder
    implements
        Builder<GRejectFollowRequestData, GRejectFollowRequestDataBuilder> {
  _$GRejectFollowRequestData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GRejectFollowRequestData_rejectFollowRequest? _rejectFollowRequest;
  GRejectFollowRequestData_rejectFollowRequest? get rejectFollowRequest =>
      _$this._rejectFollowRequest;
  set rejectFollowRequest(
          GRejectFollowRequestData_rejectFollowRequest? rejectFollowRequest) =>
      _$this._rejectFollowRequest = rejectFollowRequest;

  GRejectFollowRequestDataBuilder() {
    GRejectFollowRequestData._initializeBuilder(this);
  }

  GRejectFollowRequestDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _rejectFollowRequest = $v.rejectFollowRequest;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRejectFollowRequestData other) {
    _$v = other as _$GRejectFollowRequestData;
  }

  @override
  void update(void Function(GRejectFollowRequestDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRejectFollowRequestData build() => _build();

  _$GRejectFollowRequestData _build() {
    final _$result = _$v ??
        _$GRejectFollowRequestData._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GRejectFollowRequestData', 'G__typename'),
          rejectFollowRequest: rejectFollowRequest,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GRejectFollowRequestData_rejectFollowRequest__base
    extends GRejectFollowRequestData_rejectFollowRequest__base {
  @override
  final String G__typename;

  factory _$GRejectFollowRequestData_rejectFollowRequest__base(
          [void Function(
                  GRejectFollowRequestData_rejectFollowRequest__baseBuilder)?
              updates]) =>
      (GRejectFollowRequestData_rejectFollowRequest__baseBuilder()
            ..update(updates))
          ._build();

  _$GRejectFollowRequestData_rejectFollowRequest__base._(
      {required this.G__typename})
      : super._();
  @override
  GRejectFollowRequestData_rejectFollowRequest__base rebuild(
          void Function(
                  GRejectFollowRequestData_rejectFollowRequest__baseBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRejectFollowRequestData_rejectFollowRequest__baseBuilder toBuilder() =>
      GRejectFollowRequestData_rejectFollowRequest__baseBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRejectFollowRequestData_rejectFollowRequest__base &&
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
            r'GRejectFollowRequestData_rejectFollowRequest__base')
          ..add('G__typename', G__typename))
        .toString();
  }
}

class GRejectFollowRequestData_rejectFollowRequest__baseBuilder
    implements
        Builder<GRejectFollowRequestData_rejectFollowRequest__base,
            GRejectFollowRequestData_rejectFollowRequest__baseBuilder> {
  _$GRejectFollowRequestData_rejectFollowRequest__base? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GRejectFollowRequestData_rejectFollowRequest__baseBuilder() {
    GRejectFollowRequestData_rejectFollowRequest__base._initializeBuilder(this);
  }

  GRejectFollowRequestData_rejectFollowRequest__baseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRejectFollowRequestData_rejectFollowRequest__base other) {
    _$v = other as _$GRejectFollowRequestData_rejectFollowRequest__base;
  }

  @override
  void update(
      void Function(GRejectFollowRequestData_rejectFollowRequest__baseBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GRejectFollowRequestData_rejectFollowRequest__base build() => _build();

  _$GRejectFollowRequestData_rejectFollowRequest__base _build() {
    final _$result = _$v ??
        _$GRejectFollowRequestData_rejectFollowRequest__base._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GRejectFollowRequestData_rejectFollowRequest__base',
              'G__typename'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess
    extends GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess {
  @override
  final String G__typename;
  @override
  final GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data
      data;

  factory _$GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess(
          [void Function(
                  GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccessBuilder)?
              updates]) =>
      (GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccessBuilder()
            ..update(updates))
          ._build();

  _$GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess._(
      {required this.G__typename, required this.data})
      : super._();
  @override
  GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess
      rebuild(
              void Function(
                      GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccessBuilder)
                  updates) =>
          (toBuilder()..update(updates)).build();

  @override
  GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccessBuilder
      toBuilder() =>
          GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccessBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess &&
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
            r'GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess')
          ..add('G__typename', G__typename)
          ..add('data', data))
        .toString();
  }
}

class GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccessBuilder
    implements
        Builder<
            GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess,
            GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccessBuilder> {
  _$GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess?
      _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_dataBuilder?
      _data;
  GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_dataBuilder
      get data => _$this._data ??=
          GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_dataBuilder();
  set data(
          GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_dataBuilder?
              data) =>
      _$this._data = data;

  GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccessBuilder() {
    GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess
        ._initializeBuilder(this);
  }

  GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccessBuilder
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
      GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess
          other) {
    _$v = other
        as _$GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess;
  }

  @override
  void update(
      void Function(
              GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccessBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess
      build() => _build();

  _$GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess
      _build() {
    _$GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess
        _$result;
    try {
      _$result = _$v ??
          _$GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess
              ._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess',
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
            r'GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data
    extends GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final int senderId;
  @override
  final int receiverId;
  @override
  final _i3.GFollowRequestStatus status;
  @override
  final DateTime createdAt;

  factory _$GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data(
          [void Function(
                  GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_dataBuilder)?
              updates]) =>
      (GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_dataBuilder()
            ..update(updates))
          ._build();

  _$GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data._(
      {required this.G__typename,
      required this.id,
      required this.senderId,
      required this.receiverId,
      required this.status,
      required this.createdAt})
      : super._();
  @override
  GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data
      rebuild(
              void Function(
                      GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_dataBuilder)
                  updates) =>
          (toBuilder()..update(updates)).build();

  @override
  GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_dataBuilder
      toBuilder() =>
          GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_dataBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data &&
        G__typename == other.G__typename &&
        id == other.id &&
        senderId == other.senderId &&
        receiverId == other.receiverId &&
        status == other.status &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, senderId.hashCode);
    _$hash = $jc(_$hash, receiverId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('senderId', senderId)
          ..add('receiverId', receiverId)
          ..add('status', status)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_dataBuilder
    implements
        Builder<
            GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data,
            GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_dataBuilder> {
  _$GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data?
      _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _senderId;
  int? get senderId => _$this._senderId;
  set senderId(int? senderId) => _$this._senderId = senderId;

  int? _receiverId;
  int? get receiverId => _$this._receiverId;
  set receiverId(int? receiverId) => _$this._receiverId = receiverId;

  _i3.GFollowRequestStatus? _status;
  _i3.GFollowRequestStatus? get status => _$this._status;
  set status(_i3.GFollowRequestStatus? status) => _$this._status = status;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_dataBuilder() {
    GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data
        ._initializeBuilder(this);
  }

  GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_dataBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _senderId = $v.senderId;
      _receiverId = $v.receiverId;
      _status = $v.status;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data
          other) {
    _$v = other
        as _$GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data;
  }

  @override
  void update(
      void Function(
              GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_dataBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data
      build() => _build();

  _$GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data
      _build() {
    final _$result = _$v ??
        _$GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data
            ._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data',
              'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data',
              'id'),
          senderId: BuiltValueNullFieldError.checkNotNull(
              senderId,
              r'GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data',
              'senderId'),
          receiverId: BuiltValueNullFieldError.checkNotNull(
              receiverId,
              r'GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data',
              'receiverId'),
          status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data',
              'status'),
          createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt,
              r'GRejectFollowRequestData_rejectFollowRequest__asMutationRejectFollowRequestSuccess_data',
              'createdAt'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GRejectFollowRequestData_rejectFollowRequest__asValidationError
    extends GRejectFollowRequestData_rejectFollowRequest__asValidationError {
  @override
  final String G__typename;
  @override
  final String? message;
  @override
  final String? code;

  factory _$GRejectFollowRequestData_rejectFollowRequest__asValidationError(
          [void Function(
                  GRejectFollowRequestData_rejectFollowRequest__asValidationErrorBuilder)?
              updates]) =>
      (GRejectFollowRequestData_rejectFollowRequest__asValidationErrorBuilder()
            ..update(updates))
          ._build();

  _$GRejectFollowRequestData_rejectFollowRequest__asValidationError._(
      {required this.G__typename, this.message, this.code})
      : super._();
  @override
  GRejectFollowRequestData_rejectFollowRequest__asValidationError rebuild(
          void Function(
                  GRejectFollowRequestData_rejectFollowRequest__asValidationErrorBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRejectFollowRequestData_rejectFollowRequest__asValidationErrorBuilder
      toBuilder() =>
          GRejectFollowRequestData_rejectFollowRequest__asValidationErrorBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GRejectFollowRequestData_rejectFollowRequest__asValidationError &&
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
            r'GRejectFollowRequestData_rejectFollowRequest__asValidationError')
          ..add('G__typename', G__typename)
          ..add('message', message)
          ..add('code', code))
        .toString();
  }
}

class GRejectFollowRequestData_rejectFollowRequest__asValidationErrorBuilder
    implements
        Builder<GRejectFollowRequestData_rejectFollowRequest__asValidationError,
            GRejectFollowRequestData_rejectFollowRequest__asValidationErrorBuilder> {
  _$GRejectFollowRequestData_rejectFollowRequest__asValidationError? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  GRejectFollowRequestData_rejectFollowRequest__asValidationErrorBuilder() {
    GRejectFollowRequestData_rejectFollowRequest__asValidationError
        ._initializeBuilder(this);
  }

  GRejectFollowRequestData_rejectFollowRequest__asValidationErrorBuilder
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
      GRejectFollowRequestData_rejectFollowRequest__asValidationError other) {
    _$v = other
        as _$GRejectFollowRequestData_rejectFollowRequest__asValidationError;
  }

  @override
  void update(
      void Function(
              GRejectFollowRequestData_rejectFollowRequest__asValidationErrorBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GRejectFollowRequestData_rejectFollowRequest__asValidationError build() =>
      _build();

  _$GRejectFollowRequestData_rejectFollowRequest__asValidationError _build() {
    final _$result = _$v ??
        _$GRejectFollowRequestData_rejectFollowRequest__asValidationError._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GRejectFollowRequestData_rejectFollowRequest__asValidationError',
              'G__typename'),
          message: message,
          code: code,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
