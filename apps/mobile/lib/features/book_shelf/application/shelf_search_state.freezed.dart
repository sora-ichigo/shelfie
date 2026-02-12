// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shelf_search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ShelfSearchState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ShelfBookItem> books, bool hasMore,
            bool isLoadingMore, int totalCount)
        loaded,
    required TResult Function(Failure failure) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ShelfBookItem> books, bool hasMore,
            bool isLoadingMore, int totalCount)?
        loaded,
    TResult? Function(Failure failure)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ShelfBookItem> books, bool hasMore,
            bool isLoadingMore, int totalCount)?
        loaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ShelfSearchInitial value) initial,
    required TResult Function(ShelfSearchLoading value) loading,
    required TResult Function(ShelfSearchLoaded value) loaded,
    required TResult Function(ShelfSearchError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShelfSearchInitial value)? initial,
    TResult? Function(ShelfSearchLoading value)? loading,
    TResult? Function(ShelfSearchLoaded value)? loaded,
    TResult? Function(ShelfSearchError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShelfSearchInitial value)? initial,
    TResult Function(ShelfSearchLoading value)? loading,
    TResult Function(ShelfSearchLoaded value)? loaded,
    TResult Function(ShelfSearchError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShelfSearchStateCopyWith<$Res> {
  factory $ShelfSearchStateCopyWith(
          ShelfSearchState value, $Res Function(ShelfSearchState) then) =
      _$ShelfSearchStateCopyWithImpl<$Res, ShelfSearchState>;
}

/// @nodoc
class _$ShelfSearchStateCopyWithImpl<$Res, $Val extends ShelfSearchState>
    implements $ShelfSearchStateCopyWith<$Res> {
  _$ShelfSearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShelfSearchState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ShelfSearchInitialImplCopyWith<$Res> {
  factory _$$ShelfSearchInitialImplCopyWith(_$ShelfSearchInitialImpl value,
          $Res Function(_$ShelfSearchInitialImpl) then) =
      __$$ShelfSearchInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ShelfSearchInitialImplCopyWithImpl<$Res>
    extends _$ShelfSearchStateCopyWithImpl<$Res, _$ShelfSearchInitialImpl>
    implements _$$ShelfSearchInitialImplCopyWith<$Res> {
  __$$ShelfSearchInitialImplCopyWithImpl(_$ShelfSearchInitialImpl _value,
      $Res Function(_$ShelfSearchInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShelfSearchState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ShelfSearchInitialImpl implements ShelfSearchInitial {
  const _$ShelfSearchInitialImpl();

  @override
  String toString() {
    return 'ShelfSearchState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ShelfSearchInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ShelfBookItem> books, bool hasMore,
            bool isLoadingMore, int totalCount)
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
    TResult? Function(List<ShelfBookItem> books, bool hasMore,
            bool isLoadingMore, int totalCount)?
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
    TResult Function(List<ShelfBookItem> books, bool hasMore,
            bool isLoadingMore, int totalCount)?
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
    required TResult Function(ShelfSearchInitial value) initial,
    required TResult Function(ShelfSearchLoading value) loading,
    required TResult Function(ShelfSearchLoaded value) loaded,
    required TResult Function(ShelfSearchError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShelfSearchInitial value)? initial,
    TResult? Function(ShelfSearchLoading value)? loading,
    TResult? Function(ShelfSearchLoaded value)? loaded,
    TResult? Function(ShelfSearchError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShelfSearchInitial value)? initial,
    TResult Function(ShelfSearchLoading value)? loading,
    TResult Function(ShelfSearchLoaded value)? loaded,
    TResult Function(ShelfSearchError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ShelfSearchInitial implements ShelfSearchState {
  const factory ShelfSearchInitial() = _$ShelfSearchInitialImpl;
}

/// @nodoc
abstract class _$$ShelfSearchLoadingImplCopyWith<$Res> {
  factory _$$ShelfSearchLoadingImplCopyWith(_$ShelfSearchLoadingImpl value,
          $Res Function(_$ShelfSearchLoadingImpl) then) =
      __$$ShelfSearchLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ShelfSearchLoadingImplCopyWithImpl<$Res>
    extends _$ShelfSearchStateCopyWithImpl<$Res, _$ShelfSearchLoadingImpl>
    implements _$$ShelfSearchLoadingImplCopyWith<$Res> {
  __$$ShelfSearchLoadingImplCopyWithImpl(_$ShelfSearchLoadingImpl _value,
      $Res Function(_$ShelfSearchLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShelfSearchState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ShelfSearchLoadingImpl implements ShelfSearchLoading {
  const _$ShelfSearchLoadingImpl();

  @override
  String toString() {
    return 'ShelfSearchState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ShelfSearchLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ShelfBookItem> books, bool hasMore,
            bool isLoadingMore, int totalCount)
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
    TResult? Function(List<ShelfBookItem> books, bool hasMore,
            bool isLoadingMore, int totalCount)?
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
    TResult Function(List<ShelfBookItem> books, bool hasMore,
            bool isLoadingMore, int totalCount)?
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
    required TResult Function(ShelfSearchInitial value) initial,
    required TResult Function(ShelfSearchLoading value) loading,
    required TResult Function(ShelfSearchLoaded value) loaded,
    required TResult Function(ShelfSearchError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShelfSearchInitial value)? initial,
    TResult? Function(ShelfSearchLoading value)? loading,
    TResult? Function(ShelfSearchLoaded value)? loaded,
    TResult? Function(ShelfSearchError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShelfSearchInitial value)? initial,
    TResult Function(ShelfSearchLoading value)? loading,
    TResult Function(ShelfSearchLoaded value)? loaded,
    TResult Function(ShelfSearchError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ShelfSearchLoading implements ShelfSearchState {
  const factory ShelfSearchLoading() = _$ShelfSearchLoadingImpl;
}

/// @nodoc
abstract class _$$ShelfSearchLoadedImplCopyWith<$Res> {
  factory _$$ShelfSearchLoadedImplCopyWith(_$ShelfSearchLoadedImpl value,
          $Res Function(_$ShelfSearchLoadedImpl) then) =
      __$$ShelfSearchLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<ShelfBookItem> books,
      bool hasMore,
      bool isLoadingMore,
      int totalCount});
}

/// @nodoc
class __$$ShelfSearchLoadedImplCopyWithImpl<$Res>
    extends _$ShelfSearchStateCopyWithImpl<$Res, _$ShelfSearchLoadedImpl>
    implements _$$ShelfSearchLoadedImplCopyWith<$Res> {
  __$$ShelfSearchLoadedImplCopyWithImpl(_$ShelfSearchLoadedImpl _value,
      $Res Function(_$ShelfSearchLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShelfSearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? books = null,
    Object? hasMore = null,
    Object? isLoadingMore = null,
    Object? totalCount = null,
  }) {
    return _then(_$ShelfSearchLoadedImpl(
      books: null == books
          ? _value._books
          : books // ignore: cast_nullable_to_non_nullable
              as List<ShelfBookItem>,
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

class _$ShelfSearchLoadedImpl implements ShelfSearchLoaded {
  const _$ShelfSearchLoadedImpl(
      {required final List<ShelfBookItem> books,
      required this.hasMore,
      required this.isLoadingMore,
      required this.totalCount})
      : _books = books;

  final List<ShelfBookItem> _books;
  @override
  List<ShelfBookItem> get books {
    if (_books is EqualUnmodifiableListView) return _books;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_books);
  }

  @override
  final bool hasMore;
  @override
  final bool isLoadingMore;
  @override
  final int totalCount;

  @override
  String toString() {
    return 'ShelfSearchState.loaded(books: $books, hasMore: $hasMore, isLoadingMore: $isLoadingMore, totalCount: $totalCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShelfSearchLoadedImpl &&
            const DeepCollectionEquality().equals(other._books, _books) &&
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
      hasMore,
      isLoadingMore,
      totalCount);

  /// Create a copy of ShelfSearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShelfSearchLoadedImplCopyWith<_$ShelfSearchLoadedImpl> get copyWith =>
      __$$ShelfSearchLoadedImplCopyWithImpl<_$ShelfSearchLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ShelfBookItem> books, bool hasMore,
            bool isLoadingMore, int totalCount)
        loaded,
    required TResult Function(Failure failure) error,
  }) {
    return loaded(books, hasMore, isLoadingMore, totalCount);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ShelfBookItem> books, bool hasMore,
            bool isLoadingMore, int totalCount)?
        loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return loaded?.call(books, hasMore, isLoadingMore, totalCount);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ShelfBookItem> books, bool hasMore,
            bool isLoadingMore, int totalCount)?
        loaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(books, hasMore, isLoadingMore, totalCount);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ShelfSearchInitial value) initial,
    required TResult Function(ShelfSearchLoading value) loading,
    required TResult Function(ShelfSearchLoaded value) loaded,
    required TResult Function(ShelfSearchError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShelfSearchInitial value)? initial,
    TResult? Function(ShelfSearchLoading value)? loading,
    TResult? Function(ShelfSearchLoaded value)? loaded,
    TResult? Function(ShelfSearchError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShelfSearchInitial value)? initial,
    TResult Function(ShelfSearchLoading value)? loading,
    TResult Function(ShelfSearchLoaded value)? loaded,
    TResult Function(ShelfSearchError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ShelfSearchLoaded implements ShelfSearchState {
  const factory ShelfSearchLoaded(
      {required final List<ShelfBookItem> books,
      required final bool hasMore,
      required final bool isLoadingMore,
      required final int totalCount}) = _$ShelfSearchLoadedImpl;

  List<ShelfBookItem> get books;
  bool get hasMore;
  bool get isLoadingMore;
  int get totalCount;

  /// Create a copy of ShelfSearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShelfSearchLoadedImplCopyWith<_$ShelfSearchLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ShelfSearchErrorImplCopyWith<$Res> {
  factory _$$ShelfSearchErrorImplCopyWith(_$ShelfSearchErrorImpl value,
          $Res Function(_$ShelfSearchErrorImpl) then) =
      __$$ShelfSearchErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Failure failure});

  $FailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$ShelfSearchErrorImplCopyWithImpl<$Res>
    extends _$ShelfSearchStateCopyWithImpl<$Res, _$ShelfSearchErrorImpl>
    implements _$$ShelfSearchErrorImplCopyWith<$Res> {
  __$$ShelfSearchErrorImplCopyWithImpl(_$ShelfSearchErrorImpl _value,
      $Res Function(_$ShelfSearchErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShelfSearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$ShelfSearchErrorImpl(
      failure: null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure,
    ));
  }

  /// Create a copy of ShelfSearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FailureCopyWith<$Res> get failure {
    return $FailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc

class _$ShelfSearchErrorImpl implements ShelfSearchError {
  const _$ShelfSearchErrorImpl({required this.failure});

  @override
  final Failure failure;

  @override
  String toString() {
    return 'ShelfSearchState.error(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShelfSearchErrorImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  /// Create a copy of ShelfSearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShelfSearchErrorImplCopyWith<_$ShelfSearchErrorImpl> get copyWith =>
      __$$ShelfSearchErrorImplCopyWithImpl<_$ShelfSearchErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ShelfBookItem> books, bool hasMore,
            bool isLoadingMore, int totalCount)
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
    TResult? Function(List<ShelfBookItem> books, bool hasMore,
            bool isLoadingMore, int totalCount)?
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
    TResult Function(List<ShelfBookItem> books, bool hasMore,
            bool isLoadingMore, int totalCount)?
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
    required TResult Function(ShelfSearchInitial value) initial,
    required TResult Function(ShelfSearchLoading value) loading,
    required TResult Function(ShelfSearchLoaded value) loaded,
    required TResult Function(ShelfSearchError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShelfSearchInitial value)? initial,
    TResult? Function(ShelfSearchLoading value)? loading,
    TResult? Function(ShelfSearchLoaded value)? loaded,
    TResult? Function(ShelfSearchError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShelfSearchInitial value)? initial,
    TResult Function(ShelfSearchLoading value)? loading,
    TResult Function(ShelfSearchLoaded value)? loaded,
    TResult Function(ShelfSearchError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ShelfSearchError implements ShelfSearchState {
  const factory ShelfSearchError({required final Failure failure}) =
      _$ShelfSearchErrorImpl;

  Failure get failure;

  /// Create a copy of ShelfSearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShelfSearchErrorImplCopyWith<_$ShelfSearchErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
