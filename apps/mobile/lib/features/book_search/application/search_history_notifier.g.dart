// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_history_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchHistoryNotifierHash() =>
    r'864f3e1b540d08e32b4349532626e8437fccd7cd';

/// 検索履歴の状態管理 Notifier
///
/// 検索履歴リストの状態管理とビジネスロジックを提供する。
/// - 履歴追加、削除、全削除
/// - 入力クエリに部分一致する履歴のフィルタリング
/// - Repository 層への処理委譲
///
/// Copied from [SearchHistoryNotifier].
@ProviderFor(SearchHistoryNotifier)
final searchHistoryNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      SearchHistoryNotifier,
      List<SearchHistoryEntry>
    >.internal(
      SearchHistoryNotifier.new,
      name: r'searchHistoryNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$searchHistoryNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SearchHistoryNotifier =
    AutoDisposeAsyncNotifier<List<SearchHistoryEntry>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
