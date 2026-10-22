<p class="muted">Aktifkan/nonaktifkan, urutkan, dan edit setiap section beranda. Perubahan langsung tampil di website.</p>
<?php foreach ($rows as $i => $s): ?>
<details class="panel" <?= $i === 0 ? 'open' : '' ?>><summary style="cursor:pointer;font-weight:700;color:var(--navy);display:flex;gap:.7rem;align-items:center;flex-wrap:wrap"><?= $i + 1 ?>. <?= e($s['label']) ?> <span class="badge <?= $s['is_enabled'] ? 'badge-ok' : 'badge-off' ?>"><?= $s['is_enabled'] ? 'Aktif' : 'Nonaktif' ?></span></summary>
<div class="toolbar" style="margin-top:.8rem">
  <form method="post" action="<?= e(url('admin/homepage/urut')) ?>"><?= Csrf::field() ?><input type="hidden" name="key" value="<?= e($s['key']) ?>"><input type="hidden" name="dir" value="up"><button class="btn btn-sm btn-outline" type="submit" <?= $i === 0 ? 'disabled' : '' ?>>&uarr; Naik</button></form>
  <form method="post" action="<?= e(url('admin/homepage/urut')) ?>"><?= Csrf::field() ?><input type="hidden" name="key" value="<?= e($s['key']) ?>"><input type="hidden" name="dir" value="down"><button class="btn btn-sm btn-outline" type="submit" <?= $i === count($rows) - 1 ? 'disabled' : '' ?>>&darr; Turun</button></form></div>
<form class="form" method="post" action="<?= e(url('admin/homepage')) ?>" enctype="multipart/form-data"><?= Csrf::field() ?><input type="hidden" name="key" value="<?= e($s['key']) ?>">
<label class="check"><input type="checkbox" name="is_enabled" value="1" <?= $s['is_enabled'] ? 'checked' : '' ?>> Tampilkan section ini</label>
<div class="row2"><div class="field"><label>Badge</label><input name="badge" value="<?= e($s['badge']) ?>" maxlength="120"></div><div class="field"><label>Judul</label><input name="title" value="<?= e($s['title']) ?>" maxlength="255"></div></div>
<div class="field"><label>Subjudul</label><input name="subtitle" value="<?= e($s['subtitle']) ?>" maxlength="255"></div>
<div class="field"><label>Deskripsi</label><textarea name="content" maxlength="3000"><?= e($s['content']) ?></textarea></div>
<div class="row2"><div class="field"><label>Teks tombol</label><input name="button_text" value="<?= e($s['button_text']) ?>" maxlength="80"></div><div class="field"><label>URL tombol</label><input name="button_url" value="<?= e($s['button_url']) ?>" maxlength="255" placeholder="/ppdb"></div></div>
<div class="row2"><div class="field"><label>Teks tombol 2</label><input name="button2_text" value="<?= e($s['button2_text']) ?>" maxlength="80"></div><div class="field"><label>URL tombol 2</label><input name="button2_url" value="<?= e($s['button2_url']) ?>" maxlength="255"></div></div>
<div class="field"><label>Gambar / background</label><input type="file" name="image" accept="image/*"><?php if ($s['image']): ?><div class="preview"><img src="<?= e(upload_url($s['image'])) ?>" alt=""><label class="check" style="font-weight:400"><input type="checkbox" name="image_remove" value="1"> Hapus</label></div><?php endif; ?></div>
<div class="toolbar"><button class="btn btn-primary" type="submit">Simpan section</button></div></form></details>
<?php endforeach; ?>
