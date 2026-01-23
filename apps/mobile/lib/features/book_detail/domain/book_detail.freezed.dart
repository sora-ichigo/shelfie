// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BookDetail {
  /// 書籍 ID（Google Books ID）
  String get id => throw _privateConstructorUsedError;

  /// タイトル
  String get title => throw _privateConstructorUsedError;

  /// 著者リスト
  List<String> get authors => throw _privateConstructorUsedError;

  /// 出版社
  String? get publisher => throw _privateConstructorUsedError;

  /// 発売日
  String? get publishedDate => throw _privateConstructorUsedError;

  /// ページ数
  int? get pageCount => throw _privateConstructorUsedError;

  /// カテゴリ（ジャンル）リスト
  List<String>? get categories => throw _privateConstructorUsedError;

  /// 書籍の説明文
  String? get description => throw _privateConstructorUsedError;

  /// 表紙画像 URL
  String? get thumbnailUrl => throw _privateConstructorUsedError;

  /// Amazon URL
  String? get amazonUrl => throw _privateConstructorUsedError;

  /// Google Books 情報ページ URL
  String? get infoLink => throw _privateConstructorUsedError;

  /// ユーザーの読書記録（本棚に追加されている場合）
  UserBook? get userBook => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BookDetailCopyWith<BookDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookDetailCopyWith<$Res> {
  factory $BookDetailCopyWith(
          BookDetail value, $Res Function(BookDetail) then) =
      _$BookDetailCopyWithImpl<$Res, BookDetail>;
  @useResult
  $Res call(
      {String id,
      String title,
      List<String> authors,
      String? publisher,
      String? publishedDate,
      int? pageCount,
      List<String>? categories,
      String? description,
      String? thumbnailUrl,
      String? amazonUrl,
      String? infoLink,
      UserBook? userBook});

  $UserBookCopyWith<$Res>? get userBook;
}

/// @nodoc
class _$BookDetailCopyWithImpl<$Res, $Val extends BookDetail>
    implements $BookDetailCopyWith<$Res> {
  _$BookDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? authors = null,
    Object? publisher = freezed,
    Object? publishedDate = freezed,
    Object? pageCount = freezed,
    Object? categories = freezed,
    Object? description = freezed,
    Object? thumbnailUrl = freezed,
    Object? amazonUrl = freezed,
    Object? infoLink = freezed,
    Object? userBook = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      authors: null == authors
          ? _value.authors
          : authors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      publisher: freezed == publisher
          ? _value.publisher
          : publisher // ignore: cast_nullable_to_non_nullable
              as String?,
      publishedDate: freezed == publishedDate
          ? _value.publishedDate
          : publishedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      pageCount: freezed == pageCount
          ? _value.pageCount
          : pageCount // ignore: cast_nullable_to_non_nullable
              as int?,
      categories: freezed == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      amazonUrl: freezed == amazonUrl
          ? _value.amazonUrl
          : amazonUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      infoLink: freezed == infoLink
          ? _value.infoLink
          : infoLink // ignore: cast_nullable_to_non_nullable
              as String?,
      userBook: freezed == userBook
          ? _value.userBook
          : userBook // ignore: cast_nullable_to_non_nullable
              as UserBook?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserBookCopyWith<$Res>? get userBook {
    if (_value.userBook == null) {
      return null;
    }

    return $UserBookCopyWith<$Res>(_value.userBook!, (value) {
      return _then(_value.copyWith(userBook: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BookDetailImplCopyWith<$Res>
    implements $BookDetailCopyWith<$Res> {
  factory _$$BookDetailImplCopyWith(
          _$BookDetailImpl value, $Res Function(_$BookDetailImpl) then) =
      __$$BookDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      List<String> authors,
      String? publisher,
      String? publishedDate,
      int? pageCount,
      List<String>? categories,
      String? description,
      String? thumbnailUrl,
      String? amazonUrl,
      String? infoLink,
      UserBook? userBook});

  @override
  $UserBookCopyWith<$Res>? get userBook;
}

/// @nodoc
class __$$BookDetailImplCopyWithImpl<$Res>
    extends _$BookDetailCopyWithImpl<$Res, _$BookDetailImpl>
    implements _$$BookDetailImplCopyWith<$Res> {
  __$$BookDetailImplCopyWithImpl(
      _$BookDetailImpl _value, $Res Function(_$BookDetailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? authors = null,
    Object? publisher = freezed,
    Object? publishedDate = freezed,
    Object? pageCount = freezed,
    Object? categories = freezed,
    Object? description = freezed,
    Object? thumbnailUrl = freezed,
    Object? amazonUrl = freezed,
    Object? infoLink = freezed,
    Object? userBook = freezed,
  }) {
    return _then(_$BookDetailImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      authors: null == authors
          ? _value._authors
          : authors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      publisher: freezed == publisher
          ? _value.publisher
          : publisher // ignore: cast_nullable_to_non_nullable
              as String?,
      publishedDate: freezed == publishedDate
          ? _value.publishedDate
          : publishedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      pageCount: freezed == pageCount
          ? _value.pageCount
          : pageCount // ignore: cast_nullable_to_non_nullable
              as int?,
      categories: freezed == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      amazonUrl: freezed == amazonUrl
          ? _value.amazonUrl
          : amazonUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      infoLink: freezed == infoLink
          ? _value.infoLink
          : infoLink // ignore: cast_nullable_to_non_nullable
              as String?,
      userBook: freezed == userBook
          ? _value.userBook
          : userBook // ignore: cast_nullable_to_non_nullable
              as UserBook?,
    ));
  }
}

/// @nodoc

class _$BookDetailImpl extends _BookDetail {
  const _$BookDetailImpl(
      {required this.id,
      required this.title,
      required final List<String> authors,
      this.publisher,
      this.publishedDate,
      this.pageCount,
      final List<String>? categories,
      this.description,
      this.thumbnailUrl,
      this.amazonUrl,
      this.infoLink,
      this.userBook})
      : _authors = authors,
        _categories = categories,
        super._();

  /// 書籍 ID（Google Books ID）
  @override
  final String id;

  /// タイトル
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

  /// 出版社
  @override
  final String? publisher;

  /// 発売日
  @override
  final String? publishedDate;

  /// ページ数
  @override
  final int? pageCount;

  /// カテゴリ（ジャンル）リスト
  final List<String>? _categories;

  /// カテゴリ（ジャンル）リスト
  @override
  List<String>? get categories {
    final value = _categories;
    if (value == null) return null;
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// 書籍の説明文
  @override
  final String? description;

  /// 表紙画像 URL
  @override
  final String? thumbnailUrl;

  /// Amazon URL
  @override
  final String? amazonUrl;

  /// Google Books 情報ページ URL
  @override
  final String? infoLink;

  /// ユーザーの読書記録（本棚に追加されている場合）
  @override
  final UserBook? userBook;

  @override
  String toString() {
    return 'BookDetail(id: $id, title: $title, authors: $authors, publisher: $publisher, publishedDate: $publishedDate, pageCount: $pageCount, categories: $categories, description: $description, thumbnailUrl: $thumbnailUrl, amazonUrl: $amazonUrl, infoLink: $infoLink, userBook: $userBook)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._authors, _authors) &&
            (identical(other.publisher, publisher) ||
                other.publisher == publisher) &&
            (identical(other.publishedDate, publishedDate) ||
                other.publishedDate == publishedDate) &&
            (identical(other.pageCount, pageCount) ||
                other.pageCount == pageCount) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.amazonUrl, amazonUrl) ||
                other.amazonUrl == amazonUrl) &&
            (identical(other.infoLink, infoLink) ||
                other.infoLink == infoLink) &&
            (identical(other.userBook, userBook) ||
                other.userBook == userBook));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      const DeepCollectionEquality().hash(_authors),
      publisher,
      publishedDate,
      pageCount,
      const DeepCollectionEquality().hash(_categories),
      description,
      thumbnailUrl,
      amazonUrl,
      infoLink,
      userBook);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookDetailImplCopyWith<_$BookDetailImpl> get copyWith =>
      __$$BookDetailImplCopyWithImpl<_$BookDetailImpl>(this, _$identity);
}

abstract class _BookDetail extends BookDetail {
  const factory _BookDetail(
      {required final String id,
      required final String title,
      required final List<String> authors,
      final String? publisher,
      final String? publishedDate,
      final int? pageCount,
      final List<String>? categories,
      final String? description,
      final String? thumbnailUrl,
      final String? amazonUrl,
      final String? infoLink,
      final UserBook? userBook}) = _$BookDetailImpl;
  const _BookDetail._() : super._();

  @override

  /// 書籍 ID（Google Books ID）
  String get id;
  @override

  /// タイトル
  String get title;
  @override

  /// 著者リスト
  List<String> get authors;
  @override

  /// 出版社
  String? get publisher;
  @override

  /// 発売日
  String? get publishedDate;
  @override

  /// ページ数
  int? get pageCount;
  @override

  /// カテゴリ（ジャンル）リスト
  List<String>? get categories;
  @override

  /// 書籍の説明文
  String? get description;
  @override

  /// 表紙画像 URL
  String? get thumbnailUrl;
  @override

  /// Amazon URL
  String? get amazonUrl;
  @override

  /// Google Books 情報ページ URL
  String? get infoLink;
  @override

  /// ユーザーの読書記録（本棚に追加されている場合）
  UserBook? get userBook;
  @override
  @JsonKey(ignore: true)
  _$$BookDetailImplCopyWith<_$BookDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
