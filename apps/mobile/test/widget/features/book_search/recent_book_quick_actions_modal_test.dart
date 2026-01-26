import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_search/domain/recent_book_entry.dart';
import 'package:shelfie/features/book_search/presentation/widgets/recent_book_quick_actions_modal.dart';

void main() {
  group('RecentBookQuickActionsModal', () {
    final testBook = RecentBookEntry(
      bookId: 'book1',
      title: 'Test Book',
      authors: const ['Test Author'],
      coverImageUrl: 'https://example.com/cover.jpg',
      viewedAt: DateTime(2026, 1, 25, 10, 0),
    );

    final testShelfEntry = ShelfEntry(
      userBookId: 1,
      externalId: 'book1',
      readingStatus: ReadingStatus.backlog,
      addedAt: DateTime(2026, 1, 20),
    );

    Widget buildTestWidget({
      required RecentBookEntry book,
      Map<String, ShelfEntry> shelfState = const {},
      void Function()? onAddToShelf,
      void Function()? onRemoveFromShelf,
    }) {
      return ProviderScope(
        overrides: [
          shelfStateProvider.overrideWith(() => MockShelfState(shelfState)),
        ],
        child: MaterialApp(
          theme: AppTheme.theme,
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showRecentBookQuickActionsModal(
                  context: context,
                  book: book,
                  onAddToShelf: onAddToShelf ?? () {},
                  onRemoveFromShelf: onRemoveFromShelf ?? () {},
                ),
                child: const Text('Open Modal'),
              ),
            ),
          ),
        ),
      );
    }

    testWidgets('本棚に未追加の場合は「本棚に追加」ボタンを表示', (tester) async {
      await tester.pumpWidget(buildTestWidget(book: testBook));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      expect(find.text('本棚に追加'), findsOneWidget);
      expect(find.text('本棚から削除'), findsNothing);
    });

    testWidgets('本棚に追加済みの場合は「本棚から削除」ボタンを表示', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          book: testBook,
          shelfState: {'book1': testShelfEntry},
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      expect(find.text('本棚から削除'), findsOneWidget);
      expect(find.text('本棚に追加'), findsNothing);
    });

    testWidgets('「本棚に追加」タップで onAddToShelf が呼ばれる', (tester) async {
      var addCalled = false;
      await tester.pumpWidget(
        buildTestWidget(
          book: testBook,
          onAddToShelf: () => addCalled = true,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('本棚に追加'));
      await tester.pumpAndSettle();

      expect(addCalled, isTrue);
    });

    testWidgets('「本棚から削除」タップで onRemoveFromShelf が呼ばれる', (tester) async {
      var removeCalled = false;
      await tester.pumpWidget(
        buildTestWidget(
          book: testBook,
          shelfState: {'book1': testShelfEntry},
          onRemoveFromShelf: () => removeCalled = true,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('本棚から削除'));
      await tester.pumpAndSettle();

      expect(removeCalled, isTrue);
    });

    testWidgets('モーダルに本のタイトルと著者が表示される', (tester) async {
      await tester.pumpWidget(buildTestWidget(book: testBook));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      expect(find.text('Test Book'), findsOneWidget);
      expect(find.text('Test Author'), findsOneWidget);
    });
  });
}

class MockShelfState extends Notifier<Map<String, ShelfEntry>>
    with Mock
    implements ShelfState {
  MockShelfState([this._initialState = const {}]);

  final Map<String, ShelfEntry> _initialState;

  @override
  Map<String, ShelfEntry> build() => _initialState;
}
