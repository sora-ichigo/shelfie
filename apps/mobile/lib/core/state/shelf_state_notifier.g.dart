// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shelf_state_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$shelfStateHash() => r'f3454bdf3b85bddd1a38cd0c3ae5084c7ffc81f2';

/// ユーザーの本棚にある本の状態を管理する（SSOT）
///
/// externalId (Google Books ID) → ShelfEntry のマッピングを保持
/// 読書状態（readingStatus, note など）を一元管理する
///
/// Copied from [ShelfState].
@ProviderFor(ShelfState)
final shelfStateProvider =
    NotifierProvider<ShelfState, Map<String, ShelfEntry>>.internal(
  ShelfState.new,
  name: r'shelfStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$shelfStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ShelfState = Notifier<Map<String, ShelfEntry>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
