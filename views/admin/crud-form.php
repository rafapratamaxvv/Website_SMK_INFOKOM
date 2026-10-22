<?php $base = 'admin/m/' . $c['key']; $err = $_SESSION['_errors'] ?? []; $old = $_SESSION['_old'] ?? []; ?>
<div class="panel"><form class="form" method="post" action="<?= e(url($base . '/simpan')) ?>" enctype="multipart/form-data"><?= Csrf::field() ?>
<?php if ($row): ?><input type="hidden" name="id" value="<?= (int)$row['id'] ?>"><?php endif; ?>
<?php foreach ($c['fields'] as $f): $n = $f['name']; $val = $old[$n] ?? ($row[$n] ?? ($f['default'] ?? '')); $req = !empty($f['required']); $id = 'f-' . $n; ?>
<div class="field <?= isset($err[$n]) ? 'has-error' : '' ?>"<?= !empty($f['only_if']) ? ' data-only-if="' . e($f['only_if'][0] . '=' . $f['only_if'][1]) . '"' : '' ?>>
<?php switch ($f['type']):
 case 'bool': ?><label class="check"><input type="checkbox" name="<?= e($n) ?>" value="1" <?= ($old ? isset($old[$n]) : !empty($val)) ? 'checked' : '' ?>> <?= e($f['label']) ?></label><?php break;
 default: ?><label for="<?= e($id) ?>"><?= e($f['label']) ?><?= $req ? ' <span class="req">*</span>' : '' ?></label><?php
 switch ($f['type']) {
   case 'textarea': echo '<textarea id="' . e($id) . '" name="' . e($n) . '" maxlength="' . (int)($f['max'] ?? 5000) . '"' . ($req ? ' required' : '') . '>' . e($val) . '</textarea>'; break;
   case 'html': echo '<textarea class="html" id="' . e($id) . '" name="' . e($n) . '"' . ($req ? ' required' : '') . '>' . e($val) . '</textarea><div class="hint">Boleh HTML dasar: &lt;p&gt;, &lt;h2&gt;, &lt;ul&gt;, &lt;a&gt;, &lt;strong&gt;, &lt;img&gt;. Skrip dan atribut berbahaya otomatis dibuang.</div>'; break;
   case 'select': echo '<select id="' . e($id) . '" name="' . e($n) . '"' . ($req ? ' required' : '') . '>';
     if (!$req || isset($f['options']['blank'])) echo '<option value="' . e($f['options']['blank_value'] ?? '') . '">' . e($f['options']['blank'] ?? '— Pilih —') . '</option>';
     foreach ($opts[$n] as $k => $l) echo '<option value="' . e($k) . '"' . ((string)$val === (string)$k ? ' selected' : '') . '>' . e($l) . '</option>';
     echo '</select>'; break;
   case 'image': case 'file': case 'video':
     $multi = ($c['multi_image'] ?? null) === $n && !$row;
     echo '<input id="' . e($id) . '" type="file" name="' . e($n) . ($multi ? '[]' : '') . '" accept="' . ($f['type'] === 'image' ? 'image/jpeg,image/png,image/webp,image/gif' : ($f['type'] === 'video' ? 'video/mp4,video/webm,video/quicktime' : 'application/pdf')) . '"' . ($multi ? ' multiple' : '') . ($f['type'] === 'image' ? ' data-preview="pv-' . e($n) . '"' : '') . ($req && !$row ? ' required' : '') . '>';
     if ($row && !empty($row[$n])) { echo '<div class="preview">' . ($f['type'] === 'image' ? '<img id="pv-' . e($n) . '" src="' . e(upload_url($row[$n])) . '" alt="">' : ($f['type'] === 'video' ? '<video src="' . e(upload_url($row[$n])) . '" controls preload="metadata" style="max-width:320px;border-radius:8px"></video>' : '<a href="' . e(upload_url($row[$n])) . '" target="_blank" rel="noopener">Lihat file saat ini</a>')) . '<label class="check" style="font-weight:400"><input type="checkbox" name="' . e($n) . '_remove" value="1"> Hapus</label></div>'; }
     elseif ($f['type'] === 'image') echo '<div class="preview"><img id="pv-' . e($n) . '" alt="" hidden></div>';
     echo '<div class="hint">' . ($f['type'] === 'image' ? 'JPG/PNG/WebP/GIF, maks 5 MB.' : ($f['type'] === 'video' ? 'MP4 / WebM / MOV, maks 50 MB (batas server PHP juga berlaku, lihat php.ini: upload_max_filesize &amp; post_max_size).' : 'PDF, maks 10 MB.')) . ' Kosongkan jika tidak diganti.' . (!empty($f['hint']) ? ' ' . e($f['hint']) : '') . '</div>'; break;
   case 'datetime': echo '<input id="' . e($id) . '" type="datetime-local" name="' . e($n) . '" value="' . e($val ? date('Y-m-d\TH:i', strtotime((string)$val)) : date('Y-m-d\TH:i')) . '">'; break;
   case 'date': echo '<input id="' . e($id) . '" type="date" name="' . e($n) . '" value="' . e($val) . '"' . ($req ? ' required' : '') . '>'; break;
   case 'number': echo '<input id="' . e($id) . '" type="number" name="' . e($n) . '" value="' . e($val) . '"' . (isset($f['min']) ? ' min="' . (int)$f['min'] . '"' : ' min="0"') . (isset($f['max']) ? ' max="' . (int)$f['max'] . '"' : '') . ($req ? ' required' : '') . '>'; break;
   default: echo '<input id="' . e($id) . '" type="' . ($f['type'] === 'url' ? 'url' : 'text') . '" name="' . e($n) . '" value="' . e($val) . '" maxlength="' . (int)($f['max'] ?? 255) . '"' . ($req ? ' required' : '') . (isset($suggest[$n]) ? ' list="dl-' . e($n) . '" autocomplete="off"' : '') . '>';
     if (!empty($f['hint']) && $f['type'] === 'url') echo '<div class="hint">' . e($f['hint']) . '</div>';
     if (isset($suggest[$n])) { echo '<datalist id="dl-' . e($n) . '">'; foreach ($suggest[$n] as $sv) echo '<option value="' . e($sv) . '">'; echo '</datalist><div class="hint">Ketik kategori baru apa saja, atau klik kolom ini untuk memilih dari kategori yang sudah ada.</div>'; }
 }
endswitch; ?>
<?php if (isset($err[$n])): ?><small class="field-error"><?= e($err[$n]) ?></small><?php endif; ?></div>
<?php endforeach; ?>
<div class="toolbar"><button class="btn btn-primary" type="submit"><?= icon('check', 14) ?> Simpan</button><a class="btn btn-outline" href="<?= e(url($base)) ?>">Batal</a></div>
</form></div><?php clear_old(); ?>
