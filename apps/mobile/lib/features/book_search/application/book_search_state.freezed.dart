// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BookSearchState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Book> books, int totalCount, bool hasMore,
            String currentQuery, int currentOffset)
        success,
    required TResult Function(String query) empty,
    required TResult Function(Failure failure) error,
    required TResult Function(List<Book> books, int totalCount,
            String currentQuery, int currentOffset)
        loadingMore,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Book> books, int totalCount, bool hasMore,
            String currentQuery, int currentOffset)?
        success,
    TResult? Function(String query)? empty,
    TResult? Function(Failure failure)? error,
    TResult? Function(List<Book> books, int totalCount, String currentQuery,
            int currentOffset)?
        loadingMore,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Book> books, int totalCount, bool hasMore,
            String currentQuery, int currentOffset)?
        success,
    TResult Function(String query)? empty,
    TResult Function(Failure failure)? error,
    TResult Function(List<Book> books, int totalCount, String currentQuery,
            int currentOffset)?
        loadingMore,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BookSearchInitial value) initial,
    required TResult Function(BookSearchLoading value) loading,
    required TResult Function(BookSearchSuccess value) success,
    required TResult Function(BookSearchEmpty value) empty,
    required TResult Function(BookSearchError value) error,
    required TResult Function(BookSearchLoadingMore value) loadingMore,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookSearchInitial value)? initial,
    TResult? Function(BookSearchLoading value)? loading,
    TResult? Function(BookSearchSuccess value)? success,
    TResult? Function(BookSearchEmpty value)? empty,
    TResult? Function(BookSearchError value)? error,
    TResult? Function(BookSearchLoadingMore value)? loadingMore,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookSearchInitial value)? initial,
    TResult Function(BookSearchLoading value)? loading,
    TResult Function(BookSearchSuccess value)? success,
    TResult Function(BookSearchEmpty value)? empty,
    TResult Function(BookSearchError value)? error,
    TResult Function(BookSearchLoadingMore value)? loadingMore,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookSearchStateCopyWith<$Res> {
  factory $BookSearchStateCopyWith(
          BookSearchState value, $Res Function(BookSearchState) then) =
      _$BookSearchStateCopyWithImpl<$Res, BookSearchState>;
}

/// @nodoc
class _$BookSearchStateCopyWithImpl<$Res, $Val extends BookSearchState>
    implements $BookSearchStateCopyWith<$Res> {
  _$BookSearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$BookSearchInitialImplCopyWith<$Res> {
  factory _$$BookSearchInitialImplCopyWith(_$BookSearchInitialImpl value,
          $Res Function(_$BookSearchInitialImpl) then) =
      __$$BookSearchInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BookSearchInitialImplCopyWithImpl<$Res>
    extends _$BookSearchStateCopyWithImpl<$Res, _$BookSearchInitialImpl>
    implements _$$BookSearchInitialImplCopyWith<$Res> {
  __$$BookSearchInitialImplCopyWithImpl(_$BookSearchInitialImpl _value,
      $Res Function(_$BookSearchInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BookSearchInitialImpl implements BookSearchInitial {
  const _$BookSearchInitialImpl();

  @override
  String toString() {
    return 'BookSearchState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BookSearchInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Book> books, int totalCount, bool hasMore,
            String currentQuery, int currentOffset)
        success,
    required TResult Function(String query) empty,
    required TResult Function(Failure failure) error,
    required TResult Function(List<Book> books, int totalCount,
            String currentQuery, int currentOffset)
        loadingMore,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Book> books, int totalCount, bool hasMore,
            String currentQuery, int currentOffset)?
        success,
    TResult? Function(String query)? empty,
    TResult? Function(Failure failure)? error,
    TResult? Function(List<Book> books, int totalCount, String currentQuery,
            int currentOffset)?
        loadingMore,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Book> books, int totalCount, bool hasMore,
            String currentQuery, int currentOffset)?
        success,
    TResult Function(String query)? empty,
    TResult Function(Failure failure)? error,
    TResult Function(List<Book> books, int totalCount, String currentQuery,
            int currentOffset)?
        loadingMore,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BookSearchInitial value) initial,
    required TResult Function(BookSearchLoading value) loading,
    required TResult Function(BookSearchSuccess value) success,
    required TResult Function(BookSearchEmpty value) empty,
    required TResult Function(BookSearchError value) error,
    required TResult Function(BookSearchLoadingMore value) loadingMore,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookSearchInitial value)? initial,
    TResult? Function(BookSearchLoading value)? loading,
    TResult? Function(BookSearchSuccess value)? success,
    TResult? Function(BookSearchEmpty value)? empty,
    TResult? Function(BookSearchError value)? error,
    TResult? Function(BookSearchLoadingMore value)? loadingMore,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookSearchInitial value)? initial,
    TResult Function(BookSearchLoading value)? loading,
    TResult Function(BookSearchSuccess value)? success,
    TResult Function(BookSearchEmpty value)? empty,
    TResult Function(BookSearchError value)? error,
    TResult Function(BookSearchLoadingMore value)? loadingMore,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class BookSearchInitial implements BookSearchState {
  const factory BookSearchInitial() = _$BookSearchInitialImpl;
}

/// @nodoc
abstract class _$$BookSearchLoadingImplCopyWith<$Res> {
  factory _$$BookSearchLoadingImplCopyWith(_$BookSearchLoadingImpl value,
          $Res Function(_$BookSearchLoadingImpl) then) =
      __$$BookSearchLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BookSearchLoadingImplCopyWithImpl<$Res>
    extends _$BookSearchStateCopyWithImpl<$Res, _$BookSearchLoadingImpl>
    implements _$$BookSearchLoadingImplCopyWith<$Res> {
  __$$BookSearchLoadingImplCopyWithImpl(_$BookSearchLoadingImpl _value,
      $Res Function(_$BookSearchLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BookSearchLoadingImpl implements BookSearchLoading {
  const _$BookSearchLoadingImpl();

  @override
  String toString() {
    return 'BookSearchState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BookSearchLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Book> books, int totalCount, bool hasMore,
            String currentQuery, int currentOffset)
        success,
    required TResult Function(String query) empty,
    required TResult Function(Failure failure) error,
    required TResult Function(List<Book> books, int totalCount,
            String currentQuery, int currentOffset)
        loadingMore,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Book> books, int totalCount, bool hasMore,
            String currentQuery, int currentOffset)?
        success,
    TResult? Function(String query)? empty,
    TResult? Function(Failure failure)? error,
    TResult? Function(List<Book> books, int totalCount, String currentQuery,
            int currentOffset)?
        loadingMore,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Book> books, int totalCount, bool hasMore,
            String currentQuery, int currentOffset)?
        success,
    TResult Function(String query)? empty,
    TResult Function(Failure failure)? error,
    TResult Function(List<Book> books, int totalCount, String currentQuery,
            int currentOffset)?
        loadingMore,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BookSearchInitial value) initial,
    required TResult Function(BookSearchLoading value) loading,
    required TResult Function(BookSearchSuccess value) success,
    required TResult Function(BookSearchEmpty value) empty,
    required TResult Function(BookSearchError value) error,
    required TResult Function(BookSearchLoadingMore value) loadingMore,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookSearchInitial value)? initial,
    TResult? Function(BookSearchLoading value)? loading,
    TResult? Function(BookSearchSuccess value)? success,
    TResult? Function(BookSearchEmpty value)? empty,
    TResult? Function(BookSearchError value)? error,
    TResult? Function(BookSearchLoadingMore value)? loadingMore,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookSearchInitial value)? initial,
    TResult Function(BookSearchLoading value)? loading,
    TResult Function(BookSearchSuccess value)? success,
    TResult Function(BookSearchEmpty value)? empty,
    TResult Function(BookSearchError value)? error,
    TResult Function(BookSearchLoadingMore value)? loadingMore,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class BookSearchLoading implements BookSearchState {
  const factory BookSearchLoading() = _$BookSearchLoadingImpl;
}

/// @nodoc
abstract class _$$BookSearchSuccessImplCopyWith<$Res> {
  factory _$$BookSearchSuccessImplCopyWith(_$BookSearchSuccessImpl value,
          $Res Function(_$BookSearchSuccessImpl) then) =
      __$$BookSearchSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<Book> books,
      int totalCount,
      bool hasMore,
      String currentQuery,
      int currentOffset});
}

/// @nodoc
class __$$BookSearchSuccessImplCopyWithImpl<$Res>
    extends _$BookSearchStateCopyWithImpl<$Res, _$BookSearchSuccessImpl>
    implements _$$BookSearchSuccessImplCopyWith<$Res> {
  __$$BookSearchSuccessImplCopyWithImpl(_$BookSearchSuccessImpl _value,
      $Res Function(_$BookSearchSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? books = null,
    Object? totalCount = null,
    Object? hasMore = null,
    Object? currentQuery = null,
    Object? currentOffset = null,
  }) {
    return _then(_$BookSearchSuccessImpl(
      books: null == books
          ? _value._books
          : books // ignore: cast_nullable_to_non_nullable
              as List<Book>,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      currentQuery: null == currentQuery
          ? _value.currentQuery
          : currentQuery // ignore: cast_nullable_to_non_nullable
              as String,
      currentOffset: null == currentOffset
          ? _value.currentOffset
          : currentOffset // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$BookSearchSuccessImpl implements BookSearchSuccess {
  const _$BookSearchSuccessImpl(
      {required final List<Book> books,
      required this.totalCount,
      required this.hasMore,
      required this.currentQuery,
      required this.currentOffset})
      : _books = books;

  final List<Book> _books;
  @override
  List<Book> get books {
    if (_books is EqualUnmodifiableListView) return _books;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_books);
  }

  @override
  final int totalCount;
  @override
  final bool hasMore;
  @override
  final String currentQuery;
  @override
  final int currentOffset;

  @override
  String toString() {
    return 'BookSearchState.success(books: $books, totalCount: $totalCount, hasMore: $hasMore, currentQuery: $currentQuery, currentOffset: $currentOffset)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookSearchSuccessImpl &&
            const DeepCollectionEquality().equals(other._books, _books) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.currentQuery, currentQuery) ||
                other.currentQuery == currentQuery) &&
            (identical(other.currentOffset, currentOffset) ||
                other.currentOffset == currentOffset));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_books),
      totalCount,
      hasMore,
      currentQuery,
      currentOffset);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookSearchSuccessImplCopyWith<_$BookSearchSuccessImpl> get copyWith =>
      __$$BookSearchSuccessImplCopyWithImpl<_$BookSearchSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Book> books, int totalCount, bool hasMore,
            String currentQuery, int currentOffset)
        success,
    required TResult Function(String query) empty,
    required TResult Function(Failure failure) error,
    required TResult Function(List<Book> books, int totalCount,
            String currentQuery, int currentOffset)
        loadingMore,
  }) {
    return success(books, totalCount, hasMore, currentQuery, currentOffset);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Book> books, int totalCount, bool hasMore,
            String currentQuery, int currentOffset)?
        success,
    TResult? Function(String query)? empty,
    TResult? Function(Failure failure)? error,
    TResult? Function(List<Book> books, int totalCount, String currentQuery,
            int currentOffset)?
        loadingMore,
  }) {
    return success?.call(
        books, totalCount, hasMore, currentQuery, currentOffset);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Book> books, int totalCount, bool hasMore,
            String currentQuery, int currentOffset)?
        success,
    TResult Function(String query)? empty,
    TResult Function(Failure failure)? error,
    TResult Function(List<Book> books, int totalCount, String currentQuery,
            int currentOffset)?
        loadingMore,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(books, totalCount, hasMore, currentQuery, currentOffset);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BookSearchInitial value) initial,
    required TResult Function(BookSearchLoading value) loading,
    required TResult Function(BookSearchSuccess value) success,
    required TResult Function(BookSearchEmpty value) empty,
    required TResult Function(BookSearchError value) error,
    required TResult Function(BookSearchLoadingMore value) loadingMore,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookSearchInitial value)? initial,
    TResult? Function(BookSearchLoading value)? loading,
    TResult? Function(BookSearchSuccess value)? success,
    TResult? Function(BookSearchEmpty value)? empty,
    TResult? Function(BookSearchError value)? error,
    TResult? Function(BookSearchLoadingMore value)? loadingMore,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookSearchInitial value)? initial,
    TResult Function(BookSearchLoading value)? loading,
    TResult Function(BookSearchSuccess value)? success,
    TResult Function(BookSearchEmpty value)? empty,
    TResult Function(BookSearchError value)? error,
    TResult Function(BookSearchLoadingMore value)? loadingMore,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class BookSearchSuccess implements BookSearchState {
  const factory BookSearchSuccess(
      {required final List<Book> books,
      required final int totalCount,
      required final bool hasMore,
      required final String currentQuery,
      required final int currentOffset}) = _$BookSearchSuccessImpl;

  List<Book> get books;
  int get totalCount;
  bool get hasMore;
  String get currentQuery;
  int get currentOffset;
  @JsonKey(ignore: true)
  _$$BookSearchSuccessImplCopyWith<_$BookSearchSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BookSearchEmptyImplCopyWith<$Res> {
  factory _$$BookSearchEmptyImplCopyWith(_$BookSearchEmptyImpl value,
          $Res Function(_$BookSearchEmptyImpl) then) =
      __$$BookSearchEmptyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$$BookSearchEmptyImplCopyWithImpl<$Res>
    extends _$BookSearchStateCopyWithImpl<$Res, _$BookSearchEmptyImpl>
    implements _$$BookSearchEmptyImplCopyWith<$Res> {
  __$$BookSearchEmptyImplCopyWithImpl(
      _$BookSearchEmptyImpl _value, $Res Function(_$BookSearchEmptyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
  }) {
    return _then(_$BookSearchEmptyImpl(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$BookSearchEmptyImpl implements BookSearchEmpty {
  const _$BookSearchEmptyImpl({required this.query});

  @override
  final String query;

  @override
  String toString() {
    return 'BookSearchState.empty(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookSearchEmptyImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookSearchEmptyImplCopyWith<_$BookSearchEmptyImpl> get copyWith =>
      __$$BookSearchEmptyImplCopyWithImpl<_$BookSearchEmptyImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Book> books, int totalCount, bool hasMore,
            String currentQuery, int currentOffset)
        success,
    required TResult Function(String query) empty,
    required TResult Function(Failure failure) error,
    required TResult Function(List<Book> books, int totalCount,
            String currentQuery, int currentOffset)
        loadingMore,
  }) {
    return empty(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Book> books, int totalCount, bool hasMore,
            String currentQuery, int currentOffset)?
        success,
    TResult? Function(String query)? empty,
    TResult? Function(Failure failure)? error,
    TResult? Function(List<Book> books, int totalCount, String currentQuery,
            int currentOffset)?
        loadingMore,
  }) {
    return empty?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Book> books, int totalCount, bool hasMore,
            String currentQuery, int currentOffset)?
        success,
    TResult Function(String query)? empty,
    TResult Function(Failure failure)? error,
    TResult Function(List<Book> books, int totalCount, String currentQuery,
            int currentOffset)?
        loadingMore,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BookSearchInitial value) initial,
    required TResult Function(BookSearchLoading value) loading,
    required TResult Function(BookSearchSuccess value) success,
    required TResult Function(BookSearchEmpty value) empty,
    required TResult Function(BookSearchError value) error,
    required TResult Function(BookSearchLoadingMore value) loadingMore,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookSearchInitial value)? initial,
    TResult? Function(BookSearchLoading value)? loading,
    TResult? Function(BookSearchSuccess value)? success,
    TResult? Function(BookSearchEmpty value)? empty,
    TResult? Function(BookSearchError value)? error,
    TResult? Function(BookSearchLoadingMore value)? loadingMore,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookSearchInitial value)? initial,
    TResult Function(BookSearchLoading value)? loading,
    TResult Function(BookSearchSuccess value)? success,
    TResult Function(BookSearchEmpty value)? empty,
    TResult Function(BookSearchError value)? error,
    TResult Function(BookSearchLoadingMore value)? loadingMore,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class BookSearchEmpty implements BookSearchState {
  const factory BookSearchEmpty({required final String query}) =
      _$BookSearchEmptyImpl;

  String get query;
  @JsonKey(ignore: true)
  _$$BookSearchEmptyImplCopyWith<_$BookSearchEmptyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BookSearchErrorImplCopyWith<$Res> {
  factory _$$BookSearchErrorImplCopyWith(_$BookSearchErrorImpl value,
          $Res Function(_$BookSearchErrorImpl) then) =
      __$$BookSearchErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Failure failure});

  $FailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$BookSearchErrorImplCopyWithImpl<$Res>
    extends _$BookSearchStateCopyWithImpl<$Res, _$BookSearchErrorImpl>
    implements _$$BookSearchErrorImplCopyWith<$Res> {
  __$$BookSearchErrorImplCopyWithImpl(
      _$BookSearchErrorImpl _value, $Res Function(_$BookSearchErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$BookSearchErrorImpl(
      failure: null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $FailureCopyWith<$Res> get failure {
    return $FailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc

class _$BookSearchErrorImpl implements BookSearchError {
  const _$BookSearchErrorImpl({required this.failure});

  @override
  final Failure failure;

  @override
  String toString() {
    return 'BookSearchState.error(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookSearchErrorImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookSearchErrorImplCopyWith<_$BookSearchErrorImpl> get copyWith =>
      __$$BookSearchErrorImplCopyWithImpl<_$BookSearchErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Book> books, int totalCount, bool hasMore,
            String currentQuery, int currentOffset)
        success,
    required TResult Function(String query) empty,
    required TResult Function(Failure failure) error,
    required TResult Function(List<Book> books, int totalCount,
            String currentQuery, int currentOffset)
        loadingMore,
  }) {
    return error(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Book> books, int totalCount, bool hasMore,
            String currentQuery, int currentOffset)?
        success,
    TResult? Function(String query)? empty,
    TResult? Function(Failure failure)? error,
    TResult? Function(List<Book> books, int totalCount, String currentQuery,
            int currentOffset)?
        loadingMore,
  }) {
    return error?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Book> books, int totalCount, bool hasMore,
            String currentQuery, int currentOffset)?
        success,
    TResult Function(String query)? empty,
    TResult Function(Failure failure)? error,
    TResult Function(List<Book> books, int totalCount, String currentQuery,
            int currentOffset)?
        loadingMore,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BookSearchInitial value) initial,
    required TResult Function(BookSearchLoading value) loading,
    required TResult Function(BookSearchSuccess value) success,
    required TResult Function(BookSearchEmpty value) empty,
    required TResult Function(BookSearchError value) error,
    required TResult Function(BookSearchLoadingMore value) loadingMore,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookSearchInitial value)? initial,
    TResult? Function(BookSearchLoading value)? loading,
    TResult? Function(BookSearchSuccess value)? success,
    TResult? Function(BookSearchEmpty value)? empty,
    TResult? Function(BookSearchError value)? error,
    TResult? Function(BookSearchLoadingMore value)? loadingMore,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookSearchInitial value)? initial,
    TResult Function(BookSearchLoading value)? loading,
    TResult Function(BookSearchSuccess value)? success,
    TResult Function(BookSearchEmpty value)? empty,
    TResult Function(BookSearchError value)? error,
    TResult Function(BookSearchLoadingMore value)? loadingMore,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class BookSearchError implements BookSearchState {
  const factory BookSearchError({required final Failure failure}) =
      _$BookSearchErrorImpl;

  Failure get failure;
  @JsonKey(ignore: true)
  _$$BookSearchErrorImplCopyWith<_$BookSearchErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BookSearchLoadingMoreImplCopyWith<$Res> {
  factory _$$BookSearchLoadingMoreImplCopyWith(
          _$BookSearchLoadingMoreImpl value,
          $Res Function(_$BookSearchLoadingMoreImpl) then) =
      __$$BookSearchLoadingMoreImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<Book> books,
      int totalCount,
      String currentQuery,
      int currentOffset});
}

/// @nodoc
class __$$BookSearchLoadingMoreImplCopyWithImpl<$Res>
    extends _$BookSearchStateCopyWithImpl<$Res, _$BookSearchLoadingMoreImpl>
    implements _$$BookSearchLoadingMoreImplCopyWith<$Res> {
  __$$BookSearchLoadingMoreImplCopyWithImpl(_$BookSearchLoadingMoreImpl _value,
      $Res Function(_$BookSearchLoadingMoreImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? books = null,
    Object? totalCount = null,
    Object? currentQuery = null,
    Object? currentOffset = null,
  }) {
    return _then(_$BookSearchLoadingMoreImpl(
      books: null == books
          ? _value._books
          : books // ignore: cast_nullable_to_non_nullable
              as List<Book>,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      currentQuery: null == currentQuery
          ? _value.currentQuery
          : currentQuery // ignore: cast_nullable_to_non_nullable
              as String,
      currentOffset: null == currentOffset
          ? _value.currentOffset
          : currentOffset // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$BookSearchLoadingMoreImpl implements BookSearchLoadingMore {
  const _$BookSearchLoadingMoreImpl(
      {required final List<Book> books,
      required this.totalCount,
      required this.currentQuery,
      required this.currentOffset})
      : _books = books;

  final List<Book> _books;
  @override
  List<Book> get books {
    if (_books is EqualUnmodifiableListView) return _books;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_books);
  }

  @override
  final int totalCount;
  @override
  final String currentQuery;
  @override
  final int currentOffset;

  @override
  String toString() {
    return 'BookSearchState.loadingMore(books: $books, totalCount: $totalCount, currentQuery: $currentQuery, currentOffset: $currentOffset)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookSearchLoadingMoreImpl &&
            const DeepCollectionEquality().equals(other._books, _books) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.currentQuery, currentQuery) ||
                other.currentQuery == currentQuery) &&
            (identical(other.currentOffset, currentOffset) ||
                other.currentOffset == currentOffset));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_books),
      totalCount,
      currentQuery,
      currentOffset);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookSearchLoadingMoreImplCopyWith<_$BookSearchLoadingMoreImpl>
      get copyWith => __$$BookSearchLoadingMoreImplCopyWithImpl<
          _$BookSearchLoadingMoreImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Book> books, int totalCount, bool hasMore,
            String currentQuery, int currentOffset)
        success,
    required TResult Function(String query) empty,
    required TResult Function(Failure failure) error,
    required TResult Function(List<Book> books, int totalCount,
            String currentQuery, int currentOffset)
        loadingMore,
  }) {
    return loadingMore(books, totalCount, currentQuery, currentOffset);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Book> books, int totalCount, bool hasMore,
            String currentQuery, int currentOffset)?
        success,
    TResult? Function(String query)? empty,
    TResult? Function(Failure failure)? error,
    TResult? Function(List<Book> books, int totalCount, String currentQuery,
            int currentOffset)?
        loadingMore,
  }) {
    return loadingMore?.call(books, totalCount, currentQuery, currentOffset);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Book> books, int totalCount, bool hasMore,
            String currentQuery, int currentOffset)?
        success,
    TResult Function(String query)? empty,
    TResult Function(Failure failure)? error,
    TResult Function(List<Book> books, int totalCount, String currentQuery,
            int currentOffset)?
        loadingMore,
    required TResult orElse(),
  }) {
    if (loadingMore != null) {
      return loadingMore(books, totalCount, currentQuery, currentOffset);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BookSearchInitial value) initial,
    required TResult Function(BookSearchLoading value) loading,
    required TResult Function(BookSearchSuccess value) success,
    required TResult Function(BookSearchEmpty value) empty,
    required TResult Function(BookSearchError value) error,
    required TResult Function(BookSearchLoadingMore value) loadingMore,
  }) {
    return loadingMore(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookSearchInitial value)? initial,
    TResult? Function(BookSearchLoading value)? loading,
    TResult? Function(BookSearchSuccess value)? success,
    TResult? Function(BookSearchEmpty value)? empty,
    TResult? Function(BookSearchError value)? error,
    TResult? Function(BookSearchLoadingMore value)? loadingMore,
  }) {
    return loadingMore?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookSearchInitial value)? initial,
    TResult Function(BookSearchLoading value)? loading,
    TResult Function(BookSearchSuccess value)? success,
    TResult Function(BookSearchEmpty value)? empty,
    TResult Function(BookSearchError value)? error,
    TResult Function(BookSearchLoadingMore value)? loadingMore,
    required TResult orElse(),
  }) {
    if (loadingMore != null) {
      return loadingMore(this);
    }
    return orElse();
  }
}

abstract class BookSearchLoadingMore implements BookSearchState {
  const factory BookSearchLoadingMore(
      {required final List<Book> books,
      required final int totalCount,
      required final String currentQuery,
      required final int currentOffset}) = _$BookSearchLoadingMoreImpl;

  List<Book> get books;
  int get totalCount;
  String get currentQuery;
  int get currentOffset;
  @JsonKey(ignore: true)
  _$$BookSearchLoadingMoreImplCopyWith<_$BookSearchLoadingMoreImpl>
      get copyWith => throw _privateConstructorUsedError;
}
