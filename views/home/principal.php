<section class="section section-alt"><div class="container split">
  <div class="principal-frame reveal"><div class="pf-photo"><?= img(setting('principal_photo') ?: null, setting('principal_name'), '', false, asset('images/avatar.svg')) ?></div></div>
  <div>
    <?php sec_head($s, 'Sambutan ' . setting('principal_title', 'Kepala Sekolah')); ?>
    <blockquote class="reveal" style="margin:0 0 1rem;font-size:1.08rem;border-left:4px solid var(--accent);padding-left:1.2rem"><?= e(mb_strimwidth(setting('principal_speech'), 0, 420, '…')) ?></blockquote>
    <p class="reveal"><strong><?= e(setting('principal_name')) ?></strong><br><span class="muted"><?= e(setting('principal_title')) ?></span></p>
    <div class="reveal"><?= sec_link($s) ?></div>
  </div>
</div></section>
