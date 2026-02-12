import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/features/account/presentation/widgets/no_book_lists_message.dart';

import '../../../../helpers/test_helpers.dart';

void main() {
  setUpAll(registerTestFallbackValues);

  group('NoBookListsMessage', () {
    testWidgets('collections_bookmark_outlined アイコンが表示される',
        (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
            child: NoBookListsMessage(onCreateListPressed: () {})),
      );

      final icon = tester.widget<Icon>(
        find.byIcon(Icons.library_books_rounded),
      );
      expect(icon.size, 64);
      expect(icon.color, AppColors.dark.textSecondary);
    });

    testWidgets('タイトルが表示される', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
            child: NoBookListsMessage(onCreateListPressed: () {})),
      );

      expect(find.text('リストを作成してみましょう'), findsOneWidget);
    });

    testWidgets('説明文が表示される', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
            child: NoBookListsMessage(onCreateListPressed: () {})),
      );

      expect(find.text('お気に入りの本をまとめて、\nリストを作りましょう'), findsOneWidget);
    });

    testWidgets('「リストを作成する」ボタンが表示される', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
            child: NoBookListsMessage(onCreateListPressed: () {})),
      );

      expect(
          find.widgetWithText(FilledButton, 'リストを作成する'), findsOneWidget);
    });

    testWidgets('ボタンタップで onCreateListPressed が呼ばれる', (tester) async {
      var pressed = false;

      await tester.pumpWidget(
        buildTestWidget(
          child:
              NoBookListsMessage(onCreateListPressed: () => pressed = true),
        ),
      );

      await tester.tap(find.text('リストを作成する'));
      expect(pressed, isTrue);
    });

    testWidgets('アイコンがタイトルの上に表示される', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
            child: NoBookListsMessage(onCreateListPressed: () {})),
      );

      final iconPos = tester.getCenter(
        find.byIcon(Icons.library_books_rounded),
      );
      final textPos = tester.getCenter(find.text('リストを作成してみましょう'));
      expect(iconPos.dy, lessThan(textPos.dy));
    });

    testWidgets('Center でラップされている', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
            child: NoBookListsMessage(onCreateListPressed: () {})),
      );

      expect(find.byType(Center), findsWidgets);
    });
  });
}
