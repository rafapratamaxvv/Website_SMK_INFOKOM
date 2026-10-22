<?php if ($stats): ?>
<section class="stats-wrap" aria-label="<?= e($s['title']) ?>"><div class="container"><div class="stats">
<?php foreach ($stats as $st): ?>
  <div class="stat reveal scale"><?= icon($st['icon'], 28) ?><b data-count="<?= (int)$st['value'] ?>" data-suffix="<?= e($st['suffix']) ?>">0</b><span><?= e($st['label']) ?></span></div>
<?php endforeach; ?>
</div></div></section>
<?php endif; ?>
