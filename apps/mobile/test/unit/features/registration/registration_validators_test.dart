import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/registration/domain/registration_validators.dart';

void main() {
  group('RegistrationValidators', () {
    group('validateEmail', () {
      test('有効なメールアドレスの場合、null を返す', () {
        expect(RegistrationValidators.validateEmail('test@example.com'), isNull);
        expect(RegistrationValidators.validateEmail('user.name@domain.co.jp'), isNull);
        expect(RegistrationValidators.validateEmail('user+tag@example.org'), isNull);
      });

      test('空文字の場合、null を返す（未入力は許容）', () {
        expect(RegistrationValidators.validateEmail(''), isNull);
      });

      test('@ がない場合、エラーメッセージを返す', () {
        expect(
          RegistrationValidators.validateEmail('invalid-email'),
          equals('有効なメールアドレスを入力してください'),
        );
      });

      test('@ の前が空の場合、エラーメッセージを返す', () {
        expect(
          RegistrationValidators.validateEmail('@example.com'),
          equals('有効なメールアドレスを入力してください'),
        );
      });

      test('ドメインが不正な場合、エラーメッセージを返す', () {
        expect(
          RegistrationValidators.validateEmail('test@'),
          equals('有効なメールアドレスを入力してください'),
        );
        expect(
          RegistrationValidators.validateEmail('test@example'),
          equals('有効なメールアドレスを入力してください'),
        );
      });
    });

    group('validatePassword', () {
      test('8文字以上の場合、null を返す', () {
        expect(RegistrationValidators.validatePassword('12345678'), isNull);
        expect(RegistrationValidators.validatePassword('password123'), isNull);
        expect(RegistrationValidators.validatePassword('verylongpassword'), isNull);
      });

      test('空文字の場合、null を返す（未入力は許容）', () {
        expect(RegistrationValidators.validatePassword(''), isNull);
      });

      test('8文字未満の場合、エラーメッセージを返す', () {
        expect(
          RegistrationValidators.validatePassword('1234567'),
          equals('パスワードは8文字以上で入力してください'),
        );
        expect(
          RegistrationValidators.validatePassword('short'),
          equals('パスワードは8文字以上で入力してください'),
        );
      });
    });

    group('validatePasswordConfirmation', () {
      test('パスワードと一致する場合、null を返す', () {
        expect(
          RegistrationValidators.validatePasswordConfirmation('password123', 'password123'),
          isNull,
        );
      });

      test('確認用パスワードが空の場合、null を返す（未入力は許容）', () {
        expect(
          RegistrationValidators.validatePasswordConfirmation('password123', ''),
          isNull,
        );
      });

      test('パスワードと一致しない場合、エラーメッセージを返す', () {
        expect(
          RegistrationValidators.validatePasswordConfirmation('password123', 'password456'),
          equals('パスワードが一致しません'),
        );
      });
    });
  });
}
