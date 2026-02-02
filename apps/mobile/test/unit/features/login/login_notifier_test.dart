import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/core/storage/secure_storage_service.dart';
import 'package:shelfie/features/login/application/login_form_state.dart';
import 'package:shelfie/features/login/application/login_notifier.dart';
import 'package:shelfie/features/login/data/login_repository.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

class MockSecureStorageService extends Mock implements SecureStorageService {}

void main() {
  group('LoginState', () {
    test('initial 状態を作成できる', () {
      const state = LoginState.initial();
      expect(state, isA<LoginStateInitial>());
    });

    test('loading 状態を作成できる', () {
      const state = LoginState.loading();
      expect(state, isA<LoginStateLoading>());
    });

    test('success 状態を作成できる', () {
      const state = LoginState.success(
        userId: 'test-user-id',
        email: 'test@example.com',
        idToken: 'test-id-token',
        refreshToken: 'test-refresh-token',
      );
      expect(state, isA<LoginStateSuccess>());
      expect((state as LoginStateSuccess).userId, equals('test-user-id'));
      expect(state.email, equals('test@example.com'));
      expect(state.idToken, equals('test-id-token'));
      expect(state.refreshToken, equals('test-refresh-token'));
    });

    test('error 状態を作成できる', () {
      const state = LoginState.error(message: 'Error message', field: 'email');
      expect(state, isA<LoginStateError>());
      expect((state as LoginStateError).message, equals('Error message'));
      expect(state.field, equals('email'));
    });

    test('error 状態は field なしでも作成できる', () {
      const state = LoginState.error(message: 'Error message');
      expect(state, isA<LoginStateError>());
      expect((state as LoginStateError).field, isNull);
    });
  });

  group('LoginNotifier', () {
    late ProviderContainer container;
    late MockLoginRepository mockRepository;
    late MockSecureStorageService mockStorage;

    setUp(() {
      mockRepository = MockLoginRepository();
      mockStorage = MockSecureStorageService();

      when(() => mockStorage.saveAuthData(
            userId: any(named: 'userId'),
            email: any(named: 'email'),
            idToken: any(named: 'idToken'),
            refreshToken: any(named: 'refreshToken'),
          )).thenAnswer((_) async {});
      when(() => mockStorage.updateTokens(
            idToken: any(named: 'idToken'),
            refreshToken: any(named: 'refreshToken'),
          )).thenAnswer((_) async {});
      when(() => mockStorage.clearAuthData()).thenAnswer((_) async {});
      when(() => mockStorage.loadAuthData()).thenAnswer((_) async => null);
      when(() => mockStorage.saveGuestMode(isGuest: any(named: 'isGuest')))
          .thenAnswer((_) async {});
      when(() => mockStorage.loadGuestMode()).thenAnswer((_) async => false);
      when(() => mockStorage.clearGuestMode()).thenAnswer((_) async {});

      container = ProviderContainer(
        overrides: [
          loginRepositoryProvider.overrideWithValue(mockRepository),
          secureStorageServiceProvider.overrideWithValue(mockStorage),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('初期状態は initial', () {
      final state = container.read(loginNotifierProvider);
      expect(state, isA<LoginStateInitial>());
    });

    test('login は loading 状態を経由して success になる', () async {
      when(
        () => mockRepository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => right(
          const LoggedInUser(
            id: 1,
            email: 'test@example.com',
            idToken: 'test-id-token',
            refreshToken: 'test-refresh-token',
          ),
        ),
      );

      final formNotifier = container.read(loginFormStateProvider.notifier);
      formNotifier.updateEmail('test@example.com');
      formNotifier.updatePassword('password123');

      final loginNotifier = container.read(loginNotifierProvider.notifier);

      final states = <LoginState>[];
      container.listen(loginNotifierProvider, (previous, next) {
        states.add(next);
      });

      await loginNotifier.login();

      expect(states, contains(isA<LoginStateLoading>()));
      expect(states.last, isA<LoginStateSuccess>());
      expect(
        (states.last as LoginStateSuccess).idToken,
        equals('test-id-token'),
      );
    });

    test('login 失敗時は error 状態になる', () async {
      when(
        () => mockRepository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => left(
          const InvalidCredentialsError(
            'メールアドレスまたはパスワードが正しくありません',
          ),
        ),
      );

      final formNotifier = container.read(loginFormStateProvider.notifier);
      formNotifier.updateEmail('test@example.com');
      formNotifier.updatePassword('wrong-password');

      final loginNotifier = container.read(loginNotifierProvider.notifier);

      final states = <LoginState>[];
      container.listen(loginNotifierProvider, (previous, next) {
        states.add(next);
      });

      await loginNotifier.login();

      expect(states, contains(isA<LoginStateLoading>()));
      expect(states.last, isA<LoginStateError>());
      expect(
        (states.last as LoginStateError).message,
        contains('メールアドレスまたはパスワード'),
      );
    });

    test('login 成功時に authState にトークンがセットされる', () async {
      when(
        () => mockRepository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => right(
          const LoggedInUser(
            id: 1,
            email: 'test@example.com',
            idToken: 'test-id-token',
            refreshToken: 'test-refresh-token',
          ),
        ),
      );

      final formNotifier = container.read(loginFormStateProvider.notifier);
      formNotifier.updateEmail('test@example.com');
      formNotifier.updatePassword('password123');

      await container.read(loginNotifierProvider.notifier).login();

      expect(container.read(authStateProvider).token, equals('test-id-token'));
    });

    test('reset で初期状態に戻る', () async {
      when(
        () => mockRepository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => right(
          const LoggedInUser(
            id: 1,
            email: 'test@example.com',
            idToken: 'test-id-token',
            refreshToken: 'test-refresh-token',
          ),
        ),
      );

      final formNotifier = container.read(loginFormStateProvider.notifier);
      formNotifier.updateEmail('test@example.com');
      formNotifier.updatePassword('password123');

      final loginNotifier = container.read(loginNotifierProvider.notifier);

      final states = <LoginState>[];
      container.listen(loginNotifierProvider, (previous, next) {
        states.add(next);
      });

      await loginNotifier.login();
      expect(states.last, isA<LoginStateSuccess>());

      loginNotifier.reset();
      expect(container.read(loginNotifierProvider), isA<LoginStateInitial>());
    });
  });
}
