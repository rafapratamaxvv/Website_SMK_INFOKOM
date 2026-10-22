<?php page_hero('Guru & Staff', 'Tenaga pendidik dan kependidikan SMK Infokom.', ['Profil' => 'profil', 'Guru & Staff' => null], 'users'); profil_tabs('guru-staff'); ?>
<section class="section"><div class="container">
  <form class="search-bar" method="get" role="search">
    <input type="search" name="q" value="<?= e($q) ?>" placeholder="Cari nama, jabatan, mata pelajaran…" aria-label="Cari">
    <select name="tipe" aria-label="Tipe"><option value="">Guru &amp; Staff</option><option value="guru" <?= $type === 'guru' ? 'selected' : '' ?>>Guru</option><option value="staff" <?= $type === 'staff' ? 'selected' : '' ?>>Staff</option></select>
    <select name="jurusan" aria-label="Jurusan"><option value="">Semua jurusan</option><?php foreach ($majors as $m): ?><option value="<?= (int)$m['id'] ?>" <?= $major === (int)$m['id'] ? 'selected' : '' ?>><?= e($m['code']) ?></option><?php endforeach; ?></select>
    <button class="btn btn-primary" type="submit"><?= icon('search', 18) ?> Cari</button>
  </form>
  <?php if (!$rows): ?><p class="muted">Data tidak ditemukan.</p><?php endif; ?>
  <div class="grid g4 stagger">
  <?php foreach ($rows as $r): $mid = 'm-' . $r['tipe'] . $r['id']; ?>
    <article class="card portrait reveal" data-modal="<?= e($mid) ?>" tabindex="0" role="button" aria-label="Detail <?= e($r['name']) ?>">
      <div class="ph"><?= img($r['photo'], $r['name'], '', true, asset('images/avatar.svg')) ?></div>
      <h3><?= e($r['name']) ?></h3><p><?= e($r['position']) ?></p><?= demo_badge($r) ?>
    </article>
    <div class="modal" id="<?= e($mid) ?>" role="dialog" aria-modal="true" aria-label="<?= e($r['name']) ?>" hidden><div class="modal-box">
      <button class="icon-btn modal-close" type="button" aria-label="Tutup"><?= icon('x', 20) ?></button>
      <img class="modal-photo" src="<?= e($r['photo'] ? upload_url($r['photo']) : asset('images/avatar.svg')) ?>" alt="">
      <h3 class="center"><?= e($r['name']) ?></h3><p class="center muted"><?= e($r['position']) ?> <?= demo_badge($r) ?></p>
      <table class="t"><tbody>
        <?php foreach (['education' => 'Pendidikan', 'field' => 'Bidang', 'subjects' => 'Mata pelajaran'] as $k => $l): if ($r[$k]): ?><tr><th><?= e($l) ?></th><td><?= e($r[$k]) ?></td></tr><?php endif; endforeach; ?>
        <tr><th>Status</th><td>Aktif</td></tr>
      </tbody></table>
      <?php if ($r['bio']): ?><p style="margin-top:1rem"><?= nl2br(e($r['bio'])) ?></p><?php endif; ?>
    </div></div>
  <?php endforeach; ?>
  </div>
  <?= pager($pg, ['q' => $q, 'tipe' => $type, 'jurusan' => $major ?: '']) ?>
</div></section>
