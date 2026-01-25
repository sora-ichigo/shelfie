// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appRouterHash() => r'dfe93a7b4a3261ab51005d0efcba4c4c1b362a38';

/// AppRouter Provider
///
/// go_router を使用したルーティング設定を提供する。
/// - 初期ルート: /
/// - デバッグモードでログ出力有効
/// - onException でエラーハンドリング
/// - redirect で認証ガード（me クエリでセッション検証）
/// - ShellRoute でタブナビゲーション
///
/// Copied from [appRouter].
@ProviderFor(appRouter)
final appRouterProvider = Provider<GoRouter>.internal(
  appRouter,
  name: r'appRouterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appRouterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppRouterRef = ProviderRef<GoRouter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
