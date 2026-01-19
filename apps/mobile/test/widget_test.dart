import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/app/app.dart';
import 'package:shelfie/core/theme/app_theme.dart';

void main() {
  group('ShelfieApp', () {
    testWidgets('アプリが正常に起動すること', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: ShelfieApp(),
        ),
      );

      // アプリが起動してウィジェットが表示されることを確認
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('ダークモードテーマが適用されていること', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: ShelfieApp(),
        ),
      );

      final materialApp =
          tester.widget<MaterialApp>(find.byType(MaterialApp));

      // ダークモードが適用されていることを確認
      expect(materialApp.theme?.brightness, equals(Brightness.dark));
    });

    testWidgets('AppTheme のテーマが適用されていること', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: ShelfieApp(),
        ),
      );

      final materialApp =
          tester.widget<MaterialApp>(find.byType(MaterialApp));

      // Material 3 が有効になっていることを確認
      expect(materialApp.theme?.useMaterial3, isTrue);

      // シードカラーが正しく設定されていることを確認
      expect(
        materialApp.theme?.colorScheme.primary,
        equals(AppTheme.theme.colorScheme.primary),
      );
    });

    testWidgets('プレースホルダーホーム画面が表示されること', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: ShelfieApp(),
        ),
      );

      // Welcome メッセージが表示されていることを確認
      expect(find.text('Welcome to Shelfie'), findsOneWidget);
    });

    testWidgets('AppBar に Shelfie タイトルが表示されること', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: ShelfieApp(),
        ),
      );

      // AppBar のタイトルが表示されていることを確認
      expect(find.text('Shelfie'), findsOneWidget);
    });
  });
}
