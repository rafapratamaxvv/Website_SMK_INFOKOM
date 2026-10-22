<?php page_hero('Verifikasi Pendaftaran', 'Pemeriksaan keaslian bukti pendaftaran PPDB.', ['PPDB' => 'ppdb', 'Verifikasi' => null]); ?>
<section class="section"><div class="container" style="max-width:640px"><div class="form-card reveal">
  <div class="alert alert-success" style="margin-top:0">Bukti pendaftaran ini <strong>valid</strong> dan terdaftar di sistem.</div>
  <table class="t"><tbody>
    <tr><th>No. Pendaftaran</th><td><?= e($r['reg_number']) ?></td></tr>
    <tr><th>Nama</th><td><?= e($maskedName) ?></td></tr>
    <tr><th>Jurusan</th><td><?= e($r['major_code']) ?> — <?= e($r['major_name']) ?></td></tr>
    <tr><th>Periode</th><td><?= e($r['period_name']) ?></td></tr>
    <tr><th>Status</th><td><span class="badge"><?= e(strtoupper($r['status'])) ?></span></td></tr>
    <tr><th>Tanggal daftar</th><td><?= e(fmt_date($r['created_at'], 'd F Y')) ?></td></tr>
  </tbody></table></div></div></section>
