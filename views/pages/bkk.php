<?php page_hero('BKK — Bursa Kerja Khusus', (string)$page['excerpt'], ['Industri & Karier' => null, 'BKK' => null], 'briefcase');
$kind = ['profil' => ['Profil BKK', 'building'], 'jobfair' => ['Job Fair', 'users'], 'rekrutmen' => ['Rekrutmen', 'handshake'], 'tracer' => ['Tracer Study', 'trending-up']]; ?>
<section class="section"><div class="container">
  <div class="split"><div class="reveal"><span class="eyebrow">Jembatan Karier</span><div class="prose"><?= $page['content'] ?></div>
    <div class="chips" style="margin-top:1rem"><a class="chip" href="#lowongan"><?= icon('briefcase', 14) ?> Lihat Lowongan</a><a class="chip" href="<?= e(url('mitra')) ?>"><?= icon('handshake', 14) ?> Mitra Industri</a><a class="chip" href="<?= e(url('alumni')) ?>"><?= icon('users', 14) ?> Alumni</a></div></div>
    <div class="benefit-grid stagger"><?php $i = 0; foreach ($kind as $k => [$l, $ic]): if (!array_filter($items, fn($x) => $x['kind'] === $k)) continue; ?><div class="benefit reveal" style="--i:<?= $i++ ?>"><span class="ico-lg" style="width:46px;height:46px;border-radius:14px"><?= icon($ic, 22) ?></span><div><h3><?= e($l) ?></h3><p><?= e(count(array_filter($items, fn($x) => $x['kind'] === $k))) ?> informasi</p></div></div><?php endforeach; ?></div></div>
</div></section>
<section class="section section-pattern"><div class="container">
  <header class="sec-head center reveal"><span class="eyebrow">Layanan BKK</span><h2>Informasi untuk lulusan &amp; industri</h2></header>
  <div class="grid g2 stagger"><?php foreach ($items as $i => $it): ?><article class="card icon-card reveal" style="--i:<?= $i % 6 ?>"><div style="display:flex;gap:.8rem;align-items:center;margin-bottom:.6rem"><span class="ico-lg" style="width:44px;height:44px;border-radius:13px"><?= icon(($kind[$it['kind']][1] ?? 'briefcase'), 20) ?></span><span class="badge"><?= e($kind[$it['kind']][0] ?? ucfirst($it['kind'])) ?></span></div><h3><?= e($it['title']) ?> <?= demo_badge($it) ?></h3><p class="muted"><?= nl2br(e($it['content'])) ?></p></article><?php endforeach; ?></div>
</div></section>
<section class="section"><div class="container"><header class="sec-head reveal" id="lowongan"><span class="eyebrow">Lowongan</span><h2>Peluang kerja terbaru</h2></header>
  <?php require BASE_PATH . '/views/pages/_jobs.php'; ?></div></section>
<?php if ($companies): ?><section class="section section-alt"><div class="container"><header class="sec-head reveal"><span class="eyebrow">Rekrutmen</span><h2>Perusahaan Rekrutmen</h2></header><div class="logo-wall stagger"><?php foreach ($companies as $i => $c): ?><div class="logo-item reveal" style="--i:<?= $i % 8 ?>"><?= $c['logo'] ? img($c['logo'], $c['name']) : '<span>' . e($c['name']) . '</span>' ?></div><?php endforeach; ?></div></div></section><?php endif; ?>
