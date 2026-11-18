import '../enums/status_baca.dart';

class Book {
  final String idBuku;
  final String judul;
  final String penulis;
  final String? penerbit;
  final String? tahunTerbit;
  final String? deskripsi;
  final String? coverUrl;

  final StatusBaca? status;

  Book({
    required this.idBuku,
    required this.judul,
    required this.penulis,
    this.penerbit,
    this.tahunTerbit,
    this.deskripsi,
    this.coverUrl,
    this.status,
  });

  factory Book.fromJson(Map<String, dynamic> j) => Book(
    idBuku: j['id_buku'].toString(),
    judul: (j['judul'] ?? '').toString(),
    penulis: (j['penulis'] ?? '').toString(),
    penerbit: j['penerbit']?.toString(),
    tahunTerbit: j['tahun_terbit']?.toString(),
    deskripsi: j['deskripsi']?.toString(),
    coverUrl: j['cover_url']?.toString(),
    status: StatusBaca.fromValue(j['status']?.toString()),
  );

  Book withRak(StatusBaca status) => Book(
    idBuku: idBuku,
    judul: judul,
    penulis: penulis,
    penerbit: penerbit,
    tahunTerbit: tahunTerbit,
    deskripsi: deskripsi,
    coverUrl: coverUrl,
    status: status,
  );
}
