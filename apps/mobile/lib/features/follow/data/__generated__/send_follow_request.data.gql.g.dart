// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_follow_request.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GSendFollowRequestData> _$gSendFollowRequestDataSerializer =
    _$GSendFollowRequestDataSerializer();
Serializer<GSendFollowRequestData_sendFollowRequest__base>
    _$gSendFollowRequestDataSendFollowRequestBaseSerializer =
    _$GSendFollowRequestData_sendFollowRequest__baseSerializer();
Serializer<
        GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess>
    _$gSendFollowRequestDataSendFollowRequestAsMutationSendFollowRequestSuccessSerializer =
    _$GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccessSerializer();
Serializer<
        GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data>
    _$gSendFollowRequestDataSendFollowRequestAsMutationSendFollowRequestSuccessDataSerializer =
    _$GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_dataSerializer();
Serializer<GSendFollowRequestData_sendFollowRequest__asValidationError>
    _$gSendFollowRequestDataSendFollowRequestAsValidationErrorSerializer =
    _$GSendFollowRequestData_sendFollowRequest__asValidationErrorSerializer();

class _$GSendFollowRequestDataSerializer
    implements StructuredSerializer<GSendFollowRequestData> {
  @override
  final Iterable<Type> types = const [
    GSendFollowRequestData,
    _$GSendFollowRequestData
  ];
  @override
  final String wireName = 'GSendFollowRequestData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSendFollowRequestData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.sendFollowRequest;
    if (value != null) {
      result
        ..add('sendFollowRequest')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(GSendFollowRequestData_sendFollowRequest)));
    }
    return result;
  }

  @override
  GSendFollowRequestData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GSendFollowRequestDataBuilder();

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
        case 'sendFollowRequest':
          result.sendFollowRequest = serializers.deserialize(value,
                  specifiedType:
                      const FullType(GSendFollowRequestData_sendFollowRequest))
              as GSendFollowRequestData_sendFollowRequest?;
          break;
      }
    }

    return result.build();
  }
}

class _$GSendFollowRequestData_sendFollowRequest__baseSerializer
    implements
        StructuredSerializer<GSendFollowRequestData_sendFollowRequest__base> {
  @override
  final Iterable<Type> types = const [
    GSendFollowRequestData_sendFollowRequest__base,
    _$GSendFollowRequestData_sendFollowRequest__base
  ];
  @override
  final String wireName = 'GSendFollowRequestData_sendFollowRequest__base';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GSendFollowRequestData_sendFollowRequest__base object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GSendFollowRequestData_sendFollowRequest__base deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GSendFollowRequestData_sendFollowRequest__baseBuilder();

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

class _$GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccessSerializer
    implements
        StructuredSerializer<
            GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess> {
  @override
  final Iterable<Type> types = const [
    GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess,
    _$GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess
  ];
  @override
  final String wireName =
      'GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess';

  @override
  Iterable<Object?> serialize(
      Serializers serializers,
      GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess
          object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data)),
    ];

    return result;
  }

  @override
  GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess
      deserialize(Serializers serializers, Iterable<Object?> serialized,
          {FullType specifiedType = FullType.unspecified}) {
    final result =
        GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccessBuilder();

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
                      GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data))!
              as GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data);
          break;
      }
    }

    return result.build();
  }
}

class _$GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_dataSerializer
    implements
        StructuredSerializer<
            GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data> {
  @override
  final Iterable<Type> types = const [
    GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data,
    _$GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data
  ];
  @override
  final String wireName =
      'GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data';

  @override
  Iterable<Object?> serialize(
      Serializers serializers,
      GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data
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
  GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data
      deserialize(Serializers serializers, Iterable<Object?> serialized,
          {FullType specifiedType = FullType.unspecified}) {
    final result =
        GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_dataBuilder();

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

class _$GSendFollowRequestData_sendFollowRequest__asValidationErrorSerializer
    implements
        StructuredSerializer<
            GSendFollowRequestData_sendFollowRequest__asValidationError> {
  @override
  final Iterable<Type> types = const [
    GSendFollowRequestData_sendFollowRequest__asValidationError,
    _$GSendFollowRequestData_sendFollowRequest__asValidationError
  ];
  @override
  final String wireName =
      'GSendFollowRequestData_sendFollowRequest__asValidationError';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GSendFollowRequestData_sendFollowRequest__asValidationError object,
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
  GSendFollowRequestData_sendFollowRequest__asValidationError deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        GSendFollowRequestData_sendFollowRequest__asValidationErrorBuilder();

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

class _$GSendFollowRequestData extends GSendFollowRequestData {
  @override
  final String G__typename;
  @override
  final GSendFollowRequestData_sendFollowRequest? sendFollowRequest;

  factory _$GSendFollowRequestData(
          [void Function(GSendFollowRequestDataBuilder)? updates]) =>
      (GSendFollowRequestDataBuilder()..update(updates))._build();

  _$GSendFollowRequestData._(
      {required this.G__typename, this.sendFollowRequest})
      : super._();
  @override
  GSendFollowRequestData rebuild(
          void Function(GSendFollowRequestDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSendFollowRequestDataBuilder toBuilder() =>
      GSendFollowRequestDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSendFollowRequestData &&
        G__typename == other.G__typename &&
        sendFollowRequest == other.sendFollowRequest;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, sendFollowRequest.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSendFollowRequestData')
          ..add('G__typename', G__typename)
          ..add('sendFollowRequest', sendFollowRequest))
        .toString();
  }
}

class GSendFollowRequestDataBuilder
    implements Builder<GSendFollowRequestData, GSendFollowRequestDataBuilder> {
  _$GSendFollowRequestData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GSendFollowRequestData_sendFollowRequest? _sendFollowRequest;
  GSendFollowRequestData_sendFollowRequest? get sendFollowRequest =>
      _$this._sendFollowRequest;
  set sendFollowRequest(
          GSendFollowRequestData_sendFollowRequest? sendFollowRequest) =>
      _$this._sendFollowRequest = sendFollowRequest;

  GSendFollowRequestDataBuilder() {
    GSendFollowRequestData._initializeBuilder(this);
  }

  GSendFollowRequestDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _sendFollowRequest = $v.sendFollowRequest;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSendFollowRequestData other) {
    _$v = other as _$GSendFollowRequestData;
  }

  @override
  void update(void Function(GSendFollowRequestDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSendFollowRequestData build() => _build();

  _$GSendFollowRequestData _build() {
    final _$result = _$v ??
        _$GSendFollowRequestData._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GSendFollowRequestData', 'G__typename'),
          sendFollowRequest: sendFollowRequest,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GSendFollowRequestData_sendFollowRequest__base
    extends GSendFollowRequestData_sendFollowRequest__base {
  @override
  final String G__typename;

  factory _$GSendFollowRequestData_sendFollowRequest__base(
          [void Function(GSendFollowRequestData_sendFollowRequest__baseBuilder)?
              updates]) =>
      (GSendFollowRequestData_sendFollowRequest__baseBuilder()..update(updates))
          ._build();

  _$GSendFollowRequestData_sendFollowRequest__base._(
      {required this.G__typename})
      : super._();
  @override
  GSendFollowRequestData_sendFollowRequest__base rebuild(
          void Function(GSendFollowRequestData_sendFollowRequest__baseBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSendFollowRequestData_sendFollowRequest__baseBuilder toBuilder() =>
      GSendFollowRequestData_sendFollowRequest__baseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSendFollowRequestData_sendFollowRequest__base &&
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
            r'GSendFollowRequestData_sendFollowRequest__base')
          ..add('G__typename', G__typename))
        .toString();
  }
}

class GSendFollowRequestData_sendFollowRequest__baseBuilder
    implements
        Builder<GSendFollowRequestData_sendFollowRequest__base,
            GSendFollowRequestData_sendFollowRequest__baseBuilder> {
  _$GSendFollowRequestData_sendFollowRequest__base? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GSendFollowRequestData_sendFollowRequest__baseBuilder() {
    GSendFollowRequestData_sendFollowRequest__base._initializeBuilder(this);
  }

  GSendFollowRequestData_sendFollowRequest__baseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSendFollowRequestData_sendFollowRequest__base other) {
    _$v = other as _$GSendFollowRequestData_sendFollowRequest__base;
  }

  @override
  void update(
      void Function(GSendFollowRequestData_sendFollowRequest__baseBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GSendFollowRequestData_sendFollowRequest__base build() => _build();

  _$GSendFollowRequestData_sendFollowRequest__base _build() {
    final _$result = _$v ??
        _$GSendFollowRequestData_sendFollowRequest__base._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GSendFollowRequestData_sendFollowRequest__base', 'G__typename'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess
    extends GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess {
  @override
  final String G__typename;
  @override
  final GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data
      data;

  factory _$GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess(
          [void Function(
                  GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccessBuilder)?
              updates]) =>
      (GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccessBuilder()
            ..update(updates))
          ._build();

  _$GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess._(
      {required this.G__typename, required this.data})
      : super._();
  @override
  GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess
      rebuild(
              void Function(
                      GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccessBuilder)
                  updates) =>
          (toBuilder()..update(updates)).build();

  @override
  GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccessBuilder
      toBuilder() =>
          GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccessBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess &&
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
            r'GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess')
          ..add('G__typename', G__typename)
          ..add('data', data))
        .toString();
  }
}

class GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccessBuilder
    implements
        Builder<
            GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess,
            GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccessBuilder> {
  _$GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess?
      _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_dataBuilder?
      _data;
  GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_dataBuilder
      get data => _$this._data ??=
          GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_dataBuilder();
  set data(
          GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_dataBuilder?
              data) =>
      _$this._data = data;

  GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccessBuilder() {
    GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess
        ._initializeBuilder(this);
  }

  GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccessBuilder
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
      GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess
          other) {
    _$v = other
        as _$GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess;
  }

  @override
  void update(
      void Function(
              GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccessBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess
      build() => _build();

  _$GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess
      _build() {
    _$GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess
        _$result;
    try {
      _$result = _$v ??
          _$GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess
              ._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess',
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
            r'GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data
    extends GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data {
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

  factory _$GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data(
          [void Function(
                  GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_dataBuilder)?
              updates]) =>
      (GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_dataBuilder()
            ..update(updates))
          ._build();

  _$GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data._(
      {required this.G__typename,
      this.id,
      this.senderId,
      this.receiverId,
      this.status,
      this.createdAt})
      : super._();
  @override
  GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data
      rebuild(
              void Function(
                      GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_dataBuilder)
                  updates) =>
          (toBuilder()..update(updates)).build();

  @override
  GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_dataBuilder
      toBuilder() =>
          GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_dataBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data &&
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
            r'GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('senderId', senderId)
          ..add('receiverId', receiverId)
          ..add('status', status)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_dataBuilder
    implements
        Builder<
            GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data,
            GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_dataBuilder> {
  _$GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data?
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

  GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_dataBuilder() {
    GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data
        ._initializeBuilder(this);
  }

  GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_dataBuilder
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
      GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data
          other) {
    _$v = other
        as _$GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data;
  }

  @override
  void update(
      void Function(
              GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_dataBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data
      build() => _build();

  _$GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data
      _build() {
    final _$result = _$v ??
        _$GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data
            ._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GSendFollowRequestData_sendFollowRequest__asMutationSendFollowRequestSuccess_data',
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

class _$GSendFollowRequestData_sendFollowRequest__asValidationError
    extends GSendFollowRequestData_sendFollowRequest__asValidationError {
  @override
  final String G__typename;
  @override
  final String? message;
  @override
  final String? code;

  factory _$GSendFollowRequestData_sendFollowRequest__asValidationError(
          [void Function(
                  GSendFollowRequestData_sendFollowRequest__asValidationErrorBuilder)?
              updates]) =>
      (GSendFollowRequestData_sendFollowRequest__asValidationErrorBuilder()
            ..update(updates))
          ._build();

  _$GSendFollowRequestData_sendFollowRequest__asValidationError._(
      {required this.G__typename, this.message, this.code})
      : super._();
  @override
  GSendFollowRequestData_sendFollowRequest__asValidationError rebuild(
          void Function(
                  GSendFollowRequestData_sendFollowRequest__asValidationErrorBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSendFollowRequestData_sendFollowRequest__asValidationErrorBuilder
      toBuilder() =>
          GSendFollowRequestData_sendFollowRequest__asValidationErrorBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GSendFollowRequestData_sendFollowRequest__asValidationError &&
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
            r'GSendFollowRequestData_sendFollowRequest__asValidationError')
          ..add('G__typename', G__typename)
          ..add('message', message)
          ..add('code', code))
        .toString();
  }
}

class GSendFollowRequestData_sendFollowRequest__asValidationErrorBuilder
    implements
        Builder<GSendFollowRequestData_sendFollowRequest__asValidationError,
            GSendFollowRequestData_sendFollowRequest__asValidationErrorBuilder> {
  _$GSendFollowRequestData_sendFollowRequest__asValidationError? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  GSendFollowRequestData_sendFollowRequest__asValidationErrorBuilder() {
    GSendFollowRequestData_sendFollowRequest__asValidationError
        ._initializeBuilder(this);
  }

  GSendFollowRequestData_sendFollowRequest__asValidationErrorBuilder
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
      GSendFollowRequestData_sendFollowRequest__asValidationError other) {
    _$v =
        other as _$GSendFollowRequestData_sendFollowRequest__asValidationError;
  }

  @override
  void update(
      void Function(
              GSendFollowRequestData_sendFollowRequest__asValidationErrorBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GSendFollowRequestData_sendFollowRequest__asValidationError build() =>
      _build();

  _$GSendFollowRequestData_sendFollowRequest__asValidationError _build() {
    final _$result = _$v ??
        _$GSendFollowRequestData_sendFollowRequest__asValidationError._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GSendFollowRequestData_sendFollowRequest__asValidationError',
              'G__typename'),
          message: message,
          code: code,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
