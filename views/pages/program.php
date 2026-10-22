<?php page_hero('Program Sekolah', 'PKL, magang, teaching factory, sertifikasi, dan program unggulan lainnya.', ['Program' => null], 'star'); ?>
<section class="section"><div class="container"><div class="grid g3">
<?php foreach ($rows as $p): ?><article class="card icon-card reveal"><div class="ico"><?= icon($p['icon'], 26) ?></div><h3><?= e($p['title']) ?> <?= demo_badge($p) ?></h3><p class="muted"><?= e($p['summary']) ?></p><p><?= nl2br(e($p['description'])) ?></p>
<?php if ($p['slug'] === 'pkl' || $p['slug'] === 'magang'): ?><a class="more" href="<?= e(url($p['slug'])) ?>">Selengkapnya <?= icon('arrow-right', 16) ?></a><?php endif; ?></article><?php endforeach; ?>
</div></div></section>
