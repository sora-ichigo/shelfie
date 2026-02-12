import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/state/follow_version.dart';
import 'package:shelfie/features/notification/application/unread_notification_count.dart';
import 'package:shelfie/features/notification/data/notification_repository.dart';

class MockNotificationRepository extends Mock
    implements NotificationRepository {}

void main() {
  late ProviderContainer container;
  late MockNotificationRepository mockRepository;

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

  group('UnreadNotificationCount', () {
    group('initial state', () {
      test('should start with AsyncData(0)', () {
        final state = container.read(unreadNotificationCountProvider);
        expect(state, const AsyncData(0));
      });
    });

    group('refresh', () {
      test('should fetch unread count from repository', () async {
        when(() => mockRepository.getUnreadCount())
            .thenAnswer((_) async => right(5));

        final notifier =
            container.read(unreadNotificationCountProvider.notifier);
        await notifier.refresh();

        final state = container.read(unreadNotificationCountProvider);
        expect(state.value, 5);
      });

      test('should keep previous value on failure', () async {
        when(() => mockRepository.getUnreadCount())
            .thenAnswer((_) async => right(3));

        final notifier =
            container.read(unreadNotificationCountProvider.notifier);
        await notifier.refresh();

        when(() => mockRepository.getUnreadCount()).thenAnswer(
          (_) async => left(const NetworkFailure(message: 'error')),
        );

        await notifier.refresh();

        final state = container.read(unreadNotificationCountProvider);
        expect(state.value, 3);
      });
    });

    group('FollowVersion integration', () {
      test('should refresh when FollowVersion changes', () async {
        when(() => mockRepository.getUnreadCount())
            .thenAnswer((_) async => right(2));

        // Access the notifier to activate the provider
        container.read(unreadNotificationCountProvider);

        container.read(followVersionProvider.notifier).increment();
        await Future<void>.delayed(Duration.zero);

        verify(() => mockRepository.getUnreadCount()).called(1);
      });
    });

    group('reset', () {
      test('should reset count to 0', () async {
        when(() => mockRepository.getUnreadCount())
            .thenAnswer((_) async => right(5));

        final notifier =
            container.read(unreadNotificationCountProvider.notifier);
        await notifier.refresh();

        notifier.reset();

        final state = container.read(unreadNotificationCountProvider);
        expect(state.value, 0);
      });
    });
  });
}
