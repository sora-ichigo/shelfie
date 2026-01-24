import 'dart:async';

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
import 'package:shelfie/features/book_detail/domain/user_book.dart';
import 'package:shelfie/features/book_detail/presentation/widgets/reading_status_modal.dart';

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
    required ReadingStatus currentStatus,
    required int userBookId,
    required String externalId,
  }) {
    return ProviderScope(
      overrides: [
        bookDetailRepositoryProvider.overrideWithValue(mockRepository),
        bookDetailNotifierProvider(externalId).overrideWith(
          () => _TestBookDetailNotifier(
            currentStatus: currentStatus,
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
                showReadingStatusModal(
                  context: context,
                  currentStatus: currentStatus,
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

  group('ReadingStatusModal 表示', () {
    testWidgets('モーダルが画面下部からスライドアップ表示される', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        currentStatus: ReadingStatus.backlog,
        userBookId: 1,
        externalId: 'test-id',
      ));

      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      expect(find.byType(BottomSheet), findsOneWidget);
    });

    testWidgets('4つの読書状態がラジオボタンで表示される', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        currentStatus: ReadingStatus.backlog,
        userBookId: 1,
        externalId: 'test-id',
      ));

      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      expect(find.text('積読'), findsOneWidget);
      expect(find.text('読書中'), findsOneWidget);
      expect(find.text('読了'), findsOneWidget);
      expect(find.text('読まない'), findsOneWidget);
      expect(find.byType(Radio<ReadingStatus>), findsNWidgets(4));
    });

    testWidgets('現在の状態が初期選択されている', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        currentStatus: ReadingStatus.reading,
        userBookId: 1,
        externalId: 'test-id',
      ));

      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      final radio = tester.widget<Radio<ReadingStatus>>(
        find.byWidgetPredicate(
          (widget) =>
              widget is Radio<ReadingStatus> &&
              widget.value == ReadingStatus.reading,
        ),
      );
      expect(radio.groupValue, ReadingStatus.reading);
    });

    testWidgets('保存ボタンとキャンセルボタンが表示される', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        currentStatus: ReadingStatus.backlog,
        userBookId: 1,
        externalId: 'test-id',
      ));

      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      expect(find.text('保存'), findsOneWidget);
      expect(find.text('キャンセル'), findsOneWidget);
    });
  });

  group('ReadingStatusModal 状態選択', () {
    testWidgets('ラジオボタンをタップすると選択状態が変わる', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        currentStatus: ReadingStatus.backlog,
        userBookId: 1,
        externalId: 'test-id',
      ));

      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('読了'));
      await tester.pumpAndSettle();

      final radio = tester.widget<Radio<ReadingStatus>>(
        find.byWidgetPredicate(
          (widget) =>
              widget is Radio<ReadingStatus> &&
              widget.value == ReadingStatus.completed,
        ),
      );
      expect(radio.groupValue, ReadingStatus.completed);
    });

    testWidgets('変更がない場合は保存ボタンが無効化される', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        currentStatus: ReadingStatus.backlog,
        userBookId: 1,
        externalId: 'test-id',
      ));

      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      final saveButton = tester.widget<ElevatedButton>(
        find.widgetWithText(ElevatedButton, '保存'),
      );
      expect(saveButton.onPressed, isNull);
    });

    testWidgets('状態を変更すると保存ボタンが有効化される', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        currentStatus: ReadingStatus.backlog,
        userBookId: 1,
        externalId: 'test-id',
      ));

      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('読書中'));
      await tester.pumpAndSettle();

      final saveButton = tester.widget<ElevatedButton>(
        find.widgetWithText(ElevatedButton, '保存'),
      );
      expect(saveButton.onPressed, isNotNull);
    });
  });

  group('ReadingStatusModal キャンセル', () {
    testWidgets('キャンセルボタンをタップするとモーダルが閉じる', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        currentStatus: ReadingStatus.backlog,
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

  group('ReadingStatusModal 保存', () {
    testWidgets('保存成功時にモーダルが閉じる', (tester) async {
      when(
        () => mockRepository.updateReadingStatus(
          userBookId: any(named: 'userBookId'),
          status: any(named: 'status'),
        ),
      ).thenAnswer(
        (_) async => right(
          UserBook(
            id: 1,
            readingStatus: ReadingStatus.reading,
            addedAt: DateTime(2024, 1, 1),
          ),
        ),
      );

      await tester.pumpWidget(buildTestWidget(
        currentStatus: ReadingStatus.backlog,
        userBookId: 1,
        externalId: 'test-id',
      ));

      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('読書中'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('保存'));
      await tester.pumpAndSettle();

      expect(find.byType(BottomSheet), findsNothing);
    });

    testWidgets('保存失敗時にエラーメッセージが表示される', (tester) async {
      when(
        () => mockRepository.updateReadingStatus(
          userBookId: any(named: 'userBookId'),
          status: any(named: 'status'),
        ),
      ).thenAnswer(
        (_) async => left(const NetworkFailure(message: 'Network error')),
      );

      await tester.pumpWidget(buildTestWidget(
        currentStatus: ReadingStatus.backlog,
        userBookId: 1,
        externalId: 'test-id',
      ));

      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('読書中'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('保存'));
      await tester.pumpAndSettle();

      expect(find.text('ネットワーク接続を確認してください'), findsOneWidget);
    });

    testWidgets('保存中はローディングインジケータが表示される', (tester) async {
      final completer = Completer<Either<Failure, UserBook>>();
      when(
        () => mockRepository.updateReadingStatus(
          userBookId: any(named: 'userBookId'),
          status: any(named: 'status'),
        ),
      ).thenAnswer((_) => completer.future);

      await tester.pumpWidget(buildTestWidget(
        currentStatus: ReadingStatus.backlog,
        userBookId: 1,
        externalId: 'test-id',
      ));

      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('読書中'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('保存'));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      completer.complete(right(
        UserBook(
          id: 1,
          readingStatus: ReadingStatus.reading,
          addedAt: DateTime(2024, 1, 1),
        ),
      ));
      await tester.pumpAndSettle();
    });
  });
}

class _TestBookDetailNotifier extends BookDetailNotifier {
  _TestBookDetailNotifier({
    required this.currentStatus,
    required this.userBookId,
    required this.externalId,
    required this.repository,
  });

  final ReadingStatus currentStatus;
  final int userBookId;
  final String externalId;
  final BookDetailRepository repository;

  @override
  Future<BookDetail?> build(String externalId) async {
    ref.read(shelfStateProvider.notifier).registerEntry(
      ShelfEntry(
        userBookId: userBookId,
        externalId: externalId,
        readingStatus: currentStatus,
        addedAt: DateTime(2024, 1, 1),
      ),
    );
    return BookDetail(
      id: externalId,
      title: 'Test Book',
      authors: const ['Test Author'],
    );
  }

  @override
  Future<Either<Failure, ShelfEntry>> updateReadingStatus({
    required int userBookId,
    required ReadingStatus status,
  }) async {
    final result = await repository.updateReadingStatus(
      userBookId: userBookId,
      status: status,
    );

    return result.fold(
      left,
      (userBook) {
        final entry = ShelfEntry(
          userBookId: userBook.id,
          externalId: externalId,
          readingStatus: userBook.readingStatus,
          addedAt: userBook.addedAt,
          completedAt: userBook.completedAt,
        );
        ref.read(shelfStateProvider.notifier).registerEntry(entry);
        return right(entry);
      },
    );
  }
}
