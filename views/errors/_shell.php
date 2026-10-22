<?php /** @var string $code @var string $heading @var string $text */ ?>
<!doctype html><html lang="id"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><meta name="robots" content="noindex">
<title><?= e($code) ?> — <?= e($heading) ?></title>
<link rel="stylesheet" href="<?= e(asset('css/site.css')) ?>"></head>
<body><main style="min-height:100vh;display:grid;place-items:center;padding:2rem;background:linear-gradient(135deg,var(--navy),var(--primary));color:#fff;text-align:center">
<div style="max-width:520px"><div style="font-size:clamp(4rem,14vw,7rem);font-weight:800;color:var(--accent);line-height:1"><?= e($code) ?></div>
<h1 style="color:#fff;font-size:1.8rem;margin-top:.6rem"><?= e($heading) ?></h1><p style="color:#cfdcf2"><?= e($text) ?></p>
<p><a class="btn btn-accent" href="<?= e(url('/')) ?>">Kembali ke Beranda</a></p></div></main></body></html>
