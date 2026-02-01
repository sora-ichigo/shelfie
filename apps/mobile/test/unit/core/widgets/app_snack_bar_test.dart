import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/widgets/app_snack_bar.dart';

void main() {
  Widget buildApp({required Widget child}) {
    return MaterialApp(
      theme: ThemeData(
        extensions: const [AppColors.dark],
      ),
      home: Scaffold(body: child),
    );
  }

  group('SnackBarType', () {
    test('4種類の型が定義されている', () {
      expect(SnackBarType.values.length, 4);
      expect(SnackBarType.values, contains(SnackBarType.info));
      expect(SnackBarType.values, contains(SnackBarType.success));
      expect(SnackBarType.values, contains(SnackBarType.warning));
      expect(SnackBarType.values, contains(SnackBarType.error));
    });
  });

  group('AppSnackBar.show', () {
    testWidgets('メッセージが表示される', (tester) async {
      await tester.pumpWidget(
        buildApp(
          child: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => AppSnackBar.show(
                context,
                message: 'テストメッセージ',
                type: SnackBarType.info,
              ),
              child: const Text('Show'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      expect(find.text('テストメッセージ'), findsOneWidget);
    });

    testWidgets('SnackBar が floating behavior で表示される', (tester) async {
      await tester.pumpWidget(
        buildApp(
          child: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => AppSnackBar.show(
                context,
                message: 'テスト',
                type: SnackBarType.success,
              ),
              child: const Text('Show'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      expect(snackBar.behavior, SnackBarBehavior.floating);
    });

    testWidgets('success タイプで正しい背景色が使われる', (tester) async {
      await tester.pumpWidget(
        buildApp(
          child: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => AppSnackBar.show(
                context,
                message: '成功',
                type: SnackBarType.success,
              ),
              child: const Text('Show'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      expect(snackBar.backgroundColor, AppColors.dark.success);
    });

    testWidgets('error タイプで正しい背景色が使われる', (tester) async {
      await tester.pumpWidget(
        buildApp(
          child: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => AppSnackBar.show(
                context,
                message: 'エラー',
                type: SnackBarType.error,
              ),
              child: const Text('Show'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      expect(snackBar.backgroundColor, AppColors.dark.error);
    });

    testWidgets('warning タイプで正しい背景色が使われる', (tester) async {
      await tester.pumpWidget(
        buildApp(
          child: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => AppSnackBar.show(
                context,
                message: '警告',
                type: SnackBarType.warning,
              ),
              child: const Text('Show'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      expect(snackBar.backgroundColor, AppColors.dark.warning);
    });

    testWidgets('info タイプで正しい背景色が使われる', (tester) async {
      await tester.pumpWidget(
        buildApp(
          child: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => AppSnackBar.show(
                context,
                message: '情報',
                type: SnackBarType.info,
              ),
              child: const Text('Show'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      expect(snackBar.backgroundColor, AppColors.dark.info);
    });

    testWidgets('既存の SnackBar がクリアされてから新しいものが表示される',
        (tester) async {
      await tester.pumpWidget(
        buildApp(
          child: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => AppSnackBar.show(
                context,
                message: '新しいメッセージ',
                type: SnackBarType.info,
              ),
              child: const Text('Show'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      expect(find.text('新しいメッセージ'), findsOneWidget);
    });

    testWidgets('action パラメータが指定された場合、アクションボタンが表示される',
        (tester) async {
      var actionPressed = false;

      await tester.pumpWidget(
        buildApp(
          child: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => AppSnackBar.show(
                context,
                message: 'テスト',
                type: SnackBarType.info,
                action: '取り消し',
                onActionPressed: () {
                  actionPressed = true;
                },
              ),
              child: const Text('Show'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      expect(find.text('取り消し'), findsOneWidget);

      await tester.tap(find.text('取り消し'));
      await tester.pumpAndSettle();

      expect(actionPressed, isTrue);
    });
  });
}
