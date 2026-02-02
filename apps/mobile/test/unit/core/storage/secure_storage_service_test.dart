import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/storage/secure_storage_service.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  group('SecureStorageService', () {
    late MockFlutterSecureStorage mockStorage;
    late SecureStorageService service;

    setUp(() {
      mockStorage = MockFlutterSecureStorage();
      service = SecureStorageService(storage: mockStorage);
    });

    group('saveAuthData', () {
      test('すべての認証データが保存されること', () async {
        when(() => mockStorage.write(
              key: any(named: 'key'),
              value: any(named: 'value'),
            )).thenAnswer((_) async {});

        await service.saveAuthData(
          userId: 'user-123',
          email: 'test@example.com',
          idToken: 'id-token',
          refreshToken: 'refresh-token',
        );

        verify(() => mockStorage.write(key: 'auth_user_id', value: 'user-123'))
            .called(1);
        verify(() =>
                mockStorage.write(key: 'auth_email', value: 'test@example.com'))
            .called(1);
        verify(
                () => mockStorage.write(key: 'auth_id_token', value: 'id-token'))
            .called(1);
        verify(() => mockStorage.write(
            key: 'auth_refresh_token', value: 'refresh-token')).called(1);
      });
    });

    group('updateTokens', () {
      test('トークンのみが更新されること', () async {
        when(() => mockStorage.write(
              key: any(named: 'key'),
              value: any(named: 'value'),
            )).thenAnswer((_) async {});

        await service.updateTokens(
          idToken: 'new-id-token',
          refreshToken: 'new-refresh-token',
        );

        verify(() =>
                mockStorage.write(key: 'auth_id_token', value: 'new-id-token'))
            .called(1);
        verify(() => mockStorage.write(
            key: 'auth_refresh_token', value: 'new-refresh-token')).called(1);
        verifyNever(() => mockStorage.write(
              key: 'auth_user_id',
              value: any(named: 'value'),
            ));
        verifyNever(() => mockStorage.write(
              key: 'auth_email',
              value: any(named: 'value'),
            ));
      });
    });

    group('loadAuthData', () {
      test('すべてのデータが存在する場合は AuthStorageData を返すこと', () async {
        when(() => mockStorage.read(key: 'auth_user_id'))
            .thenAnswer((_) async => 'user-123');
        when(() => mockStorage.read(key: 'auth_email'))
            .thenAnswer((_) async => 'test@example.com');
        when(() => mockStorage.read(key: 'auth_id_token'))
            .thenAnswer((_) async => 'id-token');
        when(() => mockStorage.read(key: 'auth_refresh_token'))
            .thenAnswer((_) async => 'refresh-token');

        final result = await service.loadAuthData();

        expect(result, isNotNull);
        expect(result!.userId, equals('user-123'));
        expect(result.email, equals('test@example.com'));
        expect(result.idToken, equals('id-token'));
        expect(result.refreshToken, equals('refresh-token'));
      });

      test('userId が null の場合は null を返すこと', () async {
        when(() => mockStorage.read(key: 'auth_user_id'))
            .thenAnswer((_) async => null);
        when(() => mockStorage.read(key: 'auth_email'))
            .thenAnswer((_) async => 'test@example.com');
        when(() => mockStorage.read(key: 'auth_id_token'))
            .thenAnswer((_) async => 'id-token');
        when(() => mockStorage.read(key: 'auth_refresh_token'))
            .thenAnswer((_) async => 'refresh-token');

        final result = await service.loadAuthData();

        expect(result, isNull);
      });

      test('email が null の場合は null を返すこと', () async {
        when(() => mockStorage.read(key: 'auth_user_id'))
            .thenAnswer((_) async => 'user-123');
        when(() => mockStorage.read(key: 'auth_email'))
            .thenAnswer((_) async => null);
        when(() => mockStorage.read(key: 'auth_id_token'))
            .thenAnswer((_) async => 'id-token');
        when(() => mockStorage.read(key: 'auth_refresh_token'))
            .thenAnswer((_) async => 'refresh-token');

        final result = await service.loadAuthData();

        expect(result, isNull);
      });

      test('idToken が null の場合は null を返すこと', () async {
        when(() => mockStorage.read(key: 'auth_user_id'))
            .thenAnswer((_) async => 'user-123');
        when(() => mockStorage.read(key: 'auth_email'))
            .thenAnswer((_) async => 'test@example.com');
        when(() => mockStorage.read(key: 'auth_id_token'))
            .thenAnswer((_) async => null);
        when(() => mockStorage.read(key: 'auth_refresh_token'))
            .thenAnswer((_) async => 'refresh-token');

        final result = await service.loadAuthData();

        expect(result, isNull);
      });

      test('refreshToken が null の場合は null を返すこと', () async {
        when(() => mockStorage.read(key: 'auth_user_id'))
            .thenAnswer((_) async => 'user-123');
        when(() => mockStorage.read(key: 'auth_email'))
            .thenAnswer((_) async => 'test@example.com');
        when(() => mockStorage.read(key: 'auth_id_token'))
            .thenAnswer((_) async => 'id-token');
        when(() => mockStorage.read(key: 'auth_refresh_token'))
            .thenAnswer((_) async => null);

        final result = await service.loadAuthData();

        expect(result, isNull);
      });
    });

    group('clearAuthData', () {
      test('すべての認証データが削除されること', () async {
        when(() => mockStorage.delete(key: any(named: 'key')))
            .thenAnswer((_) async {});

        await service.clearAuthData();

        verify(() => mockStorage.delete(key: 'auth_user_id')).called(1);
        verify(() => mockStorage.delete(key: 'auth_email')).called(1);
        verify(() => mockStorage.delete(key: 'auth_id_token')).called(1);
        verify(() => mockStorage.delete(key: 'auth_refresh_token')).called(1);
      });
    });
  });

  group('Guest mode storage', () {
    late MockFlutterSecureStorage mockStorage;
    late SecureStorageService service;

    setUp(() {
      mockStorage = MockFlutterSecureStorage();
      service = SecureStorageService(storage: mockStorage);
    });

    group('saveGuestMode', () {
      test('ゲストモードフラグが保存されること', () async {
        when(() => mockStorage.write(
              key: any(named: 'key'),
              value: any(named: 'value'),
            )).thenAnswer((_) async {});

        await service.saveGuestMode(isGuest: true);

        verify(() =>
                mockStorage.write(key: 'guest_mode', value: 'true'))
            .called(1);
      });
    });

    group('loadGuestMode', () {
      test('ゲストモードフラグが保存されている場合は true を返すこと', () async {
        when(() => mockStorage.read(key: 'guest_mode'))
            .thenAnswer((_) async => 'true');

        final result = await service.loadGuestMode();

        expect(result, isTrue);
      });

      test('ゲストモードフラグが保存されていない場合は false を返すこと', () async {
        when(() => mockStorage.read(key: 'guest_mode'))
            .thenAnswer((_) async => null);

        final result = await service.loadGuestMode();

        expect(result, isFalse);
      });
    });

    group('clearGuestMode', () {
      test('ゲストモードフラグが削除されること', () async {
        when(() => mockStorage.delete(key: any(named: 'key')))
            .thenAnswer((_) async {});

        await service.clearGuestMode();

        verify(() => mockStorage.delete(key: 'guest_mode')).called(1);
      });
    });
  });

  group('AuthStorageData', () {
    test('正しく作成されること', () {
      const data = AuthStorageData(
        userId: 'user-123',
        email: 'test@example.com',
        idToken: 'id-token',
        refreshToken: 'refresh-token',
      );

      expect(data.userId, equals('user-123'));
      expect(data.email, equals('test@example.com'));
      expect(data.idToken, equals('id-token'));
      expect(data.refreshToken, equals('refresh-token'));
    });
  });
}
