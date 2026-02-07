import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_search/presentation/isbn_scan_screen.dart';

class MockMobileScannerController extends Mock {}

void main() {
  group('ISBNScanScreen', () {
    testWidgets('displays camera preview when permission is granted',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.theme,
            home: const ISBNScanScreen(),
          ),
        ),
      );

      expect(find.byType(ISBNScanScreen), findsOneWidget);
    });

    testWidgets('displays close button', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.theme,
            home: const ISBNScanScreen(),
          ),
        ),
      );

      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('displays scan overlay', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.theme,
            home: const ISBNScanScreen(),
          ),
        ),
      );

      expect(find.byKey(const Key('scan_overlay')), findsOneWidget);
    });

    testWidgets('displays instruction text', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.theme,
            home: const ISBNScanScreen(),
          ),
        ),
      );

      expect(find.text('バーコードを枠内に合わせてください'), findsOneWidget);
    });

    testWidgets('displays permission denied message when camera is denied',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.theme,
            home: const ISBNScanScreen(
              testCameraPermissionDenied: true,
            ),
          ),
        ),
      );

      expect(find.text('カメラへのアクセスが拒否されています'), findsOneWidget);
      expect(find.text('設定を開く'), findsOneWidget);
    });
  });
}
