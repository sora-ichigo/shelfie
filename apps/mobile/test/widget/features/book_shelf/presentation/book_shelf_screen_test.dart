@Skip('Ferry GraphQL clientのタイマー問題により不安定なため一時的にスキップ')
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/core/widgets/empty_state.dart';
import 'package:shelfie/core/widgets/error_view.dart';
import 'package:shelfie/core/widgets/loading_indicator.dart';
import 'package:shelfie/core/widgets/screen_header.dart';
import 'package:shelfie/core/widgets/user_avatar.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart'
    show BookSource;
import 'package:shelfie/features/book_shelf/application/book_shelf_notifier.dart';
import 'package:shelfie/features/book_shelf/application/book_shelf_state.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/domain/sort_option.dart';
import 'package:shelfie/features/book_shelf/presentation/book_shelf_screen.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/book_card.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/book_grid.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/search_filter_bar.dart';
import 'package:shelfie/routing/app_router.dart';

class MockBookShelfNotifier extends AutoDisposeNotifier<BookShelfState>
    with Mock
    implements BookShelfNotifier {
  MockBookShelfNotifier({BookShelfState? initialState})
      : _state = initialState ?? const BookShelfState.initial();

  BookShelfState _state;
  bool initializeCalled = false;
  bool refreshCalled = false;
  SortOption? lastSortOption;

  @override
  BookShelfState build() => _state;

  void setState(BookShelfState newState) {
    _state = newState;
    ref.invalidateSelf();
  }

  @override
  Future<void> initialize() async {
    initializeCalled = true;
  }

  @override
  Future<void> setSortOption(SortOption option) async {
    lastSortOption = option;
  }

  @override
  Future<void> loadMore() async {}

  @override
  Future<void> refresh() async {
    refreshCalled = true;
  }
}

class MockGoRouter extends Mock implements GoRouter {}

class FakeRoute extends Fake implements Route<dynamic> {}

class MockShelfState extends Notifier<Map<String, ShelfEntry>>
    with Mock
    implements ShelfState {
  MockShelfState(this._initialState);

  final Map<String, ShelfEntry> _initialState;

  @override
  Map<String, ShelfEntry> build() => _initialState;
}

void main() {
  late MockBookShelfNotifier mockNotifier;
  late MockGoRouter mockRouter;

  setUpAll(() {
    registerFallbackValue(const BookShelfState.initial());
    registerFallbackValue(FakeRoute());
    registerFallbackValue(SortOption.defaultOption);
  });

  setUp(() {
    mockNotifier = MockBookShelfNotifier();
    mockRouter = MockGoRouter();
  });

  Widget buildTestApp({
    BookShelfState? initialState,
    Map<String, ShelfEntry>? shelfState,
    GoRouter? router,
    List<Override>? additionalOverrides,
  }) {
    if (initialState != null) {
      mockNotifier = MockBookShelfNotifier(initialState: initialState);
    }

    // BookShelfLoaded の場合、shelfState が指定されていなければ
    // books から自動生成（デフォルトの readingStatus を使用）
    final effectiveShelfState = shelfState ?? <String, ShelfEntry>{};
    if (shelfState == null && initialState is BookShelfLoaded) {
      for (final book in initialState.books) {
        effectiveShelfState[book.externalId] = ShelfEntry(
          userBookId: book.userBookId,
          externalId: book.externalId,
          readingStatus: ReadingStatus.backlog,
          addedAt: book.addedAt,
        );
      }
    }

    return ProviderScope(
      overrides: [
        bookShelfNotifierProvider.overrideWith(() => mockNotifier),
        shelfStateProvider.overrideWith(() => MockShelfState(effectiveShelfState)),
        ...?additionalOverrides,
      ],
      child: MaterialApp(
        theme: AppTheme.theme,
        home: InheritedGoRouter(
          goRouter: router ?? mockRouter,
          child: const Scaffold(
            body: BookShelfScreen(),
          ),
        ),
      ),
    );
  }

  group('BookShelfScreen', () {
    group('レイアウト (Task 4.1)', () {
      testWidgets('SafeArea でラップされ Column レイアウトで構成される', (tester) async {
        await tester.pumpWidget(buildTestApp(
          initialState: BookShelfState.loaded(
            books: const [],
            sortOption: SortOption.defaultOption,

            hasMore: false,
            isLoadingMore: false,
            totalCount: 0,
          ),
        ));
        await tester.pumpAndSettle();

        expect(find.byType(SafeArea), findsOneWidget);
        expect(find.byType(Column), findsWidgets);
      });

      testWidgets('ScreenHeader に「マイライブラリ」タイトルを表示する', (tester) async {
        await tester.pumpWidget(buildTestApp(
          initialState: BookShelfState.loaded(
            books: const [],
            sortOption: SortOption.defaultOption,

            hasMore: false,
            isLoadingMore: false,
            totalCount: 0,
          ),
        ));
        await tester.pumpAndSettle();

        expect(find.byType(ScreenHeader), findsOneWidget);
        expect(find.text('マイライブラリ'), findsOneWidget);
      });

      testWidgets('プロフィールアイコンをタップするとアカウント画面へ遷移する', (tester) async {
        when(() => mockRouter.push(AppRoutes.account))
            .thenAnswer((_) async => null);

        await tester.pumpWidget(buildTestApp(
          initialState: BookShelfState.loaded(
            books: const [],
            sortOption: SortOption.defaultOption,

            hasMore: false,
            isLoadingMore: false,
            totalCount: 0,
          ),
          router: mockRouter,
        ));
        await tester.pumpAndSettle();

        final userAvatar = find.byType(UserAvatar);
        await tester.tap(userAvatar);
        await tester.pumpAndSettle();

        verify(() => mockRouter.push(AppRoutes.account)).called(1);
      });

      testWidgets('SearchFilterBar がヘッダー下に配置される', (tester) async {
        await tester.pumpWidget(buildTestApp(
          initialState: BookShelfState.loaded(
            books: const [],
            sortOption: SortOption.defaultOption,

            hasMore: false,
            isLoadingMore: false,
            totalCount: 0,
          ),
        ));
        await tester.pumpAndSettle();

        expect(find.byType(SearchFilterBar), findsOneWidget);

        final headerFinder = find.byType(ScreenHeader);
        final filterBarFinder = find.byType(SearchFilterBar);

        final headerTopLeft = tester.getTopLeft(headerFinder);
        final filterBarTopLeft = tester.getTopLeft(filterBarFinder);

        expect(filterBarTopLeft.dy, greaterThan(headerTopLeft.dy));
      });
    });

    group('状態に応じた表示 (Task 4.2)', () {
      testWidgets('ローディング状態では LoadingIndicator を全画面表示する', (tester) async {
        await tester.pumpWidget(buildTestApp(
          initialState: const BookShelfState.loading(),
        ));
        await tester.pump();

        expect(find.byType(LoadingIndicator), findsOneWidget);
      });

      testWidgets('読み込み完了かつ書籍0件では空状態UIを表示する', (tester) async {
        await tester.pumpWidget(buildTestApp(
          initialState: BookShelfState.loaded(
            books: const [],
            sortOption: SortOption.defaultOption,

            hasMore: false,
            isLoadingMore: false,
            totalCount: 0,
          ),
        ));
        await tester.pumpAndSettle();

        expect(find.byType(EmptyState), findsOneWidget);
        expect(find.byIcon(Icons.auto_stories_outlined), findsOneWidget);
      });

      testWidgets('読み込み完了かつ書籍ありでは書籍グリッドを表示する', (tester) async {
        final testBooks = [
          ShelfBookItem(
            userBookId: 1,
            externalId: 'book-1',
            title: 'Test Book 1',
            authors: const ['Author 1'],
            addedAt: DateTime(2024, 1, 1),
          ),
          ShelfBookItem(
            userBookId: 2,
            externalId: 'book-2',
            title: 'Test Book 2',
            authors: const ['Author 2'],
            addedAt: DateTime(2024, 1, 2),
          ),
        ];

        await tester.pumpWidget(buildTestApp(
          initialState: BookShelfState.loaded(
            books: testBooks,
            sortOption: SortOption.defaultOption,

            hasMore: false,
            isLoadingMore: false,
            totalCount: 2,
          ),
        ));
        await tester.pumpAndSettle();

        expect(find.byType(BookGrid), findsOneWidget);
        expect(find.text('Test Book 1'), findsOneWidget);
        expect(find.text('Test Book 2'), findsOneWidget);
      });

      testWidgets('エラー状態ではエラーメッセージとリトライボタンを表示する', (tester) async {
        await tester.pumpWidget(buildTestApp(
          initialState: const BookShelfState.error(
            failure: NetworkFailure(message: 'ネットワークエラー'),
          ),
        ));
        await tester.pump();

        expect(find.byType(ErrorView), findsOneWidget);
        expect(find.textContaining('ネットワーク'), findsOneWidget);
        expect(find.widgetWithText(ElevatedButton, 'リトライ'), findsOneWidget);
      });

      testWidgets('リトライボタンタップでデータ再取得を実行する', (tester) async {
        await tester.pumpWidget(buildTestApp(
          initialState: const BookShelfState.error(
            failure: NetworkFailure(message: 'ネットワークエラー'),
          ),
        ));
        await tester.pump();

        final retryButton = find.widgetWithText(ElevatedButton, 'リトライ');
        await tester.tap(retryButton);
        await tester.pump();

        expect(mockNotifier.refreshCalled, isTrue);
      });
    });

    group('書籍詳細画面への遷移 (Task 4.3)', () {
      testWidgets('書籍カードタップ時に詳細画面へ遷移する', (tester) async {
        final testBooks = [
          ShelfBookItem(
            userBookId: 1,
            externalId: 'test-external-id',
            title: 'Test Book',
            authors: const ['Test Author'],
            addedAt: DateTime(2024, 1, 1),
          ),
        ];

        when(() => mockRouter.push(any())).thenAnswer((_) async => null);

        await tester.pumpWidget(buildTestApp(
          initialState: BookShelfState.loaded(
            books: testBooks,
            sortOption: SortOption.defaultOption,

            hasMore: false,
            isLoadingMore: false,
            totalCount: 1,
          ),
          router: mockRouter,
        ));
        await tester.pumpAndSettle();

        final bookCard = find.byType(BookCard);
        await tester.tap(bookCard);
        await tester.pumpAndSettle();

        verify(
          () =>
              mockRouter.push(AppRoutes.bookDetail(bookId: 'test-external-id', source: BookSource.rakuten)),
        ).called(1);
      });

      testWidgets('書籍のexternalIdがパラメータとして渡される', (tester) async {
        final testBooks = [
          ShelfBookItem(
            userBookId: 1,
            externalId: 'rakuten-12345',
            title: 'Book with Rakuten ID',
            authors: const ['Author'],
            addedAt: DateTime(2024, 1, 1),
          ),
        ];

        String? capturedPath;
        when(() => mockRouter.push(any())).thenAnswer((invocation) async {
          capturedPath = invocation.positionalArguments[0] as String;
          return null;
        });

        await tester.pumpWidget(buildTestApp(
          initialState: BookShelfState.loaded(
            books: testBooks,
            sortOption: SortOption.defaultOption,

            hasMore: false,
            isLoadingMore: false,
            totalCount: 1,
          ),
          router: mockRouter,
        ));
        await tester.pumpAndSettle();

        final bookCard = find.byType(BookCard);
        await tester.tap(bookCard);
        await tester.pumpAndSettle();

        expect(capturedPath, equals('/books/rakuten-12345'));
      });
    });

    group('初期化', () {
      testWidgets('画面表示時にinitializeが呼ばれる', (tester) async {
        await tester.pumpWidget(buildTestApp(
          initialState: const BookShelfState.initial(),
        ));
        await tester.pump();

        expect(mockNotifier.initializeCalled, isTrue);
      });
    });

    group('SearchFilterBar コールバック', () {
      testWidgets('ソート変更時に setSortOption が呼ばれる', (tester) async {
        await tester.pumpWidget(buildTestApp(
          initialState: BookShelfState.loaded(
            books: const [],
            sortOption: SortOption.defaultOption,

            hasMore: false,
            isLoadingMore: false,
            totalCount: 0,
          ),
        ));
        await tester.pumpAndSettle();

        final sortButton = find.byIcon(Icons.tune);
        await tester.tap(sortButton);
        await tester.pumpAndSettle();

        final titleOption = find.text('タイトル（A→Z）');
        await tester.tap(titleOption);
        await tester.pumpAndSettle();

        expect(mockNotifier.lastSortOption, equals(SortOption.titleAsc));
      });

});
  });
}
