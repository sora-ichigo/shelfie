abstract final class LoginValidators {
  static final _emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

  static String? validateEmail(String email) {
    if (email.isEmpty) return null;
    if (!_emailRegExp.hasMatch(email)) {
      return '有効なメールアドレスを入力してください';
    }
    return null;
  }
}
