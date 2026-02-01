// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_book_by_isbn.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GSearchBookByISBNVars> _$gSearchBookByISBNVarsSerializer =
    new _$GSearchBookByISBNVarsSerializer();

class _$GSearchBookByISBNVarsSerializer
    implements StructuredSerializer<GSearchBookByISBNVars> {
  @override
  final Iterable<Type> types = const [
    GSearchBookByISBNVars,
    _$GSearchBookByISBNVars
  ];
  @override
  final String wireName = 'GSearchBookByISBNVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSearchBookByISBNVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'isbn',
      serializers.serialize(object.isbn, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GSearchBookByISBNVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSearchBookByISBNVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'isbn':
          result.isbn = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GSearchBookByISBNVars extends GSearchBookByISBNVars {
  @override
  final String isbn;

  factory _$GSearchBookByISBNVars(
          [void Function(GSearchBookByISBNVarsBuilder)? updates]) =>
      (new GSearchBookByISBNVarsBuilder()..update(updates))._build();

  _$GSearchBookByISBNVars._({required this.isbn}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        isbn, r'GSearchBookByISBNVars', 'isbn');
  }

  @override
  GSearchBookByISBNVars rebuild(
          void Function(GSearchBookByISBNVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSearchBookByISBNVarsBuilder toBuilder() =>
      new GSearchBookByISBNVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchBookByISBNVars && isbn == other.isbn;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, isbn.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSearchBookByISBNVars')
          ..add('isbn', isbn))
        .toString();
  }
}

class GSearchBookByISBNVarsBuilder
    implements Builder<GSearchBookByISBNVars, GSearchBookByISBNVarsBuilder> {
  _$GSearchBookByISBNVars? _$v;

  String? _isbn;
  String? get isbn => _$this._isbn;
  set isbn(String? isbn) => _$this._isbn = isbn;

  GSearchBookByISBNVarsBuilder();

  GSearchBookByISBNVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isbn = $v.isbn;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchBookByISBNVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSearchBookByISBNVars;
  }

  @override
  void update(void Function(GSearchBookByISBNVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchBookByISBNVars build() => _build();

  _$GSearchBookByISBNVars _build() {
    final _$result = _$v ??
        new _$GSearchBookByISBNVars._(
            isbn: BuiltValueNullFieldError.checkNotNull(
                isbn, r'GSearchBookByISBNVars', 'isbn'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
