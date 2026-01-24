// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_shelf_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bookShelfNotifierHash() => r'a0fc49aa8021bced3a5fae117c01f07c2dad629d';

/// 本棚画面の状態管理 Notifier
///
/// サーバーサイドでの検索・ソート・ページネーション、
/// クライアント側でのグループ化を担当する。
///
/// Copied from [BookShelfNotifier].
@ProviderFor(BookShelfNotifier)
final bookShelfNotifierProvider =
    AutoDisposeNotifierProvider<BookShelfNotifier, BookShelfState>.internal(
  BookShelfNotifier.new,
  name: r'bookShelfNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bookShelfNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BookShelfNotifier = AutoDisposeNotifier<BookShelfState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
