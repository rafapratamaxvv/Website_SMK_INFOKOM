<?php page_hero('Galeri', 'Dokumentasi foto & video kegiatan SMK Infokom.', ['Informasi' => null, 'Galeri' => null], 'image');
$cats = ['Kegiatan', 'PKL', 'Magang', 'TKJ', 'RPL', 'DKV', 'PSPT', 'Fasilitas', 'Prestasi', 'OSIS', 'Event']; ?>
<section class="section"><div class="container">
  <div class="chips"><a class="chip <?= $cat === '' ? 'is-active' : '' ?>" href="<?= e(url('galeri')) ?>">Semua</a><?php foreach ($cats as $c): ?><a class="chip <?= $cat === $c ? 'is-active' : '' ?>" href="<?= e(url('galeri?kategori=' . rawurlencode($c))) ?>"><?= e($c) ?></a><?php endforeach; ?></div>
  <?php if (!$albums): ?><p class="muted">Belum ada album pada kategori ini.</p><?php endif; ?>
  <?php foreach ($albums as $a): ?>
    <section class="reveal" style="margin-bottom:2.5rem"><h2 style="font-size:1.4rem"><?= e($a['title']) ?> <?= demo_badge($a) ?> <span class="badge"><?= e($a['category']) ?></span></h2>
      <?php if ($a['description']): ?><p class="muted"><?= e($a['description']) ?></p><?php endif; ?>
      <?php if ($items[$a['id']]): ?><div class="masonry"><?php foreach ($items[$a['id']] as $it): ?><?= media_tile($it, $a['title'], 'album' . (int)$a['id']) ?><?php endforeach; ?></div>
      <?php else: ?><div class="card" style="max-width:340px"><div class="card-img"><?= img($a['cover'], $a['title']) ?></div></div><?php endif; ?></section>
  <?php endforeach; ?>
  <?= pager($pg, ['kategori' => $cat]) ?>
</div></section>
