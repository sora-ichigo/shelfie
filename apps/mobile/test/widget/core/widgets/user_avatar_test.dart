import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/core/widgets/user_avatar.dart';

void main() {
  group('UserAvatar', () {
    testWidgets('画像がない場合はpersonアイコンが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: UserAvatar(),
          ),
        ),
      );

      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('指定したradiusでCircleAvatarが作成される', (tester) async {
      const testRadius = 32.0;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: UserAvatar(radius: testRadius),
          ),
        ),
      );

      final circleAvatar = tester.widget<CircleAvatar>(
        find.byType(CircleAvatar),
      );
      expect(circleAvatar.radius, equals(testRadius));
    });

    testWidgets('デフォルトのradiusは24', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: UserAvatar(),
          ),
        ),
      );

      final circleAvatar = tester.widget<CircleAvatar>(
        find.byType(CircleAvatar),
      );
      expect(circleAvatar.radius, equals(24));
    });

    testWidgets('personアイコンのサイズはradiusと同じ', (tester) async {
      const testRadius = 40.0;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: UserAvatar(radius: testRadius),
          ),
        ),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.person));
      expect(icon.size, equals(testRadius));
    });
  });
}
