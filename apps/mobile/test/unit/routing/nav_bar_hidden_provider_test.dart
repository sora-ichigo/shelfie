import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/routing/app_router.dart';

void main() {
  group('navBarHiddenProvider', () {
    test('should default to false', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(navBarHiddenProvider), false);
    });

    test('should be settable to true', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(navBarHiddenProvider.notifier).state = true;
      expect(container.read(navBarHiddenProvider), true);
    });

    test('should be resettable to false', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(navBarHiddenProvider.notifier).state = true;
      container.read(navBarHiddenProvider.notifier).state = false;
      expect(container.read(navBarHiddenProvider), false);
    });
  });
}
