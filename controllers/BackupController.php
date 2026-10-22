<?php
declare(strict_types=1);

final class BackupController
{
    private const HEADER = '-- SMK-INFOKOM-BACKUP v1';

    private function dir(): string { $d = BASE_PATH . '/storage/backups'; if (!is_dir($d)) mkdir($d, 0750, true); return $d; }

    public function index(): void
    {
        $files = [];
        foreach (glob($this->dir() . '/backup-*.sql') ?: [] as $f) $files[] = ['name' => basename($f), 'size' => filesize($f), 'time' => filemtime($f)];
        usort($files, fn($a, $b) => $b['time'] <=> $a['time']);
        View::admin('backup', ['title' => 'Backup & Restore', 'files' => $files]);
    }

    public function create(): void
    {
        $pdo = Database::pdo();
        $name = 'backup-' . date('Ymd-His') . '-' . bin2hex(random_bytes(4)) . '.sql';
        $fh = fopen($this->dir() . '/' . $name, 'wb');
        fwrite($fh, self::HEADER . "\nSET NAMES utf8mb4;\nSET FOREIGN_KEY_CHECKS=0;\n");
        foreach ($pdo->query('SHOW TABLES')->fetchAll(PDO::FETCH_COLUMN) as $t) {
            if (!preg_match('/^[a-z0-9_]+$/i', $t)) continue;
            $create = $pdo->query("SHOW CREATE TABLE `$t`")->fetch(PDO::FETCH_NUM)[1];
            fwrite($fh, "DROP TABLE IF EXISTS `$t`;\n" . preg_replace('/\s*\n\s*/', ' ', $create) . ";\n");
            $st = $pdo->query("SELECT * FROM `$t`");
            while ($row = $st->fetch(PDO::FETCH_NUM)) {
                $vals = array_map(fn($v) => $v === null ? 'NULL' : (is_int($v) || is_float($v) ? (string)$v : "X'" . bin2hex((string)$v) . "'"), $row);
                fwrite($fh, "INSERT INTO `$t` VALUES (" . implode(',', $vals) . ");\n");
            }
        }
        fwrite($fh, "SET FOREIGN_KEY_CHECKS=1;\n");
        fclose($fh);
        log_activity('create', 'backup', null, $name);
        flash('success', 'Backup dibuat: ' . $name); redirect('admin/backup');
    }

    public function download(string $file): void
    {
        if (!preg_match('/^backup-\d{8}-\d{6}-[a-f0-9]{8}\.sql$/', $file) || !is_file($this->dir() . '/' . $file)) { http_response_code(404); View::raw('errors/404', []); return; }
        log_activity('export', 'backup', null, $file);
        header('Content-Type: application/sql');
        header('Content-Disposition: attachment; filename="' . $file . '"');
        header('Content-Length: ' . filesize($this->dir() . '/' . $file));
        readfile($this->dir() . '/' . $file);
    }

    public function restore(): void
    {
        if (trim((string)($_POST['confirm'] ?? '')) !== 'RESTORE') { flash('error', 'Ketik RESTORE untuk konfirmasi.'); redirect('admin/backup'); }
        $path = null;
        $named = (string)($_POST['file'] ?? '');
        if ($named !== '') {
            if (!preg_match('/^backup-\d{8}-\d{6}-[a-f0-9]{8}\.sql$/', $named) || !is_file($this->dir() . '/' . $named)) { flash('error', 'File backup tidak ditemukan.'); redirect('admin/backup'); }
            $path = $this->dir() . '/' . $named;
        } elseif (isset($_FILES['sql']) && $_FILES['sql']['error'] === UPLOAD_ERR_OK && is_uploaded_file($_FILES['sql']['tmp_name'])) {
            if (strtolower(pathinfo($_FILES['sql']['name'], PATHINFO_EXTENSION)) !== 'sql' || $_FILES['sql']['size'] > 52428800) { flash('error', 'File harus .sql (maks 50 MB).'); redirect('admin/backup'); }
            $path = $_FILES['sql']['tmp_name'];
        } else { flash('error', 'Pilih backup atau unggah file .sql.'); redirect('admin/backup'); }

        $fh = fopen($path, 'rb');
        if (!$fh || rtrim((string)fgets($fh)) !== self::HEADER) { flash('error', 'Bukan file backup SMK Infokom yang valid.'); redirect('admin/backup'); }
        $pdo = Database::pdo(); $n = 0;
        try {
            while (($line = fgets($fh)) !== false) {
                $line = trim($line);
                if ($line === '') continue;
                if (!preg_match('/^(DROP TABLE IF EXISTS `[a-z0-9_]+`|CREATE TABLE `[a-z0-9_]+` |INSERT INTO `[a-z0-9_]+` VALUES \(|SET NAMES utf8mb4|SET FOREIGN_KEY_CHECKS=[01])/i', $line)) throw new RuntimeException('Perintah tidak diizinkan pada baris ' . ($n + 1));
                $pdo->exec($line); $n++;
            }
        } catch (Throwable $e) {
            error_log('Restore: ' . $e->getMessage());
            @$pdo->exec('SET FOREIGN_KEY_CHECKS=1');
            fclose($fh);
            flash('error', 'Restore gagal: ' . (env('APP_DEBUG') === 'true' ? $e->getMessage() : 'cek storage/logs/php-error.log'));
            redirect('admin/backup');
        }
        fclose($fh);
        Auth::logout(false);
        Auth::startSession();
        flash('success', "Restore selesai ($n perintah). Silakan login kembali.");
        redirect('admin/login');
    }
}
