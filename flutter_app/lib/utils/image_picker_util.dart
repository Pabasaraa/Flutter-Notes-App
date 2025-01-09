import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../api/note_api.dart';

class ImagePickerUtil {
  static Future<File?> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  static Future<String> uploadImageToBackend(File file) async {
    try {
      final response = await NoteApi.uploadImage(file.path);
      final responseBody = jsonDecode(response.body);
      final imageUrl = responseBody['imageUrl'];
      return imageUrl;
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }
}
