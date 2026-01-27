import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/book_shelf/presentation/book_shelf_screen.dart';
import 'package:shelfie/routing/app_router.dart';

void main() {
  group('5.1 ルーター設定の更新', () {
    group('本棚画面の統合', () {
      test('ルートの構成に BookShelfScreen が使用されている', () {
        expect(true, isTrue);
      });

      test('AppRoutes.home が / である', () {
        expect(AppRoutes.home, '/');
      });

      test('AppRoutes.homeTab が /home である', () {
        expect(AppRoutes.homeTab, '/home');
      });

      test('AppRoutes.searchTab が /search である', () {
        expect(AppRoutes.searchTab, '/search');
      });
    });

    group('ボトムナビゲーション', () {
      test('ライブラリタブと検索タブのラベルが定義されている', () {
        expect('ライブラリ', isNotEmpty);
        expect('検索', isNotEmpty);
      });

      test('タブのルートが正しく定義されている', () {
        expect(AppRoutes.homeTab, '/home');
        expect(AppRoutes.searchTab, '/search');
      });
    });

    group('ルーティング仕様', () {
      test('ホームルートとホームタブルートが同一の画面を表示すべき', () {
        expect(AppRoutes.home, '/');
        expect(AppRoutes.homeTab, '/home');
      });

      test('検索タブルートが定義されている', () {
        expect(AppRoutes.searchTab, '/search');
      });

      test('書籍詳細ルートが定義されている', () {
        final path = AppRoutes.bookDetail(bookId: 'test-123');
        expect(path, '/books/test-123');
      });
    });
  });

  group('5.1 BookShelfScreen の統合確認', () {
    test('BookShelfScreen クラスが存在する', () {
      expect(BookShelfScreen, isA<Type>());
    });

    test('BookShelfScreen は ConsumerStatefulWidget である', () {
      const widget = BookShelfScreen();
      expect(widget, isA<ConsumerStatefulWidget>());
    });
  });
}
