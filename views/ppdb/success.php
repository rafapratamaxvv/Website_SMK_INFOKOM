<?php page_hero('Pendaftaran Berhasil', 'Simpan nomor pendaftaran dan unduh bukti Anda.', ['PPDB' => 'ppdb', 'Berhasil' => null]); ?>
<section class="section"><div class="container" style="max-width:720px"><div class="form-card center reveal" data-autodownload="<?= e(url('ppdb/bukti/' . $r['verify_token'] . '?unduh=1')) ?>">
  <div class="ico" style="width:70px;height:70px;border-radius:50%;background:#E8F7EF;color:var(--ok);display:grid;place-items:center;margin:0 auto 1rem"><?= icon('check', 36) ?></div>
  <h2>Terima kasih, <?= e($r['name']) ?>!</h2>
  <p class="muted">Nomor pendaftaran Anda</p>
  <p style="font-size:2rem;font-weight:800;color:var(--primary);margin:0 0 1rem"><?= e($r['reg_number']) ?></p>
  <p>Jurusan <strong><?= e($r['major_code']) ?></strong> · <?= e($r['period_name']) ?></p>
  <div class="hero-cta" style="justify-content:center">
    <a class="btn btn-primary" href="<?= e(url('ppdb/bukti/' . $r['verify_token'] . '?unduh=1')) ?>"><?= icon('download', 18) ?> Unduh Formulir Terisi (PDF)</a>
    <a class="btn btn-outline" href="<?= e(url('ppdb/bukti/' . $r['verify_token'] . '?print=1')) ?>" target="_blank" rel="noopener"><?= icon('printer', 18) ?> Cetak</a>
    <a class="btn btn-outline" href="<?= e(url('ppdb/cek-status')) ?>"><?= icon('search', 18) ?> Cek Status PPDB</a>
  </div>
  <p class="hint" style="margin-top:1rem">PDF formulir Anda diunduh otomatis. Jika tidak mulai, klik tombol di atas. Simpan tautan halaman ini. Halaman ini hanya dapat dibuka dengan tautan unik milik Anda.</p>
</div></div></section>
