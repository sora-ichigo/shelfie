// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_rating.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GUpdateBookRatingVars> _$gUpdateBookRatingVarsSerializer =
    _$GUpdateBookRatingVarsSerializer();

class _$GUpdateBookRatingVarsSerializer
    implements StructuredSerializer<GUpdateBookRatingVars> {
  @override
  final Iterable<Type> types = const [
    GUpdateBookRatingVars,
    _$GUpdateBookRatingVars
  ];
  @override
  final String wireName = 'GUpdateBookRatingVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateBookRatingVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'userBookId',
      serializers.serialize(object.userBookId,
          specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.rating;
    if (value != null) {
      result
        ..add('rating')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  GUpdateBookRatingVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUpdateBookRatingVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'userBookId':
          result.userBookId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'rating':
          result.rating = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateBookRatingVars extends GUpdateBookRatingVars {
  @override
  final int userBookId;
  @override
  final int? rating;

  factory _$GUpdateBookRatingVars(
          [void Function(GUpdateBookRatingVarsBuilder)? updates]) =>
      (GUpdateBookRatingVarsBuilder()..update(updates))._build();

  _$GUpdateBookRatingVars._({required this.userBookId, this.rating})
      : super._();
  @override
  GUpdateBookRatingVars rebuild(
          void Function(GUpdateBookRatingVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateBookRatingVarsBuilder toBuilder() =>
      GUpdateBookRatingVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateBookRatingVars &&
        userBookId == other.userBookId &&
        rating == other.rating;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userBookId.hashCode);
    _$hash = $jc(_$hash, rating.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateBookRatingVars')
          ..add('userBookId', userBookId)
          ..add('rating', rating))
        .toString();
  }
}

class GUpdateBookRatingVarsBuilder
    implements Builder<GUpdateBookRatingVars, GUpdateBookRatingVarsBuilder> {
  _$GUpdateBookRatingVars? _$v;

  int? _userBookId;
  int? get userBookId => _$this._userBookId;
  set userBookId(int? userBookId) => _$this._userBookId = userBookId;

  int? _rating;
  int? get rating => _$this._rating;
  set rating(int? rating) => _$this._rating = rating;

  GUpdateBookRatingVarsBuilder();

  GUpdateBookRatingVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userBookId = $v.userBookId;
      _rating = $v.rating;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateBookRatingVars other) {
    _$v = other as _$GUpdateBookRatingVars;
  }

  @override
  void update(void Function(GUpdateBookRatingVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateBookRatingVars build() => _build();

  _$GUpdateBookRatingVars _build() {
    final _$result = _$v ??
        _$GUpdateBookRatingVars._(
          userBookId: BuiltValueNullFieldError.checkNotNull(
              userBookId, r'GUpdateBookRatingVars', 'userBookId'),
          rating: rating,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
