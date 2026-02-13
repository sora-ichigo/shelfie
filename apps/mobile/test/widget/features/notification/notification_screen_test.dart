import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/follow/domain/follow_status_type.dart';
import 'package:shelfie/features/follow/domain/user_summary.dart';
import 'package:shelfie/features/notification/data/notification_repository.dart';
import 'package:shelfie/features/notification/domain/notification_model.dart';
import 'package:shelfie/features/notification/domain/notification_type.dart';
import 'package:shelfie/features/notification/presentation/notification_screen.dart';

class MockNotificationRepository extends Mock
    implements NotificationRepository {}

void main() {
  late MockNotificationRepository mockNotificationRepo;

  setUp(() {
    mockNotificationRepo = MockNotificationRepository();
  });

  Widget buildSubject({
    List<Override> overrides = const [],
  }) {
    return ProviderScope(
      overrides: [
        notificationRepositoryProvider
            .overrideWithValue(mockNotificationRepo),
        ...overrides,
      ],
      child: MaterialApp(
        theme: AppTheme.theme,
        home: const NotificationScreen(),
      ),
    );
  }

  NotificationModel createNotification({
    required int id,
    required String name,
    required String handle,
    required NotificationType type,
    required FollowStatusType followStatus,
    bool isRead = false,
  }) {
    return NotificationModel(
      id: id,
      sender: UserSummary(
        id: id * 10,
        name: name,
        avatarUrl: null,
        handle: handle,
      ),
      type: type,
      followStatus: followStatus,
      isRead: isRead,
      createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
    );
  }

  final testNotifications = [
    NotificationModel(
      id: 1,
      sender: const UserSummary(
        id: 10,
        name: 'テストユーザー',
        avatarUrl: null,
        handle: 'testuser',
      ),
      type: NotificationType.followRequestReceived,
      followStatus: FollowStatusType.pendingReceived,
      isRead: false,
      createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    NotificationModel(
      id: 2,
      sender: const UserSummary(
        id: 20,
        name: '承認ユーザー',
        avatarUrl: null,
        handle: 'approved',
      ),
      type: NotificationType.followRequestApproved,
      followStatus: FollowStatusType.none,
      isRead: true,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
  ];

  group('NotificationScreen', () {
    testWidgets('お知らせ一覧を表示すること', (tester) async {
      when(() => mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer((_) async => right(testNotifications));
      when(() => mockNotificationRepo.markAllAsRead())
          .thenAnswer((_) async => right(null));

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.textContaining('テストユーザー'), findsOneWidget);
      expect(find.textContaining('承認ユーザー'), findsOneWidget);
    });

    testWidgets('followRequestReceived の通知テキストを正しく表示すること', (tester) async {
      when(() => mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer((_) async => right([testNotifications[0]]));
      when(() => mockNotificationRepo.markAllAsRead())
          .thenAnswer((_) async => right(null));

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(
        find.textContaining('からフォローリクエストがありました'),
        findsOneWidget,
      );
    });

    testWidgets('followRequestApproved の通知テキストを正しく表示すること', (tester) async {
      when(() => mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer((_) async => right([testNotifications[1]]));
      when(() => mockNotificationRepo.markAllAsRead())
          .thenAnswer((_) async => right(null));

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(
        find.textContaining('があなたをフォローしました'),
        findsOneWidget,
      );
    });

    testWidgets('お知らせが0件の場合に空状態メッセージを表示すること', (tester) async {
      when(() => mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer((_) async => right([]));
      when(() => mockNotificationRepo.markAllAsRead())
          .thenAnswer((_) async => right(null));

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.text('お知らせはまだありません'), findsOneWidget);
    });

    testWidgets('画面を開いた際に markAsRead が呼ばれること', (tester) async {
      when(() => mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer((_) async => right(testNotifications));
      when(() => mockNotificationRepo.markAllAsRead())
          .thenAnswer((_) async => right(null));

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      verify(() => mockNotificationRepo.markAllAsRead()).called(1);
    });

    testWidgets('エラー時にリトライボタンを表示すること', (tester) async {
      when(() => mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer(
        (_) async => left(const NetworkFailure(message: 'Network error')),
      );
      when(() => mockNotificationRepo.markAllAsRead())
          .thenAnswer((_) async => right(null));

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.byType(ErrorWidget).evaluate().isEmpty, isTrue);
    });

    testWidgets('pendingReceived で承認・削除ボタンを表示すること', (tester) async {
      final notification = createNotification(
        id: 1,
        name: 'ユーザーA',
        handle: 'user_a',
        type: NotificationType.followRequestReceived,
        followStatus: FollowStatusType.pendingReceived,
      );

      when(() => mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer((_) async => right([notification]));
      when(() => mockNotificationRepo.markAllAsRead())
          .thenAnswer((_) async => right(null));

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.text('承認'), findsOneWidget);
      expect(find.text('削除'), findsOneWidget);
    });

    testWidgets('following でフォロー中ボタン（非活性）を表示すること', (tester) async {
      final notification = createNotification(
        id: 2,
        name: 'ユーザーB',
        handle: 'user_b',
        type: NotificationType.followRequestApproved,
        followStatus: FollowStatusType.following,
      );

      when(() => mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer((_) async => right([notification]));
      when(() => mockNotificationRepo.markAllAsRead())
          .thenAnswer((_) async => right(null));

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.text('フォロー中'), findsOneWidget);
    });

    testWidgets('none + followRequestReceived でフォローバックボタンを表示すること',
        (tester) async {
      final notification = createNotification(
        id: 3,
        name: 'ユーザーC',
        handle: 'user_c',
        type: NotificationType.followRequestReceived,
        followStatus: FollowStatusType.none,
      );

      when(() => mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer((_) async => right([notification]));
      when(() => mockNotificationRepo.markAllAsRead())
          .thenAnswer((_) async => right(null));

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.text('フォローバック'), findsOneWidget);
    });

    testWidgets('none + followRequestApproved でフォローボタンを表示すること',
        (tester) async {
      final notification = createNotification(
        id: 4,
        name: 'ユーザーD',
        handle: 'user_d',
        type: NotificationType.followRequestApproved,
        followStatus: FollowStatusType.none,
      );

      when(() => mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer((_) async => right([notification]));
      when(() => mockNotificationRepo.markAllAsRead())
          .thenAnswer((_) async => right(null));

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.text('フォロー'), findsOneWidget);
    });

    testWidgets('pendingSent でリクエスト済みボタン（非活性）を表示すること', (tester) async {
      final notification = createNotification(
        id: 5,
        name: 'ユーザーE',
        handle: 'user_e',
        type: NotificationType.followRequestApproved,
        followStatus: FollowStatusType.pendingSent,
      );

      when(() => mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer((_) async => right([notification]));
      when(() => mockNotificationRepo.markAllAsRead())
          .thenAnswer((_) async => right(null));

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.text('リクエスト済み'), findsOneWidget);
    });
  });
}
