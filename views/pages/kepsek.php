<?php page_hero('Kepala Sekolah', 'Sambutan Kepala Sekolah', ['Profil' => 'profil', 'Kepala Sekolah' => null], 'user-check'); profil_tabs('kepala-sekolah'); ?>
<section class="section"><div class="container kepsek-wrap">
  <aside class="kepsek-photo reveal">
    <div class="frame"><?= img(setting('principal_photo') ?: null, setting('principal_name'), '', false, asset('images/avatar.svg')) ?></div>
    <div class="kepsek-name"><h2><?= e(setting('principal_name')) ?></h2><p class="muted"><?= e(setting('principal_title')) ?></p></div>
  </aside>
  <div class="reveal">
    <span class="eyebrow">Sambutan</span>
    <div class="speech">
      <?php foreach (preg_split('/\R{2,}|\R/', (string)setting('principal_speech')) as $para): if (trim($para) === '') continue; ?><p><?= e($para) ?></p><?php endforeach; ?>
      <div class="sign"><?= e(setting('principal_name')) ?><small><?= e(setting('principal_title')) ?></small></div>
    </div>
  </div>
</div></section>
