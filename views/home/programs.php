<?php if ($programs): ?>
<section class="section section-alt"><div class="container">
  <?php sec_head($s, 'Program', true); ?>
  <div class="grid g3">
  <?php foreach ($programs as $p): ?>
    <article class="card icon-card reveal"><div class="ico"><?= icon($p['icon'], 26) ?></div><h3><?= e($p['title']) ?> <?= demo_badge($p) ?></h3><p class="muted"><?= e($p['summary']) ?></p></article>
  <?php endforeach; ?>
  </div>
  <div class="sec-foot"><?= sec_link($s) ?></div>
</div></section>
<?php endif; ?>
