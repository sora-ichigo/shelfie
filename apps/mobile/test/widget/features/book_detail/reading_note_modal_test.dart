import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_detail/application/book_detail_notifier.dart';
import 'package:shelfie/features/book_detail/data/book_detail_repository.dart';
import 'package:shelfie/features/book_detail/domain/book_detail.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_detail/presentation/widgets/reading_note_modal.dart';

class MockBookDetailRepository extends Mock implements BookDetailRepository {}

void main() {
  late MockBookDetailRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(ReadingStatus.backlog);
  });

  setUp(() {
    mockRepository = MockBookDetailRepository();
  });

  Widget buildTestWidget({
    String? currentNote,
    required int userBookId,
    required String externalId,
  }) {
    return ProviderScope(
      overrides: [
        bookDetailRepositoryProvider.overrideWithValue(mockRepository),
        bookDetailNotifierProvider(externalId).overrideWith(
          () => _TestBookDetailNotifier(
            currentNote: currentNote,
            userBookId: userBookId,
            externalId: externalId,
            repository: mockRepository,
          ),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.dark(),
        home: Builder(
          builder: (context) => Scaffold(
            body: ElevatedButton(
              onPressed: () {
                showReadingNoteModal(
                  context: context,
                  currentNote: currentNote,
                  userBookId: userBookId,
                  externalId: externalId,
                );
              },
              child: const Text('Open Modal'),
            ),
          ),
        ),
      ),
    );
  }

  group('ReadingNoteModal 表示', () {
    testWidgets('モーダルが画面下部からスライドアップ表示される', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        currentNote: null,
        userBookId: 1,
        externalId: 'test-id',
      ));

      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      expect(find.byType(BottomSheet), findsOneWidget);
    });

    testWidgets('複数行テキストエリアが表示される', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        currentNote: null,
        userBookId: 1,
        externalId: 'test-id',
      ));

      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsOneWidget);
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.maxLines, greaterThan(1));
    });

    testWidgets('既存メモがある場合は初期値として表示される', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        currentNote: 'Existing note content',
        userBookId: 1,
        externalId: 'test-id',
      ));

      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      expect(find.text('Existing note content'), findsOneWidget);
    });

    testWidgets('保存ボタンとキャンセルボタンが表示される', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        currentNote: null,
        userBookId: 1,
        externalId: 'test-id',
      ));

      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      expect(find.text('保存'), findsOneWidget);
      expect(find.text('キャンセル'), findsOneWidget);
    });
  });

  group('ReadingNoteModal キャンセル', () {
    testWidgets('キャンセルボタンをタップするとモーダルが閉じる', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        currentNote: null,
        userBookId: 1,
        externalId: 'test-id',
      ));

      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('キャンセル'));
      await tester.pumpAndSettle();

      expect(find.byType(BottomSheet), findsNothing);
    });
  });

  group('ReadingNoteModal 保存', () {
    testWidgets('保存失敗時にエラーメッセージが表示される', (tester) async {
      when(
        () => mockRepository.updateReadingNote(
          userBookId: any(named: 'userBookId'),
          note: any(named: 'note'),
        ),
      ).thenAnswer(
        (_) async => left(const NetworkFailure(message: 'Network error')),
      );

      await tester.pumpWidget(buildTestWidget(
        currentNote: null,
        userBookId: 1,
        externalId: 'test-id',
      ));

      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'New note');
      await tester.pumpAndSettle();

      await tester.tap(find.text('保存'));
      await tester.pumpAndSettle();

      expect(find.text('ネットワーク接続を確認してください'), findsOneWidget);
    });

  });
}

class _TestBookDetailNotifier extends BookDetailNotifier {
  _TestBookDetailNotifier({
    required this.currentNote,
    required this.userBookId,
    required this.externalId,
    required this.repository,
  });

  final String? currentNote;
  final int userBookId;
  final String externalId;
  final BookDetailRepository repository;

  @override
  Future<BookDetail?> build(String externalId) async {
    ref.read(shelfStateProvider.notifier).registerEntry(
      ShelfEntry(
        userBookId: userBookId,
        externalId: externalId,
        readingStatus: ReadingStatus.backlog,
        addedAt: DateTime(2024, 1, 1),
        note: currentNote,
      ),
    );
    return BookDetail(
      id: externalId,
      title: 'Test Book',
      authors: const ['Test Author'],
    );
  }

  @override
  Future<Either<Failure, ShelfEntry>> updateReadingNote({
    required int userBookId,
    required String note,
  }) async {
    final result = await repository.updateReadingNote(
      userBookId: userBookId,
      note: note,
    );

    return result.fold(
      left,
      (userBook) {
        final entry = ShelfEntry(
          userBookId: userBook.id,
          externalId: externalId,
          readingStatus: userBook.readingStatus,
          addedAt: userBook.addedAt,
          note: userBook.note,
          noteUpdatedAt: userBook.noteUpdatedAt,
        );
        ref.read(shelfStateProvider.notifier).registerEntry(entry);
        return right(entry);
      },
    );
  }
}
