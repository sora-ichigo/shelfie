import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_detail/presentation/widgets/reading_record_section.dart';

void main() {
  Widget buildTestWidget({
    required ShelfEntry shelfEntry,
    VoidCallback? onStatusTap,
    VoidCallback? onRatingTap,
    ValueChanged<DateTime>? onCompletedAtTap,
  }) {
    return MaterialApp(
      theme: AppTheme.dark(),
      home: Scaffold(
        body: SingleChildScrollView(
          child: ReadingRecordSection(
            shelfEntry: shelfEntry,
            onStatusTap: onStatusTap ?? () {},
            onRatingTap: onRatingTap ?? () {},
            onCompletedAtTap: onCompletedAtTap,
          ),
        ),
      ),
    );
  }

  group('ReadingRecordSection 読了日編集', () {
    testWidgets('読了状態で読了日行が表示される', (tester) async {
      final shelfEntry = ShelfEntry(
        userBookId: 1,
        externalId: 'book-1',
        readingStatus: ReadingStatus.completed,
        addedAt: DateTime(2024, 1, 1),
        completedAt: DateTime(2024, 6, 20),
      );

      await tester.pumpWidget(buildTestWidget(
        shelfEntry: shelfEntry,
        onCompletedAtTap: (_) {},
      ));

      expect(find.text('読了日'), findsOneWidget);
      expect(find.text('2024年6月20日'), findsOneWidget);
    });

    testWidgets('読了以外の状態では読了日行が表示されない', (tester) async {
      final shelfEntry = ShelfEntry(
        userBookId: 1,
        externalId: 'book-1',
        readingStatus: ReadingStatus.reading,
        addedAt: DateTime(2024, 1, 1),
      );

      await tester.pumpWidget(buildTestWidget(
        shelfEntry: shelfEntry,
      ));

      expect(find.text('読了日'), findsNothing);
    });

    testWidgets('読了状態で onCompletedAtTap が設定されている場合、読了日行にシェブロンが表示される',
        (tester) async {
      final shelfEntry = ShelfEntry(
        userBookId: 1,
        externalId: 'book-1',
        readingStatus: ReadingStatus.completed,
        addedAt: DateTime(2024, 1, 1),
        completedAt: DateTime(2024, 6, 20),
      );

      await tester.pumpWidget(buildTestWidget(
        shelfEntry: shelfEntry,
        onCompletedAtTap: (_) {},
      ));

      final completedRow = find.ancestor(
        of: find.text('読了日'),
        matching: find.byType(InkWell),
      );
      expect(completedRow, findsOneWidget);
    });

    testWidgets('読了状態で onCompletedAtTap が null の場合、読了日行はタップ不可',
        (tester) async {
      final shelfEntry = ShelfEntry(
        userBookId: 1,
        externalId: 'book-1',
        readingStatus: ReadingStatus.completed,
        addedAt: DateTime(2024, 1, 1),
        completedAt: DateTime(2024, 6, 20),
      );

      await tester.pumpWidget(buildTestWidget(
        shelfEntry: shelfEntry,
        onCompletedAtTap: null,
      ));

      final completedRow = find.ancestor(
        of: find.text('読了日'),
        matching: find.byType(InkWell),
      );
      expect(completedRow, findsNothing);
    });

    testWidgets('読了日行をタップするとDatePickerが表示される', (tester) async {
      final shelfEntry = ShelfEntry(
        userBookId: 1,
        externalId: 'book-1',
        readingStatus: ReadingStatus.completed,
        addedAt: DateTime(2024, 1, 1),
        completedAt: DateTime(2024, 6, 20),
      );

      await tester.pumpWidget(buildTestWidget(
        shelfEntry: shelfEntry,
        onCompletedAtTap: (_) {},
      ));

      final completedRow = find.ancestor(
        of: find.text('読了日'),
        matching: find.byType(InkWell),
      );
      await tester.tap(completedRow);
      await tester.pumpAndSettle();

      expect(find.byType(DatePickerDialog), findsOneWidget);
    });
  });
}
