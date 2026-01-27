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
        body: SizedBox(
          width: 180,
          child: BookListCard.vertical(
            summary: summary,
            onTap: onTap ?? () {},
          ),
        ),
      ),
    );
  }

  group('BookListCard vertical variant', () {
    group('2x2 cover image collage', () {
      testWidgets('displays 2x2 collage when 4 or more cover images',
          (tester) async {
        final summary = createSummary(
          coverImages: [
            'https://example.com/cover1.jpg',
            'https://example.com/cover2.jpg',
            'https://example.com/cover3.jpg',
            'https://example.com/cover4.jpg',
          ],
        );

        await tester.pumpWidget(buildTestWidget(summary: summary));
        await tester.pump();

        final coverCollage = find.byType(CoverCollage);
        expect(coverCollage, findsOneWidget);
      });

      testWidgets('displays available covers when less than 4 images',
          (tester) async {
        final summary = createSummary(
          coverImages: [
            'https://example.com/cover1.jpg',
            'https://example.com/cover2.jpg',
          ],
        );

        await tester.pumpWidget(buildTestWidget(summary: summary));
        await tester.pump();

        final coverCollage = find.byType(CoverCollage);
        expect(coverCollage, findsOneWidget);
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
        expect(textWidget.maxLines, 2);
        expect(textWidget.overflow, TextOverflow.ellipsis);
      });
    });

    group('book count display', () {
      testWidgets('displays book count', (tester) async {
        final summary = createSummary(bookCount: 5);

        await tester.pumpWidget(buildTestWidget(summary: summary));
        await tester.pump();

        expect(find.text('5冊'), findsOneWidget);
      });

      testWidgets('displays singular form for 0 books', (tester) async {
        final summary = createSummary(bookCount: 0);

        await tester.pumpWidget(buildTestWidget(summary: summary));
        await tester.pump();

        expect(find.text('0冊'), findsOneWidget);
      });
    });

    group('description display', () {
      testWidgets('displays description when present', (tester) async {
        final summary = createSummary(description: 'A collection of favorites');

        await tester.pumpWidget(buildTestWidget(summary: summary));
        await tester.pump();

        expect(find.text('A collection of favorites'), findsOneWidget);
      });

      testWidgets('does not display description when null', (tester) async {
        final summary = createSummary(description: null);

        await tester.pumpWidget(buildTestWidget(summary: summary));
        await tester.pump();

        final descriptionTexts = find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              widget.data != summary.title &&
              widget.data != '${summary.bookCount}冊',
        );
        expect(descriptionTexts, findsNothing);
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
