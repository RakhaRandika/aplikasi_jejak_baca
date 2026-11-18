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
CREATE TABLE IF NOT EXISTS favorites (
  id_favorite        SERIAL PRIMARY KEY,
  id_user            INTEGER NOT NULL REFERENCES users(id_user) ON DELETE CASCADE,
  id_buku            INTEGER NOT NULL REFERENCES buku(id_buku) ON DELETE CASCADE,
  waktu_ditambahkan  TIMESTAMP NOT NULL DEFAULT NOW(),
  status             VARCHAR(20) NOT NULL DEFAULT 'ingin_dibaca'
                     CHECK (status IN ('ingin_dibaca', 'sedang_dibaca', 'selesai')),

  CONSTRAINT favorites_user_buku_unique UNIQUE (id_user, id_buku)
);

-- Untuk database yang sudah punya tabel favorites: tambahkan kolom status baca.
-- Aman dijalankan berulang kali.
ALTER TABLE favorites ADD COLUMN IF NOT EXISTS status VARCHAR(20) NOT NULL DEFAULT 'ingin_dibaca';

ALTER TABLE favorites DROP CONSTRAINT IF EXISTS favorites_status_check;
ALTER TABLE favorites ADD CONSTRAINT favorites_status_check
  CHECK (status IN ('ingin_dibaca', 'sedang_dibaca', 'selesai'));

-- Untuk database lama: hapus kolom yang tidak dipakai lagi.
ALTER TABLE buku DROP COLUMN IF EXISTS rangkuman;
ALTER TABLE buku DROP COLUMN IF EXISTS isi;
