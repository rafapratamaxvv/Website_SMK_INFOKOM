<?php
/** @var array|null $r  Data pendaftar (null = formulir kosong) */
$filled = is_array($r);
$v = fn(string $k) => $filled ? e($r[$k] ?? '') : '';
$line = fn(string $val = '') => $val !== '' ? $val : '&nbsp;';
$box = fn(bool $on) => '<span class="cb' . ($on ? ' on' : '') . '">' . ($on ? '&#10003;' : '&nbsp;') . '</span>';
$majorId = $filled ? (int)$r['major_id'] : 0;
$income = ['< Rp 1.000.000', 'Rp 1.000.000 – 3.000.000', 'Rp 3.000.000 – 5.000.000', '> Rp 5.000.000', 'Tidak berpenghasilan'];
?>
<!doctype html>
<html lang="id"><head><meta charset="utf-8"><title><?= $filled ? 'Formulir PPDB ' . e($r['reg_number']) : 'Formulir PPDB (Kosong)' ?></title>
<style>
@page { margin: 18px 32px 18px; }
body { font-family: DejaVu Sans, Arial, sans-serif; font-size: 10px; color: #1a2233; line-height: 1.3; }
.head { border-bottom: 3px solid #0B4DA2; padding-bottom: 8px; margin-bottom: 10px; }
.head table { width: 100%; }
.school { font-size: 15px; font-weight: bold; color: #0A2A5E; }
.sub { color: #566; font-size: 9px; line-height: 1.45; }
h1 { font-size: 13.5px; text-align: center; margin: 8px 0 2px; letter-spacing: .4px; color: #0A2A5E; }
.regbox { text-align: center; margin-bottom: 8px; font-size: 10px; color: #566; }
.regbox b { font-size: 15px; color: #0B4DA2; letter-spacing: 1px; }
.sec { background: #0B4DA2; color: #fff; font-weight: bold; padding: 2.5px 8px; margin: 7px 0 3px; font-size: 10.5px; }
table.f { width: 100%; border-collapse: collapse; }
table.f td { padding: 3.4px 4px; vertical-align: bottom; }
table.f td.k { width: 128px; color: #455; }
table.f td.c { width: 8px; }
table.f td.v { border-bottom: 1px <?= $filled ? 'solid #cfd8e6' : 'dotted #555' ?>; font-weight: <?= $filled ? 'bold' : 'normal' ?>; }
.cb { display: inline-block; width: 11px; height: 11px; border: 1px solid #333; text-align: center; font-size: 9px; line-height: 11px; margin-right: 3px; vertical-align: middle; font-weight: bold; color: #0B4DA2; }
.cb.on { background: #0B4DA2; color: #fff; border-color: #0B4DA2; }
.opt { display: inline-block; margin-right: 14px; }
.photo { width: 78px; height: 102px; border: 1px solid #667; text-align: center; color: #889; font-size: 8.5px; }
.photo img { width: 78px; height: 102px; }
.note { border: 1px solid #c9d3e3; background: #f6f8fc; padding: 5px 8px; font-size: 9px; color: #455; margin-top: 8px; }
.sign td { text-align: center; width: 33%; padding-top: 4px; font-size: 10px; }
.sign .sp { height: 32px; }
.badge { background: #F5B800; color: #0A2A5E; font-weight: bold; padding: 1px 6px; font-size: 9px; }
</style></head><body>
<div class="head"><table><tr>
<td style="width:66px;vertical-align:middle"><?php if ($logoUri): ?><img src="<?= $logoUri ?>" width="58" height="58" alt="Logo SMK Infokom"><?php endif; ?></td>
<td><div class="school"><?= e(setting('school_name', 'SMK INFOKOM KOTA BOGOR')) ?></div>
<div class="sub"><?= e(setting('address')) ?><br>Telp. <?= e(setting('phone')) ?> · WA <?= e(setting('whatsapp')) ?> · <?= e(setting('email')) ?></div></td>
<td style="width:92px;text-align:right"><?php if ($filled): ?><div class="photo"><?php if ($photoUri): ?><img src="<?= $photoUri ?>" alt="Foto"><?php else: ?><br><br>Foto<?php endif; ?></div><?php else: ?><div class="photo"><br><br><br>Pas foto<br>3 x 4</div><?php endif; ?></td>
</tr></table></div>

<h1>FORMULIR PENDAFTARAN PESERTA DIDIK BARU</h1>
<div class="regbox">No. Pendaftaran: <?php if ($filled): ?><b><?= e($r['reg_number']) ?></b> &nbsp; <span class="badge"><?= e(strtoupper($r['status'])) ?></span><?php else: ?><b>____________________</b> <span style="font-size:8.5px">(diisi panitia)</span><?php endif; ?>
<br>Periode: <?= $filled ? e($r['period_name']) : ($period ? e($period['name']) : '...........................') ?></div>

<div class="sec">A. DATA CALON PESERTA DIDIK</div>
<table class="f">
<tr><td class="k">Nama lengkap</td><td class="c">:</td><td class="v"><?= $line($v('name')) ?></td></tr>
<tr><td class="k">NISN</td><td class="c">:</td><td class="v"><?= $line($v('nisn')) ?></td></tr>
<tr><td class="k">Asal SMP/MTs</td><td class="c">:</td><td class="v"><?= $line($v('school_origin')) ?></td></tr>
<tr><td class="k">Tempat, tanggal lahir</td><td class="c">:</td><td class="v"><?= $filled ? e($r['birth_place']) . ', ' . e(fmt_date($r['birth_date'], 'd F Y')) : '&nbsp;' ?></td></tr>
<tr><td class="k">Jenis kelamin</td><td class="c">:</td><td class="v"><span class="opt"><?= $box($filled && $r['gender'] === 'L') ?> Laki-laki</span><span class="opt"><?= $box($filled && $r['gender'] === 'P') ?> Perempuan</span></td></tr>
<tr><td class="k">Alamat lengkap</td><td class="c">:</td><td class="v"><?= $line($v('address')) ?></td></tr>
<?php if (!$filled): ?><tr><td class="k"></td><td class="c"></td><td class="v">&nbsp;</td></tr><?php endif; ?>
<tr><td class="k">No. HP / WhatsApp</td><td class="c">:</td><td class="v"><?= $line($v('phone')) ?></td></tr>
<tr><td class="k">Email</td><td class="c">:</td><td class="v"><?= $line($v('email')) ?></td></tr>
</table>

<div class="sec">B. DATA ORANG TUA / WALI</div>
<table class="f">
<tr><td class="k">Nama ayah</td><td class="c">:</td><td class="v"><?= $line($v('father_name')) ?></td></tr>
<tr><td class="k">Nama ibu</td><td class="c">:</td><td class="v"><?= $line($v('mother_name')) ?></td></tr>
<tr><td class="k">Pekerjaan orang tua</td><td class="c">:</td><td class="v"><?= $line($v('parent_job')) ?></td></tr>
<tr><td class="k">Penghasilan / bulan</td><td class="c">:</td><td class="v"><?php if ($filled): ?><?= e($r['parent_income']) ?><?php else: foreach ($income as $i): ?><span class="opt" style="margin-right:8px"><?= $box(false) ?> <?= e($i) ?></span><?php endforeach; endif; ?></td></tr>
</table>

<div class="sec">C. PILIHAN KOMPETENSI KEAHLIAN</div>
<table class="f"><tr><td style="padding-left:8px">
<?php foreach ($majors as $m): ?><span class="opt"><?= $box($majorId === (int)$m['id']) ?> <b><?= e($m['code']) ?></b> — <?= e($m['name']) ?></span><br><?php endforeach; ?>
</td></tr></table>

<div class="sec">D. KELENGKAPAN BERKAS</div>
<table class="f"><tr><td style="padding-left:8px">
<?php foreach (lines($cfg['requirements'] ?? '') ?: ['Fotokopi ijazah/SKL', 'Fotokopi Kartu Keluarga', 'Pas foto terbaru', 'NISN'] as $req): ?><span class="opt" style="width:46%"><?= $box(false) ?> <?= e($req) ?></span><?php endforeach; ?>
</td></tr></table>

<div class="note"><b>Pernyataan:</b> Saya menyatakan bahwa data yang saya isi pada formulir ini adalah benar. Apabila di kemudian hari terdapat data yang tidak benar, saya bersedia menerima konsekuensi sesuai ketentuan sekolah.</div>

<table class="sign" style="width:100%;margin-top:8px"><tr>
<td>Mengetahui,<br>Orang Tua / Wali<div class="sp"></div>( ...................................... )</td>
<td>Bogor, ........................ 20....<br>Calon Peserta Didik<div class="sp"></div>( <?= $filled ? e($r['name']) : '......................................' ?> )</td>
<td>Panitia PPDB<br>&nbsp;<div class="sp"></div>( ...................................... )</td>
</tr></table>

<?php if ($filled): ?>
<table style="width:100%;margin-top:8px"><tr>
<td><div class="note" style="margin:0">Terdaftar online pada <b><?= e(fmt_date($r['created_at'], 'd F Y, H:i')) ?> WIB</b>. Cetak formulir ini, tanda tangani, dan bawa bersama berkas asli saat verifikasi di sekolah. Keaslian dapat dicek dengan memindai kode QR atau membuka:<br><b><?= e($verifyUrl) ?></b></div></td>
<td style="width:96px;text-align:right"><?php if ($qrUri): ?><img src="<?= $qrUri ?>" width="88" alt="QR verifikasi"><?php elseif (!empty($qrHtml)): echo $qrHtml; endif; ?></td>
</tr></table>
<?php else: ?>
<div class="note" style="margin-top:8px">Formulir ini dapat diisi tangan dan diserahkan ke sekolah, atau lebih mudah daftar online di <b><?= e(abs_url('ppdb')) ?></b> — bukti pendaftaran PDF langsung terunduh setelah formulir dikirim.</div>
<?php endif; ?>
</body></html>
