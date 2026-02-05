import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_share/domain/share_card_data.dart';
import 'package:shelfie/features/book_share/domain/share_card_level.dart';
import 'package:shelfie/features/book_share/presentation/widgets/share_card_widget.dart';

void main() {
  final now = DateTime(2025, 1, 15);
  final boundaryKey = GlobalKey();

  ShareCardData createCardData({
    String? thumbnailUrl = 'https://example.com/cover.jpg',
    int? rating,
    String? note,
    String? userName = 'テストユーザー',
    String? avatarUrl = 'https://example.com/avatar.jpg',
  }) {
    return ShareCardData(
      title: 'テスト書籍タイトル',
      authors: ['著者A', '著者B'],
      thumbnailUrl: thumbnailUrl,
      userName: userName,
      avatarUrl: avatarUrl,
      rating: rating,
      completedAt: now,
      note: note,
    );
  }

  Widget buildTestWidget({
    required ShareCardLevel level,
    required ShareCardData data,
  }) {
    return MaterialApp(
      theme: AppTheme.dark(),
      home: Scaffold(
        body: ShareCardWidget(
          level: level,
          data: data,
          boundaryKey: boundaryKey,
        ),
      ),
    );
  }

  group('ShareCardWidget', () {
    group('シンプルカード', () {
      testWidgets('タイトルが表示される', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          level: ShareCardLevel.simple,
          data: createCardData(),
        ));

        expect(find.text('テスト書籍タイトル'), findsOneWidget);
      });

      testWidgets('著者名が表示される', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          level: ShareCardLevel.simple,
          data: createCardData(),
        ));

        expect(find.text('著者A, 著者B'), findsOneWidget);
      });

      testWidgets('Shelfie ロゴテキストが表示される', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          level: ShareCardLevel.simple,
          data: createCardData(),
        ));

        expect(find.text('Shelfie'), findsOneWidget);
      });

      testWidgets('表紙画像が表示される', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          level: ShareCardLevel.simple,
          data: createCardData(),
        ));

        expect(find.byType(CachedNetworkImage), findsOneWidget);
      });

      testWidgets('表紙画像が null の場合、プレースホルダーが表示される',
          (tester) async {
        await tester.pumpWidget(buildTestWidget(
          level: ShareCardLevel.simple,
          data: createCardData(thumbnailUrl: null),
        ));

        expect(find.byType(CachedNetworkImage), findsNothing);
        expect(find.byIcon(Icons.book), findsOneWidget);
      });
    });

    group('プロフィール付きカード', () {
      testWidgets('タイトルと著者名が表示される', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          level: ShareCardLevel.profile,
          data: createCardData(rating: 4),
        ));

        expect(find.text('テスト書籍タイトル'), findsOneWidget);
        expect(find.text('著者A, 著者B'), findsOneWidget);
      });

      testWidgets('星評価が表示される', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          level: ShareCardLevel.profile,
          data: createCardData(rating: 4),
        ));

        expect(find.byIcon(Icons.star_rounded), findsNWidgets(5));
      });

      testWidgets('読了日が表示される', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          level: ShareCardLevel.profile,
          data: createCardData(rating: 4),
        ));

        expect(find.text('2025.01.15 読了'), findsOneWidget);
      });

      testWidgets('ユーザー名が表示される', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          level: ShareCardLevel.profile,
          data: createCardData(rating: 4),
        ));

        expect(find.text('テストユーザー'), findsOneWidget);
      });
    });

    group('感想共有カード', () {
      testWidgets('読書メモが表示される', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          level: ShareCardLevel.review,
          data: createCardData(rating: 5, note: 'この本は素晴らしかった'),
        ));

        expect(find.text('この本は素晴らしかった'), findsOneWidget);
      });

      testWidgets('タイトル、著者名、星評価が表示される', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          level: ShareCardLevel.review,
          data: createCardData(rating: 5, note: 'メモ'),
        ));

        expect(find.text('テスト書籍タイトル'), findsOneWidget);
        expect(find.text('著者A, 著者B'), findsOneWidget);
        expect(find.byIcon(Icons.star_rounded), findsNWidgets(5));
      });

      testWidgets('ユーザー名と読了日が表示される', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          level: ShareCardLevel.review,
          data: createCardData(rating: 5, note: 'メモ'),
        ));

        expect(find.text('テストユーザー'), findsOneWidget);
        expect(find.text('2025.01.15 読了'), findsOneWidget);
      });
    });

    group('RepaintBoundary', () {
      testWidgets('RepaintBoundary が存在する', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          level: ShareCardLevel.simple,
          data: createCardData(),
        ));

        expect(find.byType(RepaintBoundary), findsWidgets);
      });
    });
  });
}
