<?php page_hero('Fasilitas', 'Sarana belajar yang mendukung praktik kompetensi.', ['Fasilitas' => null], 'building');
$cats = array_values(array_unique(array_column($rows, 'category'))); ?>
<section class="section"><div class="container">
  <div class="chips" data-filter-group=".fac-item"><button type="button" class="chip is-active" data-filter="*">Semua</button><?php foreach ($cats as $c): ?><button type="button" class="chip" data-filter="<?= e($c) ?>"><?= e($c) ?></button><?php endforeach; ?></div>
  <div class="grid g3"><?php foreach ($rows as $f): ?>
    <article class="card fac-item reveal" data-cat="<?= e($f['category']) ?>"><div class="card-img" <?= $f['image'] ? 'data-lightbox="fac" data-caption="' . e($f['name']) . '" style="cursor:zoom-in"' : '' ?>><?= img($f['image'], $f['name']) ?></div><div class="card-body"><span class="badge"><?= e($f['category']) ?></span><h3><?= e($f['name']) ?> <?= demo_badge($f) ?></h3><p><?= e($f['description']) ?></p></div></article>
  <?php endforeach; ?></div>
</div></section>
