class User {
  final String idUser;
  final String nama;
  final String email;

  User({required this.idUser, required this.nama, required this.email});

  factory User.fromJson(Map<String, dynamic> j) => User(
        idUser: j['id_user'].toString(),
        nama: (j['nama'] ?? '').toString(),
        email: (j['email'] ?? '').toString(),
      );
}
