import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/account/application/account_notifier.dart';
import 'package:shelfie/features/account/application/profile_edit_notifier.dart';
import 'package:shelfie/features/account/application/profile_form_state.dart';
import 'package:shelfie/features/account/data/image_picker_service.dart';
import 'package:shelfie/features/account/domain/user_profile.dart';
import 'package:shelfie/features/account/presentation/profile_edit_screen.dart';

class MockImagePickerService extends Mock implements ImagePickerService {}

class FakeXFile extends Fake implements XFile {}

void main() {
  late MockImagePickerService mockImagePickerService;

  final testProfile = UserProfile(
    id: 1,
    email: 'test@example.com',
    name: 'Test User',
    avatarUrl: null,
    username: '@testuser',
    bookCount: 42,
    readingStartYear: 2020,
    createdAt: DateTime(2023, 1, 1),
  );

  setUpAll(() {
    registerFallbackValue(testProfile);
    registerFallbackValue(FakeXFile());
  });

  setUp(() {
    mockImagePickerService = MockImagePickerService();
    when(() => mockImagePickerService.pickFromCamera())
        .thenAnswer((_) async => null);
    when(() => mockImagePickerService.pickFromGallery())
        .thenAnswer((_) async => null);
  });

  Widget buildTestProfileEditScreen({
    VoidCallback? onClose,
    VoidCallback? onSaveSuccess,
    ProfileEditState? editState,
  }) {
    return ProviderScope(
      overrides: [
        profileEditNotifierProvider.overrideWith(
          () => _TestProfileEditNotifier(editState),
        ),
        profileFormStateProvider.overrideWith(
          () => _TestProfileFormState(testProfile),
        ),
        accountNotifierProvider.overrideWith(
          () => _TestAccountNotifier(testProfile),
        ),
        imagePickerServiceProvider.overrideWithValue(mockImagePickerService),
      ],
      child: MaterialApp(
        theme: AppTheme.theme,
        home: ProfileEditScreen(
          initialProfile: testProfile,
          onClose: onClose ?? () {},
          onSaveSuccess: onSaveSuccess ?? () {},
        ),
      ),
    );
  }

  group('ProfileEditScreen', () {
    testWidgets('displays header with title and buttons', (tester) async {
      await tester.pumpWidget(buildTestProfileEditScreen());
      await tester.pumpAndSettle();

      expect(find.text('プロフィール編集'), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('displays avatar editor', (tester) async {
      await tester.pumpWidget(buildTestProfileEditScreen());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.byIcon(Icons.edit), findsOneWidget);
    });

    testWidgets('displays form fields with labels', (tester) async {
      await tester.pumpWidget(buildTestProfileEditScreen());
      await tester.pumpAndSettle();

      expect(find.text('氏名'), findsOneWidget);
      expect(find.text('メールアドレス'), findsOneWidget);
      expect(
        find.text('アカウントのメールアドレスは変更できません'),
        findsOneWidget,
      );
    });

    testWidgets('shows image source bottom sheet when avatar tapped',
        (tester) async {
      await tester.pumpWidget(buildTestProfileEditScreen());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();

      expect(find.text('画像を選択'), findsOneWidget);
      expect(find.text('カメラで撮影'), findsOneWidget);
      expect(find.text('ギャラリーから選択'), findsOneWidget);
    });

    testWidgets('calls camera picker when camera option selected',
        (tester) async {
      await tester.pumpWidget(buildTestProfileEditScreen());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();

      await tester.tap(find.text('カメラで撮影'));
      await tester.pumpAndSettle();

      verify(() => mockImagePickerService.pickFromCamera()).called(1);
    });

    testWidgets('calls gallery picker when gallery option selected',
        (tester) async {
      await tester.pumpWidget(buildTestProfileEditScreen());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();

      await tester.tap(find.text('ギャラリーから選択'));
      await tester.pumpAndSettle();

      verify(() => mockImagePickerService.pickFromGallery()).called(1);
    });

    testWidgets('calls onClose when close button tapped', (tester) async {
      var closed = false;

      await tester.pumpWidget(
        buildTestProfileEditScreen(
          onClose: () => closed = true,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(closed, isTrue);
    });

    testWidgets('save button is enabled when form is valid', (tester) async {
      await tester.pumpWidget(buildTestProfileEditScreen());
      await tester.pumpAndSettle();

      final checkButton = find.byIcon(Icons.check);
      expect(checkButton, findsOneWidget);

      final iconButton = tester.widget<IconButton>(
        find.ancestor(
          of: checkButton,
          matching: find.byType(IconButton),
        ),
      );
      expect(iconButton.onPressed, isNotNull);
    });

    testWidgets('save button is disabled when form is invalid', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            profileEditNotifierProvider.overrideWith(
              () => _TestProfileEditNotifier(null),
            ),
            profileFormStateProvider.overrideWith(
              () => _InvalidProfileFormState(),
            ),
            accountNotifierProvider.overrideWith(
              () => _TestAccountNotifier(testProfile),
            ),
            imagePickerServiceProvider.overrideWithValue(mockImagePickerService),
          ],
          child: MaterialApp(
            theme: AppTheme.theme,
            home: ProfileEditScreen(
              initialProfile: testProfile,
              onClose: () {},
              onSaveSuccess: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final checkButton = find.byIcon(Icons.check);
      expect(checkButton, findsOneWidget);

      final iconButton = tester.widget<IconButton>(
        find.ancestor(
          of: checkButton,
          matching: find.byType(IconButton),
        ),
      );
      expect(iconButton.onPressed, isNull);
    });

    testWidgets('shows loading indicator when in loading state', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            profileEditNotifierProvider.overrideWith(
              () => _TestProfileEditNotifier(const ProfileEditState.loading()),
            ),
            profileFormStateProvider.overrideWith(
              () => _TestProfileFormState(testProfile),
            ),
            accountNotifierProvider.overrideWith(
              () => _TestAccountNotifier(testProfile),
            ),
            imagePickerServiceProvider.overrideWithValue(mockImagePickerService),
          ],
          child: MaterialApp(
            theme: AppTheme.theme,
            home: ProfileEditScreen(
              initialProfile: testProfile,
              onClose: () {},
              onSaveSuccess: () {},
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays form with initial values', (tester) async {
      await tester.pumpWidget(buildTestProfileEditScreen());
      await tester.pumpAndSettle();

      expect(find.text('Test User'), findsOneWidget);
      expect(find.text('test@example.com'), findsOneWidget);
    });
  });
}

class _InvalidProfileFormState extends ProfileFormState {
  @override
  ProfileFormData build() {
    return const ProfileFormData(
      name: '',
      email: 'test@example.com',
      originalEmail: 'test@example.com',
    );
  }

  @override
  void initialize(UserProfile profile) {}

  @override
  void updateName(String name) {}

  @override
  void updateEmail(String email) {}

  @override
  void setAvatarImage(XFile? file) {}

  @override
  bool get isValid => false;

  @override
  String? get nameError => '氏名を入力してください';

  @override
  String? get emailError => null;

  @override
  bool get hasEmailChanged => false;
}

class _TestProfileEditNotifier extends ProfileEditNotifier {
  _TestProfileEditNotifier(this._initialState);

  final ProfileEditState? _initialState;

  @override
  ProfileEditState build() {
    return _initialState ?? const ProfileEditState.initial();
  }

  @override
  Future<void> save() async {}

  @override
  void reset() {}

  @override
  void setAvatarImage(XFile? file) {}
}

class _TestProfileFormState extends ProfileFormState {
  _TestProfileFormState(this._profile);

  final UserProfile _profile;

  @override
  ProfileFormData build() {
    return ProfileFormData(
      name: _profile.name ?? '',
      email: _profile.email,
      originalEmail: _profile.email,
    );
  }

  @override
  void initialize(UserProfile profile) {}

  @override
  void updateName(String name) {}

  @override
  void updateEmail(String email) {}

  @override
  void setAvatarImage(XFile? file) {}

  @override
  bool get isValid => true;

  @override
  String? get nameError => null;

  @override
  String? get emailError => null;

  @override
  bool get hasEmailChanged => false;
}

class _TestAccountNotifier extends AccountNotifier {
  _TestAccountNotifier(this._profile);

  final UserProfile _profile;

  @override
  Future<UserProfile> build() async => _profile;

  @override
  Future<void> refresh() async {}
}
