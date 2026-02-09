// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_upload_credentials.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GGetUploadCredentialsData> _$gGetUploadCredentialsDataSerializer =
    _$GGetUploadCredentialsDataSerializer();
Serializer<GGetUploadCredentialsData_getUploadCredentials__base>
_$gGetUploadCredentialsDataGetUploadCredentialsBaseSerializer =
    _$GGetUploadCredentialsData_getUploadCredentials__baseSerializer();
Serializer<
  GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess
>
_$gGetUploadCredentialsDataGetUploadCredentialsAsQueryGetUploadCredentialsSuccessSerializer =
    _$GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccessSerializer();
Serializer<
  GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data
>
_$gGetUploadCredentialsDataGetUploadCredentialsAsQueryGetUploadCredentialsSuccessDataSerializer =
    _$GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_dataSerializer();
Serializer<GGetUploadCredentialsData_getUploadCredentials__asImageUploadError>
_$gGetUploadCredentialsDataGetUploadCredentialsAsImageUploadErrorSerializer =
    _$GGetUploadCredentialsData_getUploadCredentials__asImageUploadErrorSerializer();

class _$GGetUploadCredentialsDataSerializer
    implements StructuredSerializer<GGetUploadCredentialsData> {
  @override
  final Iterable<Type> types = const [
    GGetUploadCredentialsData,
    _$GGetUploadCredentialsData,
  ];
  @override
  final String wireName = 'GGetUploadCredentialsData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetUploadCredentialsData object, {
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
    value = object.getUploadCredentials;
    if (value != null) {
      result
        ..add('getUploadCredentials')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(
              GGetUploadCredentialsData_getUploadCredentials,
            ),
          ),
        );
    }
    return result;
  }

  @override
  GGetUploadCredentialsData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetUploadCredentialsDataBuilder();

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
        case 'getUploadCredentials':
          result.getUploadCredentials =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(
                      GGetUploadCredentialsData_getUploadCredentials,
                    ),
                  )
                  as GGetUploadCredentialsData_getUploadCredentials?;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetUploadCredentialsData_getUploadCredentials__baseSerializer
    implements
        StructuredSerializer<
          GGetUploadCredentialsData_getUploadCredentials__base
        > {
  @override
  final Iterable<Type> types = const [
    GGetUploadCredentialsData_getUploadCredentials__base,
    _$GGetUploadCredentialsData_getUploadCredentials__base,
  ];
  @override
  final String wireName =
      'GGetUploadCredentialsData_getUploadCredentials__base';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetUploadCredentialsData_getUploadCredentials__base object, {
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
  GGetUploadCredentialsData_getUploadCredentials__base deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result =
        GGetUploadCredentialsData_getUploadCredentials__baseBuilder();

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

class _$GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccessSerializer
    implements
        StructuredSerializer<
          GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess
        > {
  @override
  final Iterable<Type> types = const [
    GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess,
    _$GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess,
  ];
  @override
  final String wireName =
      'GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess
    object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'data',
      serializers.serialize(
        object.data,
        specifiedType: const FullType(
          GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data,
        ),
      ),
    ];

    return result;
  }

  @override
  GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess
  deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result =
        GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccessBuilder();

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
        case 'data':
          result.data.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data,
                  ),
                )!
                as GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_dataSerializer
    implements
        StructuredSerializer<
          GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data
        > {
  @override
  final Iterable<Type> types = const [
    GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data,
    _$GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data,
  ];
  @override
  final String wireName =
      'GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data
    object, {
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
    value = object.token;
    if (value != null) {
      result
        ..add('token')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.signature;
    if (value != null) {
      result
        ..add('signature')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.expire;
    if (value != null) {
      result
        ..add('expire')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.publicKey;
    if (value != null) {
      result
        ..add('publicKey')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.uploadEndpoint;
    if (value != null) {
      result
        ..add('uploadEndpoint')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data
  deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result =
        GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_dataBuilder();

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
        case 'token':
          result.token =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'signature':
          result.signature =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'expire':
          result.expire =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'publicKey':
          result.publicKey =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'uploadEndpoint':
          result.uploadEndpoint =
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

class _$GGetUploadCredentialsData_getUploadCredentials__asImageUploadErrorSerializer
    implements
        StructuredSerializer<
          GGetUploadCredentialsData_getUploadCredentials__asImageUploadError
        > {
  @override
  final Iterable<Type> types = const [
    GGetUploadCredentialsData_getUploadCredentials__asImageUploadError,
    _$GGetUploadCredentialsData_getUploadCredentials__asImageUploadError,
  ];
  @override
  final String wireName =
      'GGetUploadCredentialsData_getUploadCredentials__asImageUploadError';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetUploadCredentialsData_getUploadCredentials__asImageUploadError object, {
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
          serializers.serialize(value, specifiedType: const FullType(String)),
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
  GGetUploadCredentialsData_getUploadCredentials__asImageUploadError
  deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result =
        GGetUploadCredentialsData_getUploadCredentials__asImageUploadErrorBuilder();

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
                    specifiedType: const FullType(String),
                  )
                  as String?;
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

class _$GGetUploadCredentialsData extends GGetUploadCredentialsData {
  @override
  final String G__typename;
  @override
  final GGetUploadCredentialsData_getUploadCredentials? getUploadCredentials;

  factory _$GGetUploadCredentialsData([
    void Function(GGetUploadCredentialsDataBuilder)? updates,
  ]) => (GGetUploadCredentialsDataBuilder()..update(updates))._build();

  _$GGetUploadCredentialsData._({
    required this.G__typename,
    this.getUploadCredentials,
  }) : super._();
  @override
  GGetUploadCredentialsData rebuild(
    void Function(GGetUploadCredentialsDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetUploadCredentialsDataBuilder toBuilder() =>
      GGetUploadCredentialsDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetUploadCredentialsData &&
        G__typename == other.G__typename &&
        getUploadCredentials == other.getUploadCredentials;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, getUploadCredentials.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetUploadCredentialsData')
          ..add('G__typename', G__typename)
          ..add('getUploadCredentials', getUploadCredentials))
        .toString();
  }
}

class GGetUploadCredentialsDataBuilder
    implements
        Builder<GGetUploadCredentialsData, GGetUploadCredentialsDataBuilder> {
  _$GGetUploadCredentialsData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GGetUploadCredentialsData_getUploadCredentials? _getUploadCredentials;
  GGetUploadCredentialsData_getUploadCredentials? get getUploadCredentials =>
      _$this._getUploadCredentials;
  set getUploadCredentials(
    GGetUploadCredentialsData_getUploadCredentials? getUploadCredentials,
  ) => _$this._getUploadCredentials = getUploadCredentials;

  GGetUploadCredentialsDataBuilder() {
    GGetUploadCredentialsData._initializeBuilder(this);
  }

  GGetUploadCredentialsDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _getUploadCredentials = $v.getUploadCredentials;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetUploadCredentialsData other) {
    _$v = other as _$GGetUploadCredentialsData;
  }

  @override
  void update(void Function(GGetUploadCredentialsDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetUploadCredentialsData build() => _build();

  _$GGetUploadCredentialsData _build() {
    final _$result =
        _$v ??
        _$GGetUploadCredentialsData._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GGetUploadCredentialsData',
            'G__typename',
          ),
          getUploadCredentials: getUploadCredentials,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GGetUploadCredentialsData_getUploadCredentials__base
    extends GGetUploadCredentialsData_getUploadCredentials__base {
  @override
  final String G__typename;

  factory _$GGetUploadCredentialsData_getUploadCredentials__base([
    void Function(GGetUploadCredentialsData_getUploadCredentials__baseBuilder)?
    updates,
  ]) =>
      (GGetUploadCredentialsData_getUploadCredentials__baseBuilder()
            ..update(updates))
          ._build();

  _$GGetUploadCredentialsData_getUploadCredentials__base._({
    required this.G__typename,
  }) : super._();
  @override
  GGetUploadCredentialsData_getUploadCredentials__base rebuild(
    void Function(GGetUploadCredentialsData_getUploadCredentials__baseBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetUploadCredentialsData_getUploadCredentials__baseBuilder toBuilder() =>
      GGetUploadCredentialsData_getUploadCredentials__baseBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetUploadCredentialsData_getUploadCredentials__base &&
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
      r'GGetUploadCredentialsData_getUploadCredentials__base',
    )..add('G__typename', G__typename)).toString();
  }
}

class GGetUploadCredentialsData_getUploadCredentials__baseBuilder
    implements
        Builder<
          GGetUploadCredentialsData_getUploadCredentials__base,
          GGetUploadCredentialsData_getUploadCredentials__baseBuilder
        > {
  _$GGetUploadCredentialsData_getUploadCredentials__base? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GGetUploadCredentialsData_getUploadCredentials__baseBuilder() {
    GGetUploadCredentialsData_getUploadCredentials__base._initializeBuilder(
      this,
    );
  }

  GGetUploadCredentialsData_getUploadCredentials__baseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetUploadCredentialsData_getUploadCredentials__base other) {
    _$v = other as _$GGetUploadCredentialsData_getUploadCredentials__base;
  }

  @override
  void update(
    void Function(GGetUploadCredentialsData_getUploadCredentials__baseBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GGetUploadCredentialsData_getUploadCredentials__base build() => _build();

  _$GGetUploadCredentialsData_getUploadCredentials__base _build() {
    final _$result =
        _$v ??
        _$GGetUploadCredentialsData_getUploadCredentials__base._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GGetUploadCredentialsData_getUploadCredentials__base',
            'G__typename',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess
    extends
        GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess {
  @override
  final String G__typename;
  @override
  final GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data
  data;

  factory _$GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess([
    void Function(
      GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccessBuilder,
    )?
    updates,
  ]) =>
      (GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccessBuilder()
            ..update(updates))
          ._build();

  _$GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess._({
    required this.G__typename,
    required this.data,
  }) : super._();
  @override
  GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess
  rebuild(
    void Function(
      GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccessBuilder,
    )
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccessBuilder
  toBuilder() =>
      GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccessBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess &&
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
            r'GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess',
          )
          ..add('G__typename', G__typename)
          ..add('data', data))
        .toString();
  }
}

class GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccessBuilder
    implements
        Builder<
          GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess,
          GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccessBuilder
        > {
  _$GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess?
  _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_dataBuilder?
  _data;
  GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_dataBuilder
  get data => _$this._data ??=
      GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_dataBuilder();
  set data(
    GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_dataBuilder?
    data,
  ) => _$this._data = data;

  GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccessBuilder() {
    GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess._initializeBuilder(
      this,
    );
  }

  GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccessBuilder
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
    GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess
    other,
  ) {
    _$v =
        other
            as _$GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess;
  }

  @override
  void update(
    void Function(
      GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccessBuilder,
    )?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess
  build() => _build();

  _$GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess
  _build() {
    _$GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess
    _$result;
    try {
      _$result =
          _$v ??
          _$GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess',
              'G__typename',
            ),
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data
    extends
        GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data {
  @override
  final String G__typename;
  @override
  final String? token;
  @override
  final String? signature;
  @override
  final int? expire;
  @override
  final String? publicKey;
  @override
  final String? uploadEndpoint;

  factory _$GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data([
    void Function(
      GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_dataBuilder,
    )?
    updates,
  ]) =>
      (GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_dataBuilder()
            ..update(updates))
          ._build();

  _$GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data._({
    required this.G__typename,
    this.token,
    this.signature,
    this.expire,
    this.publicKey,
    this.uploadEndpoint,
  }) : super._();
  @override
  GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data
  rebuild(
    void Function(
      GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_dataBuilder,
    )
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_dataBuilder
  toBuilder() =>
      GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_dataBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data &&
        G__typename == other.G__typename &&
        token == other.token &&
        signature == other.signature &&
        expire == other.expire &&
        publicKey == other.publicKey &&
        uploadEndpoint == other.uploadEndpoint;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, signature.hashCode);
    _$hash = $jc(_$hash, expire.hashCode);
    _$hash = $jc(_$hash, publicKey.hashCode);
    _$hash = $jc(_$hash, uploadEndpoint.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data',
          )
          ..add('G__typename', G__typename)
          ..add('token', token)
          ..add('signature', signature)
          ..add('expire', expire)
          ..add('publicKey', publicKey)
          ..add('uploadEndpoint', uploadEndpoint))
        .toString();
  }
}

class GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_dataBuilder
    implements
        Builder<
          GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data,
          GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_dataBuilder
        > {
  _$GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data?
  _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  String? _signature;
  String? get signature => _$this._signature;
  set signature(String? signature) => _$this._signature = signature;

  int? _expire;
  int? get expire => _$this._expire;
  set expire(int? expire) => _$this._expire = expire;

  String? _publicKey;
  String? get publicKey => _$this._publicKey;
  set publicKey(String? publicKey) => _$this._publicKey = publicKey;

  String? _uploadEndpoint;
  String? get uploadEndpoint => _$this._uploadEndpoint;
  set uploadEndpoint(String? uploadEndpoint) =>
      _$this._uploadEndpoint = uploadEndpoint;

  GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_dataBuilder() {
    GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data._initializeBuilder(
      this,
    );
  }

  GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_dataBuilder
  get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _token = $v.token;
      _signature = $v.signature;
      _expire = $v.expire;
      _publicKey = $v.publicKey;
      _uploadEndpoint = $v.uploadEndpoint;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
    GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data
    other,
  ) {
    _$v =
        other
            as _$GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data;
  }

  @override
  void update(
    void Function(
      GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_dataBuilder,
    )?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data
  build() => _build();

  _$GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data
  _build() {
    final _$result =
        _$v ??
        _$GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GGetUploadCredentialsData_getUploadCredentials__asQueryGetUploadCredentialsSuccess_data',
            'G__typename',
          ),
          token: token,
          signature: signature,
          expire: expire,
          publicKey: publicKey,
          uploadEndpoint: uploadEndpoint,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GGetUploadCredentialsData_getUploadCredentials__asImageUploadError
    extends GGetUploadCredentialsData_getUploadCredentials__asImageUploadError {
  @override
  final String G__typename;
  @override
  final String? code;
  @override
  final String? message;

  factory _$GGetUploadCredentialsData_getUploadCredentials__asImageUploadError([
    void Function(
      GGetUploadCredentialsData_getUploadCredentials__asImageUploadErrorBuilder,
    )?
    updates,
  ]) =>
      (GGetUploadCredentialsData_getUploadCredentials__asImageUploadErrorBuilder()
            ..update(updates))
          ._build();

  _$GGetUploadCredentialsData_getUploadCredentials__asImageUploadError._({
    required this.G__typename,
    this.code,
    this.message,
  }) : super._();
  @override
  GGetUploadCredentialsData_getUploadCredentials__asImageUploadError rebuild(
    void Function(
      GGetUploadCredentialsData_getUploadCredentials__asImageUploadErrorBuilder,
    )
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetUploadCredentialsData_getUploadCredentials__asImageUploadErrorBuilder
  toBuilder() =>
      GGetUploadCredentialsData_getUploadCredentials__asImageUploadErrorBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GGetUploadCredentialsData_getUploadCredentials__asImageUploadError &&
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
            r'GGetUploadCredentialsData_getUploadCredentials__asImageUploadError',
          )
          ..add('G__typename', G__typename)
          ..add('code', code)
          ..add('message', message))
        .toString();
  }
}

class GGetUploadCredentialsData_getUploadCredentials__asImageUploadErrorBuilder
    implements
        Builder<
          GGetUploadCredentialsData_getUploadCredentials__asImageUploadError,
          GGetUploadCredentialsData_getUploadCredentials__asImageUploadErrorBuilder
        > {
  _$GGetUploadCredentialsData_getUploadCredentials__asImageUploadError? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  GGetUploadCredentialsData_getUploadCredentials__asImageUploadErrorBuilder() {
    GGetUploadCredentialsData_getUploadCredentials__asImageUploadError._initializeBuilder(
      this,
    );
  }

  GGetUploadCredentialsData_getUploadCredentials__asImageUploadErrorBuilder
  get _$this {
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
  void replace(
    GGetUploadCredentialsData_getUploadCredentials__asImageUploadError other,
  ) {
    _$v =
        other
            as _$GGetUploadCredentialsData_getUploadCredentials__asImageUploadError;
  }

  @override
  void update(
    void Function(
      GGetUploadCredentialsData_getUploadCredentials__asImageUploadErrorBuilder,
    )?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GGetUploadCredentialsData_getUploadCredentials__asImageUploadError build() =>
      _build();

  _$GGetUploadCredentialsData_getUploadCredentials__asImageUploadError
  _build() {
    final _$result =
        _$v ??
        _$GGetUploadCredentialsData_getUploadCredentials__asImageUploadError._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GGetUploadCredentialsData_getUploadCredentials__asImageUploadError',
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
