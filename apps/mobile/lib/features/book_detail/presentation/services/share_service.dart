import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';

part 'share_service.g.dart';

/// 共有機能を提供するサービス
///
/// OS 標準の共有シートを表示して、書籍情報を共有する。
abstract class ShareService {
  /// 書籍情報を共有する
  ///
  /// [title] - 書籍のタイトル
  /// [url] - 共有するURL（Amazon URL または infoLink）
  Future<void> shareBook({
    required String title,
    String? url,
  });

  /// ブックリスト情報を共有する
  Future<void> shareBookList({
    required String title,
    String? description,
    required int bookCount,
  });
}

/// ShareService の実装
class ShareServiceImpl implements ShareService {
  @override
  Future<void> shareBook({
    required String title,
    String? url,
  }) async {
    final text = url != null ? '$title\n$url' : title;

    // ignore: deprecated_member_use
    await Share.share(text);
  }

  @override
  Future<void> shareBookList({
    required String title,
    String? description,
    required int bookCount,
  }) async {
    final buffer = StringBuffer(title);
    if (description != null && description.isNotEmpty) {
      buffer.write('\n$description');
    }
    buffer.write('\n$bookCount冊');

    // ignore: deprecated_member_use
    await Share.share(buffer.toString());
  }
}

/// ShareService プロバイダー
@riverpod
ShareService shareService(Ref ref) {
  return ShareServiceImpl();
}
