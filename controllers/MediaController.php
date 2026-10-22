<?php
declare(strict_types=1);

final class MediaController
{
    public function index(): void
    {
        $q = trim((string)($_GET['q'] ?? '')); $folder = trim((string)($_GET['folder'] ?? '')); $type = $_GET['tipe'] ?? '';
        $w = ['1=1']; $p = [];
        if ($q !== '') { $w[] = '(filename LIKE ? OR alt LIKE ?)'; $p[] = "%$q%"; $p[] = "%$q%"; }
        if ($folder !== '') { $w[] = 'folder=?'; $p[] = $folder; }
        if ($type === 'gambar') $w[] = "mime LIKE 'image/%'"; elseif ($type === 'pdf') $w[] = "mime='application/pdf'";
        $where = implode(' AND ', $w);
        $pg = paginate((int)Database::val("SELECT COUNT(*) FROM media WHERE $where", $p), 24, (int)($_GET['page'] ?? 1));
        View::admin('media', [
            'title' => 'Media Library', 'rows' => Database::all("SELECT * FROM media WHERE $where ORDER BY id DESC LIMIT {$pg['per']} OFFSET {$pg['offset']}", $p),
            'pg' => $pg, 'q' => $q, 'folder' => $folder, 'type' => $type,
            'folders' => array_column(Database::all('SELECT DISTINCT folder FROM media ORDER BY folder'), 'folder'),
        ]);
    }

    public function upload(): void
    {
        $folder = preg_replace('/[^a-z0-9_-]/i', '', (string)($_POST['folder'] ?? 'umum')) ?: 'umum';
        $category = mb_substr(trim((string)($_POST['category'] ?? '')), 0, 60) ?: null;
        $toWebp = !empty($_POST['webp']) && function_exists('imagewebp');
        $files = $_FILES['files'] ?? null; $ok = 0; $errs = [];
        if ($files && is_array($files['name'])) {
            foreach ($files['name'] as $i => $name) {
                $f = ['name' => $name, 'type' => $files['type'][$i], 'tmp_name' => $files['tmp_name'][$i], 'error' => $files['error'][$i], 'size' => $files['size'][$i]];
                if ($f['error'] === UPLOAD_ERR_NO_FILE) continue;
                $r = Upload::save($f, 'media/' . $folder, Upload::IMAGES + Upload::DOCS, 8388608);
                if (!$r['ok']) { $errs[] = $name . ': ' . $r['error']; continue; }
                $path = $r['path']; $mime = $r['mime']; $size = $r['size'];
                if ($toWebp && in_array($mime, ['image/jpeg', 'image/png'], true)) {
                    $abs = BASE_PATH . '/' . $path;
                    $im = $mime === 'image/png' ? @imagecreatefrompng($abs) : @imagecreatefromjpeg($abs);
                    if ($im) {
                        if ($mime === 'image/png') { imagepalettetotruecolor($im); imagealphablending($im, true); imagesavealpha($im, true); }
                        $newRel = preg_replace('/\.(jpe?g|png)$/i', '.webp', $path);
                        if (imagewebp($im, BASE_PATH . '/' . $newRel, 82)) { @unlink($abs); $path = $newRel; $mime = 'image/webp'; $size = (int)filesize(BASE_PATH . '/' . $path); }
                        imagedestroy($im);
                    }
                }
                $id = Database::insert('media', ['filename' => mb_substr($r['name'], 0, 200), 'path' => $path, 'mime' => $mime, 'size' => $size, 'folder' => $folder, 'category' => $category, 'uploaded_by' => Auth::user()['id']]);
                log_activity('upload', 'media', $id, $r['name']);
                $ok++;
            }
        }
        if ($ok) flash($errs ? 'warning' : 'success', "$ok file diunggah." . ($errs ? ' Gagal: ' . implode('; ', $errs) : ''));
        else flash('error', $errs ? implode('; ', $errs) : 'Pilih file terlebih dahulu.');
        redirect('admin/media');
    }

    public function rename(string $id): void
    {
        $name = trim((string)($_POST['filename'] ?? ''));
        if ($name === '' || mb_strlen($name) > 200) { flash('error', 'Nama file tidak valid.'); redirect('admin/media'); }
        Database::run('UPDATE media SET filename=?, alt=? WHERE id=?', [$name, mb_substr(trim((string)($_POST['alt'] ?? '')), 0, 200) ?: null, (int)$id]);
        log_activity('update', 'media', (int)$id, $name);
        flash('success', 'Nama media diperbarui.'); redirect('admin/media');
    }

    public function delete(string $id): void
    {
        $m = Database::one('SELECT * FROM media WHERE id=?', [(int)$id]);
        if ($m) { Upload::delete($m['path']); Database::run('DELETE FROM media WHERE id=?', [(int)$id]); log_activity('delete', 'media', (int)$id, $m['filename']); }
        flash('success', 'Media dihapus.'); redirect('admin/media');
    }
}
