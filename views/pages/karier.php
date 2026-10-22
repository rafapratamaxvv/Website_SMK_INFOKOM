<?php page_hero('Karier', (string)$page['excerpt'], ['Industri & Karier' => null, 'Karier' => null], 'trending-up');
$skills = ['TKJ' => ['Instalasi & konfigurasi jaringan', 'Administrasi server', 'Keamanan jaringan'], 'RPL' => ['Pemrograman web & mobile', 'Basis data', 'Pengujian perangkat lunak'], 'DKV' => ['Desain grafis & branding', 'Ilustrasi & tipografi', 'Fotografi & video'], 'PSPT' => ['Produksi program TV', 'Kamera & penyuntingan', 'Penulisan naskah']]; ?>
<section class="section"><div class="container">
  <div class="prose reveal"><?= $page['content'] ?></div>
  <h2 style="margin-top:2.5rem">Career Path & Skill Industri</h2>
  <div class="grid g4"><?php foreach ($majors as $m): ?><article class="card major-card icon-card reveal"><div class="major-code"><?= e($m['code']) ?></div><h3>Jalur karier</h3><ul class="checklist"><?php foreach (lines($m['career']) as $c): ?><li><?= e($c) ?></li><?php endforeach; ?></ul><h3>Skill industri</h3><ul class="checklist"><?php foreach ($skills[$m['code']] ?? [] as $s): ?><li><?= e($s) ?></li><?php endforeach; ?></ul></article><?php endforeach; ?></div>
  <h2 id="lowongan" style="margin-top:2.5rem">Lowongan</h2>
  <?php require BASE_PATH . '/views/pages/_jobs.php'; ?>
</div></section>
<?php if ($alumni): ?><section class="section section-alt"><div class="container"><h2 class="reveal">Karier Alumni</h2><div class="grid g4"><?php foreach ($alumni as $a): ?><article class="card portrait reveal"><div class="ph"><?= img($a['photo'], $a['name'], '', true, asset('images/avatar.svg')) ?></div><h3><?= e($a['name']) ?> <?= demo_badge($a) ?></h3><p><?= e($a['job']) ?><?= $a['company'] ? ' — ' . e($a['company']) : '' ?></p></article><?php endforeach; ?></div></div></section><?php endif; ?>
<?php if ($companies): ?><section class="section"><div class="container"><h2 class="reveal">Recruitment Partner</h2><div class="grid g4"><?php foreach ($companies as $c): ?><div class="logo-item reveal" style="width:auto"><?= $c['logo'] ? img($c['logo'], $c['name']) : '<span>' . e($c['name']) . '</span>' ?></div><?php endforeach; ?></div></div></section><?php endif; ?>
