import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/login/application/login_form_state.dart';

void main() {
  group('LoginFormData', () {
    test('デフォルト値が正しく設定される', () {
      const data = LoginFormData();
      expect(data.email, equals(''));
      expect(data.password, equals(''));
      expect(data.isPasswordObscured, isTrue);
    });

    test('copyWith で値を更新できる', () {
      const data = LoginFormData();
      final updated = data.copyWith(
        email: 'test@example.com',
        password: 'password123',
        isPasswordObscured: false,
      );

      expect(updated.email, equals('test@example.com'));
      expect(updated.password, equals('password123'));
      expect(updated.isPasswordObscured, isFalse);
    });
  });

  group('LoginFormState', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('初期状態はデフォルト値', () {
      final state = container.read(loginFormStateProvider);
      expect(state.email, equals(''));
      expect(state.password, equals(''));
      expect(state.isPasswordObscured, isTrue);
    });

    test('updateEmail でメールアドレスを更新できる', () {
      container.read(loginFormStateProvider.notifier).updateEmail('test@example.com');
      final state = container.read(loginFormStateProvider);
      expect(state.email, equals('test@example.com'));
    });

    test('updatePassword でパスワードを更新できる', () {
      container.read(loginFormStateProvider.notifier).updatePassword('password123');
      final state = container.read(loginFormStateProvider);
      expect(state.password, equals('password123'));
    });

    test('togglePasswordVisibility でパスワードの表示/非表示を切り替えられる', () {
      final notifier = container.read(loginFormStateProvider.notifier);

      expect(container.read(loginFormStateProvider).isPasswordObscured, isTrue);

      notifier.togglePasswordVisibility();
      expect(container.read(loginFormStateProvider).isPasswordObscured, isFalse);

      notifier.togglePasswordVisibility();
      expect(container.read(loginFormStateProvider).isPasswordObscured, isTrue);
    });

    group('emailError', () {
      test('メールアドレスが空の場合は null を返す', () {
        expect(container.read(loginFormStateProvider.notifier).emailError, isNull);
      });

      test('メールアドレスが有効な場合は null を返す', () {
        container.read(loginFormStateProvider.notifier).updateEmail('test@example.com');
        expect(container.read(loginFormStateProvider.notifier).emailError, isNull);
      });

      test('メールアドレスが不正な場合はエラーメッセージを返す', () {
        container.read(loginFormStateProvider.notifier).updateEmail('invalid-email');
        expect(
          container.read(loginFormStateProvider.notifier).emailError,
          equals('有効なメールアドレスを入力してください'),
        );
      });
    });

    group('isValid', () {
      test('すべての入力が空の場合は false を返す', () {
        expect(container.read(loginFormStateProvider.notifier).isValid, isFalse);
      });

      test('メールアドレスのみ入力されている場合は false を返す', () {
        container.read(loginFormStateProvider.notifier).updateEmail('test@example.com');
        expect(container.read(loginFormStateProvider.notifier).isValid, isFalse);
      });

      test('パスワードのみ入力されている場合は false を返す', () {
        container.read(loginFormStateProvider.notifier).updatePassword('password123');
        expect(container.read(loginFormStateProvider.notifier).isValid, isFalse);
      });

      test('メールアドレスとパスワードが入力されている場合は true を返す', () {
        final notifier = container.read(loginFormStateProvider.notifier);
        notifier.updateEmail('test@example.com');
        notifier.updatePassword('password123');
        expect(notifier.isValid, isTrue);
      });

      test('メールアドレスが不正な場合は false を返す', () {
        final notifier = container.read(loginFormStateProvider.notifier);
        notifier.updateEmail('invalid-email');
        notifier.updatePassword('password123');
        expect(notifier.isValid, isFalse);
      });
    });
  });
}
