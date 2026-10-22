<?php $err = $_SESSION['_errors'] ?? []; $old = $_SESSION['_old'] ?? []; ?>
<form class="form" method="post" action="<?= e(url('admin/settings')) ?>" enctype="multipart/form-data"><?= Csrf::field() ?>
<?php foreach ($groups as $group => $fields): ?><div class="panel"><h2><?= e($group) ?></h2><?php if ($group === 'Chatbot'): $m = ChatController::mode(); ?><div class="alert <?= $m === 'kb' ? 'alert-warning' : 'alert-success' ?>" style="margin-top:0">Mode saat ini: <strong><?= $m === 'gemini' ? 'AI Google Gemini' : ($m === 'anthropic' ? 'AI Anthropic Claude' : 'Standar (tanpa AI, menjawab dari data website)') ?></strong>. <?= $m === 'kb' ? 'Untuk mengaktifkan AI, isi GEMINI_API_KEY di file .env (lihat README).' : 'Jika AI gagal/timeout, chatbot otomatis memakai mode standar.' ?></div><?php endif; ?><div class="form">
<?php foreach ($fields as [$k, $label, $type]): $val = $old[$k] ?? setting($k); ?>
<div class="field <?= isset($err[$k]) ? 'has-error' : '' ?>"><label for="s-<?= e($k) ?>"><?= e($label) ?></label>
<?php if ($type === 'bool'): ?><label class="check"><input type="checkbox" id="s-<?= e($k) ?>" name="<?= e($k) ?>" value="1" <?= ($old ? isset($old[$k]) : setting($k, '1') === '1') ? 'checked' : '' ?>> Ya</label>
<?php elseif ($type === 'textarea'): ?><textarea id="s-<?= e($k) ?>" name="<?= e($k) ?>" maxlength="2000"><?= e($val) ?></textarea>
<?php elseif ($type === 'image'): ?><input id="s-<?= e($k) ?>" type="file" name="<?= e($k) ?>" accept="image/*" data-preview="pv-<?= e($k) ?>">
  <div class="preview"><img id="pv-<?= e($k) ?>" src="<?= e($val ? upload_url($val) : '') ?>" alt="" <?= $val ? '' : 'hidden' ?>><?php if ($val): ?><label class="check" style="font-weight:400"><input type="checkbox" name="<?= e($k) ?>_remove" value="1"> Hapus</label><?php endif; ?></div>
<?php elseif ($type === 'color'): ?><input id="s-<?= e($k) ?>" type="color" name="<?= e($k) ?>" value="<?= e($val ?: '#0B4DA2') ?>" style="width:90px;height:42px;padding:2px">
<?php else: ?><input id="s-<?= e($k) ?>" type="<?= e($type === 'tel' ? 'tel' : $type) ?>" name="<?= e($k) ?>" value="<?= e($val) ?>" maxlength="2000"><?php endif; ?>
<?php if (isset($err[$k])): ?><small class="field-error"><?= e($err[$k]) ?></small><?php endif; ?></div>
<?php endforeach; ?></div></div><?php endforeach; ?>
<div class="toolbar"><button class="btn btn-primary" type="submit"><?= icon('check', 14) ?> Simpan Pengaturan</button></div></form><?php clear_old(); ?>
