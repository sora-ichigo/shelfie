import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/widgets/add_book_bottom_sheet.dart';

import '../../../helpers/test_helpers.dart';

void main() {
  setUpAll(registerTestFallbackValues);

  group('AddBookBottomSheet', () {
    testWidgets('ボトムシートが表示されること', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          child: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => showAddBookBottomSheet(context: context),
              child: const Text('Open'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('本を追加'), findsOneWidget);
    });

    testWidgets('「キーワードで検索」と「カメラで登録」の選択肢が表示されること',
        (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          child: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => showAddBookBottomSheet(context: context),
              child: const Text('Open'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('キーワードで検索'), findsOneWidget);
      expect(find.text('カメラで登録'), findsOneWidget);
      expect(find.byIcon(CupertinoIcons.search), findsOneWidget);
      expect(find.byIcon(CupertinoIcons.camera), findsOneWidget);
    });

    testWidgets('「キーワードで検索」タップでonSearchSelectedが呼ばれること',
        (tester) async {
      var searchCalled = false;

      await tester.pumpWidget(
        buildTestWidget(
          child: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => showAddBookBottomSheet(
                context: context,
                onSearchSelected: () => searchCalled = true,
              ),
              child: const Text('Open'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('キーワードで検索'));
      await tester.pumpAndSettle();

      expect(searchCalled, isTrue);
    });

    testWidgets('「カメラで登録」タップでonCameraSelectedが呼ばれること',
        (tester) async {
      var cameraCalled = false;

      await tester.pumpWidget(
        buildTestWidget(
          child: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => showAddBookBottomSheet(
                context: context,
                onCameraSelected: () => cameraCalled = true,
              ),
              child: const Text('Open'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('カメラで登録'));
      await tester.pumpAndSettle();

      expect(cameraCalled, isTrue);
    });
  });
}
