// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appRouterHash() => r'09baf9aafcc77439e22b6eac36664f2e3a4f32c0';

/// AppRouter Provider
///
/// go_router を使用したルーティング設定を提供する。
/// - 初期ルート: /
/// - デバッグモードでログ出力有効
/// - onException でエラーハンドリング
/// - redirect で認証ガード
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
String _$userProfileByHandleHash() =>
    r'c79bd95212777c7f1e95d1560443bb324181e5ab';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [_userProfileByHandle].
@ProviderFor(_userProfileByHandle)
const _userProfileByHandleProvider = _UserProfileByHandleFamily();

/// See also [_userProfileByHandle].
class _UserProfileByHandleFamily extends Family<AsyncValue<UserProfileModel>> {
  /// See also [_userProfileByHandle].
  const _UserProfileByHandleFamily();

  /// See also [_userProfileByHandle].
  _UserProfileByHandleProvider call(
    String handle,
  ) {
    return _UserProfileByHandleProvider(
      handle,
    );
  }

  @override
  _UserProfileByHandleProvider getProviderOverride(
    covariant _UserProfileByHandleProvider provider,
  ) {
    return call(
      provider.handle,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_userProfileByHandleProvider';
}

/// See also [_userProfileByHandle].
class _UserProfileByHandleProvider
    extends AutoDisposeFutureProvider<UserProfileModel> {
  /// See also [_userProfileByHandle].
  _UserProfileByHandleProvider(
    String handle,
  ) : this._internal(
          (ref) => _userProfileByHandle(
            ref as _UserProfileByHandleRef,
            handle,
          ),
          from: _userProfileByHandleProvider,
          name: r'_userProfileByHandleProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userProfileByHandleHash,
          dependencies: _UserProfileByHandleFamily._dependencies,
          allTransitiveDependencies:
              _UserProfileByHandleFamily._allTransitiveDependencies,
          handle: handle,
        );

  _UserProfileByHandleProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.handle,
  }) : super.internal();

  final String handle;

  @override
  Override overrideWith(
    FutureOr<UserProfileModel> Function(_UserProfileByHandleRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _UserProfileByHandleProvider._internal(
        (ref) => create(ref as _UserProfileByHandleRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        handle: handle,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<UserProfileModel> createElement() {
    return _UserProfileByHandleProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _UserProfileByHandleProvider && other.handle == handle;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, handle.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin _UserProfileByHandleRef
    on AutoDisposeFutureProviderRef<UserProfileModel> {
  /// The parameter `handle` of this provider.
  String get handle;
}

class _UserProfileByHandleProviderElement
    extends AutoDisposeFutureProviderElement<UserProfileModel>
    with _UserProfileByHandleRef {
  _UserProfileByHandleProviderElement(super.provider);

  @override
  String get handle => (origin as _UserProfileByHandleProvider).handle;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
