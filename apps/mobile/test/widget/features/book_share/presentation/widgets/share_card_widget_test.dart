import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_share/domain/share_card_data.dart';
import 'package:shelfie/features/book_share/presentation/widgets/share_card_widget.dart';

void main() {
  final boundaryKey = GlobalKey();

  ShareCardData createCardData({
    String? thumbnailUrl = 'https://example.com/cover.jpg',
  }) {
    return ShareCardData(
      title: 'テスト書籍タイトル',
      authors: ['著者A', '著者B'],
      thumbnailUrl: thumbnailUrl,
    );
  }

  Widget buildTestWidget({required ShareCardData data}) {
    return MaterialApp(
      theme: AppTheme.dark(),
      home: Scaffold(
        body: ShareCardWidget(
          data: data,
          boundaryKey: boundaryKey,
        ),
      ),
    );
  }

  group('ShareCardWidget', () {
    testWidgets('タイトルが表示される', (tester) async {
      await tester.pumpWidget(buildTestWidget(data: createCardData()));

      expect(find.text('テスト書籍タイトル'), findsOneWidget);
    });

    testWidgets('著者名が表示される', (tester) async {
      await tester.pumpWidget(buildTestWidget(data: createCardData()));

      expect(find.text('著者A, 著者B'), findsOneWidget);
    });

    testWidgets('Shelfie ロゴテキストが表示される', (tester) async {
      await tester.pumpWidget(buildTestWidget(data: createCardData()));

      expect(find.text('Shelfie'), findsOneWidget);
    });

    testWidgets('表紙画像が表示される', (tester) async {
      await tester.pumpWidget(buildTestWidget(data: createCardData()));

      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets('表紙画像が null の場合、プレースホルダーが表示される',
        (tester) async {
      await tester.pumpWidget(
        buildTestWidget(data: createCardData(thumbnailUrl: null)),
      );

      expect(find.byType(CachedNetworkImage), findsNothing);
      expect(find.byIcon(Icons.book), findsOneWidget);
    });

    testWidgets('RepaintBoundary が存在する', (tester) async {
      await tester.pumpWidget(buildTestWidget(data: createCardData()));

      expect(find.byType(RepaintBoundary), findsWidgets);
    });

    testWidgets('accentColor を渡すと背景色がアクセントカラーになる', (tester) async {
      const testColor = Color(0xFF017BC8);
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ShareCardWidget(
              data: createCardData(),
              boundaryKey: boundaryKey,
              accentColor: testColor,
            ),
          ),
        ),
      );

      final container = tester.widgetList<Container>(find.byType(Container)).where(
        (c) {
          final decoration = c.decoration;
          if (decoration is! BoxDecoration) return false;
          return decoration.color == testColor;
        },
      );
      expect(container.length, 1);
    });

    testWidgets('accentColor が null の場合、単色背景になる', (tester) async {
      await tester.pumpWidget(buildTestWidget(data: createCardData()));

      final container = tester.widgetList<Container>(find.byType(Container)).where(
        (c) {
          final decoration = c.decoration;
          if (decoration is! BoxDecoration) return false;
          return decoration.gradient == null && decoration.color != null;
        },
      );
      expect(container.isNotEmpty, isTrue);
    });
  });
}
