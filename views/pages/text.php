<?php
$slug = (string)$page['slug'];
$heroIcons = ['tentang-sekolah' => 'building', 'sejarah' => 'clock', 'visi-misi' => 'eye', 'tujuan' => 'check-square', 'struktur-organisasi' => 'users'];
$isProfil = isset($heroIcons[$slug]);
page_hero($page['title'], (string)$page['excerpt'], $isProfil ? ['Profil' => 'profil', $page['title'] => null] : [$page['title'] => null], $heroIcons[$slug] ?? 'book');
if ($isProfil) profil_tabs($slug);
$secs = html_sections((string)$page['content']);
?>

<?php if ($slug === 'tentang-sekolah'):
  $stats = Database::all('SELECT * FROM school_statistics WHERE is_active=1 ORDER BY sort_order LIMIT 4'); ?>
<section class="section"><div class="container">
  <div class="about-grid">
    <div>
      <span class="eyebrow reveal">Kenali Kami</span>
      <h2 class="reveal"><?= e(setting('school_name', 'SMK Infokom Kota Bogor')) ?></h2>
      <div class="prose reveal"><?= $page['content'] ?></div>
      <div class="chips reveal" style="margin-top:1.2rem">
        <?php foreach (Site::majors() as $m): ?><a class="chip" href="<?= e(url('jurusan/' . $m['slug'])) ?>"><?= icon('check', 14) ?> <?= e($m['code']) ?></a><?php endforeach; ?>
      </div>
    </div>
    <div class="about-media">
      <div class="frame img-reveal"><?= img($page['image'] ?: null, 'Foto ' . $page['title'] . ' SMK Infokom Kota Bogor', '', false, asset('images/sekolah.svg')) ?></div>
      <div class="float-card"><span class="ico-lg" style="width:42px;height:42px;border-radius:12px"><?= icon('award', 22) ?></span><span>Sekolah Kejuruan<small>Teknologi &amp; Kreatif</small></span></div>
    </div>
  </div>
  <?php if ($stats): ?><div class="stat-tiles stagger"><?php foreach ($stats as $i => $st): ?><div class="stat-tile reveal" style="--i:<?= (int)$i ?>"><b><?= e(number_format((int)$st['value'], 0, ',', '.')) ?><?= e((string)$st['suffix']) ?></b><span><?= e($st['label']) ?></span></div><?php endforeach; ?></div><?php endif; ?>
</div></section>
<section class="section section-pattern"><div class="container">
  <header class="sec-head reveal"><span class="eyebrow">Jelajahi Profil</span><h2>Lebih dekat dengan sekolah kami</h2></header>
  <div class="quick-links stagger">
    <?php foreach ([['Sejarah', 'profil/sejarah', 'clock', 'Perjalanan sekolah'], ['Visi & Misi', 'profil/visi-misi', 'eye', 'Arah & komitmen'], ['Tujuan', 'profil/tujuan', 'check-square', 'Target pendidikan'], ['Struktur Organisasi', 'profil/struktur-organisasi', 'users', 'Susunan pengelola'], ['Kepala Sekolah', 'profil/kepala-sekolah', 'user-check', 'Sambutan pimpinan'], ['Guru & Staff', 'profil/guru-staff', 'users', 'Tenaga pendidik']] as $i => [$l, $h, $ic, $d]): ?>
      <a class="quick reveal" style="--i:<?= $i ?>" href="<?= e(url($h)) ?>"><span class="ico-lg"><?= icon($ic, 22) ?></span><span><?= e($l) ?><small><?= e($d) ?></small></span></a>
    <?php endforeach; ?>
  </div>
</div></section>

<?php elseif ($slug === 'sejarah'):
  // Format isi: <h2>Sekilas Sejarah</h2> lalu per peristiwa <h3>2006 — Awal Berdiri</h3><p>uraian</p>
  $events = []; $intro = []; $heading = '';
  foreach ($secs as $sec) {
    if (preg_match('/^((?:19|20)\d{2})\s*[\x{2014}\x{2013}-]\s*(.+)$/u', $sec['title'], $mm)) { $events[] = ['year' => $mm[1], 'title' => trim($mm[2]), 'paras' => $sec['paras'], 'items' => $sec['items']]; }
    else { if ($sec['title'] !== '' && $heading === '') $heading = $sec['title']; foreach ($sec['paras'] as $ip) $intro[] = $ip; }
  }
  if ($events): ?>
<section class="section"><div class="container">
  <header class="sec-head center reveal"><span class="eyebrow">Perjalanan Kami</span><h2><?= e($heading ?: 'Sekilas Sejarah') ?></h2></header>
  <?php foreach ($intro as $ip): ?><div class="prose reveal" style="margin:0 auto 1.6rem;text-align:center"><p><?= $ip ?></p></div><?php endforeach; ?>
  <div class="timeline stagger">
    <?php foreach ($events as $n => $ev): ?>
    <div class="tl-item reveal" style="--i:<?= $n % 6 ?>"><div class="tl-card"><span class="tl-year"><?= e($ev['year']) ?></span><h3 style="margin:.1rem 0 .4rem"><?= e($ev['title']) ?></h3>
      <?php foreach ($ev['paras'] as $para): ?><p><?= $para ?></p><?php endforeach; ?>
      <?php foreach ($ev['items'] as $it): ?><p><?= $it ?></p><?php endforeach; ?></div></div>
    <?php endforeach; ?>
  </div>
</div></section>
<?php else: ?>
<section class="section"><div class="container">
  <header class="sec-head center reveal"><span class="eyebrow">Perjalanan Kami</span><h2>Jejak langkah <?= e(setting('school_short', 'SMK Infokom')) ?></h2></header>
  <div class="timeline stagger">
    <?php $n = 0; foreach ($secs as $sec):
      if ($sec['title'] !== ''): ?><div class="tl-item reveal"><div class="tl-card"><h3><?= e($sec['title']) ?></h3></div></div><?php endif;
      foreach ($sec['paras'] as $para):
        $plain = trim(strip_tags($para)); $year = preg_match('/\b(19|20)\d{2}\b/', $plain, $mm) ? $mm[0] : ''; ?>
      <div class="tl-item reveal" style="--i:<?= $n++ % 6 ?>"><div class="tl-card"><?php if ($year): ?><span class="tl-year"><?= e($year) ?></span><?php endif; ?><p><?= $para ?></p></div></div>
    <?php endforeach; foreach ($sec['items'] as $it): ?><div class="tl-item reveal"><div class="tl-card"><p><?= $it ?></p></div></div><?php endforeach; endforeach; ?>
  </div>
</div></section>
<?php endif; ?>

<?php elseif ($slug === 'visi-misi'):
  $visi = null; $misi = null;
  foreach ($secs as $s) { if (stripos($s['title'], 'visi') !== false) $visi = $s; elseif (stripos($s['title'], 'misi') !== false) $misi = $s; } ?>
<section class="section"><div class="container">
  <?php if ($visi): ?><div class="vision reveal scale"><span class="eyebrow">Visi</span><?php foreach ($visi['paras'] as $p): ?><p><?= $p ?></p><?php endforeach; ?></div><?php endif; ?>
  <?php if ($misi): ?>
  <header class="sec-head reveal" style="margin-top:3rem"><span class="eyebrow">Misi</span><h2>Komitmen kami untuk mewujudkannya</h2></header>
  <div class="vm-list stagger">
    <?php $i = 1; foreach ($misi['items'] as $it): ?><div class="vm-item reveal" style="--i:<?= ($i - 1) % 6 ?>"><span class="num-badge"><?= $i++ ?></span><div><p><?= $it ?></p></div></div><?php endforeach; ?>
    <?php foreach ($misi['paras'] as $p): ?><div class="vm-item reveal"><span class="num-badge"><?= icon('check', 20) ?></span><div><p><?= $p ?></p></div></div><?php endforeach; ?>
  </div>
  <?php endif; if (!$visi && !$misi): ?><div class="prose reveal"><?= $page['content'] ?></div><?php endif; ?>
</div></section>

<?php elseif ($slug === 'tujuan'): ?>
<section class="section"><div class="container">
  <header class="sec-head reveal"><span class="eyebrow">Tujuan Pendidikan</span><h2>Apa yang ingin kami capai bersama</h2></header>
  <?php $all = []; foreach ($secs as $s) { foreach ($s['items'] as $it) $all[] = $it; } ?>
  <?php if ($all): ?><div class="vm-list stagger"><?php foreach ($all as $i => $it): ?><div class="vm-item reveal" style="--i:<?= $i % 6 ?>"><span class="num-badge"><?= $i + 1 ?></span><div><p><?= $it ?></p></div></div><?php endforeach; ?></div>
  <?php else: ?><div class="prose reveal"><?= $page['content'] ?></div><?php endif; ?>
</div></section>

<?php elseif ($slug === 'struktur-organisasi'): ?>
<section class="section"><div class="container">
  <header class="sec-head center reveal"><span class="eyebrow">Susunan Organisasi</span><h2>Struktur Organisasi Sekolah</h2></header>
  <div class="glass reveal scale"><div class="prose" style="max-width:none"><?= $page['content'] ?></div></div>
  <?php if ($page['image']): ?><div class="img-reveal" style="margin-top:2rem"><?= img($page['image'], 'Bagan struktur organisasi', '', false) ?></div><?php endif; ?>
</div></section>

<?php else: ?>
<section class="section"><div class="container">
  <?php if (!empty($page['image'])): ?>
    <div class="split"><div class="prose reveal"><?= $page['content'] ?></div><div class="img-reveal"><?= img($page['image'], 'Foto ' . $page['title'], '', false, asset('images/sekolah.svg')) ?></div></div>
  <?php else: ?><div class="prose reveal"><?= $page['content'] ?></div><?php endif; ?>
</div></section>
<?php endif; ?>

<?php if ($isProfil): ?>
<section class="section" style="padding-top:0"><div class="container"><div class="cta-band reveal scale">
  <div><h3>Tertarik bergabung dengan SMK Infokom?</h3><p>Daftarkan diri Anda dan wujudkan karier di bidang teknologi &amp; kreatif.</p></div>
  <a class="btn btn-accent" href="<?= e(url('ppdb')) ?>">Daftar PPDB <?= icon('arrow-right', 16) ?></a>
</div></div></section>
<?php endif; ?>
