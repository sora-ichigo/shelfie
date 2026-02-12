import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/features/follow/domain/user_summary.dart';
import 'package:shelfie/features/notification/application/notification_list_notifier.dart';
import 'package:shelfie/features/notification/data/notification_repository.dart';
import 'package:shelfie/features/notification/domain/notification_model.dart';
import 'package:shelfie/features/notification/domain/notification_type.dart';

class MockNotificationRepository extends Mock
    implements NotificationRepository {}

void main() {
  late ProviderContainer container;
  late MockNotificationRepository mockRepository;

  NotificationModel createNotification({required int id, bool isRead = false}) {
    return NotificationModel(
      id: id,
      sender: UserSummary(
        id: id * 10,
        name: 'User $id',
        avatarUrl: null,
        handle: 'user$id',
      ),
      type: NotificationType.followRequestReceived,
      isRead: isRead,
      createdAt: DateTime(2024, 1, id),
    );
  }

  setUp(() {
    mockRepository = MockNotificationRepository();
    container = ProviderContainer(
      overrides: [
        notificationRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('NotificationListNotifier', () {
    group('loadInitial', () {
      test('should load notifications', () async {
        final notifications = [
          createNotification(id: 1),
          createNotification(id: 2),
        ];
        when(() => mockRepository.getNotifications(limit: 20))
            .thenAnswer((_) async => right(notifications));

        final notifier =
            container.read(notificationListNotifierProvider.notifier);
        await notifier.loadInitial();

        final state = container.read(notificationListNotifierProvider);
        expect(state.value, hasLength(2));
      });

      test('should set hasMore to true when page is full', () async {
        final notifications =
            List.generate(20, (i) => createNotification(id: i + 1));
        when(() => mockRepository.getNotifications(limit: 20))
            .thenAnswer((_) async => right(notifications));

        final notifier =
            container.read(notificationListNotifierProvider.notifier);
        await notifier.loadInitial();

        expect(notifier.hasMore, isTrue);
      });

      test('should set hasMore to false when page is not full', () async {
        final notifications = [createNotification(id: 1)];
        when(() => mockRepository.getNotifications(limit: 20))
            .thenAnswer((_) async => right(notifications));

        final notifier =
            container.read(notificationListNotifierProvider.notifier);
        await notifier.loadInitial();

        expect(notifier.hasMore, isFalse);
      });

      test('should set error state on failure', () async {
        when(() => mockRepository.getNotifications(limit: 20)).thenAnswer(
          (_) async => left(const NetworkFailure(message: 'error')),
        );

        final notifier =
            container.read(notificationListNotifierProvider.notifier);
        await notifier.loadInitial();

        final state = container.read(notificationListNotifierProvider);
        expect(state.hasError, isTrue);
      });
    });

    group('loadMore', () {
      test('should append items to list', () async {
        final page1 =
            List.generate(20, (i) => createNotification(id: i + 1));
        final page2 = [createNotification(id: 21)];

        when(() => mockRepository.getNotifications(limit: 20))
            .thenAnswer((_) async => right(page1));
        when(() => mockRepository.getNotifications(cursor: 20, limit: 20))
            .thenAnswer((_) async => right(page2));

        final notifier =
            container.read(notificationListNotifierProvider.notifier);
        await notifier.loadInitial();
        await notifier.loadMore();

        final state = container.read(notificationListNotifierProvider);
        expect(state.value, hasLength(21));
      });

      test('should not load when hasMore is false', () async {
        final notifications = [createNotification(id: 1)];
        when(() => mockRepository.getNotifications(limit: 20))
            .thenAnswer((_) async => right(notifications));

        final notifier =
            container.read(notificationListNotifierProvider.notifier);
        await notifier.loadInitial();
        clearInteractions(mockRepository);

        await notifier.loadMore();

        verifyNever(
          () => mockRepository.getNotifications(
            cursor: any(named: 'cursor'),
            limit: any(named: 'limit'),
          ),
        );
      });
    });

    group('markAsRead', () {
      test('should call markAllAsRead on repository', () async {
        when(() => mockRepository.getNotifications(limit: 20))
            .thenAnswer((_) async => right([createNotification(id: 1)]));
        when(() => mockRepository.markAllAsRead())
            .thenAnswer((_) async => right(null));

        final notifier =
            container.read(notificationListNotifierProvider.notifier);
        await notifier.loadInitial();
        await notifier.markAsRead();

        verify(() => mockRepository.markAllAsRead()).called(1);
      });

      test('should only call markAllAsRead once per session', () async {
        when(() => mockRepository.getNotifications(limit: 20))
            .thenAnswer((_) async => right([createNotification(id: 1)]));
        when(() => mockRepository.markAllAsRead())
            .thenAnswer((_) async => right(null));

        final notifier =
            container.read(notificationListNotifierProvider.notifier);
        await notifier.loadInitial();
        await notifier.markAsRead();
        await notifier.markAsRead();

        verify(() => mockRepository.markAllAsRead()).called(1);
      });
    });
  });
}
