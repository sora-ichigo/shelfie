import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/core/widgets/user_avatar.dart';
import 'package:shelfie/features/account/domain/user_profile.dart';
import 'package:shelfie/features/profile/presentation/profile_header.dart';

void main() {
  UserProfile createTestProfile({
    String? name = 'Test User',
    String? avatarUrl,
    String? username = '@testuser',
  }) {
    return UserProfile(
      id: 1,
      email: 'test@example.com',
      name: name,
      avatarUrl: avatarUrl,
      username: username,
      bookCount: 15,
      readingCount: 3,
      backlogCount: 5,
      completedCount: 6,
      interestedCount: 1,
      readingStartYear: 2020,
      readingStartMonth: 1,
      createdAt: DateTime(2020, 1, 1),
    );
  }

  group('ProfileHeader', () {
    testWidgets('表示名が表示される', (tester) async {
      final profile = createTestProfile(name: 'Test User');

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ProfileHeader(profile: profile),
          ),
        ),
      );

      expect(find.text('Test User'), findsOneWidget);
    });

    testWidgets('@username が表示される', (tester) async {
      final profile = createTestProfile(username: '@testuser');

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ProfileHeader(profile: profile),
          ),
        ),
      );

      expect(find.text('@testuser'), findsOneWidget);
    });

    testWidgets('UserAvatar が表示される', (tester) async {
      final profile = createTestProfile();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ProfileHeader(profile: profile),
          ),
        ),
      );

      expect(find.byType(UserAvatar), findsOneWidget);
    });

    testWidgets('名前が null の場合はデフォルト表示', (tester) async {
      final profile = createTestProfile(name: null, username: null);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ProfileHeader(profile: profile),
          ),
        ),
      );

      expect(find.text('未設定'), findsOneWidget);
    });

    testWidgets('アバター未設定時にデフォルトアイコンが表示される', (tester) async {
      final profile = createTestProfile(avatarUrl: null);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ProfileHeader(profile: profile),
          ),
        ),
      );

      expect(find.byIcon(Icons.person), findsOneWidget);
    });
  });
}
