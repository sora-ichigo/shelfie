// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_books.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GSearchBooksVars> _$gSearchBooksVarsSerializer =
    new _$GSearchBooksVarsSerializer();

class _$GSearchBooksVarsSerializer
    implements StructuredSerializer<GSearchBooksVars> {
  @override
  final Iterable<Type> types = const [GSearchBooksVars, _$GSearchBooksVars];
  @override
  final String wireName = 'GSearchBooksVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GSearchBooksVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'query',
      serializers.serialize(object.query,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.limit;
    if (value != null) {
      result
        ..add('limit')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.offset;
    if (value != null) {
      result
        ..add('offset')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  GSearchBooksVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSearchBooksVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'query':
          result.query = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'limit':
          result.limit = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'offset':
          result.offset = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$GSearchBooksVars extends GSearchBooksVars {
  @override
  final String query;
  @override
  final int? limit;
  @override
  final int? offset;

  factory _$GSearchBooksVars(
          [void Function(GSearchBooksVarsBuilder)? updates]) =>
      (new GSearchBooksVarsBuilder()..update(updates))._build();

  _$GSearchBooksVars._({required this.query, this.limit, this.offset})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(query, r'GSearchBooksVars', 'query');
  }

  @override
  GSearchBooksVars rebuild(void Function(GSearchBooksVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSearchBooksVarsBuilder toBuilder() =>
      new GSearchBooksVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchBooksVars &&
        query == other.query &&
        limit == other.limit &&
        offset == other.offset;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, query.hashCode);
    _$hash = $jc(_$hash, limit.hashCode);
    _$hash = $jc(_$hash, offset.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSearchBooksVars')
          ..add('query', query)
          ..add('limit', limit)
          ..add('offset', offset))
        .toString();
  }
}

class GSearchBooksVarsBuilder
    implements Builder<GSearchBooksVars, GSearchBooksVarsBuilder> {
  _$GSearchBooksVars? _$v;

  String? _query;
  String? get query => _$this._query;
  set query(String? query) => _$this._query = query;

  int? _limit;
  int? get limit => _$this._limit;
  set limit(int? limit) => _$this._limit = limit;

  int? _offset;
  int? get offset => _$this._offset;
  set offset(int? offset) => _$this._offset = offset;

  GSearchBooksVarsBuilder();

  GSearchBooksVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _query = $v.query;
      _limit = $v.limit;
      _offset = $v.offset;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchBooksVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSearchBooksVars;
  }

  @override
  void update(void Function(GSearchBooksVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchBooksVars build() => _build();

  _$GSearchBooksVars _build() {
    final _$result = _$v ??
        new _$GSearchBooksVars._(
            query: BuiltValueNullFieldError.checkNotNull(
                query, r'GSearchBooksVars', 'query'),
            limit: limit,
            offset: offset);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
