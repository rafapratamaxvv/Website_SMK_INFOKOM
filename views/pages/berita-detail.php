<?php page_hero($n['title'], '', ['Berita' => 'berita', 'Detail' => null]); $shareUrl = abs_url('berita/' . $n['slug']); ?>
<section class="section"><div class="container" style="max-width:860px">
  <div class="card-meta" style="margin-bottom:1rem"><?php if ($n['category']): ?><span class="badge"><?= e($n['category']) ?></span><?php endif; ?><span><?= icon('calendar', 14) ?> <?= e(fmt_date($n['published_at'], 'd F Y')) ?></span><span><?= icon('eye', 14) ?> <?= (int)$n['views'] + 1 ?>x dibaca</span><?= demo_badge($n) ?></div>
  <?php if ($n['image']): ?><div class="article-cover"><?= img($n['image'], $n['title'], '', false) ?></div><?php endif; ?>
  <div class="prose"><?= $n['content'] ?></div>
  <div class="share"><strong>Bagikan:</strong>
    <a class="btn btn-sm btn-outline" href="<?= e('https://wa.me/?text=' . rawurlencode($n['title'] . ' ' . $shareUrl)) ?>" target="_blank" rel="noopener noreferrer">WhatsApp</a>
    <a class="btn btn-sm btn-outline" href="<?= e('https://www.facebook.com/sharer/sharer.php?u=' . rawurlencode($shareUrl)) ?>" target="_blank" rel="noopener noreferrer">Facebook</a>
    <a class="btn btn-sm btn-outline" href="<?= e('https://twitter.com/intent/tweet?url=' . rawurlencode($shareUrl) . '&text=' . rawurlencode($n['title'])) ?>" target="_blank" rel="noopener noreferrer">X</a></div>
</div></section>
<?php if ($related): ?><section class="section section-alt"><div class="container"><h2>Berita terkait</h2><div class="grid g3"><?php foreach ($related as $r): ?><article class="card"><div class="card-img"><?= img($r['image'], $r['title']) ?></div><div class="card-body"><div class="card-meta"><?= e(fmt_date($r['published_at'])) ?></div><h3><a class="card-link" href="<?= e(url('berita/' . $r['slug'])) ?>"><?= e($r['title']) ?></a></h3></div></article><?php endforeach; ?></div></div></section><?php endif; ?>
