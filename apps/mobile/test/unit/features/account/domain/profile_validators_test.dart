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

    group('validateHandle', () {
      test('有効なハンドルの場合、null を返す', () {
        expect(ProfileValidators.validateHandle('testuser'), isNull);
        expect(ProfileValidators.validateHandle('test_user'), isNull);
        expect(ProfileValidators.validateHandle('TestUser123'), isNull);
        expect(ProfileValidators.validateHandle('a'), isNull);
      });

      test('空文字の場合、null を返す（任意フィールド）', () {
        expect(ProfileValidators.validateHandle(''), isNull);
      });

      test('30文字を超える場合、エラーメッセージを返す', () {
        final longHandle = 'a' * 31;
        expect(
          ProfileValidators.validateHandle(longHandle),
          equals('ハンドルは30文字以内で入力してください'),
        );
      });

      test('30文字ちょうどの場合、null を返す', () {
        final handle = 'a' * 30;
        expect(ProfileValidators.validateHandle(handle), isNull);
      });

      test('英数字とアンダースコア以外を含む場合、エラーメッセージを返す', () {
        expect(
          ProfileValidators.validateHandle('test-user'),
          equals('ハンドルは英数字とアンダースコアのみ使用できます'),
        );
        expect(
          ProfileValidators.validateHandle('test user'),
          equals('ハンドルは英数字とアンダースコアのみ使用できます'),
        );
        expect(
          ProfileValidators.validateHandle('テスト'),
          equals('ハンドルは英数字とアンダースコアのみ使用できます'),
        );
        expect(
          ProfileValidators.validateHandle('test@user'),
          equals('ハンドルは英数字とアンダースコアのみ使用できます'),
        );
      });
    });

    group('validateBio', () {
      test('有効なBIOの場合、null を返す', () {
        expect(ProfileValidators.validateBio('自己紹介テキスト'), isNull);
        expect(ProfileValidators.validateBio('Hello, World!'), isNull);
      });

      test('空文字の場合、null を返す（任意フィールド）', () {
        expect(ProfileValidators.validateBio(''), isNull);
      });

      test('100文字ちょうどの場合、null を返す', () {
        final bio = 'あ' * 100;
        expect(ProfileValidators.validateBio(bio), isNull);
      });

      test('100文字を超える場合、エラーメッセージを返す', () {
        final longBio = 'あ' * 101;
        expect(
          ProfileValidators.validateBio(longBio),
          equals('自己紹介は100文字以内で入力してください'),
        );
      });
    });

    group('validateInstagramHandle', () {
      test('有効なInstagramハンドルの場合、null を返す', () {
        expect(ProfileValidators.validateInstagramHandle('testuser'), isNull);
        expect(ProfileValidators.validateInstagramHandle('test.user'), isNull);
        expect(ProfileValidators.validateInstagramHandle('test_user'), isNull);
        expect(ProfileValidators.validateInstagramHandle('test123'), isNull);
      });

      test('空文字の場合、null を返す（任意フィールド）', () {
        expect(ProfileValidators.validateInstagramHandle(''), isNull);
      });

      test('30文字を超える場合、エラーメッセージを返す', () {
        final longHandle = 'a' * 31;
        expect(
          ProfileValidators.validateInstagramHandle(longHandle),
          equals('Instagramハンドルは30文字以内で入力してください'),
        );
      });

      test('不正な文字を含む場合、エラーメッセージを返す', () {
        expect(
          ProfileValidators.validateInstagramHandle('test user'),
          equals('Instagramハンドルの形式が正しくありません'),
        );
        expect(
          ProfileValidators.validateInstagramHandle('test@user'),
          equals('Instagramハンドルの形式が正しくありません'),
        );
      });
    });
  });
}
