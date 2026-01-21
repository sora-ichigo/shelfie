import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage_service.g.dart';

@Riverpod(keepAlive: true)
SecureStorageService secureStorageService(SecureStorageServiceRef ref) {
  return SecureStorageService();
}

class SecureStorageService {
  SecureStorageService({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static const String _keyUserId = 'auth_user_id';
  static const String _keyEmail = 'auth_email';
  static const String _keyIdToken = 'auth_id_token';
  static const String _keyRefreshToken = 'auth_refresh_token';

  Future<void> saveAuthData({
    required String userId,
    required String email,
    required String idToken,
    required String refreshToken,
  }) async {
    await Future.wait([
      _storage.write(key: _keyUserId, value: userId),
      _storage.write(key: _keyEmail, value: email),
      _storage.write(key: _keyIdToken, value: idToken),
      _storage.write(key: _keyRefreshToken, value: refreshToken),
    ]);
  }

  Future<void> updateTokens({
    required String idToken,
    required String refreshToken,
  }) async {
    await Future.wait([
      _storage.write(key: _keyIdToken, value: idToken),
      _storage.write(key: _keyRefreshToken, value: refreshToken),
    ]);
  }

  Future<AuthStorageData?> loadAuthData() async {
    final results = await Future.wait([
      _storage.read(key: _keyUserId),
      _storage.read(key: _keyEmail),
      _storage.read(key: _keyIdToken),
      _storage.read(key: _keyRefreshToken),
    ]);

    final userId = results[0];
    final email = results[1];
    final idToken = results[2];
    final refreshToken = results[3];

    if (userId == null ||
        email == null ||
        idToken == null ||
        refreshToken == null) {
      return null;
    }

    return AuthStorageData(
      userId: userId,
      email: email,
      idToken: idToken,
      refreshToken: refreshToken,
    );
  }

  Future<void> clearAuthData() async {
    await Future.wait([
      _storage.delete(key: _keyUserId),
      _storage.delete(key: _keyEmail),
      _storage.delete(key: _keyIdToken),
      _storage.delete(key: _keyRefreshToken),
    ]);
  }
}

class AuthStorageData {
  const AuthStorageData({
    required this.userId,
    required this.email,
    required this.idToken,
    required this.refreshToken,
  });

  final String userId;
  final String email;
  final String idToken;
  final String refreshToken;
}
