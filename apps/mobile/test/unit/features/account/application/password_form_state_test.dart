import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/account/application/password_form_state.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
  });

  group('PasswordFormState', () {
    group('初期状態', () {
      test('すべてのフィールドが空文字で初期化される', () {
        final state = container.read(passwordFormStateProvider);
        expect(state.currentPassword, equals(''));
        expect(state.newPassword, equals(''));
        expect(state.confirmPassword, equals(''));
      });

      test('すべてのパスワードフィールドが非表示状態で初期化される', () {
        final state = container.read(passwordFormStateProvider);
        expect(state.isCurrentPasswordObscured, isTrue);
        expect(state.isNewPasswordObscured, isTrue);
        expect(state.isConfirmPasswordObscured, isTrue);
      });

      test('エラーメッセージが null で初期化される', () {
        final state = container.read(passwordFormStateProvider);
        expect(state.currentPasswordError, isNull);
        expect(state.newPasswordError, isNull);
        expect(state.confirmPasswordError, isNull);
      });
    });

    group('setCurrentPassword', () {
      test('現在のパスワードを設定できる', () {
        container
            .read(passwordFormStateProvider.notifier)
            .setCurrentPassword('oldPassword123');
        final state = container.read(passwordFormStateProvider);
        expect(state.currentPassword, equals('oldPassword123'));
      });
    });

    group('setNewPassword', () {
      test('新しいパスワードを設定できる', () {
        container
            .read(passwordFormStateProvider.notifier)
            .setNewPassword('newPassword123');
        final state = container.read(passwordFormStateProvider);
        expect(state.newPassword, equals('newPassword123'));
      });

      test('8文字未満の場合、エラーメッセージが設定される', () {
        container
            .read(passwordFormStateProvider.notifier)
            .setNewPassword('short');
        final state = container.read(passwordFormStateProvider);
        expect(state.newPasswordError, isNotNull);
        expect(state.newPasswordError, contains('8文字以上'));
      });

      test('英字を含まない場合、エラーメッセージが設定される', () {
        container
            .read(passwordFormStateProvider.notifier)
            .setNewPassword('12345678');
        final state = container.read(passwordFormStateProvider);
        expect(state.newPasswordError, isNotNull);
        expect(state.newPasswordError, contains('英字'));
      });

      test('数字を含まない場合、エラーメッセージが設定される', () {
        container
            .read(passwordFormStateProvider.notifier)
            .setNewPassword('abcdefgh');
        final state = container.read(passwordFormStateProvider);
        expect(state.newPasswordError, isNotNull);
        expect(state.newPasswordError, contains('数字'));
      });

      test('有効なパスワードの場合、エラーメッセージが null になる', () {
        container
            .read(passwordFormStateProvider.notifier)
            .setNewPassword('password123');
        final state = container.read(passwordFormStateProvider);
        expect(state.newPasswordError, isNull);
      });
    });

    group('setConfirmPassword', () {
      test('確認用パスワードを設定できる', () {
        container
            .read(passwordFormStateProvider.notifier)
            .setConfirmPassword('password123');
        final state = container.read(passwordFormStateProvider);
        expect(state.confirmPassword, equals('password123'));
      });

      test('新しいパスワードと一致しない場合、エラーメッセージが設定される', () {
        container
            .read(passwordFormStateProvider.notifier)
            .setNewPassword('password123');
        container
            .read(passwordFormStateProvider.notifier)
            .setConfirmPassword('different123');
        final state = container.read(passwordFormStateProvider);
        expect(state.confirmPasswordError, isNotNull);
        expect(state.confirmPasswordError, contains('一致しません'));
      });

      test('新しいパスワードと一致する場合、エラーメッセージが null になる', () {
        container
            .read(passwordFormStateProvider.notifier)
            .setNewPassword('password123');
        container
            .read(passwordFormStateProvider.notifier)
            .setConfirmPassword('password123');
        final state = container.read(passwordFormStateProvider);
        expect(state.confirmPasswordError, isNull);
      });
    });

    group('toggleCurrentPasswordVisibility', () {
      test('表示/非表示を切り替えられる', () {
        expect(
          container.read(passwordFormStateProvider).isCurrentPasswordObscured,
          isTrue,
        );
        container
            .read(passwordFormStateProvider.notifier)
            .toggleCurrentPasswordVisibility();
        expect(
          container.read(passwordFormStateProvider).isCurrentPasswordObscured,
          isFalse,
        );
        container
            .read(passwordFormStateProvider.notifier)
            .toggleCurrentPasswordVisibility();
        expect(
          container.read(passwordFormStateProvider).isCurrentPasswordObscured,
          isTrue,
        );
      });
    });

    group('toggleNewPasswordVisibility', () {
      test('表示/非表示を切り替えられる', () {
        expect(
          container.read(passwordFormStateProvider).isNewPasswordObscured,
          isTrue,
        );
        container
            .read(passwordFormStateProvider.notifier)
            .toggleNewPasswordVisibility();
        expect(
          container.read(passwordFormStateProvider).isNewPasswordObscured,
          isFalse,
        );
      });
    });

    group('toggleConfirmPasswordVisibility', () {
      test('表示/非表示を切り替えられる', () {
        expect(
          container.read(passwordFormStateProvider).isConfirmPasswordObscured,
          isTrue,
        );
        container
            .read(passwordFormStateProvider.notifier)
            .toggleConfirmPasswordVisibility();
        expect(
          container.read(passwordFormStateProvider).isConfirmPasswordObscured,
          isFalse,
        );
      });
    });

    group('isValid', () {
      test('すべてのフィールドが空の場合、false を返す', () {
        final isValid =
            container.read(passwordFormStateProvider.notifier).isValid;
        expect(isValid, isFalse);
      });

      test('すべてのフィールドが有効で一致している場合、true を返す', () {
        final notifier = container.read(passwordFormStateProvider.notifier);
        notifier.setCurrentPassword('oldPassword123');
        notifier.setNewPassword('newPassword123');
        notifier.setConfirmPassword('newPassword123');
        expect(notifier.isValid, isTrue);
      });

      test('新しいパスワードにエラーがある場合、false を返す', () {
        final notifier = container.read(passwordFormStateProvider.notifier);
        notifier.setCurrentPassword('oldPassword123');
        notifier.setNewPassword('short');
        notifier.setConfirmPassword('short');
        expect(notifier.isValid, isFalse);
      });

      test('確認用パスワードが一致しない場合、false を返す', () {
        final notifier = container.read(passwordFormStateProvider.notifier);
        notifier.setCurrentPassword('oldPassword123');
        notifier.setNewPassword('newPassword123');
        notifier.setConfirmPassword('different123');
        expect(notifier.isValid, isFalse);
      });
    });

    group('reset', () {
      test('すべてのフィールドを初期状態にリセットする', () {
        final notifier = container.read(passwordFormStateProvider.notifier);
        notifier.setCurrentPassword('oldPassword123');
        notifier.setNewPassword('newPassword123');
        notifier.setConfirmPassword('newPassword123');
        notifier.toggleCurrentPasswordVisibility();

        notifier.reset();

        final state = container.read(passwordFormStateProvider);
        expect(state.currentPassword, equals(''));
        expect(state.newPassword, equals(''));
        expect(state.confirmPassword, equals(''));
        expect(state.isCurrentPasswordObscured, isTrue);
        expect(state.isNewPasswordObscured, isTrue);
        expect(state.isConfirmPasswordObscured, isTrue);
      });
    });
  });
}
