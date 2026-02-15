import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/features/account/application/reading_status_counts_notifier.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_shelf/data/book_shelf_repository.dart';

class MockBookShelfRepository extends Mock implements BookShelfRepository {}

void main() {
  late MockBookShelfRepository mockRepository;

  setUp(() {
    mockRepository = MockBookShelfRepository();
  });

  setUpAll(() {
    registerFallbackValue(GReadingStatus.READING);
    registerFallbackValue(GShelfSortField.ADDED_AT);
    registerFallbackValue(GSortOrder.DESC);
  });

  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [
        bookShelfRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  void stubGetMyShelfCounts(Map<GReadingStatus, int> counts) {
    when(
      () => mockRepository.getMyShelf(
        readingStatus: any(named: 'readingStatus'),
        sortBy: any(named: 'sortBy'),
        sortOrder: any(named: 'sortOrder'),
        limit: any(named: 'limit'),
        offset: any(named: 'offset'),
      ),
    ).thenAnswer((invocation) async {
      final status =
          invocation.namedArguments[#readingStatus] as GReadingStatus?;
      final count = status != null ? (counts[status] ?? 0) : 0;
      return right(
        MyShelfResult(
          items: [],
          entries: {},
          totalCount: count,
          hasMore: false,
        ),
      );
    });
  }

  group('ReadingStatusCountsNotifier', () {
    test('読書状態変更時にカウントが楽観的に更新される', () async {
      stubGetMyShelfCounts({
        GReadingStatus.READING: 3,
        GReadingStatus.BACKLOG: 2,
        GReadingStatus.COMPLETED: 1,
        GReadingStatus.INTERESTED: 0,
      });

      final container = createContainer();

      container.listen(
        readingStatusCountsNotifierProvider,
        (_, __) {},
        fireImmediately: true,
      );
      await Future<void>.delayed(Duration.zero);

      final initialCounts =
          container.read(readingStatusCountsNotifierProvider);
      expect(initialCounts[ReadingStatus.reading], 3);
      expect(initialCounts[ReadingStatus.completed], 1);

      // shelfStateProvider にエントリを登録
      final shelfNotifier = container.read(shelfStateProvider.notifier);
      shelfNotifier.registerEntry(
        ShelfEntry(
          userBookId: 1,
          externalId: 'book-1',
          readingStatus: ReadingStatus.reading,
          addedAt: DateTime(2024, 1, 1),
        ),
      );

      // 読書状態を reading → completed に変更
      shelfNotifier.updateReadingStatus(
        externalId: 'book-1',
        status: ReadingStatus.completed,
      );

      // カウントが楽観的に更新されていることを確認
      final updatedCounts =
          container.read(readingStatusCountsNotifierProvider);
      expect(updatedCounts[ReadingStatus.reading], 2);
      expect(updatedCounts[ReadingStatus.completed], 2);

      await Future<void>.delayed(Duration.zero);
    });
  });
}
