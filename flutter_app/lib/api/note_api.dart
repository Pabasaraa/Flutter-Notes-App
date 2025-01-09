import 'api_client.dart';

class NoteApi {
  static Future getNotes() async => ApiClient.get('/notes');
  static Future createNote(Map<String, dynamic> note) async =>
      ApiClient.post('/notes', note);
  static Future updateNote(String id, Map<String, dynamic> note) async =>
      ApiClient.put('/notes/$id', note);
  static Future deleteNote(String id) async => ApiClient.delete('/notes/$id');
  static Future uploadImage(String filePath) async =>
      ApiClient.uploadImage('/assets/upload', filePath);
}
