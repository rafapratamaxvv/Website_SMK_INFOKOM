# Website SMK Infokom Kota Bogor (PHP Native)

Website profil + CMS + PPDB online, dibuat dari nol dengan **PHP Native (PDO)** tanpa framework.
Jurusan: **TKJ, RPL, DKV, PSPT**.

## Requirement
- PHP **8.2+** (disarankan 8.4) dengan ekstensi: `pdo_mysql`, `mbstring`, `fileinfo`, `gd` (dengan dukungan WebP), `dom`
- MySQL 8+ / MariaDB 10.6+
- Apache dengan `mod_rewrite` dan `AllowOverride All` (Laragon sudah sesuai)
- Composer — **opsional**. Dompdf dan library QR sudah disertakan di folder `vendor/`.

## Instalasi di Laragon
1. Ekstrak ke `C:\laragon\www\smk-infokom-bogor`.
2. Jalankan Apache + MySQL di Laragon.
3. Buat database dan impor data: buka HeidiSQL/phpMyAdmin lalu impor **`database.sql`**
   (atau CLI: `mysql -uroot < database.sql`). Ini membuat database `smk_infokom_bogor` beserta tabel, data resmi, dan data demo.
4. Cek `.env` (salin dari `.env.example` bila belum ada):
   ```
   APP_ENV=production
   APP_DEBUG=false
   APP_URL=http://localhost/smk-infokom-bogor
   DB_HOST=127.0.0.1
   DB_PORT=3306
   DB_NAME=smk_infokom_bogor
   DB_USER=root
   DB_PASS=
   ```
   Jika memakai virtual host Laragon (mis. `http://smk-infokom-bogor.test`), isi `APP_URL` dengan URL tersebut.
5. Buka `http://localhost/smk-infokom-bogor`.

Tanpa Apache (hanya untuk development): `php -S localhost:8000 router.php`, lalu set `APP_URL=http://localhost:8000`.

## Akun admin awal
| Email | Password | Role |
|---|---|---|
| `admin@smkinfokom.local` | `smkinfkmbgr26` | Super Admin |

**Segera ganti password** di *Admin → Akun Saya* (akun ditandai wajib ganti password).
Login: `/admin/login`. Role: Super Admin, Admin, Editor (izin dapat diatur di *Roles*).

## Fitur utama
- Frontend dinamis dari database: Home (17 section yang dapat diaktifkan/diurutkan), Profil, Guru & Staff (cari/filter/paginasi/modal), Akademik, Jurusan (`/jurusan/tkj|rpl|dkv|pspt`), Program, PKL, Magang, Fasilitas, Prestasi, Alumni, Ekstrakurikuler, Organisasi, BKK, Karier, Mitra, Berita, Pengumuman, Galeri (lightbox), Video (YouTube), Agenda, PPDB, Kontak, pencarian global AJAX.
- Admin CMS: CRUD untuk seluruh modul, Homepage Customizer, Pengaturan Situs (logo, favicon, warna, kontak, WhatsApp, sosmed, footer, SEO), Navigation Manager (dropdown bertingkat), Media Library (WebP), Users/Roles/Permissions, Activity Log, Backup/Restore, Pesan Kontak.
- PPDB: gelombang, kuota per jurusan, validasi frontend + backend, nomor pendaftaran `PPDB-TAHUN-NNNN`, **bukti PDF (Dompdf) + QR verifikasi**, cetak, ekspor CSV, kelola status. Otomatis tutup bila saklar nonaktif, di luar periode, atau kuota jurusan penuh.
- SEO: title/description/canonical/Open Graph/Twitter Card per halaman, JSON-LD, `sitemap.xml`, `robots.txt`.


## Fitur tambahan (pembaruan)
- **Pintasan keyboard:** `Ctrl+Shift+L` (atau `Alt+Shift+A`) di website membuka halaman admin (langsung ke Dashboard jika sudah login). Di dalam admin, `Ctrl+Shift+L` kembali ke website. Tombol "Dashboard Admin" muncul di pojok kiri bawah website saat Anda login; tautan "Login Admin" ada di footer.
- **Formulir PPDB (PDF):** (1) *Formulir kosong* untuk diisi tangan: tombol "Unduh Formulir Kosong" di halaman PPDB (`/ppdb/formulir-kosong?unduh=1`, selalu tersedia walau PPDB ditutup); (2) *Formulir terisi*: setelah pendaftaran online dikirim, PDF langsung terunduh otomatis, dan dapat diunduh/dicetak lagi dari halaman sukses.
- **Chatbot:** widget di pojok kanan bawah semua halaman publik. Pengaturan di **Pengaturan Situs → Chatbot** (aktif/nonaktif, nama, pesan sambutan, dan *pengetahuan tambahan* format `pertanyaan | jawaban`, satu per baris). FAQ aktif di menu FAQ juga ikut dipakai.
  - *Mode standar (gratis, tanpa internet keluar):* memahami pertanyaan lalu menjawab langsung dari database website (PPDB, jadwal, kuota, biaya, jurusan, fasilitas, kontak, lowongan BKK, berita, dll.) disertai tombol tautan.
  - *Mode AI generatif (opsional):* pilih **Google Gemini** (disarankan) atau Anthropic Claude. Untuk Gemini: buat API key di https://aistudio.google.com/apikey, lalu isi `GEMINI_API_KEY=` (dan `GEMINI_MODEL=gemini-2.5-flash`, atau `gemini-2.5-flash-lite` yang lebih hemat) di file `.env`. Perubahan `.env` langsung berlaku tanpa restart. Indikator "Mode saat ini" tampil di **Pengaturan Situs → Chatbot**. AI hanya diberi data website sebagai konteks; bila gagal/timeout/limit, chatbot otomatis kembali ke mode standar. Sapaan/terima kasih tidak memanggil AI. Catatan: pada *free tier* Gemini, isi percakapan dapat dipakai Google untuk meningkatkan produknya, dan ada batas permintaan per menit/hari; pakai akun berbayar bila ingin data tidak dipakai untuk pelatihan.
- **Kategori Fasilitas bebas:** saat menambah/mengedit fasilitas, kolom Kategori dapat diketik sendiri (ada saran dari kategori yang sudah ada); filter di halaman Fasilitas ikut menyesuaikan.
- **Efek hover gambar:** tilt 3D, kilau cahaya, paralaks, dan kursor interaktif pada foto kepala sekolah, kartu, galeri, banner, dan gambar halaman. Otomatis nonaktif di layar sentuh dan jika pengguna memilih "kurangi animasi".

## Data resmi vs data demo
Data resmi diambil dari https://smkinfokom-bogor.sch.id/ (identitas, visi, misi, tujuan, sejarah singkat, kepala sekolah, kompetensi jurusan, kontak, peta, media sosial).
Data yang belum tersedia ditandai `is_demo = 1` dan tampil dengan label **DATA DEMO** / awalan `[DEMO]` (guru, mitra, prestasi, alumni, berita, galeri, jadwal PPDB, dll.).
- Filter *Semua / Resmi / Demo* tersedia di tiap daftar admin.
- Super Admin: **Dashboard → Hapus Semua Data Demo** (ketik `HAPUS DEMO`).
- Foto belum tersedia memakai placeholder/avatar generik — tidak ada foto orang nyata.
- Catatan: pada website resmi, jurusan ke-3 bernama "Multimedia"; di project ini sesuai ketentuan dipakai **DKV**, sehingga deskripsi/kompetensi DKV bersifat ringkasan yang perlu ditinjau & disempurnakan sekolah.

## Upload
Validasi ekstensi, MIME, file signature, ukuran, nama acak, pemindaian payload skrip, re-encode gambar (GD), dan eksekusi PHP dimatikan di `uploads/.htaccess`. Batas: foto 5 MB (PPDB 2 MB), dokumen PDF 10 MB (PPDB 3 MB).
Atur `upload_max_filesize` / `post_max_size` di `php.ini` minimal 12M bila perlu.

## PDF
Dompdf (folder `vendor/dompdf`) membuat bukti pendaftaran A4. Jika Dompdf tidak termuat, sistem menampilkan versi HTML siap cetak. Foto WebP tidak dirender di PDF (Dompdf) — unggahan PPDB sebaiknya JPG/PNG.

## Backup
*Admin → Backup* (Super Admin): buat, unduh, dan restore backup database (`storage/backups`, tidak dapat diakses publik). Restore hanya menerima file hasil backup fitur ini dan memvalidasi tiap perintah SQL. **Folder `uploads/` perlu dicadangkan terpisah.**

## Keamanan
`password_hash`/`password_verify`, session regeneration + timeout 30 menit, cookie HttpOnly/SameSite (Secure di HTTPS), CSRF di semua POST, rate limiting login (5 gagal/15 menit) dan form publik, PDO prepared statements, escaping output, sanitasi HTML CMS, header keamanan (CSP, X-Frame-Options, X-Content-Type-Options, Referrer-Policy, Permissions-Policy), otorisasi per endpoint (session → role → permission → CSRF → validasi; 403 bila tidak berhak), `display_errors` mati di produksi, folder internal diblokir lewat `.htaccess`.

## Deployment (produksi)
- Set `APP_DEBUG=false`, `APP_URL` ke domain HTTPS, kredensial DB khusus (bukan root).
- Arahkan document root ke folder project; pastikan `storage/` dan `uploads/` dapat ditulis oleh web server dan `mod_rewrite` aktif.
- Aktifkan HTTPS; setelah itu pertimbangkan menambah header HSTS di server.
- Ganti password admin awal dan hapus `router.php` jika tidak dipakai.

## Troubleshooting
| Gejala | Solusi |
|---|---|
| Halaman 404 untuk semua URL kecuali beranda | `mod_rewrite` / `AllowOverride All` belum aktif |
| "Database tidak dapat diakses" | Periksa `.env` dan pastikan `database.sql` sudah diimpor |
| Gambar/CSS tidak tampil, URL salah | Sesuaikan `APP_URL` di `.env` |
| Upload gagal | Naikkan `upload_max_filesize` dan `post_max_size`; pastikan `uploads/` writable |
| PDF kosong/error | Pastikan ekstensi `gd`, `mbstring`, `dom` aktif; cek `storage/logs/php-error.log` |
| Tidak bisa login (diblokir) | Tunggu 15 menit atau `DELETE FROM login_attempts;` |

## Struktur
`config/` (daftar modul CRUD) · `controllers/` · `core/` (Router, Database, Auth, Csrf, Upload, Validator, View) · `helpers/` · `middleware/` · `models/` · `routes/` · `views/` · `assets/` (css, js, images, icons) · `database/` + `database.sql` · `storage/` · `uploads/` · `vendor/`


## Pembaruan terbaru
- **Desain halaman dalam diperbarui** (`assets/css/pages.css`): hero bergradien dengan pola & ornamen animasi, sub-navigasi Profil, timeline Sejarah, kartu Visi & Misi / Tujuan, bagan Struktur Organisasi, halaman Kepala Sekolah, kartu Guru & Staff, alur PKL, Magang, BKK, dan Mitra.
- **Halaman baru: Kunjungan Industri** (`/kunjungan-industri`). Kelola dari **Admin → Kunjungan Industri**. Untuk database yang sudah berjalan, impor `database/migrasi-kunjungan-industri.sql` (aman dijalankan berulang). Instalasi baru cukup mengimpor `database.sql`.
- **Perbaikan error 500 saat unduh PDF.** Penyebab: ekstensi PHP **GD** belum aktif (Dompdf butuh GD untuk gambar PNG). Kini PDF tetap jadi walau GD nonaktif (QR dibuat sebagai tabel, gambar PNG dilewati, foto WebP dikonversi ke JPEG bila GD aktif), dan bila Dompdf gagal total sistem menampilkan versi siap-cetak, bukan error 500.
  - **Disarankan tetap mengaktifkan GD.** XAMPP: buka `php.ini` (Config → PHP), hapus tanda `;` di depan `extension=gd`, lalu restart Apache.


## Pembaruan 22 Okt 2026
Jalankan **`database/migrasi-2026-10-22.sql`** pada database yang sudah berjalan (aman diulang; data tidak dihapus kecuali baris organisasi MPK).

- **Galeri foto & video:** *Admin → Foto & Video Galeri* → pilih *Jenis media*: Foto, Video (unggah file MP4/WebM/MOV, maks 50 MB) atau Video (link YouTube / TikTok / Instagram). Video sosial dimuat saat diklik. Batas unggah server: naikkan `upload_max_filesize` dan `post_max_size` di php.ini bila perlu.
- **Magang:** *Admin → Dokumentasi Magang* untuk foto dan link video YouTube/Instagram; tampil di halaman Magang.
- **Formulir PPDB (PDF):** logo sekolah otomatis di kiri atas (dari Pengaturan Situs → logo, cadangan `assets/images/logo-smk-infokom.png`).
- **Cek Status PPDB:** `/ppdb/cek-status` (NISN + tanggal lahir). Status diatur admin di *Admin → Pendaftar PPDB*. Opsi *Otomatis tandai pendaftar baru sebagai DITERIMA* ada di *Pengaturan PPDB* (default mati).
- Label "DATA DEMO" / awalan "[DEMO]" tidak tampil lagi; datanya tetap ada.
