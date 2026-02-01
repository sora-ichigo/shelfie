import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';

enum SnackBarType { info, success, warning, error }

abstract final class AppSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    required SnackBarType type,
    String? action,
    VoidCallback? onActionPressed,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    final appColors = Theme.of(context).extension<AppColors>()!;

    messenger
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: _backgroundColor(appColors, type),
          behavior: SnackBarBehavior.floating,
          action: action != null
              ? SnackBarAction(
                  label: action,
                  textColor: Colors.white,
                  onPressed: onActionPressed ?? () {},
                )
              : null,
        ),
      );
  }

  static Color _backgroundColor(AppColors colors, SnackBarType type) {
    return switch (type) {
      SnackBarType.info => colors.info,
      SnackBarType.success => colors.success,
      SnackBarType.warning => colors.warning,
      SnackBarType.error => colors.error,
    };
  }
}
