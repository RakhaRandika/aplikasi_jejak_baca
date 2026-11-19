-- Mengubah tabel lama favorites menjadi jejak_baca (data tetap) lalu memastikan kolom status ada.
-- Aman dijalankan berulang kali.
DO $$
BEGIN
  IF to_regclass('public.favorites') IS NOT NULL
     AND to_regclass('public.jejak_baca') IS NULL THEN
    ALTER TABLE favorites RENAME TO jejak_baca;
    ALTER TABLE jejak_baca RENAME COLUMN id_favorite TO id_jejak;
    ALTER TABLE jejak_baca RENAME CONSTRAINT favorites_user_buku_unique TO jejak_baca_user_buku_unique;
  END IF;
END $$;

ALTER TABLE jejak_baca ADD COLUMN IF NOT EXISTS status VARCHAR(20) NOT NULL DEFAULT 'ingin_dibaca';

ALTER TABLE jejak_baca DROP CONSTRAINT IF EXISTS favorites_status_check;
ALTER TABLE jejak_baca DROP CONSTRAINT IF EXISTS jejak_baca_status_check;
ALTER TABLE jejak_baca ADD CONSTRAINT jejak_baca_status_check
  CHECK (status IN ('ingin_dibaca', 'sedang_dibaca', 'selesai'));

-- Hapus kolom yang tidak dipakai lagi
ALTER TABLE buku DROP COLUMN IF EXISTS rangkuman;
ALTER TABLE buku DROP COLUMN IF EXISTS isi;
