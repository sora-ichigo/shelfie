import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_list/data/book_list_repository.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';
import 'package:shelfie/features/book_list/presentation/widgets/book_list_item_actions.dart';

class MockBookListRepository extends Mock implements BookListRepository {}

void main() {
  late MockBookListRepository mockRepository;
  final now = DateTime(2024, 1, 15, 10, 30);

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

  setUp(() {
    mockRepository = MockBookListRepository();
  });

  Widget buildTestWidget({
    required BookListItem item,
    required int listId,
    VoidCallback? onRemoved,
  }) {
    return ProviderScope(
      overrides: [
        bookListRepositoryProvider.overrideWithValue(mockRepository),
      ],
      child: MaterialApp(
        theme: AppTheme.dark(),
        home: Scaffold(
          body: BookListItemActions(
            item: item,
            listId: listId,
            onRemoved: onRemoved,
          ),
        ),
      ),
    );
  }

  group('BookListItemActions', () {
    group('delete action', () {
      testWidgets('displays delete icon', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          item: createItem(),
          listId: 1,
        ));
        await tester.pump();

        expect(find.byIcon(Icons.delete_outline), findsOneWidget);
      });

      testWidgets('shows confirmation dialog when delete is tapped',
          (tester) async {
        await tester.pumpWidget(buildTestWidget(
          item: createItem(),
          listId: 1,
        ));
        await tester.pump();

        await tester.tap(find.byIcon(Icons.delete_outline));
        await tester.pumpAndSettle();

        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text('本をリストから削除'), findsOneWidget);
      });

      testWidgets('calls removeBookFromList when confirmed', (tester) async {
        when(
          () => mockRepository.removeBookFromList(
            listId: any(named: 'listId'),
            userBookId: any(named: 'userBookId'),
          ),
        ).thenAnswer((_) async => right(null));

        await tester.pumpWidget(buildTestWidget(
          item: createItem(id: 10),
          listId: 1,
        ));
        await tester.pump();

        await tester.tap(find.byIcon(Icons.delete_outline));
        await tester.pumpAndSettle();

        await tester.tap(find.text('削除'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        verify(
          () => mockRepository.removeBookFromList(
            listId: 1,
            userBookId: 10,
          ),
        ).called(1);
      });

      testWidgets('calls onRemoved callback after successful deletion',
          (tester) async {
        var removedCalled = false;

        when(
          () => mockRepository.removeBookFromList(
            listId: any(named: 'listId'),
            userBookId: any(named: 'userBookId'),
          ),
        ).thenAnswer((_) async => right(null));

        await tester.pumpWidget(buildTestWidget(
          item: createItem(id: 10),
          listId: 1,
          onRemoved: () => removedCalled = true,
        ));
        await tester.pump();

        await tester.tap(find.byIcon(Icons.delete_outline));
        await tester.pumpAndSettle();

        await tester.tap(find.text('削除'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        expect(removedCalled, isTrue);
      });

      testWidgets('does not call removeBookFromList when cancelled',
          (tester) async {
        await tester.pumpWidget(buildTestWidget(
          item: createItem(),
          listId: 1,
        ));
        await tester.pump();

        await tester.tap(find.byIcon(Icons.delete_outline));
        await tester.pumpAndSettle();

        await tester.tap(find.text('キャンセル'));
        await tester.pumpAndSettle();

        verifyNever(
          () => mockRepository.removeBookFromList(
            listId: any(named: 'listId'),
            userBookId: any(named: 'userBookId'),
          ),
        );
      });
    });

    group('drag handle', () {
      testWidgets('displays drag handle icon', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          item: createItem(),
          listId: 1,
        ));
        await tester.pump();

        expect(find.byIcon(Icons.drag_handle), findsOneWidget);
      });
    });
  });
}
