<?php
declare(strict_types=1);

final class AdminPpdbController
{
    private const STATUSES = ['baru', 'terverifikasi', 'diterima', 'ditolak'];

    private function filters(): array
    {
        $w = ['r.deleted_at IS NULL']; $p = [];
        $q = trim((string)($_GET['q'] ?? '')); $st = (string)($_GET['status'] ?? ''); $mj = (int)($_GET['jurusan'] ?? 0);
        if ($q !== '') { $w[] = '(r.name LIKE ? OR r.nisn LIKE ? OR r.reg_number LIKE ?)'; array_push($p, "%$q%", "%$q%", "%$q%"); }
        if (in_array($st, self::STATUSES, true)) { $w[] = 'r.status=?'; $p[] = $st; }
        if ($mj) { $w[] = 'r.major_id=?'; $p[] = $mj; }
        return [implode(' AND ', $w), $p, $q, $st, $mj];
    }

    public function index(): void
    {
        [$where, $p, $q, $st, $mj] = $this->filters();
        $pg = paginate((int)Database::val("SELECT COUNT(*) FROM ppdb_registrants r WHERE $where", $p), 20, (int)($_GET['page'] ?? 1));
        View::admin('ppdb', [
            'title' => 'PPDB', 'cfg' => Site::ppdb(), 'period' => Site::activePeriod(), 'majors' => Site::majors(false), 'statuses' => self::STATUSES,
            'rows' => Database::all("SELECT r.*, m.code AS major_code FROM ppdb_registrants r JOIN majors m ON m.id=r.major_id WHERE $where ORDER BY r.id DESC LIMIT {$pg['per']} OFFSET {$pg['offset']}", $p),
            'pg' => $pg, 'q' => $q, 'st' => $st, 'mj' => $mj,
        ]);
    }

    public function show(string $id): void
    {
        $r = Database::one('SELECT r.*, m.name AS major_name, m.code AS major_code, p.name AS period_name FROM ppdb_registrants r JOIN majors m ON m.id=r.major_id JOIN ppdb_periods p ON p.id=r.period_id WHERE r.id=? AND r.deleted_at IS NULL', [(int)$id]);
        if (!$r) { http_response_code(404); View::raw('errors/404', []); return; }
        View::admin('ppdb-show', ['title' => $r['reg_number'], 'r' => $r, 'docs' => Database::all('SELECT * FROM ppdb_documents WHERE registrant_id=?', [$r['id']]), 'statuses' => self::STATUSES]);
    }

    public function status(string $id): void
    {
        $st = (string)($_POST['status'] ?? '');
        if (!in_array($st, self::STATUSES, true)) { flash('error', 'Status tidak valid.'); redirect('admin/ppdb/' . (int)$id); }
        Database::run('UPDATE ppdb_registrants SET status=?, note=? WHERE id=? AND deleted_at IS NULL', [$st, mb_substr(trim((string)($_POST['note'] ?? '')), 0, 300) ?: null, (int)$id]);
        log_activity('update', 'ppdb_registrants', (int)$id, "status=$st");
        flash('success', 'Status pendaftar diperbarui.'); redirect('admin/ppdb/' . (int)$id);
    }

    public function delete(string $id): void
    {
        Database::run('UPDATE ppdb_registrants SET deleted_at=NOW() WHERE id=?', [(int)$id]);
        log_activity('delete', 'ppdb_registrants', (int)$id);
        flash('success', 'Pendaftar dihapus (arsip).'); redirect('admin/ppdb');
    }

    public function export(): void
    {
        [$where, $p] = $this->filters();
        $rows = Database::all("SELECT r.reg_number,r.name,r.nisn,m.code,r.school_origin,r.birth_place,r.birth_date,r.gender,r.address,r.phone,r.email,r.father_name,r.mother_name,r.parent_job,r.parent_income,r.status,r.created_at FROM ppdb_registrants r JOIN majors m ON m.id=r.major_id WHERE $where ORDER BY r.id", $p);
        log_activity('export', 'ppdb_registrants', null, count($rows) . ' baris');
        header('Content-Type: text/csv; charset=utf-8');
        header('Content-Disposition: attachment; filename="pendaftar-ppdb-' . date('Ymd-His') . '.csv"');
        $out = fopen('php://output', 'w');
        fwrite($out, "\xEF\xBB\xBF");
        fputcsv($out, ['No Pendaftaran', 'Nama', 'NISN', 'Jurusan', 'Asal Sekolah', 'Tempat Lahir', 'Tgl Lahir', 'JK', 'Alamat', 'HP', 'Email', 'Ayah', 'Ibu', 'Pekerjaan', 'Penghasilan', 'Status', 'Tgl Daftar']);
        foreach ($rows as $r) fputcsv($out, array_map(fn($v) => is_string($v) && preg_match('/^[=+\-@\t\r]/', $v) ? "'" . $v : $v, array_values($r)));
        fclose($out);
    }

    public function saveSettings(): void
    {
        $s = fn(string $k, int $max) => mb_substr(trim((string)($_POST[$k] ?? '')), 0, $max);
        Database::run('UPDATE ppdb_settings SET is_open=?, info=?, requirements=?, fees=?, flow=?, closed_message=? WHERE id=1', [isset($_POST['is_open']) ? 1 : 0, $s('info', 3000), $s('requirements', 3000), $s('fees', 3000), $s('flow', 3000), $s('closed_message', 300)]);
        if (table_has('ppdb_settings', 'auto_accept')) Database::run('UPDATE ppdb_settings SET auto_accept=? WHERE id=1', [isset($_POST['auto_accept']) ? 1 : 0]);
        foreach (Site::majors(false) as $m) {
            $q = $_POST['quota'][$m['id']] ?? null;
            if ($q !== null && preg_match('/^\d{1,4}$/', (string)$q)) Database::run('UPDATE majors SET ppdb_quota=? WHERE id=?', [(int)$q, $m['id']]);
        }
        log_activity('settings', 'ppdb_settings', 1);
        flash('success', 'Pengaturan PPDB disimpan.'); redirect('admin/ppdb');
    }
}
