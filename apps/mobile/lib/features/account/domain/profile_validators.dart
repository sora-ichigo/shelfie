abstract final class ProfileValidators {
  static final _emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
  static final _handleRegExp = RegExp(r'^[a-zA-Z0-9_]+$');
  static final _instagramHandleRegExp = RegExp(r'^[a-zA-Z0-9_.]+$');

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

  static String? validateHandle(String handle) {
    if (handle.isEmpty) return null;
    if (handle.length > 30) {
      return 'ハンドルは30文字以内で入力してください';
    }
    if (!_handleRegExp.hasMatch(handle)) {
      return 'ハンドルは英数字とアンダースコアのみ使用できます';
    }
    return null;
  }

  static String? validateBio(String bio) {
    if (bio.isEmpty) return null;
    if (bio.length > 500) {
      return '自己紹介は500文字以内で入力してください';
    }
    return null;
  }

  static String? validateInstagramHandle(String handle) {
    if (handle.isEmpty) return null;
    if (handle.length > 30) {
      return 'Instagramハンドルは30文字以内で入力してください';
    }
    if (!_instagramHandleRegExp.hasMatch(handle)) {
      return 'Instagramハンドルの形式が正しくありません';
    }
    return null;
  }
}
