// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approve_follow_request.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GApproveFollowRequestData> _$gApproveFollowRequestDataSerializer =
    _$GApproveFollowRequestDataSerializer();
Serializer<GApproveFollowRequestData_approveFollowRequest__base>
    _$gApproveFollowRequestDataApproveFollowRequestBaseSerializer =
    _$GApproveFollowRequestData_approveFollowRequest__baseSerializer();
Serializer<
        GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess>
    _$gApproveFollowRequestDataApproveFollowRequestAsMutationApproveFollowRequestSuccessSerializer =
    _$GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccessSerializer();
Serializer<
        GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data>
    _$gApproveFollowRequestDataApproveFollowRequestAsMutationApproveFollowRequestSuccessDataSerializer =
    _$GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_dataSerializer();
Serializer<GApproveFollowRequestData_approveFollowRequest__asValidationError>
    _$gApproveFollowRequestDataApproveFollowRequestAsValidationErrorSerializer =
    _$GApproveFollowRequestData_approveFollowRequest__asValidationErrorSerializer();

class _$GApproveFollowRequestDataSerializer
    implements StructuredSerializer<GApproveFollowRequestData> {
  @override
  final Iterable<Type> types = const [
    GApproveFollowRequestData,
    _$GApproveFollowRequestData
  ];
  @override
  final String wireName = 'GApproveFollowRequestData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GApproveFollowRequestData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.approveFollowRequest;
    if (value != null) {
      result
        ..add('approveFollowRequest')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                GApproveFollowRequestData_approveFollowRequest)));
    }
    return result;
  }

  @override
  GApproveFollowRequestData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GApproveFollowRequestDataBuilder();

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
        case 'approveFollowRequest':
          result.approveFollowRequest = serializers.deserialize(value,
                  specifiedType: const FullType(
                      GApproveFollowRequestData_approveFollowRequest))
              as GApproveFollowRequestData_approveFollowRequest?;
          break;
      }
    }

    return result.build();
  }
}

class _$GApproveFollowRequestData_approveFollowRequest__baseSerializer
    implements
        StructuredSerializer<
            GApproveFollowRequestData_approveFollowRequest__base> {
  @override
  final Iterable<Type> types = const [
    GApproveFollowRequestData_approveFollowRequest__base,
    _$GApproveFollowRequestData_approveFollowRequest__base
  ];
  @override
  final String wireName =
      'GApproveFollowRequestData_approveFollowRequest__base';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GApproveFollowRequestData_approveFollowRequest__base object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GApproveFollowRequestData_approveFollowRequest__base deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        GApproveFollowRequestData_approveFollowRequest__baseBuilder();

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

class _$GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccessSerializer
    implements
        StructuredSerializer<
            GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess> {
  @override
  final Iterable<Type> types = const [
    GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess,
    _$GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess
  ];
  @override
  final String wireName =
      'GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess';

  @override
  Iterable<Object?> serialize(
      Serializers serializers,
      GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess
          object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data)),
    ];

    return result;
  }

  @override
  GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess
      deserialize(Serializers serializers, Iterable<Object?> serialized,
          {FullType specifiedType = FullType.unspecified}) {
    final result =
        GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccessBuilder();

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
                      GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data))!
              as GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data);
          break;
      }
    }

    return result.build();
  }
}

class _$GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_dataSerializer
    implements
        StructuredSerializer<
            GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data> {
  @override
  final Iterable<Type> types = const [
    GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data,
    _$GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data
  ];
  @override
  final String wireName =
      'GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data';

  @override
  Iterable<Object?> serialize(
      Serializers serializers,
      GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data
          object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.senderId;
    if (value != null) {
      result
        ..add('senderId')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.receiverId;
    if (value != null) {
      result
        ..add('receiverId')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.status;
    if (value != null) {
      result
        ..add('status')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i3.GFollowRequestStatus)));
    }
    value = object.createdAt;
    if (value != null) {
      result
        ..add('createdAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    return result;
  }

  @override
  GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data
      deserialize(Serializers serializers, Iterable<Object?> serialized,
          {FullType specifiedType = FullType.unspecified}) {
    final result =
        GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_dataBuilder();

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
        case 'senderId':
          result.senderId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'receiverId':
          result.receiverId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GFollowRequestStatus))
              as _i3.GFollowRequestStatus?;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
      }
    }

    return result.build();
  }
}

class _$GApproveFollowRequestData_approveFollowRequest__asValidationErrorSerializer
    implements
        StructuredSerializer<
            GApproveFollowRequestData_approveFollowRequest__asValidationError> {
  @override
  final Iterable<Type> types = const [
    GApproveFollowRequestData_approveFollowRequest__asValidationError,
    _$GApproveFollowRequestData_approveFollowRequest__asValidationError
  ];
  @override
  final String wireName =
      'GApproveFollowRequestData_approveFollowRequest__asValidationError';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GApproveFollowRequestData_approveFollowRequest__asValidationError object,
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
  GApproveFollowRequestData_approveFollowRequest__asValidationError deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        GApproveFollowRequestData_approveFollowRequest__asValidationErrorBuilder();

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

class _$GApproveFollowRequestData extends GApproveFollowRequestData {
  @override
  final String G__typename;
  @override
  final GApproveFollowRequestData_approveFollowRequest? approveFollowRequest;

  factory _$GApproveFollowRequestData(
          [void Function(GApproveFollowRequestDataBuilder)? updates]) =>
      (GApproveFollowRequestDataBuilder()..update(updates))._build();

  _$GApproveFollowRequestData._(
      {required this.G__typename, this.approveFollowRequest})
      : super._();
  @override
  GApproveFollowRequestData rebuild(
          void Function(GApproveFollowRequestDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GApproveFollowRequestDataBuilder toBuilder() =>
      GApproveFollowRequestDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GApproveFollowRequestData &&
        G__typename == other.G__typename &&
        approveFollowRequest == other.approveFollowRequest;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, approveFollowRequest.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GApproveFollowRequestData')
          ..add('G__typename', G__typename)
          ..add('approveFollowRequest', approveFollowRequest))
        .toString();
  }
}

class GApproveFollowRequestDataBuilder
    implements
        Builder<GApproveFollowRequestData, GApproveFollowRequestDataBuilder> {
  _$GApproveFollowRequestData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GApproveFollowRequestData_approveFollowRequest? _approveFollowRequest;
  GApproveFollowRequestData_approveFollowRequest? get approveFollowRequest =>
      _$this._approveFollowRequest;
  set approveFollowRequest(
          GApproveFollowRequestData_approveFollowRequest?
              approveFollowRequest) =>
      _$this._approveFollowRequest = approveFollowRequest;

  GApproveFollowRequestDataBuilder() {
    GApproveFollowRequestData._initializeBuilder(this);
  }

  GApproveFollowRequestDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _approveFollowRequest = $v.approveFollowRequest;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GApproveFollowRequestData other) {
    _$v = other as _$GApproveFollowRequestData;
  }

  @override
  void update(void Function(GApproveFollowRequestDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GApproveFollowRequestData build() => _build();

  _$GApproveFollowRequestData _build() {
    final _$result = _$v ??
        _$GApproveFollowRequestData._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GApproveFollowRequestData', 'G__typename'),
          approveFollowRequest: approveFollowRequest,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GApproveFollowRequestData_approveFollowRequest__base
    extends GApproveFollowRequestData_approveFollowRequest__base {
  @override
  final String G__typename;

  factory _$GApproveFollowRequestData_approveFollowRequest__base(
          [void Function(
                  GApproveFollowRequestData_approveFollowRequest__baseBuilder)?
              updates]) =>
      (GApproveFollowRequestData_approveFollowRequest__baseBuilder()
            ..update(updates))
          ._build();

  _$GApproveFollowRequestData_approveFollowRequest__base._(
      {required this.G__typename})
      : super._();
  @override
  GApproveFollowRequestData_approveFollowRequest__base rebuild(
          void Function(
                  GApproveFollowRequestData_approveFollowRequest__baseBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GApproveFollowRequestData_approveFollowRequest__baseBuilder toBuilder() =>
      GApproveFollowRequestData_approveFollowRequest__baseBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GApproveFollowRequestData_approveFollowRequest__base &&
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
            r'GApproveFollowRequestData_approveFollowRequest__base')
          ..add('G__typename', G__typename))
        .toString();
  }
}

class GApproveFollowRequestData_approveFollowRequest__baseBuilder
    implements
        Builder<GApproveFollowRequestData_approveFollowRequest__base,
            GApproveFollowRequestData_approveFollowRequest__baseBuilder> {
  _$GApproveFollowRequestData_approveFollowRequest__base? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GApproveFollowRequestData_approveFollowRequest__baseBuilder() {
    GApproveFollowRequestData_approveFollowRequest__base._initializeBuilder(
        this);
  }

  GApproveFollowRequestData_approveFollowRequest__baseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GApproveFollowRequestData_approveFollowRequest__base other) {
    _$v = other as _$GApproveFollowRequestData_approveFollowRequest__base;
  }

  @override
  void update(
      void Function(
              GApproveFollowRequestData_approveFollowRequest__baseBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GApproveFollowRequestData_approveFollowRequest__base build() => _build();

  _$GApproveFollowRequestData_approveFollowRequest__base _build() {
    final _$result = _$v ??
        _$GApproveFollowRequestData_approveFollowRequest__base._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GApproveFollowRequestData_approveFollowRequest__base',
              'G__typename'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess
    extends GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess {
  @override
  final String G__typename;
  @override
  final GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data
      data;

  factory _$GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess(
          [void Function(
                  GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccessBuilder)?
              updates]) =>
      (GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccessBuilder()
            ..update(updates))
          ._build();

  _$GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess._(
      {required this.G__typename, required this.data})
      : super._();
  @override
  GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess
      rebuild(
              void Function(
                      GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccessBuilder)
                  updates) =>
          (toBuilder()..update(updates)).build();

  @override
  GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccessBuilder
      toBuilder() =>
          GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccessBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess &&
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
            r'GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess')
          ..add('G__typename', G__typename)
          ..add('data', data))
        .toString();
  }
}

class GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccessBuilder
    implements
        Builder<
            GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess,
            GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccessBuilder> {
  _$GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess?
      _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_dataBuilder?
      _data;
  GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_dataBuilder
      get data => _$this._data ??=
          GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_dataBuilder();
  set data(
          GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_dataBuilder?
              data) =>
      _$this._data = data;

  GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccessBuilder() {
    GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess
        ._initializeBuilder(this);
  }

  GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccessBuilder
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
      GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess
          other) {
    _$v = other
        as _$GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess;
  }

  @override
  void update(
      void Function(
              GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccessBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess
      build() => _build();

  _$GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess
      _build() {
    _$GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess
        _$result;
    try {
      _$result = _$v ??
          _$GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess
              ._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess',
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
            r'GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data
    extends GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data {
  @override
  final String G__typename;
  @override
  final int? id;
  @override
  final int? senderId;
  @override
  final int? receiverId;
  @override
  final _i3.GFollowRequestStatus? status;
  @override
  final DateTime? createdAt;

  factory _$GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data(
          [void Function(
                  GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_dataBuilder)?
              updates]) =>
      (GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_dataBuilder()
            ..update(updates))
          ._build();

  _$GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data._(
      {required this.G__typename,
      this.id,
      this.senderId,
      this.receiverId,
      this.status,
      this.createdAt})
      : super._();
  @override
  GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data
      rebuild(
              void Function(
                      GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_dataBuilder)
                  updates) =>
          (toBuilder()..update(updates)).build();

  @override
  GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_dataBuilder
      toBuilder() =>
          GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_dataBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data &&
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
            r'GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('senderId', senderId)
          ..add('receiverId', receiverId)
          ..add('status', status)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_dataBuilder
    implements
        Builder<
            GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data,
            GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_dataBuilder> {
  _$GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data?
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

  GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_dataBuilder() {
    GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data
        ._initializeBuilder(this);
  }

  GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_dataBuilder
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
      GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data
          other) {
    _$v = other
        as _$GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data;
  }

  @override
  void update(
      void Function(
              GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_dataBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data
      build() => _build();

  _$GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data
      _build() {
    final _$result = _$v ??
        _$GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data
            ._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GApproveFollowRequestData_approveFollowRequest__asMutationApproveFollowRequestSuccess_data',
              'G__typename'),
          id: id,
          senderId: senderId,
          receiverId: receiverId,
          status: status,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GApproveFollowRequestData_approveFollowRequest__asValidationError
    extends GApproveFollowRequestData_approveFollowRequest__asValidationError {
  @override
  final String G__typename;
  @override
  final String? message;
  @override
  final String? code;

  factory _$GApproveFollowRequestData_approveFollowRequest__asValidationError(
          [void Function(
                  GApproveFollowRequestData_approveFollowRequest__asValidationErrorBuilder)?
              updates]) =>
      (GApproveFollowRequestData_approveFollowRequest__asValidationErrorBuilder()
            ..update(updates))
          ._build();

  _$GApproveFollowRequestData_approveFollowRequest__asValidationError._(
      {required this.G__typename, this.message, this.code})
      : super._();
  @override
  GApproveFollowRequestData_approveFollowRequest__asValidationError rebuild(
          void Function(
                  GApproveFollowRequestData_approveFollowRequest__asValidationErrorBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GApproveFollowRequestData_approveFollowRequest__asValidationErrorBuilder
      toBuilder() =>
          GApproveFollowRequestData_approveFollowRequest__asValidationErrorBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GApproveFollowRequestData_approveFollowRequest__asValidationError &&
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
            r'GApproveFollowRequestData_approveFollowRequest__asValidationError')
          ..add('G__typename', G__typename)
          ..add('message', message)
          ..add('code', code))
        .toString();
  }
}

class GApproveFollowRequestData_approveFollowRequest__asValidationErrorBuilder
    implements
        Builder<
            GApproveFollowRequestData_approveFollowRequest__asValidationError,
            GApproveFollowRequestData_approveFollowRequest__asValidationErrorBuilder> {
  _$GApproveFollowRequestData_approveFollowRequest__asValidationError? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  GApproveFollowRequestData_approveFollowRequest__asValidationErrorBuilder() {
    GApproveFollowRequestData_approveFollowRequest__asValidationError
        ._initializeBuilder(this);
  }

  GApproveFollowRequestData_approveFollowRequest__asValidationErrorBuilder
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
      GApproveFollowRequestData_approveFollowRequest__asValidationError other) {
    _$v = other
        as _$GApproveFollowRequestData_approveFollowRequest__asValidationError;
  }

  @override
  void update(
      void Function(
              GApproveFollowRequestData_approveFollowRequest__asValidationErrorBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GApproveFollowRequestData_approveFollowRequest__asValidationError build() =>
      _build();

  _$GApproveFollowRequestData_approveFollowRequest__asValidationError _build() {
    final _$result = _$v ??
        _$GApproveFollowRequestData_approveFollowRequest__asValidationError._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GApproveFollowRequestData_approveFollowRequest__asValidationError',
              'G__typename'),
          message: message,
          code: code,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
