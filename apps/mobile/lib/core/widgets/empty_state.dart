import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

/// 空状態ウィジェット
///
/// データが存在しない場合に表示する。
/// カスタマイズ可能なメッセージ、アイコン、アクションボタンをサポート。
class EmptyState extends StatelessWidget {
  /// [EmptyState] を作成する
  ///
  /// [message] は必須のメッセージテキスト。
  /// [title] を指定すると、メッセージの上にタイトルが表示される。
  /// [icon] でカスタムアイコンを指定できる（デフォルトは inbox_outlined）。
  /// [onAction] を指定すると、アクションボタンが表示される。
  /// [actionText] でボタンのテキストをカスタマイズできる。
  const EmptyState({
    required this.message,
    super.key,
    this.title,
    this.icon = Icons.inbox_outlined,
    this.onAction,
    this.actionText = 'Action',
  });

  /// 表示するメッセージ
  final String message;

  /// オプションのタイトル
  final String? title;

  /// 表示するアイコン
  final IconData icon;

  /// アクションボタンのコールバック
  final VoidCallback? onAction;

  /// アクションボタンのテキスト
  final String actionText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurfaceVariant = theme.colorScheme.onSurfaceVariant;

    return Center(
      child: Padding(
        padding: AppSpacing.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 64,
              color: onSurfaceVariant,
            ),
            const SizedBox(height: AppSpacing.md),
            if (title != null) ...[
              Text(
                title!,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs),
            ],
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (onAction != null) ...[
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton(
                onPressed: onAction,
                child: Text(actionText),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
