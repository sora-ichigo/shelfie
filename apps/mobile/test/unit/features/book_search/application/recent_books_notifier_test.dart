import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/features/book_search/application/recent_books_notifier.dart';
import 'package:shelfie/features/book_search/data/recent_books_repository.dart';
import 'package:shelfie/features/book_search/domain/recent_book_entry.dart';

class MockRecentBooksRepository extends Mock implements RecentBooksRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      RecentBookEntry(
        bookId: 'fallback',
        title: 'Fallback Book',
        authors: ['Fallback Author'],
        viewedAt: DateTime.now(),
      ),
    );
  });

  group('RecentBooksNotifier', () {
    late MockRecentBooksRepository mockRepository;
    late ProviderContainer container;

    setUp(() {
      mockRepository = MockRecentBooksRepository();
      container = ProviderContainer(
        overrides: [
          recentBooksRepositoryProvider.overrideWithValue(mockRepository),
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
          RecentBookEntry(
            bookId: 'book-1',
            title: 'Flutter Complete Guide',
            authors: ['John Doe'],
            coverImageUrl: 'https://example.com/cover1.jpg',
            viewedAt: now,
          ),
          RecentBookEntry(
            bookId: 'book-2',
            title: 'Dart Programming',
            authors: ['Jane Doe'],
            viewedAt: now.subtract(const Duration(hours: 1)),
          ),
        ];

        when(() => mockRepository.getAll()).thenAnswer((_) async => entries);

        final state = await container.read(recentBooksNotifierProvider.future);

        expect(state.length, 2);
        expect(state[0].bookId, 'book-1');
        expect(state[1].bookId, 'book-2');
        verify(() => mockRepository.getAll()).called(1);
      });

      test('履歴が空の場合は空リストを返す', () async {
        when(() => mockRepository.getAll()).thenAnswer((_) async => []);

        final state = await container.read(recentBooksNotifierProvider.future);

        expect(state, isEmpty);
      });
    });

    group('addRecentBook', () {
      test('閲覧履歴を追加する', () async {
        when(() => mockRepository.getAll()).thenAnswer((_) async => []);
        when(() => mockRepository.add(any())).thenAnswer((_) async {});

        await container.read(recentBooksNotifierProvider.future);

        final notifier = container.read(recentBooksNotifierProvider.notifier);
        await notifier.addRecentBook(
          bookId: 'book-1',
          title: 'Flutter Book',
          authors: ['Author'],
          coverImageUrl: 'https://example.com/cover.jpg',
        );

        final captured = verify(() => mockRepository.add(captureAny()))
            .captured
            .first as RecentBookEntry;
        expect(captured.bookId, 'book-1');
        expect(captured.title, 'Flutter Book');
        expect(captured.authors, ['Author']);
        expect(captured.coverImageUrl, 'https://example.com/cover.jpg');
      });

      test('カバー画像URLがnullでも追加できる', () async {
        when(() => mockRepository.getAll()).thenAnswer((_) async => []);
        when(() => mockRepository.add(any())).thenAnswer((_) async {});

        await container.read(recentBooksNotifierProvider.future);

        final notifier = container.read(recentBooksNotifierProvider.notifier);
        await notifier.addRecentBook(
          bookId: 'book-1',
          title: 'Flutter Book',
          authors: ['Author'],
        );

        final captured = verify(() => mockRepository.add(captureAny()))
            .captured
            .first as RecentBookEntry;
        expect(captured.coverImageUrl, isNull);
      });

      test('空の書籍IDは追加しない', () async {
        when(() => mockRepository.getAll()).thenAnswer((_) async => []);

        await container.read(recentBooksNotifierProvider.future);

        final notifier = container.read(recentBooksNotifierProvider.notifier);
        await notifier.addRecentBook(
          bookId: '',
          title: 'Flutter Book',
          authors: ['Author'],
        );

        verifyNever(() => mockRepository.add(any()));
      });

      test('空のタイトルは追加しない', () async {
        when(() => mockRepository.getAll()).thenAnswer((_) async => []);

        await container.read(recentBooksNotifierProvider.future);

        final notifier = container.read(recentBooksNotifierProvider.notifier);
        await notifier.addRecentBook(
          bookId: 'book-1',
          title: '',
          authors: ['Author'],
        );

        verifyNever(() => mockRepository.add(any()));
      });

      test('空の著者リストは追加しない', () async {
        when(() => mockRepository.getAll()).thenAnswer((_) async => []);

        await container.read(recentBooksNotifierProvider.future);

        final notifier = container.read(recentBooksNotifierProvider.notifier);
        await notifier.addRecentBook(
          bookId: 'book-1',
          title: 'Flutter Book',
          authors: [],
        );

        verifyNever(() => mockRepository.add(any()));
      });

      test('履歴追加後に状態が更新される', () async {
        final now = DateTime.now();
        when(() => mockRepository.getAll()).thenAnswer((_) async => []);
        when(() => mockRepository.add(any())).thenAnswer((_) async {});

        await container.read(recentBooksNotifierProvider.future);

        final notifier = container.read(recentBooksNotifierProvider.notifier);

        when(() => mockRepository.getAll()).thenAnswer(
          (_) async => [
            RecentBookEntry(
              bookId: 'book-1',
              title: 'Flutter Book',
              authors: ['Author'],
              viewedAt: now,
            ),
          ],
        );

        await notifier.addRecentBook(
          bookId: 'book-1',
          title: 'Flutter Book',
          authors: ['Author'],
        );

        final state = await container.read(recentBooksNotifierProvider.future);
        expect(state.length, 1);
        expect(state.first.bookId, 'book-1');
      });
    });

    group('removeBook', () {
      test('指定した書籍IDの履歴を削除する', () async {
        final now = DateTime.now();
        when(() => mockRepository.getAll()).thenAnswer(
          (_) async => [
            RecentBookEntry(
              bookId: 'book-1',
              title: 'Flutter Book',
              authors: ['Author 1'],
              viewedAt: now,
            ),
            RecentBookEntry(
              bookId: 'book-2',
              title: 'Dart Book',
              authors: ['Author 2'],
              viewedAt: now.subtract(const Duration(hours: 1)),
            ),
          ],
        );
        when(() => mockRepository.remove(any())).thenAnswer((_) async {});

        await container.read(recentBooksNotifierProvider.future);

        final notifier = container.read(recentBooksNotifierProvider.notifier);

        when(() => mockRepository.getAll()).thenAnswer(
          (_) async => [
            RecentBookEntry(
              bookId: 'book-2',
              title: 'Dart Book',
              authors: ['Author 2'],
              viewedAt: now.subtract(const Duration(hours: 1)),
            ),
          ],
        );

        await notifier.removeBook('book-1');

        verify(() => mockRepository.remove('book-1')).called(1);

        final state = await container.read(recentBooksNotifierProvider.future);
        expect(state.length, 1);
        expect(state.first.bookId, 'book-2');
      });
    });

    group('clearAll', () {
      test('全履歴を削除する', () async {
        final now = DateTime.now();
        when(() => mockRepository.getAll()).thenAnswer(
          (_) async => [
            RecentBookEntry(
              bookId: 'book-1',
              title: 'Flutter Book',
              authors: ['Author 1'],
              viewedAt: now,
            ),
            RecentBookEntry(
              bookId: 'book-2',
              title: 'Dart Book',
              authors: ['Author 2'],
              viewedAt: now,
            ),
          ],
        );
        when(() => mockRepository.clear()).thenAnswer((_) async {});

        await container.read(recentBooksNotifierProvider.future);

        final notifier = container.read(recentBooksNotifierProvider.notifier);

        when(() => mockRepository.getAll()).thenAnswer((_) async => []);

        await notifier.clearAll();

        verify(() => mockRepository.clear()).called(1);

        final state = await container.read(recentBooksNotifierProvider.future);
        expect(state, isEmpty);
      });
    });
  });
}
