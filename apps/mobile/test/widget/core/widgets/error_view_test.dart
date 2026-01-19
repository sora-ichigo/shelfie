import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/core/widgets/error_view.dart';

void main() {
  Widget buildTestWidget({required Widget child}) {
    return MaterialApp(
      theme: AppTheme.theme,
      home: Scaffold(body: child),
    );
  }

  group('ErrorView', () {
    group('displays failure message', () {
      testWidgets('shows userMessage for NetworkFailure', (tester) async {
        const failure = NetworkFailure(message: 'Connection lost');

        await tester.pumpWidget(
          buildTestWidget(child: ErrorView(failure: failure)),
        );

        expect(find.text(failure.userMessage), findsOneWidget);
      });

      testWidgets('shows userMessage for ServerFailure', (tester) async {
        const failure = ServerFailure(
          message: 'Internal error',
          code: 'ERR_500',
          statusCode: 500,
        );

        await tester.pumpWidget(
          buildTestWidget(child: ErrorView(failure: failure)),
        );

        expect(find.text(failure.userMessage), findsOneWidget);
      });

      testWidgets('shows userMessage for AuthFailure', (tester) async {
        const failure = AuthFailure(message: 'Token expired');

        await tester.pumpWidget(
          buildTestWidget(child: ErrorView(failure: failure)),
        );

        expect(find.text(failure.userMessage), findsOneWidget);
      });

      testWidgets('shows userMessage for ValidationFailure', (tester) async {
        const failure = ValidationFailure(
          message: 'Invalid email format',
          fieldErrors: {'email': 'Invalid format'},
        );

        await tester.pumpWidget(
          buildTestWidget(child: ErrorView(failure: failure)),
        );

        expect(find.text(failure.userMessage), findsOneWidget);
      });

      testWidgets('shows userMessage for UnexpectedFailure', (tester) async {
        const failure = UnexpectedFailure(message: 'Something went wrong');

        await tester.pumpWidget(
          buildTestWidget(child: ErrorView(failure: failure)),
        );

        expect(find.text(failure.userMessage), findsOneWidget);
      });
    });

    group('retry button', () {
      testWidgets('displays retry button when onRetry is provided',
          (tester) async {
        const failure = NetworkFailure(message: 'Connection lost');
        var retryPressed = false;

        await tester.pumpWidget(
          buildTestWidget(
            child: ErrorView(
              failure: failure,
              onRetry: () => retryPressed = true,
            ),
          ),
        );

        expect(find.byType(ElevatedButton), findsOneWidget);
        expect(find.text('Retry'), findsOneWidget);

        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        expect(retryPressed, isTrue);
      });

      testWidgets('does not display retry button when onRetry is null',
          (tester) async {
        const failure = NetworkFailure(message: 'Connection lost');

        await tester.pumpWidget(
          buildTestWidget(child: ErrorView(failure: failure)),
        );

        expect(find.byType(ElevatedButton), findsNothing);
        expect(find.text('Retry'), findsNothing);
      });

      testWidgets('uses custom retry button text', (tester) async {
        const failure = NetworkFailure(message: 'Connection lost');
        const customText = 'Try Again';

        await tester.pumpWidget(
          buildTestWidget(
            child: ErrorView(
              failure: failure,
              onRetry: () {},
              retryButtonText: customText,
            ),
          ),
        );

        expect(find.text(customText), findsOneWidget);
        expect(find.text('Retry'), findsNothing);
      });
    });

    group('error type icons', () {
      testWidgets('shows wifi_off icon for NetworkFailure', (tester) async {
        const failure = NetworkFailure(message: 'No connection');

        await tester.pumpWidget(
          buildTestWidget(child: ErrorView(failure: failure)),
        );

        expect(find.byIcon(Icons.wifi_off), findsOneWidget);
      });

      testWidgets('shows cloud_off icon for ServerFailure', (tester) async {
        const failure = ServerFailure(message: 'Server error', code: 'ERR_500');

        await tester.pumpWidget(
          buildTestWidget(child: ErrorView(failure: failure)),
        );

        expect(find.byIcon(Icons.cloud_off), findsOneWidget);
      });

      testWidgets('shows lock_outline icon for AuthFailure', (tester) async {
        const failure = AuthFailure(message: 'Auth error');

        await tester.pumpWidget(
          buildTestWidget(child: ErrorView(failure: failure)),
        );

        expect(find.byIcon(Icons.lock_outline), findsOneWidget);
      });

      testWidgets('shows warning icon for ValidationFailure', (tester) async {
        const failure = ValidationFailure(message: 'Validation error');

        await tester.pumpWidget(
          buildTestWidget(child: ErrorView(failure: failure)),
        );

        expect(find.byIcon(Icons.warning_amber_outlined), findsOneWidget);
      });

      testWidgets('shows error_outline icon for UnexpectedFailure',
          (tester) async {
        const failure = UnexpectedFailure(message: 'Unexpected error');

        await tester.pumpWidget(
          buildTestWidget(child: ErrorView(failure: failure)),
        );

        expect(find.byIcon(Icons.error_outline), findsOneWidget);
      });
    });

    group('error type colors', () {
      testWidgets('uses warning color for NetworkFailure', (tester) async {
        const failure = NetworkFailure(message: 'No connection');

        await tester.pumpWidget(
          buildTestWidget(child: ErrorView(failure: failure)),
        );

        final icon = tester.widget<Icon>(find.byIcon(Icons.wifi_off));
        expect(icon.color, equals(AppColors.dark.warning));
      });

      testWidgets('uses error color for ServerFailure', (tester) async {
        const failure = ServerFailure(message: 'Server error', code: 'ERR_500');

        await tester.pumpWidget(
          buildTestWidget(child: ErrorView(failure: failure)),
        );

        final theme = AppTheme.theme;
        final icon = tester.widget<Icon>(find.byIcon(Icons.cloud_off));
        expect(icon.color, equals(theme.colorScheme.error));
      });

      testWidgets('uses warning color for AuthFailure', (tester) async {
        const failure = AuthFailure(message: 'Auth error');

        await tester.pumpWidget(
          buildTestWidget(child: ErrorView(failure: failure)),
        );

        final icon = tester.widget<Icon>(find.byIcon(Icons.lock_outline));
        expect(icon.color, equals(AppColors.dark.warning));
      });

      testWidgets('uses warning color for ValidationFailure', (tester) async {
        const failure = ValidationFailure(message: 'Validation error');

        await tester.pumpWidget(
          buildTestWidget(child: ErrorView(failure: failure)),
        );

        final icon =
            tester.widget<Icon>(find.byIcon(Icons.warning_amber_outlined));
        expect(icon.color, equals(AppColors.dark.warning));
      });

      testWidgets('uses error color for UnexpectedFailure', (tester) async {
        const failure = UnexpectedFailure(message: 'Unexpected error');

        await tester.pumpWidget(
          buildTestWidget(child: ErrorView(failure: failure)),
        );

        final theme = AppTheme.theme;
        final icon = tester.widget<Icon>(find.byIcon(Icons.error_outline));
        expect(icon.color, equals(theme.colorScheme.error));
      });
    });

    group('layout', () {
      testWidgets('centers content', (tester) async {
        const failure = NetworkFailure(message: 'No connection');

        await tester.pumpWidget(
          buildTestWidget(child: ErrorView(failure: failure)),
        );

        expect(find.byType(Center), findsWidgets);
      });

      testWidgets('displays icon above message', (tester) async {
        const failure = NetworkFailure(message: 'No connection');

        await tester.pumpWidget(
          buildTestWidget(child: ErrorView(failure: failure)),
        );

        final icon = find.byIcon(Icons.wifi_off);
        final message = find.text(failure.userMessage);

        final iconPosition = tester.getCenter(icon);
        final messagePosition = tester.getCenter(message);

        expect(iconPosition.dy, lessThan(messagePosition.dy));
      });
    });
  });
}
