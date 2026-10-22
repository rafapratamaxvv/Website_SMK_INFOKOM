<?php page_hero('Magang', (string)$page['excerpt'], ['Program' => 'program', 'Magang' => null], 'briefcase');
$titles = ['informasi' => ['Informasi', 'book'], 'persyaratan' => ['Persyaratan', 'clipboard'], 'proses' => ['Proses', 'refresh'], 'timeline' => ['Timeline', 'calendar'], 'dokumentasi' => ['Dokumentasi', 'image']]; ?>
<section class="section"><div class="container">
  <div class="split">
    <div class="reveal"><span class="eyebrow">Pengalaman Kerja</span><div class="prose"><?= $page['content'] ?></div>
      <a class="btn btn-primary" href="<?= e(url('kontak')) ?>">Tanya Program Magang <?= icon('arrow-right', 16) ?></a></div>
    <div class="about-media"><div class="frame img-reveal"><?= img($page['image'] ?: null, 'Ilustrasi program magang siswa SMK Infokom', '', false, asset('images/magang.svg')) ?></div></div>
  </div>
</div></section>
<section class="section section-pattern"><div class="container">
  <header class="sec-head center reveal"><span class="eyebrow">Program Magang</span><h2>Yang perlu kamu ketahui</h2></header>
  <div class="info-tabs stagger"><?php $i = 0; foreach ($titles as $k => [$label, $ic]): if (empty($by[$k])) continue; ?>
    <article class="info-card reveal" style="--i:<?= $i++ ?>"><h3><span class="ico-lg" style="width:42px;height:42px;border-radius:12px"><?= icon($ic, 20) ?></span><?= e($label) ?></h3><?php foreach ($by[$k] as $it): ?><div class="it"><strong><?= e($it['title']) ?></strong> <?= demo_badge($it) ?><br><span class="muted"><?= nl2br(e($it['description'])) ?></span></div><?php endforeach; ?></article>
  <?php endforeach; ?></div>
</div></section>
<?php if ($companies): ?><section class="section"><div class="container"><header class="sec-head reveal"><span class="eyebrow">Mitra</span><h2>Mitra Magang</h2></header><div class="logo-wall stagger"><?php foreach ($companies as $i => $c): ?><div class="logo-item reveal" style="--i:<?= $i % 8 ?>"><?= $c['logo'] ? img($c['logo'], $c['name']) : '<span>' . e($c['name']) . '</span>' ?> <?= demo_badge($c) ?></div><?php endforeach; ?></div></div></section><?php endif; ?>
<?php if (!empty($media)): ?><section class="section section-alt"><div class="container">
  <header class="sec-head reveal"><span class="eyebrow">Foto &amp; Video</span><h2>Dokumentasi Magang</h2><p class="muted">Cuplikan kegiatan, keberangkatan, dan pengalaman peserta magang.</p></header>
  <div class="masonry"><?php foreach ($media as $m): ?><?= media_tile($m, 'Dokumentasi magang', 'magang') ?><?php endforeach; ?></div>
</div></section><?php endif; ?>
<?php if ($albums): ?><section class="section section-alt"><div class="container"><header class="sec-head reveal"><span class="eyebrow">Galeri</span><h2>Album Magang</h2></header><div class="grid g4 stagger"><?php foreach ($albums as $i => $a): ?><article class="card reveal" style="--i:<?= $i ?>"><div class="card-img"><?= img($a['cover'], $a['title']) ?></div><div class="card-body"><h3><?= e($a['title']) ?></h3></div></article><?php endforeach; ?></div></div></section><?php endif; ?>
