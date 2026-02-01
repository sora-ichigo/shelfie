// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_detail.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GBookDetailVars> _$gBookDetailVarsSerializer =
    new _$GBookDetailVarsSerializer();

class _$GBookDetailVarsSerializer
    implements StructuredSerializer<GBookDetailVars> {
  @override
  final Iterable<Type> types = const [GBookDetailVars, _$GBookDetailVars];
  @override
  final String wireName = 'GBookDetailVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GBookDetailVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'bookId',
      serializers.serialize(object.bookId,
          specifiedType: const FullType(String)),
      'source',
      serializers.serialize(object.source,
          specifiedType: const FullType(_i1.GBookSource)),
    ];

    return result;
  }

  @override
  GBookDetailVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GBookDetailVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'bookId':
          result.bookId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'source':
          result.source = serializers.deserialize(value,
                  specifiedType: const FullType(_i1.GBookSource))!
              as _i1.GBookSource;
          break;
      }
    }

    return result.build();
  }
}

class _$GBookDetailVars extends GBookDetailVars {
  @override
  final String bookId;
  @override
  final _i1.GBookSource source;

  factory _$GBookDetailVars([void Function(GBookDetailVarsBuilder)? updates]) =>
      (new GBookDetailVarsBuilder()..update(updates))._build();

  _$GBookDetailVars._({required this.bookId, required this.source})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(bookId, r'GBookDetailVars', 'bookId');
    BuiltValueNullFieldError.checkNotNull(source, r'GBookDetailVars', 'source');
  }

  @override
  GBookDetailVars rebuild(void Function(GBookDetailVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GBookDetailVarsBuilder toBuilder() =>
      new GBookDetailVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GBookDetailVars &&
        bookId == other.bookId &&
        source == other.source;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, bookId.hashCode);
    _$hash = $jc(_$hash, source.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GBookDetailVars')
          ..add('bookId', bookId)
          ..add('source', source))
        .toString();
  }
}

class GBookDetailVarsBuilder
    implements Builder<GBookDetailVars, GBookDetailVarsBuilder> {
  _$GBookDetailVars? _$v;

  String? _bookId;
  String? get bookId => _$this._bookId;
  set bookId(String? bookId) => _$this._bookId = bookId;

  _i1.GBookSource? _source;
  _i1.GBookSource? get source => _$this._source;
  set source(_i1.GBookSource? source) => _$this._source = source;

  GBookDetailVarsBuilder();

  GBookDetailVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _bookId = $v.bookId;
      _source = $v.source;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GBookDetailVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GBookDetailVars;
  }

  @override
  void update(void Function(GBookDetailVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GBookDetailVars build() => _build();

  _$GBookDetailVars _build() {
    final _$result = _$v ??
        new _$GBookDetailVars._(
            bookId: BuiltValueNullFieldError.checkNotNull(
                bookId, r'GBookDetailVars', 'bookId'),
            source: BuiltValueNullFieldError.checkNotNull(
                source, r'GBookDetailVars', 'source'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
