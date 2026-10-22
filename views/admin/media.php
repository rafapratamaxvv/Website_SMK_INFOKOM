<div class="panel"><h2>Unggah media</h2>
<form class="form" method="post" action="<?= e(url('admin/media/upload')) ?>" enctype="multipart/form-data"><?= Csrf::field() ?>
<div class="row2"><div class="field"><label for="m-files">File (JPG/PNG/WebP/GIF/PDF, maks 8 MB)</label><input id="m-files" type="file" name="files[]" multiple required accept="image/jpeg,image/png,image/webp,image/gif,application/pdf"></div>
<div class="field"><label for="m-folder">Folder</label><input id="m-folder" name="folder" value="umum" maxlength="60" list="folders"><datalist id="folders"><?php foreach ($folders as $f): ?><option value="<?= e($f) ?>"><?php endforeach; ?></datalist></div></div>
<div class="row2"><div class="field"><label for="m-cat">Kategori</label><input id="m-cat" name="category" maxlength="60"></div>
<label class="check" style="align-self:end"><input type="checkbox" name="webp" value="1" checked> Konversi JPG/PNG ke WebP</label></div>
<div class="toolbar"><button class="btn btn-primary" type="submit"><?= icon('plus', 14) ?> Unggah</button></div></form></div>
<form method="get" class="toolbar"><input type="search" name="q" value="<?= e($q) ?>" placeholder="Cari nama…"><select name="folder" data-autosubmit><option value="">Semua folder</option><?php foreach ($folders as $f): ?><option <?= $f === $folder ? 'selected' : '' ?>><?= e($f) ?></option><?php endforeach; ?></select><select name="tipe" data-autosubmit><option value="">Semua tipe</option><option value="gambar" <?= $type === 'gambar' ? 'selected' : '' ?>>Gambar</option><option value="pdf" <?= $type === 'pdf' ? 'selected' : '' ?>>PDF</option></select><button class="btn btn-outline" type="submit">Cari</button></form>
<div class="media-grid"><?php if (!$rows): ?><p class="muted">Belum ada media.</p><?php endif; ?>
<?php foreach ($rows as $m): ?><div class="media-item"><div class="pv"><?php if (str_starts_with($m['mime'], 'image/')): ?><img src="<?= e(upload_url($m['path'])) ?>" alt="<?= e($m['alt']) ?>" loading="lazy"><?php else: ?><?= icon('file', 36) ?><?php endif; ?></div>
<div class="mi"><b title="<?= e($m['filename']) ?>"><?= e($m['filename']) ?></b><span class="muted"><?= e($m['folder']) ?> · <?= number_format($m['size'] / 1024, 0) ?> KB</span><br>
<input readonly value="<?= e($m['path']) ?>" aria-label="Path file" style="margin-top:.3rem">
<details><summary>Ubah / hapus</summary>
<form method="post" action="<?= e(url('admin/media/' . $m['id'] . '/rename')) ?>"><?= Csrf::field() ?><input name="filename" value="<?= e($m['filename']) ?>" maxlength="200" required aria-label="Nama"><input name="alt" value="<?= e($m['alt']) ?>" placeholder="Teks alternatif" maxlength="200"><button class="btn btn-sm btn-outline" type="submit">Simpan</button></form>
<form method="post" action="<?= e(url('admin/media/' . $m['id'] . '/hapus')) ?>" data-confirm="Hapus file ini permanen?"><?= Csrf::field() ?><button class="btn btn-sm btn-danger" type="submit"><?= icon('trash', 13) ?> Hapus</button></form></details></div></div><?php endforeach; ?></div>
<?= pager($pg, ['q' => $q, 'folder' => $folder, 'tipe' => $type]) ?>
