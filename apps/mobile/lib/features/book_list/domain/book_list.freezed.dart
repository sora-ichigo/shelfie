// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BookList {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of BookList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookListCopyWith<BookList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookListCopyWith<$Res> {
  factory $BookListCopyWith(BookList value, $Res Function(BookList) then) =
      _$BookListCopyWithImpl<$Res, BookList>;
  @useResult
  $Res call(
      {int id,
      String title,
      String? description,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$BookListCopyWithImpl<$Res, $Val extends BookList>
    implements $BookListCopyWith<$Res> {
  _$BookListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookListImplCopyWith<$Res>
    implements $BookListCopyWith<$Res> {
  factory _$$BookListImplCopyWith(
          _$BookListImpl value, $Res Function(_$BookListImpl) then) =
      __$$BookListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String? description,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$BookListImplCopyWithImpl<$Res>
    extends _$BookListCopyWithImpl<$Res, _$BookListImpl>
    implements _$$BookListImplCopyWith<$Res> {
  __$$BookListImplCopyWithImpl(
      _$BookListImpl _value, $Res Function(_$BookListImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$BookListImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$BookListImpl implements _BookList {
  const _$BookListImpl(
      {required this.id,
      required this.title,
      this.description,
      required this.createdAt,
      required this.updatedAt});

  @override
  final int id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'BookList(id: $id, title: $title, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookListImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, description, createdAt, updatedAt);

  /// Create a copy of BookList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookListImplCopyWith<_$BookListImpl> get copyWith =>
      __$$BookListImplCopyWithImpl<_$BookListImpl>(this, _$identity);
}

abstract class _BookList implements BookList {
  const factory _BookList(
      {required final int id,
      required final String title,
      final String? description,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$BookListImpl;

  @override
  int get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of BookList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookListImplCopyWith<_$BookListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BookListSummary {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int get bookCount => throw _privateConstructorUsedError;
  List<String> get coverImages => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of BookListSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookListSummaryCopyWith<BookListSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookListSummaryCopyWith<$Res> {
  factory $BookListSummaryCopyWith(
          BookListSummary value, $Res Function(BookListSummary) then) =
      _$BookListSummaryCopyWithImpl<$Res, BookListSummary>;
  @useResult
  $Res call(
      {int id,
      String title,
      String? description,
      int bookCount,
      List<String> coverImages,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$BookListSummaryCopyWithImpl<$Res, $Val extends BookListSummary>
    implements $BookListSummaryCopyWith<$Res> {
  _$BookListSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookListSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? bookCount = null,
    Object? coverImages = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      bookCount: null == bookCount
          ? _value.bookCount
          : bookCount // ignore: cast_nullable_to_non_nullable
              as int,
      coverImages: null == coverImages
          ? _value.coverImages
          : coverImages // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookListSummaryImplCopyWith<$Res>
    implements $BookListSummaryCopyWith<$Res> {
  factory _$$BookListSummaryImplCopyWith(_$BookListSummaryImpl value,
          $Res Function(_$BookListSummaryImpl) then) =
      __$$BookListSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String? description,
      int bookCount,
      List<String> coverImages,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$BookListSummaryImplCopyWithImpl<$Res>
    extends _$BookListSummaryCopyWithImpl<$Res, _$BookListSummaryImpl>
    implements _$$BookListSummaryImplCopyWith<$Res> {
  __$$BookListSummaryImplCopyWithImpl(
      _$BookListSummaryImpl _value, $Res Function(_$BookListSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookListSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? bookCount = null,
    Object? coverImages = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$BookListSummaryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      bookCount: null == bookCount
          ? _value.bookCount
          : bookCount // ignore: cast_nullable_to_non_nullable
              as int,
      coverImages: null == coverImages
          ? _value._coverImages
          : coverImages // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$BookListSummaryImpl implements _BookListSummary {
  const _$BookListSummaryImpl(
      {required this.id,
      required this.title,
      this.description,
      required this.bookCount,
      required final List<String> coverImages,
      required this.createdAt,
      required this.updatedAt})
      : _coverImages = coverImages;

  @override
  final int id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final int bookCount;
  final List<String> _coverImages;
  @override
  List<String> get coverImages {
    if (_coverImages is EqualUnmodifiableListView) return _coverImages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_coverImages);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'BookListSummary(id: $id, title: $title, description: $description, bookCount: $bookCount, coverImages: $coverImages, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookListSummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.bookCount, bookCount) ||
                other.bookCount == bookCount) &&
            const DeepCollectionEquality()
                .equals(other._coverImages, _coverImages) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      bookCount,
      const DeepCollectionEquality().hash(_coverImages),
      createdAt,
      updatedAt);

  /// Create a copy of BookListSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookListSummaryImplCopyWith<_$BookListSummaryImpl> get copyWith =>
      __$$BookListSummaryImplCopyWithImpl<_$BookListSummaryImpl>(
          this, _$identity);
}

abstract class _BookListSummary implements BookListSummary {
  const factory _BookListSummary(
      {required final int id,
      required final String title,
      final String? description,
      required final int bookCount,
      required final List<String> coverImages,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$BookListSummaryImpl;

  @override
  int get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  int get bookCount;
  @override
  List<String> get coverImages;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of BookListSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookListSummaryImplCopyWith<_$BookListSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BookListDetail {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<BookListItem> get items => throw _privateConstructorUsedError;
  BookListDetailStats get stats => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of BookListDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookListDetailCopyWith<BookListDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookListDetailCopyWith<$Res> {
  factory $BookListDetailCopyWith(
          BookListDetail value, $Res Function(BookListDetail) then) =
      _$BookListDetailCopyWithImpl<$Res, BookListDetail>;
  @useResult
  $Res call(
      {int id,
      String title,
      String? description,
      List<BookListItem> items,
      BookListDetailStats stats,
      DateTime createdAt,
      DateTime updatedAt});

  $BookListDetailStatsCopyWith<$Res> get stats;
}

/// @nodoc
class _$BookListDetailCopyWithImpl<$Res, $Val extends BookListDetail>
    implements $BookListDetailCopyWith<$Res> {
  _$BookListDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookListDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? items = null,
    Object? stats = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<BookListItem>,
      stats: null == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as BookListDetailStats,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  /// Create a copy of BookListDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BookListDetailStatsCopyWith<$Res> get stats {
    return $BookListDetailStatsCopyWith<$Res>(_value.stats, (value) {
      return _then(_value.copyWith(stats: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BookListDetailImplCopyWith<$Res>
    implements $BookListDetailCopyWith<$Res> {
  factory _$$BookListDetailImplCopyWith(_$BookListDetailImpl value,
          $Res Function(_$BookListDetailImpl) then) =
      __$$BookListDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String? description,
      List<BookListItem> items,
      BookListDetailStats stats,
      DateTime createdAt,
      DateTime updatedAt});

  @override
  $BookListDetailStatsCopyWith<$Res> get stats;
}

/// @nodoc
class __$$BookListDetailImplCopyWithImpl<$Res>
    extends _$BookListDetailCopyWithImpl<$Res, _$BookListDetailImpl>
    implements _$$BookListDetailImplCopyWith<$Res> {
  __$$BookListDetailImplCopyWithImpl(
      _$BookListDetailImpl _value, $Res Function(_$BookListDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookListDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? items = null,
    Object? stats = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$BookListDetailImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<BookListItem>,
      stats: null == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as BookListDetailStats,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$BookListDetailImpl implements _BookListDetail {
  const _$BookListDetailImpl(
      {required this.id,
      required this.title,
      this.description,
      required final List<BookListItem> items,
      required this.stats,
      required this.createdAt,
      required this.updatedAt})
      : _items = items;

  @override
  final int id;
  @override
  final String title;
  @override
  final String? description;
  final List<BookListItem> _items;
  @override
  List<BookListItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final BookListDetailStats stats;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'BookListDetail(id: $id, title: $title, description: $description, items: $items, stats: $stats, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookListDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.stats, stats) || other.stats == stats) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, description,
      const DeepCollectionEquality().hash(_items), stats, createdAt, updatedAt);

  /// Create a copy of BookListDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookListDetailImplCopyWith<_$BookListDetailImpl> get copyWith =>
      __$$BookListDetailImplCopyWithImpl<_$BookListDetailImpl>(
          this, _$identity);
}

abstract class _BookListDetail implements BookListDetail {
  const factory _BookListDetail(
      {required final int id,
      required final String title,
      final String? description,
      required final List<BookListItem> items,
      required final BookListDetailStats stats,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$BookListDetailImpl;

  @override
  int get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  List<BookListItem> get items;
  @override
  BookListDetailStats get stats;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of BookListDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookListDetailImplCopyWith<_$BookListDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BookListItem {
  int get id => throw _privateConstructorUsedError;
  int get position => throw _privateConstructorUsedError;
  DateTime get addedAt => throw _privateConstructorUsedError;
  BookListItemUserBook? get userBook => throw _privateConstructorUsedError;

  /// Create a copy of BookListItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookListItemCopyWith<BookListItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookListItemCopyWith<$Res> {
  factory $BookListItemCopyWith(
          BookListItem value, $Res Function(BookListItem) then) =
      _$BookListItemCopyWithImpl<$Res, BookListItem>;
  @useResult
  $Res call(
      {int id, int position, DateTime addedAt, BookListItemUserBook? userBook});

  $BookListItemUserBookCopyWith<$Res>? get userBook;
}

/// @nodoc
class _$BookListItemCopyWithImpl<$Res, $Val extends BookListItem>
    implements $BookListItemCopyWith<$Res> {
  _$BookListItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookListItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? position = null,
    Object? addedAt = null,
    Object? userBook = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      addedAt: null == addedAt
          ? _value.addedAt
          : addedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userBook: freezed == userBook
          ? _value.userBook
          : userBook // ignore: cast_nullable_to_non_nullable
              as BookListItemUserBook?,
    ) as $Val);
  }

  /// Create a copy of BookListItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BookListItemUserBookCopyWith<$Res>? get userBook {
    if (_value.userBook == null) {
      return null;
    }

    return $BookListItemUserBookCopyWith<$Res>(_value.userBook!, (value) {
      return _then(_value.copyWith(userBook: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BookListItemImplCopyWith<$Res>
    implements $BookListItemCopyWith<$Res> {
  factory _$$BookListItemImplCopyWith(
          _$BookListItemImpl value, $Res Function(_$BookListItemImpl) then) =
      __$$BookListItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id, int position, DateTime addedAt, BookListItemUserBook? userBook});

  @override
  $BookListItemUserBookCopyWith<$Res>? get userBook;
}

/// @nodoc
class __$$BookListItemImplCopyWithImpl<$Res>
    extends _$BookListItemCopyWithImpl<$Res, _$BookListItemImpl>
    implements _$$BookListItemImplCopyWith<$Res> {
  __$$BookListItemImplCopyWithImpl(
      _$BookListItemImpl _value, $Res Function(_$BookListItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookListItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? position = null,
    Object? addedAt = null,
    Object? userBook = freezed,
  }) {
    return _then(_$BookListItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      addedAt: null == addedAt
          ? _value.addedAt
          : addedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userBook: freezed == userBook
          ? _value.userBook
          : userBook // ignore: cast_nullable_to_non_nullable
              as BookListItemUserBook?,
    ));
  }
}

/// @nodoc

class _$BookListItemImpl implements _BookListItem {
  const _$BookListItemImpl(
      {required this.id,
      required this.position,
      required this.addedAt,
      this.userBook});

  @override
  final int id;
  @override
  final int position;
  @override
  final DateTime addedAt;
  @override
  final BookListItemUserBook? userBook;

  @override
  String toString() {
    return 'BookListItem(id: $id, position: $position, addedAt: $addedAt, userBook: $userBook)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookListItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.addedAt, addedAt) || other.addedAt == addedAt) &&
            (identical(other.userBook, userBook) ||
                other.userBook == userBook));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, position, addedAt, userBook);

  /// Create a copy of BookListItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookListItemImplCopyWith<_$BookListItemImpl> get copyWith =>
      __$$BookListItemImplCopyWithImpl<_$BookListItemImpl>(this, _$identity);
}

abstract class _BookListItem implements BookListItem {
  const factory _BookListItem(
      {required final int id,
      required final int position,
      required final DateTime addedAt,
      final BookListItemUserBook? userBook}) = _$BookListItemImpl;

  @override
  int get id;
  @override
  int get position;
  @override
  DateTime get addedAt;
  @override
  BookListItemUserBook? get userBook;

  /// Create a copy of BookListItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookListItemImplCopyWith<_$BookListItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BookListItemUserBook {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  List<String> get authors => throw _privateConstructorUsedError;
  String? get coverImageUrl => throw _privateConstructorUsedError;
  String get readingStatus => throw _privateConstructorUsedError;

  /// Create a copy of BookListItemUserBook
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookListItemUserBookCopyWith<BookListItemUserBook> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookListItemUserBookCopyWith<$Res> {
  factory $BookListItemUserBookCopyWith(BookListItemUserBook value,
          $Res Function(BookListItemUserBook) then) =
      _$BookListItemUserBookCopyWithImpl<$Res, BookListItemUserBook>;
  @useResult
  $Res call(
      {int id,
      String title,
      List<String> authors,
      String? coverImageUrl,
      String readingStatus});
}

/// @nodoc
class _$BookListItemUserBookCopyWithImpl<$Res,
        $Val extends BookListItemUserBook>
    implements $BookListItemUserBookCopyWith<$Res> {
  _$BookListItemUserBookCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookListItemUserBook
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? authors = null,
    Object? coverImageUrl = freezed,
    Object? readingStatus = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
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
      readingStatus: null == readingStatus
          ? _value.readingStatus
          : readingStatus // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookListItemUserBookImplCopyWith<$Res>
    implements $BookListItemUserBookCopyWith<$Res> {
  factory _$$BookListItemUserBookImplCopyWith(_$BookListItemUserBookImpl value,
          $Res Function(_$BookListItemUserBookImpl) then) =
      __$$BookListItemUserBookImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      List<String> authors,
      String? coverImageUrl,
      String readingStatus});
}

/// @nodoc
class __$$BookListItemUserBookImplCopyWithImpl<$Res>
    extends _$BookListItemUserBookCopyWithImpl<$Res, _$BookListItemUserBookImpl>
    implements _$$BookListItemUserBookImplCopyWith<$Res> {
  __$$BookListItemUserBookImplCopyWithImpl(_$BookListItemUserBookImpl _value,
      $Res Function(_$BookListItemUserBookImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookListItemUserBook
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? authors = null,
    Object? coverImageUrl = freezed,
    Object? readingStatus = null,
  }) {
    return _then(_$BookListItemUserBookImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
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
      readingStatus: null == readingStatus
          ? _value.readingStatus
          : readingStatus // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$BookListItemUserBookImpl implements _BookListItemUserBook {
  const _$BookListItemUserBookImpl(
      {required this.id,
      required this.title,
      required final List<String> authors,
      this.coverImageUrl,
      required this.readingStatus})
      : _authors = authors;

  @override
  final int id;
  @override
  final String title;
  final List<String> _authors;
  @override
  List<String> get authors {
    if (_authors is EqualUnmodifiableListView) return _authors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_authors);
  }

  @override
  final String? coverImageUrl;
  @override
  final String readingStatus;

  @override
  String toString() {
    return 'BookListItemUserBook(id: $id, title: $title, authors: $authors, coverImageUrl: $coverImageUrl, readingStatus: $readingStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookListItemUserBookImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._authors, _authors) &&
            (identical(other.coverImageUrl, coverImageUrl) ||
                other.coverImageUrl == coverImageUrl) &&
            (identical(other.readingStatus, readingStatus) ||
                other.readingStatus == readingStatus));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      const DeepCollectionEquality().hash(_authors),
      coverImageUrl,
      readingStatus);

  /// Create a copy of BookListItemUserBook
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookListItemUserBookImplCopyWith<_$BookListItemUserBookImpl>
      get copyWith =>
          __$$BookListItemUserBookImplCopyWithImpl<_$BookListItemUserBookImpl>(
              this, _$identity);
}

abstract class _BookListItemUserBook implements BookListItemUserBook {
  const factory _BookListItemUserBook(
      {required final int id,
      required final String title,
      required final List<String> authors,
      final String? coverImageUrl,
      required final String readingStatus}) = _$BookListItemUserBookImpl;

  @override
  int get id;
  @override
  String get title;
  @override
  List<String> get authors;
  @override
  String? get coverImageUrl;
  @override
  String get readingStatus;

  /// Create a copy of BookListItemUserBook
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookListItemUserBookImplCopyWith<_$BookListItemUserBookImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BookListDetailStats {
  int get bookCount => throw _privateConstructorUsedError;
  int get completedCount => throw _privateConstructorUsedError;
  List<String> get coverImages => throw _privateConstructorUsedError;

  /// Create a copy of BookListDetailStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookListDetailStatsCopyWith<BookListDetailStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookListDetailStatsCopyWith<$Res> {
  factory $BookListDetailStatsCopyWith(
          BookListDetailStats value, $Res Function(BookListDetailStats) then) =
      _$BookListDetailStatsCopyWithImpl<$Res, BookListDetailStats>;
  @useResult
  $Res call({int bookCount, int completedCount, List<String> coverImages});
}

/// @nodoc
class _$BookListDetailStatsCopyWithImpl<$Res, $Val extends BookListDetailStats>
    implements $BookListDetailStatsCopyWith<$Res> {
  _$BookListDetailStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookListDetailStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookCount = null,
    Object? completedCount = null,
    Object? coverImages = null,
  }) {
    return _then(_value.copyWith(
      bookCount: null == bookCount
          ? _value.bookCount
          : bookCount // ignore: cast_nullable_to_non_nullable
              as int,
      completedCount: null == completedCount
          ? _value.completedCount
          : completedCount // ignore: cast_nullable_to_non_nullable
              as int,
      coverImages: null == coverImages
          ? _value.coverImages
          : coverImages // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookListDetailStatsImplCopyWith<$Res>
    implements $BookListDetailStatsCopyWith<$Res> {
  factory _$$BookListDetailStatsImplCopyWith(_$BookListDetailStatsImpl value,
          $Res Function(_$BookListDetailStatsImpl) then) =
      __$$BookListDetailStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int bookCount, int completedCount, List<String> coverImages});
}

/// @nodoc
class __$$BookListDetailStatsImplCopyWithImpl<$Res>
    extends _$BookListDetailStatsCopyWithImpl<$Res, _$BookListDetailStatsImpl>
    implements _$$BookListDetailStatsImplCopyWith<$Res> {
  __$$BookListDetailStatsImplCopyWithImpl(_$BookListDetailStatsImpl _value,
      $Res Function(_$BookListDetailStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookListDetailStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookCount = null,
    Object? completedCount = null,
    Object? coverImages = null,
  }) {
    return _then(_$BookListDetailStatsImpl(
      bookCount: null == bookCount
          ? _value.bookCount
          : bookCount // ignore: cast_nullable_to_non_nullable
              as int,
      completedCount: null == completedCount
          ? _value.completedCount
          : completedCount // ignore: cast_nullable_to_non_nullable
              as int,
      coverImages: null == coverImages
          ? _value._coverImages
          : coverImages // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$BookListDetailStatsImpl implements _BookListDetailStats {
  const _$BookListDetailStatsImpl(
      {required this.bookCount,
      required this.completedCount,
      required final List<String> coverImages})
      : _coverImages = coverImages;

  @override
  final int bookCount;
  @override
  final int completedCount;
  final List<String> _coverImages;
  @override
  List<String> get coverImages {
    if (_coverImages is EqualUnmodifiableListView) return _coverImages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_coverImages);
  }

  @override
  String toString() {
    return 'BookListDetailStats(bookCount: $bookCount, completedCount: $completedCount, coverImages: $coverImages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookListDetailStatsImpl &&
            (identical(other.bookCount, bookCount) ||
                other.bookCount == bookCount) &&
            (identical(other.completedCount, completedCount) ||
                other.completedCount == completedCount) &&
            const DeepCollectionEquality()
                .equals(other._coverImages, _coverImages));
  }

  @override
  int get hashCode => Object.hash(runtimeType, bookCount, completedCount,
      const DeepCollectionEquality().hash(_coverImages));

  /// Create a copy of BookListDetailStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookListDetailStatsImplCopyWith<_$BookListDetailStatsImpl> get copyWith =>
      __$$BookListDetailStatsImplCopyWithImpl<_$BookListDetailStatsImpl>(
          this, _$identity);
}

abstract class _BookListDetailStats implements BookListDetailStats {
  const factory _BookListDetailStats(
      {required final int bookCount,
      required final int completedCount,
      required final List<String> coverImages}) = _$BookListDetailStatsImpl;

  @override
  int get bookCount;
  @override
  int get completedCount;
  @override
  List<String> get coverImages;

  /// Create a copy of BookListDetailStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookListDetailStatsImplCopyWith<_$BookListDetailStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MyBookListsResult {
  List<BookListSummary> get items => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;

  /// Create a copy of MyBookListsResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MyBookListsResultCopyWith<MyBookListsResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyBookListsResultCopyWith<$Res> {
  factory $MyBookListsResultCopyWith(
          MyBookListsResult value, $Res Function(MyBookListsResult) then) =
      _$MyBookListsResultCopyWithImpl<$Res, MyBookListsResult>;
  @useResult
  $Res call({List<BookListSummary> items, int totalCount, bool hasMore});
}

/// @nodoc
class _$MyBookListsResultCopyWithImpl<$Res, $Val extends MyBookListsResult>
    implements $MyBookListsResultCopyWith<$Res> {
  _$MyBookListsResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MyBookListsResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? totalCount = null,
    Object? hasMore = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<BookListSummary>,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MyBookListsResultImplCopyWith<$Res>
    implements $MyBookListsResultCopyWith<$Res> {
  factory _$$MyBookListsResultImplCopyWith(_$MyBookListsResultImpl value,
          $Res Function(_$MyBookListsResultImpl) then) =
      __$$MyBookListsResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<BookListSummary> items, int totalCount, bool hasMore});
}

/// @nodoc
class __$$MyBookListsResultImplCopyWithImpl<$Res>
    extends _$MyBookListsResultCopyWithImpl<$Res, _$MyBookListsResultImpl>
    implements _$$MyBookListsResultImplCopyWith<$Res> {
  __$$MyBookListsResultImplCopyWithImpl(_$MyBookListsResultImpl _value,
      $Res Function(_$MyBookListsResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of MyBookListsResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? totalCount = null,
    Object? hasMore = null,
  }) {
    return _then(_$MyBookListsResultImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<BookListSummary>,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$MyBookListsResultImpl implements _MyBookListsResult {
  const _$MyBookListsResultImpl(
      {required final List<BookListSummary> items,
      required this.totalCount,
      required this.hasMore})
      : _items = items;

  final List<BookListSummary> _items;
  @override
  List<BookListSummary> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final int totalCount;
  @override
  final bool hasMore;

  @override
  String toString() {
    return 'MyBookListsResult(items: $items, totalCount: $totalCount, hasMore: $hasMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyBookListsResultImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_items), totalCount, hasMore);

  /// Create a copy of MyBookListsResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MyBookListsResultImplCopyWith<_$MyBookListsResultImpl> get copyWith =>
      __$$MyBookListsResultImplCopyWithImpl<_$MyBookListsResultImpl>(
          this, _$identity);
}

abstract class _MyBookListsResult implements MyBookListsResult {
  const factory _MyBookListsResult(
      {required final List<BookListSummary> items,
      required final int totalCount,
      required final bool hasMore}) = _$MyBookListsResultImpl;

  @override
  List<BookListSummary> get items;
  @override
  int get totalCount;
  @override
  bool get hasMore;

  /// Create a copy of MyBookListsResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MyBookListsResultImplCopyWith<_$MyBookListsResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
