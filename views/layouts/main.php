<?php
$meta = $meta ?? [];
$siteName = setting('school_name', 'SMK INFOKOM KOTA BOGOR');
$seo = !empty($meta['key']) ? Site::seo($meta['key']) : null;
$title = ($seo['title'] ?? null) ?: (isset($meta['title']) ? $meta['title'] . ' — ' . $siteName : setting('seo_title', $siteName));
$desc = ($seo['description'] ?? null) ?: ($meta['description'] ?? setting('seo_description'));
$canonical = $meta['canonical'] ?? abs_url(ltrim(parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?: '', '/') === '' ? '' : substr((string)parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH), strlen(base_path_url()) + 1));
$img = !empty($meta['image']) ? abs_url($meta['image']) : (setting('logo') ? abs_url(setting('logo')) : abs_url('assets/images/og-default.svg'));
$cp = preg_match('/^#[0-9a-f]{6}$/i', setting('color_primary')) ? setting('color_primary') : '#0B4DA2';
$cn = preg_match('/^#[0-9a-f]{6}$/i', setting('color_navy')) ? setting('color_navy') : '#0A2A5E';
$ca = preg_match('/^#[0-9a-f]{6}$/i', setting('color_accent')) ? setting('color_accent') : '#F5B800';
$bar = Site::bar();
$chatOn = setting('chatbot_enabled', '1') === '1';
$nav = nav_tree();
$favicon = setting('favicon');
$path = '/' . trim(substr((string)parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH), strlen(base_path_url())), '/');
$isActive = fn(string $u) => $u !== '' && ($u === '/' ? $path === '/' : str_starts_with($path, '/' . trim(explode('#', $u)[0], '/')));
?>
<!doctype html>
<html lang="id">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><?= e($title) ?></title>
<meta name="description" content="<?= e($desc) ?>">
<?php if (!empty($meta['noindex'])): ?><meta name="robots" content="noindex,nofollow"><?php endif; ?>
<link rel="canonical" href="<?= e($canonical) ?>">
<meta property="og:type" content="<?= e($meta['type'] ?? 'website') ?>">
<meta property="og:site_name" content="<?= e($siteName) ?>">
<meta property="og:title" content="<?= e($title) ?>">
<meta property="og:description" content="<?= e($desc) ?>">
<meta property="og:url" content="<?= e($canonical) ?>">
<meta property="og:image" content="<?= e($img) ?>">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="<?= e($title) ?>">
<meta name="twitter:description" content="<?= e($desc) ?>">
<meta name="twitter:image" content="<?= e($img) ?>">
<meta name="theme-color" content="<?= e($cp) ?>">
<link rel="icon" href="<?= e($favicon ? upload_url($favicon) : asset('images/favicon.svg')) ?>">
<style>:root{--primary:<?= e($cp) ?>;--navy:<?= e($cn) ?>;--accent:<?= e($ca) ?>}</style>
<link rel="stylesheet" href="<?= e(asset('css/site.css')) ?>">
<link rel="stylesheet" href="<?= e(asset('css/pages.css')) ?>">
<?php if ($chatOn): ?><link rel="stylesheet" href="<?= e(asset('css/chat.css')) ?>"><?php endif; ?>
<script type="application/ld+json"><?= json_encode(['@context' => 'https://schema.org', '@type' => 'EducationalOrganization', 'name' => $siteName, 'url' => abs_url(''), 'telephone' => setting('phone'), 'email' => setting('email'), 'address' => ['@type' => 'PostalAddress', 'streetAddress' => setting('address'), 'addressLocality' => 'Kota Bogor', 'addressRegion' => 'Jawa Barat', 'addressCountry' => 'ID']], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_HEX_TAG) ?></script>
</head>
<body class="is-loading" data-base="<?= e(rtrim(url(''), '/')) ?>" data-csrf="<?= e(Csrf::token()) ?>">
<div id="loader" class="loader" aria-hidden="true">
  <div class="loader-logo"><?php if (setting('logo')): ?><img src="<?= e(upload_url(setting('logo'))) ?>" alt="" width="104" height="104"><?php else: ?><?= icon('cpu', 48) ?><?php endif; ?></div>
  <strong class="loader-name"><?= e(setting('school_name', 'SMK INFOKOM KOTA BOGOR')) ?></strong>
  <div class="loader-bar"><i></i></div>
</div>
<a class="skip" href="#main">Lewati ke konten</a>

<?php if ($bar): ?>
<div class="announce"><div class="container"><?= icon('megaphone', 16) ?> <span><?= e($bar['title']) ?></span><?php if ($bar['link']): ?> <a href="<?= e(url($bar['link'])) ?>">Selengkapnya <?= icon('arrow-right', 14) ?></a><?php endif; ?></div></div>
<?php endif; ?>

<header class="site-header" id="siteHeader">
<div class="container header-row">
  <a class="brand" href="<?= e(url('/')) ?>" aria-label="<?= e($siteName) ?>">
    <?php if (setting('logo')): ?><img src="<?= e(upload_url(setting('logo'))) ?>" alt="" width="44" height="44"><?php else: ?><span class="brand-mark"><?= icon('cpu', 26) ?></span><?php endif; ?>
    <span class="brand-text"><strong><?= e(setting('school_short', 'SMK Infokom')) ?></strong><small>Kota Bogor</small></span>
  </a>
  <nav class="main-nav" aria-label="Navigasi utama">
    <ul>
    <?php foreach ($nav as $item): $hasKids = !empty($item['children']); $href = $item['url'] !== '' ? url($item['url']) : '#'; ?>
      <li class="<?= $hasKids ? 'has-sub' : '' ?> <?= ($isActive($item['url']) || array_filter($item['children'], fn($c) => $isActive($c['url']))) ? 'is-current' : '' ?>">
        <?php if ($hasKids): ?>
          <button type="button" class="nav-link" aria-expanded="false"><?= e($item['name']) ?> <?= icon('chevron-down', 14) ?></button>
          <div class="sub"><ul>
          <?php foreach ($item['children'] as $c): ?>
            <li><a href="<?= e(url($c['url'])) ?>" <?= $c['target'] === '_blank' ? 'target="_blank" rel="noopener noreferrer"' : '' ?>><?= e($c['name']) ?></a></li>
          <?php endforeach; ?>
          </ul></div>
        <?php else: ?>
          <a class="nav-link <?= $item['name'] === 'PPDB' ? 'nav-cta' : '' ?>" href="<?= e($href) ?>" <?= $item['target'] === '_blank' ? 'target="_blank" rel="noopener noreferrer"' : '' ?>><?= e($item['name']) ?></a>
        <?php endif; ?>
      </li>
    <?php endforeach; ?>
    </ul>
  </nav>
  <div class="header-tools">
    <button class="icon-btn" id="searchOpen" type="button" aria-label="Cari"><?= icon('search', 20) ?></button>
    <button class="icon-btn menu-btn" id="menuBtn" type="button" aria-label="Menu" aria-expanded="false" aria-controls="mobileNav"><span></span><span></span><span></span></button>
  </div>
</div>
<nav class="mobile-nav" id="mobileNav" aria-label="Navigasi mobile" hidden>
  <ul>
  <?php foreach ($nav as $item): ?>
    <?php if (!empty($item['children'])): ?>
      <li class="m-acc"><button type="button" aria-expanded="false"><?= e($item['name']) ?> <?= icon('chevron-down', 16) ?></button>
        <ul><?php foreach ($item['children'] as $c): ?><li><a href="<?= e(url($c['url'])) ?>"><?= e($c['name']) ?></a></li><?php endforeach; ?></ul></li>
    <?php else: ?>
      <li><a href="<?= e($item['url'] !== '' ? url($item['url']) : '#') ?>"><?= e($item['name']) ?></a></li>
    <?php endif; ?>
  <?php endforeach; ?>
  </ul>
</nav>
</header>

<div class="search-modal" id="searchModal" role="dialog" aria-modal="true" aria-label="Pencarian" hidden>
  <div class="search-box">
    <form action="<?= e(url('cari')) ?>" method="get" role="search" id="searchForm">
      <?= icon('search', 22) ?><input type="search" name="q" id="searchInput" placeholder="Cari berita, jurusan, guru, prestasi…" autocomplete="off" minlength="2" required>
      <button type="button" class="icon-btn" id="searchClose" aria-label="Tutup"><?= icon('x', 20) ?></button>
    </form>
    <div id="searchResults" class="search-results" aria-live="polite"></div>
  </div>
</div>

<main id="main"><?php if ($f = flash()): ?><div class="container"><div class="alert alert-<?= e($f['type']) ?>" role="alert"><?= e($f['msg']) ?></div></div><?php endif; ?>
<?= $content ?>
</main>

<footer class="site-footer">
  <div class="container footer-grid">
    <div>
      <a class="brand brand-light" href="<?= e(url('/')) ?>"><?php if (setting('logo')): ?><span class="brand-logo"><img src="<?= e(upload_url(setting('logo'))) ?>" alt="" width="48" height="48"></span><?php else: ?><span class="brand-mark"><?= icon('cpu', 24) ?></span><?php endif; ?><span class="brand-text"><strong><?= e($siteName) ?></strong></span></a>
      <p><?= e(setting('footer_text')) ?></p>
      <div class="social">
        <?php foreach (['instagram', 'youtube', 'facebook'] as $s): if (setting($s)): ?><a href="<?= e(setting($s)) ?>" target="_blank" rel="noopener noreferrer" aria-label="<?= e(ucfirst($s)) ?>"><?= icon($s, 20) ?></a><?php endif; endforeach; ?>
        <?php if (setting('tiktok')): ?><a href="<?= e(setting('tiktok')) ?>" target="_blank" rel="noopener noreferrer" aria-label="TikTok"><?= icon('video', 20) ?></a><?php endif; ?>
      </div>
    </div>
    <div><h3>Jurusan</h3><ul><?php foreach (Site::majors() as $m): ?><li><a href="<?= e(url('jurusan/' . $m['slug'])) ?>"><?= e($m['code']) ?> — <?= e($m['name']) ?></a></li><?php endforeach; ?></ul></div>
    <div><h3>Tautan</h3><ul>
      <li><a href="<?= e(url('profil/tentang-sekolah')) ?>">Tentang Sekolah</a></li><li><a href="<?= e(url('ppdb')) ?>">PPDB</a></li><li><a href="<?= e(url('berita')) ?>">Berita</a></li><li><a href="<?= e(url('bkk')) ?>">BKK</a></li><li><a href="<?= e(url('galeri')) ?>">Galeri</a></li><li><a href="<?= e(url('kontak')) ?>">Kontak</a></li></ul></div>
    <div><h3>Kontak</h3><ul class="contact-list">
      <li><?= icon('map-pin', 16) ?> <span><?= e(setting('address')) ?></span></li>
      <li><?= icon('phone', 16) ?> <a href="tel:<?= e(preg_replace('/[^0-9+]/', '', setting('phone'))) ?>"><?= e(setting('phone')) ?></a></li>
      <li><?= icon('mail', 16) ?> <a href="mailto:<?= e(setting('email')) ?>"><?= e(setting('email')) ?></a></li>
      <li><?= icon('clock', 16) ?> <span><?= e(setting('hours')) ?></span></li></ul></div>
  </div>
  <div class="container footer-bottom"><span>© <?= date('Y') ?> <?= e($siteName) ?>. Hak cipta dilindungi.</span><span><?= e(setting('tagline')) ?></span><a class="admin-link" href="<?= e(url('admin/login')) ?>" title="Pintasan keyboard: Ctrl+Shift+L"><?= icon('shield', 14) ?> Login Admin <kbd>Ctrl+Shift+L</kbd></a></div>
</footer>

<?php if ($chatOn): ?><div id="chatbot-root" data-endpoint="<?= e(url('api/chat')) ?>" data-name="<?= e(setting('chatbot_name', 'Asisten Infokom')) ?>" data-greeting="<?= e(setting('chatbot_greeting', 'Halo! Saya asisten virtual ' . setting('school_short', 'SMK Infokom') . '. Silakan tanya seputar PPDB, jurusan, fasilitas, kontak, atau lowongan kerja.')) ?>" data-logo="<?= e(setting('logo') ? upload_url(setting('logo')) : '') ?>"></div><?php endif; ?>
<?php if (!empty($_SESSION['uid']) && Auth::check()): ?><a class="admin-pill" href="<?= e(url('admin/dashboard')) ?>" title="Pintasan keyboard: Ctrl+Shift+L"><?= icon('settings', 16) ?> Dashboard Admin</a><?php endif; ?>
<a class="wa-float" href="<?= e(wa_link('Halo SMK Infokom, saya ingin bertanya.')) ?>" target="_blank" rel="noopener noreferrer" aria-label="Chat WhatsApp"><?= icon('whatsapp', 28) ?></a>
<button class="to-top" id="toTop" type="button" aria-label="Kembali ke atas"><?= icon('arrow-up', 20) ?></button>
<div class="toast-wrap" id="toasts" aria-live="polite"></div>
<div class="lightbox" id="lightbox" role="dialog" aria-modal="true" aria-label="Pratinjau gambar" hidden><button class="lb-close" type="button" aria-label="Tutup"><?= icon('x', 24) ?></button><button class="lb-nav lb-prev" type="button" aria-label="Sebelumnya"><?= icon('chevron-left', 28) ?></button><figure><img alt="" src=""><figcaption></figcaption></figure><button class="lb-nav lb-next" type="button" aria-label="Berikutnya"><?= icon('chevron-right', 28) ?></button></div>
<?php if ($chatOn): ?><script src="<?= e(asset('js/chat.js')) ?>" defer></script><?php endif; ?>
<script src="<?= e(asset('js/app.js')) ?>" defer></script>
</body>
</html>
