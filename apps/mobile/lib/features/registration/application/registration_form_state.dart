import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/features/registration/domain/registration_validators.dart';

part 'registration_form_state.freezed.dart';
part 'registration_form_state.g.dart';

@freezed
class RegistrationFormData with _$RegistrationFormData {
  const factory RegistrationFormData({
    @Default('') String email,
    @Default('') String password,
    @Default('') String passwordConfirmation,
    @Default(true) bool isPasswordObscured,
    @Default(true) bool isPasswordConfirmationObscured,
  }) = _RegistrationFormData;
}

@riverpod
class RegistrationFormState extends _$RegistrationFormState {
  @override
  RegistrationFormData build() {
    return const RegistrationFormData();
  }

  void updateEmail(String value) {
    state = state.copyWith(email: value);
  }

  void updatePassword(String value) {
    state = state.copyWith(password: value);
  }

  void updatePasswordConfirmation(String value) {
    state = state.copyWith(passwordConfirmation: value);
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordObscured: !state.isPasswordObscured);
  }

  void togglePasswordConfirmationVisibility() {
    state = state.copyWith(
      isPasswordConfirmationObscured: !state.isPasswordConfirmationObscured,
    );
  }

  String? get emailError => RegistrationValidators.validateEmail(state.email);

  String? get passwordError =>
      RegistrationValidators.validatePassword(state.password);

  String? get passwordConfirmationError =>
      RegistrationValidators.validatePasswordConfirmation(
        state.password,
        state.passwordConfirmation,
      );

  bool get isValid {
    if (state.email.isEmpty ||
        state.password.isEmpty ||
        state.passwordConfirmation.isEmpty) {
      return false;
    }
    return emailError == null &&
        passwordError == null &&
        passwordConfirmationError == null;
  }
}
