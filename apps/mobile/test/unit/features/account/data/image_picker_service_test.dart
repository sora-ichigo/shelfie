import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/features/account/data/image_picker_service.dart';

class MockImagePicker extends Mock implements ImagePicker {}

void main() {
  late MockImagePicker mockImagePicker;
  late ImagePickerService service;

  setUp(() {
    mockImagePicker = MockImagePicker();
    service = ImagePickerService(picker: mockImagePicker);
  });

  group('ImagePickerService', () {
    group('pickFromGallery', () {
      test('returns XFile when image is selected', () async {
        final mockFile = XFile('/path/to/image.jpg');
        when(
          () => mockImagePicker.pickImage(source: ImageSource.gallery),
        ).thenAnswer((_) async => mockFile);

        final result = await service.pickFromGallery();

        expect(result, isNotNull);
        expect(result!.path, equals('/path/to/image.jpg'));
        verify(
          () => mockImagePicker.pickImage(source: ImageSource.gallery),
        ).called(1);
      });

      test('returns null when user cancels', () async {
        when(
          () => mockImagePicker.pickImage(source: ImageSource.gallery),
        ).thenAnswer((_) async => null);

        final result = await service.pickFromGallery();

        expect(result, isNull);
      });
    });

    group('pickFromCamera', () {
      test('returns XFile when image is captured', () async {
        final mockFile = XFile('/path/to/captured.jpg');
        when(
          () => mockImagePicker.pickImage(source: ImageSource.camera),
        ).thenAnswer((_) async => mockFile);

        final result = await service.pickFromCamera();

        expect(result, isNotNull);
        expect(result!.path, equals('/path/to/captured.jpg'));
        verify(
          () => mockImagePicker.pickImage(source: ImageSource.camera),
        ).called(1);
      });

      test('returns null when user cancels', () async {
        when(
          () => mockImagePicker.pickImage(source: ImageSource.camera),
        ).thenAnswer((_) async => null);

        final result = await service.pickFromCamera();

        expect(result, isNull);
      });
    });
  });
}
