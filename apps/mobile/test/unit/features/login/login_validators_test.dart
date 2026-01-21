import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/login/domain/login_validators.dart';

void main() {
  group('LoginValidators', () {
    group('validateEmail', () {
      test('有効なメールアドレスの場合、null を返す', () {
        expect(LoginValidators.validateEmail('test@example.com'), isNull);
        expect(LoginValidators.validateEmail('user.name@domain.co.jp'), isNull);
        expect(LoginValidators.validateEmail('user+tag@example.org'), isNull);
      });

      test('空文字の場合、null を返す（未入力は許容）', () {
        expect(LoginValidators.validateEmail(''), isNull);
      });

      test('@ がない場合、エラーメッセージを返す', () {
        expect(
          LoginValidators.validateEmail('invalid-email'),
          equals('有効なメールアドレスを入力してください'),
        );
      });

      test('@ の前が空の場合、エラーメッセージを返す', () {
        expect(
          LoginValidators.validateEmail('@example.com'),
          equals('有効なメールアドレスを入力してください'),
        );
      });

      test('ドメインが不正な場合、エラーメッセージを返す', () {
        expect(
          LoginValidators.validateEmail('test@'),
          equals('有効なメールアドレスを入力してください'),
        );
        expect(
          LoginValidators.validateEmail('test@example'),
          equals('有効なメールアドレスを入力してください'),
        );
      });
    });
  });
}
