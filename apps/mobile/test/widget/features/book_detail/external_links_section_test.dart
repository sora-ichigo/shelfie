import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_detail/presentation/widgets/external_links_section.dart';

void main() {
  Widget buildTestWidget({
    String? amazonUrl,
    String? infoLink,
    void Function(String)? onLinkTap,
  }) {
    return MaterialApp(
      theme: AppTheme.dark(),
      home: Scaffold(
        body: ExternalLinksSection(
          amazonUrl: amazonUrl,
          infoLink: infoLink,
          onLinkTap: onLinkTap ?? (_) {},
        ),
      ),
    );
  }

  group('ExternalLinksSection', () {
    testWidgets('セクションタイトルが表示される', (tester) async {
      await tester.pumpWidget(buildTestWidget(amazonUrl: 'https://amazon.com/test'));

      expect(find.text('購入・詳細'), findsOneWidget);
    });

    testWidgets('AmazonURLがある場合「Amazonで見る」リンクが表示される', (tester) async {
      await tester.pumpWidget(buildTestWidget(amazonUrl: 'https://amazon.com/test'));

      expect(find.text('Amazonで見る'), findsOneWidget);
    });

    testWidgets('AmazonURLがない場合「Amazonで見る」リンクが表示されない', (tester) async {
      await tester.pumpWidget(buildTestWidget(infoLink: 'https://example.com'));

      expect(find.text('Amazonで見る'), findsNothing);
    });

    testWidgets('infoLinkがある場合「公式サイトへ」リンクが表示される', (tester) async {
      await tester.pumpWidget(buildTestWidget(infoLink: 'https://books.google.com/test'));

      expect(find.text('公式サイトへ'), findsOneWidget);
    });

    testWidgets('infoLinkがない場合「公式サイトへ」リンクが表示されない', (tester) async {
      await tester.pumpWidget(buildTestWidget(amazonUrl: 'https://amazon.com/test'));

      expect(find.text('公式サイトへ'), findsNothing);
    });

    testWidgets('Amazonリンクをタップするとコールバックが呼ばれる', (tester) async {
      String? tappedUrl;
      await tester.pumpWidget(
        buildTestWidget(
          amazonUrl: 'https://amazon.com/test',
          onLinkTap: (url) => tappedUrl = url,
        ),
      );

      await tester.tap(find.text('Amazonで見る'));
      await tester.pump();

      expect(tappedUrl, 'https://amazon.com/test');
    });

    testWidgets('公式サイトリンクをタップするとコールバックが呼ばれる', (tester) async {
      String? tappedUrl;
      await tester.pumpWidget(
        buildTestWidget(
          infoLink: 'https://books.google.com/test',
          onLinkTap: (url) => tappedUrl = url,
        ),
      );

      await tester.tap(find.text('公式サイトへ'));
      await tester.pump();

      expect(tappedUrl, 'https://books.google.com/test');
    });

    testWidgets('両方のリンクがある場合両方表示される', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          amazonUrl: 'https://amazon.com/test',
          infoLink: 'https://books.google.com/test',
        ),
      );

      expect(find.text('Amazonで見る'), findsOneWidget);
      expect(find.text('公式サイトへ'), findsOneWidget);
    });

    testWidgets('両方のリンクがない場合何も表示されない', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.text('購入・詳細'), findsNothing);
      expect(find.text('Amazonで見る'), findsNothing);
      expect(find.text('公式サイトへ'), findsNothing);
    });
  });
}
