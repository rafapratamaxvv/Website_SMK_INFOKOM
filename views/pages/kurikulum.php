<?php page_hero('Kurikulum', 'Kurikulum, kalender akademik, UKK, sertifikasi, dan dokumen.', ['Akademik' => 'akademik', 'Kurikulum' => null], 'clipboard'); ?>
<section class="section"><div class="container">
  <div class="prose reveal"><?= $page['content'] ?></div>
  <div class="accordion reveal" style="margin-top:1.5rem;max-width:860px">
  <?php foreach ($items as $i): ?><details><summary><span><?= e($i['title']) ?> <?= demo_badge($i) ?></span></summary><div class="a"><?= nl2br(e($i['content'])) ?></div></details><?php endforeach; ?>
  </div>
  <h2 style="margin-top:2.5rem">Dokumen</h2>
  <?php if (!$docs): ?><p class="muted">Belum ada dokumen.</p><?php endif; ?>
  <div class="grid g3"><?php foreach ($docs as $d): ?>
    <article class="card icon-card reveal"><div class="ico"><?= icon('file', 24) ?></div><h3><?= e($d['title']) ?> <?= demo_badge($d) ?></h3><span class="badge"><?= e($d['category']) ?></span>
      <?php if ($d['file_path']): ?><p style="margin-top:1rem;display:flex;gap:.5rem;flex-wrap:wrap"><a class="btn btn-sm btn-outline" href="<?= e(upload_url($d['file_path'])) ?>" target="_blank" rel="noopener">Pratinjau</a><a class="btn btn-sm btn-primary" href="<?= e(upload_url($d['file_path'])) ?>" download><?= icon('download', 16) ?> Unduh</a></p><?php else: ?><p class="muted" style="margin-top:1rem">File belum diunggah.</p><?php endif; ?></article>
  <?php endforeach; ?></div>
</div></section>
