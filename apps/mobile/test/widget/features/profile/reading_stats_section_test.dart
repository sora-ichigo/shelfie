import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/account/domain/user_profile.dart';
import 'package:shelfie/features/profile/presentation/reading_stats_section.dart';

void main() {
  UserProfile createTestProfile({
    int readingCount = 3,
    int backlogCount = 5,
    int completedCount = 6,
    int interestedCount = 1,
  }) {
    return UserProfile(
      id: 1,
      email: 'test@example.com',
      name: 'Test User',
      avatarUrl: null,
      username: '@testuser',
      bookCount: 15,
      readingCount: readingCount,
      backlogCount: backlogCount,
      completedCount: completedCount,
      interestedCount: interestedCount,
      readingStartYear: 2020,
      readingStartMonth: 1,
      createdAt: DateTime(2020, 1, 1),
    );
  }

  group('ReadingStatsSection', () {
    testWidgets('読了冊数が数字とラベルで表示される', (tester) async {
      final profile = createTestProfile(completedCount: 6);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ReadingStatsSection(profile: profile),
          ),
        ),
      );

      expect(find.text('6'), findsOneWidget);
      expect(find.text('読了'), findsOneWidget);
    });

    testWidgets('読書中冊数が数字とラベルで表示される', (tester) async {
      final profile = createTestProfile(readingCount: 3);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ReadingStatsSection(profile: profile),
          ),
        ),
      );

      expect(find.text('3'), findsOneWidget);
      expect(find.text('読書中'), findsOneWidget);
    });

    testWidgets('積読冊数が数字とラベルで表示される', (tester) async {
      final profile = createTestProfile(backlogCount: 5);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ReadingStatsSection(profile: profile),
          ),
        ),
      );

      expect(find.text('5'), findsOneWidget);
      expect(find.text('積読'), findsOneWidget);
    });

    testWidgets('気になる冊数が数字とラベルで表示される', (tester) async {
      final profile = createTestProfile(interestedCount: 1);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ReadingStatsSection(profile: profile),
          ),
        ),
      );

      expect(find.text('1'), findsOneWidget);
      expect(find.text('気になる'), findsOneWidget);
    });

    testWidgets('4つのステータスが横並びで表示される', (tester) async {
      final profile = createTestProfile();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ReadingStatsSection(profile: profile),
          ),
        ),
      );

      expect(find.text('読了'), findsOneWidget);
      expect(find.text('読書中'), findsOneWidget);
      expect(find.text('積読'), findsOneWidget);
      expect(find.text('気になる'), findsOneWidget);
    });

    testWidgets('読書開始情報は表示されない', (tester) async {
      final profile = createTestProfile();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ReadingStatsSection(profile: profile),
          ),
        ),
      );

      expect(find.text('読書開始'), findsNothing);
    });
  });
}
