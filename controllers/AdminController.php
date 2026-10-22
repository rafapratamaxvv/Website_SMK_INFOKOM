<?php
declare(strict_types=1);

final class AdminController
{
    public function dashboard(): void
    {
        $count = fn(string $sql) => (int)Database::val($sql);
        View::admin('dashboard', [
            'title' => 'Dashboard',
            'stats' => [
                ['Berita', $count('SELECT COUNT(*) FROM news WHERE deleted_at IS NULL'), 'news'],
                ['Guru aktif', $count('SELECT COUNT(*) FROM teachers WHERE is_active=1'), 'teachers'],
                ['Pendaftar PPDB', $count('SELECT COUNT(*) FROM ppdb_registrants WHERE deleted_at IS NULL'), 'ppdb'],
                ['Pesan belum dibaca', $count('SELECT COUNT(*) FROM contact_messages WHERE is_read=0'), 'pesan'],
            ],
            'recent' => Auth::can('ppdb.manage') ? Database::all('SELECT r.id, r.reg_number, r.name, r.status, r.created_at, m.code FROM ppdb_registrants r JOIN majors m ON m.id=r.major_id WHERE r.deleted_at IS NULL ORDER BY r.id DESC LIMIT 5') : [],
            'logs' => Auth::can('logs.view') ? Database::all('SELECT l.*, u.name AS user_name FROM activity_logs l LEFT JOIN users u ON u.id=l.user_id ORDER BY l.id DESC LIMIT 8') : [],
            'demoCount' => $this->demoCount(),
        ]);
    }

    private function demoCount(): int
    {
        $n = 0;
        foreach (demo_tables() as $t) if (table_has($t, 'is_demo')) $n += (int)Database::val("SELECT COUNT(*) FROM `$t` WHERE is_demo=1");
        return $n;
    }

    public function imageGuide(): void
    {
        View::admin('image-guide', ['title' => 'Panduan Gambar / Foto']);
    }

    public function account(): void { View::admin('account', ['title' => 'Akun Saya']); }

    public function accountSave(): void
    {
        $u = Auth::user();
        $full = Database::one('SELECT * FROM users WHERE id=?', [$u['id']]);
        $cur = (string)($_POST['current'] ?? ''); $new = (string)($_POST['new'] ?? ''); $rep = (string)($_POST['repeat'] ?? '');
        $name = trim((string)($_POST['name'] ?? ''));
        if ($name === '' || mb_strlen($name) > 100) { flash('error', 'Nama wajib diisi (maks 100 karakter).'); redirect('admin/akun'); }
        if (!password_verify($cur, $full['password'])) { flash('error', 'Password saat ini salah.'); redirect('admin/akun'); }
        $upd = ['name' => $name];
        if ($new !== '') {
            if (strlen($new) < 10 || !preg_match('/[A-Za-z]/', $new) || !preg_match('/\d/', $new)) { flash('error', 'Password baru minimal 10 karakter, mengandung huruf dan angka.'); redirect('admin/akun'); }
            if ($new !== $rep) { flash('error', 'Konfirmasi password tidak sama.'); redirect('admin/akun'); }
            $upd['password'] = password_hash($new, PASSWORD_DEFAULT);
            $upd['must_change_password'] = 0;
            session_regenerate_id(true);
        }
        Database::update('users', (int)$u['id'], $upd);
        log_activity('update', 'users', (int)$u['id'], 'Ubah akun sendiri' . ($new !== '' ? ' + password' : ''));
        flash('success', 'Akun diperbarui.');
        redirect('admin/akun');
    }

    public function messages(): void
    {
        Database::run('UPDATE contact_messages SET is_read=1 WHERE is_read=0 AND id IN (SELECT id FROM (SELECT id FROM contact_messages ORDER BY id DESC LIMIT 20) t)');
        $pg = paginate((int)Database::val('SELECT COUNT(*) FROM contact_messages'), 20, (int)($_GET['page'] ?? 1));
        View::admin('messages', ['title' => 'Pesan Kontak', 'rows' => Database::all("SELECT * FROM contact_messages ORDER BY id DESC LIMIT {$pg['per']} OFFSET {$pg['offset']}"), 'pg' => $pg]);
    }

    public function messageDelete(string $id): void
    {
        Database::run('DELETE FROM contact_messages WHERE id=?', [(int)$id]);
        log_activity('delete', 'contact_messages', (int)$id);
        flash('success', 'Pesan dihapus.'); redirect('admin/pesan');
    }

    public function logs(): void
    {
        $pg = paginate((int)Database::val('SELECT COUNT(*) FROM activity_logs'), 30, (int)($_GET['page'] ?? 1));
        View::admin('logs', ['title' => 'Activity Logs', 'rows' => Database::all("SELECT l.*, u.name AS user_name FROM activity_logs l LEFT JOIN users u ON u.id=l.user_id ORDER BY l.id DESC LIMIT {$pg['per']} OFFSET {$pg['offset']}"), 'pg' => $pg]);
    }

    public function deleteDemo(): void
    {
        if (trim((string)($_POST['confirm'] ?? '')) !== 'HAPUS DEMO') { flash('error', 'Ketik HAPUS DEMO untuk konfirmasi.'); redirect('admin/dashboard'); }
        $total = 0;
        foreach (demo_tables() as $t) if (table_has($t, 'is_demo')) $total += Database::run("DELETE FROM `$t` WHERE is_demo=1");
        log_activity('delete', 'demo_data', null, "Hapus semua data demo ($total baris)");
        flash('success', "Data demo dihapus ($total baris). Jurusan, halaman profil, dan pengaturan resmi tidak ikut terhapus.");
        redirect('admin/dashboard');
    }
}
