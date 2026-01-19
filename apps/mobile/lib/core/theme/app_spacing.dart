import 'package:flutter/widgets.dart';

/// アプリケーション全体のスペーシング定数
///
/// 4pt グリッドシステムに基づいた一貫したスペーシングを提供する。
/// UI の余白やパディングにこれらの定数を使用することで、
/// デザインの統一性を保つ。
abstract final class AppSpacing {
  /// ゼロスペーシング (0pt)
  static const double zero = 0;

  /// 極小スペーシング (4pt)
  static const double xxs = 4;

  /// 超小スペーシング (8pt)
  static const double xs = 8;

  /// 小スペーシング (12pt - 4pt グリッドの例外として許容)
  static const double sm = 12;

  /// 中スペーシング (16pt)
  static const double md = 16;

  /// 大スペーシング (24pt)
  static const double lg = 24;

  /// 超大スペーシング (32pt)
  static const double xl = 32;

  /// 極大スペーシング (48pt)
  static const double xxl = 48;

  /// 水平方向のパディングを生成
  static EdgeInsets horizontal(double value) => EdgeInsets.symmetric(
        horizontal: value,
      );

  /// 垂直方向のパディングを生成
  static EdgeInsets vertical(double value) => EdgeInsets.symmetric(
        vertical: value,
      );

  /// 全方向のパディングを生成
  static EdgeInsets all(double value) => EdgeInsets.all(value);
}
