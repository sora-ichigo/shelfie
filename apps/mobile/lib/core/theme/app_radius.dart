import 'package:flutter/widgets.dart';

/// アプリケーション全体のボーダーラディウス定数
///
/// 一貫したデザインを提供するために、
/// ボタン、カード、モーダルなどで使用する角丸の値を定義する。
abstract final class AppRadius {
  /// 角丸なし (0px)
  static const double none = 0;

  /// 小さい角丸 (4px) - 小さいチップ
  static const double sm = 4;

  /// 中くらいの角丸 (8px) - ボタン、カード
  static const double md = 8;

  /// 大きい角丸 (12px) - モーダル、大きいカード
  static const double lg = 12;

  /// 完全な円形 (9999px) - 円形ボタン、アバター
  static const double full = 9999;

  /// 均一な BorderRadius を生成
  static BorderRadius circular(double radius) => BorderRadius.circular(radius);
}
