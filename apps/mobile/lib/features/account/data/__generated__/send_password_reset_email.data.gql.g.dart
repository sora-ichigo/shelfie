// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_password_reset_email.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GSendPasswordResetEmailData>
    _$gSendPasswordResetEmailDataSerializer =
    new _$GSendPasswordResetEmailDataSerializer();
Serializer<GSendPasswordResetEmailData_sendPasswordResetEmail__base>
    _$gSendPasswordResetEmailDataSendPasswordResetEmailBaseSerializer =
    new _$GSendPasswordResetEmailData_sendPasswordResetEmail__baseSerializer();
Serializer<
        GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess>
    _$gSendPasswordResetEmailDataSendPasswordResetEmailAsMutationSendPasswordResetEmailSuccessSerializer =
    new _$GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccessSerializer();
Serializer<
        GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data>
    _$gSendPasswordResetEmailDataSendPasswordResetEmailAsMutationSendPasswordResetEmailSuccessDataSerializer =
    new _$GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_dataSerializer();
Serializer<GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError>
    _$gSendPasswordResetEmailDataSendPasswordResetEmailAsAuthErrorSerializer =
    new _$GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthErrorSerializer();

class _$GSendPasswordResetEmailDataSerializer
    implements StructuredSerializer<GSendPasswordResetEmailData> {
  @override
  final Iterable<Type> types = const [
    GSendPasswordResetEmailData,
    _$GSendPasswordResetEmailData
  ];
  @override
  final String wireName = 'GSendPasswordResetEmailData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSendPasswordResetEmailData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.sendPasswordResetEmail;
    if (value != null) {
      result
        ..add('sendPasswordResetEmail')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                GSendPasswordResetEmailData_sendPasswordResetEmail)));
    }
    return result;
  }

  @override
  GSendPasswordResetEmailData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSendPasswordResetEmailDataBuilder();

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
        case 'sendPasswordResetEmail':
          result.sendPasswordResetEmail = serializers.deserialize(value,
                  specifiedType: const FullType(
                      GSendPasswordResetEmailData_sendPasswordResetEmail))
              as GSendPasswordResetEmailData_sendPasswordResetEmail?;
          break;
      }
    }

    return result.build();
  }
}

class _$GSendPasswordResetEmailData_sendPasswordResetEmail__baseSerializer
    implements
        StructuredSerializer<
            GSendPasswordResetEmailData_sendPasswordResetEmail__base> {
  @override
  final Iterable<Type> types = const [
    GSendPasswordResetEmailData_sendPasswordResetEmail__base,
    _$GSendPasswordResetEmailData_sendPasswordResetEmail__base
  ];
  @override
  final String wireName =
      'GSendPasswordResetEmailData_sendPasswordResetEmail__base';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GSendPasswordResetEmailData_sendPasswordResetEmail__base object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GSendPasswordResetEmailData_sendPasswordResetEmail__base deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GSendPasswordResetEmailData_sendPasswordResetEmail__baseBuilder();

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

class _$GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccessSerializer
    implements
        StructuredSerializer<
            GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess> {
  @override
  final Iterable<Type> types = const [
    GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess,
    _$GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess
  ];
  @override
  final String wireName =
      'GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess';

  @override
  Iterable<Object?> serialize(
      Serializers serializers,
      GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess
          object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data)),
    ];

    return result;
  }

  @override
  GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess
      deserialize(Serializers serializers, Iterable<Object?> serialized,
          {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccessBuilder();

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
                      GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data))!
              as GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data);
          break;
      }
    }

    return result.build();
  }
}

class _$GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_dataSerializer
    implements
        StructuredSerializer<
            GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data> {
  @override
  final Iterable<Type> types = const [
    GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data,
    _$GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data
  ];
  @override
  final String wireName =
      'GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data';

  @override
  Iterable<Object?> serialize(
      Serializers serializers,
      GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data
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
  GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data
      deserialize(Serializers serializers, Iterable<Object?> serialized,
          {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_dataBuilder();

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

class _$GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthErrorSerializer
    implements
        StructuredSerializer<
            GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError> {
  @override
  final Iterable<Type> types = const [
    GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError,
    _$GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError
  ];
  @override
  final String wireName =
      'GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError object,
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
    value = object.field;
    if (value != null) {
      result
        ..add('field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.retryable;
    if (value != null) {
      result
        ..add('retryable')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthErrorBuilder();

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
        case 'field':
          result.field = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'retryable':
          result.retryable = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
      }
    }

    return result.build();
  }
}

class _$GSendPasswordResetEmailData extends GSendPasswordResetEmailData {
  @override
  final String G__typename;
  @override
  final GSendPasswordResetEmailData_sendPasswordResetEmail?
      sendPasswordResetEmail;

  factory _$GSendPasswordResetEmailData(
          [void Function(GSendPasswordResetEmailDataBuilder)? updates]) =>
      (new GSendPasswordResetEmailDataBuilder()..update(updates))._build();

  _$GSendPasswordResetEmailData._(
      {required this.G__typename, this.sendPasswordResetEmail})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GSendPasswordResetEmailData', 'G__typename');
  }

  @override
  GSendPasswordResetEmailData rebuild(
          void Function(GSendPasswordResetEmailDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSendPasswordResetEmailDataBuilder toBuilder() =>
      new GSendPasswordResetEmailDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSendPasswordResetEmailData &&
        G__typename == other.G__typename &&
        sendPasswordResetEmail == other.sendPasswordResetEmail;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, sendPasswordResetEmail.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSendPasswordResetEmailData')
          ..add('G__typename', G__typename)
          ..add('sendPasswordResetEmail', sendPasswordResetEmail))
        .toString();
  }
}

class GSendPasswordResetEmailDataBuilder
    implements
        Builder<GSendPasswordResetEmailData,
            GSendPasswordResetEmailDataBuilder> {
  _$GSendPasswordResetEmailData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GSendPasswordResetEmailData_sendPasswordResetEmail? _sendPasswordResetEmail;
  GSendPasswordResetEmailData_sendPasswordResetEmail?
      get sendPasswordResetEmail => _$this._sendPasswordResetEmail;
  set sendPasswordResetEmail(
          GSendPasswordResetEmailData_sendPasswordResetEmail?
              sendPasswordResetEmail) =>
      _$this._sendPasswordResetEmail = sendPasswordResetEmail;

  GSendPasswordResetEmailDataBuilder() {
    GSendPasswordResetEmailData._initializeBuilder(this);
  }

  GSendPasswordResetEmailDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _sendPasswordResetEmail = $v.sendPasswordResetEmail;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSendPasswordResetEmailData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSendPasswordResetEmailData;
  }

  @override
  void update(void Function(GSendPasswordResetEmailDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSendPasswordResetEmailData build() => _build();

  _$GSendPasswordResetEmailData _build() {
    final _$result = _$v ??
        new _$GSendPasswordResetEmailData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GSendPasswordResetEmailData', 'G__typename'),
            sendPasswordResetEmail: sendPasswordResetEmail);
    replace(_$result);
    return _$result;
  }
}

class _$GSendPasswordResetEmailData_sendPasswordResetEmail__base
    extends GSendPasswordResetEmailData_sendPasswordResetEmail__base {
  @override
  final String G__typename;

  factory _$GSendPasswordResetEmailData_sendPasswordResetEmail__base(
          [void Function(
                  GSendPasswordResetEmailData_sendPasswordResetEmail__baseBuilder)?
              updates]) =>
      (new GSendPasswordResetEmailData_sendPasswordResetEmail__baseBuilder()
            ..update(updates))
          ._build();

  _$GSendPasswordResetEmailData_sendPasswordResetEmail__base._(
      {required this.G__typename})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename,
        r'GSendPasswordResetEmailData_sendPasswordResetEmail__base',
        'G__typename');
  }

  @override
  GSendPasswordResetEmailData_sendPasswordResetEmail__base rebuild(
          void Function(
                  GSendPasswordResetEmailData_sendPasswordResetEmail__baseBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSendPasswordResetEmailData_sendPasswordResetEmail__baseBuilder toBuilder() =>
      new GSendPasswordResetEmailData_sendPasswordResetEmail__baseBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSendPasswordResetEmailData_sendPasswordResetEmail__base &&
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
            r'GSendPasswordResetEmailData_sendPasswordResetEmail__base')
          ..add('G__typename', G__typename))
        .toString();
  }
}

class GSendPasswordResetEmailData_sendPasswordResetEmail__baseBuilder
    implements
        Builder<GSendPasswordResetEmailData_sendPasswordResetEmail__base,
            GSendPasswordResetEmailData_sendPasswordResetEmail__baseBuilder> {
  _$GSendPasswordResetEmailData_sendPasswordResetEmail__base? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GSendPasswordResetEmailData_sendPasswordResetEmail__baseBuilder() {
    GSendPasswordResetEmailData_sendPasswordResetEmail__base._initializeBuilder(
        this);
  }

  GSendPasswordResetEmailData_sendPasswordResetEmail__baseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSendPasswordResetEmailData_sendPasswordResetEmail__base other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSendPasswordResetEmailData_sendPasswordResetEmail__base;
  }

  @override
  void update(
      void Function(
              GSendPasswordResetEmailData_sendPasswordResetEmail__baseBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GSendPasswordResetEmailData_sendPasswordResetEmail__base build() => _build();

  _$GSendPasswordResetEmailData_sendPasswordResetEmail__base _build() {
    final _$result = _$v ??
        new _$GSendPasswordResetEmailData_sendPasswordResetEmail__base._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GSendPasswordResetEmailData_sendPasswordResetEmail__base',
                'G__typename'));
    replace(_$result);
    return _$result;
  }
}

class _$GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess
    extends GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess {
  @override
  final String G__typename;
  @override
  final GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data
      data;

  factory _$GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess(
          [void Function(
                  GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccessBuilder)?
              updates]) =>
      (new GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccessBuilder()
            ..update(updates))
          ._build();

  _$GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess._(
      {required this.G__typename, required this.data})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename,
        r'GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess',
        'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        data,
        r'GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess',
        'data');
  }

  @override
  GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess
      rebuild(
              void Function(
                      GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccessBuilder)
                  updates) =>
          (toBuilder()..update(updates)).build();

  @override
  GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccessBuilder
      toBuilder() =>
          new GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccessBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess &&
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
            r'GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess')
          ..add('G__typename', G__typename)
          ..add('data', data))
        .toString();
  }
}

class GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccessBuilder
    implements
        Builder<
            GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess,
            GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccessBuilder> {
  _$GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess?
      _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_dataBuilder?
      _data;
  GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_dataBuilder
      get data => _$this._data ??=
          new GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_dataBuilder();
  set data(
          GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_dataBuilder?
              data) =>
      _$this._data = data;

  GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccessBuilder() {
    GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess
        ._initializeBuilder(this);
  }

  GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccessBuilder
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
      GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess
          other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other
        as _$GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess;
  }

  @override
  void update(
      void Function(
              GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccessBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess
      build() => _build();

  _$GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess
      _build() {
    _$GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess
        _$result;
    try {
      _$result = _$v ??
          new _$GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess
              ._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename,
                  r'GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess',
                  'G__typename'),
              data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data
    extends GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data {
  @override
  final String G__typename;
  @override
  final bool? success;

  factory _$GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data(
          [void Function(
                  GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_dataBuilder)?
              updates]) =>
      (new GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_dataBuilder()
            ..update(updates))
          ._build();

  _$GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data._(
      {required this.G__typename, this.success})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename,
        r'GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data',
        'G__typename');
  }

  @override
  GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data
      rebuild(
              void Function(
                      GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_dataBuilder)
                  updates) =>
          (toBuilder()..update(updates)).build();

  @override
  GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_dataBuilder
      toBuilder() =>
          new GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_dataBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data &&
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
            r'GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data')
          ..add('G__typename', G__typename)
          ..add('success', success))
        .toString();
  }
}

class GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_dataBuilder
    implements
        Builder<
            GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data,
            GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_dataBuilder> {
  _$GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data?
      _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_dataBuilder() {
    GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data
        ._initializeBuilder(this);
  }

  GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_dataBuilder
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
      GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data
          other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other
        as _$GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data;
  }

  @override
  void update(
      void Function(
              GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_dataBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data
      build() => _build();

  _$GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data
      _build() {
    final _$result = _$v ??
        new _$GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data
            ._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GSendPasswordResetEmailData_sendPasswordResetEmail__asMutationSendPasswordResetEmailSuccess_data',
                'G__typename'),
            success: success);
    replace(_$result);
    return _$result;
  }
}

class _$GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError
    extends GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError {
  @override
  final String G__typename;
  @override
  final _i3.GAuthErrorCode? code;
  @override
  final String? message;
  @override
  final String? field;
  @override
  final bool? retryable;

  factory _$GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError(
          [void Function(
                  GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthErrorBuilder)?
              updates]) =>
      (new GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthErrorBuilder()
            ..update(updates))
          ._build();

  _$GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError._(
      {required this.G__typename,
      this.code,
      this.message,
      this.field,
      this.retryable})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename,
        r'GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError',
        'G__typename');
  }

  @override
  GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError rebuild(
          void Function(
                  GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthErrorBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthErrorBuilder
      toBuilder() =>
          new GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthErrorBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError &&
        G__typename == other.G__typename &&
        code == other.code &&
        message == other.message &&
        field == other.field &&
        retryable == other.retryable;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, field.hashCode);
    _$hash = $jc(_$hash, retryable.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError')
          ..add('G__typename', G__typename)
          ..add('code', code)
          ..add('message', message)
          ..add('field', field)
          ..add('retryable', retryable))
        .toString();
  }
}

class GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthErrorBuilder
    implements
        Builder<GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError,
            GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthErrorBuilder> {
  _$GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  _i3.GAuthErrorCode? _code;
  _i3.GAuthErrorCode? get code => _$this._code;
  set code(_i3.GAuthErrorCode? code) => _$this._code = code;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _field;
  String? get field => _$this._field;
  set field(String? field) => _$this._field = field;

  bool? _retryable;
  bool? get retryable => _$this._retryable;
  set retryable(bool? retryable) => _$this._retryable = retryable;

  GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthErrorBuilder() {
    GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError
        ._initializeBuilder(this);
  }

  GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthErrorBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _code = $v.code;
      _message = $v.message;
      _field = $v.field;
      _retryable = $v.retryable;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other
        as _$GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError;
  }

  @override
  void update(
      void Function(
              GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthErrorBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError build() =>
      _build();

  _$GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError _build() {
    final _$result = _$v ??
        new _$GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GSendPasswordResetEmailData_sendPasswordResetEmail__asAuthError',
                'G__typename'),
            code: code,
            message: message,
            field: field,
            retryable: retryable);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
