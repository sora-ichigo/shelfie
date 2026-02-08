import 'dart:typed_data';

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

    testWidgets('ImageKit URLがある場合はCachedNetworkImageを使用する',
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

      expect(find.byType(CachedNetworkImage), findsOneWidget);
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
      final testProvider = MemoryImage(
        Uint8List.fromList([
          0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, // PNG signature
          0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52, // IHDR chunk
          0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, // 1x1 pixel
          0x08, 0x02, 0x00, 0x00, 0x00, 0x90, 0x77, 0x53,
          0xDE, 0x00, 0x00, 0x00, 0x0C, 0x49, 0x44, 0x41,
          0x54, 0x08, 0xD7, 0x63, 0xF8, 0xFF, 0xFF, 0x3F,
          0x00, 0x05, 0xFE, 0x02, 0xFE, 0xDC, 0xCC, 0x59,
          0xE7, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E,
          0x44, 0xAE, 0x42, 0x60, 0x82, // IEND chunk
        ]),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
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

    testWidgets('ネットワーク画像ローディング中は控えめなプレースホルダーが表示される', (tester) async {
      const testUrl = 'https://ik.imagekit.io/test/avatar.jpg';

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: UserAvatar(avatarUrl: testUrl),
          ),
        ),
      );

      // ローディング中はpersonアイコンが表示される
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('isLoading=trueの場合はLoadingAvatarが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: UserAvatar(isLoading: true),
          ),
        ),
      );

      expect(find.byIcon(Icons.person), findsOneWidget);
      // CachedNetworkImageは使用されない
      expect(find.byType(CachedNetworkImage), findsNothing);
    });

    testWidgets('ImageKit URLのサイズにデバイスピクセル比が反映される',
        (tester) async {
      const testUrl = 'https://ik.imagekit.io/test/avatar.jpg';
      const testRadius = 24.0;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(devicePixelRatio: 3.0),
            child: child!,
          ),
          home: const Scaffold(
            body: UserAvatar(avatarUrl: testUrl, radius: testRadius),
          ),
        ),
      );

      final cachedImage = tester.widget<CachedNetworkImage>(
        find.byType(CachedNetworkImage),
      );
      // radius(24) * 2 * dpr(3.0) = 144
      expect(cachedImage.imageUrl, contains('w-144'));
      expect(cachedImage.imageUrl, contains('h-144'));
    });

    testWidgets('isLoading=trueの場合はavatarUrlがあってもLoadingAvatarが優先される',
        (tester) async {
      const testUrl = 'https://ik.imagekit.io/test/avatar.jpg';

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: UserAvatar(
              avatarUrl: testUrl,
              isLoading: true,
            ),
          ),
        ),
      );

      // isLoading=trueなのでCachedNetworkImageは使用されない
      expect(find.byType(CachedNetworkImage), findsNothing);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });
  });
}
