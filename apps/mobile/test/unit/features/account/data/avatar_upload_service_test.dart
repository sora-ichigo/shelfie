import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/features/account/data/account_repository.dart';
import 'package:shelfie/features/account/data/avatar_upload_service.dart';
import 'package:shelfie/features/account/domain/upload_credentials.dart';

class MockXFile extends Mock implements XFile {}

class MockAccountRepository extends Mock implements AccountRepository {}

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('AvatarUploadService', () {
    late AvatarUploadService service;

    setUp(() {
      service = AvatarUploadService();
    });

    group('validateImage', () {
      test('JPEG形式の画像は有効と判定される', () async {
        final mockFile = MockXFile();
        when(() => mockFile.path).thenReturn('/path/to/image.jpg');
        when(() => mockFile.mimeType).thenReturn('image/jpeg');
        when(() => mockFile.length()).thenAnswer((_) async => 1024 * 1024); // 1MB

        final result = await service.validateImage(mockFile);

        expect(result.isValid, isTrue);
        expect(result.errorMessage, isNull);
        expect(result.errorType, isNull);
      });

      test('PNG形式の画像は有効と判定される', () async {
        final mockFile = MockXFile();
        when(() => mockFile.path).thenReturn('/path/to/image.png');
        when(() => mockFile.mimeType).thenReturn('image/png');
        when(() => mockFile.length()).thenAnswer((_) async => 1024 * 1024); // 1MB

        final result = await service.validateImage(mockFile);

        expect(result.isValid, isTrue);
        expect(result.errorMessage, isNull);
        expect(result.errorType, isNull);
      });

      test('WebP形式の画像は有効と判定される', () async {
        final mockFile = MockXFile();
        when(() => mockFile.path).thenReturn('/path/to/image.webp');
        when(() => mockFile.mimeType).thenReturn('image/webp');
        when(() => mockFile.length()).thenAnswer((_) async => 1024 * 1024); // 1MB

        final result = await service.validateImage(mockFile);

        expect(result.isValid, isTrue);
        expect(result.errorMessage, isNull);
        expect(result.errorType, isNull);
      });

      test('未対応形式(GIF)の画像は無効と判定される', () async {
        final mockFile = MockXFile();
        when(() => mockFile.path).thenReturn('/path/to/image.gif');
        when(() => mockFile.mimeType).thenReturn('image/gif');
        when(() => mockFile.length()).thenAnswer((_) async => 1024 * 1024); // 1MB

        final result = await service.validateImage(mockFile);

        expect(result.isValid, isFalse);
        expect(result.errorType, equals(ImageValidationErrorType.invalidFormat));
        expect(result.errorMessage, contains('JPEG、PNG、WebP'));
      });

      test('未対応形式(BMP)の画像は無効と判定される', () async {
        final mockFile = MockXFile();
        when(() => mockFile.path).thenReturn('/path/to/image.bmp');
        when(() => mockFile.mimeType).thenReturn('image/bmp');
        when(() => mockFile.length()).thenAnswer((_) async => 1024 * 1024); // 1MB

        final result = await service.validateImage(mockFile);

        expect(result.isValid, isFalse);
        expect(result.errorType, equals(ImageValidationErrorType.invalidFormat));
      });

      test('5MBを超えるファイルは無効と判定される', () async {
        final mockFile = MockXFile();
        when(() => mockFile.path).thenReturn('/path/to/image.jpg');
        when(() => mockFile.mimeType).thenReturn('image/jpeg');
        when(() => mockFile.length())
            .thenAnswer((_) async => 6 * 1024 * 1024); // 6MB

        final result = await service.validateImage(mockFile);

        expect(result.isValid, isFalse);
        expect(result.errorType, equals(ImageValidationErrorType.fileTooLarge));
        expect(result.errorMessage, contains('5MB'));
      });

      test('5MB以下のファイルは有効と判定される', () async {
        final mockFile = MockXFile();
        when(() => mockFile.path).thenReturn('/path/to/image.jpg');
        when(() => mockFile.mimeType).thenReturn('image/jpeg');
        when(() => mockFile.length())
            .thenAnswer((_) async => 5 * 1024 * 1024); // 5MB (境界値)

        final result = await service.validateImage(mockFile);

        expect(result.isValid, isTrue);
      });

      test('mimeTypeがnullの場合は拡張子で判定される', () async {
        final mockFile = MockXFile();
        when(() => mockFile.path).thenReturn('/path/to/image.jpg');
        when(() => mockFile.mimeType).thenReturn(null);
        when(() => mockFile.length()).thenAnswer((_) async => 1024 * 1024);

        final result = await service.validateImage(mockFile);

        expect(result.isValid, isTrue);
      });

      test('拡張子が大文字でも正しく判定される', () async {
        final mockFile = MockXFile();
        when(() => mockFile.path).thenReturn('/path/to/image.JPG');
        when(() => mockFile.mimeType).thenReturn(null);
        when(() => mockFile.length()).thenAnswer((_) async => 1024 * 1024);

        final result = await service.validateImage(mockFile);

        expect(result.isValid, isTrue);
      });

      test('jpeg拡張子は有効と判定される', () async {
        final mockFile = MockXFile();
        when(() => mockFile.path).thenReturn('/path/to/image.jpeg');
        when(() => mockFile.mimeType).thenReturn(null);
        when(() => mockFile.length()).thenAnswer((_) async => 1024 * 1024);

        final result = await service.validateImage(mockFile);

        expect(result.isValid, isTrue);
      });
    });

    group('uploadToImageKit', () {
      late MockHttpClient mockHttpClient;
      late MockAccountRepository mockRepository;
      late AvatarUploadService serviceWithDeps;

      setUp(() {
        mockHttpClient = MockHttpClient();
        mockRepository = MockAccountRepository();
        serviceWithDeps = AvatarUploadService(
          httpClient: mockHttpClient,
          repository: mockRepository,
        );
      });

      setUpAll(() {
        registerFallbackValue(http.MultipartRequest('POST', Uri()));
        registerFallbackValue(http.BaseRequest);
      });

      test('アップロード成功時にAvatarUploadResultを返す', () async {
        final mockFile = MockXFile();
        when(() => mockFile.path).thenReturn('/path/to/image.jpg');
        when(() => mockFile.readAsBytes())
            .thenAnswer((_) async => Uint8List.fromList([1, 2, 3, 4, 5]));

        const credentials = UploadCredentials(
          token: 'test-token',
          signature: 'test-signature',
          expire: 1706200000,
          publicKey: 'public_key',
          uploadEndpoint: 'https://upload.imagekit.io/api/v1/files/upload',
        );

        final responseBody = jsonEncode({
          'fileId': 'file123',
          'url': 'https://ik.imagekit.io/test/avatar.jpg',
          'name': 'avatar.jpg',
        });

        when(() => mockHttpClient.send(any())).thenAnswer((_) async {
          return http.StreamedResponse(
            Stream.value(utf8.encode(responseBody)),
            200,
          );
        });

        final result = await serviceWithDeps.uploadToImageKit(
          file: mockFile,
          credentials: credentials,
        );

        expect(result.isRight(), isTrue);
        final uploadResult = result.getRight().toNullable()!;
        expect(uploadResult.fileId, equals('file123'));
        expect(uploadResult.url, equals('https://ik.imagekit.io/test/avatar.jpg'));
      });

      test('アップロード失敗時にServerFailureを返す', () async {
        final mockFile = MockXFile();
        when(() => mockFile.path).thenReturn('/path/to/image.jpg');
        when(() => mockFile.readAsBytes())
            .thenAnswer((_) async => Uint8List.fromList([1, 2, 3, 4, 5]));

        const credentials = UploadCredentials(
          token: 'test-token',
          signature: 'test-signature',
          expire: 1706200000,
          publicKey: 'public_key',
          uploadEndpoint: 'https://upload.imagekit.io/api/v1/files/upload',
        );

        final responseBody = jsonEncode({
          'message': 'Invalid signature',
        });

        when(() => mockHttpClient.send(any())).thenAnswer((_) async {
          return http.StreamedResponse(
            Stream.value(utf8.encode(responseBody)),
            400,
          );
        });

        final result = await serviceWithDeps.uploadToImageKit(
          file: mockFile,
          credentials: credentials,
        );

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<ServerFailure>());
      });

      test('ネットワークエラー時にNetworkFailureを返す', () async {
        final mockFile = MockXFile();
        when(() => mockFile.path).thenReturn('/path/to/image.jpg');
        when(() => mockFile.readAsBytes())
            .thenAnswer((_) async => Uint8List.fromList([1, 2, 3, 4, 5]));

        const credentials = UploadCredentials(
          token: 'test-token',
          signature: 'test-signature',
          expire: 1706200000,
          publicKey: 'public_key',
          uploadEndpoint: 'https://upload.imagekit.io/api/v1/files/upload',
        );

        when(() => mockHttpClient.send(any()))
            .thenThrow(http.ClientException('Network error'));

        final result = await serviceWithDeps.uploadToImageKit(
          file: mockFile,
          credentials: credentials,
        );

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<NetworkFailure>());
      });
    });

    group('uploadAndUpdateProfile', () {
      late MockHttpClient mockHttpClient;
      late MockAccountRepository mockRepository;
      late AvatarUploadService serviceWithDeps;

      setUp(() {
        mockHttpClient = MockHttpClient();
        mockRepository = MockAccountRepository();
        serviceWithDeps = AvatarUploadService(
          httpClient: mockHttpClient,
          repository: mockRepository,
        );
      });

      setUpAll(() {
        registerFallbackValue(http.MultipartRequest('POST', Uri()));
      });

      test('署名取得に失敗した場合はエラーを返す', () async {
        final mockFile = MockXFile();
        when(() => mockFile.path).thenReturn('/path/to/image.jpg');
        when(() => mockFile.mimeType).thenReturn('image/jpeg');
        when(() => mockFile.length()).thenAnswer((_) async => 1024);

        when(() => mockRepository.getUploadCredentials()).thenAnswer(
          (_) async => left(
            const ServerFailure(message: 'Service error', code: 'ERROR'),
          ),
        );

        final result = await serviceWithDeps.uploadAndUpdateProfile(
          file: mockFile,
          name: 'Test User',
        );

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<ServerFailure>());
      });
    });
  });
}
