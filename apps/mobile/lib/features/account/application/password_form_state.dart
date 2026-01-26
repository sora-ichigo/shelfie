import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/features/account/domain/password_validators.dart';

part 'password_form_state.freezed.dart';
part 'password_form_state.g.dart';

@freezed
class PasswordFormData with _$PasswordFormData {
  const factory PasswordFormData({
    @Default('') String currentPassword,
    @Default('') String newPassword,
    @Default('') String confirmPassword,
    @Default(true) bool isCurrentPasswordObscured,
    @Default(true) bool isNewPasswordObscured,
    @Default(true) bool isConfirmPasswordObscured,
    String? currentPasswordError,
    String? newPasswordError,
    String? confirmPasswordError,
  }) = _PasswordFormData;
}

@riverpod
class PasswordFormState extends _$PasswordFormState {
  @override
  PasswordFormData build() {
    return const PasswordFormData();
  }

  void setCurrentPassword(String value) {
    final error = PasswordValidators.validateCurrentPassword(value);
    state = state.copyWith(
      currentPassword: value,
      currentPasswordError: error,
    );
  }

  void setNewPassword(String value) {
    final error = PasswordValidators.validateNewPassword(value);
    state = state.copyWith(
      newPassword: value,
      newPasswordError: error,
    );

    if (state.confirmPassword.isNotEmpty) {
      final confirmError = PasswordValidators.validateConfirmPassword(
        value,
        state.confirmPassword,
      );
      state = state.copyWith(confirmPasswordError: confirmError);
    }
  }

  void setConfirmPassword(String value) {
    final error = PasswordValidators.validateConfirmPassword(
      state.newPassword,
      value,
    );
    state = state.copyWith(
      confirmPassword: value,
      confirmPasswordError: error,
    );
  }

  void toggleCurrentPasswordVisibility() {
    state = state.copyWith(
      isCurrentPasswordObscured: !state.isCurrentPasswordObscured,
    );
  }

  void toggleNewPasswordVisibility() {
    state = state.copyWith(
      isNewPasswordObscured: !state.isNewPasswordObscured,
    );
  }

  void toggleConfirmPasswordVisibility() {
    state = state.copyWith(
      isConfirmPasswordObscured: !state.isConfirmPasswordObscured,
    );
  }

  bool get isValid {
    if (state.currentPassword.isEmpty ||
        state.newPassword.isEmpty ||
        state.confirmPassword.isEmpty) {
      return false;
    }

    return state.currentPasswordError == null &&
        state.newPasswordError == null &&
        state.confirmPasswordError == null;
  }

  void reset() {
    state = const PasswordFormData();
  }
}
