import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/utils/time_ago.dart';

void main() {
  group('formatTimeAgo', () {
    test('数秒前を表示すること', () {
      final now = DateTime.now();
      expect(formatTimeAgo(now.subtract(const Duration(seconds: 5))), '5秒前');
      expect(formatTimeAgo(now.subtract(const Duration(seconds: 30))), '30秒前');
      expect(formatTimeAgo(now.subtract(const Duration(seconds: 59))), '59秒前');
    });

    test('0秒差はたった今を表示すること', () {
      final now = DateTime.now();
      expect(formatTimeAgo(now), 'たった今');
    });

    test('分単位を表示すること', () {
      final now = DateTime.now();
      expect(formatTimeAgo(now.subtract(const Duration(minutes: 1))), '1分前');
      expect(formatTimeAgo(now.subtract(const Duration(minutes: 30))), '30分前');
      expect(formatTimeAgo(now.subtract(const Duration(minutes: 59))), '59分前');
    });

    test('時間単位を表示すること', () {
      final now = DateTime.now();
      expect(formatTimeAgo(now.subtract(const Duration(hours: 1))), '1時間前');
      expect(formatTimeAgo(now.subtract(const Duration(hours: 23))), '23時間前');
    });

    test('日単位を表示すること', () {
      final now = DateTime.now();
      expect(formatTimeAgo(now.subtract(const Duration(days: 1))), '1日前');
      expect(formatTimeAgo(now.subtract(const Duration(days: 29))), '29日前');
    });

    test('月単位を表示すること', () {
      final now = DateTime.now();
      expect(formatTimeAgo(now.subtract(const Duration(days: 30))), '1ヶ月前');
      expect(formatTimeAgo(now.subtract(const Duration(days: 364))), '12ヶ月前');
    });

    test('年単位を表示すること', () {
      final now = DateTime.now();
      expect(formatTimeAgo(now.subtract(const Duration(days: 365))), '1年前');
    });
  });
}
