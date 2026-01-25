import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/account/presentation/widgets/image_source_bottom_sheet.dart';

void main() {
  group('ImageSourceBottomSheet', () {
    testWidgets('カメラ撮影オプションが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showImageSourceBottomSheet(
                  context: context,
                  onCameraSelected: () {},
                  onGallerySelected: () {},
                ),
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('カメラで撮影'), findsOneWidget);
    });

    testWidgets('ギャラリーから選択オプションが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showImageSourceBottomSheet(
                  context: context,
                  onCameraSelected: () {},
                  onGallerySelected: () {},
                ),
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('ギャラリーから選択'), findsOneWidget);
    });

    testWidgets('カメラアイコンが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showImageSourceBottomSheet(
                  context: context,
                  onCameraSelected: () {},
                  onGallerySelected: () {},
                ),
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.camera_alt_outlined), findsOneWidget);
    });

    testWidgets('フォトライブラリアイコンが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showImageSourceBottomSheet(
                  context: context,
                  onCameraSelected: () {},
                  onGallerySelected: () {},
                ),
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.photo_library_outlined), findsOneWidget);
    });

    testWidgets('カメラ撮影をタップするとコールバックが呼ばれる', (tester) async {
      var cameraSelected = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showImageSourceBottomSheet(
                  context: context,
                  onCameraSelected: () => cameraSelected = true,
                  onGallerySelected: () {},
                ),
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('カメラで撮影'));

      expect(cameraSelected, isTrue);
    });

    testWidgets('ギャラリーから選択をタップするとコールバックが呼ばれる', (tester) async {
      var gallerySelected = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showImageSourceBottomSheet(
                  context: context,
                  onCameraSelected: () {},
                  onGallerySelected: () => gallerySelected = true,
                ),
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('ギャラリーから選択'));

      expect(gallerySelected, isTrue);
    });
  });
}
