import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';
import 'package:shelfie/features/book_list/presentation/widgets/book_list_card.dart';

void main() {
  final now = DateTime(2024, 1, 15, 10, 30);

  BookListSummary createSummary({
    int id = 1,
    String title = 'Test List',
    String? description,
    int bookCount = 3,
    List<String> coverImages = const [],
  }) {
    return BookListSummary(
      id: id,
      title: title,
      description: description,
      bookCount: bookCount,
      coverImages: coverImages,
      createdAt: now,
      updatedAt: now,
    );
  }

  Widget buildTestWidget({
    required BookListSummary summary,
    VoidCallback? onTap,
  }) {
    return MaterialApp(
      theme: AppTheme.dark(),
      home: Scaffold(
        body: BookListCard(
          summary: summary,
          onTap: onTap ?? () {},
        ),
      ),
    );
  }

  group('BookListCard', () {
    group('cover image display', () {
      testWidgets('displays cover collage when images exist', (tester) async {
        final summary = createSummary(
          coverImages: [
            'https://example.com/cover1.jpg',
            'https://example.com/cover2.jpg',
          ],
        );

        await tester.pumpWidget(buildTestWidget(summary: summary));
        await tester.pump();

        expect(find.byType(CoverCollage), findsOneWidget);
      });

      testWidgets('displays placeholder when no cover images', (tester) async {
        final summary = createSummary(
          bookCount: 0,
          coverImages: [],
        );

        await tester.pumpWidget(buildTestWidget(summary: summary));
        await tester.pump();

        final placeholderIcon = find.byIcon(Icons.collections_bookmark);
        expect(placeholderIcon, findsOneWidget);
      });
    });

    group('title display', () {
      testWidgets('displays list title', (tester) async {
        final summary = createSummary(title: 'My Reading List');

        await tester.pumpWidget(buildTestWidget(summary: summary));
        await tester.pump();

        expect(find.text('My Reading List'), findsOneWidget);
      });

      testWidgets('truncates long title with ellipsis', (tester) async {
        final summary = createSummary(
          title: 'This is a very long title that should be truncated',
        );

        await tester.pumpWidget(buildTestWidget(summary: summary));
        await tester.pump();

        final titleText = find.text(
          'This is a very long title that should be truncated',
        );
        expect(titleText, findsOneWidget);

        final textWidget = tester.widget<Text>(titleText);
        expect(textWidget.maxLines, 1);
        expect(textWidget.overflow, TextOverflow.ellipsis);
      });
    });

    group('book count and description display', () {
      testWidgets('displays book count and description in one line',
          (tester) async {
        final summary = createSummary(
          bookCount: 5,
          description: 'A collection',
        );

        await tester.pumpWidget(buildTestWidget(summary: summary));
        await tester.pump();

        expect(find.textContaining('5冊'), findsOneWidget);
        expect(find.textContaining('A collection'), findsOneWidget);
      });

      testWidgets('displays only book count when no description',
          (tester) async {
        final summary = createSummary(
          bookCount: 3,
          description: null,
        );

        await tester.pumpWidget(buildTestWidget(summary: summary));
        await tester.pump();

        expect(find.text('3冊'), findsOneWidget);
      });
    });

    group('tap interaction', () {
      testWidgets('calls onTap when tapped', (tester) async {
        var tapped = false;
        final summary = createSummary();

        await tester.pumpWidget(buildTestWidget(
          summary: summary,
          onTap: () => tapped = true,
        ));
        await tester.pump();

        await tester.tap(find.byType(BookListCard));
        await tester.pumpAndSettle();

        expect(tapped, isTrue);
      });
    });
  });
}
