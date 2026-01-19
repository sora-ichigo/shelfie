import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

/// 再利用可能なローディングインジケータウィジェット
///
/// 全画面ローディングとインラインローディングの両方をサポートする。
/// テーマに応じたスタイリングが適用される。
class LoadingIndicator extends StatelessWidget {
  /// [LoadingIndicator] を作成する
  ///
  /// [fullScreen] が true の場合、画面全体を覆うローディング表示になる。
  /// [message] を指定すると、インジケータの下にメッセージが表示される。
  const LoadingIndicator({
    super.key,
    this.fullScreen = false,
    this.message,
  });

  /// 全画面モードかどうか
  final bool fullScreen;

  /// ローディング中に表示するメッセージ
  final String? message;

  @override
  Widget build(BuildContext context) {
    final indicator = _buildIndicator(context);

    if (fullScreen) {
      return SizedBox.expand(
        child: Center(child: indicator),
      );
    }

    return Center(child: indicator);
  }

  Widget _buildIndicator(BuildContext context) {
    final theme = Theme.of(context);

    if (message == null) {
      return const CircularProgressIndicator();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: AppSpacing.md),
        Text(
          message!,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
