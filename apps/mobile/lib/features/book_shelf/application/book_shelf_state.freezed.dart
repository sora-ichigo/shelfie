// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_shelf_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BookShelfState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ShelfBookItem> books, SortOption sortOption,
            bool hasMore, bool isLoadingMore, int totalCount)
        loaded,
    required TResult Function(Failure failure) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ShelfBookItem> books, SortOption sortOption,
            bool hasMore, bool isLoadingMore, int totalCount)?
        loaded,
    TResult? Function(Failure failure)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ShelfBookItem> books, SortOption sortOption,
            bool hasMore, bool isLoadingMore, int totalCount)?
        loaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BookShelfInitial value) initial,
    required TResult Function(BookShelfLoading value) loading,
    required TResult Function(BookShelfLoaded value) loaded,
    required TResult Function(BookShelfError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookShelfInitial value)? initial,
    TResult? Function(BookShelfLoading value)? loading,
    TResult? Function(BookShelfLoaded value)? loaded,
    TResult? Function(BookShelfError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookShelfInitial value)? initial,
    TResult Function(BookShelfLoading value)? loading,
    TResult Function(BookShelfLoaded value)? loaded,
    TResult Function(BookShelfError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookShelfStateCopyWith<$Res> {
  factory $BookShelfStateCopyWith(
          BookShelfState value, $Res Function(BookShelfState) then) =
      _$BookShelfStateCopyWithImpl<$Res, BookShelfState>;
}

/// @nodoc
class _$BookShelfStateCopyWithImpl<$Res, $Val extends BookShelfState>
    implements $BookShelfStateCopyWith<$Res> {
  _$BookShelfStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$BookShelfInitialImplCopyWith<$Res> {
  factory _$$BookShelfInitialImplCopyWith(_$BookShelfInitialImpl value,
          $Res Function(_$BookShelfInitialImpl) then) =
      __$$BookShelfInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BookShelfInitialImplCopyWithImpl<$Res>
    extends _$BookShelfStateCopyWithImpl<$Res, _$BookShelfInitialImpl>
    implements _$$BookShelfInitialImplCopyWith<$Res> {
  __$$BookShelfInitialImplCopyWithImpl(_$BookShelfInitialImpl _value,
      $Res Function(_$BookShelfInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BookShelfInitialImpl implements BookShelfInitial {
  const _$BookShelfInitialImpl();

  @override
  String toString() {
    return 'BookShelfState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BookShelfInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ShelfBookItem> books, SortOption sortOption,
            bool hasMore, bool isLoadingMore, int totalCount)
        loaded,
    required TResult Function(Failure failure) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ShelfBookItem> books, SortOption sortOption,
            bool hasMore, bool isLoadingMore, int totalCount)?
        loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ShelfBookItem> books, SortOption sortOption,
            bool hasMore, bool isLoadingMore, int totalCount)?
        loaded,
    TResult Function(Failure failure)? error,
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
    required TResult Function(BookShelfInitial value) initial,
    required TResult Function(BookShelfLoading value) loading,
    required TResult Function(BookShelfLoaded value) loaded,
    required TResult Function(BookShelfError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookShelfInitial value)? initial,
    TResult? Function(BookShelfLoading value)? loading,
    TResult? Function(BookShelfLoaded value)? loaded,
    TResult? Function(BookShelfError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookShelfInitial value)? initial,
    TResult Function(BookShelfLoading value)? loading,
    TResult Function(BookShelfLoaded value)? loaded,
    TResult Function(BookShelfError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class BookShelfInitial implements BookShelfState {
  const factory BookShelfInitial() = _$BookShelfInitialImpl;
}

/// @nodoc
abstract class _$$BookShelfLoadingImplCopyWith<$Res> {
  factory _$$BookShelfLoadingImplCopyWith(_$BookShelfLoadingImpl value,
          $Res Function(_$BookShelfLoadingImpl) then) =
      __$$BookShelfLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BookShelfLoadingImplCopyWithImpl<$Res>
    extends _$BookShelfStateCopyWithImpl<$Res, _$BookShelfLoadingImpl>
    implements _$$BookShelfLoadingImplCopyWith<$Res> {
  __$$BookShelfLoadingImplCopyWithImpl(_$BookShelfLoadingImpl _value,
      $Res Function(_$BookShelfLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BookShelfLoadingImpl implements BookShelfLoading {
  const _$BookShelfLoadingImpl();

  @override
  String toString() {
    return 'BookShelfState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BookShelfLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ShelfBookItem> books, SortOption sortOption,
            bool hasMore, bool isLoadingMore, int totalCount)
        loaded,
    required TResult Function(Failure failure) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ShelfBookItem> books, SortOption sortOption,
            bool hasMore, bool isLoadingMore, int totalCount)?
        loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ShelfBookItem> books, SortOption sortOption,
            bool hasMore, bool isLoadingMore, int totalCount)?
        loaded,
    TResult Function(Failure failure)? error,
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
    required TResult Function(BookShelfInitial value) initial,
    required TResult Function(BookShelfLoading value) loading,
    required TResult Function(BookShelfLoaded value) loaded,
    required TResult Function(BookShelfError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookShelfInitial value)? initial,
    TResult? Function(BookShelfLoading value)? loading,
    TResult? Function(BookShelfLoaded value)? loaded,
    TResult? Function(BookShelfError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookShelfInitial value)? initial,
    TResult Function(BookShelfLoading value)? loading,
    TResult Function(BookShelfLoaded value)? loaded,
    TResult Function(BookShelfError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class BookShelfLoading implements BookShelfState {
  const factory BookShelfLoading() = _$BookShelfLoadingImpl;
}

/// @nodoc
abstract class _$$BookShelfLoadedImplCopyWith<$Res> {
  factory _$$BookShelfLoadedImplCopyWith(_$BookShelfLoadedImpl value,
          $Res Function(_$BookShelfLoadedImpl) then) =
      __$$BookShelfLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<ShelfBookItem> books,
      SortOption sortOption,
      bool hasMore,
      bool isLoadingMore,
      int totalCount});
}

/// @nodoc
class __$$BookShelfLoadedImplCopyWithImpl<$Res>
    extends _$BookShelfStateCopyWithImpl<$Res, _$BookShelfLoadedImpl>
    implements _$$BookShelfLoadedImplCopyWith<$Res> {
  __$$BookShelfLoadedImplCopyWithImpl(
      _$BookShelfLoadedImpl _value, $Res Function(_$BookShelfLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? books = null,
    Object? sortOption = null,
    Object? hasMore = null,
    Object? isLoadingMore = null,
    Object? totalCount = null,
  }) {
    return _then(_$BookShelfLoadedImpl(
      books: null == books
          ? _value._books
          : books // ignore: cast_nullable_to_non_nullable
              as List<ShelfBookItem>,
      sortOption: null == sortOption
          ? _value.sortOption
          : sortOption // ignore: cast_nullable_to_non_nullable
              as SortOption,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$BookShelfLoadedImpl implements BookShelfLoaded {
  const _$BookShelfLoadedImpl(
      {required final List<ShelfBookItem> books,
      required this.sortOption,
      required this.hasMore,
      required this.isLoadingMore,
      required this.totalCount})
      : _books = books;

  /// 書籍リスト
  final List<ShelfBookItem> _books;

  /// 書籍リスト
  @override
  List<ShelfBookItem> get books {
    if (_books is EqualUnmodifiableListView) return _books;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_books);
  }

  /// 現在のソートオプション
  @override
  final SortOption sortOption;

  /// 次のページがあるかどうか
  @override
  final bool hasMore;

  /// 追加読み込み中かどうか
  @override
  final bool isLoadingMore;

  /// 総件数
  @override
  final int totalCount;

  @override
  String toString() {
    return 'BookShelfState.loaded(books: $books, sortOption: $sortOption, hasMore: $hasMore, isLoadingMore: $isLoadingMore, totalCount: $totalCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookShelfLoadedImpl &&
            const DeepCollectionEquality().equals(other._books, _books) &&
            (identical(other.sortOption, sortOption) ||
                other.sortOption == sortOption) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_books),
      sortOption,
      hasMore,
      isLoadingMore,
      totalCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookShelfLoadedImplCopyWith<_$BookShelfLoadedImpl> get copyWith =>
      __$$BookShelfLoadedImplCopyWithImpl<_$BookShelfLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ShelfBookItem> books, SortOption sortOption,
            bool hasMore, bool isLoadingMore, int totalCount)
        loaded,
    required TResult Function(Failure failure) error,
  }) {
    return loaded(books, sortOption, hasMore, isLoadingMore, totalCount);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ShelfBookItem> books, SortOption sortOption,
            bool hasMore, bool isLoadingMore, int totalCount)?
        loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return loaded?.call(books, sortOption, hasMore, isLoadingMore, totalCount);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ShelfBookItem> books, SortOption sortOption,
            bool hasMore, bool isLoadingMore, int totalCount)?
        loaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(books, sortOption, hasMore, isLoadingMore, totalCount);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BookShelfInitial value) initial,
    required TResult Function(BookShelfLoading value) loading,
    required TResult Function(BookShelfLoaded value) loaded,
    required TResult Function(BookShelfError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookShelfInitial value)? initial,
    TResult? Function(BookShelfLoading value)? loading,
    TResult? Function(BookShelfLoaded value)? loaded,
    TResult? Function(BookShelfError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookShelfInitial value)? initial,
    TResult Function(BookShelfLoading value)? loading,
    TResult Function(BookShelfLoaded value)? loaded,
    TResult Function(BookShelfError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class BookShelfLoaded implements BookShelfState {
  const factory BookShelfLoaded(
      {required final List<ShelfBookItem> books,
      required final SortOption sortOption,
      required final bool hasMore,
      required final bool isLoadingMore,
      required final int totalCount}) = _$BookShelfLoadedImpl;

  /// 書籍リスト
  List<ShelfBookItem> get books;

  /// 現在のソートオプション
  SortOption get sortOption;

  /// 次のページがあるかどうか
  bool get hasMore;

  /// 追加読み込み中かどうか
  bool get isLoadingMore;

  /// 総件数
  int get totalCount;
  @JsonKey(ignore: true)
  _$$BookShelfLoadedImplCopyWith<_$BookShelfLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BookShelfErrorImplCopyWith<$Res> {
  factory _$$BookShelfErrorImplCopyWith(_$BookShelfErrorImpl value,
          $Res Function(_$BookShelfErrorImpl) then) =
      __$$BookShelfErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Failure failure});

  $FailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$BookShelfErrorImplCopyWithImpl<$Res>
    extends _$BookShelfStateCopyWithImpl<$Res, _$BookShelfErrorImpl>
    implements _$$BookShelfErrorImplCopyWith<$Res> {
  __$$BookShelfErrorImplCopyWithImpl(
      _$BookShelfErrorImpl _value, $Res Function(_$BookShelfErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$BookShelfErrorImpl(
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

class _$BookShelfErrorImpl implements BookShelfError {
  const _$BookShelfErrorImpl({required this.failure});

  /// エラー情報
  @override
  final Failure failure;

  @override
  String toString() {
    return 'BookShelfState.error(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookShelfErrorImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookShelfErrorImplCopyWith<_$BookShelfErrorImpl> get copyWith =>
      __$$BookShelfErrorImplCopyWithImpl<_$BookShelfErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ShelfBookItem> books, SortOption sortOption,
            bool hasMore, bool isLoadingMore, int totalCount)
        loaded,
    required TResult Function(Failure failure) error,
  }) {
    return error(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ShelfBookItem> books, SortOption sortOption,
            bool hasMore, bool isLoadingMore, int totalCount)?
        loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return error?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ShelfBookItem> books, SortOption sortOption,
            bool hasMore, bool isLoadingMore, int totalCount)?
        loaded,
    TResult Function(Failure failure)? error,
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
    required TResult Function(BookShelfInitial value) initial,
    required TResult Function(BookShelfLoading value) loading,
    required TResult Function(BookShelfLoaded value) loaded,
    required TResult Function(BookShelfError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookShelfInitial value)? initial,
    TResult? Function(BookShelfLoading value)? loading,
    TResult? Function(BookShelfLoaded value)? loaded,
    TResult? Function(BookShelfError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookShelfInitial value)? initial,
    TResult Function(BookShelfLoading value)? loading,
    TResult Function(BookShelfLoaded value)? loaded,
    TResult Function(BookShelfError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class BookShelfError implements BookShelfState {
  const factory BookShelfError({required final Failure failure}) =
      _$BookShelfErrorImpl;

  /// エラー情報
  Failure get failure;
  @JsonKey(ignore: true)
  _$$BookShelfErrorImplCopyWith<_$BookShelfErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
