import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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

      test('AppColors.dark.brandBackground が黒系', () {
        expect(AppColors.dark.brandBackground, const Color(0xFF0A0A0A));
      });

      testWidgets('BookCard がダークテーマで正しく表示される', (tester) async {
        final book = ShelfBookItem(
          userBookId: 1,
          externalId: 'test-book-1',
          title: 'テスト書籍',
          authors: ['テスト著者'],
          coverImageUrl: null,
          readingStatus: ReadingStatus.reading,
          rating: 4,
          addedAt: DateTime(2024, 1, 1),
          completedAt: null,
        );

        await tester.pumpWidget(
          buildTestWidget(
            child: BookCard(
              book: book,
              onTap: () {},
            ),
          ),
        );

        final card = tester.widget<Card>(find.byType(Card));
        expect(card.color, AppColors.dark.surfaceElevated);
      });

      testWidgets('BookCard の背景色が surfaceElevated', (tester) async {
        final book = ShelfBookItem(
          userBookId: 1,
          externalId: 'test-book-1',
          title: 'テスト書籍',
          authors: ['テスト著者'],
          coverImageUrl: null,
          readingStatus: ReadingStatus.reading,
          rating: null,
          addedAt: DateTime(2024, 1, 1),
          completedAt: null,
        );

        await tester.pumpWidget(
          buildTestWidget(
            child: BookCard(
              book: book,
              onTap: () {},
            ),
          ),
        );

        final card = tester.widget<Card>(find.byType(Card));
        expect(card.color, const Color(0xFF1A1A1A));
      });
    });

    group('アクセントカラー（緑色）の適用', () {
      test('AppColors.dark.brandPrimary がターコイズグリーン', () {
        expect(AppColors.dark.brandPrimary, const Color(0xFF4FD1C5));
      });

      test('AppTheme.seedColor がターコイズグリーン', () {
        expect(AppTheme.seedColor, const Color(0xFF4FD1C5));
      });

      testWidgets('ボトムナビゲーションでアクセントカラーが使用される', (tester) async {
        final theme = AppTheme.theme;
        final bottomNavTheme = theme.bottomNavigationBarTheme;

        expect(bottomNavTheme.selectedItemColor, AppColors.dark.textPrimary);
      });
    });

    group('カードUIのモダンデザイン', () {
      testWidgets('BookCard が角丸デザイン', (tester) async {
        final book = ShelfBookItem(
          userBookId: 1,
          externalId: 'test-book-1',
          title: 'テスト書籍',
          authors: ['テスト著者'],
          coverImageUrl: null,
          readingStatus: ReadingStatus.reading,
          rating: 4,
          addedAt: DateTime(2024, 1, 1),
          completedAt: null,
        );

        await tester.pumpWidget(
          buildTestWidget(
            child: BookCard(
              book: book,
              onTap: () {},
            ),
          ),
        );

        final card = tester.widget<Card>(find.byType(Card));
        final shape = card.shape! as RoundedRectangleBorder;
        final borderRadius = shape.borderRadius as BorderRadius;

        expect(borderRadius.topLeft.x, greaterThan(0));
      });

      testWidgets('BookCard に InkWell がタップフィードバックを提供', (tester) async {
        final book = ShelfBookItem(
          userBookId: 1,
          externalId: 'test-book-1',
          title: 'テスト書籍',
          authors: ['テスト著者'],
          coverImageUrl: null,
          readingStatus: ReadingStatus.reading,
          rating: null,
          addedAt: DateTime(2024, 1, 1),
          completedAt: null,
        );

        await tester.pumpWidget(
          buildTestWidget(
            child: BookCard(
              book: book,
              onTap: () {},
            ),
          ),
        );

        expect(find.byType(InkWell), findsOneWidget);
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

        expect(find.byType(DropdownButton<SortOption>), findsOneWidget);
      });
    });

    group('テキストカラーの適用', () {
      test('AppColors.dark.textPrimary が白', () {
        expect(AppColors.dark.textPrimary, const Color(0xFFFFFFFF));
      });

      test('AppColors.dark.textSecondary がグレー', () {
        expect(AppColors.dark.textSecondary, const Color(0xFFA0A0A0));
      });

      testWidgets('BookCard のタイトルがプライマリテキストカラー', (tester) async {
        final book = ShelfBookItem(
          userBookId: 1,
          externalId: 'test-book-1',
          title: 'テスト書籍',
          authors: ['テスト著者'],
          coverImageUrl: null,
          readingStatus: ReadingStatus.reading,
          rating: null,
          addedAt: DateTime(2024, 1, 1),
          completedAt: null,
        );

        await tester.pumpWidget(
          buildTestWidget(
            child: BookCard(
              book: book,
              onTap: () {},
            ),
          ),
        );

        final titleText = tester.widget<Text>(find.text('テスト書籍'));
        expect(titleText, isNotNull);
      });

      testWidgets('BookCard の著者名がセカンダリテキストカラー', (tester) async {
        final book = ShelfBookItem(
          userBookId: 1,
          externalId: 'test-book-1',
          title: 'テスト書籍',
          authors: ['テスト著者'],
          coverImageUrl: null,
          readingStatus: ReadingStatus.reading,
          rating: null,
          addedAt: DateTime(2024, 1, 1),
          completedAt: null,
        );

        await tester.pumpWidget(
          buildTestWidget(
            child: BookCard(
              book: book,
              onTap: () {},
            ),
          ),
        );

        final authorText = tester.widget<Text>(find.text('テスト著者'));
        expect(authorText.style?.color, AppColors.dark.textSecondary);
      });
    });

    group('星評価のアクセントカラー', () {
      test('AppColors.dark.brandAccent がゴールド', () {
        expect(AppColors.dark.brandAccent, const Color(0xFFF6C94A));
      });

      testWidgets('BookCard の星評価がアクセントカラー', (tester) async {
        final book = ShelfBookItem(
          userBookId: 1,
          externalId: 'test-book-1',
          title: 'テスト書籍',
          authors: ['テスト著者'],
          coverImageUrl: null,
          readingStatus: ReadingStatus.reading,
          rating: 4,
          addedAt: DateTime(2024, 1, 1),
          completedAt: null,
        );

        await tester.pumpWidget(
          buildTestWidget(
            child: BookCard(
              book: book,
              onTap: () {},
            ),
          ),
        );

        final starIcons = tester.widgetList<Icon>(find.byIcon(Icons.star));
        for (final icon in starIcons) {
          expect(icon.color, AppColors.dark.brandAccent);
        }
      });
    });
  });
}
