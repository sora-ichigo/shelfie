import 'package:cached_network_image/cached_network_image.dart';
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

    testWidgets('ImageKit URLがある場合はCachedNetworkImageProviderを使用する',
        (tester) async {
      const testUrl = 'https://ik.imagekit.io/test/avatar.jpg';

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: UserAvatar(avatarUrl: testUrl),
          ),
        ),
      );

      final circleAvatar =
          tester.widget<CircleAvatar>(find.byType(CircleAvatar));
      expect(circleAvatar.backgroundImage, isA<CachedNetworkImageProvider>());
    });

    testWidgets('URLがnullの場合はデフォルトアイコンが表示される', (tester) async {
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

    testWidgets('URLが空文字の場合はデフォルトアイコンが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: UserAvatar(avatarUrl: ''),
          ),
        ),
      );

      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('imageProviderが指定された場合はそれが優先される', (tester) async {
      const testProvider = AssetImage('assets/images/test.png');

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: UserAvatar(
              avatarUrl: 'https://ik.imagekit.io/test/avatar.jpg',
              imageProvider: testProvider,
            ),
          ),
        ),
      );

      final circleAvatar =
          tester.widget<CircleAvatar>(find.byType(CircleAvatar));
      expect(circleAvatar.backgroundImage, equals(testProvider));
    });
  });
}
