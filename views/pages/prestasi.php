<?php page_hero('Prestasi', 'Capaian siswa di berbagai kompetisi.', ['Kesiswaan' => null, 'Prestasi' => null], 'trophy'); ?>
<section class="section"><div class="container">
  <form class="search-bar" method="get">
    <select name="tahun" aria-label="Tahun"><option value="">Semua tahun</option><?php foreach ($years as $y): ?><option <?= (int)$y === $f['tahun'] ? 'selected' : '' ?>><?= (int)$y ?></option><?php endforeach; ?></select>
    <select name="jurusan" aria-label="Jurusan"><option value="">Semua jurusan</option><?php foreach ($majors as $m): ?><option value="<?= (int)$m['id'] ?>" <?= (int)$m['id'] === $f['jurusan'] ? 'selected' : '' ?>><?= e($m['code']) ?></option><?php endforeach; ?></select>
    <select name="kategori" aria-label="Kategori"><option value="">Semua kategori</option><?php foreach ($cats as $c): ?><option <?= $c === $f['kategori'] ? 'selected' : '' ?>><?= e($c) ?></option><?php endforeach; ?></select>
    <select name="tingkat" aria-label="Tingkat"><option value="">Semua tingkat</option><?php foreach (['Sekolah', 'Kecamatan', 'Kota', 'Provinsi', 'Nasional', 'Internasional'] as $t): ?><option <?= $t === $f['tingkat'] ? 'selected' : '' ?>><?= e($t) ?></option><?php endforeach; ?></select>
    <button class="btn btn-primary" type="submit"><?= icon('filter', 16) ?> Filter</button>
  </form>
  <?php if (!$rows): ?><p class="muted">Belum ada prestasi yang sesuai filter.</p><?php endif; ?>
  <div class="grid g3"><?php foreach ($rows as $a): ?>
    <article class="card reveal"><div class="card-img"><?= img($a['image'], $a['title']) ?></div><div class="card-body">
      <div class="card-meta"><span class="badge badge-gold"><?= e($a['rank_title']) ?></span><span><?= e($a['level']) ?></span><span><?= (int)$a['year'] ?></span><?php if ($a['major_code']): ?><span class="badge"><?= e($a['major_code']) ?></span><?php endif; ?></div>
      <h3><?= e($a['title']) ?> <?= demo_badge($a) ?></h3><p><strong><?= e($a['team']) ?></strong><br><?= e($a['competition']) ?></p><p><?= e($a['description']) ?></p>
      <?php if ($a['certificate']): ?><a class="more" href="<?= e(upload_url($a['certificate'])) ?>" target="_blank" rel="noopener"><?= icon('file', 16) ?> Sertifikat</a><?php endif; ?></div></article>
  <?php endforeach; ?></div>
  <?= pager($pg, array_filter($f)) ?>
</div></section>
