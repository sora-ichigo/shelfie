// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_detail.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GBookDetailVars> _$gBookDetailVarsSerializer =
    _$GBookDetailVarsSerializer();

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
    ];

    return result;
  }

  @override
  GBookDetailVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GBookDetailVarsBuilder();

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
      }
    }

    return result.build();
  }
}

class _$GBookDetailVars extends GBookDetailVars {
  @override
  final String bookId;

  factory _$GBookDetailVars([void Function(GBookDetailVarsBuilder)? updates]) =>
      (GBookDetailVarsBuilder()..update(updates))._build();

  _$GBookDetailVars._({required this.bookId}) : super._();
  @override
  GBookDetailVars rebuild(void Function(GBookDetailVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GBookDetailVarsBuilder toBuilder() => GBookDetailVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GBookDetailVars && bookId == other.bookId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, bookId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GBookDetailVars')
          ..add('bookId', bookId))
        .toString();
  }
}

class GBookDetailVarsBuilder
    implements Builder<GBookDetailVars, GBookDetailVarsBuilder> {
  _$GBookDetailVars? _$v;

  String? _bookId;
  String? get bookId => _$this._bookId;
  set bookId(String? bookId) => _$this._bookId = bookId;

  GBookDetailVarsBuilder();

  GBookDetailVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _bookId = $v.bookId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GBookDetailVars other) {
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
        _$GBookDetailVars._(
          bookId: BuiltValueNullFieldError.checkNotNull(
              bookId, r'GBookDetailVars', 'bookId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
