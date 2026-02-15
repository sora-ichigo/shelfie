import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_search/presentation/widgets/search_bar_widget.dart';

void main() {
  Widget buildSearchBarWidget({
    void Function(String)? onChanged,
    TextEditingController? controller,
  }) {
    return MaterialApp(
      theme: AppTheme.dark(),
      home: Scaffold(
        body: SearchBarWidget(
          onChanged: onChanged ?? (_) {},
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

    testWidgets('テキスト入力時にコールバックが呼ばれる', (tester) async {
      String? changedValue;

      await tester.pumpWidget(
        buildSearchBarWidget(onChanged: (value) => changedValue = value),
      );

      await tester.enterText(find.byType(TextField), 'テスト');

      expect(changedValue, 'テスト');
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

    group('クリアボタン', () {
      testWidgets('テキストが空のときはクリアボタンが表示されない', (tester) async {
        final controller = TextEditingController();

        await tester.pumpWidget(
          buildSearchBarWidget(controller: controller),
        );

        expect(find.byIcon(Icons.clear), findsNothing);
      });

      testWidgets('テキストが入力されているときはクリアボタンが表示される', (tester) async {
        final controller = TextEditingController(text: 'テスト');

        await tester.pumpWidget(
          buildSearchBarWidget(controller: controller),
        );

        expect(find.byIcon(Icons.clear), findsOneWidget);
      });

      testWidgets('クリアボタンをタップすると入力がクリアされる', (tester) async {
        final controller = TextEditingController(text: 'テスト');

        await tester.pumpWidget(
          buildSearchBarWidget(controller: controller),
        );

        await tester.tap(find.byIcon(Icons.clear));
        await tester.pump();

        expect(controller.text, isEmpty);
      });

      testWidgets('クリアボタンをタップするとonChangedが空文字で呼ばれる',
          (tester) async {
        final controller = TextEditingController(text: 'テスト');
        String? changedValue;

        await tester.pumpWidget(
          buildSearchBarWidget(
            controller: controller,
            onChanged: (value) => changedValue = value,
          ),
        );

        await tester.tap(find.byIcon(Icons.clear));
        await tester.pump();

        expect(changedValue, '');
      });
    });
  });
}
