<?php page_hero('Pencarian', $q !== '' ? 'Hasil untuk “' . $q . '”' : 'Cari informasi di website sekolah.', ['Pencarian' => null]); ?>
<section class="section"><div class="container" style="max-width:860px">
  <form class="search-bar" method="get" role="search"><input type="search" name="q" value="<?= e($q) ?>" placeholder="Kata kunci…" minlength="2" required aria-label="Kata kunci"><button class="btn btn-primary" type="submit"><?= icon('search', 18) ?> Cari</button></form>
  <?php if ($q !== '' && !$results): ?><p class="muted">Tidak ada hasil.</p><?php endif; ?>
  <?php foreach ($results as $r): ?><a class="sr-item card" style="margin-bottom:.7rem;padding:1rem 1.2rem" href="<?= e($r['url']) ?>"><span class="sr-type"><?= e($r['type']) ?></span><strong><?= e($r['title']) ?></strong><span class="muted"><?= e($r['desc']) ?></span></a><?php endforeach; ?>
</div></section>
