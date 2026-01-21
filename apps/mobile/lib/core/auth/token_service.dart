import 'dart:convert';
import 'dart:io' show Platform;

import 'package:ferry/ferry.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/auth/__generated__/refresh_token.data.gql.dart';
import 'package:shelfie/core/auth/__generated__/refresh_token.req.gql.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart';

part 'token_service.g.dart';

sealed class TokenRefreshError {
  const TokenRefreshError();
}

class InvalidTokenError extends TokenRefreshError {
  const InvalidTokenError(this.message);
  final String message;
}

class TokenExpiredError extends TokenRefreshError {
  const TokenExpiredError(this.message);
  final String message;
}

class NetworkRefreshError extends TokenRefreshError {
  const NetworkRefreshError(this.message);
  final String message;
}

class UnknownRefreshError extends TokenRefreshError {
  const UnknownRefreshError(this.message);
  final String message;
}

class TokenInfo {
  const TokenInfo({
    required this.idToken,
    required this.refreshToken,
  });

  final String idToken;
  final String refreshToken;
}

@Riverpod(keepAlive: true)
TokenService tokenService(TokenServiceRef ref) {
  return TokenService(ref: ref);
}

class TokenService {
  TokenService({required this.ref});

  final TokenServiceRef ref;

  static const int _refreshThresholdSeconds = 5 * 60; // 5分前にリフレッシュ

  DateTime? getTokenExpiration(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;

      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final json = jsonDecode(decoded) as Map<String, dynamic>;

      final exp = json['exp'] as int?;
      if (exp == null) return null;

      return DateTime.fromMillisecondsSinceEpoch(exp * 1000);
    } catch (e) {
      debugPrint('[TokenService] Failed to decode token: $e');
      return null;
    }
  }

  bool isTokenExpiringSoon(String token) {
    final expiration = getTokenExpiration(token);
    if (expiration == null) return true;

    final now = DateTime.now();
    final threshold = expiration.subtract(
      const Duration(seconds: _refreshThresholdSeconds),
    );

    return now.isAfter(threshold);
  }

  bool isTokenExpired(String token) {
    final expiration = getTokenExpiration(token);
    if (expiration == null) return true;

    return DateTime.now().isAfter(expiration);
  }

  Future<Either<TokenRefreshError, TokenInfo>> refreshTokens({
    required Client client,
    required String refreshToken,
  }) async {
    debugPrint('[TokenService] Refreshing tokens...');

    final request = GRefreshTokenReq(
      (b) => b
        ..vars.input = GRefreshTokenInput(
          (i) => i..refreshToken = refreshToken,
        ).toBuilder(),
    );

    try {
      final response = await client.request(request).first;

      if (response.hasErrors) {
        final errorMessage =
            response.graphqlErrors?.first.message ?? 'トークンの更新に失敗しました';
        debugPrint('[TokenService] GraphQL error: $errorMessage');
        return left(UnknownRefreshError(errorMessage));
      }

      final result = response.data?.refreshToken;
      if (result == null) {
        return left(const UnknownRefreshError('レスポンスが空です'));
      }

      if (result
          is GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess) {
        final data = result.data;
        debugPrint('[TokenService] Token refresh successful');
        return right(
          TokenInfo(
            idToken: data.idToken,
            refreshToken: data.refreshToken,
          ),
        );
      }

      if (result is GRefreshTokenData_refreshToken__asAuthError) {
        debugPrint(
          '[TokenService] AuthError: code=${result.code}, message=${result.message}',
        );
        return left(_mapAuthError(result));
      }

      return left(const UnknownRefreshError('予期しないレスポンス形式です'));
    } catch (e, stackTrace) {
      debugPrint('[TokenService] Exception: $e');
      debugPrint('[TokenService] StackTrace: $stackTrace');
      return left(UnknownRefreshError(e.toString()));
    }
  }

  TokenRefreshError _mapAuthError(
    GRefreshTokenData_refreshToken__asAuthError error,
  ) {
    final message = error.message ?? 'エラーが発生しました';
    return switch (error.code) {
      GAuthErrorCode.INVALID_TOKEN => InvalidTokenError(message),
      GAuthErrorCode.TOKEN_EXPIRED => TokenExpiredError(message),
      GAuthErrorCode.NETWORK_ERROR => NetworkRefreshError(message),
      _ => UnknownRefreshError(message),
    };
  }

  Future<bool> ensureValidToken() async {
    final authState = ref.read(authStateProvider);

    if (!authState.isAuthenticated) {
      debugPrint('[TokenService] User is not authenticated');
      return false;
    }

    final token = authState.token;
    final currentRefreshToken = authState.refreshToken;

    if (token == null || currentRefreshToken == null) {
      debugPrint('[TokenService] Token or refresh token is null');
      return false;
    }

    if (!isTokenExpiringSoon(token)) {
      return true;
    }

    debugPrint('[TokenService] Token is expiring soon, refreshing...');

    // 循環参照を避けるため、直接 HttpLink を使用してリフレッシュ
    final result = await _refreshWithHttpLink(currentRefreshToken);

    return result.fold(
      (error) {
        debugPrint('[TokenService] Token refresh failed: $error');
        if (error is InvalidTokenError || error is TokenExpiredError) {
          ref.read(authStateProvider.notifier).logout();
        }
        return false;
      },
      (tokenInfo) {
        ref.read(authStateProvider.notifier).updateTokens(
              token: tokenInfo.idToken,
              refreshToken: tokenInfo.refreshToken,
            );
        return true;
      },
    );
  }

  Future<Either<TokenRefreshError, TokenInfo>> _refreshWithHttpLink(
    String refreshToken,
  ) async {
    // ferry_client の循環参照を避けるため、簡易的な HTTP リクエストを使用
    // 本来は DI で解決すべきだが、シンプルさを優先
    final apiEndpoint = _getApiEndpoint();

    final request = GRefreshTokenReq(
      (b) => b
        ..vars.input = GRefreshTokenInput(
          (i) => i..refreshToken = refreshToken,
        ).toBuilder(),
    );

    try {
      final client = Client(
        link: HttpLink(apiEndpoint),
        cache: Cache(),
      );

      final response = await client.request(request).first;

      if (response.hasErrors) {
        final errorMessage =
            response.graphqlErrors?.first.message ?? 'トークンの更新に失敗しました';
        return left(UnknownRefreshError(errorMessage));
      }

      final result = response.data?.refreshToken;
      if (result == null) {
        return left(const UnknownRefreshError('レスポンスが空です'));
      }

      if (result
          is GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess) {
        final data = result.data;
        return right(
          TokenInfo(
            idToken: data.idToken,
            refreshToken: data.refreshToken,
          ),
        );
      }

      if (result is GRefreshTokenData_refreshToken__asAuthError) {
        return left(_mapAuthError(result));
      }

      return left(const UnknownRefreshError('予期しないレスポンス形式です'));
    } catch (e) {
      return left(UnknownRefreshError(e.toString()));
    }
  }

  String _getApiEndpoint() {
    const apiBaseUrl = String.fromEnvironment('API_BASE_URL');
    if (apiBaseUrl.isNotEmpty) {
      return '$apiBaseUrl/graphql';
    }
    // ローカル開発用
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:4000/graphql';
    }
    return 'http://localhost:4000/graphql';
  }
}
