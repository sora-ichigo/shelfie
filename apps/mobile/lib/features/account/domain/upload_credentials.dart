import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_credentials.freezed.dart';

@freezed
class UploadCredentials with _$UploadCredentials {
  const factory UploadCredentials({
    required String token,
    required String signature,
    required int expire,
    required String publicKey,
    required String uploadEndpoint,
  }) = _UploadCredentials;
}
