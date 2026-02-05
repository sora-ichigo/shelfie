import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shelfie/core/error/failure.dart';

part 'share_image_service.g.dart';

@riverpod
ShareImageService shareImageService(Ref ref) => ShareImageService();

class ShareImageService {
  Future<Either<Failure, void>> captureAndShare({
    required GlobalKey boundaryKey,
    double pixelRatio = 3.0,
    Rect? sharePositionOrigin,
  }) async {
    final bytesResult = await captureAsBytes(
      boundaryKey: boundaryKey,
      pixelRatio: pixelRatio,
    );

    return bytesResult.fold(
      Left.new,
      (bytes) async {
        File? tempFile;
        try {
          final dir = Directory.systemTemp;
          final timestamp = DateTime.now().millisecondsSinceEpoch;
          tempFile = File('${dir.path}/shelfie_share_$timestamp.png');
          await tempFile.writeAsBytes(bytes);

          await Share.shareXFiles(
            [XFile(tempFile.path, mimeType: 'image/png')],
            sharePositionOrigin: sharePositionOrigin,
          );

          return const Right(null);
        } on Exception catch (e, st) {
          return Left(
            Failure.unexpected(
              message: 'シェアに失敗しました: $e',
              stackTrace: st,
            ),
          );
        } finally {
          if (tempFile != null && tempFile.existsSync()) {
            try {
              await tempFile.delete();
            } on Exception catch (_) {}
          }
        }
      },
    );
  }

  Future<Either<Failure, Uint8List>> captureAsBytes({
    required GlobalKey boundaryKey,
    double pixelRatio = 3.0,
  }) async {
    try {
      final boundary = boundaryKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;
      if (boundary == null) {
        return const Left(
          Failure.unexpected(message: '画像の生成に失敗しました。再度お試しください'),
        );
      }

      final image = await boundary.toImage(pixelRatio: pixelRatio);
      final byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      image.dispose();

      if (byteData == null) {
        return const Left(
          Failure.unexpected(message: '画像の生成に失敗しました。再度お試しください'),
        );
      }

      return Right(byteData.buffer.asUint8List());
    } on Exception catch (e, st) {
      return Left(
        Failure.unexpected(
          message: '画像の生成に失敗しました: $e',
          stackTrace: st,
        ),
      );
    }
  }
}
