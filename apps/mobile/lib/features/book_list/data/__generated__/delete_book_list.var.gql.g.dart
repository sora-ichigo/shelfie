// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_book_list.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GDeleteBookListVars> _$gDeleteBookListVarsSerializer =
    _$GDeleteBookListVarsSerializer();

class _$GDeleteBookListVarsSerializer
    implements StructuredSerializer<GDeleteBookListVars> {
  @override
  final Iterable<Type> types = const [
    GDeleteBookListVars,
    _$GDeleteBookListVars,
  ];
  @override
  final String wireName = 'GDeleteBookListVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GDeleteBookListVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'listId',
      serializers.serialize(object.listId, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GDeleteBookListVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GDeleteBookListVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'listId':
          result.listId =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GDeleteBookListVars extends GDeleteBookListVars {
  @override
  final int listId;

  factory _$GDeleteBookListVars([
    void Function(GDeleteBookListVarsBuilder)? updates,
  ]) => (GDeleteBookListVarsBuilder()..update(updates))._build();

  _$GDeleteBookListVars._({required this.listId}) : super._();
  @override
  GDeleteBookListVars rebuild(
    void Function(GDeleteBookListVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GDeleteBookListVarsBuilder toBuilder() =>
      GDeleteBookListVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GDeleteBookListVars && listId == other.listId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, listId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'GDeleteBookListVars',
    )..add('listId', listId)).toString();
  }
}

class GDeleteBookListVarsBuilder
    implements Builder<GDeleteBookListVars, GDeleteBookListVarsBuilder> {
  _$GDeleteBookListVars? _$v;

  int? _listId;
  int? get listId => _$this._listId;
  set listId(int? listId) => _$this._listId = listId;

  GDeleteBookListVarsBuilder();

  GDeleteBookListVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _listId = $v.listId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GDeleteBookListVars other) {
    _$v = other as _$GDeleteBookListVars;
  }

  @override
  void update(void Function(GDeleteBookListVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GDeleteBookListVars build() => _build();

  _$GDeleteBookListVars _build() {
    final _$result =
        _$v ??
        _$GDeleteBookListVars._(
          listId: BuiltValueNullFieldError.checkNotNull(
            listId,
            r'GDeleteBookListVars',
            'listId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
