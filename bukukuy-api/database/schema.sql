-- Tabel USER (nama "users" karena "user" adalah kata kunci di PostgreSQL)
CREATE TABLE IF NOT EXISTS users (
  id_user   SERIAL PRIMARY KEY,
  nama      VARCHAR(100) NOT NULL,
  email     VARCHAR(150) NOT NULL UNIQUE,
  password  VARCHAR(255) NOT NULL
);

-- Tabel BUKU
CREATE TABLE IF NOT EXISTS buku (
  id_buku       SERIAL PRIMARY KEY,
  judul         VARCHAR(255) NOT NULL,
  penulis       VARCHAR(150) NOT NULL,
  penerbit      VARCHAR(150),
  tahun_terbit  VARCHAR(4),
  deskripsi     TEXT,
  cover_url     TEXT
);

-- Tabel FAVORITES (satu buku -> banyak favorit)
CREATE TABLE favorites (
  id_favorite        SERIAL PRIMARY KEY,
  id_user            INTEGER NOT NULL REFERENCES users(id_user) ON DELETE CASCADE,
  id_buku            INTEGER NOT NULL REFERENCES buku(id_buku) ON DELETE CASCADE,
  waktu_ditambahkan  TIMESTAMP NOT NULL DEFAULT NOW(),

  CONSTRAINT favorites_user_buku_unique UNIQUE (id_user, id_buku)
);



