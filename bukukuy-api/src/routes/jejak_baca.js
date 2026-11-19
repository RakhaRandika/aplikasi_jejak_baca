const express = require('express');
const pool = require('../db');
const { wajibLogin } = require('./auth');

const router = express.Router();

const STATUS = ['ingin_dibaca', 'sedang_dibaca', 'selesai'];

router.use(wajibLogin);

router.get('/', async (req, res, next) => {
  try {
    const result = await pool.query(
      `SELECT f.id_jejak, f.id_buku, f.waktu_ditambahkan, f.status,
              b.judul, b.penulis, b.penerbit, b.tahun_terbit, b.deskripsi, b.cover_url
       FROM jejak_baca f
       JOIN buku b ON b.id_buku = f.id_buku
       WHERE f.id_user = $1
       ORDER BY f.waktu_ditambahkan DESC`,
      [req.user.id_user]
    );
    res.json({ success: true, message: 'Daftar jejak baca', data: result.rows });
  } catch (err) {
    next(err);
  }
});

router.post('/', async (req, res, next) => {
  try {
    const { id_buku, status = 'ingin_dibaca' } = req.body || {};
    if (!/^\d+$/.test(String(id_buku ?? ''))) {
      return res.status(400).json({ success: false, message: 'id_buku wajib diisi (angka)', data: null });
    }
    if (!STATUS.includes(status)) {
      return res.status(400).json({ success: false, message: 'status harus ingin_dibaca, sedang_dibaca, atau selesai', data: null });
    }
    const result = await pool.query(
      'INSERT INTO jejak_baca (id_user, id_buku, status) VALUES ($1, $2, $3) RETURNING *',
      [req.user.id_user, id_buku, status]
    );
    res.status(201).json({ success: true, message: 'Buku ditambahkan ke jejak baca', data: result.rows[0] });
  } catch (err) {
    if (err.code === '23505') {
      return res.status(409).json({ success: false, message: 'Buku sudah ada di jejak baca', data: null });
    }
    if (err.code === '23503') {
      return res.status(404).json({ success: false, message: 'Buku tidak ditemukan', data: null });
    }
    next(err);
  }
});

router.delete('/:id', async (req, res, next) => {
  try {
    if (!/^\d+$/.test(req.params.id)) {
      return res.status(400).json({ success: false, message: 'id_jejak harus angka', data: null });
    }
    const result = await pool.query(
      'DELETE FROM jejak_baca WHERE id_jejak = $1 AND id_user = $2 RETURNING *',
      [req.params.id, req.user.id_user]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, message: 'Jejak baca tidak ditemukan', data: null });
    }
    res.json({ success: true, message: 'Buku dihapus dari jejak baca', data: result.rows[0] });
  } catch (err) {
    next(err);
  }
});

router.delete('/buku/:id_buku', async (req, res, next) => {
  try {
    if (!/^\d+$/.test(req.params.id_buku)) {
      return res.status(400).json({ success: false, message: 'id_buku harus angka', data: null });
    }
    const result = await pool.query(
      'DELETE FROM jejak_baca WHERE id_buku = $1 AND id_user = $2 RETURNING *',
      [req.params.id_buku, req.user.id_user]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, message: 'Buku ini tidak ada di jejak baca', data: null });
    }
    res.json({ success: true, message: 'Buku dihapus dari jejak baca', data: result.rows[0] });
  } catch (err) {
    next(err);
  }
});

router.patch('/buku/:id_buku', async (req, res, next) => {
  try {
    if (!/^\d+$/.test(req.params.id_buku)) {
      return res.status(400).json({ success: false, message: 'id_buku harus angka', data: null });
    }
    const { status } = req.body || {};
    if (!STATUS.includes(status)) {
      return res.status(400).json({ success: false, message: 'status harus ingin_dibaca, sedang_dibaca, atau selesai', data: null });
    }
    const result = await pool.query(
      'UPDATE jejak_baca SET status = $1 WHERE id_buku = $2 AND id_user = $3 RETURNING *',
      [status, req.params.id_buku, req.user.id_user]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, message: 'Buku ini tidak ada di jejak baca', data: null });
    }
    res.json({ success: true, message: 'Status baca berhasil diubah', data: result.rows[0] });
  } catch (err) {
    next(err);
  }
});

module.exports = router;
