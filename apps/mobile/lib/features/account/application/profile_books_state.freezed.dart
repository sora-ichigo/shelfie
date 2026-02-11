// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_books_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProfileBooksState {
  List<ShelfBookItem> get books => throw _privateConstructorUsedError;
  ReadingStatus? get selectedFilter => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of ProfileBooksState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileBooksStateCopyWith<ProfileBooksState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileBooksStateCopyWith<$Res> {
  factory $ProfileBooksStateCopyWith(
          ProfileBooksState value, $Res Function(ProfileBooksState) then) =
      _$ProfileBooksStateCopyWithImpl<$Res, ProfileBooksState>;
  @useResult
  $Res call(
      {List<ShelfBookItem> books,
      ReadingStatus? selectedFilter,
      bool isLoading,
      bool isLoadingMore,
      bool hasMore,
      int totalCount,
      String? error});
}

/// @nodoc
class _$ProfileBooksStateCopyWithImpl<$Res, $Val extends ProfileBooksState>
    implements $ProfileBooksStateCopyWith<$Res> {
  _$ProfileBooksStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileBooksState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? books = null,
    Object? selectedFilter = freezed,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? hasMore = null,
    Object? totalCount = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      books: null == books
          ? _value.books
          : books // ignore: cast_nullable_to_non_nullable
              as List<ShelfBookItem>,
      selectedFilter: freezed == selectedFilter
          ? _value.selectedFilter
          : selectedFilter // ignore: cast_nullable_to_non_nullable
              as ReadingStatus?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileBooksStateImplCopyWith<$Res>
    implements $ProfileBooksStateCopyWith<$Res> {
  factory _$$ProfileBooksStateImplCopyWith(_$ProfileBooksStateImpl value,
          $Res Function(_$ProfileBooksStateImpl) then) =
      __$$ProfileBooksStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ShelfBookItem> books,
      ReadingStatus? selectedFilter,
      bool isLoading,
      bool isLoadingMore,
      bool hasMore,
      int totalCount,
      String? error});
}

/// @nodoc
class __$$ProfileBooksStateImplCopyWithImpl<$Res>
    extends _$ProfileBooksStateCopyWithImpl<$Res, _$ProfileBooksStateImpl>
    implements _$$ProfileBooksStateImplCopyWith<$Res> {
  __$$ProfileBooksStateImplCopyWithImpl(_$ProfileBooksStateImpl _value,
      $Res Function(_$ProfileBooksStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileBooksState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? books = null,
    Object? selectedFilter = freezed,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? hasMore = null,
    Object? totalCount = null,
    Object? error = freezed,
  }) {
    return _then(_$ProfileBooksStateImpl(
      books: null == books
          ? _value._books
          : books // ignore: cast_nullable_to_non_nullable
              as List<ShelfBookItem>,
      selectedFilter: freezed == selectedFilter
          ? _value.selectedFilter
          : selectedFilter // ignore: cast_nullable_to_non_nullable
              as ReadingStatus?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ProfileBooksStateImpl implements _ProfileBooksState {
  const _$ProfileBooksStateImpl(
      {final List<ShelfBookItem> books = const [],
      this.selectedFilter = null,
      this.isLoading = false,
      this.isLoadingMore = false,
      this.hasMore = false,
      this.totalCount = 0,
      this.error = null})
      : _books = books;

  final List<ShelfBookItem> _books;
  @override
  @JsonKey()
  List<ShelfBookItem> get books {
    if (_books is EqualUnmodifiableListView) return _books;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_books);
  }

  @override
  @JsonKey()
  final ReadingStatus? selectedFilter;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  @JsonKey()
  final bool hasMore;
  @override
  @JsonKey()
  final int totalCount;
  @override
  @JsonKey()
  final String? error;

  @override
  String toString() {
    return 'ProfileBooksState(books: $books, selectedFilter: $selectedFilter, isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasMore: $hasMore, totalCount: $totalCount, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileBooksStateImpl &&
            const DeepCollectionEquality().equals(other._books, _books) &&
            (identical(other.selectedFilter, selectedFilter) ||
                other.selectedFilter == selectedFilter) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_books),
      selectedFilter,
      isLoading,
      isLoadingMore,
      hasMore,
      totalCount,
      error);

  /// Create a copy of ProfileBooksState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileBooksStateImplCopyWith<_$ProfileBooksStateImpl> get copyWith =>
      __$$ProfileBooksStateImplCopyWithImpl<_$ProfileBooksStateImpl>(
          this, _$identity);
}

abstract class _ProfileBooksState implements ProfileBooksState {
  const factory _ProfileBooksState(
      {final List<ShelfBookItem> books,
      final ReadingStatus? selectedFilter,
      final bool isLoading,
      final bool isLoadingMore,
      final bool hasMore,
      final int totalCount,
      final String? error}) = _$ProfileBooksStateImpl;

  @override
  List<ShelfBookItem> get books;
  @override
  ReadingStatus? get selectedFilter;
  @override
  bool get isLoading;
  @override
  bool get isLoadingMore;
  @override
  bool get hasMore;
  @override
  int get totalCount;
  @override
  String? get error;

  /// Create a copy of ProfileBooksState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileBooksStateImplCopyWith<_$ProfileBooksStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
