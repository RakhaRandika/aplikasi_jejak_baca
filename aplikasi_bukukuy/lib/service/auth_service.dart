import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import 'api_service.dart';

class AuthService {
  static const _tokenKey = 'auth_token';

  static User? currentUser;

  static bool get isLoggedIn => ApiService.token != null && currentUser != null;

  static Future<void> login(String email, String password) async {
    final data = await ApiService.login(email, password);
    await _saveSession(data);
  }

  static Future<void> register(
    String nama,
    String email,
    String password,
  ) async {
    final data = await ApiService.register(nama, email, password);
    await _saveSession(data);
  }

  static Future<void> restoreSession() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_tokenKey);
    if (saved == null) return;

    ApiService.token = saved;
    try {
      currentUser = await ApiService.me();
    } on ApiException catch (e) {
      if (e.statusCode == 401) {
        await logout();
      } else {
        ApiService.token = null;
      }
    }
  }

  static Future<void> logout() async {
    ApiService.token = null;
    currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  static Future<void> _saveSession(Map<String, dynamic> data) async {
    final token = data['token'].toString();
    ApiService.token = token;
    currentUser = User.fromJson(Map<String, dynamic>.from(data['user'] as Map));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }
}
