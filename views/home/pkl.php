<section class="section section-navy"><div class="container split">
  <div><?php sec_head($s); ?><p class="reveal"><?= e($s['content']) ?></p><div class="reveal"><a class="btn btn-accent" href="<?= e(url($s['button_url'])) ?>"><?= e($s['button_text']) ?> <?= icon('arrow-right', 16) ?></a></div></div>
  <ol class="steps reveal" style="grid-template-columns:1fr 1fr"><?php foreach (Database::all('SELECT title FROM pkl WHERE is_active=1 ORDER BY step_order LIMIT 4') as $st): ?><li style="color:var(--ink)"><h3><?= e($st['title']) ?></h3></li><?php endforeach; ?></ol>
</div></section>
