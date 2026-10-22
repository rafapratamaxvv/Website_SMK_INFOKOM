<?php
$u = Auth::user();
$path = '/' . trim(substr((string)parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH), strlen(base_path_url())), '/');
$mod = fn(string $k) => isset(modules()[$k]) && Auth::can(modules()[$k]['perm']);
$menu = [
  ['Utama', [['Dashboard', 'admin/dashboard', 'home', true], ['Akun Saya', 'admin/akun', 'users', true], ['Panduan Gambar', 'admin/panduan-gambar', 'image', true]]],
  ['Konten Sekolah', [
    ['Halaman Profil', 'admin/m/pages', 'book', $mod('pages')], ['Guru', 'admin/m/teachers', 'users', $mod('teachers')], ['Staff', 'admin/m/staff', 'user-check', $mod('staff')],
    ['Jurusan', 'admin/m/majors', 'layers', $mod('majors')], ['Mapel Jurusan', 'admin/m/major_subjects', 'clipboard', $mod('major_subjects')], ['Program', 'admin/m/programs', 'star', $mod('programs')],
    ['Kurikulum', 'admin/m/curriculum', 'book', $mod('curriculum')], ['Dokumen PDF', 'admin/m/documents', 'file', $mod('documents')], ['Fasilitas', 'admin/m/facilities', 'building', $mod('facilities')],
    ['Prestasi', 'admin/m/achievements', 'trophy', $mod('achievements')], ['Alumni', 'admin/m/alumni', 'users', $mod('alumni')], ['Organisasi', 'admin/m/organizations', 'users', $mod('organizations')],
    ['Ekstrakurikuler', 'admin/m/extracurriculars', 'star', $mod('extracurriculars')], ['Alur PKL', 'admin/m/pkl', 'check-square', $mod('pkl')], ['Magang', 'admin/m/internships', 'briefcase', $mod('internships')], ['Dokumentasi Magang', 'admin/m/internship_media', 'image', $mod('internship_media')], ['Kunjungan Industri', 'admin/m/industry_visits', 'factory', $mod('industry_visits')],
    ['BKK', 'admin/m/bkk', 'briefcase', $mod('bkk')], ['Lowongan', 'admin/m/jobs', 'briefcase', $mod('jobs')], ['Mitra', 'admin/m/companies', 'handshake', $mod('companies')], ['FAQ', 'admin/m/faq', 'inbox', $mod('faq')]]],
  ['Informasi', [['Berita', 'admin/m/news', 'newspaper', $mod('news')], ['Kategori Berita', 'admin/m/news_categories', 'newspaper', $mod('news_categories')], ['Pengumuman', 'admin/m/announcements', 'megaphone', $mod('announcements')], ['Agenda', 'admin/m/agenda', 'calendar', $mod('agenda')],
    ['Album Galeri', 'admin/m/galleries', 'image', $mod('galleries')], ['Foto & Video Galeri', 'admin/m/gallery_items', 'image', $mod('gallery_items')], ['Video', 'admin/m/videos', 'video', $mod('videos')], ['Media Library', 'admin/media', 'image', Auth::can('media.manage')]]],
  ['PPDB & Pesan', [['Pendaftar PPDB', 'admin/ppdb', 'clipboard', Auth::can('ppdb.manage')], ['Gelombang PPDB', 'admin/m/ppdb_periods', 'calendar', $mod('ppdb_periods')], ['Pesan Kontak', 'admin/pesan', 'mail', Auth::can('messages.manage')]]],
  ['Pengaturan', [['Pengaturan Situs', 'admin/settings', 'settings', Auth::can('settings.manage')], ['Homepage', 'admin/homepage', 'home', Auth::can('settings.manage')], ['Statistik', 'admin/m/school_statistics', 'trophy', $mod('school_statistics')], ['Navigasi', 'admin/m/navigation', 'layers', $mod('navigation')], ['SEO', 'admin/m/seo_metadata', 'search', $mod('seo_metadata')]]],
  ['Sistem', [['Users', 'admin/users', 'users', Auth::can('users.manage')], ['Roles', 'admin/roles', 'shield', ($u['role'] ?? '') === 'super_admin'], ['Activity Logs', 'admin/logs', 'eye', Auth::can('logs.view')], ['Backup', 'admin/backup', 'database', ($u['role'] ?? '') === 'super_admin']]],
];
?>
<!doctype html>
<html lang="id"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><meta name="robots" content="noindex,nofollow">
<title><?= e($title ?? 'Admin') ?> — Admin <?= e(setting('school_short', 'SMK Infokom')) ?></title>
<link rel="icon" href="<?= e(setting('favicon') ? upload_url(setting('favicon')) : asset('images/favicon.svg')) ?>">
<link rel="stylesheet" href="<?= e(asset('css/admin.css')) ?>"></head>
<body data-base="<?= e(rtrim(url(''), '/')) ?>">
<aside class="sidebar" id="sidebar"><div class="side-brand"><?php if (setting('logo')): ?><span class="brand-logo"><img src="<?= e(upload_url(setting('logo'))) ?>" alt="" width="40" height="40"></span><?php else: ?><span class="brand-mark"><?= icon('cpu', 22) ?></span><?php endif; ?><div><strong>Admin CMS</strong><small><?= e(setting('school_short')) ?></small></div></div>
<nav aria-label="Menu admin"><?php foreach ($menu as [$group, $items]): $vis = array_filter($items, fn($i) => $i[3]); if (!$vis) continue; ?>
  <div class="side-group"><?= e($group) ?></div>
  <?php foreach ($vis as [$label, $href, $ic]): $act = $path === '/' . $href || ($href !== 'admin/dashboard' && str_starts_with($path, '/' . $href . '/')) || ($href !== 'admin/dashboard' && $path === '/' . $href); ?>
    <a href="<?= e(url($href)) ?>" class="<?= $act ? 'is-active' : '' ?>"><?= icon($ic, 18) ?> <span><?= e($label) ?></span></a>
  <?php endforeach; endforeach; ?></nav></aside>
<div class="main">
  <header class="topbar"><button class="icon-btn" id="sideToggle" type="button" aria-label="Menu"><?= icon('layers', 22) ?></button><h1><?= e($title ?? '') ?></h1>
    <div class="top-right"><a class="btn btn-sm btn-outline" href="<?= e(url('/')) ?>" target="_blank" rel="noopener" title="Pintasan keyboard: Ctrl+Shift+L"><?= icon('external', 14) ?> Lihat Situs</a>
      <span class="who"><?= e($u['name'] ?? '') ?> <small><?= e($u['role'] ?? '') ?></small></span>
      <form method="post" action="<?= e(url('admin/logout')) ?>"><?= Csrf::field() ?><button class="btn btn-sm btn-primary" type="submit"><?= icon('log-out', 14) ?> Keluar</button></form></div></header>
  <div class="content"><?php if ($f = flash()): ?><div class="alert alert-<?= e($f['type']) ?>" role="alert"><?= e($f['msg']) ?></div><?php endif; ?>
  <?= $content ?></div>
</div>
<script src="<?= e(asset('js/admin.js')) ?>" defer></script>
</body></html>
