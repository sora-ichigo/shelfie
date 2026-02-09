// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Failure {
  String get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(String message, String code, int? statusCode)
    server,
    required TResult Function(String message) auth,
    required TResult Function(String message, Map<String, String>? fieldErrors)
    validation,
    required TResult Function(String message, StackTrace? stackTrace)
    unexpected,
    required TResult Function(String message) notFound,
    required TResult Function(String message) forbidden,
    required TResult Function(String message) duplicateBook,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(String message, String code, int? statusCode)? server,
    TResult? Function(String message)? auth,
    TResult? Function(String message, Map<String, String>? fieldErrors)?
    validation,
    TResult? Function(String message, StackTrace? stackTrace)? unexpected,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message)? duplicateBook,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(String message, String code, int? statusCode)? server,
    TResult Function(String message)? auth,
    TResult Function(String message, Map<String, String>? fieldErrors)?
    validation,
    TResult Function(String message, StackTrace? stackTrace)? unexpected,
    TResult Function(String message)? notFound,
    TResult Function(String message)? forbidden,
    TResult Function(String message)? duplicateBook,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(ServerFailure value) server,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(UnexpectedFailure value) unexpected,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(DuplicateBookFailure value) duplicateBook,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(UnexpectedFailure value)? unexpected,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(DuplicateBookFailure value)? duplicateBook,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(ServerFailure value)? server,
    TResult Function(AuthFailure value)? auth,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(UnexpectedFailure value)? unexpected,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(DuplicateBookFailure value)? duplicateBook,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FailureCopyWith<Failure> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailureCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) then) =
      _$FailureCopyWithImpl<$Res, Failure>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$FailureCopyWithImpl<$Res, $Val extends Failure>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NetworkFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$NetworkFailureImplCopyWith(
    _$NetworkFailureImpl value,
    $Res Function(_$NetworkFailureImpl) then,
  ) = __$$NetworkFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$NetworkFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$NetworkFailureImpl>
    implements _$$NetworkFailureImplCopyWith<$Res> {
  __$$NetworkFailureImplCopyWithImpl(
    _$NetworkFailureImpl _value,
    $Res Function(_$NetworkFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$NetworkFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$NetworkFailureImpl extends NetworkFailure {
  const _$NetworkFailureImpl({required this.message}) : super._();

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.network(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkFailureImplCopyWith<_$NetworkFailureImpl> get copyWith =>
      __$$NetworkFailureImplCopyWithImpl<_$NetworkFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(String message, String code, int? statusCode)
    server,
    required TResult Function(String message) auth,
    required TResult Function(String message, Map<String, String>? fieldErrors)
    validation,
    required TResult Function(String message, StackTrace? stackTrace)
    unexpected,
    required TResult Function(String message) notFound,
    required TResult Function(String message) forbidden,
    required TResult Function(String message) duplicateBook,
  }) {
    return network(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(String message, String code, int? statusCode)? server,
    TResult? Function(String message)? auth,
    TResult? Function(String message, Map<String, String>? fieldErrors)?
    validation,
    TResult? Function(String message, StackTrace? stackTrace)? unexpected,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message)? duplicateBook,
  }) {
    return network?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(String message, String code, int? statusCode)? server,
    TResult Function(String message)? auth,
    TResult Function(String message, Map<String, String>? fieldErrors)?
    validation,
    TResult Function(String message, StackTrace? stackTrace)? unexpected,
    TResult Function(String message)? notFound,
    TResult Function(String message)? forbidden,
    TResult Function(String message)? duplicateBook,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(ServerFailure value) server,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(UnexpectedFailure value) unexpected,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(DuplicateBookFailure value) duplicateBook,
  }) {
    return network(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(UnexpectedFailure value)? unexpected,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(DuplicateBookFailure value)? duplicateBook,
  }) {
    return network?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(ServerFailure value)? server,
    TResult Function(AuthFailure value)? auth,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(UnexpectedFailure value)? unexpected,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(DuplicateBookFailure value)? duplicateBook,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(this);
    }
    return orElse();
  }
}

abstract class NetworkFailure extends Failure {
  const factory NetworkFailure({required final String message}) =
      _$NetworkFailureImpl;
  const NetworkFailure._() : super._();

  @override
  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkFailureImplCopyWith<_$NetworkFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ServerFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ServerFailureImplCopyWith(
    _$ServerFailureImpl value,
    $Res Function(_$ServerFailureImpl) then,
  ) = __$$ServerFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String code, int? statusCode});
}

/// @nodoc
class __$$ServerFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ServerFailureImpl>
    implements _$$ServerFailureImplCopyWith<$Res> {
  __$$ServerFailureImplCopyWithImpl(
    _$ServerFailureImpl _value,
    $Res Function(_$ServerFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? code = null,
    Object? statusCode = freezed,
  }) {
    return _then(
      _$ServerFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        statusCode: freezed == statusCode
            ? _value.statusCode
            : statusCode // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$ServerFailureImpl extends ServerFailure {
  const _$ServerFailureImpl({
    required this.message,
    required this.code,
    this.statusCode,
  }) : super._();

  @override
  final String message;
  @override
  final String code;
  @override
  final int? statusCode;

  @override
  String toString() {
    return 'Failure.server(message: $message, code: $code, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, code, statusCode);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerFailureImplCopyWith<_$ServerFailureImpl> get copyWith =>
      __$$ServerFailureImplCopyWithImpl<_$ServerFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(String message, String code, int? statusCode)
    server,
    required TResult Function(String message) auth,
    required TResult Function(String message, Map<String, String>? fieldErrors)
    validation,
    required TResult Function(String message, StackTrace? stackTrace)
    unexpected,
    required TResult Function(String message) notFound,
    required TResult Function(String message) forbidden,
    required TResult Function(String message) duplicateBook,
  }) {
    return server(message, code, statusCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(String message, String code, int? statusCode)? server,
    TResult? Function(String message)? auth,
    TResult? Function(String message, Map<String, String>? fieldErrors)?
    validation,
    TResult? Function(String message, StackTrace? stackTrace)? unexpected,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message)? duplicateBook,
  }) {
    return server?.call(message, code, statusCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(String message, String code, int? statusCode)? server,
    TResult Function(String message)? auth,
    TResult Function(String message, Map<String, String>? fieldErrors)?
    validation,
    TResult Function(String message, StackTrace? stackTrace)? unexpected,
    TResult Function(String message)? notFound,
    TResult Function(String message)? forbidden,
    TResult Function(String message)? duplicateBook,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(message, code, statusCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(ServerFailure value) server,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(UnexpectedFailure value) unexpected,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(DuplicateBookFailure value) duplicateBook,
  }) {
    return server(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(UnexpectedFailure value)? unexpected,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(DuplicateBookFailure value)? duplicateBook,
  }) {
    return server?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(ServerFailure value)? server,
    TResult Function(AuthFailure value)? auth,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(UnexpectedFailure value)? unexpected,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(DuplicateBookFailure value)? duplicateBook,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(this);
    }
    return orElse();
  }
}

abstract class ServerFailure extends Failure {
  const factory ServerFailure({
    required final String message,
    required final String code,
    final int? statusCode,
  }) = _$ServerFailureImpl;
  const ServerFailure._() : super._();

  @override
  String get message;
  String get code;
  int? get statusCode;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServerFailureImplCopyWith<_$ServerFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$AuthFailureImplCopyWith(
    _$AuthFailureImpl value,
    $Res Function(_$AuthFailureImpl) then,
  ) = __$$AuthFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AuthFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$AuthFailureImpl>
    implements _$$AuthFailureImplCopyWith<$Res> {
  __$$AuthFailureImplCopyWithImpl(
    _$AuthFailureImpl _value,
    $Res Function(_$AuthFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$AuthFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AuthFailureImpl extends AuthFailure {
  const _$AuthFailureImpl({required this.message}) : super._();

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.auth(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthFailureImplCopyWith<_$AuthFailureImpl> get copyWith =>
      __$$AuthFailureImplCopyWithImpl<_$AuthFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(String message, String code, int? statusCode)
    server,
    required TResult Function(String message) auth,
    required TResult Function(String message, Map<String, String>? fieldErrors)
    validation,
    required TResult Function(String message, StackTrace? stackTrace)
    unexpected,
    required TResult Function(String message) notFound,
    required TResult Function(String message) forbidden,
    required TResult Function(String message) duplicateBook,
  }) {
    return auth(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(String message, String code, int? statusCode)? server,
    TResult? Function(String message)? auth,
    TResult? Function(String message, Map<String, String>? fieldErrors)?
    validation,
    TResult? Function(String message, StackTrace? stackTrace)? unexpected,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message)? duplicateBook,
  }) {
    return auth?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(String message, String code, int? statusCode)? server,
    TResult Function(String message)? auth,
    TResult Function(String message, Map<String, String>? fieldErrors)?
    validation,
    TResult Function(String message, StackTrace? stackTrace)? unexpected,
    TResult Function(String message)? notFound,
    TResult Function(String message)? forbidden,
    TResult Function(String message)? duplicateBook,
    required TResult orElse(),
  }) {
    if (auth != null) {
      return auth(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(ServerFailure value) server,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(UnexpectedFailure value) unexpected,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(DuplicateBookFailure value) duplicateBook,
  }) {
    return auth(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(UnexpectedFailure value)? unexpected,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(DuplicateBookFailure value)? duplicateBook,
  }) {
    return auth?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(ServerFailure value)? server,
    TResult Function(AuthFailure value)? auth,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(UnexpectedFailure value)? unexpected,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(DuplicateBookFailure value)? duplicateBook,
    required TResult orElse(),
  }) {
    if (auth != null) {
      return auth(this);
    }
    return orElse();
  }
}

abstract class AuthFailure extends Failure {
  const factory AuthFailure({required final String message}) =
      _$AuthFailureImpl;
  const AuthFailure._() : super._();

  @override
  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthFailureImplCopyWith<_$AuthFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValidationFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ValidationFailureImplCopyWith(
    _$ValidationFailureImpl value,
    $Res Function(_$ValidationFailureImpl) then,
  ) = __$$ValidationFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, Map<String, String>? fieldErrors});
}

/// @nodoc
class __$$ValidationFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ValidationFailureImpl>
    implements _$$ValidationFailureImplCopyWith<$Res> {
  __$$ValidationFailureImplCopyWithImpl(
    _$ValidationFailureImpl _value,
    $Res Function(_$ValidationFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? fieldErrors = freezed}) {
    return _then(
      _$ValidationFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        fieldErrors: freezed == fieldErrors
            ? _value._fieldErrors
            : fieldErrors // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>?,
      ),
    );
  }
}

/// @nodoc

class _$ValidationFailureImpl extends ValidationFailure {
  const _$ValidationFailureImpl({
    required this.message,
    final Map<String, String>? fieldErrors,
  }) : _fieldErrors = fieldErrors,
       super._();

  @override
  final String message;
  final Map<String, String>? _fieldErrors;
  @override
  Map<String, String>? get fieldErrors {
    final value = _fieldErrors;
    if (value == null) return null;
    if (_fieldErrors is EqualUnmodifiableMapView) return _fieldErrors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Failure.validation(message: $message, fieldErrors: $fieldErrors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidationFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(
              other._fieldErrors,
              _fieldErrors,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    const DeepCollectionEquality().hash(_fieldErrors),
  );

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidationFailureImplCopyWith<_$ValidationFailureImpl> get copyWith =>
      __$$ValidationFailureImplCopyWithImpl<_$ValidationFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(String message, String code, int? statusCode)
    server,
    required TResult Function(String message) auth,
    required TResult Function(String message, Map<String, String>? fieldErrors)
    validation,
    required TResult Function(String message, StackTrace? stackTrace)
    unexpected,
    required TResult Function(String message) notFound,
    required TResult Function(String message) forbidden,
    required TResult Function(String message) duplicateBook,
  }) {
    return validation(message, fieldErrors);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(String message, String code, int? statusCode)? server,
    TResult? Function(String message)? auth,
    TResult? Function(String message, Map<String, String>? fieldErrors)?
    validation,
    TResult? Function(String message, StackTrace? stackTrace)? unexpected,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message)? duplicateBook,
  }) {
    return validation?.call(message, fieldErrors);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(String message, String code, int? statusCode)? server,
    TResult Function(String message)? auth,
    TResult Function(String message, Map<String, String>? fieldErrors)?
    validation,
    TResult Function(String message, StackTrace? stackTrace)? unexpected,
    TResult Function(String message)? notFound,
    TResult Function(String message)? forbidden,
    TResult Function(String message)? duplicateBook,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(message, fieldErrors);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(ServerFailure value) server,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(UnexpectedFailure value) unexpected,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(DuplicateBookFailure value) duplicateBook,
  }) {
    return validation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(UnexpectedFailure value)? unexpected,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(DuplicateBookFailure value)? duplicateBook,
  }) {
    return validation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(ServerFailure value)? server,
    TResult Function(AuthFailure value)? auth,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(UnexpectedFailure value)? unexpected,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(DuplicateBookFailure value)? duplicateBook,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(this);
    }
    return orElse();
  }
}

abstract class ValidationFailure extends Failure {
  const factory ValidationFailure({
    required final String message,
    final Map<String, String>? fieldErrors,
  }) = _$ValidationFailureImpl;
  const ValidationFailure._() : super._();

  @override
  String get message;
  Map<String, String>? get fieldErrors;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ValidationFailureImplCopyWith<_$ValidationFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnexpectedFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$UnexpectedFailureImplCopyWith(
    _$UnexpectedFailureImpl value,
    $Res Function(_$UnexpectedFailureImpl) then,
  ) = __$$UnexpectedFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, StackTrace? stackTrace});
}

/// @nodoc
class __$$UnexpectedFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$UnexpectedFailureImpl>
    implements _$$UnexpectedFailureImplCopyWith<$Res> {
  __$$UnexpectedFailureImplCopyWithImpl(
    _$UnexpectedFailureImpl _value,
    $Res Function(_$UnexpectedFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? stackTrace = freezed}) {
    return _then(
      _$UnexpectedFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        stackTrace: freezed == stackTrace
            ? _value.stackTrace
            : stackTrace // ignore: cast_nullable_to_non_nullable
                  as StackTrace?,
      ),
    );
  }
}

/// @nodoc

class _$UnexpectedFailureImpl extends UnexpectedFailure {
  const _$UnexpectedFailureImpl({required this.message, this.stackTrace})
    : super._();

  @override
  final String message;
  @override
  final StackTrace? stackTrace;

  @override
  String toString() {
    return 'Failure.unexpected(message: $message, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnexpectedFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, stackTrace);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnexpectedFailureImplCopyWith<_$UnexpectedFailureImpl> get copyWith =>
      __$$UnexpectedFailureImplCopyWithImpl<_$UnexpectedFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(String message, String code, int? statusCode)
    server,
    required TResult Function(String message) auth,
    required TResult Function(String message, Map<String, String>? fieldErrors)
    validation,
    required TResult Function(String message, StackTrace? stackTrace)
    unexpected,
    required TResult Function(String message) notFound,
    required TResult Function(String message) forbidden,
    required TResult Function(String message) duplicateBook,
  }) {
    return unexpected(message, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(String message, String code, int? statusCode)? server,
    TResult? Function(String message)? auth,
    TResult? Function(String message, Map<String, String>? fieldErrors)?
    validation,
    TResult? Function(String message, StackTrace? stackTrace)? unexpected,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message)? duplicateBook,
  }) {
    return unexpected?.call(message, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(String message, String code, int? statusCode)? server,
    TResult Function(String message)? auth,
    TResult Function(String message, Map<String, String>? fieldErrors)?
    validation,
    TResult Function(String message, StackTrace? stackTrace)? unexpected,
    TResult Function(String message)? notFound,
    TResult Function(String message)? forbidden,
    TResult Function(String message)? duplicateBook,
    required TResult orElse(),
  }) {
    if (unexpected != null) {
      return unexpected(message, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(ServerFailure value) server,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(UnexpectedFailure value) unexpected,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(DuplicateBookFailure value) duplicateBook,
  }) {
    return unexpected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(UnexpectedFailure value)? unexpected,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(DuplicateBookFailure value)? duplicateBook,
  }) {
    return unexpected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(ServerFailure value)? server,
    TResult Function(AuthFailure value)? auth,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(UnexpectedFailure value)? unexpected,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(DuplicateBookFailure value)? duplicateBook,
    required TResult orElse(),
  }) {
    if (unexpected != null) {
      return unexpected(this);
    }
    return orElse();
  }
}

abstract class UnexpectedFailure extends Failure {
  const factory UnexpectedFailure({
    required final String message,
    final StackTrace? stackTrace,
  }) = _$UnexpectedFailureImpl;
  const UnexpectedFailure._() : super._();

  @override
  String get message;
  StackTrace? get stackTrace;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnexpectedFailureImplCopyWith<_$UnexpectedFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NotFoundFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$NotFoundFailureImplCopyWith(
    _$NotFoundFailureImpl value,
    $Res Function(_$NotFoundFailureImpl) then,
  ) = __$$NotFoundFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$NotFoundFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$NotFoundFailureImpl>
    implements _$$NotFoundFailureImplCopyWith<$Res> {
  __$$NotFoundFailureImplCopyWithImpl(
    _$NotFoundFailureImpl _value,
    $Res Function(_$NotFoundFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$NotFoundFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$NotFoundFailureImpl extends NotFoundFailure {
  const _$NotFoundFailureImpl({required this.message}) : super._();

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.notFound(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotFoundFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotFoundFailureImplCopyWith<_$NotFoundFailureImpl> get copyWith =>
      __$$NotFoundFailureImplCopyWithImpl<_$NotFoundFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(String message, String code, int? statusCode)
    server,
    required TResult Function(String message) auth,
    required TResult Function(String message, Map<String, String>? fieldErrors)
    validation,
    required TResult Function(String message, StackTrace? stackTrace)
    unexpected,
    required TResult Function(String message) notFound,
    required TResult Function(String message) forbidden,
    required TResult Function(String message) duplicateBook,
  }) {
    return notFound(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(String message, String code, int? statusCode)? server,
    TResult? Function(String message)? auth,
    TResult? Function(String message, Map<String, String>? fieldErrors)?
    validation,
    TResult? Function(String message, StackTrace? stackTrace)? unexpected,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message)? duplicateBook,
  }) {
    return notFound?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(String message, String code, int? statusCode)? server,
    TResult Function(String message)? auth,
    TResult Function(String message, Map<String, String>? fieldErrors)?
    validation,
    TResult Function(String message, StackTrace? stackTrace)? unexpected,
    TResult Function(String message)? notFound,
    TResult Function(String message)? forbidden,
    TResult Function(String message)? duplicateBook,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(ServerFailure value) server,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(UnexpectedFailure value) unexpected,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(DuplicateBookFailure value) duplicateBook,
  }) {
    return notFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(UnexpectedFailure value)? unexpected,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(DuplicateBookFailure value)? duplicateBook,
  }) {
    return notFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(ServerFailure value)? server,
    TResult Function(AuthFailure value)? auth,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(UnexpectedFailure value)? unexpected,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(DuplicateBookFailure value)? duplicateBook,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(this);
    }
    return orElse();
  }
}

abstract class NotFoundFailure extends Failure {
  const factory NotFoundFailure({required final String message}) =
      _$NotFoundFailureImpl;
  const NotFoundFailure._() : super._();

  @override
  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotFoundFailureImplCopyWith<_$NotFoundFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ForbiddenFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ForbiddenFailureImplCopyWith(
    _$ForbiddenFailureImpl value,
    $Res Function(_$ForbiddenFailureImpl) then,
  ) = __$$ForbiddenFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ForbiddenFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ForbiddenFailureImpl>
    implements _$$ForbiddenFailureImplCopyWith<$Res> {
  __$$ForbiddenFailureImplCopyWithImpl(
    _$ForbiddenFailureImpl _value,
    $Res Function(_$ForbiddenFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ForbiddenFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ForbiddenFailureImpl extends ForbiddenFailure {
  const _$ForbiddenFailureImpl({required this.message}) : super._();

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.forbidden(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForbiddenFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForbiddenFailureImplCopyWith<_$ForbiddenFailureImpl> get copyWith =>
      __$$ForbiddenFailureImplCopyWithImpl<_$ForbiddenFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(String message, String code, int? statusCode)
    server,
    required TResult Function(String message) auth,
    required TResult Function(String message, Map<String, String>? fieldErrors)
    validation,
    required TResult Function(String message, StackTrace? stackTrace)
    unexpected,
    required TResult Function(String message) notFound,
    required TResult Function(String message) forbidden,
    required TResult Function(String message) duplicateBook,
  }) {
    return forbidden(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(String message, String code, int? statusCode)? server,
    TResult? Function(String message)? auth,
    TResult? Function(String message, Map<String, String>? fieldErrors)?
    validation,
    TResult? Function(String message, StackTrace? stackTrace)? unexpected,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message)? duplicateBook,
  }) {
    return forbidden?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(String message, String code, int? statusCode)? server,
    TResult Function(String message)? auth,
    TResult Function(String message, Map<String, String>? fieldErrors)?
    validation,
    TResult Function(String message, StackTrace? stackTrace)? unexpected,
    TResult Function(String message)? notFound,
    TResult Function(String message)? forbidden,
    TResult Function(String message)? duplicateBook,
    required TResult orElse(),
  }) {
    if (forbidden != null) {
      return forbidden(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(ServerFailure value) server,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(UnexpectedFailure value) unexpected,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(DuplicateBookFailure value) duplicateBook,
  }) {
    return forbidden(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(UnexpectedFailure value)? unexpected,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(DuplicateBookFailure value)? duplicateBook,
  }) {
    return forbidden?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(ServerFailure value)? server,
    TResult Function(AuthFailure value)? auth,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(UnexpectedFailure value)? unexpected,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(DuplicateBookFailure value)? duplicateBook,
    required TResult orElse(),
  }) {
    if (forbidden != null) {
      return forbidden(this);
    }
    return orElse();
  }
}

abstract class ForbiddenFailure extends Failure {
  const factory ForbiddenFailure({required final String message}) =
      _$ForbiddenFailureImpl;
  const ForbiddenFailure._() : super._();

  @override
  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForbiddenFailureImplCopyWith<_$ForbiddenFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DuplicateBookFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$DuplicateBookFailureImplCopyWith(
    _$DuplicateBookFailureImpl value,
    $Res Function(_$DuplicateBookFailureImpl) then,
  ) = __$$DuplicateBookFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$DuplicateBookFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$DuplicateBookFailureImpl>
    implements _$$DuplicateBookFailureImplCopyWith<$Res> {
  __$$DuplicateBookFailureImplCopyWithImpl(
    _$DuplicateBookFailureImpl _value,
    $Res Function(_$DuplicateBookFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$DuplicateBookFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$DuplicateBookFailureImpl extends DuplicateBookFailure {
  const _$DuplicateBookFailureImpl({required this.message}) : super._();

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.duplicateBook(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DuplicateBookFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DuplicateBookFailureImplCopyWith<_$DuplicateBookFailureImpl>
  get copyWith =>
      __$$DuplicateBookFailureImplCopyWithImpl<_$DuplicateBookFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(String message, String code, int? statusCode)
    server,
    required TResult Function(String message) auth,
    required TResult Function(String message, Map<String, String>? fieldErrors)
    validation,
    required TResult Function(String message, StackTrace? stackTrace)
    unexpected,
    required TResult Function(String message) notFound,
    required TResult Function(String message) forbidden,
    required TResult Function(String message) duplicateBook,
  }) {
    return duplicateBook(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(String message, String code, int? statusCode)? server,
    TResult? Function(String message)? auth,
    TResult? Function(String message, Map<String, String>? fieldErrors)?
    validation,
    TResult? Function(String message, StackTrace? stackTrace)? unexpected,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message)? duplicateBook,
  }) {
    return duplicateBook?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(String message, String code, int? statusCode)? server,
    TResult Function(String message)? auth,
    TResult Function(String message, Map<String, String>? fieldErrors)?
    validation,
    TResult Function(String message, StackTrace? stackTrace)? unexpected,
    TResult Function(String message)? notFound,
    TResult Function(String message)? forbidden,
    TResult Function(String message)? duplicateBook,
    required TResult orElse(),
  }) {
    if (duplicateBook != null) {
      return duplicateBook(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(ServerFailure value) server,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(UnexpectedFailure value) unexpected,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(DuplicateBookFailure value) duplicateBook,
  }) {
    return duplicateBook(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(UnexpectedFailure value)? unexpected,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(DuplicateBookFailure value)? duplicateBook,
  }) {
    return duplicateBook?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(ServerFailure value)? server,
    TResult Function(AuthFailure value)? auth,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(UnexpectedFailure value)? unexpected,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(DuplicateBookFailure value)? duplicateBook,
    required TResult orElse(),
  }) {
    if (duplicateBook != null) {
      return duplicateBook(this);
    }
    return orElse();
  }
}

abstract class DuplicateBookFailure extends Failure {
  const factory DuplicateBookFailure({required final String message}) =
      _$DuplicateBookFailureImpl;
  const DuplicateBookFailure._() : super._();

  @override
  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DuplicateBookFailureImplCopyWith<_$DuplicateBookFailureImpl>
  get copyWith => throw _privateConstructorUsedError;
}
