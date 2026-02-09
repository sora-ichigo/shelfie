import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/no_books_message.dart';

import '../../../../../helpers/test_helpers.dart';

void main() {
  setUpAll(registerTestFallbackValues);

  group('NoBooksMessage', () {
    testWidgets('auto_stories_outlined アイコンが表示される', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(child: NoBooksMessage(onAddBookPressed: () {})),
      );

      final icon = tester.widget<Icon>(
        find.byIcon(Icons.auto_stories_outlined),
      );
      expect(icon.size, 64);
      expect(icon.color, AppColors.dark.textSecondary);
    });

    testWidgets('タイトルが表示される', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(child: NoBooksMessage(onAddBookPressed: () {})),
      );

      expect(find.text('本を追加してみましょう'), findsOneWidget);
    });

    testWidgets('説明文が表示される', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(child: NoBooksMessage(onAddBookPressed: () {})),
      );

      expect(find.text('好きな本を検索して、\n本棚に追加しましょう'), findsOneWidget);
    });

    testWidgets('「本を追加する」ボタンが表示される', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(child: NoBooksMessage(onAddBookPressed: () {})),
      );

      expect(find.widgetWithText(FilledButton, '本を追加する'), findsOneWidget);
    });

    testWidgets('ボタンタップで onAddBookPressed が呼ばれる', (tester) async {
      var pressed = false;

      await tester.pumpWidget(
        buildTestWidget(
          child: NoBooksMessage(onAddBookPressed: () => pressed = true),
        ),
      );

      await tester.tap(find.text('本を追加する'));
      expect(pressed, isTrue);
    });

    testWidgets('アイコンがタイトルの上に表示される', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(child: NoBooksMessage(onAddBookPressed: () {})),
      );

      final iconPos = tester.getCenter(
        find.byIcon(Icons.auto_stories_outlined),
      );
      final textPos = tester.getCenter(find.text('本を追加してみましょう'));
      expect(iconPos.dy, lessThan(textPos.dy));
    });

    testWidgets('Center でラップされている', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(child: NoBooksMessage(onAddBookPressed: () {})),
      );

      expect(find.byType(Center), findsWidgets);
    });
  });
}
