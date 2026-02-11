import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/account/domain/user_profile.dart';

void main() {
  group('UserProfile', () {
    test('すべてのフィールドを持つインスタンスを作成できる', () {
      final createdAt = DateTime(2024, 1, 15, 10, 30);
      final profile = UserProfile(
        id: 1,
        email: 'test@example.com',
        name: 'テストユーザー',
        avatarUrl: 'https://example.com/avatar.jpg',
        username: 'testuser',
        bookCount: 42,
        bio: null,
        instagramHandle: null,
        readingStartYear: 2020,
        readingStartMonth: 1,
        createdAt: createdAt,
      );

      expect(profile.id, equals(1));
      expect(profile.email, equals('test@example.com'));
      expect(profile.name, equals('テストユーザー'));
      expect(profile.avatarUrl, equals('https://example.com/avatar.jpg'));
      expect(profile.username, equals('testuser'));
      expect(profile.bookCount, equals(42));
      expect(profile.readingStartYear, equals(2020));
      expect(profile.createdAt, equals(createdAt));
    });

    test('nullable フィールドは null を許容する', () {
      final profile = UserProfile(
        id: 1,
        email: 'test@example.com',
        name: null,
        avatarUrl: null,
        username: null,
        bookCount: 0,
        bio: null,
        instagramHandle: null,
        readingStartYear: null,
        readingStartMonth: null,
        createdAt: DateTime(2024, 1, 1),
      );

      expect(profile.name, isNull);
      expect(profile.avatarUrl, isNull);
      expect(profile.username, isNull);
      expect(profile.readingStartYear, isNull);
    });

    test('copyWith で一部のフィールドを変更できる', () {
      final original = UserProfile(
        id: 1,
        email: 'test@example.com',
        name: '旧名前',
        avatarUrl: null,
        username: 'olduser',
        bookCount: 10,
        bio: null,
        instagramHandle: null,
        readingStartYear: 2020,
        readingStartMonth: 1,
        createdAt: DateTime(2024, 1, 1),
      );

      final updated = original.copyWith(
        name: '新名前',
        avatarUrl: 'https://example.com/new-avatar.jpg',
      );

      expect(updated.id, equals(original.id));
      expect(updated.email, equals(original.email));
      expect(updated.name, equals('新名前'));
      expect(updated.avatarUrl, equals('https://example.com/new-avatar.jpg'));
      expect(updated.username, equals(original.username));
      expect(updated.bookCount, equals(original.bookCount));
    });

    test('同じ値を持つインスタンスは等価である', () {
      final createdAt = DateTime(2024, 1, 1);
      final profile1 = UserProfile(
        id: 1,
        email: 'test@example.com',
        name: 'Test User',
        avatarUrl: null,
        username: 'testuser',
        bookCount: 5,
        bio: null,
        instagramHandle: null,
        readingStartYear: 2021,
        readingStartMonth: 1,
        createdAt: createdAt,
      );
      final profile2 = UserProfile(
        id: 1,
        email: 'test@example.com',
        name: 'Test User',
        avatarUrl: null,
        username: 'testuser',
        bookCount: 5,
        bio: null,
        instagramHandle: null,
        readingStartYear: 2021,
        readingStartMonth: 1,
        createdAt: createdAt,
      );

      expect(profile1, equals(profile2));
      expect(profile1.hashCode, equals(profile2.hashCode));
    });

    test('異なる値を持つインスタンスは等価でない', () {
      final createdAt = DateTime(2024, 1, 1);
      final profile1 = UserProfile(
        id: 1,
        email: 'test@example.com',
        name: 'User A',
        avatarUrl: null,
        username: 'usera',
        bookCount: 5,
        bio: null,
        instagramHandle: null,
        readingStartYear: 2021,
        readingStartMonth: 1,
        createdAt: createdAt,
      );
      final profile2 = UserProfile(
        id: 1,
        email: 'test@example.com',
        name: 'User B',
        avatarUrl: null,
        username: 'userb',
        bookCount: 5,
        bio: null,
        instagramHandle: null,
        readingStartYear: 2021,
        readingStartMonth: 1,
        createdAt: createdAt,
      );

      expect(profile1, isNot(equals(profile2)));
    });
  });
}
