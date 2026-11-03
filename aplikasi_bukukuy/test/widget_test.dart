import 'package:aplikasi_bukukuy/models/book.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Book.fromJson menerima id & tahun berupa angka maupun string', () {
    final a = Book.fromJson({
      'id_buku': 7,
      'judul': 'Laskar Pelangi',
      'penulis': 'Andrea Hirata',
      'tahun_terbit': 2005,
    });
    expect(a.idBuku, '7');
    expect(a.tahunTerbit, '2005');

    final b = Book.fromJson({
      'id_buku': '8',
      'judul': 'Bumi',
      'penulis': 'Tere Liye',
      'tahun_terbit': '2014',
    });
    expect(b.idBuku, '8');
    expect(b.penerbit, isNull);
  });
}
