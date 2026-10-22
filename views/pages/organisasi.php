<?php page_hero('Organisasi Siswa', 'OSIS dan organisasi siswa lainnya.', ['Kesiswaan' => null, 'Organisasi' => null], 'users'); ?>
<section class="section"><div class="container">
  <?php if ($struktur): ?><div class="prose reveal"><h2>Struktur Organisasi Sekolah</h2><?= $struktur['content'] ?></div><?php endif; ?>
  <div class="grid g2" style="margin-top:2rem"><?php foreach ($rows as $o): ?><article class="card icon-card reveal"><div class="ico"><?= icon('users', 24) ?></div><span class="badge"><?= e($o['type']) ?></span><h3><?= e($o['name']) ?> <?= demo_badge($o) ?></h3><p><?= e($o['description']) ?></p>
    <?php if ($o['leaders']): ?><p><strong>Pengurus:</strong><br><?= nl2br(e($o['leaders'])) ?></p><?php endif; ?><?php if ($o['work_programs']): ?><p><strong>Program kerja:</strong><br><?= nl2br(e($o['work_programs'])) ?></p><?php endif; ?></article><?php endforeach; ?></div>
</div></section>
