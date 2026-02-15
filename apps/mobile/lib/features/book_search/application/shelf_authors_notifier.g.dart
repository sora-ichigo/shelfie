// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shelf_authors_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$shelfAuthorsHash() => r'1ab49cc214a9bce6e6ec4b2d41196e2957ce9320';

/// 本棚の著者を冊数順で提供するプロバイダー
///
/// 本棚データから著者を抽出し、冊数が多い順にソートして返す。
/// 本棚の変更（shelfVersion）を監視して自動更新する。
///
/// Copied from [ShelfAuthors].
@ProviderFor(ShelfAuthors)
final shelfAuthorsProvider =
    AsyncNotifierProvider<ShelfAuthors, List<AuthorCount>>.internal(
  ShelfAuthors.new,
  name: r'shelfAuthorsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$shelfAuthorsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ShelfAuthors = AsyncNotifier<List<AuthorCount>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
