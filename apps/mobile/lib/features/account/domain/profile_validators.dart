abstract final class ProfileValidators {
  static final _emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

  static String? validateName(String name) {
    if (name.trim().isEmpty) {
      return '氏名を入力してください';
    }
    return null;
  }

  static String? validateEmail(String email) {
    if (email.trim().isEmpty) {
      return 'メールアドレスを入力してください';
    }
    if (!_emailRegExp.hasMatch(email)) {
      return '有効なメールアドレスを入力してください';
    }
    return null;
  }
}
