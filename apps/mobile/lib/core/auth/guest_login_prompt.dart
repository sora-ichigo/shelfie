import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:shelfie/routing/app_router.dart';

void showGuestLoginSnackBar(BuildContext context) {
  AdaptiveSnackBar.show(
    context,
    message: 'この機能を利用するにはアカウントが必要です',
    type: AdaptiveSnackBarType.info,
    action: '登録',
    onActionPressed: () => context.push(AppRoutes.register),
  );
}
