import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/registration/application/registration_form_state.dart';

void main() {
  group('RegistrationFormData', () {
    test('デフォルト値が正しく設定される', () {
      const data = RegistrationFormData();
      expect(data.email, equals(''));
      expect(data.password, equals(''));
      expect(data.passwordConfirmation, equals(''));
      expect(data.isPasswordObscured, isTrue);
      expect(data.isPasswordConfirmationObscured, isTrue);
    });

    test('copyWith で値を更新できる', () {
      const data = RegistrationFormData();
      final updated = data.copyWith(
        email: 'test@example.com',
        password: 'password123',
        passwordConfirmation: 'password123',
        isPasswordObscured: false,
        isPasswordConfirmationObscured: false,
      );

      expect(updated.email, equals('test@example.com'));
      expect(updated.password, equals('password123'));
      expect(updated.passwordConfirmation, equals('password123'));
      expect(updated.isPasswordObscured, isFalse);
      expect(updated.isPasswordConfirmationObscured, isFalse);
    });
  });

  group('RegistrationFormState', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('初期状態はデフォルト値', () {
      final state = container.read(registrationFormStateProvider);
      expect(state.email, equals(''));
      expect(state.password, equals(''));
      expect(state.passwordConfirmation, equals(''));
      expect(state.isPasswordObscured, isTrue);
      expect(state.isPasswordConfirmationObscured, isTrue);
    });

    test('updateEmail でメールアドレスを更新できる', () {
      container.read(registrationFormStateProvider.notifier).updateEmail('test@example.com');
      final state = container.read(registrationFormStateProvider);
      expect(state.email, equals('test@example.com'));
    });

    test('updatePassword でパスワードを更新できる', () {
      container.read(registrationFormStateProvider.notifier).updatePassword('password123');
      final state = container.read(registrationFormStateProvider);
      expect(state.password, equals('password123'));
    });

    test('updatePasswordConfirmation で確認用パスワードを更新できる', () {
      container
          .read(registrationFormStateProvider.notifier)
          .updatePasswordConfirmation('password123');
      final state = container.read(registrationFormStateProvider);
      expect(state.passwordConfirmation, equals('password123'));
    });

    test('togglePasswordVisibility でパスワードの表示/非表示を切り替えられる', () {
      final notifier = container.read(registrationFormStateProvider.notifier);

      expect(container.read(registrationFormStateProvider).isPasswordObscured, isTrue);

      notifier.togglePasswordVisibility();
      expect(container.read(registrationFormStateProvider).isPasswordObscured, isFalse);

      notifier.togglePasswordVisibility();
      expect(container.read(registrationFormStateProvider).isPasswordObscured, isTrue);
    });

    test('togglePasswordConfirmationVisibility で確認用パスワードの表示/非表示を切り替えられる', () {
      final notifier = container.read(registrationFormStateProvider.notifier);

      expect(container.read(registrationFormStateProvider).isPasswordConfirmationObscured, isTrue);

      notifier.togglePasswordConfirmationVisibility();
      expect(container.read(registrationFormStateProvider).isPasswordConfirmationObscured, isFalse);

      notifier.togglePasswordConfirmationVisibility();
      expect(container.read(registrationFormStateProvider).isPasswordConfirmationObscured, isTrue);
    });

    group('emailError', () {
      test('メールアドレスが空の場合は null を返す', () {
        expect(container.read(registrationFormStateProvider.notifier).emailError, isNull);
      });

      test('メールアドレスが有効な場合は null を返す', () {
        container.read(registrationFormStateProvider.notifier).updateEmail('test@example.com');
        expect(container.read(registrationFormStateProvider.notifier).emailError, isNull);
      });

      test('メールアドレスが不正な場合はエラーメッセージを返す', () {
        container.read(registrationFormStateProvider.notifier).updateEmail('invalid-email');
        expect(
          container.read(registrationFormStateProvider.notifier).emailError,
          equals('有効なメールアドレスを入力してください'),
        );
      });
    });

    group('passwordError', () {
      test('パスワードが空の場合は null を返す', () {
        expect(container.read(registrationFormStateProvider.notifier).passwordError, isNull);
      });

      test('パスワードが8文字以上の場合は null を返す', () {
        container.read(registrationFormStateProvider.notifier).updatePassword('password123');
        expect(container.read(registrationFormStateProvider.notifier).passwordError, isNull);
      });

      test('パスワードが8文字未満の場合はエラーメッセージを返す', () {
        container.read(registrationFormStateProvider.notifier).updatePassword('short');
        expect(
          container.read(registrationFormStateProvider.notifier).passwordError,
          equals('パスワードは8文字以上で入力してください'),
        );
      });
    });

    group('passwordConfirmationError', () {
      test('確認用パスワードが空の場合は null を返す', () {
        container.read(registrationFormStateProvider.notifier).updatePassword('password123');
        expect(
          container.read(registrationFormStateProvider.notifier).passwordConfirmationError,
          isNull,
        );
      });

      test('パスワードと一致する場合は null を返す', () {
        final notifier = container.read(registrationFormStateProvider.notifier);
        notifier.updatePassword('password123');
        notifier.updatePasswordConfirmation('password123');
        expect(notifier.passwordConfirmationError, isNull);
      });

      test('パスワードと一致しない場合はエラーメッセージを返す', () {
        final notifier = container.read(registrationFormStateProvider.notifier);
        notifier.updatePassword('password123');
        notifier.updatePasswordConfirmation('password456');
        expect(notifier.passwordConfirmationError, equals('パスワードが一致しません'));
      });
    });

    group('isValid', () {
      test('すべての入力が空の場合は false を返す', () {
        expect(container.read(registrationFormStateProvider.notifier).isValid, isFalse);
      });

      test('メールアドレスのみ入力されている場合は false を返す', () {
        container.read(registrationFormStateProvider.notifier).updateEmail('test@example.com');
        expect(container.read(registrationFormStateProvider.notifier).isValid, isFalse);
      });

      test('すべての入力が有効な場合は true を返す', () {
        final notifier = container.read(registrationFormStateProvider.notifier);
        notifier.updateEmail('test@example.com');
        notifier.updatePassword('password123');
        notifier.updatePasswordConfirmation('password123');
        expect(notifier.isValid, isTrue);
      });

      test('メールアドレスが不正な場合は false を返す', () {
        final notifier = container.read(registrationFormStateProvider.notifier);
        notifier.updateEmail('invalid-email');
        notifier.updatePassword('password123');
        notifier.updatePasswordConfirmation('password123');
        expect(notifier.isValid, isFalse);
      });

      test('パスワードが8文字未満の場合は false を返す', () {
        final notifier = container.read(registrationFormStateProvider.notifier);
        notifier.updateEmail('test@example.com');
        notifier.updatePassword('short');
        notifier.updatePasswordConfirmation('short');
        expect(notifier.isValid, isFalse);
      });

      test('パスワードが一致しない場合は false を返す', () {
        final notifier = container.read(registrationFormStateProvider.notifier);
        notifier.updateEmail('test@example.com');
        notifier.updatePassword('password123');
        notifier.updatePasswordConfirmation('password456');
        expect(notifier.isValid, isFalse);
      });
    });
  });
}
