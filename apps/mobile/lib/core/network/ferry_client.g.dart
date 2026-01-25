// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ferry_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$apiEndpointHash() => r'74756f2506ab79a6653a5f793c84821890a25561';

/// API エンドポイント Provider
///
/// GraphQL API のベース URL を提供する。
/// テスト時にはオーバーライドして異なるエンドポイントを使用可能。
///
/// 環境変数 `API_BASE_URL` が設定されている場合はそれを使用し、
/// 未設定の場合はプラットフォームに応じたローカル開発用URLを返す。
///
/// Copied from [apiEndpoint].
@ProviderFor(apiEndpoint)
final apiEndpointProvider = Provider<String>.internal(
  apiEndpoint,
  name: r'apiEndpointProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$apiEndpointHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ApiEndpointRef = ProviderRef<String>;
String _$authTokenHash() => r'1deb832b3c938ce4bb7b7db726435c3f9c29c9a3';

/// 認証トークン Provider
///
/// 認証済みユーザーの JWT トークンを提供する。
/// null の場合は未認証状態を示す。
///
/// Copied from [authToken].
@ProviderFor(authToken)
final authTokenProvider = Provider<String?>.internal(
  authToken,
  name: r'authTokenProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authTokenHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthTokenRef = ProviderRef<String?>;
String _$ferryCacheBoxHash() => r'37ffb897b3a7ad2a1dadc7d58442c22bd079efe2';

/// Hive Box Provider
///
/// Ferry のキャッシュ用 Hive Box を非同期で提供する。
/// アプリ起動時に初期化される。
///
/// Copied from [ferryCacheBox].
@ProviderFor(ferryCacheBox)
final ferryCacheBoxProvider =
    FutureProvider<Box<Map<dynamic, dynamic>>>.internal(
  ferryCacheBox,
  name: r'ferryCacheBoxProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$ferryCacheBoxHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FerryCacheBoxRef = FutureProviderRef<Box<Map<dynamic, dynamic>>>;
String _$ferryCacheHash() => r'cb4965623268ab5712e4e27ccb2bcdd4676a0fcf';

/// Ferry Cache Provider
///
/// HiveStore を使用したオフラインキャッシュを提供する。
/// キャッシュファースト戦略により、オフライン時でもデータを表示可能。
///
/// 注意: このプロバイダーは ferryCacheBoxProvider が完了するまで待機する必要がある。
/// テスト時には MemoryStore を使用した Cache でオーバーライド可能。
///
/// Copied from [ferryCache].
@ProviderFor(ferryCache)
final ferryCacheProvider = Provider<Cache>.internal(
  ferryCache,
  name: r'ferryCacheProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$ferryCacheHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FerryCacheRef = ProviderRef<Cache>;
String _$ferryHiveCacheHash() => r'9e8272607f7e70ad62e587a4f7005a4bf7bc808a';

/// HiveStore 付き Ferry Cache Provider
///
/// Hive Box を使用したオフラインキャッシュを提供する。
/// アプリ起動時の初期化完了後に使用可能。
///
/// Copied from [ferryHiveCache].
@ProviderFor(ferryHiveCache)
final ferryHiveCacheProvider = FutureProvider<Cache>.internal(
  ferryHiveCache,
  name: r'ferryHiveCacheProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$ferryHiveCacheHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FerryHiveCacheRef = FutureProviderRef<Cache>;
String _$ferryClientHash() => r'8cc9f46ebfc56c5415480452e5df0cbd09fb29bf';

/// Ferry Client Provider
///
/// GraphQL API と通信するための Ferry Client を提供する。
///
/// 特徴:
/// - HttpLink を使用した HTTP 通信
/// - 認証トークンを Authorization ヘッダーに自動設定
/// - リクエスト前にトークンの有効期限を確認しリフレッシュ
/// - HiveStore によるオフラインキャッシュ
/// - デフォルトの FetchPolicy 設定
///
/// 使用方法:
/// ```dart
/// final client = ref.watch(ferryClientProvider);
/// final response = await client.request(yourRequest).first;
/// ```
///
/// Copied from [ferryClient].
@ProviderFor(ferryClient)
final ferryClientProvider = Provider<Client>.internal(
  ferryClient,
  name: r'ferryClientProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$ferryClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FerryClientRef = ProviderRef<Client>;
String _$ensureValidTokenHash() => r'6a2473fa4c966b7c66ab36ea0cbb4a4afee44283';

/// トークンリフレッシュを行うかどうかのフラグ Provider
///
/// 認証が必要な API リクエスト前にトークンの有効性を確認し、
/// 必要に応じてリフレッシュする。
///
/// Copied from [ensureValidToken].
@ProviderFor(ensureValidToken)
final ensureValidTokenProvider = AutoDisposeFutureProvider<bool>.internal(
  ensureValidToken,
  name: r'ensureValidTokenProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$ensureValidTokenHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EnsureValidTokenRef = AutoDisposeFutureProviderRef<bool>;
String _$authenticatedClientHash() =>
    r'ce33dd1f968554eb59bcb0af98028bff164ce6f5';

/// 認証付き API リクエスト用ヘルパー
///
/// API リクエスト前にトークンの有効性を確認し、
/// 必要に応じてリフレッシュしてからクライアントを返す。
///
/// 使用方法:
/// ```dart
/// final client = await ref.read(authenticatedClientProvider.future);
/// final response = await client.request(yourRequest).first;
/// ```
///
/// Copied from [authenticatedClient].
@ProviderFor(authenticatedClient)
final authenticatedClientProvider = AutoDisposeFutureProvider<Client>.internal(
  authenticatedClient,
  name: r'authenticatedClientProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authenticatedClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthenticatedClientRef = AutoDisposeFutureProviderRef<Client>;
String _$clearCacheHash() => r'c8f9c8b204f99b3090b35ea56a6e409ede6f07c2';

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

/// キャッシュクリア Provider
///
/// Ferry Client のキャッシュを完全にクリアする。
/// ログアウト時やデータの強制リフレッシュ時に使用する。
///
/// Copied from [clearCache].
@ProviderFor(clearCache)
const clearCacheProvider = ClearCacheFamily();

/// キャッシュクリア Provider
///
/// Ferry Client のキャッシュを完全にクリアする。
/// ログアウト時やデータの強制リフレッシュ時に使用する。
///
/// Copied from [clearCache].
class ClearCacheFamily extends Family<void> {
  /// キャッシュクリア Provider
  ///
  /// Ferry Client のキャッシュを完全にクリアする。
  /// ログアウト時やデータの強制リフレッシュ時に使用する。
  ///
  /// Copied from [clearCache].
  const ClearCacheFamily();

  /// キャッシュクリア Provider
  ///
  /// Ferry Client のキャッシュを完全にクリアする。
  /// ログアウト時やデータの強制リフレッシュ時に使用する。
  ///
  /// Copied from [clearCache].
  ClearCacheProvider call(
    Client client,
  ) {
    return ClearCacheProvider(
      client,
    );
  }

  @override
  ClearCacheProvider getProviderOverride(
    covariant ClearCacheProvider provider,
  ) {
    return call(
      provider.client,
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
  String? get name => r'clearCacheProvider';
}

/// キャッシュクリア Provider
///
/// Ferry Client のキャッシュを完全にクリアする。
/// ログアウト時やデータの強制リフレッシュ時に使用する。
///
/// Copied from [clearCache].
class ClearCacheProvider extends AutoDisposeProvider<void> {
  /// キャッシュクリア Provider
  ///
  /// Ferry Client のキャッシュを完全にクリアする。
  /// ログアウト時やデータの強制リフレッシュ時に使用する。
  ///
  /// Copied from [clearCache].
  ClearCacheProvider(
    Client client,
  ) : this._internal(
          (ref) => clearCache(
            ref as ClearCacheRef,
            client,
          ),
          from: clearCacheProvider,
          name: r'clearCacheProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$clearCacheHash,
          dependencies: ClearCacheFamily._dependencies,
          allTransitiveDependencies:
              ClearCacheFamily._allTransitiveDependencies,
          client: client,
        );

  ClearCacheProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.client,
  }) : super.internal();

  final Client client;

  @override
  Override overrideWith(
    void Function(ClearCacheRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ClearCacheProvider._internal(
        (ref) => create(ref as ClearCacheRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        client: client,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<void> createElement() {
    return _ClearCacheProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ClearCacheProvider && other.client == client;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, client.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ClearCacheRef on AutoDisposeProviderRef<void> {
  /// The parameter `client` of this provider.
  Client get client;
}

class _ClearCacheProviderElement extends AutoDisposeProviderElement<void>
    with ClearCacheRef {
  _ClearCacheProviderElement(super.provider);

  @override
  Client get client => (origin as ClearCacheProvider).client;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
