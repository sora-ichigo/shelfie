import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gal/gal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gallery_save_service.g.dart';

sealed class GallerySaveResult {
  const GallerySaveResult();
}

class GallerySaveSuccess extends GallerySaveResult {
  const GallerySaveSuccess();
}

class GallerySavePermissionDenied extends GallerySaveResult {
  const GallerySavePermissionDenied();
}

class GallerySaveError extends GallerySaveResult {
  const GallerySaveError({required this.message});
  final String message;
}

@riverpod
GallerySaveService gallerySaveService(Ref ref) => GallerySaveService();

class GallerySaveService {
  Future<GallerySaveResult> saveToGallery({
    required Uint8List imageBytes,
  }) async {
    try {
      final hasAccess = await Gal.hasAccess();
      if (!hasAccess) {
        final granted = await Gal.requestAccess();
        if (!granted) {
          return const GallerySavePermissionDenied();
        }
      }

      await Gal.putImageBytes(imageBytes);
      return const GallerySaveSuccess();
    } on GalException catch (e) {
      if (e.type == GalExceptionType.accessDenied) {
        return const GallerySavePermissionDenied();
      }
      return GallerySaveError(message: e.type.message);
    } on Exception catch (e) {
      return GallerySaveError(message: '画像の保存に失敗しました: $e');
    }
  }

  Future<bool> hasPermission() async {
    return Gal.hasAccess();
  }
}
