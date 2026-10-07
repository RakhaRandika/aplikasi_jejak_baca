require('dotenv').config();
const express = require('express');
const cors = require('cors');
const pool = require('./db');

const app = express();

app.use(cors());
app.use(express.json());

app.get('/', (req, res) => {
  res.json({ success: true, message: 'BukuKuy API berjalan', data: null });
});

// Cek koneksi ke Supabase
app.get('/api/health', async (req, res) => {
  try {
    await pool.query('SELECT 1');
    res.json({ success: true, message: 'Database terhubung', data: null });
  } catch (err) {
    res.status(500).json({ success: false, message: 'Database gagal terhubung: ' + err.message, data: null });
  }
});

app.use('/api/auth', require('./routes/auth'));
app.use('/api/buku', require('./routes/buku'));
app.use('/api/favorites', require('./routes/favorites'));

// 404
app.use((req, res) => {
  res.status(404).json({ success: false, message: 'Endpoint tidak ditemukan', data: null });
});

// Error handler
app.use((err, req, res, next) => {
  if (err.type === 'entity.parse.failed') {
    return res.status(400).json({ success: false, message: 'Format JSON tidak valid', data: null });
  }
  console.error(err);
  res.status(500).json({ success: false, message: 'Terjadi kesalahan server', data: null });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, '0.0.0.0', () => {
  console.log(`BukuKuy API berjalan di http://localhost:${PORT}`);
});
