-- Tabel rak_baca dan aturan RLS untuk app yang memakai Supabase Auth.

BEGIN;

-- buku: hanya bisa dibaca
ALTER TABLE public.buku ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "buku dapat dibaca semua orang" ON public.buku;
CREATE POLICY "buku dapat dibaca semua orang" ON public.buku
  FOR SELECT TO anon, authenticated USING (true);
REVOKE INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER ON public.buku FROM anon, authenticated;
GRANT SELECT ON public.buku TO anon, authenticated;

-- tabel lama: ditutup dari app
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.jejak_baca ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON public.users FROM anon, authenticated;
REVOKE ALL ON public.jejak_baca FROM anon, authenticated;

-- rak_baca: rak bacaan per akun
CREATE TABLE IF NOT EXISTS public.rak_baca (
  id_rak             BIGSERIAL PRIMARY KEY,
  user_id            UUID NOT NULL DEFAULT auth.uid() REFERENCES auth.users(id) ON DELETE CASCADE,
  id_buku            INTEGER NOT NULL REFERENCES public.buku(id_buku) ON DELETE CASCADE,
  status             VARCHAR(20) NOT NULL DEFAULT 'ingin_dibaca'
                     CHECK (status IN ('ingin_dibaca', 'sedang_dibaca', 'selesai')),
  waktu_ditambahkan  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CONSTRAINT rak_baca_user_buku_unique UNIQUE (user_id, id_buku)
);

ALTER TABLE public.rak_baca ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "lihat rak sendiri" ON public.rak_baca;
DROP POLICY IF EXISTS "tambah ke rak sendiri" ON public.rak_baca;
DROP POLICY IF EXISTS "ubah rak sendiri" ON public.rak_baca;
DROP POLICY IF EXISTS "hapus dari rak sendiri" ON public.rak_baca;

CREATE POLICY "lihat rak sendiri" ON public.rak_baca
  FOR SELECT TO authenticated USING (user_id = (SELECT auth.uid()));
CREATE POLICY "tambah ke rak sendiri" ON public.rak_baca
  FOR INSERT TO authenticated WITH CHECK (user_id = (SELECT auth.uid()));
CREATE POLICY "ubah rak sendiri" ON public.rak_baca
  FOR UPDATE TO authenticated
  USING (user_id = (SELECT auth.uid())) WITH CHECK (user_id = (SELECT auth.uid()));
CREATE POLICY "hapus dari rak sendiri" ON public.rak_baca
  FOR DELETE TO authenticated USING (user_id = (SELECT auth.uid()));

REVOKE ALL ON public.rak_baca FROM anon, authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.rak_baca TO authenticated;
GRANT USAGE, SELECT ON SEQUENCE public.rak_baca_id_rak_seq TO authenticated;

CREATE INDEX IF NOT EXISTS rak_baca_user_idx ON public.rak_baca (user_id);

COMMIT;
