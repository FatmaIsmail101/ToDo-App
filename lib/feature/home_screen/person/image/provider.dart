import 'package:flutter_riverpod/legacy.dart';
import 'package:image_picker/image_picker.dart';
import 'package:up_todo_app/core/casheing/cache_helper.dart';

final pickImage = StateNotifierProvider<ImagePickNotifier, String?>((ref) {
  return ImagePickNotifier();
});

class ImagePickNotifier extends StateNotifier<String?> {
  ImagePickNotifier() : super(null) {
    _loadImage();
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> _loadImage() async {
    final savedImage = CacheHelper.getString("image");
    if (savedImage != null && savedImage.isNotEmpty) {
      state = savedImage;
    }
  }

  Future<void> setImage({bool fromCamera = false}) async {
    final XFile? picked = await _picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (picked != null) {
      state = picked.path;
      await CacheHelper.setString("image", picked.path);
    }
  }

  Future<void> removeImage() async {
    state = null;
    await CacheHelper.remove("image");
  }
}
