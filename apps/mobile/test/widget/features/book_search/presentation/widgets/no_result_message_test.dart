import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/features/book_search/presentation/widgets/no_result_message.dart';

import '../../../../../helpers/test_helpers.dart';

void main() {
  setUpAll(registerTestFallbackValues);

  group('NoResultMessage', () {
    testWidgets('search_off アイコンが表示される', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(child: const NoResultMessage(query: 'テスト')),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.search_off));
      expect(icon.size, 64);
      expect(icon.color, AppColors.dark.inactive);
    });

    testWidgets('タイトルが表示される', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(child: const NoResultMessage(query: 'テスト')),
      );

      final text = tester.widget<Text>(find.text('検索結果がありません'));
      expect(text.style?.color, AppColors.dark.textPrimary);
    });

    testWidgets('query を埋め込んだメッセージが表示される', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(child: const NoResultMessage(query: 'Flutter入門')),
      );

      final text = tester.widget<Text>(
        find.text('「Flutter入門」に一致する書籍が見つかりませんでした。'),
      );
      expect(text.style?.color, AppColors.dark.textSecondary);
    });

    testWidgets('アイコン→タイトル→メッセージの順に表示される', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(child: const NoResultMessage(query: 'テスト')),
      );

      final iconPos = tester.getCenter(find.byIcon(Icons.search_off));
      final titlePos = tester.getCenter(find.text('検索結果がありません'));
      final msgPos = tester.getCenter(
        find.text('「テスト」に一致する書籍が見つかりませんでした。'),
      );

      expect(iconPos.dy, lessThan(titlePos.dy));
      expect(titlePos.dy, lessThan(msgPos.dy));
    });

    testWidgets('Center でラップされている', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(child: const NoResultMessage(query: 'テスト')),
      );

      expect(find.byType(Center), findsWidgets);
    });
  });
}
