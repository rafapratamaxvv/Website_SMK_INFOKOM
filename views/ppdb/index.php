<?php page_hero('PPDB', 'Penerimaan Peserta Didik Baru SMK Infokom Kota Bogor.', ['PPDB' => null], 'clipboard'); ?>
<section class="section" style="padding-bottom:0"><div class="container"><div class="promo reveal">
  <div class="promo-text">
    <span class="eyebrow" style="color:var(--accent)">Penerimaan Peserta Didik Baru</span>
    <h2>Wujudkan Masa Depanmu di <?= e(setting('school_short', 'SMK Infokom')) ?></h2>
    <p>Empat pilihan jurusan — TKJ, RPL, DKV, dan PSPT — dengan praktik industri, PKL, dan jalur karier melalui BKK. Daftar online dalam hitungan menit dan unduh bukti pendaftaran PDF.</p>
    <div class="hero-cta" style="margin-top:1.2rem">
      <?php if ($open): ?><a class="btn btn-accent" href="#formulir">Daftar Sekarang <?= icon('arrow-right', 16) ?></a><?php endif; ?>
      <a class="btn btn-light" href="<?= e(url('ppdb/formulir-kosong?unduh=1')) ?>"><?= icon('download', 18) ?> Unduh Formulir Kosong (PDF)</a>
      <a class="btn btn-light" href="<?= e(url('ppdb/cek-status')) ?>"><?= icon('search', 18) ?> Cek Status PPDB</a>
      <a class="btn btn-light" href="<?= e(wa_link('Halo, saya ingin bertanya tentang PPDB SMK Infokom.')) ?>" target="_blank" rel="noopener noreferrer"><?= icon('whatsapp', 18) ?> Tanya via WhatsApp</a>
    </div>
  </div>
  <div class="promo-img"><?= img(setting('ppdb_banner') ?: null, 'Promosi PPDB ' . setting('school_name', 'SMK Infokom Kota Bogor'), '', false, asset('images/ppdb.svg')) ?></div>
</div></div></section>
<section class="section"><div class="container">
  <div class="split" style="align-items:start">
    <div class="reveal">
      <span class="eyebrow">Informasi</span><h2>Pendaftaran Online</h2>
      <p><?= nl2br(e($cfg['info'])) ?></p>
      <?php if ($open): ?><div class="alert alert-success">PPDB dibuka — <strong><?= e($period['name']) ?></strong>: <?= e(fmt_date($period['start_date'])) ?> s.d. <?= e(fmt_date($period['end_date'])) ?>.</div>
      <?php else: ?><div class="alert alert-warning"><?= e($cfg['closed_message'] ?: 'PPDB sedang ditutup.') ?></div><?php endif; ?>
      <h3>Persyaratan</h3><ul class="checklist"><?php foreach (lines($cfg['requirements']) as $x): ?><li><?= e($x) ?></li><?php endforeach; ?></ul>
      <h3>Biaya</h3><p><?= nl2br(e($cfg['fees'])) ?></p>
      <p><a class="btn btn-outline" href="<?= e(url('ppdb/formulir-kosong?unduh=1')) ?>"><?= icon('download', 16) ?> Unduh formulir kosong (PDF)</a> <span class="hint">untuk diisi tangan</span></p>
    </div>
    <div class="reveal right">
      <h3>Jadwal Gelombang</h3>
      <div class="table-wrap"><table class="t"><thead><tr><th>Gelombang</th><th>Mulai</th><th>Selesai</th></tr></thead><tbody>
      <?php foreach ($periods as $p): ?><tr><td><?= e($p['name']) ?> <?= demo_badge($p) ?></td><td><?= e(fmt_date($p['start_date'])) ?></td><td><?= e(fmt_date($p['end_date'])) ?></td></tr><?php endforeach; ?>
      <?php if (!$periods): ?><tr><td colspan="3" class="muted">Jadwal belum diumumkan.</td></tr><?php endif; ?></tbody></table></div>
      <h3 style="margin-top:1.6rem">Jurusan & Kuota</h3>
      <div class="table-wrap"><table class="t"><thead><tr><th>Jurusan</th><th>Sisa kuota</th></tr></thead><tbody>
      <?php foreach ($majors as $m): ?><tr><td><strong><?= e($m['code']) ?></strong> — <?= e($m['name']) ?></td><td><span class="quota <?= $m['left'] <= 5 ? 'low' : '' ?>"><?= $open ? ($m['left'] > 0 ? $m['left'] : 'Penuh') : '—' ?></span></td></tr><?php endforeach; ?></tbody></table></div>
    </div>
  </div>
  <h2 style="margin-top:3rem" class="reveal">Alur Pendaftaran</h2>
  <ol class="steps"><?php foreach (lines($cfg['flow']) as $x): ?><li class="reveal"><h3><?= e($x) ?></h3></li><?php endforeach; ?></ol>
</div></section>

<section class="section section-alt" id="formulir"><div class="container" style="max-width:900px">
  <h2 class="reveal">Formulir Pendaftaran</h2>
  <?php if (!$open): ?>
    <div class="alert alert-warning"><?= e($cfg['closed_message'] ?: 'PPDB sedang ditutup.') ?> Formulir tidak dapat digunakan saat ini.</div>
  <?php else: ?>
  <div class="form-card reveal">
    <form class="form" method="post" action="<?= e(url('ppdb/daftar')) ?>" enctype="multipart/form-data" data-ajax novalidate>
      <?= Csrf::field() ?>
      <fieldset><legend>Data Calon Siswa</legend><div class="form">
        <div class="field <?= isset($_SESSION['_errors']['name']) ? 'has-error' : '' ?>"><label for="p-name">Nama lengkap <span class="req">*</span></label><input id="p-name" name="name" required maxlength="150" value="<?= old('name') ?>"><?= field_error('name') ?></div>
        <div class="row2">
          <div class="field <?= isset($_SESSION['_errors']['nisn']) ? 'has-error' : '' ?>"><label for="p-nisn">NISN (10 digit) <span class="req">*</span></label><input id="p-nisn" name="nisn" required inputmode="numeric" pattern="\d{10}" maxlength="10" value="<?= old('nisn') ?>"><?= field_error('nisn') ?></div>
          <div class="field"><label for="p-school">Asal SMP/MTs <span class="req">*</span></label><input id="p-school" name="school_origin" required maxlength="150" value="<?= old('school_origin') ?>"><?= field_error('school_origin') ?></div></div>
        <div class="row2">
          <div class="field"><label for="p-bp">Tempat lahir <span class="req">*</span></label><input id="p-bp" name="birth_place" required maxlength="100" value="<?= old('birth_place') ?>"><?= field_error('birth_place') ?></div>
          <div class="field"><label for="p-bd">Tanggal lahir <span class="req">*</span></label><input id="p-bd" type="date" name="birth_date" required value="<?= old('birth_date') ?>"><?= field_error('birth_date') ?></div></div>
        <div class="row2">
          <div class="field"><label for="p-g">Jenis kelamin <span class="req">*</span></label><select id="p-g" name="gender" required><option value="">Pilih…</option><option value="L" <?= old('gender') === 'L' ? 'selected' : '' ?>>Laki-laki</option><option value="P" <?= old('gender') === 'P' ? 'selected' : '' ?>>Perempuan</option></select><?= field_error('gender') ?></div>
          <div class="field"><label for="p-m">Jurusan pilihan <span class="req">*</span></label><select id="p-m" name="major_id" required><option value="">Pilih jurusan…</option><?php foreach ($majors as $m): ?><option value="<?= (int)$m['id'] ?>" <?= $m['left'] <= 0 ? 'disabled' : '' ?> <?= old('major_id') == $m['id'] ? 'selected' : '' ?>><?= e($m['code']) ?> — <?= e($m['name']) ?><?= $m['left'] <= 0 ? ' (kuota penuh)' : '' ?></option><?php endforeach; ?></select><?= field_error('major_id') ?></div></div>
        <div class="field"><label for="p-addr">Alamat lengkap <span class="req">*</span></label><textarea id="p-addr" name="address" required minlength="10" maxlength="300" style="min-height:90px"><?= old('address') ?></textarea><?= field_error('address') ?></div>
        <div class="row2">
          <div class="field"><label for="p-ph">Nomor HP <span class="req">*</span></label><input id="p-ph" name="phone" type="tel" required maxlength="20" placeholder="08xxxxxxxxxx" value="<?= old('phone') ?>"><?= field_error('phone') ?></div>
          <div class="field"><label for="p-em">Email</label><input id="p-em" name="email" type="email" maxlength="150" value="<?= old('email') ?>"><?= field_error('email') ?></div></div>
      </div></fieldset>
      <fieldset><legend>Data Orang Tua</legend><div class="form">
        <div class="row2"><div class="field"><label for="p-f">Nama ayah <span class="req">*</span></label><input id="p-f" name="father_name" required maxlength="150" value="<?= old('father_name') ?>"><?= field_error('father_name') ?></div>
        <div class="field"><label for="p-mo">Nama ibu <span class="req">*</span></label><input id="p-mo" name="mother_name" required maxlength="150" value="<?= old('mother_name') ?>"><?= field_error('mother_name') ?></div></div>
        <div class="row2"><div class="field"><label for="p-j">Pekerjaan orang tua <span class="req">*</span></label><input id="p-j" name="parent_job" required maxlength="100" value="<?= old('parent_job') ?>"><?= field_error('parent_job') ?></div>
        <div class="field"><label for="p-i">Penghasilan <span class="req">*</span></label><select id="p-i" name="parent_income" required><option value="">Pilih…</option><?php foreach (PpdbController::INCOME as $i): ?><option <?= old('parent_income') === $i ? 'selected' : '' ?>><?= e($i) ?></option><?php endforeach; ?></select><?= field_error('parent_income') ?></div></div>
      </div></fieldset>
      <fieldset><legend>Berkas</legend><div class="form">
        <div class="field"><label for="p-photo">Pas foto (JPG/PNG/WebP, maks 2 MB) <span class="req">*</span></label><input id="p-photo" type="file" name="photo" accept="image/jpeg,image/png,image/webp" required data-max="2097152"><?= field_error('photo') ?></div>
        <div class="field"><label for="p-docs">Dokumen pendukung — ijazah/SKL, KK (PDF/gambar, maks 3 MB per file, hingga 4 file)</label><input id="p-docs" type="file" name="dokumen[]" accept="application/pdf,image/jpeg,image/png,image/webp" multiple data-max="3145728"><?= field_error('dokumen') ?></div>
      </div></fieldset>
      <button class="btn btn-accent" type="submit"><?= icon('check', 18) ?> Kirim Pendaftaran</button>
    </form><?php clear_old(); ?>
  </div>
  <?php endif; ?>
</div></section>
<?php if ($faq): ?><section class="section"><div class="container" style="max-width:860px"><h2 class="reveal">FAQ PPDB</h2><div class="accordion"><?php foreach ($faq as $q): ?><details><summary><?= e($q['question']) ?> <?= demo_badge($q) ?></summary><div class="a"><?= nl2br(e($q['answer'])) ?></div></details><?php endforeach; ?></div></div></section><?php endif; ?>
