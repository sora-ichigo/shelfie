import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/state/book_list_version.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
  });

  group('BookListVersion', () {
    test('初期値が 0 である', () {
      final version = container.read(bookListVersionProvider);
      expect(version, 0);
    });

    test('increment() で値が 1 増える', () {
      container.read(bookListVersionProvider.notifier).increment();
      expect(container.read(bookListVersionProvider), 1);
    });

    test('increment() を複数回呼ぶと値が累積する', () {
      final notifier = container.read(bookListVersionProvider.notifier);
      notifier.increment();
      notifier.increment();
      notifier.increment();
      expect(container.read(bookListVersionProvider), 3);
    });
  });
}
