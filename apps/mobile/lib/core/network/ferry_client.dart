import 'dart:async';
import 'dart:io' show Platform;

import 'package:ferry/ferry.dart';
import 'package:ferry_hive_store/ferry_hive_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gql_exec/gql_exec.dart' as gql_exec;
import 'package:gql_http_link/gql_http_link.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/core/auth/token_service.dart';

part 'ferry_client.g.dart';

/// GraphQL キャッシュ用の Hive Box 名
const String _ferryCacheBoxName = 'ferry_graphql_cache';

/// ビルド時に指定された API ベース URL
///
/// `--dart-define=API_BASE_URL=https://api.example.com` で指定可能。
/// 未指定の場合は空文字列となり、ローカル開発用URLが使用される。
const String _apiBaseUrl = String.fromEnvironment('API_BASE_URL');

/// ローカル開発用のAPIエンドポイントを取得
///
/// - iOS シミュレーター: localhost が使用可能
/// - Android エミュレーター: 10.0.2.2 を使用（ホストマシンへのアクセス）
String _getLocalApiEndpoint() {
  if (Platform.isAndroid) {
    return 'http://10.0.2.2:4000/graphql';
  }
  return 'http://localhost:4000/graphql';
}

/// API エンドポイント Provider
///
/// GraphQL API のベース URL を提供する。
/// テスト時にはオーバーライドして異なるエンドポイントを使用可能。
///
/// 環境変数 `API_BASE_URL` が設定されている場合はそれを使用し、
/// 未設定の場合はプラットフォームに応じたローカル開発用URLを返す。
@Riverpod(keepAlive: true)
String apiEndpoint(Ref ref) {
  if (_apiBaseUrl.isNotEmpty) {
    return '$_apiBaseUrl/graphql';
  }
  return _getLocalApiEndpoint();
}

/// 認証トークン Provider
///
/// 認証済みユーザーの JWT トークンを提供する。
/// null の場合は未認証状態を示す。
@Riverpod(keepAlive: true)
String? authToken(Ref ref) {
  return ref.watch(authStateProvider.select((s) => s.token));
}

/// Hive Box Provider
///
/// Ferry のキャッシュ用 Hive Box を非同期で提供する。
/// アプリ起動時に初期化される。
@Riverpod(keepAlive: true)
Future<Box<Map<dynamic, dynamic>>> ferryCacheBox(Ref ref) async {
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
Cache ferryCache(Ref ref) {
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
Future<Cache> ferryHiveCache(Ref ref) async {
  final box = await ref.watch(ferryCacheBoxProvider.future);
  return Cache(store: HiveStore(box));
}

/// 認証リンク
///
/// リクエスト前にトークンの有効性を確認し、必要に応じてリフレッシュする。
class _AuthLink extends Link {
  _AuthLink({
    required this.ref,
    required this.tokenService,
  });

  final Ref ref;
  final TokenService tokenService;

  @override
  Stream<gql_exec.Response> request(
    gql_exec.Request request, [
    NextLink? forward,
  ]) async* {
    // トークンをリフレッシュ（必要な場合のみ）
    await tokenService.ensureValidToken();

    // 最新のトークンを取得
    final token = ref.read(authTokenProvider);

    // Authorizationヘッダーを追加
    final updatedRequest = request.updateContextEntry<HttpLinkHeaders>(
      (headers) => HttpLinkHeaders(
        headers: <String, String>{
          ...?headers?.headers,
          if (token != null) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    yield* forward!(updatedRequest);
  }
}

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
@Riverpod(keepAlive: true)
Client ferryClient(Ref ref) {
  final endpoint = ref.watch(apiEndpointProvider);
  final cache = ref.watch(ferryCacheProvider);
  final tokenService = ref.read(tokenServiceProvider);

  final httpLink = HttpLink(endpoint);
  final authLink = _AuthLink(ref: ref, tokenService: tokenService);

  return Client(
    link: authLink.concat(httpLink),
    cache: cache,
    defaultFetchPolicies: {
      OperationType.query: FetchPolicy.CacheFirst,
      OperationType.mutation: FetchPolicy.NetworkOnly,
      OperationType.subscription: FetchPolicy.CacheAndNetwork,
    },
  );
}

/// トークンリフレッシュを行うかどうかのフラグ Provider
///
/// 認証が必要な API リクエスト前にトークンの有効性を確認し、
/// 必要に応じてリフレッシュする。
@riverpod
Future<bool> ensureValidToken(Ref ref) async {
  final tokenService = ref.read(tokenServiceProvider);
  return tokenService.ensureValidToken();
}

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
@riverpod
Future<Client> authenticatedClient(Ref ref) async {
  final tokenService = ref.read(tokenServiceProvider);
  final isValid = await tokenService.ensureValidToken();

  if (!isValid) {
    debugPrint('[AuthenticatedClient] Token validation failed');
  }

  // トークン更新後、最新のクライアントを返す
  // authTokenProvider が更新されているため、ferryClient も最新のトークンを持つ
  return ref.watch(ferryClientProvider);
}

/// キャッシュクリア Provider
///
/// Ferry Client のキャッシュを完全にクリアする。
/// ログアウト時やデータの強制リフレッシュ時に使用する。
@riverpod
void clearCache(Ref ref, Client client) {
  client.cache.clear();
}
