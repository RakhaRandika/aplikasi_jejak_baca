const express = require('express');
const pool = require('../db');

const router = express.Router();

function validId(id) {
  return /^\d+$/.test(String(id));
}

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

// Endpoint tambah/ubah/hapus buku sengaja tidak disediakan: API ini publik dan app hanya
// menampilkan buku. Katalog dikelola lewat Supabase Dashboard (Table Editor).

module.exports = router;
