import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_list/data/book_list_repository.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';
import 'package:shelfie/features/book_list/presentation/book_list_edit_screen.dart';

class MockBookListRepository extends Mock implements BookListRepository {}

void main() {
  late MockBookListRepository mockRepository;
  final now = DateTime(2024, 1, 15, 10, 30);

  BookList createBookList({
    int id = 1,
    String title = 'Test List',
    String? description,
  }) {
    return BookList(
      id: id,
      title: title,
      description: description,
      createdAt: now,
      updatedAt: now,
    );
  }

  setUp(() {
    mockRepository = MockBookListRepository();
  });

  Widget buildTestWidget({
    BookList? existingList,
  }) {
    return ProviderScope(
      overrides: [
        bookListRepositoryProvider.overrideWithValue(mockRepository),
      ],
      child: MaterialApp(
        theme: AppTheme.dark(),
        home: BookListEditScreen(existingList: existingList),
      ),
    );
  }

  group('BookListEditScreen', () {
    group('create mode', () {
      testWidgets('displays "新規リスト" title when creating', (tester) async {
        await tester.pumpWidget(buildTestWidget());
        await tester.pump();

        expect(find.text('新規リスト'), findsOneWidget);
      });

      testWidgets('displays empty title field', (tester) async {
        await tester.pumpWidget(buildTestWidget());
        await tester.pump();

        final titleField = find.byKey(const Key('title_field'));
        expect(titleField, findsOneWidget);

        final textField = tester.widget<TextFormField>(titleField);
        expect(textField.initialValue, isEmpty);
      });

      testWidgets('displays empty description field', (tester) async {
        await tester.pumpWidget(buildTestWidget());
        await tester.pump();

        final descField = find.byKey(const Key('description_field'));
        expect(descField, findsOneWidget);
      });

      testWidgets('save button is disabled when title is empty', (tester) async {
        await tester.pumpWidget(buildTestWidget());
        await tester.pump();

        final saveButton = find.text('保存');
        expect(saveButton, findsOneWidget);

        final buttonWidget = tester.widget<ElevatedButton>(
          find.ancestor(
            of: saveButton,
            matching: find.byType(ElevatedButton),
          ),
        );
        expect(buttonWidget.onPressed, isNull);
      });

      testWidgets('save button is enabled when title is entered', (tester) async {
        await tester.pumpWidget(buildTestWidget());
        await tester.pump();

        await tester.enterText(
          find.byKey(const Key('title_field')),
          'New List',
        );
        await tester.pump();

        final buttonWidget = tester.widget<ElevatedButton>(
          find.ancestor(
            of: find.text('保存'),
            matching: find.byType(ElevatedButton),
          ),
        );
        expect(buttonWidget.onPressed, isNotNull);
      });
    });

    group('edit mode', () {
      testWidgets('displays "リスト編集" title when editing', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(existingList: createBookList()),
        );
        await tester.pump();

        expect(find.text('リスト編集'), findsOneWidget);
      });

      testWidgets('pre-fills title field with existing value', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(existingList: createBookList(title: 'My List')),
        );
        await tester.pump();

        expect(find.text('My List'), findsOneWidget);
      });

      testWidgets('pre-fills description field with existing value',
          (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            existingList: createBookList(description: 'A description'),
          ),
        );
        await tester.pump();

        expect(find.text('A description'), findsOneWidget);
      });

      testWidgets('displays delete button when editing', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(existingList: createBookList()),
        );
        await tester.pump();

        expect(find.text('リストを削除'), findsOneWidget);
      });
    });

    group('form validation', () {
      testWidgets('shows error when title is cleared after input',
          (tester) async {
        await tester.pumpWidget(buildTestWidget());
        await tester.pump();

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
      testWidgets('calls createBookList when saving new list', (tester) async {
        when(
          () => mockRepository.createBookList(
            title: any(named: 'title'),
            description: any(named: 'description'),
          ),
        ).thenAnswer(
          (_) async => right(createBookList(title: 'New List')),
        );

        await tester.pumpWidget(buildTestWidget());
        await tester.pump();

        await tester.enterText(
          find.byKey(const Key('title_field')),
          'New List',
        );
        await tester.pump();

        await tester.tap(find.text('保存'));
        await tester.pumpAndSettle();

        verify(
          () => mockRepository.createBookList(
            title: 'New List',
            description: null,
          ),
        ).called(1);
      });

      testWidgets('calls updateBookList when saving existing list',
          (tester) async {
        when(
          () => mockRepository.updateBookList(
            listId: any(named: 'listId'),
            title: any(named: 'title'),
            description: any(named: 'description'),
          ),
        ).thenAnswer(
          (_) async => right(createBookList(title: 'Updated List')),
        );

        await tester.pumpWidget(
          buildTestWidget(existingList: createBookList(id: 1)),
        );
        await tester.pump();

        await tester.enterText(
          find.byKey(const Key('title_field')),
          'Updated List',
        );
        await tester.pump();

        await tester.tap(find.text('保存'));
        await tester.pumpAndSettle();

        verify(
          () => mockRepository.updateBookList(
            listId: 1,
            title: 'Updated List',
            description: any(named: 'description'),
          ),
        ).called(1);
      });

      testWidgets('shows loading indicator while saving', (tester) async {
        when(
          () => mockRepository.createBookList(
            title: any(named: 'title'),
            description: any(named: 'description'),
          ),
        ).thenAnswer((_) async {
          await Future<void>.delayed(const Duration(milliseconds: 500));
          return right(createBookList());
        });

        await tester.pumpWidget(buildTestWidget());
        await tester.pump();

        await tester.enterText(
          find.byKey(const Key('title_field')),
          'New List',
        );
        await tester.pump();

        await tester.tap(find.text('保存'));
        await tester.pump();

        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        await tester.pumpAndSettle();
      });

      testWidgets('shows error snackbar on failure', (tester) async {
        when(
          () => mockRepository.createBookList(
            title: any(named: 'title'),
            description: any(named: 'description'),
          ),
        ).thenAnswer(
          (_) async => left(const ValidationFailure(message: 'Invalid title')),
        );

        await tester.pumpWidget(buildTestWidget());
        await tester.pump();

        await tester.enterText(
          find.byKey(const Key('title_field')),
          'New List',
        );
        await tester.pump();

        await tester.tap(find.text('保存'));
        await tester.pumpAndSettle();

        expect(find.byType(SnackBar), findsOneWidget);
      });
    });
  });
}
