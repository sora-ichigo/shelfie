import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/features/push_notification/application/notification_tap_handler.dart';

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {}

void main() {
  late MockFirebaseMessaging mockMessaging;
  late List<String> navigatedRoutes;
  late NotificationTapHandler handler;

  setUp(() {
    mockMessaging = MockFirebaseMessaging();
    navigatedRoutes = [];
    handler = NotificationTapHandler(
      messaging: mockMessaging,
      onNavigate: (route) => navigatedRoutes.add(route),
    );
  });

  group('NotificationTapHandler', () {
    group('setupFCMHandlers', () {
      test('getInitialMessage の route がある場合、onNavigate が呼ばれる', () async {
        when(() => mockMessaging.getInitialMessage()).thenAnswer(
          (_) async => RemoteMessage(data: {'route': '/books/123?source=rakuten'}),
        );

        handler.setupFCMHandlers(
          onMessageOpenedApp: const Stream.empty(),
        );

        await Future<void>.delayed(Duration.zero);

        expect(navigatedRoutes, ['/books/123?source=rakuten']);
      });

      test('getInitialMessage が null の場合、onNavigate は呼ばれない', () async {
        when(() => mockMessaging.getInitialMessage()).thenAnswer(
          (_) async => null,
        );

        handler.setupFCMHandlers(
          onMessageOpenedApp: const Stream.empty(),
        );

        await Future<void>.delayed(Duration.zero);

        expect(navigatedRoutes, isEmpty);
      });

      test('getInitialMessage の route が空の場合、onNavigate は呼ばれない', () async {
        when(() => mockMessaging.getInitialMessage()).thenAnswer(
          (_) async => const RemoteMessage(),
        );

        handler.setupFCMHandlers(
          onMessageOpenedApp: const Stream.empty(),
        );

        await Future<void>.delayed(Duration.zero);

        expect(navigatedRoutes, isEmpty);
      });

      test('onMessageOpenedApp の route がある場合、onNavigate が呼ばれる', () async {
        when(() => mockMessaging.getInitialMessage()).thenAnswer(
          (_) async => null,
        );

        final messageStream = Stream.value(
          RemoteMessage(data: {'route': '/books/456?source=google'}),
        );

        handler.setupFCMHandlers(
          onMessageOpenedApp: messageStream,
        );

        await Future<void>.delayed(Duration.zero);

        expect(navigatedRoutes, ['/books/456?source=google']);
      });

      test('onMessageOpenedApp の route がない場合、onNavigate は呼ばれない', () async {
        when(() => mockMessaging.getInitialMessage()).thenAnswer(
          (_) async => null,
        );

        final messageStream = Stream.value(const RemoteMessage());

        handler.setupFCMHandlers(
          onMessageOpenedApp: messageStream,
        );

        await Future<void>.delayed(Duration.zero);

        expect(navigatedRoutes, isEmpty);
      });
    });

    group('onLocalNotificationTap', () {
      test('payload に route がある場合、onNavigate が呼ばれる', () {
        handler.onLocalNotificationTap(
          const NotificationResponse(
            notificationResponseType:
                NotificationResponseType.selectedNotification,
            payload: '/books/789?source=rakuten',
          ),
        );

        expect(navigatedRoutes, ['/books/789?source=rakuten']);
      });

      test('payload が null の場合、onNavigate は呼ばれない', () {
        handler.onLocalNotificationTap(
          const NotificationResponse(
            notificationResponseType:
                NotificationResponseType.selectedNotification,
          ),
        );

        expect(navigatedRoutes, isEmpty);
      });

      test('payload が空文字の場合、onNavigate は呼ばれない', () {
        handler.onLocalNotificationTap(
          const NotificationResponse(
            notificationResponseType:
                NotificationResponseType.selectedNotification,
            payload: '',
          ),
        );

        expect(navigatedRoutes, isEmpty);
      });
    });
  });
}
