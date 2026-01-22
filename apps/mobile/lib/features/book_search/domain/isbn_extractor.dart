/// ISBN コードの抽出と検証を行うユーティリティクラス
///
/// バーコードスキャン結果から ISBN を抽出し、
/// ISBN-10 と ISBN-13 の形式を検証する。
class ISBNExtractor {
  const ISBNExtractor._();

  /// バーコードから ISBN を抽出する
  ///
  /// EAN-13（ISBN-13）または ISBN-10 形式のバーコードから
  /// ISBN を抽出して返す。有効な ISBN でない場合は null を返す。
  static String? extractISBN(String barcode) {
    if (barcode.isEmpty) {
      return null;
    }

    final cleaned = barcode.replaceAll(RegExp(r'[^0-9X]'), '');

    if (cleaned.length == 13 && isValidISBN13(cleaned)) {
      return cleaned;
    }

    if (cleaned.length == 10 && isValidISBN10(cleaned)) {
      return cleaned;
    }

    return null;
  }

  /// ISBN-13 形式の検証
  ///
  /// ISBN-13 は 978 または 979 で始まる 13 桁の数字
  static bool isValidISBN13(String isbn) {
    if (isbn.length != 13) {
      return false;
    }

    if (!isbn.startsWith('978') && !isbn.startsWith('979')) {
      return false;
    }

    if (!RegExp(r'^\d{13}$').hasMatch(isbn)) {
      return false;
    }

    return true;
  }

  /// ISBN-10 形式の検証
  ///
  /// ISBN-10 は 10 桁で、最後の桁はチェックディジット（0-9 または X）
  static bool isValidISBN10(String isbn) {
    if (isbn.length != 10) {
      return false;
    }

    if (!RegExp(r'^\d{9}[\dX]$').hasMatch(isbn)) {
      return false;
    }

    return true;
  }

  /// ISBN をフォーマットして表示用に変換
  ///
  /// ISBN-13: 978-X-XXXXX-XXX-X
  /// ISBN-10: X-XXXXX-XXX-X
  static String formatISBN(String isbn) {
    final cleaned = isbn.replaceAll('-', '');

    if (cleaned.length == 13) {
      return '${cleaned.substring(0, 3)}-'
          '${cleaned.substring(3, 4)}-'
          '${cleaned.substring(4, 9)}-'
          '${cleaned.substring(9, 12)}-'
          '${cleaned.substring(12)}';
    }

    if (cleaned.length == 10) {
      return '${cleaned.substring(0, 1)}-'
          '${cleaned.substring(1, 6)}-'
          '${cleaned.substring(6, 9)}-'
          '${cleaned.substring(9)}';
    }

    return isbn;
  }
}
