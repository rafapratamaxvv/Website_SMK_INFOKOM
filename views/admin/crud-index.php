<?php $base = 'admin/m/' . $c['key']; ?>
<div class="toolbar">
  <form method="get" class="toolbar" style="margin:0"><input type="search" name="q" value="<?= e($q) ?>" placeholder="Cari…" aria-label="Cari">
  <?php if ($hasDemo): ?><select name="demo" data-autosubmit aria-label="Filter data"><option value="">Semua</option><option value="0" <?= $demo === '0' ? 'selected' : '' ?>>Resmi</option><option value="1" <?= $demo === '1' ? 'selected' : '' ?>>Demo</option></select><?php endif; ?>
  <button class="btn btn-outline" type="submit"><?= icon('search', 14) ?> Cari</button></form>
  <span class="sp"></span>
  <?php if (empty($c['no_create'])): ?><a class="btn btn-primary" href="<?= e(url($base . '/baru')) ?>"><?= icon('plus', 14) ?> Tambah</a><?php endif; ?>
</div>
<div class="table-wrap"><table class="t"><thead><tr>
  <?php $imgFields = array_slice(array_column(array_filter($c['fields'], fn($f) => $f['type'] === 'image'), 'name'), 0, 2); foreach ($imgFields as $imn): $imLabel = array_values(array_filter($c['fields'], fn($f) => $f['name'] === $imn))[0]['label']; ?><th><?= e($imLabel) ?></th><?php endforeach; ?>
  <?php foreach ($c['cols'] as $label): ?><th><?= e($label) ?></th><?php endforeach; ?>
  <?php if (empty($c['no_active'])): ?><th>Status</th><?php endif; ?><th>Aksi</th></tr></thead><tbody>
<?php if (!$rows): ?><tr><td colspan="<?= count($c['cols']) + 3 ?>" class="muted">Belum ada data.</td></tr><?php endif; ?>
<?php foreach ($rows as $r): ?><tr>
  <?php foreach ($imgFields as $imn): ?><td><?php if (!empty($r[$imn])): ?><img class="thumb" src="<?= e(upload_url($r[$imn])) ?>" alt=""><?php else: ?><span class="muted">—</span><?php endif; ?></td><?php endforeach; ?>
  <?php foreach ($c['cols'] as $k => $label): $v = $r[$k] ?? ''; ?><td><?php
    if (isset($maps[$k])) echo e($maps[$k][(string)$v] ?? '—');
    elseif (in_array($k, ['show_in_bar', 'is_featured'], true)) echo $v ? '<span class="badge badge-ok">Ya</span>' : '<span class="badge">Tidak</span>';
    else echo e(mb_strimwidth((string)$v, 0, 70, '…'));
    if ($k === array_key_first($c['cols']) && !empty($r['is_demo'])) echo ' <span class="badge badge-demo">DEMO</span>'; ?></td><?php endforeach; ?>
  <?php if (empty($c['no_active'])): ?><td><form method="post" action="<?= e(url($base . '/' . $r['id'] . '/toggle')) ?>"><?= Csrf::field() ?><button class="badge <?= $r['is_active'] ? 'badge-ok' : 'badge-off' ?>" type="submit" style="border:0;cursor:pointer" title="Klik untuk ubah"><?= $r['is_active'] ? 'Tampil' : 'Disembunyikan' ?></button></form></td><?php endif; ?>
  <td class="act"><a class="btn btn-sm btn-outline" href="<?= e(url($base . '/' . $r['id'] . '/edit')) ?>"><?= icon('edit', 13) ?> Edit</a>
  <?php if (empty($c['no_delete'])): ?><form method="post" action="<?= e(url($base . '/' . $r['id'] . '/hapus')) ?>" data-confirm="Hapus data ini?"><?= Csrf::field() ?><button class="btn btn-sm btn-danger" type="submit"><?= icon('trash', 13) ?></button></form><?php endif; ?></td>
</tr><?php endforeach; ?></tbody></table></div>
<?= pager($pg, ['q' => $q, 'demo' => $demo]) ?>
