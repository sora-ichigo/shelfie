// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recent_book_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RecentBookEntry _$RecentBookEntryFromJson(Map<String, dynamic> json) {
  return _RecentBookEntry.fromJson(json);
}

/// @nodoc
mixin _$RecentBookEntry {
  /// 書籍 ID（外部 API の識別子）
  String get bookId => throw _privateConstructorUsedError;

  /// 書籍タイトル
  String get title => throw _privateConstructorUsedError;

  /// 著者リスト
  List<String> get authors => throw _privateConstructorUsedError;

  /// カバー画像 URL（取得できない場合は null）
  String? get coverImageUrl => throw _privateConstructorUsedError;

  /// 閲覧した日時
  DateTime get viewedAt => throw _privateConstructorUsedError;

  /// 書籍データの取得元（rakuten または google）
  String? get source => throw _privateConstructorUsedError;

  /// Serializes this RecentBookEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecentBookEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecentBookEntryCopyWith<RecentBookEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecentBookEntryCopyWith<$Res> {
  factory $RecentBookEntryCopyWith(
          RecentBookEntry value, $Res Function(RecentBookEntry) then) =
      _$RecentBookEntryCopyWithImpl<$Res, RecentBookEntry>;
  @useResult
  $Res call(
      {String bookId,
      String title,
      List<String> authors,
      String? coverImageUrl,
      DateTime viewedAt,
      String? source});
}

/// @nodoc
class _$RecentBookEntryCopyWithImpl<$Res, $Val extends RecentBookEntry>
    implements $RecentBookEntryCopyWith<$Res> {
  _$RecentBookEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecentBookEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookId = null,
    Object? title = null,
    Object? authors = null,
    Object? coverImageUrl = freezed,
    Object? viewedAt = null,
    Object? source = freezed,
  }) {
    return _then(_value.copyWith(
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      authors: null == authors
          ? _value.authors
          : authors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      coverImageUrl: freezed == coverImageUrl
          ? _value.coverImageUrl
          : coverImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      viewedAt: null == viewedAt
          ? _value.viewedAt
          : viewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecentBookEntryImplCopyWith<$Res>
    implements $RecentBookEntryCopyWith<$Res> {
  factory _$$RecentBookEntryImplCopyWith(_$RecentBookEntryImpl value,
          $Res Function(_$RecentBookEntryImpl) then) =
      __$$RecentBookEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String bookId,
      String title,
      List<String> authors,
      String? coverImageUrl,
      DateTime viewedAt,
      String? source});
}

/// @nodoc
class __$$RecentBookEntryImplCopyWithImpl<$Res>
    extends _$RecentBookEntryCopyWithImpl<$Res, _$RecentBookEntryImpl>
    implements _$$RecentBookEntryImplCopyWith<$Res> {
  __$$RecentBookEntryImplCopyWithImpl(
      _$RecentBookEntryImpl _value, $Res Function(_$RecentBookEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecentBookEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookId = null,
    Object? title = null,
    Object? authors = null,
    Object? coverImageUrl = freezed,
    Object? viewedAt = null,
    Object? source = freezed,
  }) {
    return _then(_$RecentBookEntryImpl(
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      authors: null == authors
          ? _value._authors
          : authors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      coverImageUrl: freezed == coverImageUrl
          ? _value.coverImageUrl
          : coverImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      viewedAt: null == viewedAt
          ? _value.viewedAt
          : viewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecentBookEntryImpl implements _RecentBookEntry {
  const _$RecentBookEntryImpl(
      {required this.bookId,
      required this.title,
      required final List<String> authors,
      this.coverImageUrl,
      required this.viewedAt,
      this.source})
      : _authors = authors;

  factory _$RecentBookEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecentBookEntryImplFromJson(json);

  /// 書籍 ID（外部 API の識別子）
  @override
  final String bookId;

  /// 書籍タイトル
  @override
  final String title;

  /// 著者リスト
  final List<String> _authors;

  /// 著者リスト
  @override
  List<String> get authors {
    if (_authors is EqualUnmodifiableListView) return _authors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_authors);
  }

  /// カバー画像 URL（取得できない場合は null）
  @override
  final String? coverImageUrl;

  /// 閲覧した日時
  @override
  final DateTime viewedAt;

  /// 書籍データの取得元（rakuten または google）
  @override
  final String? source;

  @override
  String toString() {
    return 'RecentBookEntry(bookId: $bookId, title: $title, authors: $authors, coverImageUrl: $coverImageUrl, viewedAt: $viewedAt, source: $source)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecentBookEntryImpl &&
            (identical(other.bookId, bookId) || other.bookId == bookId) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._authors, _authors) &&
            (identical(other.coverImageUrl, coverImageUrl) ||
                other.coverImageUrl == coverImageUrl) &&
            (identical(other.viewedAt, viewedAt) ||
                other.viewedAt == viewedAt) &&
            (identical(other.source, source) || other.source == source));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      bookId,
      title,
      const DeepCollectionEquality().hash(_authors),
      coverImageUrl,
      viewedAt,
      source);

  /// Create a copy of RecentBookEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecentBookEntryImplCopyWith<_$RecentBookEntryImpl> get copyWith =>
      __$$RecentBookEntryImplCopyWithImpl<_$RecentBookEntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecentBookEntryImplToJson(
      this,
    );
  }
}

abstract class _RecentBookEntry implements RecentBookEntry {
  const factory _RecentBookEntry(
      {required final String bookId,
      required final String title,
      required final List<String> authors,
      final String? coverImageUrl,
      required final DateTime viewedAt,
      final String? source}) = _$RecentBookEntryImpl;

  factory _RecentBookEntry.fromJson(Map<String, dynamic> json) =
      _$RecentBookEntryImpl.fromJson;

  /// 書籍 ID（外部 API の識別子）
  @override
  String get bookId;

  /// 書籍タイトル
  @override
  String get title;

  /// 著者リスト
  @override
  List<String> get authors;

  /// カバー画像 URL（取得できない場合は null）
  @override
  String? get coverImageUrl;

  /// 閲覧した日時
  @override
  DateTime get viewedAt;

  /// 書籍データの取得元（rakuten または google）
  @override
  String? get source;

  /// Create a copy of RecentBookEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecentBookEntryImplCopyWith<_$RecentBookEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
