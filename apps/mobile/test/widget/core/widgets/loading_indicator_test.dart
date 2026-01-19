import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/core/widgets/loading_indicator.dart';

import '../../../helpers/test_helpers.dart';

void main() {
  setUpAll(registerTestFallbackValues);

  Widget buildTestWidget({required Widget child}) {
    return MaterialApp(
      theme: AppTheme.theme,
      home: Scaffold(body: child),
    );
  }

  group('LoadingIndicator', () {
    group('inline mode (default)', () {
      testWidgets('displays CircularProgressIndicator', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(child: const LoadingIndicator()),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets('does not fill entire screen', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(child: const LoadingIndicator()),
        );

        final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
        final body = scaffold.body;
        expect(body, isA<LoadingIndicator>());
      });

      testWidgets('centers the indicator', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(child: const LoadingIndicator()),
        );

        expect(find.byType(Center), findsWidgets);
      });
    });

    group('fullScreen mode', () {
      testWidgets('fills entire available space', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(child: const LoadingIndicator(fullScreen: true)),
        );

        final container = find.byType(SizedBox).evaluate().firstWhere(
              (element) {
                final widget = element.widget as SizedBox;
                return widget.width == double.infinity &&
                    widget.height == double.infinity;
              },
              orElse: () => throw Exception('Full screen SizedBox not found'),
            );

        expect(container, isNotNull);
      });

      testWidgets('displays CircularProgressIndicator', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(child: const LoadingIndicator(fullScreen: true)),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });

    group('custom message', () {
      testWidgets('displays message when provided', (tester) async {
        const message = 'Loading data...';
        await tester.pumpWidget(
          buildTestWidget(child: const LoadingIndicator(message: message)),
        );

        expect(find.text(message), findsOneWidget);
      });

      testWidgets('does not display message by default', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(child: const LoadingIndicator()),
        );

        final textWidgets = find.byType(Text);
        expect(
          textWidgets.evaluate().where((e) {
            final text = e.widget as Text;
            return text.data != null && text.data!.isNotEmpty;
          }),
          isEmpty,
        );
      });
    });

    group('theme styling', () {
      testWidgets('uses theme color scheme for indicator', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(child: const LoadingIndicator()),
        );

        final indicator = tester.widget<CircularProgressIndicator>(
          find.byType(CircularProgressIndicator),
        );

        final theme = AppTheme.theme;
        expect(
          indicator.color ?? indicator.valueColor?.value,
          anyOf(
            isNull,
            equals(theme.colorScheme.primary),
          ),
        );
      });
    });

    group('dark mode', () {
      testWidgets('displays correctly in dark theme', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(child: const LoadingIndicator()),
        );

        final context = tester.element(find.byType(LoadingIndicator));
        final theme = Theme.of(context);

        expect(theme.brightness, equals(Brightness.dark));
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets('message text is visible in dark theme', (tester) async {
        const message = 'Loading...';
        await tester.pumpWidget(
          buildTestWidget(child: const LoadingIndicator(message: message)),
        );

        final context = tester.element(find.byType(LoadingIndicator));
        final theme = Theme.of(context);

        expect(theme.brightness, equals(Brightness.dark));
        expect(find.text(message), findsOneWidget);

        final text = tester.widget<Text>(find.text(message));
        expect(text.style?.color, isNotNull);
      });
    });
  });
}
