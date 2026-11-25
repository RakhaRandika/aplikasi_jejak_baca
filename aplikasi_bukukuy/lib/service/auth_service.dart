import 'package:supabase_flutter/supabase_flutter.dart' as sb;

import '../models/user.dart';
import 'api_service.dart';

// Login, register, dan logout lewat Supabase Auth.
class AuthService {
  static User? currentUser;

  static sb.GoTrueClient get _auth => sb.Supabase.instance.client.auth;

  static bool get isLoggedIn =>
      _auth.currentSession != null && currentUser != null;

  static Future<void> login(String email, String password) {
    return ApiService.run(() async {
      final res = await _auth.signInWithPassword(
        email: email.trim().toLowerCase(),
        password: password,
      );
      _setUser(res.user);
    });
  }

  static Future<void> register(String nama, String email, String password) {
    return ApiService.run(() async {
      final namaBersih = nama.trim();
      final emailBersih = email.trim().toLowerCase();
      if (namaBersih.isEmpty || emailBersih.isEmpty || password.isEmpty) {
        throw ApiException('Nama, email, dan kata sandi wajib diisi');
      }
      if (password.length < 8) {
        throw ApiException('Kata sandi minimal 8 karakter');
      }

      final res = await _auth.signUp(
        email: emailBersih,
        password: password,
        data: {'nama': namaBersih},
      );

      if (res.user != null && (res.user!.identities ?? const []).isEmpty) {
        throw ApiException('Email sudah terdaftar');
      }
      if (res.session == null) {
        throw ApiException(
          'Akun berhasil dibuat. Cek email untuk verifikasi, lalu login',
        );
      }
      _setUser(res.user);
    });
  }

  static Future<void> restoreSession() async {
    final session = _auth.currentSession;
    if (session == null) return;
    try {
      final res = await _auth.getUser();
      _setUser(res.user ?? session.user);
    } on sb.AuthRetryableFetchException {
      _setUser(session.user);
    } on sb.AuthException {
      await logout();
    } catch (_) {
      _setUser(session.user);
    }
  }

  static Future<void> logout() async {
    currentUser = null;
    try {
      await _auth.signOut();
    } catch (_) {
      // abaikan, sesi lokal sudah dihapus
    }
  }

  static void _setUser(sb.User? user) {
    if (user == null) {
      currentUser = null;
      return;
    }
    currentUser = User(
      idUser: user.id,
      nama: (user.userMetadata?['nama'] ?? '').toString(),
      email: user.email ?? '',
    );
  }
}
