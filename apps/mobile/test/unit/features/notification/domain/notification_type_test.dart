import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/notification/domain/notification_type.dart';

void main() {
  group('NotificationType', () {
    test('2つの値を持つ', () {
      expect(NotificationType.values.length, equals(2));
    });

    test('followRequestReceived, followRequestApproved の値が定義されている', () {
      expect(
        NotificationType.values,
        contains(NotificationType.followRequestReceived),
      );
      expect(
        NotificationType.values,
        contains(NotificationType.followRequestApproved),
      );
    });
  });
}
