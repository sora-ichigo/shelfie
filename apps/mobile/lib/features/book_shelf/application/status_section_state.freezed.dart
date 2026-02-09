// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'status_section_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$StatusSectionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<ShelfBookItem> books,
      int totalCount,
      bool hasMore,
      bool isLoadingMore,
    )
    loaded,
    required TResult Function(Failure failure) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<ShelfBookItem> books,
      int totalCount,
      bool hasMore,
      bool isLoadingMore,
    )?
    loaded,
    TResult? Function(Failure failure)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<ShelfBookItem> books,
      int totalCount,
      bool hasMore,
      bool isLoadingMore,
    )?
    loaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StatusSectionInitial value) initial,
    required TResult Function(StatusSectionLoading value) loading,
    required TResult Function(StatusSectionLoaded value) loaded,
    required TResult Function(StatusSectionError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StatusSectionInitial value)? initial,
    TResult? Function(StatusSectionLoading value)? loading,
    TResult? Function(StatusSectionLoaded value)? loaded,
    TResult? Function(StatusSectionError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StatusSectionInitial value)? initial,
    TResult Function(StatusSectionLoading value)? loading,
    TResult Function(StatusSectionLoaded value)? loaded,
    TResult Function(StatusSectionError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatusSectionStateCopyWith<$Res> {
  factory $StatusSectionStateCopyWith(
    StatusSectionState value,
    $Res Function(StatusSectionState) then,
  ) = _$StatusSectionStateCopyWithImpl<$Res, StatusSectionState>;
}

/// @nodoc
class _$StatusSectionStateCopyWithImpl<$Res, $Val extends StatusSectionState>
    implements $StatusSectionStateCopyWith<$Res> {
  _$StatusSectionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StatusSectionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StatusSectionInitialImplCopyWith<$Res> {
  factory _$$StatusSectionInitialImplCopyWith(
    _$StatusSectionInitialImpl value,
    $Res Function(_$StatusSectionInitialImpl) then,
  ) = __$$StatusSectionInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StatusSectionInitialImplCopyWithImpl<$Res>
    extends _$StatusSectionStateCopyWithImpl<$Res, _$StatusSectionInitialImpl>
    implements _$$StatusSectionInitialImplCopyWith<$Res> {
  __$$StatusSectionInitialImplCopyWithImpl(
    _$StatusSectionInitialImpl _value,
    $Res Function(_$StatusSectionInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StatusSectionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StatusSectionInitialImpl implements StatusSectionInitial {
  const _$StatusSectionInitialImpl();

  @override
  String toString() {
    return 'StatusSectionState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusSectionInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<ShelfBookItem> books,
      int totalCount,
      bool hasMore,
      bool isLoadingMore,
    )
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
      List<ShelfBookItem> books,
      int totalCount,
      bool hasMore,
      bool isLoadingMore,
    )?
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
    TResult Function(
      List<ShelfBookItem> books,
      int totalCount,
      bool hasMore,
      bool isLoadingMore,
    )?
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
    required TResult Function(StatusSectionInitial value) initial,
    required TResult Function(StatusSectionLoading value) loading,
    required TResult Function(StatusSectionLoaded value) loaded,
    required TResult Function(StatusSectionError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StatusSectionInitial value)? initial,
    TResult? Function(StatusSectionLoading value)? loading,
    TResult? Function(StatusSectionLoaded value)? loaded,
    TResult? Function(StatusSectionError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StatusSectionInitial value)? initial,
    TResult Function(StatusSectionLoading value)? loading,
    TResult Function(StatusSectionLoaded value)? loaded,
    TResult Function(StatusSectionError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class StatusSectionInitial implements StatusSectionState {
  const factory StatusSectionInitial() = _$StatusSectionInitialImpl;
}

/// @nodoc
abstract class _$$StatusSectionLoadingImplCopyWith<$Res> {
  factory _$$StatusSectionLoadingImplCopyWith(
    _$StatusSectionLoadingImpl value,
    $Res Function(_$StatusSectionLoadingImpl) then,
  ) = __$$StatusSectionLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StatusSectionLoadingImplCopyWithImpl<$Res>
    extends _$StatusSectionStateCopyWithImpl<$Res, _$StatusSectionLoadingImpl>
    implements _$$StatusSectionLoadingImplCopyWith<$Res> {
  __$$StatusSectionLoadingImplCopyWithImpl(
    _$StatusSectionLoadingImpl _value,
    $Res Function(_$StatusSectionLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StatusSectionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StatusSectionLoadingImpl implements StatusSectionLoading {
  const _$StatusSectionLoadingImpl();

  @override
  String toString() {
    return 'StatusSectionState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusSectionLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<ShelfBookItem> books,
      int totalCount,
      bool hasMore,
      bool isLoadingMore,
    )
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
      List<ShelfBookItem> books,
      int totalCount,
      bool hasMore,
      bool isLoadingMore,
    )?
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
    TResult Function(
      List<ShelfBookItem> books,
      int totalCount,
      bool hasMore,
      bool isLoadingMore,
    )?
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
    required TResult Function(StatusSectionInitial value) initial,
    required TResult Function(StatusSectionLoading value) loading,
    required TResult Function(StatusSectionLoaded value) loaded,
    required TResult Function(StatusSectionError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StatusSectionInitial value)? initial,
    TResult? Function(StatusSectionLoading value)? loading,
    TResult? Function(StatusSectionLoaded value)? loaded,
    TResult? Function(StatusSectionError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StatusSectionInitial value)? initial,
    TResult Function(StatusSectionLoading value)? loading,
    TResult Function(StatusSectionLoaded value)? loaded,
    TResult Function(StatusSectionError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class StatusSectionLoading implements StatusSectionState {
  const factory StatusSectionLoading() = _$StatusSectionLoadingImpl;
}

/// @nodoc
abstract class _$$StatusSectionLoadedImplCopyWith<$Res> {
  factory _$$StatusSectionLoadedImplCopyWith(
    _$StatusSectionLoadedImpl value,
    $Res Function(_$StatusSectionLoadedImpl) then,
  ) = __$$StatusSectionLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<ShelfBookItem> books,
    int totalCount,
    bool hasMore,
    bool isLoadingMore,
  });
}

/// @nodoc
class __$$StatusSectionLoadedImplCopyWithImpl<$Res>
    extends _$StatusSectionStateCopyWithImpl<$Res, _$StatusSectionLoadedImpl>
    implements _$$StatusSectionLoadedImplCopyWith<$Res> {
  __$$StatusSectionLoadedImplCopyWithImpl(
    _$StatusSectionLoadedImpl _value,
    $Res Function(_$StatusSectionLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StatusSectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? books = null,
    Object? totalCount = null,
    Object? hasMore = null,
    Object? isLoadingMore = null,
  }) {
    return _then(
      _$StatusSectionLoadedImpl(
        books: null == books
            ? _value._books
            : books // ignore: cast_nullable_to_non_nullable
                  as List<ShelfBookItem>,
        totalCount: null == totalCount
            ? _value.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingMore: null == isLoadingMore
            ? _value.isLoadingMore
            : isLoadingMore // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$StatusSectionLoadedImpl implements StatusSectionLoaded {
  const _$StatusSectionLoadedImpl({
    required final List<ShelfBookItem> books,
    required this.totalCount,
    required this.hasMore,
    required this.isLoadingMore,
  }) : _books = books;

  final List<ShelfBookItem> _books;
  @override
  List<ShelfBookItem> get books {
    if (_books is EqualUnmodifiableListView) return _books;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_books);
  }

  @override
  final int totalCount;
  @override
  final bool hasMore;
  @override
  final bool isLoadingMore;

  @override
  String toString() {
    return 'StatusSectionState.loaded(books: $books, totalCount: $totalCount, hasMore: $hasMore, isLoadingMore: $isLoadingMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusSectionLoadedImpl &&
            const DeepCollectionEquality().equals(other._books, _books) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_books),
    totalCount,
    hasMore,
    isLoadingMore,
  );

  /// Create a copy of StatusSectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusSectionLoadedImplCopyWith<_$StatusSectionLoadedImpl> get copyWith =>
      __$$StatusSectionLoadedImplCopyWithImpl<_$StatusSectionLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<ShelfBookItem> books,
      int totalCount,
      bool hasMore,
      bool isLoadingMore,
    )
    loaded,
    required TResult Function(Failure failure) error,
  }) {
    return loaded(books, totalCount, hasMore, isLoadingMore);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<ShelfBookItem> books,
      int totalCount,
      bool hasMore,
      bool isLoadingMore,
    )?
    loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return loaded?.call(books, totalCount, hasMore, isLoadingMore);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<ShelfBookItem> books,
      int totalCount,
      bool hasMore,
      bool isLoadingMore,
    )?
    loaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(books, totalCount, hasMore, isLoadingMore);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StatusSectionInitial value) initial,
    required TResult Function(StatusSectionLoading value) loading,
    required TResult Function(StatusSectionLoaded value) loaded,
    required TResult Function(StatusSectionError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StatusSectionInitial value)? initial,
    TResult? Function(StatusSectionLoading value)? loading,
    TResult? Function(StatusSectionLoaded value)? loaded,
    TResult? Function(StatusSectionError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StatusSectionInitial value)? initial,
    TResult Function(StatusSectionLoading value)? loading,
    TResult Function(StatusSectionLoaded value)? loaded,
    TResult Function(StatusSectionError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class StatusSectionLoaded implements StatusSectionState {
  const factory StatusSectionLoaded({
    required final List<ShelfBookItem> books,
    required final int totalCount,
    required final bool hasMore,
    required final bool isLoadingMore,
  }) = _$StatusSectionLoadedImpl;

  List<ShelfBookItem> get books;
  int get totalCount;
  bool get hasMore;
  bool get isLoadingMore;

  /// Create a copy of StatusSectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusSectionLoadedImplCopyWith<_$StatusSectionLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StatusSectionErrorImplCopyWith<$Res> {
  factory _$$StatusSectionErrorImplCopyWith(
    _$StatusSectionErrorImpl value,
    $Res Function(_$StatusSectionErrorImpl) then,
  ) = __$$StatusSectionErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Failure failure});

  $FailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$StatusSectionErrorImplCopyWithImpl<$Res>
    extends _$StatusSectionStateCopyWithImpl<$Res, _$StatusSectionErrorImpl>
    implements _$$StatusSectionErrorImplCopyWith<$Res> {
  __$$StatusSectionErrorImplCopyWithImpl(
    _$StatusSectionErrorImpl _value,
    $Res Function(_$StatusSectionErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StatusSectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? failure = null}) {
    return _then(
      _$StatusSectionErrorImpl(
        failure: null == failure
            ? _value.failure
            : failure // ignore: cast_nullable_to_non_nullable
                  as Failure,
      ),
    );
  }

  /// Create a copy of StatusSectionState
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

class _$StatusSectionErrorImpl implements StatusSectionError {
  const _$StatusSectionErrorImpl({required this.failure});

  @override
  final Failure failure;

  @override
  String toString() {
    return 'StatusSectionState.error(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusSectionErrorImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  /// Create a copy of StatusSectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusSectionErrorImplCopyWith<_$StatusSectionErrorImpl> get copyWith =>
      __$$StatusSectionErrorImplCopyWithImpl<_$StatusSectionErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<ShelfBookItem> books,
      int totalCount,
      bool hasMore,
      bool isLoadingMore,
    )
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
      List<ShelfBookItem> books,
      int totalCount,
      bool hasMore,
      bool isLoadingMore,
    )?
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
    TResult Function(
      List<ShelfBookItem> books,
      int totalCount,
      bool hasMore,
      bool isLoadingMore,
    )?
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
    required TResult Function(StatusSectionInitial value) initial,
    required TResult Function(StatusSectionLoading value) loading,
    required TResult Function(StatusSectionLoaded value) loaded,
    required TResult Function(StatusSectionError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StatusSectionInitial value)? initial,
    TResult? Function(StatusSectionLoading value)? loading,
    TResult? Function(StatusSectionLoaded value)? loaded,
    TResult? Function(StatusSectionError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StatusSectionInitial value)? initial,
    TResult Function(StatusSectionLoading value)? loading,
    TResult Function(StatusSectionLoaded value)? loaded,
    TResult Function(StatusSectionError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class StatusSectionError implements StatusSectionState {
  const factory StatusSectionError({required final Failure failure}) =
      _$StatusSectionErrorImpl;

  Failure get failure;

  /// Create a copy of StatusSectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusSectionErrorImplCopyWith<_$StatusSectionErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
