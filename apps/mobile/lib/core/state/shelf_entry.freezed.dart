// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shelf_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ShelfEntry {
  /// 読書記録の ID（userBookId）
  int get userBookId => throw _privateConstructorUsedError;

  /// 外部 ID（Google Books ID など）
  String get externalId => throw _privateConstructorUsedError;

  /// 読書状態
  ReadingStatus get readingStatus => throw _privateConstructorUsedError;

  /// 本棚に追加した日時
  DateTime get addedAt => throw _privateConstructorUsedError;

  /// 読書開始日（readingStatus が reading に変更された初回のみ設定）
  DateTime? get startedAt => throw _privateConstructorUsedError;

  /// 読了日（readingStatus が completed の場合のみ設定）
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// 読書メモ
  String? get note => throw _privateConstructorUsedError;

  /// メモの最終更新日時
  DateTime? get noteUpdatedAt => throw _privateConstructorUsedError;

  /// 評価（1-5）
  int? get rating => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ShelfEntryCopyWith<ShelfEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShelfEntryCopyWith<$Res> {
  factory $ShelfEntryCopyWith(
          ShelfEntry value, $Res Function(ShelfEntry) then) =
      _$ShelfEntryCopyWithImpl<$Res, ShelfEntry>;
  @useResult
  $Res call(
      {int userBookId,
      String externalId,
      ReadingStatus readingStatus,
      DateTime addedAt,
      DateTime? startedAt,
      DateTime? completedAt,
      String? note,
      DateTime? noteUpdatedAt,
      int? rating});
}

/// @nodoc
class _$ShelfEntryCopyWithImpl<$Res, $Val extends ShelfEntry>
    implements $ShelfEntryCopyWith<$Res> {
  _$ShelfEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userBookId = null,
    Object? externalId = null,
    Object? readingStatus = null,
    Object? addedAt = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? note = freezed,
    Object? noteUpdatedAt = freezed,
    Object? rating = freezed,
  }) {
    return _then(_value.copyWith(
      userBookId: null == userBookId
          ? _value.userBookId
          : userBookId // ignore: cast_nullable_to_non_nullable
              as int,
      externalId: null == externalId
          ? _value.externalId
          : externalId // ignore: cast_nullable_to_non_nullable
              as String,
      readingStatus: null == readingStatus
          ? _value.readingStatus
          : readingStatus // ignore: cast_nullable_to_non_nullable
              as ReadingStatus,
      addedAt: null == addedAt
          ? _value.addedAt
          : addedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShelfEntryImplCopyWith<$Res>
    implements $ShelfEntryCopyWith<$Res> {
  factory _$$ShelfEntryImplCopyWith(
          _$ShelfEntryImpl value, $Res Function(_$ShelfEntryImpl) then) =
      __$$ShelfEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int userBookId,
      String externalId,
      ReadingStatus readingStatus,
      DateTime addedAt,
      DateTime? startedAt,
      DateTime? completedAt,
      String? note,
      DateTime? noteUpdatedAt,
      int? rating});
}

/// @nodoc
class __$$ShelfEntryImplCopyWithImpl<$Res>
    extends _$ShelfEntryCopyWithImpl<$Res, _$ShelfEntryImpl>
    implements _$$ShelfEntryImplCopyWith<$Res> {
  __$$ShelfEntryImplCopyWithImpl(
      _$ShelfEntryImpl _value, $Res Function(_$ShelfEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userBookId = null,
    Object? externalId = null,
    Object? readingStatus = null,
    Object? addedAt = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? note = freezed,
    Object? noteUpdatedAt = freezed,
    Object? rating = freezed,
  }) {
    return _then(_$ShelfEntryImpl(
      userBookId: null == userBookId
          ? _value.userBookId
          : userBookId // ignore: cast_nullable_to_non_nullable
              as int,
      externalId: null == externalId
          ? _value.externalId
          : externalId // ignore: cast_nullable_to_non_nullable
              as String,
      readingStatus: null == readingStatus
          ? _value.readingStatus
          : readingStatus // ignore: cast_nullable_to_non_nullable
              as ReadingStatus,
      addedAt: null == addedAt
          ? _value.addedAt
          : addedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$ShelfEntryImpl extends _ShelfEntry {
  const _$ShelfEntryImpl(
      {required this.userBookId,
      required this.externalId,
      required this.readingStatus,
      required this.addedAt,
      this.startedAt,
      this.completedAt,
      this.note,
      this.noteUpdatedAt,
      this.rating})
      : super._();

  /// 読書記録の ID（userBookId）
  @override
  final int userBookId;

  /// 外部 ID（Google Books ID など）
  @override
  final String externalId;

  /// 読書状態
  @override
  final ReadingStatus readingStatus;

  /// 本棚に追加した日時
  @override
  final DateTime addedAt;

  /// 読書開始日（readingStatus が reading に変更された初回のみ設定）
  @override
  final DateTime? startedAt;

  /// 読了日（readingStatus が completed の場合のみ設定）
  @override
  final DateTime? completedAt;

  /// 読書メモ
  @override
  final String? note;

  /// メモの最終更新日時
  @override
  final DateTime? noteUpdatedAt;

  /// 評価（1-5）
  @override
  final int? rating;

  @override
  String toString() {
    return 'ShelfEntry(userBookId: $userBookId, externalId: $externalId, readingStatus: $readingStatus, addedAt: $addedAt, startedAt: $startedAt, completedAt: $completedAt, note: $note, noteUpdatedAt: $noteUpdatedAt, rating: $rating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShelfEntryImpl &&
            (identical(other.userBookId, userBookId) ||
                other.userBookId == userBookId) &&
            (identical(other.externalId, externalId) ||
                other.externalId == externalId) &&
            (identical(other.readingStatus, readingStatus) ||
                other.readingStatus == readingStatus) &&
            (identical(other.addedAt, addedAt) || other.addedAt == addedAt) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.noteUpdatedAt, noteUpdatedAt) ||
                other.noteUpdatedAt == noteUpdatedAt) &&
            (identical(other.rating, rating) || other.rating == rating));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      userBookId,
      externalId,
      readingStatus,
      addedAt,
      startedAt,
      completedAt,
      note,
      noteUpdatedAt,
      rating);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShelfEntryImplCopyWith<_$ShelfEntryImpl> get copyWith =>
      __$$ShelfEntryImplCopyWithImpl<_$ShelfEntryImpl>(this, _$identity);
}

abstract class _ShelfEntry extends ShelfEntry {
  const factory _ShelfEntry(
      {required final int userBookId,
      required final String externalId,
      required final ReadingStatus readingStatus,
      required final DateTime addedAt,
      final DateTime? startedAt,
      final DateTime? completedAt,
      final String? note,
      final DateTime? noteUpdatedAt,
      final int? rating}) = _$ShelfEntryImpl;
  const _ShelfEntry._() : super._();

  @override

  /// 読書記録の ID（userBookId）
  int get userBookId;
  @override

  /// 外部 ID（Google Books ID など）
  String get externalId;
  @override

  /// 読書状態
  ReadingStatus get readingStatus;
  @override

  /// 本棚に追加した日時
  DateTime get addedAt;
  @override

  /// 読書開始日（readingStatus が reading に変更された初回のみ設定）
  DateTime? get startedAt;
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

  /// 評価（1-5）
  int? get rating;
  @override
  @JsonKey(ignore: true)
  _$$ShelfEntryImplCopyWith<_$ShelfEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
