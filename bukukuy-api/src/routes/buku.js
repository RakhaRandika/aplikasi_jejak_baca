const express = require('express');
const pool = require('../db');

const router = express.Router();

const FIELDS = ['judul', 'penulis', 'penerbit', 'tahun_terbit', 'deskripsi', 'cover_url'];

function validId(id) {
  return /^\d+$/.test(String(id));
}

// GET /api/buku?search=kata  -> semua buku (bisa dicari berdasarkan judul/penulis)
router.get('/', async (req, res, next) => {
  try {
    const search = (req.query.search || '').trim();
    let result;
    if (search) {
      result = await pool.query(
        `SELECT * FROM buku
         WHERE judul ILIKE $1 OR penulis ILIKE $1
         ORDER BY id_buku ASC`,
        [`%${search}%`]
      );
    } else {
      result = await pool.query('SELECT * FROM buku ORDER BY id_buku ASC');
    }
    res.json({ success: true, message: 'Daftar buku', data: result.rows });
  } catch (err) {
    next(err);
  }
});

// GET /api/buku/:id -> detail satu buku
router.get('/:id', async (req, res, next) => {
  try {
    if (!validId(req.params.id)) {
      return res.status(400).json({ success: false, message: 'id_buku harus angka', data: null });
    }
    const result = await pool.query('SELECT * FROM buku WHERE id_buku = $1', [req.params.id]);
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, message: 'Buku tidak ditemukan', data: null });
    }
    res.json({ success: true, message: 'Detail buku', data: result.rows[0] });
  } catch (err) {
    next(err);
  }
});

// POST /api/buku -> tambah buku
router.post('/', async (req, res, next) => {
  try {
    const { judul, penulis, penerbit, tahun_terbit, deskripsi, cover_url } = req.body || {};
    if (!judul || !penulis) {
      return res.status(400).json({ success: false, message: 'judul dan penulis wajib diisi', data: null });
    }
    const result = await pool.query(
      `INSERT INTO buku (judul, penulis, penerbit, tahun_terbit, deskripsi, cover_url)
       VALUES ($1, $2, $3, $4, $5, $6)
       RETURNING *`,
      [judul, penulis, penerbit || null, tahun_terbit != null ? String(tahun_terbit) : null, deskripsi || null, cover_url || null]
    );
    res.status(201).json({ success: true, message: 'Buku berhasil ditambahkan', data: result.rows[0] });
  } catch (err) {
    next(err);
  }
});

// PUT /api/buku/:id -> ubah buku (kirim field yang mau diubah saja)
router.put('/:id', async (req, res, next) => {
  try {
    if (!validId(req.params.id)) {
      return res.status(400).json({ success: false, message: 'id_buku harus angka', data: null });
    }
    const body = req.body || {};
    const sets = [];
    const values = [];
    for (const f of FIELDS) {
      if (body[f] !== undefined) {
        values.push(f === 'tahun_terbit' && body[f] != null ? String(body[f]) : body[f]);
        sets.push(`${f} = $${values.length}`);
      }
    }
    if (sets.length === 0) {
      return res.status(400).json({ success: false, message: 'Tidak ada data yang diubah', data: null });
    }
    values.push(req.params.id);
    const result = await pool.query(
      `UPDATE buku SET ${sets.join(', ')} WHERE id_buku = $${values.length} RETURNING *`,
      values
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, message: 'Buku tidak ditemukan', data: null });
    }
    res.json({ success: true, message: 'Buku berhasil diubah', data: result.rows[0] });
  } catch (err) {
    next(err);
  }
});

// DELETE /api/buku/:id -> hapus buku
router.delete('/:id', async (req, res, next) => {
  try {
    if (!validId(req.params.id)) {
      return res.status(400).json({ success: false, message: 'id_buku harus angka', data: null });
    }
    const result = await pool.query('DELETE FROM buku WHERE id_buku = $1 RETURNING *', [req.params.id]);
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, message: 'Buku tidak ditemukan', data: null });
    }
    res.json({ success: true, message: 'Buku berhasil dihapus', data: result.rows[0] });
  } catch (err) {
    next(err);
  }
});

module.exports = router;
