// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_reading_note.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GUpdateReadingNoteVars> _$gUpdateReadingNoteVarsSerializer =
    new _$GUpdateReadingNoteVarsSerializer();

class _$GUpdateReadingNoteVarsSerializer
    implements StructuredSerializer<GUpdateReadingNoteVars> {
  @override
  final Iterable<Type> types = const [
    GUpdateReadingNoteVars,
    _$GUpdateReadingNoteVars
  ];
  @override
  final String wireName = 'GUpdateReadingNoteVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateReadingNoteVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'userBookId',
      serializers.serialize(object.userBookId,
          specifiedType: const FullType(int)),
      'note',
      serializers.serialize(object.note, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GUpdateReadingNoteVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateReadingNoteVarsBuilder();

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
        case 'note':
          result.note = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateReadingNoteVars extends GUpdateReadingNoteVars {
  @override
  final int userBookId;
  @override
  final String note;

  factory _$GUpdateReadingNoteVars(
          [void Function(GUpdateReadingNoteVarsBuilder)? updates]) =>
      (new GUpdateReadingNoteVarsBuilder()..update(updates))._build();

  _$GUpdateReadingNoteVars._({required this.userBookId, required this.note})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        userBookId, r'GUpdateReadingNoteVars', 'userBookId');
    BuiltValueNullFieldError.checkNotNull(
        note, r'GUpdateReadingNoteVars', 'note');
  }

  @override
  GUpdateReadingNoteVars rebuild(
          void Function(GUpdateReadingNoteVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateReadingNoteVarsBuilder toBuilder() =>
      new GUpdateReadingNoteVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateReadingNoteVars &&
        userBookId == other.userBookId &&
        note == other.note;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userBookId.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateReadingNoteVars')
          ..add('userBookId', userBookId)
          ..add('note', note))
        .toString();
  }
}

class GUpdateReadingNoteVarsBuilder
    implements Builder<GUpdateReadingNoteVars, GUpdateReadingNoteVarsBuilder> {
  _$GUpdateReadingNoteVars? _$v;

  int? _userBookId;
  int? get userBookId => _$this._userBookId;
  set userBookId(int? userBookId) => _$this._userBookId = userBookId;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  GUpdateReadingNoteVarsBuilder();

  GUpdateReadingNoteVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userBookId = $v.userBookId;
      _note = $v.note;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateReadingNoteVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateReadingNoteVars;
  }

  @override
  void update(void Function(GUpdateReadingNoteVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateReadingNoteVars build() => _build();

  _$GUpdateReadingNoteVars _build() {
    final _$result = _$v ??
        new _$GUpdateReadingNoteVars._(
            userBookId: BuiltValueNullFieldError.checkNotNull(
                userBookId, r'GUpdateReadingNoteVars', 'userBookId'),
            note: BuiltValueNullFieldError.checkNotNull(
                note, r'GUpdateReadingNoteVars', 'note'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
