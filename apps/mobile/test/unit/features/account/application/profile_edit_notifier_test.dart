import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/features/account/application/profile_edit_notifier.dart';
import 'package:shelfie/features/account/application/profile_form_state.dart';
import 'package:shelfie/features/account/data/account_repository.dart';
import 'package:shelfie/features/account/data/avatar_upload_service.dart';
import 'package:shelfie/features/account/domain/user_profile.dart';

class MockAccountRepository extends Mock implements AccountRepository {}

class MockAvatarUploadService extends Mock implements AvatarUploadService {}

class MockXFile extends Mock implements XFile {}

void main() {
  late MockAccountRepository mockRepository;

  setUp(() {
    mockRepository = MockAccountRepository();
  });

  setUpAll(() {
    registerFallbackValue(MockXFile());
  });

  UserProfile createTestProfile() {
    return UserProfile(
      id: 1,
      email: 'test@example.com',
      name: 'Test User',
      avatarUrl: 'https://example.com/avatar.png',
      handle: '@testuser',
      bookCount: 10,
      bio: null,
      instagramHandle: null,
      readingStartYear: 2020,
      readingStartMonth: 1,
      createdAt: DateTime(2020, 1, 1),
    );
  }

  group('ProfileEditState', () {
    test('initial 状態を生成できる', () {
      const state = ProfileEditState.initial();
      expect(state, isA<ProfileEditStateInitial>());
    });

    test('loading 状態を生成できる', () {
      const state = ProfileEditState.loading();
      expect(state, isA<ProfileEditStateLoading>());
    });

    test('success 状態を生成できる', () {
      final profile = createTestProfile();
      final state = ProfileEditState.success(profile: profile);
      expect(state, isA<ProfileEditStateSuccess>());
    });

    test('error 状態を生成できる', () {
      const state = ProfileEditState.error(message: 'エラーが発生しました');
      expect(state, isA<ProfileEditStateError>());
    });

    test('error 状態にフィールド情報を含められる', () {
      const state = ProfileEditState.error(
        message: 'バリデーションエラー',
        field: 'email',
      );
      expect(state, isA<ProfileEditStateError>());
      expect((state as ProfileEditStateError).field, equals('email'));
    });
  });

  group('ProfileEditNotifier', () {
    test('初期状態は ProfileEditState.initial()', () {
      final container = ProviderContainer(
        overrides: [
          accountRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );
      addTearDown(container.dispose);

      final state = container.read(profileEditNotifierProvider);
      expect(state, isA<ProfileEditStateInitial>());
    });

    group('save', () {
      test('名前のみ変更で保存成功', () async {
        final profile = createTestProfile();
        final updatedProfile = profile.copyWith(name: 'New Name');

        when(() => mockRepository.updateProfile(name: 'New Name')).thenAnswer(
          (_) async => right(updatedProfile),
        );

        final container = ProviderContainer(
          overrides: [
            accountRepositoryProvider.overrideWithValue(mockRepository),
          ],
        );
        addTearDown(container.dispose);

        final formNotifier = container.read(profileFormStateProvider.notifier);
        formNotifier.initialize(profile);
        formNotifier.updateName('New Name');

        await container.read(profileEditNotifierProvider.notifier).save();

        final state = container.read(profileEditNotifierProvider);
        expect(state, isA<ProfileEditStateSuccess>());
        expect((state as ProfileEditStateSuccess).profile.name, equals('New Name'));
      });

      test('保存中は loading 状態になる', () async {
        final profile = createTestProfile();
        final updatedProfile = profile.copyWith(name: 'New Name');

        when(() => mockRepository.updateProfile(name: 'New Name')).thenAnswer(
          (_) async {
            await Future<void>.delayed(const Duration(milliseconds: 100));
            return right(updatedProfile);
          },
        );

        final container = ProviderContainer(
          overrides: [
            accountRepositoryProvider.overrideWithValue(mockRepository),
          ],
        );
        addTearDown(container.dispose);

        final formNotifier = container.read(profileFormStateProvider.notifier);
        formNotifier.initialize(profile);
        formNotifier.updateName('New Name');

        final future = container.read(profileEditNotifierProvider.notifier).save();

        final loadingState = container.read(profileEditNotifierProvider);
        expect(loadingState, isA<ProfileEditStateLoading>());

        await future;
      });

      test('保存失敗時は error 状態になる', () async {
        final profile = createTestProfile();
        const failure = ServerFailure(
          message: 'Server error',
          code: 'SERVER_ERROR',
        );

        when(() => mockRepository.updateProfile(name: 'New Name')).thenAnswer(
          (_) async => left(failure),
        );

        final container = ProviderContainer(
          overrides: [
            accountRepositoryProvider.overrideWithValue(mockRepository),
          ],
        );
        addTearDown(container.dispose);

        final formNotifier = container.read(profileFormStateProvider.notifier);
        formNotifier.initialize(profile);
        formNotifier.updateName('New Name');

        await container.read(profileEditNotifierProvider.notifier).save();

        final state = container.read(profileEditNotifierProvider);
        expect(state, isA<ProfileEditStateError>());
        expect((state as ProfileEditStateError).message, isNotEmpty);
      });

      test('バリデーションエラー時は error 状態でフィールド情報を含む', () async {
        final profile = createTestProfile();
        const failure = ValidationFailure(
          message: '氏名を入力してください',
          fieldErrors: {'name': '氏名を入力してください'},
        );

        when(() => mockRepository.updateProfile(name: '')).thenAnswer(
          (_) async => left(failure),
        );

        final container = ProviderContainer(
          overrides: [
            accountRepositoryProvider.overrideWithValue(mockRepository),
          ],
        );
        addTearDown(container.dispose);

        final formNotifier = container.read(profileFormStateProvider.notifier);
        formNotifier.initialize(profile);
        formNotifier.updateName('');

        await container.read(profileEditNotifierProvider.notifier).save();

        final state = container.read(profileEditNotifierProvider);
        expect(state, isA<ProfileEditStateError>());
        final errorState = state as ProfileEditStateError;
        expect(errorState.field, equals('name'));
      });
    });

    group('setAvatarImage', () {
      test('アバター画像を設定できる', () {
        final container = ProviderContainer(
          overrides: [
            accountRepositoryProvider.overrideWithValue(mockRepository),
          ],
        );
        addTearDown(container.dispose);

        final xFile = XFile('path/to/image.jpg');
        container.read(profileEditNotifierProvider.notifier).setAvatarImage(xFile);

        final formState = container.read(profileFormStateProvider);
        expect(formState.pendingAvatarImage, equals(xFile));
      });
    });

    group('reset', () {
      test('reset で initial 状態に戻る', () async {
        final profile = createTestProfile();
        final updatedProfile = profile.copyWith(name: 'New Name');

        when(() => mockRepository.updateProfile(name: 'New Name')).thenAnswer(
          (_) async => right(updatedProfile),
        );

        final container = ProviderContainer(
          overrides: [
            accountRepositoryProvider.overrideWithValue(mockRepository),
          ],
        );
        addTearDown(container.dispose);

        final formNotifier = container.read(profileFormStateProvider.notifier);
        formNotifier.initialize(profile);
        formNotifier.updateName('New Name');

        await container.read(profileEditNotifierProvider.notifier).save();

        expect(
          container.read(profileEditNotifierProvider),
          isA<ProfileEditStateSuccess>(),
        );

        container.read(profileEditNotifierProvider.notifier).reset();

        expect(
          container.read(profileEditNotifierProvider),
          isA<ProfileEditStateInitial>(),
        );
      });
    });

    group('saveWithAvatar', () {
      late MockAvatarUploadService mockUploadService;

      setUp(() {
        mockUploadService = MockAvatarUploadService();
      });

      test('アバター画像あり＋名前変更で保存成功', () async {
        final profile = createTestProfile();
        final updatedProfile = profile.copyWith(
          name: 'New Name',
          avatarUrl: 'https://ik.imagekit.io/test/new-avatar.jpg',
        );

        final mockFile = MockXFile();
        when(() => mockFile.path).thenReturn('/path/to/image.jpg');
        when(() => mockFile.mimeType).thenReturn('image/jpeg');
        when(() => mockFile.length()).thenAnswer((_) async => 1024);
        when(() => mockFile.readAsBytes()).thenAnswer(
          (_) async => Uint8List.fromList([1, 2, 3]),
        );

        when(
          () => mockUploadService.uploadAndUpdateProfile(
            file: any(named: 'file'),
            name: any(named: 'name'),
            onProgress: any(named: 'onProgress'),
          ),
        ).thenAnswer((_) async => right(updatedProfile));

        final container = ProviderContainer(
          overrides: [
            accountRepositoryProvider.overrideWithValue(mockRepository),
            avatarUploadServiceProvider.overrideWithValue(mockUploadService),
          ],
        );
        addTearDown(container.dispose);

        final formNotifier = container.read(profileFormStateProvider.notifier);
        formNotifier.initialize(profile);
        formNotifier.updateName('New Name');
        formNotifier.setAvatarImage(mockFile);

        await container.read(profileEditNotifierProvider.notifier).save();

        final state = container.read(profileEditNotifierProvider);
        expect(state, isA<ProfileEditStateSuccess>());
        expect(
          (state as ProfileEditStateSuccess).profile.avatarUrl,
          equals('https://ik.imagekit.io/test/new-avatar.jpg'),
        );
      });

      test('アバターアップロード失敗時は error 状態になる', () async {
        final profile = createTestProfile();

        final mockFile = MockXFile();
        when(() => mockFile.path).thenReturn('/path/to/image.jpg');
        when(() => mockFile.mimeType).thenReturn('image/jpeg');
        when(() => mockFile.length()).thenAnswer((_) async => 1024);

        when(
          () => mockUploadService.uploadAndUpdateProfile(
            file: any(named: 'file'),
            name: any(named: 'name'),
            onProgress: any(named: 'onProgress'),
          ),
        ).thenAnswer(
          (_) async => left(
            const ServerFailure(message: 'Upload failed', code: 'UPLOAD_ERROR'),
          ),
        );

        final container = ProviderContainer(
          overrides: [
            accountRepositoryProvider.overrideWithValue(mockRepository),
            avatarUploadServiceProvider.overrideWithValue(mockUploadService),
          ],
        );
        addTearDown(container.dispose);

        final formNotifier = container.read(profileFormStateProvider.notifier);
        formNotifier.initialize(profile);
        formNotifier.updateName('New Name');
        formNotifier.setAvatarImage(mockFile);

        await container.read(profileEditNotifierProvider.notifier).save();

        final state = container.read(profileEditNotifierProvider);
        expect(state, isA<ProfileEditStateError>());
      });
    });
  });
}
