import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/core/widgets/empty_state.dart';

void main() {
  Widget buildTestWidget({required Widget child}) {
    return MaterialApp(
      theme: AppTheme.theme,
      home: Scaffold(body: child),
    );
  }

  group('EmptyState', () {
    group('displays message', () {
      testWidgets('shows provided message', (tester) async {
        const message = 'No items found';

        await tester.pumpWidget(
          buildTestWidget(child: const EmptyState(message: message)),
        );

        expect(find.text(message), findsOneWidget);
      });

      testWidgets('shows title when provided', (tester) async {
        const title = 'Empty List';
        const message = 'No items found';

        await tester.pumpWidget(
          buildTestWidget(
            child: const EmptyState(
              message: message,
              title: title,
            ),
          ),
        );

        expect(find.text(title), findsOneWidget);
        expect(find.text(message), findsOneWidget);
      });
    });

    group('icon', () {
      testWidgets('shows default icon when no custom icon provided',
          (tester) async {
        await tester.pumpWidget(
          buildTestWidget(child: const EmptyState(message: 'No items')),
        );

        expect(find.byIcon(Icons.inbox_outlined), findsOneWidget);
      });

      testWidgets('shows custom icon when provided', (tester) async {
        const customIcon = Icons.search_off;

        await tester.pumpWidget(
          buildTestWidget(
            child: const EmptyState(
              message: 'No items',
              icon: customIcon,
            ),
          ),
        );

        expect(find.byIcon(customIcon), findsOneWidget);
        expect(find.byIcon(Icons.inbox_outlined), findsNothing);
      });

      testWidgets('uses theme color for icon', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(child: const EmptyState(message: 'No items')),
        );

        final icon = tester.widget<Icon>(find.byIcon(Icons.inbox_outlined));
        final theme = AppTheme.theme;
        expect(
          icon.color,
          equals(theme.colorScheme.onSurfaceVariant),
        );
      });
    });

    group('action button', () {
      testWidgets('does not show button when onAction is null',
          (tester) async {
        await tester.pumpWidget(
          buildTestWidget(child: const EmptyState(message: 'No items')),
        );

        expect(find.byType(ElevatedButton), findsNothing);
        expect(find.byType(OutlinedButton), findsNothing);
        expect(find.byType(TextButton), findsNothing);
      });

      testWidgets('shows button when onAction is provided', (tester) async {
        var actionPressed = false;
        const actionText = 'Add Item';

        await tester.pumpWidget(
          buildTestWidget(
            child: EmptyState(
              message: 'No items',
              onAction: () => actionPressed = true,
              actionText: actionText,
            ),
          ),
        );

        expect(find.text(actionText), findsOneWidget);

        await tester.tap(find.text(actionText));
        await tester.pump();

        expect(actionPressed, isTrue);
      });

      testWidgets('uses default action text when not provided',
          (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            child: EmptyState(
              message: 'No items',
              onAction: () {},
            ),
          ),
        );

        expect(find.text('Action'), findsOneWidget);
      });
    });

    group('layout', () {
      testWidgets('centers content', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(child: const EmptyState(message: 'No items')),
        );

        expect(find.byType(Center), findsWidgets);
      });

      testWidgets('displays icon above message', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(child: const EmptyState(message: 'No items')),
        );

        final icon = find.byIcon(Icons.inbox_outlined);
        final message = find.text('No items');

        final iconPosition = tester.getCenter(icon);
        final messagePosition = tester.getCenter(message);

        expect(iconPosition.dy, lessThan(messagePosition.dy));
      });

      testWidgets('title is displayed above message when both are present',
          (tester) async {
        const title = 'Empty';
        const message = 'No items found';

        await tester.pumpWidget(
          buildTestWidget(
            child: const EmptyState(
              message: message,
              title: title,
            ),
          ),
        );

        final titleWidget = find.text(title);
        final messageWidget = find.text(message);

        final titlePosition = tester.getCenter(titleWidget);
        final messagePosition = tester.getCenter(messageWidget);

        expect(titlePosition.dy, lessThan(messagePosition.dy));
      });

      testWidgets('action button is displayed below message', (tester) async {
        const message = 'No items found';
        const actionText = 'Add Item';

        await tester.pumpWidget(
          buildTestWidget(
            child: EmptyState(
              message: message,
              onAction: () {},
              actionText: actionText,
            ),
          ),
        );

        final messageWidget = find.text(message);
        final buttonWidget = find.text(actionText);

        final messagePosition = tester.getCenter(messageWidget);
        final buttonPosition = tester.getCenter(buttonWidget);

        expect(messagePosition.dy, lessThan(buttonPosition.dy));
      });
    });

    group('theme styling', () {
      testWidgets('message uses onSurfaceVariant color', (tester) async {
        const message = 'No items found';

        await tester.pumpWidget(
          buildTestWidget(child: const EmptyState(message: message)),
        );

        final textWidget = tester.widget<Text>(find.text(message));
        final theme = AppTheme.theme;

        expect(
          textWidget.style?.color,
          equals(theme.colorScheme.onSurfaceVariant),
        );
      });
    });
  });
}
