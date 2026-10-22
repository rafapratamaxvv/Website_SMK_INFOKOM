<?php page_hero('Praktik Kerja Lapangan (PKL)', (string)$page['excerpt'], ['Program' => 'program', 'PKL' => null], 'factory'); ?>
<section class="section"><div class="container">
  <div class="split">
    <div class="reveal"><span class="eyebrow">Belajar di Industri</span><div class="prose"><?= $page['content'] ?></div>
      <div class="chips" style="margin:1rem 0 1.4rem"><span class="chip"><?= icon('check', 14) ?> Pengalaman nyata</span><span class="chip"><?= icon('check', 14) ?> Etos kerja</span><span class="chip"><?= icon('check', 14) ?> Jaringan industri</span></div>
      <a class="btn btn-primary" href="<?= e(url('bkk')) ?>">Peluang Karier (BKK) <?= icon('arrow-right', 16) ?></a></div>
    <div class="about-media"><div class="frame img-reveal"><?= img($page['image'] ?: null, 'Siswa SMK Infokom menjalani PKL di industri', '', false, asset('images/pkl.svg')) ?></div></div>
  </div>
</div></section>
<?php if ($steps): ?><section class="section section-pattern"><div class="container">
  <header class="sec-head center reveal"><span class="eyebrow">Alur PKL</span><h2>Tahapan dari persiapan hingga evaluasi</h2></header>
  <ol class="flow stagger"><?php $ic = ['clipboard', 'handshake', 'map-pin', 'briefcase', 'check-square', 'award']; foreach ($steps as $i => $s): ?><li class="reveal" style="--i:<?= $i % 6 ?>"><span class="ico-lg"><?= icon($s['icon'] ?: $ic[$i % 6], 24) ?></span><h3><?= e($s['title']) ?> <?= demo_badge($s) ?></h3><p><?= e($s['description']) ?></p></li><?php endforeach; ?></ol>
</div></section><?php endif; ?>
<?php if ($companies): ?><section class="section"><div class="container"><header class="sec-head reveal"><span class="eyebrow">Mitra</span><h2>Industri tempat siswa PKL</h2></header><div class="logo-wall stagger"><?php foreach ($companies as $i => $c): ?><div class="logo-item reveal" style="--i:<?= $i % 8 ?>"><?= $c['logo'] ? img($c['logo'], $c['name']) : '<span>' . e($c['name']) . '</span>' ?></div><?php endforeach; ?></div></div></section><?php endif; ?>
<section class="section" style="padding-top:0"><div class="container"><div class="cta-band reveal scale"><div><h3>Ingin menjadi mitra PKL?</h3><p>Hubungi kami untuk bekerja sama membina calon talenta terbaik.</p></div><a class="btn btn-accent" href="<?= e(url('kontak')) ?>">Hubungi Kami <?= icon('arrow-right', 16) ?></a></div></div></section>
