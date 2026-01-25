import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/account/domain/profile_validators.dart';

void main() {
  group('ProfileValidators', () {
    group('validateName', () {
      test('有効な名前の場合、null を返す', () {
        expect(ProfileValidators.validateName('山田太郎'), isNull);
        expect(ProfileValidators.validateName('John Doe'), isNull);
        expect(ProfileValidators.validateName('ユーザー'), isNull);
        expect(ProfileValidators.validateName('A'), isNull);
      });

      test('空文字の場合、エラーメッセージを返す', () {
        expect(
          ProfileValidators.validateName(''),
          equals('氏名を入力してください'),
        );
      });

      test('空白のみの場合、エラーメッセージを返す', () {
        expect(
          ProfileValidators.validateName('   '),
          equals('氏名を入力してください'),
        );
        expect(
          ProfileValidators.validateName('\t\n'),
          equals('氏名を入力してください'),
        );
      });
    });

    group('validateEmail', () {
      test('有効なメールアドレスの場合、null を返す', () {
        expect(ProfileValidators.validateEmail('test@example.com'), isNull);
        expect(
          ProfileValidators.validateEmail('user.name@domain.co.jp'),
          isNull,
        );
        expect(ProfileValidators.validateEmail('user+tag@example.org'), isNull);
      });

      test('空文字の場合、エラーメッセージを返す', () {
        expect(
          ProfileValidators.validateEmail(''),
          equals('メールアドレスを入力してください'),
        );
      });

      test('@ がない場合、エラーメッセージを返す', () {
        expect(
          ProfileValidators.validateEmail('invalid-email'),
          equals('有効なメールアドレスを入力してください'),
        );
      });

      test('@ の前が空の場合、エラーメッセージを返す', () {
        expect(
          ProfileValidators.validateEmail('@example.com'),
          equals('有効なメールアドレスを入力してください'),
        );
      });

      test('ドメインが不正な場合、エラーメッセージを返す', () {
        expect(
          ProfileValidators.validateEmail('test@'),
          equals('有効なメールアドレスを入力してください'),
        );
        expect(
          ProfileValidators.validateEmail('test@example'),
          equals('有効なメールアドレスを入力してください'),
        );
      });

      test('空白のみの場合、エラーメッセージを返す', () {
        expect(
          ProfileValidators.validateEmail('   '),
          equals('メールアドレスを入力してください'),
        );
      });
    });
  });
}
