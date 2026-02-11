import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shelfie/features/account/application/profile_form_state.dart';
import 'package:shelfie/features/account/domain/user_profile.dart';

void main() {
  group('ProfileFormData', () {
    test('デフォルト値が正しく設定される', () {
      const data = ProfileFormData();
      expect(data.name, equals(''));
      expect(data.email, equals(''));
      expect(data.handle, equals(''));
      expect(data.bio, equals(''));
      expect(data.instagramHandle, equals(''));
      expect(data.pendingAvatarImage, isNull);
      expect(data.hasChanges, isFalse);
    });

    test('copyWith で値を更新できる', () {
      const data = ProfileFormData();
      final xFile = XFile('path/to/image.jpg');
      final updated = data.copyWith(
        name: 'Test Name',
        email: 'test@example.com',
        handle: 'testuser',
        bio: '自己紹介',
        instagramHandle: 'test_insta',
        pendingAvatarImage: xFile,
        hasChanges: true,
      );

      expect(updated.name, equals('Test Name'));
      expect(updated.email, equals('test@example.com'));
      expect(updated.handle, equals('testuser'));
      expect(updated.bio, equals('自己紹介'));
      expect(updated.instagramHandle, equals('test_insta'));
      expect(updated.pendingAvatarImage, equals(xFile));
      expect(updated.hasChanges, isTrue);
    });
  });

  group('ProfileFormState', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('初期状態はデフォルト値', () {
      final state = container.read(profileFormStateProvider);
      expect(state.name, equals(''));
      expect(state.email, equals(''));
      expect(state.pendingAvatarImage, isNull);
      expect(state.hasChanges, isFalse);
    });

    group('initialize', () {
      test('UserProfile から初期値を設定できる', () {
        final profile = UserProfile(
          id: 1,
          email: 'user@example.com',
          name: 'Test User',
          avatarUrl: 'https://example.com/avatar.png',
          handle: 'testuser',
          bookCount: 10,
          bio: '自己紹介テキスト',
          instagramHandle: 'test_insta',
          readingStartYear: 2020,
          readingStartMonth: 1,
          createdAt: DateTime(2020, 1, 1),
        );

        container.read(profileFormStateProvider.notifier).initialize(profile);
        final state = container.read(profileFormStateProvider);

        expect(state.name, equals('Test User'));
        expect(state.email, equals('user@example.com'));
        expect(state.handle, equals('testuser'));
        expect(state.bio, equals('自己紹介テキスト'));
        expect(state.instagramHandle, equals('test_insta'));
        expect(state.hasChanges, isFalse);
      });

      test('name が null の場合は空文字列になる', () {
        final profile = UserProfile(
          id: 1,
          email: 'user@example.com',
          name: null,
          avatarUrl: null,
          handle: null,
          bookCount: 0,
          bio: null,
          instagramHandle: null,
          readingStartYear: null,
          readingStartMonth: null,
          createdAt: DateTime(2020, 1, 1),
        );

        container.read(profileFormStateProvider.notifier).initialize(profile);
        final state = container.read(profileFormStateProvider);

        expect(state.name, equals(''));
        expect(state.handle, equals(''));
        expect(state.bio, equals(''));
        expect(state.instagramHandle, equals(''));
      });
    });

    group('updateName', () {
      test('名前を更新できる', () {
        container.read(profileFormStateProvider.notifier).updateName('New Name');
        final state = container.read(profileFormStateProvider);
        expect(state.name, equals('New Name'));
      });

      test('名前を更新すると hasChanges が true になる', () {
        container.read(profileFormStateProvider.notifier).updateName('New Name');
        final state = container.read(profileFormStateProvider);
        expect(state.hasChanges, isTrue);
      });
    });

    group('setAvatarImage', () {
      test('アバター画像を設定できる', () {
        final xFile = XFile('path/to/image.jpg');
        container.read(profileFormStateProvider.notifier).setAvatarImage(xFile);
        final state = container.read(profileFormStateProvider);
        expect(state.pendingAvatarImage, equals(xFile));
      });

      test('アバター画像を設定すると hasChanges が true になる', () {
        final xFile = XFile('path/to/image.jpg');
        container.read(profileFormStateProvider.notifier).setAvatarImage(xFile);
        final state = container.read(profileFormStateProvider);
        expect(state.hasChanges, isTrue);
      });

      test('アバター画像を null にクリアできる', () {
        final xFile = XFile('path/to/image.jpg');
        final notifier = container.read(profileFormStateProvider.notifier);
        notifier.setAvatarImage(xFile);
        notifier.setAvatarImage(null);
        final state = container.read(profileFormStateProvider);
        expect(state.pendingAvatarImage, isNull);
      });
    });

    group('nameError', () {
      test('名前が空の場合はエラーメッセージを返す', () {
        container.read(profileFormStateProvider.notifier).updateName('');
        expect(
          container.read(profileFormStateProvider.notifier).nameError,
          equals('氏名を入力してください'),
        );
      });

      test('空白のみの場合はエラーメッセージを返す', () {
        container.read(profileFormStateProvider.notifier).updateName('   ');
        expect(
          container.read(profileFormStateProvider.notifier).nameError,
          equals('氏名を入力してください'),
        );
      });

      test('名前が有効な場合は null を返す', () {
        container.read(profileFormStateProvider.notifier).updateName('Valid Name');
        expect(
          container.read(profileFormStateProvider.notifier).nameError,
          isNull,
        );
      });
    });

    group('updateHandle', () {
      test('ハンドルを更新できる', () {
        container
            .read(profileFormStateProvider.notifier)
            .updateHandle('newhandle');
        final state = container.read(profileFormStateProvider);
        expect(state.handle, equals('newhandle'));
      });

      test('ハンドルを更新すると hasChanges が true になる', () {
        container
            .read(profileFormStateProvider.notifier)
            .updateHandle('newhandle');
        final state = container.read(profileFormStateProvider);
        expect(state.hasChanges, isTrue);
      });
    });

    group('updateBio', () {
      test('BIOを更新できる', () {
        container
            .read(profileFormStateProvider.notifier)
            .updateBio('新しい自己紹介');
        final state = container.read(profileFormStateProvider);
        expect(state.bio, equals('新しい自己紹介'));
      });

      test('BIOを更新すると hasChanges が true になる', () {
        container
            .read(profileFormStateProvider.notifier)
            .updateBio('新しい自己紹介');
        final state = container.read(profileFormStateProvider);
        expect(state.hasChanges, isTrue);
      });
    });

    group('updateInstagramHandle', () {
      test('Instagramハンドルを更新できる', () {
        container
            .read(profileFormStateProvider.notifier)
            .updateInstagramHandle('new_insta');
        final state = container.read(profileFormStateProvider);
        expect(state.instagramHandle, equals('new_insta'));
      });

      test('Instagramハンドルを更新すると hasChanges が true になる', () {
        container
            .read(profileFormStateProvider.notifier)
            .updateInstagramHandle('new_insta');
        final state = container.read(profileFormStateProvider);
        expect(state.hasChanges, isTrue);
      });
    });

    group('handleError', () {
      test('ハンドルが不正な場合はエラーメッセージを返す', () {
        container
            .read(profileFormStateProvider.notifier)
            .updateHandle('test-user');
        expect(
          container.read(profileFormStateProvider.notifier).handleError,
          equals('ハンドルは英数字とアンダースコアのみ使用できます'),
        );
      });

      test('ハンドルが有効な場合は null を返す', () {
        container
            .read(profileFormStateProvider.notifier)
            .updateHandle('valid_handle');
        expect(
          container.read(profileFormStateProvider.notifier).handleError,
          isNull,
        );
      });
    });

    group('bioError', () {
      test('BIOが500文字超の場合はエラーメッセージを返す', () {
        container
            .read(profileFormStateProvider.notifier)
            .updateBio('あ' * 501);
        expect(
          container.read(profileFormStateProvider.notifier).bioError,
          equals('自己紹介は500文字以内で入力してください'),
        );
      });

      test('BIOが有効な場合は null を返す', () {
        container
            .read(profileFormStateProvider.notifier)
            .updateBio('自己紹介');
        expect(
          container.read(profileFormStateProvider.notifier).bioError,
          isNull,
        );
      });
    });

    group('instagramHandleError', () {
      test('Instagramハンドルが不正な場合はエラーメッセージを返す', () {
        container
            .read(profileFormStateProvider.notifier)
            .updateInstagramHandle('test user');
        expect(
          container.read(profileFormStateProvider.notifier).instagramHandleError,
          equals('Instagramハンドルの形式が正しくありません'),
        );
      });

      test('Instagramハンドルが有効な場合は null を返す', () {
        container
            .read(profileFormStateProvider.notifier)
            .updateInstagramHandle('valid_handle');
        expect(
          container.read(profileFormStateProvider.notifier).instagramHandleError,
          isNull,
        );
      });
    });

    group('isValid', () {
      test('名前が空の場合は false', () {
        final notifier = container.read(profileFormStateProvider.notifier);
        notifier.updateName('');
        expect(notifier.isValid, isFalse);
      });

      test('名前が有効な場合は true', () {
        final notifier = container.read(profileFormStateProvider.notifier);
        notifier.updateName('Valid Name');
        expect(notifier.isValid, isTrue);
      });

      test('ハンドルが不正な場合は false', () {
        final notifier = container.read(profileFormStateProvider.notifier);
        notifier.updateName('Valid Name');
        notifier.updateHandle('test-user');
        expect(notifier.isValid, isFalse);
      });

      test('BIOが長すぎる場合は false', () {
        final notifier = container.read(profileFormStateProvider.notifier);
        notifier.updateName('Valid Name');
        notifier.updateBio('あ' * 501);
        expect(notifier.isValid, isFalse);
      });

      test('Instagramハンドルが不正な場合は false', () {
        final notifier = container.read(profileFormStateProvider.notifier);
        notifier.updateName('Valid Name');
        notifier.updateInstagramHandle('test user');
        expect(notifier.isValid, isFalse);
      });
    });
  });
}
