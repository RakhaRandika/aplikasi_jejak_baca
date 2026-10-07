import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/book.dart';
import '../models/user.dart';
import 'auth_service.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  ApiException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

class ApiService {
  static const _hpAsliViaUsb = true;

  static String get baseUrl {
    final isAndroid = !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
    return isAndroid && !_hpAsliViaUsb
        ? 'http://10.0.2.2:3000/api'
        : 'http://localhost:3000/api';
  }

  static const _timeout = Duration(seconds: 10);

  // Favorit disimpan per akun, jadi backend butuh token user yang sedang login
  static Map<String, String> get _authHeaders => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AuthService.token}',
      };

  // Hasil login & register: { "token": "...", "user": {...} }
  static Future<Map<String, dynamic>> login(String email, String password) async {
    return await _send(
      () => http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      ),
    );
  }

  static Future<Map<String, dynamic>> register(
      String nama, String email, String password) async {
    return await _send(
      () => http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'nama': nama, 'email': email, 'password': password}),
      ),
    );
  }

  static Future<User> me(String token) async {
    final data = await _send(
      () => http.get(
        Uri.parse('$baseUrl/auth/me'),
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    return User.fromJson(data);
  }

  static Future<List<Book>> getBooks({String? search}) async {
    final uri = Uri.parse('$baseUrl/buku').replace(
        queryParameters: (search != null && search.isNotEmpty) ? {'search': search} : null);
    final List data = await _send(() => http.get(uri));
    return data.map((e) => Book.fromJson(e)).toList();
  }

  static Future<List<Book>> getFavorites() async {
    final List data = await _send(
        () => http.get(Uri.parse('$baseUrl/favorites'), headers: _authHeaders));
    return data.map((e) => Book.fromJson(e)).toList();
  }

  // 409 = buku sudah ada di favorit, dianggap berhasil
  static Future<void> tambahFavorite(int idBuku) => _send(
        () => http.post(
          Uri.parse('$baseUrl/favorites'),
          headers: _authHeaders,
          body: jsonEncode({'id_buku': idBuku}),
        ),
        okStatus: const [409],
      );

  // 404 = buku sudah tidak ada di favorit, dianggap berhasil
  static Future<void> hapusFavorite(int idBuku) => _send(
        () => http.delete(Uri.parse('$baseUrl/favorites/buku/$idBuku'),
            headers: _authHeaders),
        okStatus: const [404],
      );

  static Future<dynamic> _send(
    Future<http.Response> Function() request, {
    List<int> okStatus = const [],
  }) async {
    final http.Response res;
    try {
      res = await request().timeout(_timeout);
    } catch (_) {
      throw ApiException('gagal memuat ke bukukuy-api, periksa koneksi internet');
    }

    dynamic body;
    try {
      body = jsonDecode(res.body);
    } catch (_) {
      throw ApiException('Respons server tidak valid (${res.statusCode})');
    }

    final sukses = res.statusCode >= 200 && res.statusCode < 300;
    if (!sukses && !okStatus.contains(res.statusCode)) {
      throw ApiException(
        body['message'] ?? 'Terjadi kesalahan (${res.statusCode})',
        statusCode: res.statusCode,
      );
    }
    return body['data'];
  }
}
