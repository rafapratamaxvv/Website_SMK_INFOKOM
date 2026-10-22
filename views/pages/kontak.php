<?php page_hero('Kontak', 'Hubungi kami untuk informasi sekolah dan PPDB.', ['Kontak' => null], 'phone'); ?>
<section class="section"><div class="container grid g2">
  <div class="reveal left"><h2>Informasi Kontak</h2>
    <ul class="contact-list" style="list-style:none;padding:0;display:grid;gap:1rem">
      <li><?= icon('map-pin', 22) ?> <span><?= e(setting('address')) ?></span></li>
      <li><?= icon('phone', 22) ?> <a href="tel:<?= e(preg_replace('/[^0-9+]/', '', setting('phone'))) ?>"><?= e(setting('phone')) ?></a></li>
      <li><?= icon('whatsapp', 22) ?> <a href="<?= e(wa_link('Halo SMK Infokom')) ?>" target="_blank" rel="noopener noreferrer">WhatsApp: <?= e(setting('whatsapp')) ?></a></li>
      <li><?= icon('mail', 22) ?> <a href="mailto:<?= e(setting('email')) ?>"><?= e(setting('email')) ?></a></li>
      <li><?= icon('clock', 22) ?> <span><?= e(setting('hours')) ?></span></li></ul>
    <?php if (setting('maps_embed')): ?><div class="card" style="margin-top:1.4rem;aspect-ratio:4/3"><iframe src="<?= e(setting('maps_embed')) ?>" title="Peta lokasi SMK Infokom" loading="lazy" referrerpolicy="no-referrer-when-downgrade" style="border:0;width:100%;height:100%"></iframe></div><?php endif; ?></div>
  <div class="form-card reveal right"><h2>Kirim Pesan</h2>
    <form class="form" method="post" action="<?= e(url('kontak')) ?>" data-ajax novalidate>
      <?= Csrf::field() ?>
      <div class="hp" aria-hidden="true"><label>Website <input type="text" name="website" tabindex="-1" autocomplete="off"></label></div>
      <div class="row2"><div class="field <?= isset($_SESSION['_errors']['name']) ? 'has-error' : '' ?>"><label for="c-name">Nama <span class="req">*</span></label><input id="c-name" name="name" required maxlength="100" value="<?= old('name') ?>"><?= field_error('name') ?></div>
      <div class="field <?= isset($_SESSION['_errors']['email']) ? 'has-error' : '' ?>"><label for="c-email">Email <span class="req">*</span></label><input id="c-email" type="email" name="email" required maxlength="150" value="<?= old('email') ?>"><?= field_error('email') ?></div></div>
      <div class="row2"><div class="field"><label for="c-phone">Telepon</label><input id="c-phone" name="phone" maxlength="20" value="<?= old('phone') ?>"><?= field_error('phone') ?></div>
      <div class="field"><label for="c-subject">Subjek <span class="req">*</span></label><input id="c-subject" name="subject" required maxlength="150" value="<?= old('subject') ?>"><?= field_error('subject') ?></div></div>
      <div class="field"><label for="c-msg">Pesan <span class="req">*</span></label><textarea id="c-msg" name="message" required minlength="10" maxlength="2000"><?= old('message') ?></textarea><?= field_error('message') ?></div>
      <button class="btn btn-primary" type="submit"><?= icon('mail', 18) ?> Kirim Pesan</button>
    </form><?php clear_old(); ?></div>
</div></section>
