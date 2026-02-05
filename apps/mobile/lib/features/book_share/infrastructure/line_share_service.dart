import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'line_share_service.g.dart';

@riverpod
LineShareService lineShareService(Ref ref) => LineShareService();

class LineShareService {
  static const _channel =
      MethodChannel('app.shelfie.shelfie/line_share');

  Future<bool> isAvailable() async {
    try {
      final result = await _channel.invokeMethod<bool>('isAvailable');
      return result ?? false;
    } on PlatformException {
      return false;
    }
  }

  Future<bool> shareImage({required String filePath}) async {
    try {
      final result = await _channel.invokeMethod<bool>(
        'shareImage',
        {'filePath': filePath},
      );
      return result ?? false;
    } on PlatformException {
      return false;
    }
  }
}
