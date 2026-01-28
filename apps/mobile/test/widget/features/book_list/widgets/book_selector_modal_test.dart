import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_list/data/book_list_repository.dart';
import 'package:shelfie/features/book_list/presentation/widgets/book_selector_modal.dart';
import 'package:shelfie/features/book_shelf/application/book_shelf_notifier.dart';
import 'package:shelfie/features/book_shelf/application/book_shelf_state.dart';
import 'package:shelfie/features/book_shelf/domain/group_option.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/domain/sort_option.dart';

class MockBookListRepository extends Mock implements BookListRepository {}

void main() {
  late MockBookListRepository mockRepository;
  final now = DateTime(2024, 1, 15, 10, 30);

  ShelfBookItem createBook({
    int userBookId = 1,
    String externalId = 'ext-1',
    String title = 'Test Book',
    List<String> authors = const ['Author'],
    String? coverImageUrl,
  }) {
    return ShelfBookItem(
      userBookId: userBookId,
      externalId: externalId,
      title: title,
      authors: authors,
      addedAt: now,
      coverImageUrl: coverImageUrl,
    );
  }

  setUp(() {
    mockRepository = MockBookListRepository();
  });

  Widget buildTestWidget({
    List<ShelfBookItem> books = const [],
    List<int> existingUserBookIds = const [],
    void Function(ShelfBookItem book)? onBookSelected,
  }) {
    return ProviderScope(
      overrides: [
        bookListRepositoryProvider.overrideWithValue(mockRepository),
        bookShelfNotifierProvider.overrideWith(() => _MockBookShelfNotifier(books)),
      ],
      child: MaterialApp(
        theme: AppTheme.dark(),
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                showBookSelectorModal(
                  context: context,
                  existingUserBookIds: existingUserBookIds,
                  onBookSelected: onBookSelected ?? (_) {},
                );
              },
              child: const Text('Show Modal'),
            ),
          ),
        ),
      ),
    );
  }

  group('BookSelectorModal', () {
    group('structure', () {
      testWidgets('displays modal title', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          books: [createBook()],
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        expect(find.text('本を追加'), findsOneWidget);
      });

      testWidgets('displays search field', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          books: [createBook()],
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        expect(find.byType(TextField), findsOneWidget);
      });
    });

    group('book list', () {
      testWidgets('displays books from shelf', (tester) async {
        final books = [
          createBook(userBookId: 1, title: 'Book One'),
          createBook(userBookId: 2, title: 'Book Two'),
        ];

        await tester.pumpWidget(buildTestWidget(
          books: books,
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        expect(find.text('Book One'), findsOneWidget);
        expect(find.text('Book Two'), findsOneWidget);
      });

      testWidgets('hides books already in the list', (tester) async {
        final books = [
          createBook(userBookId: 1, title: 'Book One'),
          createBook(userBookId: 2, title: 'Book Two'),
        ];

        await tester.pumpWidget(buildTestWidget(
          books: books,
          existingUserBookIds: [1],
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        expect(find.text('Book One'), findsNothing);
        expect(find.text('Book Two'), findsOneWidget);
      });

      testWidgets('displays empty state when no books available',
          (tester) async {
        await tester.pumpWidget(buildTestWidget(
          books: [],
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        expect(find.textContaining('本が見つかりません'), findsOneWidget);
      });
    });

    group('search', () {
      testWidgets('filters books by search query', (tester) async {
        final books = [
          createBook(userBookId: 1, title: 'Flutter Guide'),
          createBook(userBookId: 2, title: 'Dart Basics'),
        ];

        await tester.pumpWidget(buildTestWidget(
          books: books,
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextField), 'Flutter');
        await tester.pumpAndSettle();

        expect(find.text('Flutter Guide'), findsOneWidget);
        expect(find.text('Dart Basics'), findsNothing);
      });
    });

    group('selection', () {
      testWidgets('calls onBookSelected when book is tapped', (tester) async {
        ShelfBookItem? selectedBook;
        final books = [createBook(userBookId: 10, title: 'Test Book')];

        await tester.pumpWidget(buildTestWidget(
          books: books,
          onBookSelected: (book) => selectedBook = book,
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Test Book'));
        await tester.pumpAndSettle();

        expect(selectedBook?.userBookId, equals(10));
      });

      testWidgets('closes modal after selection', (tester) async {
        final books = [createBook(userBookId: 10, title: 'Test Book')];

        await tester.pumpWidget(buildTestWidget(
          books: books,
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        expect(find.text('本を追加'), findsOneWidget);

        await tester.tap(find.text('Test Book'));
        await tester.pumpAndSettle();

        expect(find.text('本を追加'), findsNothing);
      });
    });
  });
}

class _MockBookShelfNotifier extends BookShelfNotifier {
  _MockBookShelfNotifier(this._books);

  final List<ShelfBookItem> _books;

  @override
  BookShelfState build() {
    return BookShelfState.loaded(
      books: _books,
      sortOption: SortOption.defaultOption,
      groupOption: GroupOption.defaultOption,
      totalCount: _books.length,
      hasMore: false,
      isLoadingMore: false,
      groupedBooks: const {},
    );
  }

  @override
  Future<void> initialize() async {}
}
