import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/features/account/data/account_repository.dart';
import 'package:shelfie/features/account/domain/upload_credentials.dart';
import 'package:shelfie/features/account/domain/user_profile.dart';

part 'avatar_upload_service.g.dart';

enum ImageValidationErrorType {
  invalidFormat,
  fileTooLarge,
}

class ImageValidationResult {
  const ImageValidationResult({
    required this.isValid,
    this.errorMessage,
    this.errorType,
  });

  final bool isValid;
  final String? errorMessage;
  final ImageValidationErrorType? errorType;

  static const ImageValidationResult valid =
      ImageValidationResult(isValid: true);
}

class AvatarUploadResult {
  const AvatarUploadResult({
    required this.fileId,
    required this.url,
  });

  final String fileId;
  final String url;
}

@riverpod
AvatarUploadService avatarUploadService(AvatarUploadServiceRef ref) {
  final repository = ref.watch(accountRepositoryProvider);
  return AvatarUploadService(
    httpClient: http.Client(),
    repository: repository,
  );
}

class AvatarUploadService {
  AvatarUploadService({
    http.Client? httpClient,
    AccountRepository? repository,
  })  : _httpClient = httpClient ?? http.Client(),
        _repository = repository;

  final http.Client _httpClient;
  final AccountRepository? _repository;

  static const int maxFileSizeBytes = 5 * 1024 * 1024; // 5MB
  static const List<String> supportedMimeTypes = [
    'image/jpeg',
    'image/png',
    'image/webp',
  ];
  static const List<String> supportedExtensions = [
    'jpg',
    'jpeg',
    'png',
    'webp',
  ];

  Future<ImageValidationResult> validateImage(XFile file) async {
    final mimeType = file.mimeType;
    final extension = _getExtension(file.path);

    final isValidFormat = _isValidFormat(mimeType, extension);
    if (!isValidFormat) {
      return const ImageValidationResult(
        isValid: false,
        errorMessage: 'JPEG、PNG、WebP形式の画像を選択してください',
        errorType: ImageValidationErrorType.invalidFormat,
      );
    }

    final fileSize = await file.length();
    if (fileSize > maxFileSizeBytes) {
      return const ImageValidationResult(
        isValid: false,
        errorMessage: '画像サイズは5MB以下にしてください',
        errorType: ImageValidationErrorType.fileTooLarge,
      );
    }

    return ImageValidationResult.valid;
  }

  Future<Either<Failure, AvatarUploadResult>> uploadToImageKit({
    required XFile file,
    required UploadCredentials credentials,
    void Function(double progress)? onProgress,
  }) async {
    try {
      final uri = Uri.parse(credentials.uploadEndpoint);
      final request = http.MultipartRequest('POST', uri);

      final fileName = _getFileName(file.path);
      final bytes = await file.readAsBytes();

      request.fields['publicKey'] = credentials.publicKey;
      request.fields['signature'] = credentials.signature;
      request.fields['expire'] = credentials.expire.toString();
      request.fields['token'] = credentials.token;
      request.fields['fileName'] = fileName;
      request.fields['folder'] = '/avatars';
      request.fields['useUniqueFileName'] = 'true';

      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          bytes,
          filename: fileName,
        ),
      );

      final streamedResponse = await _httpClient.send(request);
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        return right(
          AvatarUploadResult(
            fileId: body['fileId'] as String? ?? '',
            url: body['url'] as String? ?? '',
          ),
        );
      } else {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        final message = body['message'] as String? ?? 'Upload failed';
        return left(
          ServerFailure(
            message: message,
            code: 'UPLOAD_ERROR',
            statusCode: response.statusCode,
          ),
        );
      }
    } on http.ClientException catch (e) {
      return left(NetworkFailure(message: e.message));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, UserProfile>> uploadAndUpdateProfile({
    required XFile file,
    required String name,
    String? bio,
    String? instagramHandle,
    String? handle,
    bool? isPublic,
    void Function(double progress)? onProgress,
  }) async {
    if (_repository == null) {
      return left(
        const UnexpectedFailure(message: 'Repository not configured'),
      );
    }

    final validationResult = await validateImage(file);
    if (!validationResult.isValid) {
      return left(
        ValidationFailure(
          message:
              validationResult.errorMessage ?? 'Invalid image',
        ),
      );
    }

    final credentialsResult = await _repository.getUploadCredentials();
    if (credentialsResult.isLeft()) {
      return left(credentialsResult.getLeft().toNullable()!);
    }

    final credentials = credentialsResult.getRight().toNullable()!;
    final uploadResult = await uploadToImageKit(
      file: file,
      credentials: credentials,
      onProgress: onProgress,
    );

    if (uploadResult.isLeft()) {
      return left(uploadResult.getLeft().toNullable()!);
    }

    final avatarUrl = uploadResult.getRight().toNullable()!.url;
    return _repository.updateProfile(
      name: name,
      avatarUrl: avatarUrl,
      bio: bio,
      instagramHandle: instagramHandle,
      handle: handle,
      isPublic: isPublic,
    );
  }

  bool _isValidFormat(String? mimeType, String extension) {
    if (mimeType != null) {
      return supportedMimeTypes.contains(mimeType);
    }
    return supportedExtensions.contains(extension.toLowerCase());
  }

  String _getExtension(String path) {
    final parts = path.split('.');
    if (parts.length < 2) return '';
    return parts.last;
  }

  String _getFileName(String path) {
    return path.split('/').last;
  }
}
