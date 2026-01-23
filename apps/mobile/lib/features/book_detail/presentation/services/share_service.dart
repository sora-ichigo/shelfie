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
}

/// ShareService プロバイダー
@riverpod
ShareService shareService(ShareServiceRef ref) {
  return ShareServiceImpl();
}
