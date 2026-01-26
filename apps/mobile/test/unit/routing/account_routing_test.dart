import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/routing/app_router.dart';

void main() {
  group('AppRoutes account routes', () {
    test('account route path is defined', () {
      expect(AppRoutes.account, '/account');
    });

    test('accountEdit route path is defined', () {
      expect(AppRoutes.accountEdit, '/account/edit');
    });

    test('accountPassword route path is defined', () {
      expect(AppRoutes.accountPassword, '/account/password');
    });
  });

  group('Account routing integration', () {
    test('AppRoutes contains all account related routes', () {
      final accountRoutes = [
        AppRoutes.account,
        AppRoutes.accountEdit,
        AppRoutes.accountPassword,
      ];

      for (final route in accountRoutes) {
        expect(route.startsWith('/account'), isTrue);
      }
    });
  });
}
