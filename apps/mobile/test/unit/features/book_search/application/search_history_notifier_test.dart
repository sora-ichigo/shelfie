import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/features/book_search/application/search_history_notifier.dart';
import 'package:shelfie/features/book_search/data/search_history_repository.dart';
import 'package:shelfie/features/book_search/domain/search_history_entry.dart';

class MockSearchHistoryRepository extends Mock
    implements SearchHistoryRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      SearchHistoryEntry(query: 'fallback', searchedAt: DateTime.now()),
    );
  });

  group('SearchHistoryNotifier', () {
    late MockSearchHistoryRepository mockRepository;
    late ProviderContainer container;

    setUp(() {
      mockRepository = MockSearchHistoryRepository();
      container = ProviderContainer(
        overrides: [
          searchHistoryRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    group('build', () {
      test('初期化時にリポジトリから全履歴を取得する', () async {
        final now = DateTime.now();
        final entries = [
          SearchHistoryEntry(query: 'flutter', searchedAt: now),
          SearchHistoryEntry(
            query: 'dart',
            searchedAt: now.subtract(const Duration(hours: 1)),
          ),
        ];

        when(() => mockRepository.getAll()).thenAnswer((_) async => entries);

        final state = await container.read(searchHistoryNotifierProvider.future);

        expect(state.length, 2);
        expect(state[0].query, 'flutter');
        expect(state[1].query, 'dart');
        verify(() => mockRepository.getAll()).called(1);
      });

      test('履歴が空の場合は空リストを返す', () async {
        when(() => mockRepository.getAll()).thenAnswer((_) async => []);

        final state = await container.read(searchHistoryNotifierProvider.future);

        expect(state, isEmpty);
      });
    });

    group('addHistory', () {
      test('検索クエリを履歴に追加する', () async {
        when(() => mockRepository.getAll()).thenAnswer((_) async => []);
        when(() => mockRepository.add(any())).thenAnswer((_) async {});

        await container.read(searchHistoryNotifierProvider.future);

        final notifier = container.read(searchHistoryNotifierProvider.notifier);
        await notifier.addHistory('flutter');

        final captured = verify(() => mockRepository.add(captureAny()))
            .captured
            .first as SearchHistoryEntry;
        expect(captured.query, 'flutter');
      });

      test('空文字クエリは追加しない', () async {
        when(() => mockRepository.getAll()).thenAnswer((_) async => []);

        await container.read(searchHistoryNotifierProvider.future);

        final notifier = container.read(searchHistoryNotifierProvider.notifier);
        await notifier.addHistory('');

        verifyNever(() => mockRepository.add(any()));
      });

      test('空白のみのクエリは追加しない', () async {
        when(() => mockRepository.getAll()).thenAnswer((_) async => []);

        await container.read(searchHistoryNotifierProvider.future);

        final notifier = container.read(searchHistoryNotifierProvider.notifier);
        await notifier.addHistory('   ');

        verifyNever(() => mockRepository.add(any()));
      });

      test('履歴追加後に状態が更新される', () async {
        final now = DateTime.now();
        when(() => mockRepository.getAll()).thenAnswer((_) async => []);
        when(() => mockRepository.add(any())).thenAnswer((_) async {});

        await container.read(searchHistoryNotifierProvider.future);

        final notifier = container.read(searchHistoryNotifierProvider.notifier);

        when(() => mockRepository.getAll()).thenAnswer(
          (_) async => [SearchHistoryEntry(query: 'flutter', searchedAt: now)],
        );

        await notifier.addHistory('flutter');

        final state = await container.read(searchHistoryNotifierProvider.future);
        expect(state.length, 1);
        expect(state.first.query, 'flutter');
      });
    });

    group('removeHistory', () {
      test('指定したクエリの履歴を削除する', () async {
        final now = DateTime.now();
        when(() => mockRepository.getAll()).thenAnswer(
          (_) async => [
            SearchHistoryEntry(query: 'flutter', searchedAt: now),
            SearchHistoryEntry(
              query: 'dart',
              searchedAt: now.subtract(const Duration(hours: 1)),
            ),
          ],
        );
        when(() => mockRepository.remove(any())).thenAnswer((_) async {});

        await container.read(searchHistoryNotifierProvider.future);

        final notifier = container.read(searchHistoryNotifierProvider.notifier);

        when(() => mockRepository.getAll()).thenAnswer(
          (_) async => [
            SearchHistoryEntry(
              query: 'dart',
              searchedAt: now.subtract(const Duration(hours: 1)),
            ),
          ],
        );

        await notifier.removeHistory('flutter');

        verify(() => mockRepository.remove('flutter')).called(1);

        final state = await container.read(searchHistoryNotifierProvider.future);
        expect(state.length, 1);
        expect(state.first.query, 'dart');
      });
    });

    group('clearAll', () {
      test('全履歴を削除する', () async {
        final now = DateTime.now();
        when(() => mockRepository.getAll()).thenAnswer(
          (_) async => [
            SearchHistoryEntry(query: 'flutter', searchedAt: now),
            SearchHistoryEntry(query: 'dart', searchedAt: now),
          ],
        );
        when(() => mockRepository.clear()).thenAnswer((_) async {});

        await container.read(searchHistoryNotifierProvider.future);

        final notifier = container.read(searchHistoryNotifierProvider.notifier);

        when(() => mockRepository.getAll()).thenAnswer((_) async => []);

        await notifier.clearAll();

        verify(() => mockRepository.clear()).called(1);

        final state = await container.read(searchHistoryNotifierProvider.future);
        expect(state, isEmpty);
      });
    });

    group('getFilteredHistory', () {
      test('クエリに部分一致する履歴を返す', () async {
        final now = DateTime.now();
        when(() => mockRepository.getAll()).thenAnswer(
          (_) async => [
            SearchHistoryEntry(query: 'flutter', searchedAt: now),
            SearchHistoryEntry(
              query: 'flutter_riverpod',
              searchedAt: now.subtract(const Duration(hours: 1)),
            ),
            SearchHistoryEntry(
              query: 'dart',
              searchedAt: now.subtract(const Duration(hours: 2)),
            ),
          ],
        );

        await container.read(searchHistoryNotifierProvider.future);

        final notifier = container.read(searchHistoryNotifierProvider.notifier);
        final filtered = notifier.getFilteredHistory('flutter');

        expect(filtered.length, 2);
        expect(filtered[0].query, 'flutter');
        expect(filtered[1].query, 'flutter_riverpod');
      });

      test('大文字小文字を区別せずにフィルタリングする', () async {
        final now = DateTime.now();
        when(() => mockRepository.getAll()).thenAnswer(
          (_) async => [
            SearchHistoryEntry(query: 'Flutter', searchedAt: now),
            SearchHistoryEntry(
              query: 'FLUTTER',
              searchedAt: now.subtract(const Duration(hours: 1)),
            ),
            SearchHistoryEntry(
              query: 'dart',
              searchedAt: now.subtract(const Duration(hours: 2)),
            ),
          ],
        );

        await container.read(searchHistoryNotifierProvider.future);

        final notifier = container.read(searchHistoryNotifierProvider.notifier);
        final filtered = notifier.getFilteredHistory('flutter');

        expect(filtered.length, 2);
      });

      test('空クエリの場合は全履歴を返す', () async {
        final now = DateTime.now();
        when(() => mockRepository.getAll()).thenAnswer(
          (_) async => [
            SearchHistoryEntry(query: 'flutter', searchedAt: now),
            SearchHistoryEntry(query: 'dart', searchedAt: now),
          ],
        );

        await container.read(searchHistoryNotifierProvider.future);

        final notifier = container.read(searchHistoryNotifierProvider.notifier);
        final filtered = notifier.getFilteredHistory('');

        expect(filtered.length, 2);
      });

      test('一致する履歴がない場合は空リストを返す', () async {
        final now = DateTime.now();
        when(() => mockRepository.getAll()).thenAnswer(
          (_) async => [
            SearchHistoryEntry(query: 'flutter', searchedAt: now),
            SearchHistoryEntry(query: 'dart', searchedAt: now),
          ],
        );

        await container.read(searchHistoryNotifierProvider.future);

        final notifier = container.read(searchHistoryNotifierProvider.notifier);
        final filtered = notifier.getFilteredHistory('python');

        expect(filtered, isEmpty);
      });

      test('フィルタ結果も新しい順でソートされている', () async {
        final now = DateTime.now();
        when(() => mockRepository.getAll()).thenAnswer(
          (_) async => [
            SearchHistoryEntry(query: 'flutter latest', searchedAt: now),
            SearchHistoryEntry(
              query: 'flutter advanced',
              searchedAt: now.subtract(const Duration(hours: 1)),
            ),
            SearchHistoryEntry(
              query: 'flutter basics',
              searchedAt: now.subtract(const Duration(hours: 2)),
            ),
          ],
        );

        await container.read(searchHistoryNotifierProvider.future);

        final notifier = container.read(searchHistoryNotifierProvider.notifier);
        final filtered = notifier.getFilteredHistory('flutter');

        expect(filtered.length, 3);
        expect(filtered[0].query, 'flutter latest');
        expect(filtered[1].query, 'flutter advanced');
        expect(filtered[2].query, 'flutter basics');
      });
    });
  });
}
