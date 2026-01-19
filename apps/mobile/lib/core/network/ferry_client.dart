import 'package:ferry/ferry.dart';
import 'package:ferry_hive_store/ferry_hive_store.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ferry_client.g.dart';

/// GraphQL キャッシュ用の Hive Box 名
const String _ferryCacheBoxName = 'ferry_graphql_cache';

/// API エンドポイント Provider
///
/// GraphQL API のベース URL を提供する。
/// テスト時にはオーバーライドして異なるエンドポイントを使用可能。
@Riverpod(keepAlive: true)
String apiEndpoint(ApiEndpointRef ref) {
  // TODO(shelfie): 環境変数または設定ファイルから取得
  return 'https://api.shelfie.example.com/graphql';
}

/// 認証トークン Provider
///
/// 認証済みユーザーの JWT トークンを提供する。
/// null の場合は未認証状態を示す。
@Riverpod(keepAlive: true)
String? authToken(AuthTokenRef ref) {
  // TODO(shelfie): SecureStorage から取得する実装に置き換え
  return null;
}

/// Hive Box Provider
///
/// Ferry のキャッシュ用 Hive Box を非同期で提供する。
/// アプリ起動時に初期化される。
@Riverpod(keepAlive: true)
Future<Box<Map<dynamic, dynamic>>> ferryCacheBox(FerryCacheBoxRef ref) async {
  return Hive.openBox<Map<dynamic, dynamic>>(_ferryCacheBoxName);
}

/// Ferry Cache Provider
///
/// HiveStore を使用したオフラインキャッシュを提供する。
/// キャッシュファースト戦略により、オフライン時でもデータを表示可能。
///
/// 注意: このプロバイダーは ferryCacheBoxProvider が完了するまで待機する必要がある。
/// テスト時には MemoryStore を使用した Cache でオーバーライド可能。
@Riverpod(keepAlive: true)
Cache ferryCache(FerryCacheRef ref) {
  // メモリキャッシュをデフォルトとして使用
  // 実際のアプリでは ferryCacheBoxProvider を事前に初期化し、
  // HiveStore を使用する
  return Cache();
}

/// HiveStore 付き Ferry Cache Provider
///
/// Hive Box を使用したオフラインキャッシュを提供する。
/// アプリ起動時の初期化完了後に使用可能。
@Riverpod(keepAlive: true)
Future<Cache> ferryHiveCache(FerryHiveCacheRef ref) async {
  final box = await ref.watch(ferryCacheBoxProvider.future);
  return Cache(store: HiveStore(box));
}

/// Ferry Client Provider
///
/// GraphQL API と通信するための Ferry Client を提供する。
///
/// 特徴:
/// - HttpLink を使用した HTTP 通信
/// - 認証トークンを Authorization ヘッダーに自動設定
/// - HiveStore によるオフラインキャッシュ
/// - デフォルトの FetchPolicy 設定
///
/// 使用方法:
/// ```dart
/// final client = ref.watch(ferryClientProvider);
/// final response = await client.request(yourRequest).first;
/// ```
@Riverpod(keepAlive: true)
Client ferryClient(FerryClientRef ref) {
  final endpoint = ref.watch(apiEndpointProvider);
  final authToken = ref.watch(authTokenProvider);
  final cache = ref.watch(ferryCacheProvider);

  final httpLink = HttpLink(
    endpoint,
    defaultHeaders: {
      if (authToken != null) 'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json',
    },
  );

  return Client(
    link: httpLink,
    cache: cache,
    defaultFetchPolicies: {
      OperationType.query: FetchPolicy.CacheFirst,
      OperationType.mutation: FetchPolicy.NetworkOnly,
      OperationType.subscription: FetchPolicy.CacheAndNetwork,
    },
  );
}

/// キャッシュクリア Provider
///
/// Ferry Client のキャッシュを完全にクリアする。
/// ログアウト時やデータの強制リフレッシュ時に使用する。
@riverpod
void clearCache(ClearCacheRef ref, Client client) {
  client.cache.clear();
}
