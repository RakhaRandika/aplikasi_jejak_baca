# BukuKuy API

REST API buku untuk aplikasi BukuKuy. Dibuat dengan Node.js + Express, database Supabase (PostgreSQL).

## 1. Siapkan database di Supabase

1. Buka https://supabase.com → buat project baru (catat **password database**-nya).
2. Masuk menu **SQL Editor** → **New query**.
3. Copy seluruh isi `database/schema.sql` → paste → klik **Run**.
   Tabel `users`, `buku`, `favorites` dibuat + 4 data buku contoh.
   Mau data lebih banyak? Buka query baru, paste isi `database/seed_100_buku.sql` → **Run** (menambah 100 buku, total 104).
4. Klik tombol **Connect** di atas dashboard → pilih **Session pooler** → copy **URI**-nya.

## 2. Jalankan API

Butuh Node.js versi 18 ke atas.

```bash
cd bukukuy-api
npm install
cp .env.example .env      # Windows: copy .env.example .env
```

Buka `.env`, tempel URI dari Supabase ke `DATABASE_URL` dan ganti `[YOUR-PASSWORD]` dengan password database.

```bash
npm start
```

Cek di browser: http://localhost:3000/api/health → harus muncul `"Database terhubung"`.

## 3. Daftar endpoint

Semua respons berformat:

```json
{ "success": true, "message": "...", "data": ... }
```

### Buku

| Method | URL | Keterangan |
|---|---|---|
| GET | `/api/buku` | Semua buku |
| GET | `/api/buku?search=laskar` | Cari berdasarkan judul / penulis |
| GET | `/api/buku/:id` | Detail buku |
| POST | `/api/buku` | Tambah buku |
| PUT | `/api/buku/:id` | Ubah buku (kirim field yang mau diubah saja) |
| DELETE | `/api/buku/:id` | Hapus buku |

Body POST / PUT (JSON):

```json
{
  "judul": "Laskar Pelangi",
  "penulis": "Andrea Hirata",
  "penerbit": "Bentang Pustaka",
  "tahun_terbit": "2005",
  "deskripsi": "Kisah sepuluh anak dari Belitung..."
}
```

`judul` dan `penulis` wajib saat POST.

### Favorites

| Method | URL | Keterangan |
|---|---|---|
| GET | `/api/favorites` | Semua favorit + data bukunya |
| POST | `/api/favorites` | Tambah favorit, body: `{ "id_buku": 1 }` |
| DELETE | `/api/favorites/:id_favorite` | Hapus favorit berdasarkan id_favorite |
| DELETE | `/api/favorites/buku/:id_buku` | Hapus favorit berdasarkan id_buku |

Kode status: `200` OK, `201` berhasil dibuat, `400` input salah, `404` tidak ditemukan, `409` buku sudah difavoritkan, `500` error server.

## 4. Pakai dari aplikasi Android

- **Emulator Android**: base URL `http://10.0.2.2:3000/`
- **HP asli** (satu Wi-Fi dengan laptop): `http://IP-LAPTOP:3000/` (cek IP dengan `ipconfig` / `ifconfig`)

Karena masih `http` (bukan `https`), tambahkan di `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET" />
<application
    android:usesCleartextTraffic="true"
    ... >
```

Contoh Retrofit (Kotlin):

```kotlin
data class Buku(
    val id_buku: Int,
    val judul: String,
    val penulis: String,
    val penerbit: String?,
    val tahun_terbit: String?,
    val deskripsi: String?
)

data class ApiResponse<T>(val success: Boolean, val message: String, val data: T?)

interface BukuApi {
    @GET("api/buku") suspend fun getBuku(@Query("search") search: String? = null): ApiResponse<List<Buku>>
    @GET("api/buku/{id}") suspend fun getDetail(@Path("id") id: Int): ApiResponse<Buku>
    @POST("api/buku") suspend fun tambah(@Body buku: Map<String, String>): ApiResponse<Buku>
    @PUT("api/buku/{id}") suspend fun ubah(@Path("id") id: Int, @Body buku: Map<String, String>): ApiResponse<Buku>
    @DELETE("api/buku/{id}") suspend fun hapus(@Path("id") id: Int): ApiResponse<Buku>
}
```

## Struktur folder

```
bukukuy-api/
├── database/schema.sql    # SQL tabel + data contoh
├── src/
│   ├── index.js           # server Express
│   ├── db.js              # koneksi ke Supabase
│   └── routes/
│       ├── buku.js        # CRUD buku
│       └── favorites.js   # favorit
├── .env.example
└── package.json
```
