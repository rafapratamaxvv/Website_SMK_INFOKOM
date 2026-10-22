<!doctype html><html lang="id"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><meta name="robots" content="noindex,nofollow"><title>Masuk Admin — <?= e(setting('school_short', 'SMK Infokom')) ?></title>
<link rel="icon" href="<?= e(asset('images/favicon.svg')) ?>"><link rel="stylesheet" href="<?= e(asset('css/admin.css')) ?>"></head>
<body><div class="login-wrap"><div class="login-card">
<?php if (setting('logo')): ?><span class="brand-logo brand-logo-lg"><img src="<?= e(upload_url(setting('logo'))) ?>" alt="" width="64" height="64"></span><?php else: ?><span class="brand-mark" style="display:grid"><?= icon('cpu', 24) ?></span><?php endif; ?><h1>Masuk Admin</h1><p><?= e(setting('school_name', 'SMK INFOKOM KOTA BOGOR')) ?></p>
<?php if (!empty($flash)): ?><div class="alert alert-<?= e($flash['type']) ?>" role="alert"><?= e($flash['msg']) ?></div><?php endif; ?>
<form class="form" method="post" action="<?= e(url('admin/login')) ?>" autocomplete="off"><?= Csrf::field() ?>
<div class="field"><label for="email">Email</label><input id="email" type="email" name="email" required maxlength="150" autofocus></div>
<div class="field"><label for="password">Password</label><input id="password" type="password" name="password" required maxlength="200" autocomplete="current-password"></div>
<button class="btn btn-primary" type="submit" style="justify-content:center">Masuk</button></form>
<p class="hint" style="margin-top:1rem"><a href="<?= e(url('/')) ?>">&larr; Kembali ke situs</a></p></div></div></body></html>
