import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/core/widgets/empty_state.dart';
import 'package:shelfie/core/widgets/error_view.dart';
import 'package:shelfie/core/widgets/loading_indicator.dart';
import 'package:shelfie/features/book_search/application/book_search_notifier.dart';
import 'package:shelfie/features/book_search/application/book_search_state.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart';
import 'package:shelfie/features/book_search/presentation/search_screen.dart';
import 'package:shelfie/features/book_search/presentation/widgets/book_list_item.dart';
import 'package:shelfie/features/book_search/presentation/widgets/search_bar_widget.dart';

class MockBookSearchRepository extends Mock implements BookSearchRepository {}

void main() {
  late MockBookSearchRepository mockRepository;

  setUp(() {
    mockRepository = MockBookSearchRepository();
  });

  Widget buildSearchScreen({
    BookSearchState? initialState,
    Map<String, int> shelfState = const {},
  }) {
    return ProviderScope(
      overrides: [
        bookSearchRepositoryProvider.overrideWithValue(mockRepository),
        shelfStateProvider.overrideWith(() => _TestShelfState(shelfState)),
        if (initialState != null)
          bookSearchNotifierProvider.overrideWith(
            () => _TestBookSearchNotifier(initialState),
          ),
      ],
      child: MaterialApp(
        theme: AppTheme.dark(),
        home: const SearchScreen(),
      ),
    );
  }

  group('SearchScreen', () {
    group('検索バー', () {
      testWidgets('検索バーが表示される', (tester) async {
        await tester.pumpWidget(buildSearchScreen());

        expect(find.byType(SearchBarWidget), findsOneWidget);
      });

      testWidgets('検索バーにプレースホルダーが表示される', (tester) async {
        await tester.pumpWidget(buildSearchScreen());

        expect(find.text('書籍を検索...'), findsOneWidget);
      });

      testWidgets('ISBNスキャンボタンが表示される', (tester) async {
        await tester.pumpWidget(buildSearchScreen());

        expect(find.byIcon(Icons.qr_code_scanner), findsOneWidget);
      });
    });

    group('初期状態', () {
      testWidgets('初期状態では検索結果が表示されない', (tester) async {
        await tester.pumpWidget(
          buildSearchScreen(
            initialState: const BookSearchState.initial(),
          ),
        );

        expect(find.byType(BookListItem), findsNothing);
        expect(find.byType(LoadingIndicator), findsNothing);
        expect(find.byType(ErrorView), findsNothing);
      });
    });

    group('ローディング状態', () {
      testWidgets('ローディング中はインジケーターが表示される', (tester) async {
        await tester.pumpWidget(
          buildSearchScreen(
            initialState: const BookSearchState.loading(),
          ),
        );

        expect(find.byType(LoadingIndicator), findsOneWidget);
      });
    });

    group('検索結果表示', () {
      final testBooks = [
        const Book(
          id: '1',
          title: 'テスト本1',
          authors: ['著者A'],
          publisher: '出版社A',
          publishedDate: '2024',
          isbn: '9784000000001',
          coverImageUrl: 'https://example.com/cover1.jpg',
        ),
        const Book(
          id: '2',
          title: 'テスト本2',
          authors: ['著者B', '著者C'],
          publisher: '出版社B',
          publishedDate: '2023',
          isbn: '9784000000002',
          coverImageUrl: null,
        ),
      ];

      testWidgets('検索結果が一覧表示される', (tester) async {
        await tester.pumpWidget(
          buildSearchScreen(
            initialState: BookSearchState.success(
              books: testBooks,
              totalCount: 2,
              hasMore: false,
              currentQuery: 'テスト',
              currentOffset: 0,
            ),
          ),
        );

        expect(find.byType(BookListItem), findsNWidgets(2));
      });

      testWidgets('書籍のタイトルが表示される', (tester) async {
        await tester.pumpWidget(
          buildSearchScreen(
            initialState: BookSearchState.success(
              books: testBooks,
              totalCount: 2,
              hasMore: false,
              currentQuery: 'テスト',
              currentOffset: 0,
            ),
          ),
        );

        expect(find.text('テスト本1'), findsOneWidget);
        expect(find.text('テスト本2'), findsOneWidget);
      });

      testWidgets('書籍の著者名が表示される', (tester) async {
        await tester.pumpWidget(
          buildSearchScreen(
            initialState: BookSearchState.success(
              books: testBooks,
              totalCount: 2,
              hasMore: false,
              currentQuery: 'テスト',
              currentOffset: 0,
            ),
          ),
        );

        expect(find.text('著者A'), findsOneWidget);
        expect(find.text('著者B, 著者C'), findsOneWidget);
      });

      testWidgets('書籍の出版社と出版年が表示される', (tester) async {
        await tester.pumpWidget(
          buildSearchScreen(
            initialState: BookSearchState.success(
              books: testBooks,
              totalCount: 2,
              hasMore: false,
              currentQuery: 'テスト',
              currentOffset: 0,
            ),
          ),
        );

        expect(find.text('出版社A / 2024年'), findsOneWidget);
        expect(find.text('出版社B / 2023年'), findsOneWidget);
      });

      testWidgets('追加ボタンが表示される', (tester) async {
        await tester.pumpWidget(
          buildSearchScreen(
            initialState: BookSearchState.success(
              books: testBooks,
              totalCount: 2,
              hasMore: false,
              currentQuery: 'テスト',
              currentOffset: 0,
            ),
          ),
        );

        expect(find.byIcon(Icons.add_circle_outline), findsNWidgets(2));
      });
    });

    group('空状態', () {
      testWidgets('検索結果が0件の場合は空状態が表示される', (tester) async {
        await tester.pumpWidget(
          buildSearchScreen(
            initialState: const BookSearchState.empty(query: 'テスト'),
          ),
        );

        expect(find.byType(EmptyState), findsOneWidget);
        expect(find.text('検索結果がありません'), findsOneWidget);
      });
    });

    group('エラー状態', () {
      testWidgets('エラー発生時はエラーメッセージが表示される', (tester) async {
        await tester.pumpWidget(
          buildSearchScreen(
            initialState: const BookSearchState.error(
              failure: NetworkFailure(message: 'ネットワークエラー'),
            ),
          ),
        );

        expect(find.byType(ErrorView), findsOneWidget);
      });
    });

    group('追加読み込み', () {
      testWidgets('追加読み込み中はリストの下にローディングが表示される', (tester) async {
        final testBooks = [
          const Book(
            id: '1',
            title: 'テスト本1',
            authors: ['著者A'],
          ),
        ];

        await tester.pumpWidget(
          buildSearchScreen(
            initialState: BookSearchState.loadingMore(
              books: testBooks,
              totalCount: 10,
              currentQuery: 'テスト',
              currentOffset: 0,
            ),
          ),
        );

        expect(find.byType(BookListItem), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });
  });
}

class _TestBookSearchNotifier extends BookSearchNotifier {
  _TestBookSearchNotifier(this._initialState);

  final BookSearchState _initialState;

  @override
  BookSearchState build() => _initialState;
}

class _TestShelfState extends ShelfState {
  _TestShelfState(this._initialState);

  final Map<String, int> _initialState;

  @override
  Map<String, int> build() => _initialState;
}
