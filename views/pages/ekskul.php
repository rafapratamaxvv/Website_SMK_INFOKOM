<?php page_hero('Ekstrakurikuler', 'Kembangkan minat dan bakat di luar kelas.', ['Kesiswaan' => null, 'Ekstrakurikuler' => null], 'star'); ?>
<section class="section"><div class="container"><div class="grid g3">
<?php foreach ($rows as $x): ?><article class="card reveal"><div class="card-img"><?= img($x['image'] ?: $x['logo'], $x['name']) ?></div><div class="card-body"><h3><?= e($x['name']) ?> <?= demo_badge($x) ?></h3><p><?= e($x['description']) ?></p>
  <div class="card-meta"><?php if ($x['coach']): ?><span>Pembina: <?= e($x['coach']) ?></span><?php endif; ?><?php if ($x['schedule']): ?><span><?= icon('clock', 14) ?> <?= e($x['schedule']) ?></span><?php endif; ?><?php if ($x['place']): ?><span><?= icon('map-pin', 14) ?> <?= e($x['place']) ?></span><?php endif; ?></div>
  <?php if ($x['achievements']): ?><p><strong>Prestasi:</strong> <?= e($x['achievements']) ?></p><?php endif; ?></div></article><?php endforeach; ?>
</div></div></section>
