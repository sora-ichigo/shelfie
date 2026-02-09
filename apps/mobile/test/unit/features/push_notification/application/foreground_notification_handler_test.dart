import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/features/push_notification/application/foreground_notification_handler.dart';

class MockFlutterLocalNotificationsPlugin extends Mock
    implements FlutterLocalNotificationsPlugin {}

class FakeNotificationDetails extends Fake implements NotificationDetails {}

void main() {
  late MockFlutterLocalNotificationsPlugin mockLocalNotifications;
  late StreamController<RemoteMessage> messageController;

  setUp(() {
    mockLocalNotifications = MockFlutterLocalNotificationsPlugin();
    messageController = StreamController<RemoteMessage>.broadcast();
  });

  tearDown(() {
    messageController.close();
  });

  setUpAll(() {
    registerFallbackValue(FakeNotificationDetails());
  });

  group('ForegroundNotificationHandler', () {
    test('フォアグラウンドメッセージ受信時にネイティブ通知を表示する', () async {
      when(
        () => mockLocalNotifications.show(
          any(),
          any(),
          any(),
          any(),
        ),
      ).thenAnswer((_) async {});

      final handler = ForegroundNotificationHandler(
        localNotifications: mockLocalNotifications,
      );

      handler.handleForegroundMessage(
        messageController.stream,
      );

      messageController.add(
        RemoteMessage(
          notification: const RemoteNotification(
            title: 'Test Title',
            body: 'Test Body',
          ),
        ),
      );

      await Future<void>.delayed(Duration.zero);

      verify(
        () => mockLocalNotifications.show(
          any(),
          'Test Title',
          'Test Body',
          any(),
        ),
      ).called(1);
    });

    test('notification が null のメッセージ（data-only）はスキップする', () async {
      when(
        () => mockLocalNotifications.show(
          any(),
          any(),
          any(),
          any(),
        ),
      ).thenAnswer((_) async {});

      final handler = ForegroundNotificationHandler(
        localNotifications: mockLocalNotifications,
      );

      handler.handleForegroundMessage(
        messageController.stream,
      );

      messageController.add(
        const RemoteMessage(),
      );

      await Future<void>.delayed(Duration.zero);

      verifyNever(
        () => mockLocalNotifications.show(
          any(),
          any(),
          any(),
          any(),
        ),
      );
    });
  });
}
