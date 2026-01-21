import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/features/login/domain/login_validators.dart';

part 'login_form_state.freezed.dart';
part 'login_form_state.g.dart';

@freezed
class LoginFormData with _$LoginFormData {
  const factory LoginFormData({
    @Default('') String email,
    @Default('') String password,
    @Default(true) bool isPasswordObscured,
  }) = _LoginFormData;
}

@riverpod
class LoginFormState extends _$LoginFormState {
  @override
  LoginFormData build() {
    return const LoginFormData();
  }

  void updateEmail(String value) {
    state = state.copyWith(email: value);
  }

  void updatePassword(String value) {
    state = state.copyWith(password: value);
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordObscured: !state.isPasswordObscured);
  }

  String? get emailError => LoginValidators.validateEmail(state.email);

  bool get isValid {
    if (state.email.isEmpty || state.password.isEmpty) {
      return false;
    }
    return emailError == null;
  }
}
