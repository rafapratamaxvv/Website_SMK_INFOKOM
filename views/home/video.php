<?php if ($videos): ?>
<section class="section"><div class="container">
  <?php sec_head($s, 'Video', true); ?>
  <div class="grid g3"><?php foreach ($videos as $v): $yt = youtube_id($v['youtube_url']); if (!$yt) continue; ?>
    <article class="card video-card reveal"><div class="vid"><button type="button" data-yt="<?= e($yt) ?>" aria-label="Putar: <?= e($v['title']) ?>" style="background-image:url('https://i.ytimg.com/vi/<?= e($yt) ?>/hqdefault.jpg')"><span class="play"><?= icon('video', 28) ?></span></button></div><div class="card-body"><h3><?= e($v['title']) ?> <?= demo_badge($v) ?></h3></div></article>
  <?php endforeach; ?></div>
  <div class="sec-foot"><?= sec_link($s) ?></div>
</div></section>
<?php endif; ?>
