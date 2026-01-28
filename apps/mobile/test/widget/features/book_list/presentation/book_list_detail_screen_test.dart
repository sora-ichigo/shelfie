import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_list/data/book_list_repository.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';
import 'package:shelfie/features/book_list/presentation/book_list_detail_screen.dart';

class MockBookListRepository extends Mock implements BookListRepository {}

void main() {
  late MockBookListRepository mockRepository;
  final now = DateTime(2024, 1, 15, 10, 30);

  BookListDetail createDetail({
    int id = 1,
    String title = 'Test List',
    String? description,
    List<BookListItem> items = const [],
  }) {
    return BookListDetail(
      id: id,
      title: title,
      description: description,
      items: items,
      createdAt: now,
      updatedAt: now,
    );
  }

  BookListItem createItem({
    int id = 1,
    int position = 0,
    DateTime? addedAt,
  }) {
    return BookListItem(
      id: id,
      position: position,
      addedAt: addedAt ?? now,
    );
  }

  setUp(() {
    mockRepository = MockBookListRepository();
  });

  Widget buildTestWidget({
    required int listId,
  }) {
    return ProviderScope(
      overrides: [
        bookListRepositoryProvider.overrideWithValue(mockRepository),
      ],
      child: MaterialApp(
        theme: AppTheme.dark(),
        home: BookListDetailScreen(listId: listId),
      ),
    );
  }

  group('BookListDetailScreen', () {
    group('structure', () {
      testWidgets('displays Scaffold with AppBar', (tester) async {
        when(() => mockRepository.getBookListDetail(listId: any(named: 'listId')))
            .thenAnswer((_) async => right(createDetail()));

        await tester.pumpWidget(buildTestWidget(listId: 1));
        await tester.pumpAndSettle();

        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(AppBar), findsOneWidget);
      });

      testWidgets('displays back button in AppBar', (tester) async {
        when(() => mockRepository.getBookListDetail(listId: any(named: 'listId')))
            .thenAnswer((_) async => right(createDetail()));

        await tester.pumpWidget(buildTestWidget(listId: 1));
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.arrow_back_ios_new), findsOneWidget);
      });
    });

    group('loading state', () {
      testWidgets('displays loading indicator while loading', (tester) async {
        when(() => mockRepository.getBookListDetail(listId: any(named: 'listId')))
            .thenAnswer((_) async {
          await Future<void>.delayed(const Duration(milliseconds: 500));
          return right(createDetail());
        });

        await tester.pumpWidget(buildTestWidget(listId: 1));
        await tester.pump();

        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        await tester.pumpAndSettle();
      });
    });

    group('error state', () {
      testWidgets('displays error message on failure', (tester) async {
        when(() => mockRepository.getBookListDetail(listId: any(named: 'listId')))
            .thenAnswer(
          (_) async => left(const NotFoundFailure(message: 'List not found')),
        );

        await tester.pumpWidget(buildTestWidget(listId: 999));
        await tester.pumpAndSettle();

        expect(find.textContaining('見つかりません'), findsOneWidget);
      });

      testWidgets('displays retry button on error', (tester) async {
        when(() => mockRepository.getBookListDetail(listId: any(named: 'listId')))
            .thenAnswer(
          (_) async => left(const NetworkFailure(message: 'Network error')),
        );

        await tester.pumpWidget(buildTestWidget(listId: 1));
        await tester.pumpAndSettle();

        expect(find.byType(ElevatedButton), findsOneWidget);
      });
    });

    group('loaded state', () {
      testWidgets('displays list title in header', (tester) async {
        when(() => mockRepository.getBookListDetail(listId: any(named: 'listId')))
            .thenAnswer((_) async => right(createDetail(title: 'My Favorites')));

        await tester.pumpWidget(buildTestWidget(listId: 1));
        await tester.pumpAndSettle();

        expect(find.text('My Favorites'), findsOneWidget);
      });

      testWidgets('displays list description when present', (tester) async {
        when(() => mockRepository.getBookListDetail(listId: any(named: 'listId')))
            .thenAnswer(
          (_) async => right(createDetail(description: 'A collection of books')),
        );

        await tester.pumpWidget(buildTestWidget(listId: 1));
        await tester.pumpAndSettle();

        expect(find.text('A collection of books'), findsOneWidget);
      });

      testWidgets('displays edit button', (tester) async {
        when(() => mockRepository.getBookListDetail(listId: any(named: 'listId')))
            .thenAnswer((_) async => right(createDetail()));

        await tester.pumpWidget(buildTestWidget(listId: 1));
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.edit), findsOneWidget);
      });

      testWidgets('displays empty state when no items', (tester) async {
        when(() => mockRepository.getBookListDetail(listId: any(named: 'listId')))
            .thenAnswer((_) async => right(createDetail(items: [])));

        await tester.pumpWidget(buildTestWidget(listId: 1));
        await tester.pumpAndSettle();

        expect(find.textContaining('本がありません'), findsOneWidget);
      });

      testWidgets('displays items sorted by position', (tester) async {
        final items = [
          createItem(id: 3, position: 2),
          createItem(id: 1, position: 0),
          createItem(id: 2, position: 1),
        ];

        when(() => mockRepository.getBookListDetail(listId: any(named: 'listId')))
            .thenAnswer((_) async => right(createDetail(items: items)));

        await tester.pumpWidget(buildTestWidget(listId: 1));
        await tester.pumpAndSettle();

        expect(find.byType(CustomScrollView), findsOneWidget);
        expect(find.byType(ListTile), findsNWidgets(3));
      });
    });
  });
}
