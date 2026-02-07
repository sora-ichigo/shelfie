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
        buildTestWidget(child: const NoBooksMessage()),
      );

      final icon = tester.widget<Icon>(
        find.byIcon(Icons.auto_stories_outlined),
      );
      expect(icon.size, 64);
      expect(icon.color, AppColors.dark.textSecondary);
    });

    testWidgets('メッセージが表示される', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(child: const NoBooksMessage()),
      );

      final text = tester.widget<Text>(find.text('「さがす」タブから本を追加してみましょう'));
      expect(text.style?.color, AppColors.dark.textSecondary);
    });

    testWidgets('アイコンがメッセージの上に表示される', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(child: const NoBooksMessage()),
      );

      final iconPos = tester.getCenter(
        find.byIcon(Icons.auto_stories_outlined),
      );
      final textPos = tester.getCenter(find.text('「さがす」タブから本を追加してみましょう'));
      expect(iconPos.dy, lessThan(textPos.dy));
    });

    testWidgets('Center でラップされている', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(child: const NoBooksMessage()),
      );

      expect(find.byType(Center), findsWidgets);
    });
  });
}
