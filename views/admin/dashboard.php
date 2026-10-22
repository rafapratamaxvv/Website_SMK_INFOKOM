<?php if (!empty(Auth::user()) && Database::val('SELECT must_change_password FROM users WHERE id=?', [Auth::user()['id']])): ?>
<div class="alert alert-warning"><strong>Ganti password Anda.</strong> Akun ini masih memakai password awal. <a href="<?= e(url('admin/akun')) ?>">Ubah sekarang</a>.</div><?php endif; ?>
<div class="cards"><?php foreach ($stats as [$l, $v, $k]): ?><div class="kpi"><b><?= (int)$v ?></b><span><?= e($l) ?></span></div><?php endforeach; ?></div>
<div class="row2">
<?php if ($recent): ?><div class="panel"><h2>Pendaftar PPDB terbaru</h2><div class="table-wrap"><table class="t"><thead><tr><th>No</th><th>Nama</th><th>Jurusan</th><th>Status</th></tr></thead><tbody><?php foreach ($recent as $r): ?><tr><td><a href="<?= e(url('admin/ppdb/' . $r['id'])) ?>"><?= e($r['reg_number']) ?></a></td><td><?= e($r['name']) ?></td><td><?= e($r['code']) ?></td><td><span class="badge"><?= e($r['status']) ?></span></td></tr><?php endforeach; ?></tbody></table></div></div><?php endif; ?>
<?php if ($logs): ?><div class="panel"><h2>Aktivitas terakhir</h2><div class="table-wrap"><table class="t"><tbody><?php foreach ($logs as $l): ?><tr><td><?= e($l['user_name'] ?: 'sistem') ?></td><td><span class="badge"><?= e($l['action']) ?></span> <?= e($l['module']) ?></td><td><?= e(fmt_date($l['created_at'], 'd M H:i')) ?></td></tr><?php endforeach; ?></tbody></table></div></div><?php endif; ?>
</div>
<?php if (Auth::user()['role'] === 'super_admin'): ?>
<div class="panel danger-zone"><h2>Data Demo</h2><p>Saat ini terdapat <strong><?= (int)$demoCount ?></strong> baris data demo (berlabel <span class="badge badge-demo">DATA DEMO</span> di website). Data resmi tidak ikut terhapus.</p>
<form method="post" action="<?= e(url('admin/demo/hapus')) ?>" class="toolbar" data-confirm="Hapus SEMUA data demo? Tindakan ini tidak dapat dibatalkan."><?= Csrf::field() ?><input name="confirm" placeholder="Ketik: HAPUS DEMO" required autocomplete="off"><button class="btn btn-danger" type="submit"><?= icon('trash', 16) ?> Hapus Semua Data Demo</button></form></div>
<?php endif; ?>
