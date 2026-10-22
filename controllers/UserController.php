<?php
declare(strict_types=1);

final class UserController
{
    public function index(): void
    {
        View::admin('users', ['title' => 'Users', 'rows' => Database::all('SELECT u.*, r.name AS role_name FROM users u JOIN roles r ON r.id=u.role_id ORDER BY u.id')]);
    }

    public function form(?string $id = null): void
    {
        $row = $id ? Database::one('SELECT * FROM users WHERE id=?', [(int)$id]) : null;
        if ($id && !$row) { http_response_code(404); View::raw('errors/404', []); return; }
        View::admin('user-form', ['title' => $row ? 'Edit User' : 'Tambah User', 'row' => $row, 'roles' => Database::all('SELECT * FROM roles ORDER BY id')]);
    }

    public function save(): void
    {
        $id = (int)($_POST['id'] ?? 0);
        $v = new Validator($_POST);
        $v->str('name', 'Nama', true, 100, 3)->email('email', 'Email')->int('role_id', 'Role', 1, 99);
        $pass = (string)($_POST['password'] ?? '');
        if (!Database::one('SELECT id FROM roles WHERE id=?', [$v->data['role_id']])) $v->errors['role_id'] = 'Role tidak valid.';
        if (($id === 0 || $pass !== '') && (strlen($pass) < 10 || !preg_match('/[A-Za-z]/', $pass) || !preg_match('/\d/', $pass))) $v->errors['password'] = 'Password minimal 10 karakter, mengandung huruf dan angka.';
        if (!isset($v->errors['email']) && Database::val('SELECT COUNT(*) FROM users WHERE email=? AND id<>?', [mb_strtolower($v->data['email']), $id]) > 0) $v->errors['email'] = 'Email sudah terdaftar.';
        $self = (int)Auth::user()['id'];
        $active = isset($_POST['is_active']) ? 1 : 0;
        if ($id === $self && !$active) $v->errors['is_active'] = 'Anda tidak dapat menonaktifkan akun sendiri.';
        if ($id === $self && (int)$v->data['role_id'] !== (int)Auth::user()['role_id']) $v->errors['role_id'] = 'Anda tidak dapat mengubah role akun sendiri.';
        if ($v->fails()) { with_old($_POST, $v->errors); flash('error', 'Periksa isian.'); redirect($id ? "admin/users/$id/edit" : 'admin/users/baru'); }
        $d = ['name' => $v->data['name'], 'email' => mb_strtolower($v->data['email']), 'role_id' => $v->data['role_id'], 'is_active' => $active];
        if ($pass !== '') { $d['password'] = password_hash($pass, PASSWORD_DEFAULT); $d['must_change_password'] = 1; }
        if ($id) { Database::update('users', $id, $d); log_activity('update', 'users', $id, $d['email']); }
        else { $id = Database::insert('users', $d); log_activity('create', 'users', $id, $d['email']); }
        clear_old(); flash('success', 'User disimpan.'); redirect('admin/users');
    }

    public function delete(string $id): void
    {
        $id = (int)$id;
        if ($id === (int)Auth::user()['id']) { flash('error', 'Tidak dapat menghapus akun sendiri.'); redirect('admin/users'); }
        $u = Database::one('SELECT u.*, r.slug FROM users u JOIN roles r ON r.id=u.role_id WHERE u.id=?', [$id]);
        if ($u && $u['slug'] === 'super_admin' && (int)Database::val("SELECT COUNT(*) FROM users u JOIN roles r ON r.id=u.role_id WHERE r.slug='super_admin' AND u.is_active=1") <= 1) { flash('error', 'Tidak dapat menghapus Super Admin terakhir.'); redirect('admin/users'); }
        if ($u) { Database::run('DELETE FROM users WHERE id=?', [$id]); log_activity('delete', 'users', $id, $u['email']); }
        flash('success', 'User dihapus.'); redirect('admin/users');
    }

    public function roles(): void
    {
        $roles = Database::all("SELECT * FROM roles WHERE slug<>'super_admin' ORDER BY id");
        $perms = Database::all('SELECT * FROM permissions ORDER BY id');
        $has = [];
        foreach (Database::all('SELECT * FROM role_permissions') as $r) $has[$r['role_id']][$r['permission_id']] = true;
        View::admin('roles', ['title' => 'Roles & Permissions', 'roles' => $roles, 'perms' => $perms, 'has' => $has]);
    }

    public function rolesSave(): void
    {
        $roles = array_column(Database::all("SELECT id FROM roles WHERE slug<>'super_admin'"), 'id');
        $perms = array_column(Database::all('SELECT id FROM permissions'), 'id');
        $pdo = Database::pdo(); $pdo->beginTransaction();
        foreach ($roles as $rid) {
            Database::run('DELETE FROM role_permissions WHERE role_id=?', [$rid]);
            foreach ($perms as $pid) if (!empty($_POST['rp'][$rid][$pid])) Database::run('INSERT INTO role_permissions (role_id,permission_id) VALUES (?,?)', [$rid, $pid]);
        }
        $pdo->commit();
        log_activity('update', 'role_permissions', null, 'Matriks izin diperbarui');
        flash('success', 'Izin role disimpan.'); redirect('admin/roles');
    }
}
