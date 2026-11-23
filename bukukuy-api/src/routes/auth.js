const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const pool = require('../db');

const router = express.Router();

if (!process.env.JWT_SECRET) {
  console.error('ERROR: JWT_SECRET belum diisi di file .env');
  process.exit(1);
}

const TOKEN_EXPIRES_IN = '7d';

function buatToken(user) {
  return jwt.sign({ id_user: user.id_user }, process.env.JWT_SECRET, {
    expiresIn: TOKEN_EXPIRES_IN,
  });
}

function publicUser(user) {
  return { id_user: user.id_user, nama: user.nama, email: user.email };
}

function wajibLogin(req, res, next) {
  const [type, token] = (req.headers.authorization || '').split(' ');
  if (type !== 'Bearer' || !token) {
    return res.status(401).json({ success: false, message: 'Silakan login terlebih dahulu', data: null });
  }
  try {
    req.user = jwt.verify(token, process.env.JWT_SECRET);
    next();
  } catch (err) {
    res.status(401).json({ success: false, message: 'Sesi berakhir, silakan login ulang', data: null });
  }
}

router.post('/register', async (req, res, next) => {
  try {
    const nama = String((req.body || {}).nama ?? '').trim();
    const email = String((req.body || {}).email ?? '').trim().toLowerCase();
    const password = String((req.body || {}).password ?? '');

    if (!nama || !email || !password) {
      return res.status(400).json({ success: false, message: 'Nama, email, dan kata sandi wajib diisi', data: null });
    }
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
      return res.status(400).json({ success: false, message: 'Format email tidak valid', data: null });
    }
    if (password.length < 8) {
      return res.status(400).json({ success: false, message: 'Kata sandi minimal 8 karakter', data: null });
    }

    const hash = await bcrypt.hash(password, 10);
    const result = await pool.query(
      'INSERT INTO users (nama, email, password) VALUES ($1, $2, $3) RETURNING *',
      [nama, email, hash]
    );
    const user = result.rows[0];
    res.status(201).json({
      success: true,
      message: 'Akun berhasil dibuat',
      data: { token: buatToken(user), user: publicUser(user) },
    });
  } catch (err) {
    if (err.code === '23505') {
      return res.status(409).json({ success: false, message: 'Email sudah terdaftar', data: null });
    }
    next(err);
  }
});

router.post('/login', async (req, res, next) => {
  try {
    const email = String((req.body || {}).email ?? '').trim().toLowerCase();
    const password = String((req.body || {}).password ?? '');

    if (!email || !password) {
      return res.status(400).json({ success: false, message: 'Email dan kata sandi wajib diisi', data: null });
    }

    const result = await pool.query('SELECT * FROM users WHERE email = $1', [email]);
    const user = result.rows[0];
    if (!user) {
      return res.status(401).json({ success: false, message: 'Email belum terdaftar', data: null });
    }
    if (!(await bcrypt.compare(password, user.password))) {
      return res.status(401).json({ success: false, message: 'Kata sandi salah', data: null });
    }

    res.json({
      success: true,
      message: 'Login berhasil',
      data: { token: buatToken(user), user: publicUser(user) },
    });
  } catch (err) {
    next(err);
  }
});

router.get('/me', wajibLogin, async (req, res, next) => {
  try {
    const result = await pool.query('SELECT * FROM users WHERE id_user = $1', [req.user.id_user]);
    if (result.rows.length === 0) {
      return res.status(401).json({ success: false, message: 'Akun tidak ditemukan', data: null });
    }
    res.json({ success: true, message: 'Data user', data: publicUser(result.rows[0]) });
  } catch (err) {
    next(err);
  }
});

module.exports = router;
module.exports.wajibLogin = wajibLogin;
