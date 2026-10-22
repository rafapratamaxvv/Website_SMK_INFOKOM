<?php /** @var array $r */ ?>
<!doctype html>
<html lang="id"><head><meta charset="utf-8"><title>Bukti Pendaftaran <?= e($r['reg_number']) ?></title>
<style>
@page { margin: 28px 36px; }
body { font-family: DejaVu Sans, Arial, sans-serif; font-size: 11px; color: #1a2233; }
.head { border-bottom: 3px solid #0B4DA2; padding-bottom: 10px; margin-bottom: 14px; }
.head table { width: 100%; }
.school { font-size: 15px; font-weight: bold; color: #0A2A5E; }
.sub { color: #566; font-size: 10px; line-height: 1.5; }
h1 { font-size: 14px; text-align: center; margin: 10px 0 2px; letter-spacing: .5px; }
.regno { text-align: center; font-size: 17px; font-weight: bold; color: #0B4DA2; margin-bottom: 14px; }
table.d { width: 100%; border-collapse: collapse; }
table.d td { padding: 5px 6px; border-bottom: 1px solid #e3e8f0; vertical-align: top; }
table.d td.k { width: 150px; color: #556; }
.band { background: #F5B800; height: 4px; margin: 14px 0; }
.photo { width: 90px; height: 120px; border: 1px solid #99a; object-fit: cover; }
.foot { margin-top: 18px; font-size: 10px; color: #556; }
.box { border: 1px solid #c9d3e3; padding: 8px 10px; background: #f6f8fc; }
.status { display: inline-block; background: #0B4DA2; color: #fff; padding: 2px 8px; font-size: 10px; }
</style></head><body>
<div class="head"><table><tr>
<td style="width:64px"><?php if ($logoUri): ?><img src="<?= $logoUri ?>" width="56" alt=""><?php endif; ?></td>
<td><div class="school"><?= e(setting('school_name', 'SMK INFOKOM KOTA BOGOR')) ?></div>
<div class="sub"><?= e(setting('address')) ?><br>Telp. <?= e(setting('phone')) ?> · <?= e(setting('email')) ?></div></td>
</tr></table></div>
<h1>BUKTI PENDAFTARAN PPDB</h1>
<div class="regno"><?= e($r['reg_number']) ?></div>
<table class="d"><tr>
<td style="width:105px"><?php if ($photoUri): ?><img class="photo" src="<?= $photoUri ?>" alt="Foto"><?php endif; ?></td>
<td><table class="d">
<tr><td class="k">Nama Lengkap</td><td><b><?= e($r['name']) ?></b></td></tr>
<tr><td class="k">NISN</td><td><?= e($r['nisn']) ?></td></tr>
<tr><td class="k">Jurusan Pilihan</td><td><b><?= e($r['major_code']) ?></b> — <?= e($r['major_name']) ?></td></tr>
<tr><td class="k">Periode</td><td><?= e($r['period_name']) ?></td></tr>
<tr><td class="k">Status</td><td><span class="status"><?= e(strtoupper($r['status'])) ?></span></td></tr>
</table></td></tr></table>
<div class="band"></div>
<table class="d">
<tr><td class="k">Tempat, Tgl Lahir</td><td><?= e($r['birth_place']) ?>, <?= e(fmt_date($r['birth_date'], 'd F Y')) ?></td></tr>
<tr><td class="k">Jenis Kelamin</td><td><?= $r['gender'] === 'L' ? 'Laki-laki' : 'Perempuan' ?></td></tr>
<tr><td class="k">Asal Sekolah</td><td><?= e($r['school_origin']) ?></td></tr>
<tr><td class="k">Alamat</td><td><?= e($r['address']) ?></td></tr>
<tr><td class="k">No. HP / Email</td><td><?= e($r['phone']) ?> / <?= e($r['email'] ?: '-') ?></td></tr>
<tr><td class="k">Ayah</td><td><?= e($r['father_name']) ?></td></tr>
<tr><td class="k">Ibu</td><td><?= e($r['mother_name']) ?></td></tr>
<tr><td class="k">Pekerjaan Orang Tua</td><td><?= e($r['parent_job']) ?></td></tr>
<tr><td class="k">Penghasilan</td><td><?= e($r['parent_income']) ?></td></tr>
<tr><td class="k">Tanggal Daftar</td><td><?= e(fmt_date($r['created_at'], 'd F Y, H:i')) ?> WIB</td></tr>
</table>
<div class="foot"><table style="width:100%"><tr>
<td><div class="box">Simpan bukti ini dan bawa saat verifikasi berkas di sekolah. Keaslian dapat dicek dengan memindai kode QR atau membuka:<br><b><?= e($verifyUrl) ?></b></div></td>
<td style="width:110px;text-align:right"><?php if ($qrUri): ?><img src="<?= $qrUri ?>" width="96" alt="QR verifikasi"><?php elseif (!empty($qrHtml)): echo $qrHtml; endif; ?></td>
</tr></table></div>
</body></html>
