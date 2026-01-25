import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/account/domain/user_profile.dart';
import 'package:shelfie/features/account/presentation/widgets/profile_card.dart';

void main() {
  UserProfile createTestProfile({
    String? name = 'Test User',
    String? avatarUrl,
    String? username = '@testuser',
    int bookCount = 10,
    int? readingStartYear = 2020,
    int? readingStartMonth = 4,
  }) {
    return UserProfile(
      id: 1,
      email: 'test@example.com',
      name: name,
      avatarUrl: avatarUrl,
      username: username,
      bookCount: bookCount,
      readingStartYear: readingStartYear,
      readingStartMonth: readingStartMonth,
      createdAt: DateTime(2020, 4, 1),
    );
  }

  group('ProfileCard', () {
    testWidgets('氏名が表示される', (tester) async {
      final profile = createTestProfile(name: 'Test User');

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ProfileCard(profile: profile),
          ),
        ),
      );

      expect(find.text('Test User'), findsOneWidget);
    });

    testWidgets('メールアドレスが表示される', (tester) async {
      final profile = createTestProfile();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ProfileCard(profile: profile),
          ),
        ),
      );

      expect(find.text('test@example.com'), findsOneWidget);
    });

    testWidgets('登録冊数が表示される', (tester) async {
      final profile = createTestProfile(bookCount: 42);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ProfileCard(profile: profile),
          ),
        ),
      );

      expect(find.text('42'), findsOneWidget);
      expect(find.text('累計冊数'), findsOneWidget);
    });

    testWidgets('読書開始年月が表示される', (tester) async {
      final profile = createTestProfile(
        readingStartYear: 2020,
        readingStartMonth: 4,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ProfileCard(profile: profile),
          ),
        ),
      );

      expect(find.text('2020/4'), findsOneWidget);
      expect(find.text('読書開始'), findsOneWidget);
    });

    testWidgets('読書開始年月がnullの場合はハイフンが表示される', (tester) async {
      final profile = createTestProfile(
        readingStartYear: null,
        readingStartMonth: null,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ProfileCard(profile: profile),
          ),
        ),
      );

      expect(find.text('-'), findsOneWidget);
      expect(find.text('読書開始'), findsOneWidget);
    });

    testWidgets('アバターが表示される', (tester) async {
      final profile = createTestProfile();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ProfileCard(profile: profile),
          ),
        ),
      );

      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('名前がnullの場合はデフォルト表示', (tester) async {
      final profile = createTestProfile(name: null, username: null);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ProfileCard(profile: profile),
          ),
        ),
      );

      expect(find.text('未設定'), findsOneWidget);
    });
  });
}
