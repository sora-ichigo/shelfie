// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'registration_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RegistrationState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(RegisteredUser user) success,
    required TResult Function(String message, String? field) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(RegisteredUser user)? success,
    TResult? Function(String message, String? field)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(RegisteredUser user)? success,
    TResult Function(String message, String? field)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegistrationStateInitial value) initial,
    required TResult Function(RegistrationStateLoading value) loading,
    required TResult Function(RegistrationStateSuccess value) success,
    required TResult Function(RegistrationStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegistrationStateInitial value)? initial,
    TResult? Function(RegistrationStateLoading value)? loading,
    TResult? Function(RegistrationStateSuccess value)? success,
    TResult? Function(RegistrationStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegistrationStateInitial value)? initial,
    TResult Function(RegistrationStateLoading value)? loading,
    TResult Function(RegistrationStateSuccess value)? success,
    TResult Function(RegistrationStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegistrationStateCopyWith<$Res> {
  factory $RegistrationStateCopyWith(
          RegistrationState value, $Res Function(RegistrationState) then) =
      _$RegistrationStateCopyWithImpl<$Res, RegistrationState>;
}

/// @nodoc
class _$RegistrationStateCopyWithImpl<$Res, $Val extends RegistrationState>
    implements $RegistrationStateCopyWith<$Res> {
  _$RegistrationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$RegistrationStateInitialImplCopyWith<$Res> {
  factory _$$RegistrationStateInitialImplCopyWith(
          _$RegistrationStateInitialImpl value,
          $Res Function(_$RegistrationStateInitialImpl) then) =
      __$$RegistrationStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RegistrationStateInitialImplCopyWithImpl<$Res>
    extends _$RegistrationStateCopyWithImpl<$Res,
        _$RegistrationStateInitialImpl>
    implements _$$RegistrationStateInitialImplCopyWith<$Res> {
  __$$RegistrationStateInitialImplCopyWithImpl(
      _$RegistrationStateInitialImpl _value,
      $Res Function(_$RegistrationStateInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$RegistrationStateInitialImpl implements RegistrationStateInitial {
  const _$RegistrationStateInitialImpl();

  @override
  String toString() {
    return 'RegistrationState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegistrationStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(RegisteredUser user) success,
    required TResult Function(String message, String? field) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(RegisteredUser user)? success,
    TResult? Function(String message, String? field)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(RegisteredUser user)? success,
    TResult Function(String message, String? field)? error,
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
    required TResult Function(RegistrationStateInitial value) initial,
    required TResult Function(RegistrationStateLoading value) loading,
    required TResult Function(RegistrationStateSuccess value) success,
    required TResult Function(RegistrationStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegistrationStateInitial value)? initial,
    TResult? Function(RegistrationStateLoading value)? loading,
    TResult? Function(RegistrationStateSuccess value)? success,
    TResult? Function(RegistrationStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegistrationStateInitial value)? initial,
    TResult Function(RegistrationStateLoading value)? loading,
    TResult Function(RegistrationStateSuccess value)? success,
    TResult Function(RegistrationStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class RegistrationStateInitial implements RegistrationState {
  const factory RegistrationStateInitial() = _$RegistrationStateInitialImpl;
}

/// @nodoc
abstract class _$$RegistrationStateLoadingImplCopyWith<$Res> {
  factory _$$RegistrationStateLoadingImplCopyWith(
          _$RegistrationStateLoadingImpl value,
          $Res Function(_$RegistrationStateLoadingImpl) then) =
      __$$RegistrationStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RegistrationStateLoadingImplCopyWithImpl<$Res>
    extends _$RegistrationStateCopyWithImpl<$Res,
        _$RegistrationStateLoadingImpl>
    implements _$$RegistrationStateLoadingImplCopyWith<$Res> {
  __$$RegistrationStateLoadingImplCopyWithImpl(
      _$RegistrationStateLoadingImpl _value,
      $Res Function(_$RegistrationStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$RegistrationStateLoadingImpl implements RegistrationStateLoading {
  const _$RegistrationStateLoadingImpl();

  @override
  String toString() {
    return 'RegistrationState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegistrationStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(RegisteredUser user) success,
    required TResult Function(String message, String? field) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(RegisteredUser user)? success,
    TResult? Function(String message, String? field)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(RegisteredUser user)? success,
    TResult Function(String message, String? field)? error,
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
    required TResult Function(RegistrationStateInitial value) initial,
    required TResult Function(RegistrationStateLoading value) loading,
    required TResult Function(RegistrationStateSuccess value) success,
    required TResult Function(RegistrationStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegistrationStateInitial value)? initial,
    TResult? Function(RegistrationStateLoading value)? loading,
    TResult? Function(RegistrationStateSuccess value)? success,
    TResult? Function(RegistrationStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegistrationStateInitial value)? initial,
    TResult Function(RegistrationStateLoading value)? loading,
    TResult Function(RegistrationStateSuccess value)? success,
    TResult Function(RegistrationStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class RegistrationStateLoading implements RegistrationState {
  const factory RegistrationStateLoading() = _$RegistrationStateLoadingImpl;
}

/// @nodoc
abstract class _$$RegistrationStateSuccessImplCopyWith<$Res> {
  factory _$$RegistrationStateSuccessImplCopyWith(
          _$RegistrationStateSuccessImpl value,
          $Res Function(_$RegistrationStateSuccessImpl) then) =
      __$$RegistrationStateSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({RegisteredUser user});
}

/// @nodoc
class __$$RegistrationStateSuccessImplCopyWithImpl<$Res>
    extends _$RegistrationStateCopyWithImpl<$Res,
        _$RegistrationStateSuccessImpl>
    implements _$$RegistrationStateSuccessImplCopyWith<$Res> {
  __$$RegistrationStateSuccessImplCopyWithImpl(
      _$RegistrationStateSuccessImpl _value,
      $Res Function(_$RegistrationStateSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$RegistrationStateSuccessImpl(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as RegisteredUser,
    ));
  }
}

/// @nodoc

class _$RegistrationStateSuccessImpl implements RegistrationStateSuccess {
  const _$RegistrationStateSuccessImpl({required this.user});

  @override
  final RegisteredUser user;

  @override
  String toString() {
    return 'RegistrationState.success(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegistrationStateSuccessImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegistrationStateSuccessImplCopyWith<_$RegistrationStateSuccessImpl>
      get copyWith => __$$RegistrationStateSuccessImplCopyWithImpl<
          _$RegistrationStateSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(RegisteredUser user) success,
    required TResult Function(String message, String? field) error,
  }) {
    return success(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(RegisteredUser user)? success,
    TResult? Function(String message, String? field)? error,
  }) {
    return success?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(RegisteredUser user)? success,
    TResult Function(String message, String? field)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegistrationStateInitial value) initial,
    required TResult Function(RegistrationStateLoading value) loading,
    required TResult Function(RegistrationStateSuccess value) success,
    required TResult Function(RegistrationStateError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegistrationStateInitial value)? initial,
    TResult? Function(RegistrationStateLoading value)? loading,
    TResult? Function(RegistrationStateSuccess value)? success,
    TResult? Function(RegistrationStateError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegistrationStateInitial value)? initial,
    TResult Function(RegistrationStateLoading value)? loading,
    TResult Function(RegistrationStateSuccess value)? success,
    TResult Function(RegistrationStateError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class RegistrationStateSuccess implements RegistrationState {
  const factory RegistrationStateSuccess({required final RegisteredUser user}) =
      _$RegistrationStateSuccessImpl;

  RegisteredUser get user;
  @JsonKey(ignore: true)
  _$$RegistrationStateSuccessImplCopyWith<_$RegistrationStateSuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RegistrationStateErrorImplCopyWith<$Res> {
  factory _$$RegistrationStateErrorImplCopyWith(
          _$RegistrationStateErrorImpl value,
          $Res Function(_$RegistrationStateErrorImpl) then) =
      __$$RegistrationStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, String? field});
}

/// @nodoc
class __$$RegistrationStateErrorImplCopyWithImpl<$Res>
    extends _$RegistrationStateCopyWithImpl<$Res, _$RegistrationStateErrorImpl>
    implements _$$RegistrationStateErrorImplCopyWith<$Res> {
  __$$RegistrationStateErrorImplCopyWithImpl(
      _$RegistrationStateErrorImpl _value,
      $Res Function(_$RegistrationStateErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? field = freezed,
  }) {
    return _then(_$RegistrationStateErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      field: freezed == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$RegistrationStateErrorImpl implements RegistrationStateError {
  const _$RegistrationStateErrorImpl({required this.message, this.field});

  @override
  final String message;
  @override
  final String? field;

  @override
  String toString() {
    return 'RegistrationState.error(message: $message, field: $field)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegistrationStateErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.field, field) || other.field == field));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, field);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegistrationStateErrorImplCopyWith<_$RegistrationStateErrorImpl>
      get copyWith => __$$RegistrationStateErrorImplCopyWithImpl<
          _$RegistrationStateErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(RegisteredUser user) success,
    required TResult Function(String message, String? field) error,
  }) {
    return error(message, field);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(RegisteredUser user)? success,
    TResult? Function(String message, String? field)? error,
  }) {
    return error?.call(message, field);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(RegisteredUser user)? success,
    TResult Function(String message, String? field)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, field);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegistrationStateInitial value) initial,
    required TResult Function(RegistrationStateLoading value) loading,
    required TResult Function(RegistrationStateSuccess value) success,
    required TResult Function(RegistrationStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegistrationStateInitial value)? initial,
    TResult? Function(RegistrationStateLoading value)? loading,
    TResult? Function(RegistrationStateSuccess value)? success,
    TResult? Function(RegistrationStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegistrationStateInitial value)? initial,
    TResult Function(RegistrationStateLoading value)? loading,
    TResult Function(RegistrationStateSuccess value)? success,
    TResult Function(RegistrationStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class RegistrationStateError implements RegistrationState {
  const factory RegistrationStateError(
      {required final String message,
      final String? field}) = _$RegistrationStateErrorImpl;

  String get message;
  String? get field;
  @JsonKey(ignore: true)
  _$$RegistrationStateErrorImplCopyWith<_$RegistrationStateErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}
