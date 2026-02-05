import 'dart:io';

import 'package:appinio_social_share/appinio_social_share.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'instagram_story_service.g.dart';

@riverpod
InstagramStoryService instagramStoryService(Ref ref) =>
    InstagramStoryService();

class InstagramStoryService {
  static const _facebookAppId = '1851655515480002';

  final _socialShare = AppinioSocialShare();

  Future<bool> shareToStory({required String filePath}) async {
    try {
      if (Platform.isAndroid) {
        await _socialShare.android.shareToInstagramStory(
          _facebookAppId,
          backgroundImage: filePath,
          backgroundTopColor: '#000000',
          backgroundBottomColor: '#000000',
        );
      } else if (Platform.isIOS) {
        await _socialShare.iOS.shareToInstagramStory(
          _facebookAppId,
          backgroundImage: filePath,
          backgroundTopColor: '#000000',
          backgroundBottomColor: '#000000',
        );
      }
      return true;
    } on Exception {
      return false;
    }
  }
}
