import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../enums/reading_status.dart';
import '../models/book.dart';
import '../models/user.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  ApiException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

class ApiService {
  static const _apiUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'http://localhost:3000',
  );
  static const baseUrl = '$_apiUrl/api';
  static const _timeout = Duration(seconds: 15);

  static String? token;

  static Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    if (token != null) 'Authorization': 'Bearer $token',
  };

  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final data = await _send(
      () => http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: _headers,
        body: jsonEncode({'email': email, 'password': password}),
      ),
    );
    return Map<String, dynamic>.from(data as Map);
  }

  static Future<Map<String, dynamic>> register(
    String nama,
    String email,
    String password,
  ) async {
    final data = await _send(
      () => http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: _headers,
        body: jsonEncode({'nama': nama, 'email': email, 'password': password}),
      ),
    );
    return Map<String, dynamic>.from(data as Map);
  }

  static Future<User> me() async {
    final data = await _send(
      () => http.get(Uri.parse('$baseUrl/auth/me'), headers: _headers),
    );
    return User.fromJson(Map<String, dynamic>.from(data as Map));
  }

  static Future<List<Book>> getBooks({String? search}) async {
    final uri = Uri.parse('$baseUrl/buku').replace(
      queryParameters: (search != null && search.isNotEmpty)
          ? {'search': search}
          : null,
    );
    final data = await _send(() => http.get(uri, headers: _headers));
    return _toBooks(data);
  }

  static Future<List<Book>> getShelf() async {
    final data = await _send(
      () => http.get(Uri.parse('$baseUrl/favorites'), headers: _headers),
    );
    return _toBooks(data);
  }

  static Future<void> addToShelf(
    String idBuku, {
    ReadingStatus status = ReadingStatus.wantToRead,
  }) async {
    await _send(
      () => http.post(
        Uri.parse('$baseUrl/favorites'),
        headers: _headers,
        body: jsonEncode({
          'id_buku': int.tryParse(idBuku) ?? idBuku,
          'status': status.value,
        }),
      ),
      okStatus: const [409],
    );
  }

  static Future<void> updateShelfStatus(
    String idBuku, {
    required ReadingStatus status,
  }) async {
    await _send(
      () => http.patch(
        Uri.parse('$baseUrl/favorites/buku/$idBuku'),
        headers: _headers,
        body: jsonEncode({'status': status.value}),
      ),
    );
  }

  static Future<void> removeFromShelf(String idBuku) async {
    await _send(
      () => http.delete(
        Uri.parse('$baseUrl/favorites/buku/$idBuku'),
        headers: _headers,
      ),
      okStatus: const [404],
    );
  }

  static List<Book> _toBooks(dynamic data) {
    final list = data is List ? data : const [];
    return list
        .map((e) => Book.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  static Future<dynamic> _send(
    Future<http.Response> Function() request, {
    List<int> okStatus = const [],
  }) async {
    final http.Response res;
    try {
      res = await request().timeout(_timeout);
    } on TimeoutException {
      throw ApiException('Server tidak merespons, coba lagi');
    } catch (_) {
      throw ApiException('Tidak dapat terhubung ke server');
    }

    dynamic body;
    try {
      body = jsonDecode(res.body);
    } catch (_) {
      body = null;
    }

    final isSuccess = res.statusCode >= 200 && res.statusCode < 300;
    if (!isSuccess && !okStatus.contains(res.statusCode)) {
      final message = body is Map ? body['message']?.toString() : null;
      throw ApiException(
        message ?? 'Terjadi kesalahan (${res.statusCode})',
        statusCode: res.statusCode,
      );
    }
    return body is Map ? body['data'] : null;
  }
}
