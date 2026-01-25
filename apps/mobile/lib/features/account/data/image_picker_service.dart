import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_picker_service.g.dart';

@riverpod
ImagePickerService imagePickerService(Ref ref) {
  return ImagePickerService(picker: ImagePicker());
}

class ImagePickerService {
  const ImagePickerService({required this.picker});

  final ImagePicker picker;

  Future<XFile?> pickFromGallery() async {
    return picker.pickImage(source: ImageSource.gallery);
  }

  Future<XFile?> pickFromCamera() async {
    return picker.pickImage(source: ImageSource.camera);
  }
}
