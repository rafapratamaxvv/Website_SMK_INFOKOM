<?php if ($news): ?>
<section class="section"><div class="container">
  <?php sec_head($s, 'Berita', true); ?>
  <div class="grid g3">
  <?php foreach ($news as $n): ?>
    <article class="card reveal"><div class="card-img"><?= img($n['image'], $n['title']) ?></div><div class="card-body">
      <div class="card-meta"><?php if ($n['category']): ?><span class="badge"><?= e($n['category']) ?></span><?php endif; ?><span><?= e(fmt_date($n['published_at'])) ?></span></div>
      <h3><a class="card-link" href="<?= e(url('berita/' . $n['slug'])) ?>"><?= e($n['title']) ?></a> <?= demo_badge($n) ?></h3><p><?= e($n['excerpt']) ?></p></div></article>
  <?php endforeach; ?>
  </div>
  <div class="sec-foot"><?= sec_link($s) ?></div>
</div></section>
<?php endif; ?>
