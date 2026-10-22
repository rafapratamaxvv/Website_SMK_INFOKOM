<?php
/** @var array|null $result @var bool $searched */
page_hero('Cek Status PPDB', 'Lihat apakah pendaftaran Anda sudah diterima.', ['PPDB' => 'ppdb', 'Cek Status' => null], 'clipboard');
$valid = $valid ?? true;
$labels = [
    'diterima'      => ['DITERIMA', 'ok'],
    'terverifikasi' => ['BERKAS TERVERIFIKASI', 'info'],
    'baru'          => ['MENUNGGU PROSES', 'wait'],
    'ditolak'       => ['BELUM DITERIMA', 'no'],
];
?>
<section class="section"><div class="container" style="max-width:680px">
  <?php if ($searched && $result): $st = (string)$result['status']; [$lab, $cls] = $labels[$st] ?? [strtoupper($st), 'wait']; ?>
  <div class="form-card reveal status-card status-<?= e($cls) ?>">
    <?php if ($st === 'diterima'): ?>
      <div class="status-ico status-ico-ok"><?= icon('check', 40) ?></div>
      <p class="muted center" style="margin:.2rem 0">Selamat, <strong><?= e($result['name']) ?></strong></p>
      <h2 class="center status-title">DITERIMA</h2>
      <p class="center">Anda dinyatakan <strong>diterima</strong> di <?= e(setting('school_name', 'SMK Infokom Kota Bogor')) ?> pada jurusan <strong><?= e($result['major_code']) ?> — <?= e($result['major_name']) ?></strong>.</p>
    <?php elseif ($st === 'ditolak'): ?>
      <div class="status-ico status-ico-no"><?= icon('x', 40) ?></div>
      <p class="muted center" style="margin:.2rem 0"><?= e($result['name']) ?></p>
      <h2 class="center status-title">BELUM DITERIMA</h2>
      <p class="center">Mohon maaf, pendaftaran Anda belum dapat diterima. Silakan hubungi panitia PPDB untuk informasi lebih lanjut.</p>
    <?php else: ?>
      <div class="status-ico status-ico-wait"><?= icon('clock', 40) ?></div>
      <p class="muted center" style="margin:.2rem 0"><?= e($result['name']) ?></p>
      <h2 class="center status-title"><?= $st === 'terverifikasi' ? 'BERKAS TERVERIFIKASI' : 'PENDAFTARAN DITERIMA PANITIA' ?></h2>
      <p class="center"><?= $st === 'terverifikasi' ? 'Berkas Anda sudah diverifikasi. Hasil akhir penerimaan akan diumumkan oleh panitia.' : 'Data Anda sudah kami terima dan sedang menunggu proses verifikasi. Cek kembali halaman ini secara berkala.' ?></p>
    <?php endif; ?>
    <table class="t" style="margin-top:1.2rem"><tbody>
      <tr><th>No. Pendaftaran</th><td><?= e($result['reg_number']) ?></td></tr>
      <tr><th>Jurusan pilihan</th><td><?= e($result['major_code']) ?> — <?= e($result['major_name']) ?></td></tr>
      <tr><th>Periode</th><td><?= e($result['period_name']) ?></td></tr>
      <tr><th>Status</th><td><span class="badge status-badge status-badge-<?= e($cls) ?>"><?= e($lab) ?></span></td></tr>
      <?php if (!empty($result['note'])): ?><tr><th>Catatan panitia</th><td><?= nl2br(e($result['note'])) ?></td></tr><?php endif; ?>
    </tbody></table>
    <?php if ($st === 'diterima'): ?><p class="hint" style="margin-top:1rem">Langkah berikutnya: cetak formulir pendaftaran, lalu bawa bersama berkas asli ke sekolah untuk daftar ulang. Info lebih lanjut hubungi <a href="<?= e(wa_link('Halo, saya sudah diterima PPDB SMK Infokom, nomor pendaftaran ' . $result['reg_number'] . '.')) ?>" target="_blank" rel="noopener noreferrer">panitia via WhatsApp</a>.</p><?php endif; ?>
    <div class="hero-cta" style="justify-content:center;margin-top:1rem">
      <a class="btn btn-primary" href="<?= e(url('ppdb/bukti/' . $result['verify_token'] . '?unduh=1')) ?>"><?= icon('download', 18) ?> Unduh Formulir (PDF)</a>
      <a class="btn btn-outline" href="<?= e(url('ppdb/cek-status')) ?>">Cek data lain</a>
    </div>
  </div>
  <?php else: ?>
  <div class="form-card reveal">
    <?php if ($searched): ?><div class="alert alert-warning" style="margin-top:0"><?= !$valid ? 'Isi NISN (10 digit) dan tanggal lahir dengan benar.' : 'Data tidak ditemukan. Pastikan NISN dan tanggal lahir sama persis dengan yang Anda isi saat mendaftar.' ?></div><?php endif; ?>
    <h2 style="margin-top:0">Cek Status Penerimaan</h2>
    <p class="muted">Masukkan NISN dan tanggal lahir sesuai data pendaftaran untuk melihat apakah Anda sudah <strong>diterima</strong>.</p>
    <form class="form" method="post" action="<?= e(url('ppdb/cek-status')) ?>" novalidate>
      <?= Csrf::field() ?>
      <div class="field"><label for="s-nisn">NISN (10 digit) <span class="req">*</span></label><input id="s-nisn" name="nisn" required inputmode="numeric" pattern="\d{10}" maxlength="10" autocomplete="off" value="<?= e($nisn ?? '') ?>"></div>
      <div class="field"><label for="s-dob">Tanggal lahir <span class="req">*</span></label><input id="s-dob" type="date" name="birth_date" required value="<?= e($dob ?? '') ?>"></div>
      <button class="btn btn-accent" type="submit"><?= icon('search', 18) ?> Cek Status</button>
    </form>
    <p class="hint" style="margin-top:1rem">Belum mendaftar? <a href="<?= e(url('ppdb#formulir')) ?>">Daftar PPDB sekarang</a>.</p>
  </div>
  <?php endif; ?>
</div></section>
