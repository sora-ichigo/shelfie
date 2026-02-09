// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_book_to_shelf.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GAddBookToShelfVars> _$gAddBookToShelfVarsSerializer =
    _$GAddBookToShelfVarsSerializer();

class _$GAddBookToShelfVarsSerializer
    implements StructuredSerializer<GAddBookToShelfVars> {
  @override
  final Iterable<Type> types = const [
    GAddBookToShelfVars,
    _$GAddBookToShelfVars,
  ];
  @override
  final String wireName = 'GAddBookToShelfVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GAddBookToShelfVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'bookInput',
      serializers.serialize(
        object.bookInput,
        specifiedType: const FullType(_i1.GAddBookInput),
      ),
    ];

    return result;
  }

  @override
  GAddBookToShelfVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GAddBookToShelfVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'bookInput':
          result.bookInput.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i1.GAddBookInput),
                )!
                as _i1.GAddBookInput,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GAddBookToShelfVars extends GAddBookToShelfVars {
  @override
  final _i1.GAddBookInput bookInput;

  factory _$GAddBookToShelfVars([
    void Function(GAddBookToShelfVarsBuilder)? updates,
  ]) => (GAddBookToShelfVarsBuilder()..update(updates))._build();

  _$GAddBookToShelfVars._({required this.bookInput}) : super._();
  @override
  GAddBookToShelfVars rebuild(
    void Function(GAddBookToShelfVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GAddBookToShelfVarsBuilder toBuilder() =>
      GAddBookToShelfVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAddBookToShelfVars && bookInput == other.bookInput;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, bookInput.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'GAddBookToShelfVars',
    )..add('bookInput', bookInput)).toString();
  }
}

class GAddBookToShelfVarsBuilder
    implements Builder<GAddBookToShelfVars, GAddBookToShelfVarsBuilder> {
  _$GAddBookToShelfVars? _$v;

  _i1.GAddBookInputBuilder? _bookInput;
  _i1.GAddBookInputBuilder get bookInput =>
      _$this._bookInput ??= _i1.GAddBookInputBuilder();
  set bookInput(_i1.GAddBookInputBuilder? bookInput) =>
      _$this._bookInput = bookInput;

  GAddBookToShelfVarsBuilder();

  GAddBookToShelfVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _bookInput = $v.bookInput.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAddBookToShelfVars other) {
    _$v = other as _$GAddBookToShelfVars;
  }

  @override
  void update(void Function(GAddBookToShelfVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAddBookToShelfVars build() => _build();

  _$GAddBookToShelfVars _build() {
    _$GAddBookToShelfVars _$result;
    try {
      _$result = _$v ?? _$GAddBookToShelfVars._(bookInput: bookInput.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'bookInput';
        bookInput.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GAddBookToShelfVars',
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

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
