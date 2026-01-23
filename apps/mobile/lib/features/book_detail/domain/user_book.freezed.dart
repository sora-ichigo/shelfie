// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_book.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserBook {
  /// 読書記録の ID
  int get id => throw _privateConstructorUsedError;

  /// 読書状態
  ReadingStatus get readingStatus => throw _privateConstructorUsedError;

  /// 本棚に追加した日時
  DateTime get addedAt => throw _privateConstructorUsedError;

  /// 読了日（readingStatus が completed の場合のみ設定）
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// 読書メモ
  String? get note => throw _privateConstructorUsedError;

  /// メモの最終更新日時
  DateTime? get noteUpdatedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserBookCopyWith<UserBook> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserBookCopyWith<$Res> {
  factory $UserBookCopyWith(UserBook value, $Res Function(UserBook) then) =
      _$UserBookCopyWithImpl<$Res, UserBook>;
  @useResult
  $Res call(
      {int id,
      ReadingStatus readingStatus,
      DateTime addedAt,
      DateTime? completedAt,
      String? note,
      DateTime? noteUpdatedAt});
}

/// @nodoc
class _$UserBookCopyWithImpl<$Res, $Val extends UserBook>
    implements $UserBookCopyWith<$Res> {
  _$UserBookCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? readingStatus = null,
    Object? addedAt = null,
    Object? completedAt = freezed,
    Object? note = freezed,
    Object? noteUpdatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      readingStatus: null == readingStatus
          ? _value.readingStatus
          : readingStatus // ignore: cast_nullable_to_non_nullable
              as ReadingStatus,
      addedAt: null == addedAt
          ? _value.addedAt
          : addedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      noteUpdatedAt: freezed == noteUpdatedAt
          ? _value.noteUpdatedAt
          : noteUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserBookImplCopyWith<$Res>
    implements $UserBookCopyWith<$Res> {
  factory _$$UserBookImplCopyWith(
          _$UserBookImpl value, $Res Function(_$UserBookImpl) then) =
      __$$UserBookImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      ReadingStatus readingStatus,
      DateTime addedAt,
      DateTime? completedAt,
      String? note,
      DateTime? noteUpdatedAt});
}

/// @nodoc
class __$$UserBookImplCopyWithImpl<$Res>
    extends _$UserBookCopyWithImpl<$Res, _$UserBookImpl>
    implements _$$UserBookImplCopyWith<$Res> {
  __$$UserBookImplCopyWithImpl(
      _$UserBookImpl _value, $Res Function(_$UserBookImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? readingStatus = null,
    Object? addedAt = null,
    Object? completedAt = freezed,
    Object? note = freezed,
    Object? noteUpdatedAt = freezed,
  }) {
    return _then(_$UserBookImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      readingStatus: null == readingStatus
          ? _value.readingStatus
          : readingStatus // ignore: cast_nullable_to_non_nullable
              as ReadingStatus,
      addedAt: null == addedAt
          ? _value.addedAt
          : addedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      noteUpdatedAt: freezed == noteUpdatedAt
          ? _value.noteUpdatedAt
          : noteUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$UserBookImpl extends _UserBook {
  const _$UserBookImpl(
      {required this.id,
      required this.readingStatus,
      required this.addedAt,
      this.completedAt,
      this.note,
      this.noteUpdatedAt})
      : super._();

  /// 読書記録の ID
  @override
  final int id;

  /// 読書状態
  @override
  final ReadingStatus readingStatus;

  /// 本棚に追加した日時
  @override
  final DateTime addedAt;

  /// 読了日（readingStatus が completed の場合のみ設定）
  @override
  final DateTime? completedAt;

  /// 読書メモ
  @override
  final String? note;

  /// メモの最終更新日時
  @override
  final DateTime? noteUpdatedAt;

  @override
  String toString() {
    return 'UserBook(id: $id, readingStatus: $readingStatus, addedAt: $addedAt, completedAt: $completedAt, note: $note, noteUpdatedAt: $noteUpdatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserBookImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.readingStatus, readingStatus) ||
                other.readingStatus == readingStatus) &&
            (identical(other.addedAt, addedAt) || other.addedAt == addedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.noteUpdatedAt, noteUpdatedAt) ||
                other.noteUpdatedAt == noteUpdatedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, readingStatus, addedAt,
      completedAt, note, noteUpdatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserBookImplCopyWith<_$UserBookImpl> get copyWith =>
      __$$UserBookImplCopyWithImpl<_$UserBookImpl>(this, _$identity);
}

abstract class _UserBook extends UserBook {
  const factory _UserBook(
      {required final int id,
      required final ReadingStatus readingStatus,
      required final DateTime addedAt,
      final DateTime? completedAt,
      final String? note,
      final DateTime? noteUpdatedAt}) = _$UserBookImpl;
  const _UserBook._() : super._();

  @override

  /// 読書記録の ID
  int get id;
  @override

  /// 読書状態
  ReadingStatus get readingStatus;
  @override

  /// 本棚に追加した日時
  DateTime get addedAt;
  @override

  /// 読了日（readingStatus が completed の場合のみ設定）
  DateTime? get completedAt;
  @override

  /// 読書メモ
  String? get note;
  @override

  /// メモの最終更新日時
  DateTime? get noteUpdatedAt;
  @override
  @JsonKey(ignore: true)
  _$$UserBookImplCopyWith<_$UserBookImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
