<?php $title = $s['title'] ?: 'SMK Infokom Kota Bogor'; ?>
<section class="hero" aria-label="Hero">
  <div class="hero-bg <?= $s['image'] ? '' : 'is-pattern' ?>" data-parallax <?= $s['image'] ? 'style="background-image:url(\'' . e(upload_url($s['image'])) . '\')"' : '' ?>></div>
  <span class="deco d3" aria-hidden="true"></span>
  <div class="container hero-grid">
    <div class="hero-inner">
      <?php if ($s['badge']): ?><span class="hero-badge reveal"><?= e($s['badge']) ?></span><?php endif; ?>
      <?php if ($s['subtitle']): ?><div class="sub-title reveal"><?= e($s['subtitle']) ?></div><?php endif; ?>
      <h1 class="reveal-text"><?= e($title) ?></h1>
      <?php if ($s['content']): ?><p class="desc reveal"><?= e($s['content']) ?></p><?php endif; ?>
      <div class="hero-cta reveal">
        <?php if ($s['button_text']): ?><a class="btn btn-accent" href="<?= e(url($s['button_url'])) ?>"><?= e($s['button_text']) ?> <?= icon('arrow-right', 18) ?></a><?php endif; ?>
        <?php if ($s['button2_text']): ?><a class="btn btn-light" href="<?= e(url($s['button2_url'])) ?>"><?= e($s['button2_text']) ?></a><?php endif; ?>
      </div>
    </div>
    <div class="hero-visual reveal scale <?= setting('hero_visual') ? 'has-photo' : '' ?>" aria-hidden="true">
      <span class="hv-ring r1"></span><span class="hv-ring r2"></span>
      <?php if (setting('hero_visual')): ?>
      <div class="hv-photo"><img src="<?= e(upload_url(setting('hero_visual'))) ?>" alt="" width="420" height="520"></div>
      <?php else: ?>
      <div class="hv-logo"><?php if (setting('logo')): ?><img src="<?= e(upload_url(setting('logo'))) ?>" alt="" width="200" height="200"><?php else: ?><?= icon('cpu', 90) ?><?php endif; ?></div>
      <?php endif; ?>
      <?php foreach (array_slice($majors ?? [], 0, 4) as $i => $m): ?><span class="hv-chip c<?= $i + 1 ?>"><?= icon($m['icon'], 16) ?> <?= e($m['code']) ?></span><?php endforeach; ?>
    </div>
  </div>
</section>
