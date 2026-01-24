// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shelf_state_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$shelfStateHash() => r'b6ff4e9b1717ca8c9bc36d63ad924cd06dd5a36b';

/// ユーザーの本棚にある本の状態を管理する
/// externalId (Google Books ID) → userBookId のマッピングを保持
///
/// Copied from [ShelfState].
@ProviderFor(ShelfState)
final shelfStateProvider =
    NotifierProvider<ShelfState, Map<String, int>>.internal(
  ShelfState.new,
  name: r'shelfStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$shelfStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ShelfState = Notifier<Map<String, int>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
