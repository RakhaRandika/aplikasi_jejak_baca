const { Pool } = require('pg');
require('dotenv').config();

if (!process.env.DATABASE_URL) {
  console.error('ERROR: DATABASE_URL belum diisi di file .env');
  process.exit(1);
}

const useSSL = process.env.DB_SSL !== 'false';

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: useSSL ? { rejectUnauthorized: false } : false,
  keepAlive: true,
  idleTimeoutMillis: 0,
  connectionTimeoutMillis: 30000,
});

pool.on('error', (err) => {
  console.error('Koneksi database terputus:', err.message);
});

pool
  .query('SELECT 1')
  .then(() => console.log('Database terhubung'))
  .catch((err) => console.error('Database gagal terhubung:', err.message));

module.exports = pool;
