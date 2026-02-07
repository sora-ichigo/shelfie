import 'dart:ui';

/// 読書状態を表す enum
///
/// ユーザーが本棚に追加した書籍の読書状態を管理する。
enum ReadingStatus {
  /// 積読（まだ読み始めていない）
  backlog,

  /// 読書中
  reading,

  /// 読了
  completed,

  /// 気になる
  interested;

  /// グループ表示時のソート順（小さいほど先に表示）
  int get displayOrder {
    switch (this) {
      case ReadingStatus.reading:
        return 0;
      case ReadingStatus.interested:
        return 1;
      case ReadingStatus.backlog:
        return 2;
      case ReadingStatus.completed:
        return 3;
    }
  }

  /// 日本語の表示名を返す
  String get displayName {
    switch (this) {
      case ReadingStatus.backlog:
        return '積読';
      case ReadingStatus.reading:
        return '読書中';
      case ReadingStatus.completed:
        return '読了';
      case ReadingStatus.interested:
        return '気になる';
    }
  }

  Color get color {
    switch (this) {
      case ReadingStatus.backlog:
        return const Color(0xFFC49A5A);
      case ReadingStatus.reading:
        return const Color(0xFF6AABCF);
      case ReadingStatus.completed:
        return const Color(0xFF6BBF8A);
      case ReadingStatus.interested:
        return const Color(0xFFB896BD);
    }
  }

  /// 文字列から ReadingStatus を生成する
  ///
  /// 大文字小文字を区別しない。無効な値の場合は [ArgumentError] をスローする。
  static ReadingStatus fromString(String value) {
    final lowered = value.toLowerCase();
    for (final status in ReadingStatus.values) {
      if (status.name == lowered) {
        return status;
      }
    }
    throw ArgumentError('Invalid ReadingStatus value: $value');
  }
}
