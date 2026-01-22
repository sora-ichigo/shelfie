import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_search/presentation/widgets/search_bar_widget.dart';

void main() {
  Widget buildSearchBarWidget({
    void Function(String)? onChanged,
    VoidCallback? onScanPressed,
    TextEditingController? controller,
  }) {
    return MaterialApp(
      theme: AppTheme.dark(),
      home: Scaffold(
        body: SearchBarWidget(
          onChanged: onChanged ?? (_) {},
          onScanPressed: onScanPressed ?? () {},
          controller: controller,
        ),
      ),
    );
  }

  group('SearchBarWidget', () {
    testWidgets('テキストフィールドが表示される', (tester) async {
      await tester.pumpWidget(buildSearchBarWidget());

      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('プレースホルダーテキストが表示される', (tester) async {
      await tester.pumpWidget(buildSearchBarWidget());

      expect(find.text('書籍を検索...'), findsOneWidget);
    });

    testWidgets('検索アイコンが表示される', (tester) async {
      await tester.pumpWidget(buildSearchBarWidget());

      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('ISBNスキャンボタンが表示される', (tester) async {
      await tester.pumpWidget(buildSearchBarWidget());

      expect(find.byIcon(Icons.qr_code_scanner), findsOneWidget);
    });

    testWidgets('テキスト入力時にコールバックが呼ばれる', (tester) async {
      String? changedValue;

      await tester.pumpWidget(
        buildSearchBarWidget(onChanged: (value) => changedValue = value),
      );

      await tester.enterText(find.byType(TextField), 'テスト');

      expect(changedValue, 'テスト');
    });

    testWidgets('スキャンボタンタップ時にコールバックが呼ばれる', (tester) async {
      var scanPressed = false;

      await tester.pumpWidget(
        buildSearchBarWidget(onScanPressed: () => scanPressed = true),
      );

      await tester.tap(find.byIcon(Icons.qr_code_scanner));

      expect(scanPressed, isTrue);
    });

    testWidgets('コントローラーが正しく動作する', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        buildSearchBarWidget(controller: controller),
      );

      controller.text = '外部からの入力';
      await tester.pump();

      expect(find.text('外部からの入力'), findsOneWidget);
    });
  });
}
