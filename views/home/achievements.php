<?php if ($achievements): ?>
<section class="section"><div class="container">
  <?php sec_head($s, 'Prestasi', true); ?>
  <div class="grid g3">
  <?php foreach ($achievements as $a): ?>
    <article class="card reveal"><div class="card-img"><?= img($a['image'], $a['title']) ?></div><div class="card-body">
      <div class="card-meta"><span class="badge badge-gold"><?= e($a['rank_title']) ?></span><span><?= e($a['level']) ?></span><span><?= (int)$a['year'] ?></span><?php if ($a['major_code']): ?><span class="badge"><?= e($a['major_code']) ?></span><?php endif; ?></div>
      <h3><?= e($a['title']) ?> <?= demo_badge($a) ?></h3><p><?= e($a['competition']) ?></p></div></article>
  <?php endforeach; ?>
  </div>
  <div class="sec-foot"><?= sec_link($s) ?></div>
</div></section>
<?php endif; ?>
