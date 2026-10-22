<section class="section"><div class="container">
  <?php sec_head($s, 'Jurusan', true); ?>
  <div class="grid g4">
  <?php foreach ($majors as $m): ?>
    <article class="card major-card icon-card reveal">
      <?php if ($m['logo']): ?><div class="ico has-logo"><?= img($m['logo'], 'Logo ' . $m['code']) ?></div><?php else: ?><div class="ico"><?= icon($m['icon'], 26) ?></div><?php endif; ?>
      <div class="major-code"><?= e($m['code']) ?></div>
      <h3><a class="card-link" href="<?= e(url('jurusan/' . $m['slug'])) ?>"><?= e($m['name']) ?></a></h3>
      <p class="muted"><?= e($m['short_desc']) ?></p>
      <span class="more">Lihat jurusan <?= icon('arrow-right', 16) ?></span>
    </article>
  <?php endforeach; ?>
  </div>
  <div class="sec-foot"><?= sec_link($s) ?></div>
</div></section>
