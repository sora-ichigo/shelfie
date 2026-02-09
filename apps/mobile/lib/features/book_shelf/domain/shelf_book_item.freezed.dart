// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shelf_book_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ShelfBookItem {
  /// ユーザーの本棚エントリID
  int get userBookId => throw _privateConstructorUsedError;

  /// 外部ID（楽天ブックスID など）
  String get externalId => throw _privateConstructorUsedError;

  /// 書籍タイトル
  String get title => throw _privateConstructorUsedError;

  /// 著者リスト
  List<String> get authors => throw _privateConstructorUsedError;

  /// 書籍のソース（rakuten or google）
  BookSource get source => throw _privateConstructorUsedError;

  /// 本棚への追加日時
  DateTime get addedAt => throw _privateConstructorUsedError;

  /// 表紙画像のURL
  String? get coverImageUrl => throw _privateConstructorUsedError;

  /// Create a copy of ShelfBookItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShelfBookItemCopyWith<ShelfBookItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShelfBookItemCopyWith<$Res> {
  factory $ShelfBookItemCopyWith(
    ShelfBookItem value,
    $Res Function(ShelfBookItem) then,
  ) = _$ShelfBookItemCopyWithImpl<$Res, ShelfBookItem>;
  @useResult
  $Res call({
    int userBookId,
    String externalId,
    String title,
    List<String> authors,
    BookSource source,
    DateTime addedAt,
    String? coverImageUrl,
  });
}

/// @nodoc
class _$ShelfBookItemCopyWithImpl<$Res, $Val extends ShelfBookItem>
    implements $ShelfBookItemCopyWith<$Res> {
  _$ShelfBookItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShelfBookItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userBookId = null,
    Object? externalId = null,
    Object? title = null,
    Object? authors = null,
    Object? source = null,
    Object? addedAt = null,
    Object? coverImageUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            userBookId: null == userBookId
                ? _value.userBookId
                : userBookId // ignore: cast_nullable_to_non_nullable
                      as int,
            externalId: null == externalId
                ? _value.externalId
                : externalId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            authors: null == authors
                ? _value.authors
                : authors // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as BookSource,
            addedAt: null == addedAt
                ? _value.addedAt
                : addedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            coverImageUrl: freezed == coverImageUrl
                ? _value.coverImageUrl
                : coverImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ShelfBookItemImplCopyWith<$Res>
    implements $ShelfBookItemCopyWith<$Res> {
  factory _$$ShelfBookItemImplCopyWith(
    _$ShelfBookItemImpl value,
    $Res Function(_$ShelfBookItemImpl) then,
  ) = __$$ShelfBookItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int userBookId,
    String externalId,
    String title,
    List<String> authors,
    BookSource source,
    DateTime addedAt,
    String? coverImageUrl,
  });
}

/// @nodoc
class __$$ShelfBookItemImplCopyWithImpl<$Res>
    extends _$ShelfBookItemCopyWithImpl<$Res, _$ShelfBookItemImpl>
    implements _$$ShelfBookItemImplCopyWith<$Res> {
  __$$ShelfBookItemImplCopyWithImpl(
    _$ShelfBookItemImpl _value,
    $Res Function(_$ShelfBookItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShelfBookItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userBookId = null,
    Object? externalId = null,
    Object? title = null,
    Object? authors = null,
    Object? source = null,
    Object? addedAt = null,
    Object? coverImageUrl = freezed,
  }) {
    return _then(
      _$ShelfBookItemImpl(
        userBookId: null == userBookId
            ? _value.userBookId
            : userBookId // ignore: cast_nullable_to_non_nullable
                  as int,
        externalId: null == externalId
            ? _value.externalId
            : externalId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        authors: null == authors
            ? _value._authors
            : authors // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as BookSource,
        addedAt: null == addedAt
            ? _value.addedAt
            : addedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        coverImageUrl: freezed == coverImageUrl
            ? _value.coverImageUrl
            : coverImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ShelfBookItemImpl extends _ShelfBookItem {
  const _$ShelfBookItemImpl({
    required this.userBookId,
    required this.externalId,
    required this.title,
    required final List<String> authors,
    this.source = BookSource.rakuten,
    required this.addedAt,
    this.coverImageUrl,
  }) : _authors = authors,
       super._();

  /// ユーザーの本棚エントリID
  @override
  final int userBookId;

  /// 外部ID（楽天ブックスID など）
  @override
  final String externalId;

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

  /// 書籍のソース（rakuten or google）
  @override
  @JsonKey()
  final BookSource source;

  /// 本棚への追加日時
  @override
  final DateTime addedAt;

  /// 表紙画像のURL
  @override
  final String? coverImageUrl;

  @override
  String toString() {
    return 'ShelfBookItem(userBookId: $userBookId, externalId: $externalId, title: $title, authors: $authors, source: $source, addedAt: $addedAt, coverImageUrl: $coverImageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShelfBookItemImpl &&
            (identical(other.userBookId, userBookId) ||
                other.userBookId == userBookId) &&
            (identical(other.externalId, externalId) ||
                other.externalId == externalId) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._authors, _authors) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.addedAt, addedAt) || other.addedAt == addedAt) &&
            (identical(other.coverImageUrl, coverImageUrl) ||
                other.coverImageUrl == coverImageUrl));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    userBookId,
    externalId,
    title,
    const DeepCollectionEquality().hash(_authors),
    source,
    addedAt,
    coverImageUrl,
  );

  /// Create a copy of ShelfBookItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShelfBookItemImplCopyWith<_$ShelfBookItemImpl> get copyWith =>
      __$$ShelfBookItemImplCopyWithImpl<_$ShelfBookItemImpl>(this, _$identity);
}

abstract class _ShelfBookItem extends ShelfBookItem {
  const factory _ShelfBookItem({
    required final int userBookId,
    required final String externalId,
    required final String title,
    required final List<String> authors,
    final BookSource source,
    required final DateTime addedAt,
    final String? coverImageUrl,
  }) = _$ShelfBookItemImpl;
  const _ShelfBookItem._() : super._();

  /// ユーザーの本棚エントリID
  @override
  int get userBookId;

  /// 外部ID（楽天ブックスID など）
  @override
  String get externalId;

  /// 書籍タイトル
  @override
  String get title;

  /// 著者リスト
  @override
  List<String> get authors;

  /// 書籍のソース（rakuten or google）
  @override
  BookSource get source;

  /// 本棚への追加日時
  @override
  DateTime get addedAt;

  /// 表紙画像のURL
  @override
  String? get coverImageUrl;

  /// Create a copy of ShelfBookItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShelfBookItemImplCopyWith<_$ShelfBookItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
