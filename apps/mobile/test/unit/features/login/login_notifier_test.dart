import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/login/application/login_form_state.dart';
import 'package:shelfie/features/login/application/login_notifier.dart';

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
      );
      expect(state, isA<LoginStateSuccess>());
      expect((state as LoginStateSuccess).userId, equals('test-user-id'));
      expect(state.email, equals('test@example.com'));
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

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('初期状態は initial', () {
      final state = container.read(loginNotifierProvider);
      expect(state, isA<LoginStateInitial>());
    });

    test('login は loading 状態を経由して success になる', () async {
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
    });

    test('reset で初期状態に戻る', () async {
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
