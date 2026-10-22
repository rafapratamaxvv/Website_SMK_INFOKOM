<?php page_hero($page['title'], (string)$page['excerpt'], ['Akademik' => null], 'book'); ?>
<section class="section"><div class="container">
  <div class="prose reveal"><?= $page['content'] ?></div>
  <h2 style="margin-top:2.5rem" class="reveal">Kompetensi Keahlian</h2>
  <div class="grid g4"><?php foreach ($majors as $m): ?><article class="card major-card icon-card reveal"><div class="major-code"><?= e($m['code']) ?></div><h3><a class="card-link" href="<?= e(url('jurusan/' . $m['slug'])) ?>"><?= e($m['name']) ?></a></h3></article><?php endforeach; ?></div>
  <p class="sec-foot"><a class="btn btn-primary" href="<?= e(url('akademik/kurikulum')) ?>">Kurikulum &amp; Dokumen <?= icon('arrow-right', 16) ?></a></p>
</div></section>
