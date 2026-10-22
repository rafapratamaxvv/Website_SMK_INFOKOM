<?php if ($facilities): ?>
<section class="section section-alt"><div class="container">
  <?php sec_head($s, 'Fasilitas', true); ?>
  <div class="grid g3">
  <?php foreach ($facilities as $f): ?>
    <article class="card reveal"><div class="card-img"><?= img($f['image'], $f['name']) ?></div><div class="card-body"><span class="badge"><?= e($f['category']) ?></span><h3><?= e($f['name']) ?> <?= demo_badge($f) ?></h3><p><?= e($f['description']) ?></p></div></article>
  <?php endforeach; ?>
  </div>
  <div class="sec-foot"><?= sec_link($s) ?></div>
</div></section>
<?php endif; ?>
