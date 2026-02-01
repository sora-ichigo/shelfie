import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/book_shelf/application/sort_option_notifier.dart';
import 'package:shelfie/features/book_shelf/data/book_shelf_settings_repository.dart';
import 'package:shelfie/features/book_shelf/domain/sort_option.dart';

class FakeBookShelfSettingsRepository
    implements BookShelfSettingsRepository {
  FakeBookShelfSettingsRepository([SortOption? initial]) {
    if (initial != null) _current = initial;
  }

  SortOption _current = SortOption.defaultOption;
  int setCallCount = 0;
  SortOption? lastSetOption;

  @override
  SortOption getSortOption() => _current;

  @override
  Future<void> setSortOption(SortOption option) async {
    setCallCount++;
    lastSetOption = option;
    _current = option;
  }
}

void main() {
  late FakeBookShelfSettingsRepository fakeSettingsRepo;
  late ProviderContainer container;

  setUp(() {
    fakeSettingsRepo = FakeBookShelfSettingsRepository();
    container = ProviderContainer(
      overrides: [
        bookShelfSettingsRepositoryProvider
            .overrideWithValue(fakeSettingsRepo),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('SortOptionNotifier', () {
    test('初期値が BookShelfSettingsRepository から読まれる（デフォルト）', () {
      final state = container.read(sortOptionNotifierProvider);
      expect(state, SortOption.defaultOption);
    });

    test('初期値が BookShelfSettingsRepository から読まれる（カスタム値）', () {
      final customRepo =
          FakeBookShelfSettingsRepository(SortOption.titleAsc);
      final c = ProviderContainer(
        overrides: [
          bookShelfSettingsRepositoryProvider
              .overrideWithValue(customRepo),
        ],
      );

      final state = c.read(sortOptionNotifierProvider);
      expect(state, SortOption.titleAsc);

      c.dispose();
    });

    test('update() で状態が変更される', () async {
      final notifier =
          container.read(sortOptionNotifierProvider.notifier);
      await notifier.update(SortOption.authorAsc);

      final state = container.read(sortOptionNotifierProvider);
      expect(state, SortOption.authorAsc);
    });

    test('update() で BookShelfSettingsRepository に永続化される', () async {
      final notifier =
          container.read(sortOptionNotifierProvider.notifier);
      await notifier.update(SortOption.addedAtAsc);

      expect(fakeSettingsRepo.setCallCount, 1);
      expect(fakeSettingsRepo.lastSetOption, SortOption.addedAtAsc);
    });

    test('update() を複数回呼んでも正しく動作する', () async {
      final notifier =
          container.read(sortOptionNotifierProvider.notifier);

      await notifier.update(SortOption.titleAsc);
      await notifier.update(SortOption.authorAsc);
      await notifier.update(SortOption.addedAtDesc);

      final state = container.read(sortOptionNotifierProvider);
      expect(state, SortOption.addedAtDesc);
      expect(fakeSettingsRepo.setCallCount, 3);
    });
  });
}
