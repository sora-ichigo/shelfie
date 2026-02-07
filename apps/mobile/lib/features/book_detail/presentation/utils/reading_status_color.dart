import 'dart:ui';

import 'package:shelfie/features/book_detail/domain/reading_status.dart';

extension ReadingStatusColor on ReadingStatus {
  static const _backlog = Color(0xFFC49A5A);
  static const _reading = Color(0xFF6AABCF);
  static const _completed = Color(0xFF6BBF8A);
  static const _interested = Color(0xFFB896BD);

  Color get color {
    switch (this) {
      case ReadingStatus.backlog:
        return _backlog;
      case ReadingStatus.reading:
        return _reading;
      case ReadingStatus.completed:
        return _completed;
      case ReadingStatus.interested:
        return _interested;
    }
  }
}
