import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class ApiClient {
  static const String baseUrl = kBackendUrl;

  static Future<http.Response> get(String endpoint) async {
    return await http.get(Uri.parse('$baseUrl$endpoint'));
  }

  static Future<http.Response> post(
      String endpoint, Map<String, dynamic> body) async {
    return await http.post(Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(body));
  }

  static Future<http.Response> put(
      String endpoint, Map<String, dynamic> body) async {
    return await http.put(Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(body));
  }

  static Future<http.Response> delete(String endpoint) async {
    return await http.delete(Uri.parse('$baseUrl$endpoint'));
  }

  static Future<http.Response> uploadImage(
      String endpoint, String filePath) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('file', filePath));

    final response = await request.send();
    return http.Response.fromStream(response);
  }
}
