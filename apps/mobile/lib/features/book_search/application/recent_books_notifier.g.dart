// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_books_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recentBooksNotifierHash() =>
    r'a9c8f315523cb5d261b605ea5976451675e40ec9';

/// 最近チェックした本の状態管理 Notifier
///
/// 閲覧履歴リストの状態管理とビジネスロジックを提供する。
/// - 履歴追加、削除、全削除
/// - Repository 層への処理委譲
///
/// Copied from [RecentBooksNotifier].
@ProviderFor(RecentBooksNotifier)
final recentBooksNotifierProvider = AutoDisposeAsyncNotifierProvider<
    RecentBooksNotifier, List<RecentBookEntry>>.internal(
  RecentBooksNotifier.new,
  name: r'recentBooksNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recentBooksNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RecentBooksNotifier = AutoDisposeAsyncNotifier<List<RecentBookEntry>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
