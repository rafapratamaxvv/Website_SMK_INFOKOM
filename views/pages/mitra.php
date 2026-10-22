<?php page_hero('Mitra & Kerja Sama', 'Dunia usaha dan industri yang bekerja sama dengan SMK Infokom.', ['Industri & Karier' => null, 'Mitra' => null], 'handshake');
$unis = array_values(array_filter($rows, fn($c) => $c['industry'] === 'Kerjasama Universitas'));
$rows = array_values(array_filter($rows, fn($c) => $c['industry'] !== 'Kerjasama Universitas'));
$loop = $rows ? array_merge($rows, $rows) : [];
$cnt = ['PKL' => 'is_pkl', 'Magang' => 'is_magang', 'Rekrutmen' => 'is_recruit', 'Teaching Factory' => 'is_tefa']; ?>
<?php if ($rows): ?><section class="section" style="padding-bottom:1.5rem"><div class="container"><div class="stat-tiles stagger" style="margin-top:0">
  <div class="stat-tile reveal"><b><?= count($rows) ?></b><span>Mitra industri</span></div>
  <?php $i = 1; foreach ($cnt as $l => $col): ?><div class="stat-tile reveal" style="--i:<?= $i++ ?>"><b><?= count(array_filter($rows, fn($r) => !empty($r[$col]))) ?></b><span>Mitra <?= e($l) ?></span></div><?php endforeach; ?>
</div></div></section>
<section class="section" style="padding-block:1.5rem"><div class="marquee" aria-label="Logo mitra"><div class="marquee-track"><?php foreach ($loop as $i => $c): ?><div class="logo-item" <?= $i >= count($rows) ? 'aria-hidden="true"' : '' ?>><?= $c['logo'] ? img($c['logo'], $c['name']) : '<span>' . e($c['name']) . '</span>' ?></div><?php endforeach; ?></div></div></section><?php endif; ?>
<?php if ($unis): ?><section class="section"><div class="container"><header class="sec-head center reveal"><span class="eyebrow">Kerjasama Universitas</span><h2>Jalur lanjut ke perguruan tinggi</h2><p class="muted">Kerja sama akademik bagi lulusan yang ingin melanjutkan kuliah.</p></header>
<div class="logo-wall stagger"><?php foreach ($unis as $i => $c): ?><div class="partner-card reveal" style="--i:<?= $i % 8 ?>;align-items:center;text-align:center"><div class="logo-item"><?= $c['logo'] ? img($c['logo'], $c['name']) : '<span>' . e($c['name']) . '</span>' ?></div><strong style="font-size:.9rem"><?= e($c['name']) ?></strong></div><?php endforeach; ?></div></div></section><?php endif; ?>
<section class="section section-pattern"><div class="container">
  <header class="sec-head center reveal"><span class="eyebrow">Daftar Mitra</span><h2>Bersama membangun talenta vokasi</h2></header>
  <div class="grid g3 stagger">
<?php foreach ($rows as $i => $c): ?><article class="partner-card reveal" style="--i:<?= $i % 6 ?>"><div class="logo-item"><?= $c['logo'] ? img($c['logo'], $c['name']) : '<span>' . e($c['name']) . '</span>' ?></div><h3><?= e($c['name']) ?> <?= demo_badge($c) ?></h3><p class="muted" style="margin:0"><?= e((string)$c['industry']) ?><?= $c['location'] ? ' · ' . e($c['location']) : '' ?></p><p style="margin:0"><?= e((string)$c['cooperation']) ?></p>
  <div class="card-meta"><?php foreach (['is_pkl' => 'PKL', 'is_magang' => 'Magang', 'is_recruit' => 'Rekrutmen', 'is_tefa' => 'Teaching Factory'] as $k => $l) if ($c[$k]) echo '<span class="badge">' . e($l) . '</span>'; ?><?php if ($c['since_year']): ?><span>Sejak <?= (int)$c['since_year'] ?></span><?php endif; ?></div>
  <?php if ($c['website']): ?><a class="more" href="<?= e($c['website']) ?>" target="_blank" rel="noopener noreferrer">Website <?= icon('external', 14) ?></a><?php endif; ?></article><?php endforeach; ?>
  </div>
  <div class="cta-band reveal scale" style="margin-top:3rem"><div><h3>Jadilah mitra SMK Infokom</h3><p>PKL, magang, rekrutmen, kunjungan industri, hingga teaching factory.</p></div><a class="btn btn-accent" href="<?= e(url('kontak')) ?>">Ajukan Kerja Sama <?= icon('arrow-right', 16) ?></a></div>
</div></section>
