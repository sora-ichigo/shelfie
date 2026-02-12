import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_list/data/book_list_repository.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';
import 'package:shelfie/features/book_list/presentation/book_list_edit_screen.dart';

class MockBookListRepository extends Mock implements BookListRepository {}

void main() {
  late MockBookListRepository mockRepository;
  final now = DateTime(2024, 1, 15, 10, 30);

  setUp(() {
    mockRepository = MockBookListRepository();
    when(() => mockRepository.getBookListDetail(listId: any(named: 'listId')))
        .thenAnswer((_) async => right(BookListDetail(
              id: 1,
              title: 'Test List',
              description: null,
              items: const [],
              stats: const BookListDetailStats(
                  bookCount: 0, completedCount: 0, coverImages: []),
              createdAt: now,
              updatedAt: now,
            )));
  });

  Widget buildTestWidget({int listId = 1}) {
    return ProviderScope(
      overrides: [
        bookListRepositoryProvider.overrideWithValue(mockRepository),
      ],
      child: MaterialApp(
        theme: AppTheme.dark(),
        home: BookListEditScreen(listId: listId),
      ),
    );
  }

  Future<void> pumpUntilLoaded(WidgetTester tester) async {
    await tester.pumpWidget(buildTestWidget());
    await tester.pump();
    await tester.pump();
  }

  group('BookListEditScreen', () {
    group('edit mode', () {
      testWidgets('displays "リスト編集" title', (tester) async {
        await pumpUntilLoaded(tester);

        expect(find.text('リスト編集'), findsOneWidget);
      });

      testWidgets('pre-fills title field with loaded value', (tester) async {
        when(() =>
                mockRepository.getBookListDetail(listId: any(named: 'listId')))
            .thenAnswer((_) async => right(BookListDetail(
                  id: 1,
                  title: 'My List',
                  description: null,
                  items: const [],
                  stats: const BookListDetailStats(
                      bookCount: 0, completedCount: 0, coverImages: []),
                  createdAt: now,
                  updatedAt: now,
                )));

        await pumpUntilLoaded(tester);

        expect(find.text('My List'), findsOneWidget);
      });

      testWidgets('pre-fills description field with loaded value',
          (tester) async {
        when(() =>
                mockRepository.getBookListDetail(listId: any(named: 'listId')))
            .thenAnswer((_) async => right(BookListDetail(
                  id: 1,
                  title: 'Test List',
                  description: 'A description',
                  items: const [],
                  stats: const BookListDetailStats(
                      bookCount: 0, completedCount: 0, coverImages: []),
                  createdAt: now,
                  updatedAt: now,
                )));

        await pumpUntilLoaded(tester);

        expect(find.text('A description'), findsOneWidget);
      });

      testWidgets('displays delete button', (tester) async {
        await pumpUntilLoaded(tester);

        expect(find.text('リストを削除'), findsOneWidget);
      });
    });

    group('form validation', () {
      testWidgets('shows error when title is cleared after input',
          (tester) async {
        await pumpUntilLoaded(tester);

        await tester.enterText(
          find.byKey(const Key('title_field')),
          'Test',
        );
        await tester.pump();

        await tester.enterText(
          find.byKey(const Key('title_field')),
          '',
        );
        await tester.pump();

        expect(find.text('タイトルを入力してください'), findsOneWidget);
      });
    });

    group('save action', () {
      testWidgets('calls updateBookList when saving', (tester) async {
        when(
          () => mockRepository.updateBookList(
            listId: any(named: 'listId'),
            title: any(named: 'title'),
            description: any(named: 'description'),
          ),
        ).thenAnswer(
          (_) async => right(BookList(
            id: 1,
            title: 'Updated List',
            description: null,
            createdAt: now,
            updatedAt: now,
          )),
        );
        when(
          () => mockRepository.getMyBookLists(
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer(
          (_) async => right(
            const MyBookListsResult(items: [], totalCount: 0, hasMore: false),
          ),
        );

        await pumpUntilLoaded(tester);

        await tester.enterText(
          find.byKey(const Key('title_field')),
          'Updated List',
        );
        await tester.pump();

        await tester.tap(find.byIcon(Icons.check));
        await tester.pump();
        await tester.pump();

        verify(
          () => mockRepository.updateBookList(
            listId: 1,
            title: 'Updated List',
            description: any(named: 'description'),
          ),
        ).called(1);
      });
    });
  });
}
