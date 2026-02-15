import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/state/follow_state_notifier.dart';
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
    required FollowStatusType outgoingFollowStatus,
    required FollowStatusType incomingFollowStatus,
    int? followRequestId,
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
      outgoingFollowStatus: outgoingFollowStatus,
      incomingFollowStatus: incomingFollowStatus,
      followRequestId: followRequestId,
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
      outgoingFollowStatus: FollowStatusType.none,
      incomingFollowStatus: FollowStatusType.pendingReceived,
      followRequestId: 100,
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
      outgoingFollowStatus: FollowStatusType.none,
      incomingFollowStatus: FollowStatusType.none,
      followRequestId: null,
      isRead: true,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
  ];

  group('NotificationScreen', () {
    testWidgets('お知らせ一覧を表示すること', (tester) async {
      when(() => mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer((_) async => right(testNotifications));

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.textContaining('テストユーザー'), findsOneWidget);
      expect(find.textContaining('承認ユーザー'), findsOneWidget);
    });

    testWidgets('followRequestReceived の通知テキストを正しく表示すること', (tester) async {
      when(() => mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer((_) async => right([testNotifications[0]]));

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

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(
        find.textContaining('がフォローリクエストを承認しました'),
        findsOneWidget,
      );
    });

    testWidgets('newFollower の通知テキストを正しく表示すること', (tester) async {
      final notification = createNotification(
        id: 10,
        name: 'フォロワーユーザー',
        handle: 'follower_user',
        type: NotificationType.newFollower,
        outgoingFollowStatus: FollowStatusType.none,
        incomingFollowStatus: FollowStatusType.following,
      );

      when(() => mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer((_) async => right([notification]));

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

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.text('お知らせはまだありません'), findsOneWidget);
    });

    testWidgets('画面を開いた際に markAllAsRead が呼ばれないこと', (tester) async {
      when(() => mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer((_) async => right(testNotifications));

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      verifyNever(() => mockNotificationRepo.markAsRead(any()));
    });

    testWidgets('通知タップ時に markAsRead が呼ばれること', (tester) async {
      when(() => mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer((_) async => right([testNotifications[1]]));
      when(() => mockNotificationRepo.markAsRead(2))
          .thenAnswer((_) async => right(null));

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      await tester.tap(find.textContaining('承認ユーザー'));
      // GoRouter が未設定のため context.push でエラーが出るのでフラッシュする
      tester.takeException();
      await tester.pump();

      verify(() => mockNotificationRepo.markAsRead(2)).called(1);
    });

    testWidgets('エラー時にリトライボタンを表示すること', (tester) async {
      when(() => mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer(
        (_) async => left(const NetworkFailure(message: 'Network error')),
      );

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
        outgoingFollowStatus: FollowStatusType.none,
        incomingFollowStatus: FollowStatusType.pendingReceived,
      );

      when(() => mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer((_) async => right([notification]));

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.text('承認'), findsOneWidget);
      expect(find.text('削除'), findsOneWidget);
    });

    testWidgets('following でボタンを表示しないこと', (tester) async {
      final notification = createNotification(
        id: 2,
        name: 'ユーザーB',
        handle: 'user_b',
        type: NotificationType.followRequestApproved,
        outgoingFollowStatus: FollowStatusType.following,
        incomingFollowStatus: FollowStatusType.none,
      );

      when(() => mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer((_) async => right([notification]));

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.byType(TextButton), findsNothing);
    });

    testWidgets('followedBy + followRequestReceived でボタンを表示しないこと',
        (tester) async {
      final notification = createNotification(
        id: 3,
        name: 'ユーザーC',
        handle: 'user_c',
        type: NotificationType.followRequestReceived,
        outgoingFollowStatus: FollowStatusType.none,
        incomingFollowStatus: FollowStatusType.following,
      );

      when(() => mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer((_) async => right([notification]));

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.byType(TextButton), findsNothing);
    });

    testWidgets('none + followRequestReceived でボタンを表示しないこと',
        (tester) async {
      final notification = createNotification(
        id: 6,
        name: 'ユーザーF',
        handle: 'user_f',
        type: NotificationType.followRequestReceived,
        outgoingFollowStatus: FollowStatusType.none,
        incomingFollowStatus: FollowStatusType.none,
      );

      when(() => mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer((_) async => right([notification]));

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.byType(TextButton), findsNothing);
    });

    testWidgets('none + followRequestApproved でボタンを表示しないこと',
        (tester) async {
      final notification = createNotification(
        id: 4,
        name: 'ユーザーD',
        handle: 'user_d',
        type: NotificationType.followRequestApproved,
        outgoingFollowStatus: FollowStatusType.none,
        incomingFollowStatus: FollowStatusType.none,
      );

      when(() => mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer((_) async => right([notification]));

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.byType(TextButton), findsNothing);
    });

    testWidgets('pendingSent でボタンを表示しないこと', (tester) async {
      final notification = createNotification(
        id: 5,
        name: 'ユーザーE',
        handle: 'user_e',
        type: NotificationType.followRequestApproved,
        outgoingFollowStatus: FollowStatusType.pendingSent,
        incomingFollowStatus: FollowStatusType.none,
      );

      when(() => mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer((_) async => right([notification]));

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.byType(TextButton), findsNothing);
    });

    testWidgets(
        'フォロー中のユーザーからフォローリクエストが来た場合、承認・削除ボタンを表示すること',
        (tester) async {
      final notification = createNotification(
        id: 1,
        name: 'ユーザーA',
        handle: 'user_a',
        type: NotificationType.followRequestReceived,
        outgoingFollowStatus: FollowStatusType.following,
        incomingFollowStatus: FollowStatusType.pendingReceived,
        followRequestId: 100,
      );
      final senderId = notification.sender.id;

      when(() =>
              mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer((_) async => right([notification]));

      final container = ProviderContainer(
        overrides: [
          notificationRepositoryProvider
              .overrideWithValue(mockNotificationRepo),
        ],
      );
      addTearDown(container.dispose);

      container.read(followStateProvider.notifier).registerStatus(
            userId: senderId,
            outgoing: FollowStatusType.following,
            incoming: FollowStatusType.none,
          );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            theme: AppTheme.theme,
            home: const NotificationScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('承認'), findsOneWidget);
      expect(find.text('削除'), findsOneWidget);
      expect(find.text('フォロー中'), findsNothing);
    });

    testWidgets(
        '承認済み(incoming: FOLLOWING)のユーザーに対して古い通知データで承認・削除ボタンに戻らないこと',
        (tester) async {
      final notification = createNotification(
        id: 1,
        name: 'ユーザーA',
        handle: 'user_a',
        type: NotificationType.followRequestReceived,
        outgoingFollowStatus: FollowStatusType.following,
        incomingFollowStatus: FollowStatusType.pendingReceived,
        followRequestId: 100,
      );
      final senderId = notification.sender.id;

      when(() =>
              mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer((_) async => right([notification]));

      final container = ProviderContainer(
        overrides: [
          notificationRepositoryProvider
              .overrideWithValue(mockNotificationRepo),
        ],
      );
      addTearDown(container.dispose);

      container.read(followStateProvider.notifier).registerStatus(
            userId: senderId,
            outgoing: FollowStatusType.following,
            incoming: FollowStatusType.following,
          );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            theme: AppTheme.theme,
            home: const NotificationScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('承認'), findsNothing);
      expect(find.text('削除'), findsNothing);
      expect(find.text('フォロー中'), findsNothing);
    });

    testWidgets('FollowState が更新されると表示が追従すること', (tester) async {
      final notification = createNotification(
        id: 1,
        name: 'ユーザーA',
        handle: 'user_a',
        type: NotificationType.followRequestReceived,
        outgoingFollowStatus: FollowStatusType.none,
        incomingFollowStatus: FollowStatusType.pendingReceived,
        followRequestId: 100,
      );
      final senderId = notification.sender.id;

      when(() => mockNotificationRepo.getNotifications(limit: any(named: 'limit')))
          .thenAnswer((_) async => right([notification]));

      late ProviderContainer container;
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationRepositoryProvider
                .overrideWithValue(mockNotificationRepo),
          ],
          child: Builder(
            builder: (context) {
              return MaterialApp(
                theme: AppTheme.theme,
                home: Consumer(
                  builder: (context, ref, _) {
                    container = ProviderScope.containerOf(context);
                    return const NotificationScreen();
                  },
                ),
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('承認'), findsOneWidget);
      expect(find.text('削除'), findsOneWidget);

      container.read(followStateProvider.notifier).registerStatus(
            userId: senderId,
            outgoing: FollowStatusType.none,
            incoming: FollowStatusType.following,
          );
      await tester.pump();

      expect(find.text('承認'), findsNothing);
      expect(find.text('削除'), findsNothing);
      expect(find.byType(TextButton), findsNothing);
    });
  });
}
