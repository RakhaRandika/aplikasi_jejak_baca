const express = require('express');
const pool = require('../db');
const { wajibLogin } = require('./auth');

const router = express.Router();

// Semua endpoint favorit wajib login; favorit disimpan per akun (req.user.id_user)
router.use(wajibLogin);

// GET /api/favorites -> favorit milik user yang login beserta data bukunya
router.get('/', async (req, res, next) => {
  try {
    const result = await pool.query(
      `SELECT f.id_favorite, f.id_buku, f.waktu_ditambahkan,
              b.judul, b.penulis, b.penerbit, b.tahun_terbit, b.deskripsi, b.cover_url
       FROM favorites f
       JOIN buku b ON b.id_buku = f.id_buku
       WHERE f.id_user = $1
       ORDER BY f.waktu_ditambahkan DESC`,
      [req.user.id_user]
    );
    res.json({ success: true, message: 'Daftar favorit', data: result.rows });
  } catch (err) {
    next(err);
  }
});

// POST /api/favorites  body: { "id_buku": 1 } -> tambah ke favorit
router.post('/', async (req, res, next) => {
  try {
    const id_buku = (req.body || {}).id_buku;
    if (!/^\d+$/.test(String(id_buku ?? ''))) {
      return res.status(400).json({ success: false, message: 'id_buku wajib diisi (angka)', data: null });
    }
    const result = await pool.query(
      'INSERT INTO favorites (id_user, id_buku) VALUES ($1, $2) RETURNING *',
      [req.user.id_user, id_buku]
    );
    res.status(201).json({ success: true, message: 'Buku ditambahkan ke favorit', data: result.rows[0] });
  } catch (err) {
    if (err.code === '23505') {
      return res.status(409).json({ success: false, message: 'Buku sudah ada di favorit', data: null });
    }
    if (err.code === '23503') {
      return res.status(404).json({ success: false, message: 'Buku tidak ditemukan', data: null });
    }
    next(err);
  }
});

// DELETE /api/favorites/:id -> hapus favorit berdasarkan id_favorite
router.delete('/:id', async (req, res, next) => {
  try {
    if (!/^\d+$/.test(req.params.id)) {
      return res.status(400).json({ success: false, message: 'id_favorite harus angka', data: null });
    }
    const result = await pool.query(
      'DELETE FROM favorites WHERE id_favorite = $1 AND id_user = $2 RETURNING *',
      [req.params.id, req.user.id_user]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, message: 'Favorit tidak ditemukan', data: null });
    }
    res.json({ success: true, message: 'Favorit berhasil dihapus', data: result.rows[0] });
  } catch (err) {
    next(err);
  }
});

// DELETE /api/favorites/buku/:id_buku -> hapus favorit berdasarkan id_buku (praktis untuk tombol hati di Android)
router.delete('/buku/:id_buku', async (req, res, next) => {
  try {
    if (!/^\d+$/.test(req.params.id_buku)) {
      return res.status(400).json({ success: false, message: 'id_buku harus angka', data: null });
    }
    const result = await pool.query(
      'DELETE FROM favorites WHERE id_buku = $1 AND id_user = $2 RETURNING *',
      [req.params.id_buku, req.user.id_user]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, message: 'Buku ini tidak ada di favorit', data: null });
    }
    res.json({ success: true, message: 'Favorit berhasil dihapus', data: result.rows[0] });
  } catch (err) {
    next(err);
  }
});

module.exports = router;
