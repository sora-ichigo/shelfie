import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/account/domain/password_validators.dart';

void main() {
  group('PasswordValidators', () {
    group('validateNewPassword', () {
      test('8文字以上で英字と数字を含む場合、null を返す', () {
        expect(PasswordValidators.validateNewPassword('password1'), isNull);
        expect(PasswordValidators.validateNewPassword('abc12345'), isNull);
        expect(PasswordValidators.validateNewPassword('Pass1234'), isNull);
        expect(PasswordValidators.validateNewPassword('1234abcd'), isNull);
      });

      test('空文字の場合、null を返す（未入力は許容）', () {
        expect(PasswordValidators.validateNewPassword(''), isNull);
      });

      test('8文字未満の場合、エラーメッセージを返す', () {
        expect(
          PasswordValidators.validateNewPassword('pass1'),
          equals('パスワードは8文字以上で入力してください'),
        );
        expect(
          PasswordValidators.validateNewPassword('abc123'),
          equals('パスワードは8文字以上で入力してください'),
        );
        expect(
          PasswordValidators.validateNewPassword('Pa1'),
          equals('パスワードは8文字以上で入力してください'),
        );
      });

      test('英字を含まない場合、エラーメッセージを返す', () {
        expect(
          PasswordValidators.validateNewPassword('12345678'),
          equals('パスワードには英字を含めてください'),
        );
        expect(
          PasswordValidators.validateNewPassword('123456789'),
          equals('パスワードには英字を含めてください'),
        );
      });

      test('数字を含まない場合、エラーメッセージを返す', () {
        expect(
          PasswordValidators.validateNewPassword('abcdefgh'),
          equals('パスワードには数字を含めてください'),
        );
        expect(
          PasswordValidators.validateNewPassword('Password'),
          equals('パスワードには数字を含めてください'),
        );
      });

      test('複数の条件を満たさない場合、最初の条件のエラーを返す', () {
        expect(
          PasswordValidators.validateNewPassword('short'),
          equals('パスワードは8文字以上で入力してください'),
        );
      });
    });

    group('validateConfirmPassword', () {
      test('パスワードと一致する場合、null を返す', () {
        expect(
          PasswordValidators.validateConfirmPassword('password1', 'password1'),
          isNull,
        );
      });

      test('確認用パスワードが空の場合、null を返す（未入力は許容）', () {
        expect(
          PasswordValidators.validateConfirmPassword('password1', ''),
          isNull,
        );
      });

      test('パスワードと一致しない場合、エラーメッセージを返す', () {
        expect(
          PasswordValidators.validateConfirmPassword('password1', 'password2'),
          equals('パスワードが一致しません'),
        );
      });
    });

    group('validateCurrentPassword', () {
      test('入力がある場合、null を返す', () {
        expect(PasswordValidators.validateCurrentPassword('anypassword'), isNull);
        expect(PasswordValidators.validateCurrentPassword('short'), isNull);
      });

      test('空文字の場合、null を返す（未入力は許容）', () {
        expect(PasswordValidators.validateCurrentPassword(''), isNull);
      });
    });

    group('minLength', () {
      test('8 を返す', () {
        expect(PasswordValidators.minLength, equals(8));
      });
    });
  });
}
