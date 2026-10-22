<?php if ($gallery || $albums): ?>
<section class="section section-alt"><div class="container">
  <?php sec_head($s, 'Galeri', true); ?>
  <?php if ($gallery): ?>
  <div class="masonry">
    <?php foreach ($gallery as $g): ?><?= media_tile($g, (string)$g['album'], 'home') ?><?php endforeach; ?>
  </div>
  <?php else: ?>
  <div class="grid g4"><?php foreach ($albums as $a): ?><article class="card reveal"><div class="card-img"><?= img($a['cover'], $a['title']) ?></div><div class="card-body"><span class="badge"><?= e($a['category']) ?></span><h3><?= e($a['title']) ?> <?= demo_badge($a) ?></h3></div></article><?php endforeach; ?></div>
  <?php endif; ?>
  <div class="sec-foot"><?= sec_link($s) ?></div>
</div></section>
<?php endif; ?>
