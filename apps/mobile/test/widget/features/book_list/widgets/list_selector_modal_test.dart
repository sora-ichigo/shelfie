import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_list/application/book_list_notifier.dart';
import 'package:shelfie/features/book_list/application/book_list_state.dart';
import 'package:shelfie/features/book_list/data/book_list_repository.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';
import 'package:shelfie/features/book_list/presentation/widgets/list_selector_modal.dart';

class MockBookListRepository extends Mock implements BookListRepository {}

void main() {
  late MockBookListRepository mockRepository;
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

  BookListItem createItem({
    int id = 1,
    int position = 0,
  }) {
    return BookListItem(
      id: id,
      position: position,
      addedAt: now,
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
    mockRepository = MockBookListRepository();
  });

  Widget buildTestWidget({
    required int userBookId,
    void Function(int listId)? onListSelected,
    List<BookListSummary>? lists,
  }) {
    if (lists != null) {
      when(() => mockRepository.getMyBookLists()).thenAnswer(
        (_) async => right(createMyBookListsResult(items: lists)),
      );
    }

    return ProviderScope(
      overrides: [
        bookListRepositoryProvider.overrideWithValue(mockRepository),
      ],
      child: MaterialApp(
        theme: AppTheme.dark(),
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                showListSelectorModal(
                  context: context,
                  userBookId: userBookId,
                  onListSelected: onListSelected ?? (_) {},
                );
              },
              child: const Text('Show Modal'),
            ),
          ),
        ),
      ),
    );
  }

  group('ListSelectorModal', () {
    group('structure', () {
      testWidgets('displays modal title', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          userBookId: 1,
          lists: [createSummary()],
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        expect(find.text('リストに追加'), findsOneWidget);
      });

      testWidgets('displays create new list button', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          userBookId: 1,
          lists: [createSummary()],
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        expect(find.text('新しいリストを作成'), findsOneWidget);
      });
    });

    group('list display', () {
      testWidgets('displays available lists', (tester) async {
        final lists = [
          createSummary(id: 1, title: 'Favorites'),
          createSummary(id: 2, title: 'To Read'),
        ];

        await tester.pumpWidget(buildTestWidget(
          userBookId: 1,
          lists: lists,
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        expect(find.text('Favorites'), findsOneWidget);
        expect(find.text('To Read'), findsOneWidget);
      });

      testWidgets('displays book count for each list', (tester) async {
        final lists = [
          createSummary(id: 1, title: 'My List', bookCount: 5),
        ];

        await tester.pumpWidget(buildTestWidget(
          userBookId: 1,
          lists: lists,
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        expect(find.textContaining('5冊'), findsOneWidget);
      });

      testWidgets('displays empty state when no lists', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          userBookId: 1,
          lists: [],
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        expect(find.textContaining('リストがありません'), findsOneWidget);
      });
    });

    group('loading state', () {
      testWidgets('displays loading indicator while loading', (tester) async {
        when(() => mockRepository.getMyBookLists()).thenAnswer((_) async {
          await Future.delayed(const Duration(milliseconds: 500));
          return right(createMyBookListsResult());
        });

        await tester.pumpWidget(buildTestWidget(
          userBookId: 1,
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        await tester.pumpAndSettle();
      });
    });

    group('selection', () {
      testWidgets('calls onListSelected when list is tapped', (tester) async {
        int? selectedListId;
        final lists = [createSummary(id: 10, title: 'My List')];

        await tester.pumpWidget(buildTestWidget(
          userBookId: 1,
          lists: lists,
          onListSelected: (id) => selectedListId = id,
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('My List'));
        await tester.pumpAndSettle();

        expect(selectedListId, equals(10));
      });

      testWidgets('closes modal after selection', (tester) async {
        final lists = [createSummary(id: 10, title: 'My List')];

        await tester.pumpWidget(buildTestWidget(
          userBookId: 1,
          lists: lists,
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        expect(find.text('リストに追加'), findsOneWidget);

        await tester.tap(find.text('My List'));
        await tester.pumpAndSettle();

        expect(find.text('リストに追加'), findsNothing);
      });
    });
  });
}
