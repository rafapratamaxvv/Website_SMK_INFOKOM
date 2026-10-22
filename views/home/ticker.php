<?php
$custom = lines(setting('marquee_text'));
if ($custom) { $items = $custom; }
else {
    $items = [setting('tagline', 'SMK, Bisa...! SMK INFOKOM, Luar Biasa…!'), 'Siap Kerja', 'Siap Kuliah', 'Siap Berwirausaha'];
    foreach ($majors ?? [] as $m) $items[] = $m['code'] . ' — ' . $m['name'];
    $items[] = 'PPDB Dibuka — Daftar Online Sekarang';
}
$loop = array_merge($items, $items);
?>
<section class="ticker" aria-label="Info sekolah"><div class="ticker-track">
<?php foreach ($loop as $i => $t): ?><span class="ticker-item" <?= $i >= count($items) ? 'aria-hidden="true"' : '' ?>><?= icon('star', 16) ?> <?= e($t) ?></span><?php endforeach; ?>
</div></section>
