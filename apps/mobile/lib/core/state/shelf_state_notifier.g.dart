// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shelf_state_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$shelfStateHash() => r'c9cf8909592f98b19fa31b49c603658fc8863f56';

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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
