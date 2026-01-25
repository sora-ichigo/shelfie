import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/account/presentation/widgets/avatar_editor.dart';

void main() {
  group('AvatarEditor', () {
    testWidgets('アバターが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: AvatarEditor(
              avatarUrl: null,
              pendingImage: null,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('鉛筆アイコンが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: AvatarEditor(
              avatarUrl: null,
              pendingImage: null,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.edit), findsOneWidget);
    });

    testWidgets('タップするとコールバックが呼ばれる', (tester) async {
      var callbackCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: AvatarEditor(
              avatarUrl: null,
              pendingImage: null,
              onTap: () => callbackCalled = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AvatarEditor));
      expect(callbackCalled, isTrue);
    });

    testWidgets('avatarUrl が null の場合はデフォルトアイコンを表示', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: AvatarEditor(
              avatarUrl: null,
              pendingImage: null,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('pendingImage が指定されている場合はファイル画像がセットされる', (tester) async {
      final tempDir = Directory.systemTemp.createTempSync();
      final tempFile = File('${tempDir.path}/test_image.jpg');
      tempFile.writeAsBytesSync([0, 0, 0, 0]);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: AvatarEditor(
              avatarUrl: null,
              pendingImage: XFile(tempFile.path),
              onTap: () {},
            ),
          ),
        ),
      );

      final avatar = tester.widget<CircleAvatar>(find.byType(CircleAvatar).first);
      expect(avatar.backgroundImage, isA<FileImage>());

      tempFile.deleteSync();
      tempDir.deleteSync();
    });

    testWidgets('pendingImage があればデフォルトアイコンは非表示', (tester) async {
      final tempDir = Directory.systemTemp.createTempSync();
      final tempFile = File('${tempDir.path}/test_image.jpg');
      tempFile.writeAsBytesSync([0, 0, 0, 0]);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: AvatarEditor(
              avatarUrl: null,
              pendingImage: XFile(tempFile.path),
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.person), findsNothing);

      tempFile.deleteSync();
      tempDir.deleteSync();
    });
  });
}
