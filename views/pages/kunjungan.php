<?php page_hero($page['title'], (string)$page['excerpt'], ['Industri & Karier' => null, 'Kunjungan Industri' => null], 'factory'); ?>
<section class="section"><div class="container">
  <div class="split">
    <div class="reveal"><span class="eyebrow">Belajar Langsung di Industri</span><div class="prose"><?= $page['content'] ?></div>
      <div class="chips" style="margin:1rem 0 1.4rem"><span class="chip"><?= icon('check', 14) ?> Wawasan dunia kerja</span><span class="chip"><?= icon('check', 14) ?> Teknologi terkini</span><span class="chip"><?= icon('check', 14) ?> Jejaring profesional</span></div>
      <a class="btn btn-primary" href="<?= e(url('mitra')) ?>">Lihat Mitra Industri <?= icon('arrow-right', 16) ?></a></div>
    <div class="benefit-grid stagger">
      <?php foreach ([['Wawasan Industri', 'Melihat alur kerja dan standar profesional di perusahaan nyata.', 'factory'], ['Teknologi Terkini', 'Mengenal perangkat, sistem, dan tren teknologi yang dipakai industri.', 'cpu'], ['Relevansi Kurikulum', 'Mencocokkan kompetensi di kelas dengan kebutuhan dunia kerja.', 'book'], ['Jejaring Karier', 'Membuka peluang PKL, magang, dan rekrutmen lulusan.', 'handshake']] as $i => [$t, $d, $ic]): ?>
        <div class="benefit reveal" style="--i:<?= $i ?>"><span class="ico-lg" style="width:46px;height:46px;border-radius:14px"><?= icon($ic, 22) ?></span><div><h3><?= e($t) ?></h3><p><?= e($d) ?></p></div></div>
      <?php endforeach; ?>
    </div>
  </div>
</div></section>

<section class="section section-pattern"><div class="container">
  <header class="sec-head reveal"><span class="eyebrow">Kegiatan</span><h2>Jejak kunjungan industri kami</h2></header>
  <?php if ($years): ?><div class="chips reveal" style="margin-bottom:1.6rem">
    <a class="chip" href="<?= e(url('kunjungan-industri')) ?>" <?= !$year ? 'style="background:var(--primary);color:#fff"' : '' ?>>Semua</a>
    <?php foreach ($years as $y): ?><a class="chip" href="<?= e(url('kunjungan-industri?tahun=' . (int)$y)) ?>" <?= $year === (int)$y ? 'style="background:var(--primary);color:#fff"' : '' ?>><?= (int)$y ?></a><?php endforeach; ?>
  </div><?php endif; ?>
  <?php if (!$visits): ?>
    <div class="empty-state reveal"><?= icon('factory', 40) ?><h3 style="margin-top:.8rem">Belum ada kegiatan yang dipublikasikan</h3><p>Dokumentasi kunjungan industri akan tampil di sini setelah ditambahkan oleh admin.</p></div>
  <?php else: ?>
  <div class="visit-grid stagger">
    <?php foreach ($visits as $i => $v): $ts = strtotime((string)$v['visit_date']); ?>
    <article class="visit-card reveal" style="--i:<?= $i % 6 ?>">
      <div class="vimg"><?= img($v['image'] ?: null, $v['title'], '', true, asset('images/pkl.svg')) ?>
        <?php if ($ts): ?><div class="vdate"><?= date('d', $ts) ?><small><?= e(fmt_date((string)$v['visit_date'], 'M Y')) ?></small></div><?php endif; ?></div>
      <div class="vbody">
        <h3><?= e($v['title']) ?> <?= demo_badge($v) ?></h3>
        <div class="vmeta"><span><?= icon('building', 14) ?> <?= e($v['company']) ?></span><?php if ($v['location']): ?><span><?= icon('map-pin', 14) ?> <?= e($v['location']) ?></span><?php endif; ?><?php if ($v['major_code']): ?><span><?= icon('layers', 14) ?> <?= e($v['major_code']) ?></span><?php endif; ?><?php if ($v['participants']): ?><span><?= icon('users', 14) ?> <?= e($v['participants']) ?></span><?php endif; ?></div>
        <?php if ($v['description']): ?><p><?= e(mb_strimwidth((string)$v['description'], 0, 170, '…')) ?></p><?php endif; ?>
        <?php $learn = array_filter(array_map('trim', preg_split('/\R/', (string)$v['learnings']))); if ($learn): ?><div class="chips" style="margin-top:.3rem"><?php foreach (array_slice($learn, 0, 3) as $l): ?><span class="badge"><?= e($l) ?></span><?php endforeach; ?></div><?php endif; ?>
      </div>
    </article>
    <?php endforeach; ?>
  </div>
  <?php endif; ?>
</div></section>

<?php if ($albums): ?><section class="section"><div class="container"><header class="sec-head reveal"><span class="eyebrow">Galeri</span><h2>Dokumentasi kunjungan</h2></header>
  <div class="grid g4 stagger"><?php foreach ($albums as $i => $a): ?><article class="card reveal" style="--i:<?= $i ?>"><div class="card-img"><?= img($a['cover'], $a['title']) ?></div><div class="card-body"><h3><a class="card-link" href="<?= e(url('galeri')) ?>"><?= e($a['title']) ?></a></h3></div></article><?php endforeach; ?></div></div></section><?php endif; ?>

<section class="section" style="padding-top:0"><div class="container"><div class="cta-band reveal scale"><div><h3>Perusahaan Anda ingin menerima kunjungan siswa?</h3><p>Kami terbuka untuk kerja sama kunjungan industri, tamu industri, dan guru tamu.</p></div><a class="btn btn-accent" href="<?= e(url('kontak')) ?>">Hubungi Humas <?= icon('arrow-right', 16) ?></a></div></div></section>
