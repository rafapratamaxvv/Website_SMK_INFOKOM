<?php page_hero('Pengumuman', 'Informasi resmi dari sekolah.', ['Informasi' => null, 'Pengumuman' => null], 'megaphone'); ?>
<section class="section"><div class="container" style="max-width:900px">
<?php if (!$rows): ?><p class="muted">Belum ada pengumuman.</p><?php endif; ?>
<?php foreach ($rows as $a): ?><article class="card icon-card reveal" style="margin-bottom:1rem"><div class="card-meta"><?= icon('megaphone', 16) ?> <?= e(fmt_date($a['created_at'])) ?></div><h3><?= e($a['title']) ?> <?= demo_badge($a) ?></h3><p><?= nl2br(e($a['body'])) ?></p><?php if ($a['link']): ?><a class="more" href="<?= e(url($a['link'])) ?>">Buka tautan <?= icon('arrow-right', 16) ?></a><?php endif; ?></article><?php endforeach; ?>
</div></section>
