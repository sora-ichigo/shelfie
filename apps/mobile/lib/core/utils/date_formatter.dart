import 'package:intl/intl.dart';

/// 日付文字列を日本語形式にフォーマットする
///
/// 対応形式:
/// - yyyy-MM-dd → yyyy年M月d日
/// - yyyy-MM → yyyy年M月
/// - yyyy → yyyy年
/// - その他 → そのまま返す
String formatDateString(String dateString) {
  try {
    if (RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(dateString)) {
      final date = DateTime.parse(dateString);
      return DateFormat('yyyy年M月d日').format(date);
    }
    if (RegExp(r'^\d{4}-\d{2}$').hasMatch(dateString)) {
      final date = DateTime.parse('$dateString-01');
      return DateFormat('yyyy年M月').format(date);
    }
    if (RegExp(r'^\d{4}$').hasMatch(dateString)) {
      return '$dateString年';
    }
    return dateString;
  } catch (_) {
    return dateString;
  }
}
