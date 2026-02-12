import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/follow/domain/user_summary.dart';

void main() {
  group('UserSummary', () {
    test('すべてのフィールドを持つインスタンスを作成できる', () {
      final summary = UserSummary(
        id: 1,
        name: 'テストユーザー',
        avatarUrl: 'https://example.com/avatar.jpg',
        handle: 'testuser',
      );

      expect(summary.id, equals(1));
      expect(summary.name, equals('テストユーザー'));
      expect(summary.avatarUrl, equals('https://example.com/avatar.jpg'));
      expect(summary.handle, equals('testuser'));
    });

    test('nullable フィールドは null を許容する', () {
      final summary = UserSummary(
        id: 1,
        name: null,
        avatarUrl: null,
        handle: null,
      );

      expect(summary.name, isNull);
      expect(summary.avatarUrl, isNull);
      expect(summary.handle, isNull);
    });

    test('copyWith で一部のフィールドを変更できる', () {
      final original = UserSummary(
        id: 1,
        name: '旧名前',
        avatarUrl: null,
        handle: 'olduser',
      );

      final updated = original.copyWith(
        name: '新名前',
        avatarUrl: 'https://example.com/new-avatar.jpg',
      );

      expect(updated.id, equals(original.id));
      expect(updated.name, equals('新名前'));
      expect(updated.avatarUrl, equals('https://example.com/new-avatar.jpg'));
      expect(updated.handle, equals(original.handle));
    });

    test('同じ値を持つインスタンスは等価である', () {
      final summary1 = UserSummary(
        id: 1,
        name: 'Test User',
        avatarUrl: null,
        handle: 'testuser',
      );
      final summary2 = UserSummary(
        id: 1,
        name: 'Test User',
        avatarUrl: null,
        handle: 'testuser',
      );

      expect(summary1, equals(summary2));
      expect(summary1.hashCode, equals(summary2.hashCode));
    });

    test('異なる値を持つインスタンスは等価でない', () {
      final summary1 = UserSummary(
        id: 1,
        name: 'User A',
        avatarUrl: null,
        handle: 'usera',
      );
      final summary2 = UserSummary(
        id: 2,
        name: 'User B',
        avatarUrl: null,
        handle: 'userb',
      );

      expect(summary1, isNot(equals(summary2)));
    });
  });
}
