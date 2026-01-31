// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BookListState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<BookListSummary> lists, int totalCount, bool hasMore)
        loaded,
    required TResult Function(Failure failure) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<BookListSummary> lists, int totalCount, bool hasMore)?
        loaded,
    TResult? Function(Failure failure)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<BookListSummary> lists, int totalCount, bool hasMore)?
        loaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BookListInitial value) initial,
    required TResult Function(BookListLoading value) loading,
    required TResult Function(BookListLoaded value) loaded,
    required TResult Function(BookListError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookListInitial value)? initial,
    TResult? Function(BookListLoading value)? loading,
    TResult? Function(BookListLoaded value)? loaded,
    TResult? Function(BookListError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookListInitial value)? initial,
    TResult Function(BookListLoading value)? loading,
    TResult Function(BookListLoaded value)? loaded,
    TResult Function(BookListError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookListStateCopyWith<$Res> {
  factory $BookListStateCopyWith(
          BookListState value, $Res Function(BookListState) then) =
      _$BookListStateCopyWithImpl<$Res, BookListState>;
}

/// @nodoc
class _$BookListStateCopyWithImpl<$Res, $Val extends BookListState>
    implements $BookListStateCopyWith<$Res> {
  _$BookListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$BookListInitialImplCopyWith<$Res> {
  factory _$$BookListInitialImplCopyWith(_$BookListInitialImpl value,
          $Res Function(_$BookListInitialImpl) then) =
      __$$BookListInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BookListInitialImplCopyWithImpl<$Res>
    extends _$BookListStateCopyWithImpl<$Res, _$BookListInitialImpl>
    implements _$$BookListInitialImplCopyWith<$Res> {
  __$$BookListInitialImplCopyWithImpl(
      _$BookListInitialImpl _value, $Res Function(_$BookListInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BookListInitialImpl implements BookListInitial {
  const _$BookListInitialImpl();

  @override
  String toString() {
    return 'BookListState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BookListInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<BookListSummary> lists, int totalCount, bool hasMore)
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
    TResult? Function(
            List<BookListSummary> lists, int totalCount, bool hasMore)?
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
    TResult Function(List<BookListSummary> lists, int totalCount, bool hasMore)?
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
    required TResult Function(BookListInitial value) initial,
    required TResult Function(BookListLoading value) loading,
    required TResult Function(BookListLoaded value) loaded,
    required TResult Function(BookListError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookListInitial value)? initial,
    TResult? Function(BookListLoading value)? loading,
    TResult? Function(BookListLoaded value)? loaded,
    TResult? Function(BookListError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookListInitial value)? initial,
    TResult Function(BookListLoading value)? loading,
    TResult Function(BookListLoaded value)? loaded,
    TResult Function(BookListError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class BookListInitial implements BookListState {
  const factory BookListInitial() = _$BookListInitialImpl;
}

/// @nodoc
abstract class _$$BookListLoadingImplCopyWith<$Res> {
  factory _$$BookListLoadingImplCopyWith(_$BookListLoadingImpl value,
          $Res Function(_$BookListLoadingImpl) then) =
      __$$BookListLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BookListLoadingImplCopyWithImpl<$Res>
    extends _$BookListStateCopyWithImpl<$Res, _$BookListLoadingImpl>
    implements _$$BookListLoadingImplCopyWith<$Res> {
  __$$BookListLoadingImplCopyWithImpl(
      _$BookListLoadingImpl _value, $Res Function(_$BookListLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BookListLoadingImpl implements BookListLoading {
  const _$BookListLoadingImpl();

  @override
  String toString() {
    return 'BookListState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BookListLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<BookListSummary> lists, int totalCount, bool hasMore)
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
    TResult? Function(
            List<BookListSummary> lists, int totalCount, bool hasMore)?
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
    TResult Function(List<BookListSummary> lists, int totalCount, bool hasMore)?
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
    required TResult Function(BookListInitial value) initial,
    required TResult Function(BookListLoading value) loading,
    required TResult Function(BookListLoaded value) loaded,
    required TResult Function(BookListError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookListInitial value)? initial,
    TResult? Function(BookListLoading value)? loading,
    TResult? Function(BookListLoaded value)? loaded,
    TResult? Function(BookListError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookListInitial value)? initial,
    TResult Function(BookListLoading value)? loading,
    TResult Function(BookListLoaded value)? loaded,
    TResult Function(BookListError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class BookListLoading implements BookListState {
  const factory BookListLoading() = _$BookListLoadingImpl;
}

/// @nodoc
abstract class _$$BookListLoadedImplCopyWith<$Res> {
  factory _$$BookListLoadedImplCopyWith(_$BookListLoadedImpl value,
          $Res Function(_$BookListLoadedImpl) then) =
      __$$BookListLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<BookListSummary> lists, int totalCount, bool hasMore});
}

/// @nodoc
class __$$BookListLoadedImplCopyWithImpl<$Res>
    extends _$BookListStateCopyWithImpl<$Res, _$BookListLoadedImpl>
    implements _$$BookListLoadedImplCopyWith<$Res> {
  __$$BookListLoadedImplCopyWithImpl(
      _$BookListLoadedImpl _value, $Res Function(_$BookListLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lists = null,
    Object? totalCount = null,
    Object? hasMore = null,
  }) {
    return _then(_$BookListLoadedImpl(
      lists: null == lists
          ? _value._lists
          : lists // ignore: cast_nullable_to_non_nullable
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

class _$BookListLoadedImpl implements BookListLoaded {
  const _$BookListLoadedImpl(
      {required final List<BookListSummary> lists,
      required this.totalCount,
      required this.hasMore})
      : _lists = lists;

  final List<BookListSummary> _lists;
  @override
  List<BookListSummary> get lists {
    if (_lists is EqualUnmodifiableListView) return _lists;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lists);
  }

  @override
  final int totalCount;
  @override
  final bool hasMore;

  @override
  String toString() {
    return 'BookListState.loaded(lists: $lists, totalCount: $totalCount, hasMore: $hasMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookListLoadedImpl &&
            const DeepCollectionEquality().equals(other._lists, _lists) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_lists), totalCount, hasMore);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookListLoadedImplCopyWith<_$BookListLoadedImpl> get copyWith =>
      __$$BookListLoadedImplCopyWithImpl<_$BookListLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<BookListSummary> lists, int totalCount, bool hasMore)
        loaded,
    required TResult Function(Failure failure) error,
  }) {
    return loaded(lists, totalCount, hasMore);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<BookListSummary> lists, int totalCount, bool hasMore)?
        loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return loaded?.call(lists, totalCount, hasMore);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<BookListSummary> lists, int totalCount, bool hasMore)?
        loaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(lists, totalCount, hasMore);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BookListInitial value) initial,
    required TResult Function(BookListLoading value) loading,
    required TResult Function(BookListLoaded value) loaded,
    required TResult Function(BookListError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookListInitial value)? initial,
    TResult? Function(BookListLoading value)? loading,
    TResult? Function(BookListLoaded value)? loaded,
    TResult? Function(BookListError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookListInitial value)? initial,
    TResult Function(BookListLoading value)? loading,
    TResult Function(BookListLoaded value)? loaded,
    TResult Function(BookListError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class BookListLoaded implements BookListState {
  const factory BookListLoaded(
      {required final List<BookListSummary> lists,
      required final int totalCount,
      required final bool hasMore}) = _$BookListLoadedImpl;

  List<BookListSummary> get lists;
  int get totalCount;
  bool get hasMore;
  @JsonKey(ignore: true)
  _$$BookListLoadedImplCopyWith<_$BookListLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BookListErrorImplCopyWith<$Res> {
  factory _$$BookListErrorImplCopyWith(
          _$BookListErrorImpl value, $Res Function(_$BookListErrorImpl) then) =
      __$$BookListErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Failure failure});

  $FailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$BookListErrorImplCopyWithImpl<$Res>
    extends _$BookListStateCopyWithImpl<$Res, _$BookListErrorImpl>
    implements _$$BookListErrorImplCopyWith<$Res> {
  __$$BookListErrorImplCopyWithImpl(
      _$BookListErrorImpl _value, $Res Function(_$BookListErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$BookListErrorImpl(
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

class _$BookListErrorImpl implements BookListError {
  const _$BookListErrorImpl({required this.failure});

  @override
  final Failure failure;

  @override
  String toString() {
    return 'BookListState.error(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookListErrorImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookListErrorImplCopyWith<_$BookListErrorImpl> get copyWith =>
      __$$BookListErrorImplCopyWithImpl<_$BookListErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<BookListSummary> lists, int totalCount, bool hasMore)
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
    TResult? Function(
            List<BookListSummary> lists, int totalCount, bool hasMore)?
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
    TResult Function(List<BookListSummary> lists, int totalCount, bool hasMore)?
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
    required TResult Function(BookListInitial value) initial,
    required TResult Function(BookListLoading value) loading,
    required TResult Function(BookListLoaded value) loaded,
    required TResult Function(BookListError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookListInitial value)? initial,
    TResult? Function(BookListLoading value)? loading,
    TResult? Function(BookListLoaded value)? loaded,
    TResult? Function(BookListError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookListInitial value)? initial,
    TResult Function(BookListLoading value)? loading,
    TResult Function(BookListLoaded value)? loaded,
    TResult Function(BookListError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class BookListError implements BookListState {
  const factory BookListError({required final Failure failure}) =
      _$BookListErrorImpl;

  Failure get failure;
  @JsonKey(ignore: true)
  _$$BookListErrorImplCopyWith<_$BookListErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BookListDetailState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(BookListDetail list) loaded,
    required TResult Function(Failure failure) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(BookListDetail list)? loaded,
    TResult? Function(Failure failure)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(BookListDetail list)? loaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BookListDetailInitial value) initial,
    required TResult Function(BookListDetailLoading value) loading,
    required TResult Function(BookListDetailLoaded value) loaded,
    required TResult Function(BookListDetailError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookListDetailInitial value)? initial,
    TResult? Function(BookListDetailLoading value)? loading,
    TResult? Function(BookListDetailLoaded value)? loaded,
    TResult? Function(BookListDetailError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookListDetailInitial value)? initial,
    TResult Function(BookListDetailLoading value)? loading,
    TResult Function(BookListDetailLoaded value)? loaded,
    TResult Function(BookListDetailError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookListDetailStateCopyWith<$Res> {
  factory $BookListDetailStateCopyWith(
          BookListDetailState value, $Res Function(BookListDetailState) then) =
      _$BookListDetailStateCopyWithImpl<$Res, BookListDetailState>;
}

/// @nodoc
class _$BookListDetailStateCopyWithImpl<$Res, $Val extends BookListDetailState>
    implements $BookListDetailStateCopyWith<$Res> {
  _$BookListDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$BookListDetailInitialImplCopyWith<$Res> {
  factory _$$BookListDetailInitialImplCopyWith(
          _$BookListDetailInitialImpl value,
          $Res Function(_$BookListDetailInitialImpl) then) =
      __$$BookListDetailInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BookListDetailInitialImplCopyWithImpl<$Res>
    extends _$BookListDetailStateCopyWithImpl<$Res, _$BookListDetailInitialImpl>
    implements _$$BookListDetailInitialImplCopyWith<$Res> {
  __$$BookListDetailInitialImplCopyWithImpl(_$BookListDetailInitialImpl _value,
      $Res Function(_$BookListDetailInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BookListDetailInitialImpl implements BookListDetailInitial {
  const _$BookListDetailInitialImpl();

  @override
  String toString() {
    return 'BookListDetailState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookListDetailInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(BookListDetail list) loaded,
    required TResult Function(Failure failure) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(BookListDetail list)? loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(BookListDetail list)? loaded,
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
    required TResult Function(BookListDetailInitial value) initial,
    required TResult Function(BookListDetailLoading value) loading,
    required TResult Function(BookListDetailLoaded value) loaded,
    required TResult Function(BookListDetailError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookListDetailInitial value)? initial,
    TResult? Function(BookListDetailLoading value)? loading,
    TResult? Function(BookListDetailLoaded value)? loaded,
    TResult? Function(BookListDetailError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookListDetailInitial value)? initial,
    TResult Function(BookListDetailLoading value)? loading,
    TResult Function(BookListDetailLoaded value)? loaded,
    TResult Function(BookListDetailError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class BookListDetailInitial implements BookListDetailState {
  const factory BookListDetailInitial() = _$BookListDetailInitialImpl;
}

/// @nodoc
abstract class _$$BookListDetailLoadingImplCopyWith<$Res> {
  factory _$$BookListDetailLoadingImplCopyWith(
          _$BookListDetailLoadingImpl value,
          $Res Function(_$BookListDetailLoadingImpl) then) =
      __$$BookListDetailLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BookListDetailLoadingImplCopyWithImpl<$Res>
    extends _$BookListDetailStateCopyWithImpl<$Res, _$BookListDetailLoadingImpl>
    implements _$$BookListDetailLoadingImplCopyWith<$Res> {
  __$$BookListDetailLoadingImplCopyWithImpl(_$BookListDetailLoadingImpl _value,
      $Res Function(_$BookListDetailLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BookListDetailLoadingImpl implements BookListDetailLoading {
  const _$BookListDetailLoadingImpl();

  @override
  String toString() {
    return 'BookListDetailState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookListDetailLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(BookListDetail list) loaded,
    required TResult Function(Failure failure) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(BookListDetail list)? loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(BookListDetail list)? loaded,
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
    required TResult Function(BookListDetailInitial value) initial,
    required TResult Function(BookListDetailLoading value) loading,
    required TResult Function(BookListDetailLoaded value) loaded,
    required TResult Function(BookListDetailError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookListDetailInitial value)? initial,
    TResult? Function(BookListDetailLoading value)? loading,
    TResult? Function(BookListDetailLoaded value)? loaded,
    TResult? Function(BookListDetailError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookListDetailInitial value)? initial,
    TResult Function(BookListDetailLoading value)? loading,
    TResult Function(BookListDetailLoaded value)? loaded,
    TResult Function(BookListDetailError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class BookListDetailLoading implements BookListDetailState {
  const factory BookListDetailLoading() = _$BookListDetailLoadingImpl;
}

/// @nodoc
abstract class _$$BookListDetailLoadedImplCopyWith<$Res> {
  factory _$$BookListDetailLoadedImplCopyWith(_$BookListDetailLoadedImpl value,
          $Res Function(_$BookListDetailLoadedImpl) then) =
      __$$BookListDetailLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BookListDetail list});

  $BookListDetailCopyWith<$Res> get list;
}

/// @nodoc
class __$$BookListDetailLoadedImplCopyWithImpl<$Res>
    extends _$BookListDetailStateCopyWithImpl<$Res, _$BookListDetailLoadedImpl>
    implements _$$BookListDetailLoadedImplCopyWith<$Res> {
  __$$BookListDetailLoadedImplCopyWithImpl(_$BookListDetailLoadedImpl _value,
      $Res Function(_$BookListDetailLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
  }) {
    return _then(_$BookListDetailLoadedImpl(
      list: null == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as BookListDetail,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $BookListDetailCopyWith<$Res> get list {
    return $BookListDetailCopyWith<$Res>(_value.list, (value) {
      return _then(_value.copyWith(list: value));
    });
  }
}

/// @nodoc

class _$BookListDetailLoadedImpl implements BookListDetailLoaded {
  const _$BookListDetailLoadedImpl({required this.list});

  @override
  final BookListDetail list;

  @override
  String toString() {
    return 'BookListDetailState.loaded(list: $list)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookListDetailLoadedImpl &&
            (identical(other.list, list) || other.list == list));
  }

  @override
  int get hashCode => Object.hash(runtimeType, list);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookListDetailLoadedImplCopyWith<_$BookListDetailLoadedImpl>
      get copyWith =>
          __$$BookListDetailLoadedImplCopyWithImpl<_$BookListDetailLoadedImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(BookListDetail list) loaded,
    required TResult Function(Failure failure) error,
  }) {
    return loaded(list);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(BookListDetail list)? loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return loaded?.call(list);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(BookListDetail list)? loaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(list);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BookListDetailInitial value) initial,
    required TResult Function(BookListDetailLoading value) loading,
    required TResult Function(BookListDetailLoaded value) loaded,
    required TResult Function(BookListDetailError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookListDetailInitial value)? initial,
    TResult? Function(BookListDetailLoading value)? loading,
    TResult? Function(BookListDetailLoaded value)? loaded,
    TResult? Function(BookListDetailError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookListDetailInitial value)? initial,
    TResult Function(BookListDetailLoading value)? loading,
    TResult Function(BookListDetailLoaded value)? loaded,
    TResult Function(BookListDetailError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class BookListDetailLoaded implements BookListDetailState {
  const factory BookListDetailLoaded({required final BookListDetail list}) =
      _$BookListDetailLoadedImpl;

  BookListDetail get list;
  @JsonKey(ignore: true)
  _$$BookListDetailLoadedImplCopyWith<_$BookListDetailLoadedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BookListDetailErrorImplCopyWith<$Res> {
  factory _$$BookListDetailErrorImplCopyWith(_$BookListDetailErrorImpl value,
          $Res Function(_$BookListDetailErrorImpl) then) =
      __$$BookListDetailErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Failure failure});

  $FailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$BookListDetailErrorImplCopyWithImpl<$Res>
    extends _$BookListDetailStateCopyWithImpl<$Res, _$BookListDetailErrorImpl>
    implements _$$BookListDetailErrorImplCopyWith<$Res> {
  __$$BookListDetailErrorImplCopyWithImpl(_$BookListDetailErrorImpl _value,
      $Res Function(_$BookListDetailErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$BookListDetailErrorImpl(
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

class _$BookListDetailErrorImpl implements BookListDetailError {
  const _$BookListDetailErrorImpl({required this.failure});

  @override
  final Failure failure;

  @override
  String toString() {
    return 'BookListDetailState.error(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookListDetailErrorImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookListDetailErrorImplCopyWith<_$BookListDetailErrorImpl> get copyWith =>
      __$$BookListDetailErrorImplCopyWithImpl<_$BookListDetailErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(BookListDetail list) loaded,
    required TResult Function(Failure failure) error,
  }) {
    return error(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(BookListDetail list)? loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return error?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(BookListDetail list)? loaded,
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
    required TResult Function(BookListDetailInitial value) initial,
    required TResult Function(BookListDetailLoading value) loading,
    required TResult Function(BookListDetailLoaded value) loaded,
    required TResult Function(BookListDetailError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookListDetailInitial value)? initial,
    TResult? Function(BookListDetailLoading value)? loading,
    TResult? Function(BookListDetailLoaded value)? loaded,
    TResult? Function(BookListDetailError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookListDetailInitial value)? initial,
    TResult Function(BookListDetailLoading value)? loading,
    TResult Function(BookListDetailLoaded value)? loaded,
    TResult Function(BookListDetailError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class BookListDetailError implements BookListDetailState {
  const factory BookListDetailError({required final Failure failure}) =
      _$BookListDetailErrorImpl;

  Failure get failure;
  @JsonKey(ignore: true)
  _$$BookListDetailErrorImplCopyWith<_$BookListDetailErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
