<?php
declare(strict_types=1);

// ---------- Publik ----------
Router::get('/', [HomeController::class, 'index']);
Router::get('/profil', [PageController::class, 'profil']);
Router::get('/profil/guru-staff', [PageController::class, 'guruStaff']);
Router::get('/profil/kepala-sekolah', [PageController::class, 'kepalaSekolah']);
Router::get('/profil/{slug}', [PageController::class, 'profilPage']);
Router::get('/akademik', [PageController::class, 'akademik']);
Router::get('/akademik/kurikulum', [PageController::class, 'kurikulum']);
Router::get('/jurusan', [PageController::class, 'jurusanIndex']);
Router::get('/jurusan/{slug}', [PageController::class, 'jurusanShow']);
Router::get('/program', [PageController::class, 'program']);
Router::get('/pkl', [PageController::class, 'pkl']);
Router::get('/magang', [PageController::class, 'magang']);
Router::get('/kunjungan-industri', [PageController::class, 'kunjungan']);
Router::get('/fasilitas', [PageController::class, 'fasilitas']);
Router::get('/prestasi', [PageController::class, 'prestasi']);
Router::get('/alumni', [PageController::class, 'alumni']);
Router::get('/ekstrakurikuler', [PageController::class, 'ekskul']);
Router::get('/organisasi', [PageController::class, 'organisasi']);
Router::get('/bkk', [PageController::class, 'bkk']);
Router::get('/karier', [PageController::class, 'karier']);
Router::get('/mitra', [PageController::class, 'mitra']);
Router::get('/pengumuman', [PageController::class, 'pengumuman']);
Router::get('/galeri', [PageController::class, 'galeri']);
Router::get('/video', [PageController::class, 'video']);
Router::get('/agenda', [PageController::class, 'agenda']);
Router::get('/berita', [NewsController::class, 'index']);
Router::get('/berita/{slug}', [NewsController::class, 'show']);
Router::get('/cari', [SearchController::class, 'page']);
Router::post('/api/chat', [ChatController::class, 'ask'], ['RateMw:chat,40,10']);
Router::get('/api/search', [SearchController::class, 'api']);
Router::get('/kontak', [ContactController::class, 'show']);
Router::post('/kontak', [ContactController::class, 'send'], ['RateMw:contact,5,10']);
Router::get('/ppdb', [PpdbController::class, 'index']);
Router::post('/ppdb/daftar', [PpdbController::class, 'submit'], ['RateMw:ppdb,6,30']);
Router::get('/ppdb/formulir-kosong', [PpdbController::class, 'blankForm']);
Router::get('/ppdb/cek-status', [PpdbController::class, 'statusForm']);
Router::post('/ppdb/cek-status', [PpdbController::class, 'statusCheck'], ['RateMw:ppdb-status,15,10']);
Router::get('/ppdb/sukses/{token}', [PpdbController::class, 'success']);
Router::get('/ppdb/bukti/{token}', [PpdbController::class, 'receipt']);
Router::get('/ppdb/verifikasi/{token}', [PpdbController::class, 'verify']);
Router::get('/sitemap.xml', [SeoController::class, 'sitemap']);
Router::get('/robots.txt', [SeoController::class, 'robots']);

// ---------- Admin ----------
Router::get('/admin', fn() => redirect('admin/dashboard'));
Router::get('/admin/login', [AuthController::class, 'form']);
Router::post('/admin/login', [AuthController::class, 'login']);
Router::post('/admin/logout', [AuthController::class, 'logout'], ['AuthMw']);
Router::get('/admin/dashboard', [AdminController::class, 'dashboard'], ['AuthMw']);
Router::get('/admin/panduan-gambar', [AdminController::class, 'imageGuide'], ['AuthMw']);
Router::get('/admin/akun', [AdminController::class, 'account'], ['AuthMw']);
Router::post('/admin/akun', [AdminController::class, 'accountSave'], ['AuthMw']);

// Generic CRUD
Router::get('/admin/m/{module}', [CrudController::class, 'index'], ['AuthMw']);
Router::get('/admin/m/{module}/baru', [CrudController::class, 'form'], ['AuthMw']);
Router::get('/admin/m/{module}/{id}/edit', [CrudController::class, 'form'], ['AuthMw']);
Router::post('/admin/m/{module}/simpan', [CrudController::class, 'save'], ['AuthMw']);
Router::post('/admin/m/{module}/{id}/hapus', [CrudController::class, 'delete'], ['AuthMw']);
Router::post('/admin/m/{module}/{id}/toggle', [CrudController::class, 'toggle'], ['AuthMw']);

// Pengaturan
Router::get('/admin/settings', [SettingsController::class, 'form'], ['PermMw:settings.manage']);
Router::post('/admin/settings', [SettingsController::class, 'save'], ['PermMw:settings.manage']);
Router::get('/admin/homepage', [SettingsController::class, 'homepage'], ['PermMw:settings.manage']);
Router::post('/admin/homepage', [SettingsController::class, 'homepageSave'], ['PermMw:settings.manage']);
Router::post('/admin/homepage/urut', [SettingsController::class, 'homepageOrder'], ['PermMw:settings.manage']);

// Media
Router::get('/admin/media', [MediaController::class, 'index'], ['PermMw:media.manage']);
Router::post('/admin/media/upload', [MediaController::class, 'upload'], ['PermMw:media.manage']);
Router::post('/admin/media/{id}/rename', [MediaController::class, 'rename'], ['PermMw:media.manage']);
Router::post('/admin/media/{id}/hapus', [MediaController::class, 'delete'], ['PermMw:media.manage']);

// PPDB admin
Router::get('/admin/ppdb', [AdminPpdbController::class, 'index'], ['PermMw:ppdb.manage']);
Router::get('/admin/ppdb/{id}', [AdminPpdbController::class, 'show'], ['PermMw:ppdb.manage']);
Router::post('/admin/ppdb/{id}/status', [AdminPpdbController::class, 'status'], ['PermMw:ppdb.manage']);
Router::post('/admin/ppdb/{id}/hapus', [AdminPpdbController::class, 'delete'], ['PermMw:ppdb.manage']);
Router::get('/admin/ppdb-export', [AdminPpdbController::class, 'export'], ['PermMw:ppdb.manage']);
Router::post('/admin/ppdb-pengaturan', [AdminPpdbController::class, 'saveSettings'], ['PermMw:ppdb.manage']);

// Pesan
Router::get('/admin/pesan', [AdminController::class, 'messages'], ['PermMw:messages.manage']);
Router::post('/admin/pesan/{id}/hapus', [AdminController::class, 'messageDelete'], ['PermMw:messages.manage']);

// Users, logs, backup, demo (Super Admin)
Router::get('/admin/users', [UserController::class, 'index'], ['PermMw:users.manage']);
Router::get('/admin/users/baru', [UserController::class, 'form'], ['PermMw:users.manage']);
Router::get('/admin/users/{id}/edit', [UserController::class, 'form'], ['PermMw:users.manage']);
Router::post('/admin/users/simpan', [UserController::class, 'save'], ['PermMw:users.manage']);
Router::post('/admin/users/{id}/hapus', [UserController::class, 'delete'], ['PermMw:users.manage']);
Router::get('/admin/roles', [UserController::class, 'roles'], ['RoleMw:super_admin']);
Router::post('/admin/roles/simpan', [UserController::class, 'rolesSave'], ['RoleMw:super_admin']);
Router::get('/admin/logs', [AdminController::class, 'logs'], ['PermMw:logs.view']);
Router::get('/admin/backup', [BackupController::class, 'index'], ['RoleMw:super_admin']);
Router::post('/admin/backup/buat', [BackupController::class, 'create'], ['RoleMw:super_admin']);
Router::get('/admin/backup/unduh/{file}', [BackupController::class, 'download'], ['RoleMw:super_admin']);
Router::post('/admin/backup/restore', [BackupController::class, 'restore'], ['RoleMw:super_admin']);
Router::post('/admin/demo/hapus', [AdminController::class, 'deleteDemo'], ['RoleMw:super_admin']);
