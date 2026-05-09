import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://192.168.100.156:8000/api";

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

    return jsonDecode(response.body);
  }

  static Future<List<dynamic>> getPengantaranKurir(String kurirId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/kurir/$kurirId/pengantaran'),
      headers: {
        'Accept': 'application/json',
      },
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['status'] == true) {
      return data['data'] ?? [];
    }

    throw Exception(data['message'] ?? 'Gagal mengambil data pengantaran');
  }

  static Future<Map<String, dynamic>> getDetailPengantaran(int pengantaranId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/pengantaran/$pengantaranId/detail'),
      headers: {
        'Accept': 'application/json',
      },
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['status'] == true) {
      return data['data'];
    }

    throw Exception(data['message'] ?? 'Gagal mengambil detail pengantaran');
  }

  static Future<Map<String, dynamic>> verifikasiPengantaran({
    required int pengantaranId,
    required File foto,
  }) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/pengantaran/$pengantaranId/verifikasi'),
    );

    request.headers.addAll({
      'Accept': 'application/json',
    });

    request.files.add(
      await http.MultipartFile.fromPath(
        'foto',
        foto.path,
      ),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['status'] == true) {
      return data;
    }

    throw Exception(data['message'] ?? 'Verifikasi gagal');
  }

  static Future<List<dynamic>> getRiwayatKurir(String kurirId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/riwayat-kurir/$kurirId'),
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data is Map && data['data'] != null) {
        return data['data'];
      }

      if (data is List) {
        return data;
      }

      return [];
    } else {
      throw Exception(
        'Status ${response.statusCode}\n${response.body}',
      );
    }
  }
}