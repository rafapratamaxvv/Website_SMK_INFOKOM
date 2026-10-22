<div class="panel" style="max-width:560px"><form class="form" method="post" action="<?= e(url('admin/akun')) ?>"><?= Csrf::field() ?>
<div class="field"><label>Nama</label><input name="name" required maxlength="100" value="<?= e(Auth::user()['name']) ?>"></div>
<div class="field"><label>Email</label><input value="<?= e(Auth::user()['email']) ?>" disabled></div>
<div class="field"><label>Password saat ini <span class="req">*</span></label><input type="password" name="current" required autocomplete="current-password"></div>
<div class="row2"><div class="field"><label>Password baru</label><input type="password" name="new" autocomplete="new-password"><div class="hint">Min. 10 karakter, huruf dan angka. Kosongkan jika tidak diganti.</div></div><div class="field"><label>Ulangi password baru</label><input type="password" name="repeat" autocomplete="new-password"></div></div>
<div class="toolbar"><button class="btn btn-primary" type="submit">Simpan</button></div></form></div>
