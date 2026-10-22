<section class="section"><div class="container"><div class="cta reveal">
  <div><h2><?= e($s['title']) ?></h2><p><?= e($s['content']) ?></p></div>
  <div class="hero-cta" style="margin:0"><a class="btn btn-accent" href="<?= e(url($s['button_url'])) ?>"><?= e($s['button_text']) ?> <?= icon('arrow-right', 16) ?></a><?php if ($s['button2_text']): ?><a class="btn btn-light" href="<?= e(url($s['button2_url'])) ?>"><?= e($s['button2_text']) ?></a><?php endif; ?></div>
</div></div></section>
