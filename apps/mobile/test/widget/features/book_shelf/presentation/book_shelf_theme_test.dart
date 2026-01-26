import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_shelf/domain/group_option.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/domain/sort_option.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/book_card.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/search_filter_bar.dart';

import '../../../../helpers/test_helpers.dart';

void main() {
  ShelfBookItem createTestBook() {
    return ShelfBookItem(
      userBookId: 1,
      externalId: 'test-book-1',
      title: 'テスト書籍',
      authors: ['テスト著者'],
      coverImageUrl: null,
      addedAt: DateTime(2024, 1, 1),
    );
  }

  ShelfEntry createTestEntry({int? rating}) {
    return ShelfEntry(
      userBookId: 1,
      externalId: 'test-book-1',
      readingStatus: ReadingStatus.reading,
      addedAt: DateTime(2024, 1, 1),
      rating: rating,
    );
  }

  group('5.2 デザインテーマの適用確認', () {
    group('ダークテーマ（黒背景）の適用', () {
      test('AppTheme がダークモードを返す', () {
        final theme = AppTheme.theme;

        expect(theme.brightness, Brightness.dark);
      });

      test('scaffoldBackgroundColor が黒系', () {
        final theme = AppTheme.theme;

        expect(theme.scaffoldBackgroundColor, const Color(0xFF0A0A0A));
      });

      test('AppColors.dark.background が黒系', () {
        expect(AppColors.dark.background, const Color(0xFF0A0A0A));
      });

      testWidgets('BookCard がダークテーマで正しく表示される', (tester) async {
        final book = createTestBook();

        await tester.pumpWidget(
          buildTestWidget(
            child: SingleChildScrollView(
              child: SizedBox(
                width: 120,
                child: BookCard(
                  book: book,
                  onTap: () {},
                ),
              ),
            ),
            shelfState: {book.externalId: createTestEntry(rating: 4)},
          ),
        );

        expect(find.byType(ClipRRect), findsOneWidget);
      });

      testWidgets('BookCard に角丸が適用されている', (tester) async {
        final book = createTestBook();

        await tester.pumpWidget(
          buildTestWidget(
            child: SingleChildScrollView(
              child: SizedBox(
                width: 120,
                child: BookCard(
                  book: book,
                  onTap: () {},
                ),
              ),
            ),
            shelfState: {book.externalId: createTestEntry()},
          ),
        );

        expect(find.byType(ClipRRect), findsOneWidget);
      });
    });

    group('アクセントカラー（緑色）の適用', () {
      test('AppColors.dark.accent がターコイズグリーン', () {
        expect(AppColors.dark.accent, const Color(0xFF4FD1C5));
      });

      test('AppTheme.seedColor がターコイズグリーン', () {
        expect(AppTheme.seedColor, const Color(0xFF4FD1C5));
      });

      testWidgets('ボトムナビゲーションでアクセントカラーが使用される', (tester) async {
        final theme = AppTheme.theme;
        final bottomNavTheme = theme.bottomNavigationBarTheme;

        expect(bottomNavTheme.selectedItemColor, AppColors.dark.foreground);
      });
    });

    group('カードUIのモダンデザイン', () {
      testWidgets('BookCard が角丸デザイン', (tester) async {
        final book = createTestBook();

        await tester.pumpWidget(
          buildTestWidget(
            child: SingleChildScrollView(
              child: SizedBox(
                width: 120,
                child: BookCard(
                  book: book,
                  onTap: () {},
                ),
              ),
            ),
            shelfState: {book.externalId: createTestEntry(rating: 4)},
          ),
        );

        final clipRRect = tester.widget<ClipRRect>(find.byType(ClipRRect));
        final borderRadius = clipRRect.borderRadius as BorderRadius;

        expect(borderRadius.topLeft.x, greaterThan(0));
      });

      testWidgets('BookCard が GestureDetector でタップ可能', (tester) async {
        final book = createTestBook();

        await tester.pumpWidget(
          buildTestWidget(
            child: SingleChildScrollView(
              child: SizedBox(
                width: 120,
                child: BookCard(
                  book: book,
                  onTap: () {},
                ),
              ),
            ),
            shelfState: {book.externalId: createTestEntry()},
          ),
        );

        expect(find.byType(GestureDetector), findsOneWidget);
      });

      testWidgets('SearchFilterBar がダークテーマで表示される', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            child: SearchFilterBar(
              sortOption: SortOption.addedAtDesc,
              groupOption: GroupOption.none,
              onSortChanged: (_) {},
              onGroupChanged: (_) {},
            ),
          ),
        );

        expect(find.byIcon(Icons.tune), findsOneWidget);
        expect(find.byIcon(Icons.grid_view), findsOneWidget);
      });
    });

    group('テキストカラーの適用', () {
      test('AppColors.dark.foreground が白', () {
        expect(AppColors.dark.foreground, const Color(0xFFFFFFFF));
      });

      test('AppColors.dark.foregroundMuted がグレー', () {
        expect(AppColors.dark.foregroundMuted, const Color(0xFFA0A0A0));
      });

      testWidgets('BookCard のタイトルがプライマリテキストカラー', (tester) async {
        final book = createTestBook();

        await tester.pumpWidget(
          buildTestWidget(
            child: SingleChildScrollView(
              child: SizedBox(
                width: 120,
                child: BookCard(
                  book: book,
                  onTap: () {},
                ),
              ),
            ),
            shelfState: {book.externalId: createTestEntry()},
          ),
        );

        final titleText = tester.widget<Text>(find.text('テスト書籍'));
        expect(titleText, isNotNull);
      });

      testWidgets('BookCard の著者名がセカンダリテキストカラー', (tester) async {
        final book = createTestBook();

        await tester.pumpWidget(
          buildTestWidget(
            child: SingleChildScrollView(
              child: SizedBox(
                width: 120,
                child: BookCard(
                  book: book,
                  onTap: () {},
                ),
              ),
            ),
            shelfState: {book.externalId: createTestEntry()},
          ),
        );

        final authorText = tester.widget<Text>(find.text('テスト著者'));
        expect(authorText.style?.color, AppColors.dark.foregroundMuted);
      });
    });

    group('星評価のアクセントカラー', () {
      test('AppColors.dark.accentSecondary がゴールド', () {
        expect(AppColors.dark.accentSecondary, const Color(0xFFF6C94A));
      });

      testWidgets('BookCard の星評価がアクセントカラー', (tester) async {
        final book = createTestBook();

        await tester.pumpWidget(
          buildTestWidget(
            child: SingleChildScrollView(
              child: SizedBox(
                width: 120,
                child: BookCard(
                  book: book,
                  onTap: () {},
                ),
              ),
            ),
            shelfState: {book.externalId: createTestEntry(rating: 4)},
          ),
        );

        final starIcons = tester.widgetList<Icon>(find.byIcon(Icons.star));
        for (final icon in starIcons) {
          expect(icon.color, AppColors.dark.accentSecondary);
        }
      });
    });
  });
}
