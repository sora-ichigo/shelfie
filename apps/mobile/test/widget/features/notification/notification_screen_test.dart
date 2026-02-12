import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/follow/data/follow_repository.dart';
import 'package:shelfie/features/follow/domain/user_summary.dart';
import 'package:shelfie/features/notification/data/notification_repository.dart';
import 'package:shelfie/features/notification/domain/notification_model.dart';
import 'package:shelfie/features/notification/domain/notification_type.dart';
import 'package:shelfie/features/notification/presentation/notification_screen.dart';

class MockNotificationRepository extends Mock
    implements NotificationRepository {}

class MockFollowRepository extends Mock implements FollowRepository {}

void main() {
  late MockNotificationRepository mockNotificationRepo;
  late MockFollowRepository mockFollowRepo;

  setUp(() {
    mockNotificationRepo = MockNotificationRepository();
    mockFollowRepo = MockFollowRepository();
  });

  Widget buildSubject({
    List<Override> overrides = const [],
  }) {
    return ProviderScope(
      overrides: [
        notificationRepositoryProvider
            .overrideWithValue(mockNotificationRepo),
        followRepositoryProvider.overrideWithValue(mockFollowRepo),
        ...overrides,
      ],
      child: MaterialApp(
        theme: AppTheme.theme,
        home: const NotificationScreen(),
      ),
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
      when(() => mockFollowRepo.getPendingRequestCount())
          .thenAnswer((_) async => right(0));

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
      when(() => mockFollowRepo.getPendingRequestCount())
          .thenAnswer((_) async => right(0));

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(
        find.textContaining('フォローリクエストが届きました'),
        findsOneWidget,
      );
    });

    testWidgets('followRequestApproved の通知テキストを正しく表示すること', (tester) async {
      when(() => mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer((_) async => right([testNotifications[1]]));
      when(() => mockNotificationRepo.markAllAsRead())
          .thenAnswer((_) async => right(null));
      when(() => mockFollowRepo.getPendingRequestCount())
          .thenAnswer((_) async => right(0));

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(
        find.textContaining('フォローリクエストを承認しました'),
        findsOneWidget,
      );
    });

    testWidgets('お知らせが0件の場合に空状態メッセージを表示すること', (tester) async {
      when(() => mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer((_) async => right([]));
      when(() => mockNotificationRepo.markAllAsRead())
          .thenAnswer((_) async => right(null));
      when(() => mockFollowRepo.getPendingRequestCount())
          .thenAnswer((_) async => right(0));

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.text('お知らせはまだありません'), findsOneWidget);
    });

    testWidgets('未処理リクエストが0件の場合はフォローリクエスト導線を非表示にすること',
        (tester) async {
      when(() => mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer((_) async => right(testNotifications));
      when(() => mockNotificationRepo.markAllAsRead())
          .thenAnswer((_) async => right(null));
      when(() => mockFollowRepo.getPendingRequestCount())
          .thenAnswer((_) async => right(0));

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.text('フォローリクエスト'), findsNothing);
    });

    testWidgets('未処理リクエストがある場合はフォローリクエスト導線を表示すること',
        (tester) async {
      when(() => mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer((_) async => right(testNotifications));
      when(() => mockNotificationRepo.markAllAsRead())
          .thenAnswer((_) async => right(null));
      when(() => mockFollowRepo.getPendingRequestCount())
          .thenAnswer((_) async => right(3));

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.text('フォローリクエスト'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('画面を開いた際に markAsRead が呼ばれること', (tester) async {
      when(() => mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer((_) async => right(testNotifications));
      when(() => mockNotificationRepo.markAllAsRead())
          .thenAnswer((_) async => right(null));
      when(() => mockFollowRepo.getPendingRequestCount())
          .thenAnswer((_) async => right(0));

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
      when(() => mockFollowRepo.getPendingRequestCount())
          .thenAnswer((_) async => right(0));

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.byType(ErrorWidget).evaluate().isEmpty, isTrue);
    });

    testWidgets('通知種別に応じたアイコンを表示すること', (tester) async {
      when(() => mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer((_) async => right(testNotifications));
      when(() => mockNotificationRepo.markAllAsRead())
          .thenAnswer((_) async => right(null));
      when(() => mockFollowRepo.getPendingRequestCount())
          .thenAnswer((_) async => right(0));

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.byIcon(CupertinoIcons.person_add), findsOneWidget);
      expect(find.byIcon(CupertinoIcons.checkmark_circle), findsOneWidget);
    });
  });
}
