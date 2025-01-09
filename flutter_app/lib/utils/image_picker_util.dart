import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import '../api/note_api.dart';

class ImagePickerUtil {
  static Future<String?> pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageUrl = await uploadImageToBackend(pickedFile.path);
      return imageUrl;
    }
    return null;
  }

  static Future<String> uploadImageToBackend(String filePath) async {
    try {
      final response = await NoteApi.uploadImage(filePath);
      final responseBody = jsonDecode(response.body);
      final imageUrl = responseBody['imageUrl'];
      return imageUrl;
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }
}
