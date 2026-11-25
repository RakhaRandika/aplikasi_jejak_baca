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
app.use('/api/jejak-baca', require('./routes/jejak_baca'));

app.use((req, res) => {
  res.status(404).json({ success: false, message: 'Endpoint tidak ditemukan', data: null });
});

app.use((err, req, res, next) => {
  if (err.type === 'entity.parse.failed') {
    return res.status(400).json({ success: false, message: 'Format JSON tidak valid', data: null });
  }
  console.error(err);
  res.status(500).json({ success: false, message: 'Terjadi kesalahan server', data: null });
});

// Dijalankan langsung (npm start) → buka server di PORT.
// Di-import (Vercel serverless lewat api/index.js) → cukup ekspor app.
if (require.main === module) {
  const PORT = process.env.PORT || 3000;
  app.listen(PORT, '0.0.0.0', () => {
    console.log(`BukuKuy API berjalan di http://localhost:${PORT}`);
  });
}

module.exports = app;
