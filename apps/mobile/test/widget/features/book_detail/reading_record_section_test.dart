import 'package:flutter/cupertino.dart';
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
    ValueChanged<DateTime>? onStartedAtTap,
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
            onStartedAtTap: onStartedAtTap,
          ),
        ),
      ),
    );
  }

  group('ReadingRecordSection 読書開始日表示', () {
    testWidgets('startedAt がある場合、読書開始日行が表示される', (tester) async {
      final shelfEntry = ShelfEntry(
        userBookId: 1,
        externalId: 'book-1',
        readingStatus: ReadingStatus.reading,
        addedAt: DateTime(2024, 1, 1),
        startedAt: DateTime(2024, 3, 15),
      );

      await tester.pumpWidget(buildTestWidget(
        shelfEntry: shelfEntry,
      ));

      expect(find.text('読書開始日'), findsOneWidget);
      expect(find.text('2024年3月15日'), findsOneWidget);
    });

    testWidgets('startedAt が null かつ onStartedAtTap も null の場合、読書開始日行が表示されない',
        (tester) async {
      final shelfEntry = ShelfEntry(
        userBookId: 1,
        externalId: 'book-1',
        readingStatus: ReadingStatus.backlog,
        addedAt: DateTime(2024, 1, 1),
      );

      await tester.pumpWidget(buildTestWidget(
        shelfEntry: shelfEntry,
      ));

      expect(find.text('読書開始日'), findsNothing);
    });

    testWidgets('startedAt が null でも onStartedAtTap が設定されていれば「未設定」で表示される',
        (tester) async {
      final shelfEntry = ShelfEntry(
        userBookId: 1,
        externalId: 'book-1',
        readingStatus: ReadingStatus.reading,
        addedAt: DateTime(2024, 1, 1),
      );

      await tester.pumpWidget(buildTestWidget(
        shelfEntry: shelfEntry,
        onStartedAtTap: (_) {},
      ));

      expect(find.text('読書開始日'), findsOneWidget);
      expect(find.text('未設定'), findsOneWidget);
    });

    testWidgets('読了状態で startedAt と completedAt の両方がある場合、両方表示される',
        (tester) async {
      final shelfEntry = ShelfEntry(
        userBookId: 1,
        externalId: 'book-1',
        readingStatus: ReadingStatus.completed,
        addedAt: DateTime(2024, 1, 1),
        startedAt: DateTime(2024, 3, 15),
        completedAt: DateTime(2024, 6, 20),
      );

      await tester.pumpWidget(buildTestWidget(
        shelfEntry: shelfEntry,
        onCompletedAtTap: (_) {},
      ));

      expect(find.text('読書開始日'), findsOneWidget);
      expect(find.text('2024年3月15日'), findsOneWidget);
      expect(find.text('読了日'), findsOneWidget);
      expect(find.text('2024年6月20日'), findsOneWidget);
    });
  });

  group('ReadingRecordSection 読書開始日編集', () {
    testWidgets('onStartedAtTap が設定されている場合、読書開始日行にシェブロンが表示される',
        (tester) async {
      final shelfEntry = ShelfEntry(
        userBookId: 1,
        externalId: 'book-1',
        readingStatus: ReadingStatus.reading,
        addedAt: DateTime(2024, 1, 1),
        startedAt: DateTime(2024, 3, 15),
      );

      await tester.pumpWidget(buildTestWidget(
        shelfEntry: shelfEntry,
        onStartedAtTap: (_) {},
      ));

      final startedRow = find.ancestor(
        of: find.text('読書開始日'),
        matching: find.byType(InkWell),
      );
      expect(startedRow, findsOneWidget);
    });

    testWidgets('onStartedAtTap が null の場合、読書開始日行はタップ不可',
        (tester) async {
      final shelfEntry = ShelfEntry(
        userBookId: 1,
        externalId: 'book-1',
        readingStatus: ReadingStatus.reading,
        addedAt: DateTime(2024, 1, 1),
        startedAt: DateTime(2024, 3, 15),
      );

      await tester.pumpWidget(buildTestWidget(
        shelfEntry: shelfEntry,
        onStartedAtTap: null,
      ));

      final startedRow = find.ancestor(
        of: find.text('読書開始日'),
        matching: find.byType(InkWell),
      );
      expect(startedRow, findsNothing);
    });

    testWidgets('読書開始日行をタップするとボトムシートにカレンダーが表示される',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final shelfEntry = ShelfEntry(
        userBookId: 1,
        externalId: 'book-1',
        readingStatus: ReadingStatus.reading,
        addedAt: DateTime(2024, 1, 1),
        startedAt: DateTime(2024, 3, 15),
      );

      await tester.pumpWidget(buildTestWidget(
        shelfEntry: shelfEntry,
        onStartedAtTap: (_) {},
      ));

      final startedRow = find.ancestor(
        of: find.text('読書開始日'),
        matching: find.byType(InkWell),
      );
      await tester.tap(startedRow);
      await tester.pumpAndSettle();

      expect(find.byType(CupertinoDatePicker), findsOneWidget);
      expect(find.text('読書開始日を変更'), findsOneWidget);
    });

    testWidgets('startedAt が null の場合、日付ピッカーのタイトルが「読書開始日を設定」になる',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final shelfEntry = ShelfEntry(
        userBookId: 1,
        externalId: 'book-1',
        readingStatus: ReadingStatus.reading,
        addedAt: DateTime(2024, 1, 1),
      );

      await tester.pumpWidget(buildTestWidget(
        shelfEntry: shelfEntry,
        onStartedAtTap: (_) {},
      ));

      final startedRow = find.ancestor(
        of: find.text('読書開始日'),
        matching: find.byType(InkWell),
      );
      await tester.tap(startedRow);
      await tester.pumpAndSettle();

      expect(find.byType(CupertinoDatePicker), findsOneWidget);
      expect(find.text('読書開始日を設定'), findsOneWidget);
    });
  });

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

    testWidgets('読了日行をタップするとボトムシートにカレンダーが表示される',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

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

      expect(find.byType(CupertinoDatePicker), findsOneWidget);
      expect(find.text('読了日を変更'), findsOneWidget);
    });
  });
}
