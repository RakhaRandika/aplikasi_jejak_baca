import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart' hide User;

import '../enums/reading_status.dart';
import '../models/book.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  ApiException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

// Mengambil data buku dan rak bacaan dari Supabase.
class ApiService {
  static const _timeout = Duration(seconds: 30);

  static SupabaseClient get _db => Supabase.instance.client;

  static Future<List<Book>> getBooks({String? search}) {
    return run(() async {
      var query = _db.from('buku').select();
      final q = _clean(search);
      if (q.isNotEmpty) {
        query = query.or('judul.ilike.%$q%,penulis.ilike.%$q%');
      }
      final rows = await query.order('id_buku', ascending: true);
      return rows.map(Book.fromJson).toList();
    });
  }

  static Future<List<Book>> getShelf() {
    return run(() async {
      final rows = await _db
          .from('rak_baca')
          .select('id_buku, status, waktu_ditambahkan, buku(*)')
          .order('waktu_ditambahkan', ascending: false);
      return rows
          .where((r) => r['buku'] != null)
          .map(
            (r) => Book.fromJson({
              ...Map<String, dynamic>.from(r['buku'] as Map),
              'status': r['status'],
            }),
          )
          .toList();
    });
  }

  static Future<void> addToShelf(
    String idBuku, {
    ReadingStatus status = ReadingStatus.wantToRead,
  }) {
    return run(() async {
      try {
        await _db.from('rak_baca').insert({
          'id_buku': _id(idBuku),
          'status': status.value,
        });
      } on PostgrestException catch (e) {
        if (e.code == '23505') return; 
        rethrow;
      }
    });
  }

  static Future<void> updateShelfStatus(
    String idBuku, {
    required ReadingStatus status,
  }) {
    return run(() async {
      final rows = await _db
          .from('rak_baca')
          .update({'status': status.value})
          .eq('id_buku', _id(idBuku))
          .select('id_rak');
      if (rows.isEmpty) {
        throw ApiException('Buku ini tidak ada di jejak baca');
      }
    });
  }

  static Future<void> removeFromShelf(String idBuku) {
    return run(() async {
      await _db.from('rak_baca').delete().eq('id_buku', _id(idBuku));
    });
  }

  static Future<T> run<T>(Future<T> Function() action) async {
    try {
      return await action().timeout(_timeout);
    } on ApiException {
      rethrow;
    } on TimeoutException {
      throw ApiException('Server tidak merespons, coba lagi');
    } on AuthException catch (e) {
      throw ApiException(
        _authMessage(e),
        statusCode: int.tryParse(e.statusCode ?? ''),
      );
    } on PostgrestException catch (e) {
      final detail = '${e.message} ${e.details ?? ''}';
      if (e.code == '42501' ||
          e.code == 'PGRST301' ||
          (e.code == '23503' && detail.contains('user_id'))) {
        throw ApiException('Sesi berakhir, silakan login ulang', statusCode: 401);
      }
      if (e.code == '23503') {
        throw ApiException('Buku tidak ditemukan');
      }
      throw ApiException('Terjadi kesalahan (${e.code ?? 'db'}), coba lagi');
    } catch (e) {
      final text = e.toString();
      if (text.contains('SocketException') ||
          text.contains('ClientException') ||
          text.contains('HandshakeException')) {
        throw ApiException('Tidak dapat terhubung ke server');
      }
      throw ApiException('Terjadi kesalahan (${e.runtimeType}), coba lagi');
    }
  }

  static String _authMessage(AuthException e) {
    if (e is AuthRetryableFetchException) {
      return 'Tidak dapat terhubung ke server';
    }
    switch (e.code) {
      case 'invalid_credentials':
        return 'Email atau kata sandi salah';
      case 'email_not_confirmed':
        return 'Email belum diverifikasi. Cek kotak masuk email kamu';
      case 'user_already_exists':
      case 'email_exists':
        return 'Email sudah terdaftar';
      case 'weak_password':
        return 'Kata sandi terlalu lemah';
      case 'email_address_invalid':
        return 'Format email tidak valid';
      case 'over_request_rate_limit':
      case 'over_email_send_rate_limit':
        return 'Terlalu banyak percobaan, coba lagi beberapa saat lagi';
    }
    if (e.statusCode == '429') {
      return 'Terlalu banyak percobaan, coba lagi beberapa saat lagi';
    }
    return 'Gagal masuk (${e.code ?? e.statusCode ?? 'auth'}), coba lagi';
  }

  static int _id(String idBuku) {
    final id = int.tryParse(idBuku);
    if (id == null) throw ApiException('ID buku tidak valid');
    return id;
  }

  static String _clean(String? s) =>
      (s ?? '').replaceAll(RegExp(r'[,()%*\\"]'), ' ').trim();
}
