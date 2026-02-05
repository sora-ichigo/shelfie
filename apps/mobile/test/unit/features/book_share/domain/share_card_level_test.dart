import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/book_share/domain/share_card_level.dart';

void main() {
  group('ShareCardLevel', () {
    test('should have 3 levels', () {
      expect(ShareCardLevel.values, hasLength(3));
    });

    test('should contain simple, profile, review', () {
      expect(ShareCardLevel.values, contains(ShareCardLevel.simple));
      expect(ShareCardLevel.values, contains(ShareCardLevel.profile));
      expect(ShareCardLevel.values, contains(ShareCardLevel.review));
    });

    group('displayName', () {
      test('simple should return "シンプル"', () {
        expect(ShareCardLevel.simple.displayName, 'シンプル');
      });

      test('profile should return "プロフィール付き"', () {
        expect(ShareCardLevel.profile.displayName, 'プロフィール付き');
      });

      test('review should return "感想共有"', () {
        expect(ShareCardLevel.review.displayName, '感想共有');
      });
    });
  });
}
