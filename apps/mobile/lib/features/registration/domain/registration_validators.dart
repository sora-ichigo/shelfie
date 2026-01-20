abstract final class RegistrationValidators {
  static final _emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

  static String? validateEmail(String email) {
    if (email.isEmpty) return null;
    if (!_emailRegExp.hasMatch(email)) {
      return '有効なメールアドレスを入力してください';
    }
    return null;
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) return null;
    if (password.length < 8) {
      return 'パスワードは8文字以上で入力してください';
    }
    return null;
  }

  static String? validatePasswordConfirmation(
    String password,
    String confirmation,
  ) {
    if (confirmation.isEmpty) return null;
    if (password != confirmation) {
      return 'パスワードが一致しません';
    }
    return null;
  }
}
