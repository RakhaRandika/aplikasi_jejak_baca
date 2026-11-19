CREATE TABLE IF NOT EXISTS users (
  id_user   SERIAL PRIMARY KEY,
  nama      VARCHAR(100) NOT NULL,
  email     VARCHAR(150) NOT NULL UNIQUE,
  password  VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS buku (
  id_buku       SERIAL PRIMARY KEY,
  judul         VARCHAR(255) NOT NULL,
  penulis       VARCHAR(150) NOT NULL,
  penerbit      VARCHAR(150),
  tahun_terbit  VARCHAR(4),
  deskripsi     TEXT,
  cover_url     TEXT
);

DO $$
BEGIN
  IF to_regclass('public.favorites') IS NOT NULL
     AND to_regclass('public.jejak_baca') IS NULL THEN
    ALTER TABLE favorites RENAME TO jejak_baca;
    ALTER TABLE jejak_baca RENAME COLUMN id_favorite TO id_jejak;
    ALTER TABLE jejak_baca RENAME CONSTRAINT favorites_user_buku_unique TO jejak_baca_user_buku_unique;
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS jejak_baca (
  id_jejak           SERIAL PRIMARY KEY,
  id_user            INTEGER NOT NULL REFERENCES users(id_user) ON DELETE CASCADE,
  id_buku            INTEGER NOT NULL REFERENCES buku(id_buku) ON DELETE CASCADE,
  waktu_ditambahkan  TIMESTAMP NOT NULL DEFAULT NOW(),
  status             VARCHAR(20) NOT NULL DEFAULT 'ingin_dibaca'
                     CHECK (status IN ('ingin_dibaca', 'sedang_dibaca', 'selesai')),

  CONSTRAINT jejak_baca_user_buku_unique UNIQUE (id_user, id_buku)
);

ALTER TABLE jejak_baca ADD COLUMN IF NOT EXISTS status VARCHAR(20) NOT NULL DEFAULT 'ingin_dibaca';

ALTER TABLE jejak_baca DROP CONSTRAINT IF EXISTS favorites_status_check;
ALTER TABLE jejak_baca DROP CONSTRAINT IF EXISTS jejak_baca_status_check;
ALTER TABLE jejak_baca ADD CONSTRAINT jejak_baca_status_check
  CHECK (status IN ('ingin_dibaca', 'sedang_dibaca', 'selesai'));

ALTER TABLE buku DROP COLUMN IF EXISTS rangkuman;
ALTER TABLE buku DROP COLUMN IF EXISTS isi;
