import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_list/data/book_list_repository.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';
import 'package:shelfie/features/book_list/presentation/widgets/create_book_list_modal.dart';

class MockBookListRepository extends Mock implements BookListRepository {}

void main() {
  late MockBookListRepository mockRepository;
  final now = DateTime(2024, 1, 15, 10, 30);

  setUp(() {
    mockRepository = MockBookListRepository();
    when(() => mockRepository.getMyBookLists())
        .thenAnswer((_) async => right(const MyBookListsResult(
              items: [],
              totalCount: 0,
              hasMore: false,
            )));
  });

  BookList createBookList({
    int id = 1,
    String title = 'ブックリスト#3',
  }) {
    return BookList(
      id: id,
      title: title,
      createdAt: now,
      updatedAt: now,
    );
  }

  Widget buildTestWidget({int existingCount = 2}) {
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
                showCreateBookListModal(
                  context: context,
                  existingCount: existingCount,
                );
              },
              child: const Text('Show Modal'),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> openModal(WidgetTester tester, {int existingCount = 2}) async {
    await tester.pumpWidget(buildTestWidget(existingCount: existingCount));
    await tester.pump();
    await tester.tap(find.text('Show Modal'));
    await tester.pumpAndSettle();
  }

  group('CreateBookListModal', () {
    group('structure', () {
      testWidgets('モーダルが正しく表示される', (tester) async {
        await openModal(tester);

        expect(find.text('ブックリストを作成'), findsOneWidget);
        expect(find.text('ブックリストに名前をつけてください'), findsOneWidget);
      });

      testWidgets('テキストフィールドにデフォルト値が入っている', (tester) async {
        await openModal(tester, existingCount: 2);

        expect(
          find.widgetWithText(TextFormField, 'ブックリスト#3'),
          findsOneWidget,
        );
      });

      testWidgets('existingCount: 0 なら「ブックリスト#1」がデフォルト値', (tester) async {
        await openModal(tester, existingCount: 0);

        expect(
          find.widgetWithText(TextFormField, 'ブックリスト#1'),
          findsOneWidget,
        );
      });
    });

    group('validation', () {
      testWidgets('空のテキストでは「作成する」ボタンが無効', (tester) async {
        await openModal(tester);

        final textField = find.byType(TextFormField);
        await tester.enterText(textField, '');
        await tester.pump();

        final button = tester.widget<FilledButton>(find.byType(FilledButton));
        expect(button.onPressed, isNull);
      });

      testWidgets('テキスト入力後に「作成する」ボタンが有効', (tester) async {
        await openModal(tester);

        final textField = find.byType(TextFormField);
        await tester.enterText(textField, 'マイリスト');
        await tester.pump();

        final button = tester.widget<FilledButton>(find.byType(FilledButton));
        expect(button.onPressed, isNotNull);
      });
    });

    group('creation', () {
      testWidgets('「作成する」ボタンタップで BookListNotifier.createList が呼ばれる',
          (tester) async {
        when(() => mockRepository.createBookList(title: any(named: 'title')))
            .thenAnswer((_) async => right(createBookList()));

        await openModal(tester);

        await tester.tap(find.text('作成する'));
        await tester.pumpAndSettle();

        verify(() => mockRepository.createBookList(title: 'ブックリスト#3'))
            .called(1);
      });

      testWidgets('作成成功後にモーダルが閉じて BookList が返される', (tester) async {
        final expectedBookList = createBookList();
        when(() => mockRepository.createBookList(title: any(named: 'title')))
            .thenAnswer((_) async => right(expectedBookList));

        BookList? result;
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              bookListRepositoryProvider.overrideWithValue(mockRepository),
            ],
            child: MaterialApp(
              theme: AppTheme.dark(),
              home: Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () async {
                      result = await showCreateBookListModal(
                        context: context,
                        existingCount: 2,
                      );
                    },
                    child: const Text('Show Modal'),
                  ),
                ),
              ),
            ),
          ),
        );
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('作成する'));
        await tester.pumpAndSettle();

        expect(result, isNotNull);
        expect(result!.id, equals(1));
        expect(result!.title, equals('ブックリスト#3'));
        expect(find.text('ブックリストを作成'), findsNothing);
      });
    });
  });
}
