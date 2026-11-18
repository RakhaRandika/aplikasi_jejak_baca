ALTER TABLE favorites ADD COLUMN IF NOT EXISTS status VARCHAR(20) NOT NULL DEFAULT 'ingin_dibaca';

ALTER TABLE favorites DROP CONSTRAINT IF EXISTS favorites_status_check;
ALTER TABLE favorites ADD CONSTRAINT favorites_status_check
  CHECK (status IN ('ingin_dibaca', 'sedang_dibaca', 'selesai'));

-- Hapus kolom yang tidak dipakai lagi
ALTER TABLE buku DROP COLUMN IF EXISTS rangkuman;
ALTER TABLE buku DROP COLUMN IF EXISTS isi;
