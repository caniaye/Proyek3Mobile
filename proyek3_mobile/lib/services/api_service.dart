import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://localhost:8000/api";

  static Future<Map<String, dynamic>> loginKurir({
    required String kode,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login-kurir'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'kode': kode,
        'password': password,
      }),
    );

    final Map<String, dynamic> data = jsonDecode(response.body);
    return data;
  }
}