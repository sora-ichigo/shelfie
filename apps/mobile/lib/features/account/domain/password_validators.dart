abstract final class PasswordValidators {
  static const int minLength = 8;

  static final _hasLetter = RegExp('[a-zA-Z]');
  static final _hasNumber = RegExp('[0-9]');

  static String? validateNewPassword(String password) {
    if (password.isEmpty) return null;

    if (password.length < minLength) {
      return 'パスワードは$minLength文字以上で入力してください';
    }

    if (!_hasLetter.hasMatch(password)) {
      return 'パスワードには英字を含めてください';
    }

    if (!_hasNumber.hasMatch(password)) {
      return 'パスワードには数字を含めてください';
    }

    return null;
  }

  static String? validateConfirmPassword(
    String password,
    String confirmPassword,
  ) {
    if (confirmPassword.isEmpty) return null;

    if (password != confirmPassword) {
      return 'パスワードが一致しません';
    }

    return null;
  }

  static String? validateCurrentPassword(String password) {
    if (password.isEmpty) return null;
    return null;
  }
}
