<?php page_hero('Alumni', 'Jejak lulusan SMK Infokom di dunia kerja, kampus, dan wirausaha.', ['Kesiswaan' => null, 'Alumni' => null], 'users'); ?>
<section class="section"><div class="container"><div class="grid g3">
<?php foreach ($rows as $a): ?><article class="card portrait reveal"><div class="ph"><?= img($a['photo'], $a['name'], '', true, asset('images/avatar.svg')) ?></div><h3><?= e($a['name']) ?> <?= demo_badge($a) ?></h3>
  <p><?= $a['major_code'] ? e($a['major_code']) . ' · ' : '' ?>Lulus <?= (int)$a['grad_year'] ?></p>
  <p><?= e(trim(($a['job'] ?: '') . ($a['company'] ? ' — ' . $a['company'] : ''), ' —')) ?></p>
  <?php if ($a['college']): ?><p>Kuliah: <?= e($a['college']) ?></p><?php endif; ?><?php if ($a['entrepreneur']): ?><p>Wirausaha: <?= e($a['entrepreneur']) ?></p><?php endif; ?>
  <?php if ($a['testimonial']): ?><p style="margin-top:.6rem;font-style:italic">“<?= e($a['testimonial']) ?>”</p><?php endif; ?></article><?php endforeach; ?>
</div></div></section>
<?php if ($tracer): ?><section class="section section-alt"><div class="container"><h2 class="reveal"><?= e($tracer['title']) ?></h2><div class="prose reveal"><?= $tracer['content'] ?></div><p><a class="btn btn-primary" href="<?= e(wa_link('Halo Humas, saya alumni SMK Infokom dan ingin memperbarui data tracer.')) ?>" target="_blank" rel="noopener noreferrer">Perbarui data alumni</a></p></div></section><?php endif; ?>
