import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/features/book_shelf/domain/group_option.dart';
import 'package:shelfie/features/book_shelf/domain/sort_option.dart';

part 'book_shelf_settings_repository.g.dart';

const String bookShelfSettingsBoxName = 'book_shelf_settings';

const String _sortOptionKey = 'sort_option';
const String _groupOptionKey = 'group_option';

abstract interface class BookShelfSettingsRepositoryInterface {
  SortOption getSortOption();
  Future<void> setSortOption(SortOption option);
  GroupOption getGroupOption();
  Future<void> setGroupOption(GroupOption option);
}

class BookShelfSettingsRepository implements BookShelfSettingsRepositoryInterface {
  BookShelfSettingsRepository(this._box);

  final Box<String> _box;

  @override
  SortOption getSortOption() {
    final value = _box.get(_sortOptionKey);
    if (value == null) {
      return SortOption.defaultOption;
    }
    return SortOption.values.asNameMap()[value] ?? SortOption.defaultOption;
  }

  @override
  Future<void> setSortOption(SortOption option) async {
    await _box.put(_sortOptionKey, option.name);
  }

  @override
  GroupOption getGroupOption() {
    final value = _box.get(_groupOptionKey);
    if (value == null) {
      return GroupOption.defaultOption;
    }
    return GroupOption.values.asNameMap()[value] ?? GroupOption.defaultOption;
  }

  @override
  Future<void> setGroupOption(GroupOption option) async {
    await _box.put(_groupOptionKey, option.name);
  }
}

@Riverpod(keepAlive: true)
BookShelfSettingsRepository bookShelfSettingsRepository(Ref ref) {
  final box = Hive.box<String>(bookShelfSettingsBoxName);
  return BookShelfSettingsRepository(box);
}
