<?php if ($companies): $loop = array_merge($companies, $companies); ?>
<section class="section section-alt"><div class="container"><?php sec_head($s, 'Mitra', true); ?></div>
  <div class="marquee reveal" aria-label="Logo mitra industri"><div class="marquee-track">
  <?php foreach ($loop as $i => $c): ?>
    <div class="logo-item" <?= $i >= count($companies) ? 'aria-hidden="true"' : '' ?>><?= $c['logo'] ? img($c['logo'], $c['name']) : '<span>' . e($c['name']) . '</span>' ?></div>
  <?php endforeach; ?>
  </div></div>
  <div class="container sec-foot"><?= sec_link($s) ?></div>
</section>
<?php endif; ?>
