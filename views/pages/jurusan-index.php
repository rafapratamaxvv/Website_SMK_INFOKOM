<?php page_hero('Jurusan', 'Empat kompetensi keahlian untuk masa depan Anda.', ['Jurusan' => null], 'layers'); ?>
<section class="section"><div class="container"><div class="grid g2">
<?php foreach ($majors as $m): ?>
  <article class="card major-card reveal"><div class="card-img"><?= img($m['cover'], $m['name']) ?></div><div class="card-body">
    <div class="major-head"><?php if ($m['logo']): ?><span class="major-logo"><?= img($m['logo'], 'Logo ' . $m['code']) ?></span><?php endif; ?><div class="major-code"><?= e($m['code']) ?></div></div><h3><a class="card-link" href="<?= e(url('jurusan/' . $m['slug'])) ?>"><?= e($m['name']) ?></a></h3><p><?= e($m['short_desc']) ?></p>
    <ul class="checklist"><?php foreach (array_slice(lines($m['competencies']), 0, 3) as $c): ?><li><?= e($c) ?></li><?php endforeach; ?></ul>
    <span class="more">Selengkapnya <?= icon('arrow-right', 16) ?></span></div></article>
<?php endforeach; ?>
</div></div></section>
