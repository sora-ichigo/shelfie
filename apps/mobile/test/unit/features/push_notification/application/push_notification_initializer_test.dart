import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/features/push_notification/application/push_notification_initializer.dart';

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {}

class MockFlutterLocalNotificationsPlugin extends Mock
    implements FlutterLocalNotificationsPlugin {}

class FakeNotificationSettings extends Fake implements NotificationSettings {
  FakeNotificationSettings({this.authorizationStatusOverride});

  final AuthorizationStatus? authorizationStatusOverride;

  @override
  AuthorizationStatus get authorizationStatus =>
      authorizationStatusOverride ?? AuthorizationStatus.authorized;
}

class FakeInitializationSettings extends Fake
    implements InitializationSettings {}

void main() {
  late MockFirebaseMessaging mockMessaging;
  late MockFlutterLocalNotificationsPlugin mockLocalNotifications;

  setUp(() {
    mockMessaging = MockFirebaseMessaging();
    mockLocalNotifications = MockFlutterLocalNotificationsPlugin();
  });

  setUpAll(() {
    registerFallbackValue(FakeInitializationSettings());
  });

  PushNotificationInitializer createInitializer() {
    return PushNotificationInitializer(
      messaging: mockMessaging,
      localNotifications: mockLocalNotifications,
      registerBackgroundHandler: false,
    );
  }

  void stubDefaults({
    AuthorizationStatus authStatus = AuthorizationStatus.authorized,
  }) {
    when(() => mockMessaging.requestPermission()).thenAnswer(
      (_) async => FakeNotificationSettings(
        authorizationStatusOverride: authStatus,
      ),
    );
    when(
      () => mockMessaging.setForegroundNotificationPresentationOptions(
        alert: any(named: 'alert'),
        badge: any(named: 'badge'),
        sound: any(named: 'sound'),
      ),
    ).thenAnswer((_) async {});
    when(() => mockLocalNotifications.initialize(any()))
        .thenAnswer((_) async => true);
    when(
      () => mockLocalNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>(),
    ).thenReturn(null);
  }

  group('PushNotificationInitializer', () {
    test('requestPermission を呼び出す', () async {
      stubDefaults();
      final initializer = createInitializer();

      await initializer.initialize();

      verify(() => mockMessaging.requestPermission()).called(1);
    });

    test('iOS のフォアグラウンド通知表示オプションを設定する', () async {
      stubDefaults();
      final initializer = createInitializer();

      await initializer.initialize();

      verify(
        () => mockMessaging.setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        ),
      ).called(1);
    });

    test('flutter_local_notifications を初期化する', () async {
      stubDefaults();
      final initializer = createInitializer();

      await initializer.initialize();

      verify(() => mockLocalNotifications.initialize(any())).called(1);
    });

    test('通知許可が拒否されてもクラッシュしない', () async {
      stubDefaults(authStatus: AuthorizationStatus.denied);
      final initializer = createInitializer();

      await expectLater(initializer.initialize(), completes);
    });
  });
}
