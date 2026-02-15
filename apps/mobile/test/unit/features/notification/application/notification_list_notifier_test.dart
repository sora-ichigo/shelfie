import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/features/follow/domain/follow_status_type.dart';
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
      outgoingFollowStatus: FollowStatusType.none,
      incomingFollowStatus: FollowStatusType.pendingReceived,
      followRequestId: null,
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

    group('removeNotification', () {
      test('should remove notification by id from the list', () async {
        final notifications = [
          createNotification(id: 1),
          createNotification(id: 2),
          createNotification(id: 3),
        ];
        when(() => mockRepository.getNotifications(limit: 20))
            .thenAnswer((_) async => right(notifications));

        final notifier =
            container.read(notificationListNotifierProvider.notifier);
        await notifier.loadInitial();

        notifier.removeNotification(2);

        final state = container.read(notificationListNotifierProvider);
        expect(state.value, hasLength(2));
        expect(state.value!.map((n) => n.id), containsAll([1, 3]));
        expect(state.value!.map((n) => n.id), isNot(contains(2)));
      });

      test('should do nothing when notification id not found', () async {
        final notifications = [
          createNotification(id: 1),
        ];
        when(() => mockRepository.getNotifications(limit: 20))
            .thenAnswer((_) async => right(notifications));

        final notifier =
            container.read(notificationListNotifierProvider.notifier);
        await notifier.loadInitial();

        notifier.removeNotification(999);

        final state = container.read(notificationListNotifierProvider);
        expect(state.value, hasLength(1));
      });
    });

    group('markAsReadById', () {
      test('should call markAsRead on repository with notificationId',
          () async {
        when(() => mockRepository.getNotifications(limit: 20))
            .thenAnswer((_) async => right([createNotification(id: 1)]));
        when(() => mockRepository.markAsRead(1))
            .thenAnswer((_) async => right(null));

        final notifier =
            container.read(notificationListNotifierProvider.notifier);
        await notifier.loadInitial();
        await notifier.markAsReadById(1);

        verify(() => mockRepository.markAsRead(1)).called(1);
      });

      test('should update local state to isRead=true', () async {
        when(() => mockRepository.getNotifications(limit: 20))
            .thenAnswer((_) async => right([
                  createNotification(id: 1, isRead: false),
                  createNotification(id: 2, isRead: false),
                ]));
        when(() => mockRepository.markAsRead(1))
            .thenAnswer((_) async => right(null));

        final notifier =
            container.read(notificationListNotifierProvider.notifier);
        await notifier.loadInitial();
        await notifier.markAsReadById(1);

        final state = container.read(notificationListNotifierProvider);
        final notification = state.value!.firstWhere((n) => n.id == 1);
        expect(notification.isRead, isTrue);

        final other = state.value!.firstWhere((n) => n.id == 2);
        expect(other.isRead, isFalse);
      });

      test('should not update state when notification is already read',
          () async {
        when(() => mockRepository.getNotifications(limit: 20))
            .thenAnswer((_) async => right([
                  createNotification(id: 1, isRead: true),
                ]));
        when(() => mockRepository.markAsRead(1))
            .thenAnswer((_) async => right(null));

        final notifier =
            container.read(notificationListNotifierProvider.notifier);
        await notifier.loadInitial();

        final stateBefore = container.read(notificationListNotifierProvider);
        await notifier.markAsReadById(1);
        final stateAfter = container.read(notificationListNotifierProvider);

        expect(identical(stateBefore, stateAfter), isTrue);
        verify(() => mockRepository.markAsRead(1)).called(1);
      });

      test('should still call API when notification id not found in local state',
          () async {
        when(() => mockRepository.getNotifications(limit: 20))
            .thenAnswer((_) async => right([createNotification(id: 1)]));
        when(() => mockRepository.markAsRead(999))
            .thenAnswer((_) async => right(null));

        final notifier =
            container.read(notificationListNotifierProvider.notifier);
        await notifier.loadInitial();
        await notifier.markAsReadById(999);

        verify(() => mockRepository.markAsRead(999)).called(1);
      });
    });
  });
}
