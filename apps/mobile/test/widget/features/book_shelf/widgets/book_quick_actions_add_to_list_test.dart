import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart' show ShelfState, shelfStateProvider;
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_list/data/book_list_repository.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/book_quick_actions_modal.dart';

class MockBookListRepository extends Mock implements BookListRepository {}

void main() {
  late MockBookListRepository mockBookListRepository;
  final now = DateTime(2024, 1, 15, 10, 30);

  BookListSummary createSummary({
    int id = 1,
    String title = 'Test List',
    String? description,
    int bookCount = 3,
    List<String> coverImages = const [],
  }) {
    return BookListSummary(
      id: id,
      title: title,
      description: description,
      bookCount: bookCount,
      coverImages: coverImages,
      createdAt: now,
      updatedAt: now,
    );
  }

  MyBookListsResult createMyBookListsResult({
    List<BookListSummary>? items,
    int totalCount = 1,
    bool hasMore = false,
  }) {
    return MyBookListsResult(
      items: items ?? [createSummary()],
      totalCount: totalCount,
      hasMore: hasMore,
    );
  }

  setUp(() {
    mockBookListRepository = MockBookListRepository();
  });

  ShelfBookItem createBook({
    int userBookId = 1,
    String externalId = 'test-external-id',
    String title = 'Test Book',
    List<String> authors = const ['Test Author'],
    String? coverImageUrl,
  }) {
    return ShelfBookItem(
      userBookId: userBookId,
      externalId: externalId,
      title: title,
      authors: authors,
      coverImageUrl: coverImageUrl,
      addedAt: now,
    );
  }

  ShelfEntry createShelfEntry({
    int userBookId = 1,
    String externalId = 'test-external-id',
    ReadingStatus readingStatus = ReadingStatus.backlog,
    int? rating,
    String? note,
  }) {
    return ShelfEntry(
      userBookId: userBookId,
      externalId: externalId,
      readingStatus: readingStatus,
      addedAt: now,
      rating: rating,
      note: note,
    );
  }

  Widget buildTestWidget({
    required ShelfBookItem book,
    required ShelfEntry shelfEntry,
    List<BookListSummary>? lists,
  }) {
    if (lists != null) {
      when(() => mockBookListRepository.getMyBookLists()).thenAnswer(
        (_) async => right(createMyBookListsResult(items: lists)),
      );
    }

    return ProviderScope(
      overrides: [
        bookListRepositoryProvider.overrideWithValue(mockBookListRepository),
        shelfStateProvider.overrideWith(ShelfState.new),
      ],
      child: MaterialApp(
        theme: AppTheme.dark(),
        home: Scaffold(
          body: Builder(
            builder: (context) => Consumer(
              builder: (context, ref, _) => ElevatedButton(
                onPressed: () {
                  showBookQuickActionsModal(
                    context: context,
                    ref: ref,
                    book: book,
                    shelfEntry: shelfEntry,
                  );
                },
                child: const Text('Show Modal'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  group('BookQuickActionsModal リストに追加アクション', () {
    testWidgets('「リストに追加」アクションが表示される', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        book: createBook(),
        shelfEntry: createShelfEntry(),
        lists: [createSummary()],
      ));
      await tester.pump();

      await tester.tap(find.text('Show Modal'));
      await tester.pumpAndSettle();

      expect(find.text('リストに追加'), findsOneWidget);
    });

    testWidgets('「リストに追加」をタップするとリスト選択モーダルが表示される', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        book: createBook(),
        shelfEntry: createShelfEntry(),
        lists: [createSummary(title: 'My Reading List')],
      ));
      await tester.pump();

      await tester.tap(find.text('Show Modal'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('リストに追加'));
      await tester.pumpAndSettle();

      expect(find.text('My Reading List'), findsOneWidget);
    });

  });
}
