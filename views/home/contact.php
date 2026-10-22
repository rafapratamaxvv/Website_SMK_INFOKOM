<section class="section section-alt"><div class="container">
  <?php sec_head($s, 'Kontak', true); ?>
  <div class="grid g2">
    <div class="card icon-card reveal left"><ul class="contact-list" style="list-style:none;padding:0;display:grid;gap:1rem;margin:0">
      <li><?= icon('map-pin', 20) ?> <span><?= e(setting('address')) ?></span></li>
      <li><?= icon('phone', 20) ?> <a href="tel:<?= e(preg_replace('/[^0-9+]/', '', setting('phone'))) ?>"><?= e(setting('phone')) ?></a></li>
      <li><?= icon('whatsapp', 20) ?> <a href="<?= e(wa_link()) ?>" target="_blank" rel="noopener noreferrer">WhatsApp Humas: <?= e(setting('whatsapp')) ?></a></li>
      <li><?= icon('mail', 20) ?> <a href="mailto:<?= e(setting('email')) ?>"><?= e(setting('email')) ?></a></li>
      <li><?= icon('clock', 20) ?> <span><?= e(setting('hours')) ?></span></li></ul>
      <div style="margin-top:1.4rem"><?= sec_link($s) ?></div></div>
    <?php if (setting('maps_embed')): ?><div class="card reveal right" style="min-height:300px"><iframe src="<?= e(setting('maps_embed')) ?>" title="Peta lokasi sekolah" loading="lazy" referrerpolicy="no-referrer-when-downgrade" style="border:0;width:100%;height:100%;min-height:300px"></iframe></div><?php endif; ?>
  </div>
</div></section>
