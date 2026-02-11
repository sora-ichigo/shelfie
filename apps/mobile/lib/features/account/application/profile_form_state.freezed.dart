// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProfileFormData {
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  XFile? get pendingAvatarImage => throw _privateConstructorUsedError;
  bool get hasChanges => throw _privateConstructorUsedError;

  /// Create a copy of ProfileFormData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileFormDataCopyWith<ProfileFormData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileFormDataCopyWith<$Res> {
  factory $ProfileFormDataCopyWith(
          ProfileFormData value, $Res Function(ProfileFormData) then) =
      _$ProfileFormDataCopyWithImpl<$Res, ProfileFormData>;
  @useResult
  $Res call(
      {String name, String email, XFile? pendingAvatarImage, bool hasChanges});
}

/// @nodoc
class _$ProfileFormDataCopyWithImpl<$Res, $Val extends ProfileFormData>
    implements $ProfileFormDataCopyWith<$Res> {
  _$ProfileFormDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileFormData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? pendingAvatarImage = freezed,
    Object? hasChanges = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      pendingAvatarImage: freezed == pendingAvatarImage
          ? _value.pendingAvatarImage
          : pendingAvatarImage // ignore: cast_nullable_to_non_nullable
              as XFile?,
      hasChanges: null == hasChanges
          ? _value.hasChanges
          : hasChanges // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileFormDataImplCopyWith<$Res>
    implements $ProfileFormDataCopyWith<$Res> {
  factory _$$ProfileFormDataImplCopyWith(_$ProfileFormDataImpl value,
          $Res Function(_$ProfileFormDataImpl) then) =
      __$$ProfileFormDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, String email, XFile? pendingAvatarImage, bool hasChanges});
}

/// @nodoc
class __$$ProfileFormDataImplCopyWithImpl<$Res>
    extends _$ProfileFormDataCopyWithImpl<$Res, _$ProfileFormDataImpl>
    implements _$$ProfileFormDataImplCopyWith<$Res> {
  __$$ProfileFormDataImplCopyWithImpl(
      _$ProfileFormDataImpl _value, $Res Function(_$ProfileFormDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileFormData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? pendingAvatarImage = freezed,
    Object? hasChanges = null,
  }) {
    return _then(_$ProfileFormDataImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      pendingAvatarImage: freezed == pendingAvatarImage
          ? _value.pendingAvatarImage
          : pendingAvatarImage // ignore: cast_nullable_to_non_nullable
              as XFile?,
      hasChanges: null == hasChanges
          ? _value.hasChanges
          : hasChanges // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ProfileFormDataImpl implements _ProfileFormData {
  const _$ProfileFormDataImpl(
      {this.name = '',
      this.email = '',
      this.pendingAvatarImage,
      this.hasChanges = false});

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String email;
  @override
  final XFile? pendingAvatarImage;
  @override
  @JsonKey()
  final bool hasChanges;

  @override
  String toString() {
    return 'ProfileFormData(name: $name, email: $email, pendingAvatarImage: $pendingAvatarImage, hasChanges: $hasChanges)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileFormDataImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.pendingAvatarImage, pendingAvatarImage) ||
                other.pendingAvatarImage == pendingAvatarImage) &&
            (identical(other.hasChanges, hasChanges) ||
                other.hasChanges == hasChanges));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, name, email, pendingAvatarImage, hasChanges);

  /// Create a copy of ProfileFormData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileFormDataImplCopyWith<_$ProfileFormDataImpl> get copyWith =>
      __$$ProfileFormDataImplCopyWithImpl<_$ProfileFormDataImpl>(
          this, _$identity);
}

abstract class _ProfileFormData implements ProfileFormData {
  const factory _ProfileFormData(
      {final String name,
      final String email,
      final XFile? pendingAvatarImage,
      final bool hasChanges}) = _$ProfileFormDataImpl;

  @override
  String get name;
  @override
  String get email;
  @override
  XFile? get pendingAvatarImage;
  @override
  bool get hasChanges;

  /// Create a copy of ProfileFormData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileFormDataImplCopyWith<_$ProfileFormDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
