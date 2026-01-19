import 'package:flutter/material.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

/// エラー表示ウィジェット
///
/// [Failure] 型を受け取り、エラータイプに応じたアイコン、色、メッセージを表示する。
/// オプションでリトライボタンを表示できる。
class ErrorView extends StatelessWidget {
  /// [ErrorView] を作成する
  ///
  /// [failure] は表示するエラー情報。
  /// [onRetry] が指定されると、リトライボタンが表示される。
  /// [retryButtonText] でボタンのテキストをカスタマイズできる。
  const ErrorView({
    required this.failure,
    super.key,
    this.onRetry,
    this.retryButtonText = 'Retry',
  });

  /// 表示するエラー情報
  final Failure failure;

  /// リトライボタンのコールバック
  final VoidCallback? onRetry;

  /// リトライボタンのテキスト
  final String retryButtonText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>() ?? AppColors.dark;

    return Center(
      child: Padding(
        padding: AppSpacing.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getIcon(),
              size: 64,
              color: _getIconColor(theme, appColors),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              failure.userMessage,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton(
                onPressed: onRetry,
                child: Text(retryButtonText),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getIcon() {
    return failure.when(
      network: (_) => Icons.wifi_off,
      server: (_, __, ___) => Icons.cloud_off,
      auth: (_) => Icons.lock_outline,
      validation: (_, __) => Icons.warning_amber_outlined,
      unexpected: (_, __) => Icons.error_outline,
    );
  }

  Color _getIconColor(ThemeData theme, AppColors appColors) {
    return failure.when(
      network: (_) => appColors.warning,
      server: (_, __, ___) => theme.colorScheme.error,
      auth: (_) => appColors.warning,
      validation: (_, __) => appColors.warning,
      unexpected: (_, __) => theme.colorScheme.error,
    );
  }
}
