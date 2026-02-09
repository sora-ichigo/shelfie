import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:shelfie/core/widgets/app_snack_bar.dart';
import 'package:shelfie/routing/app_router.dart';

void showGuestLoginSnackBar(BuildContext context) {
  AppSnackBar.show(
    context,
    message: 'この機能を利用するにはアカウントが必要です',
    type: AppSnackBarType.info,
    action: '登録',
    onActionPressed: () => context.push(AppRoutes.register),
  );
}
