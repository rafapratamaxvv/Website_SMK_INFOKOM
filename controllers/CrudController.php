<?php
declare(strict_types=1);

final class CrudController
{
    private function cfg(string $module): array
    {
        $all = modules();
        if (!isset($all[$module])) { http_response_code(404); View::raw('errors/404', []); exit; }
        $c = $all[$module];
        if (!Auth::can($c['perm'])) {
            http_response_code(403);
            View::raw('errors/403', ['msg' => 'Anda tidak memiliki izin untuk modul ini.']);
            exit;
        }
        $c['key'] = $module;
        return $c;
    }

    public function index(string $module): void
    {
        $c = $this->cfg($module);
        $t = $c['table'];
        $hasDemo = empty($c['no_demo']) && table_has($t, 'is_demo');
        $w = ['1=1']; $p = [];
        if (!empty($c['soft'])) $w[] = 'deleted_at IS NULL';
        $q = trim((string)($_GET['q'] ?? ''));
        if ($q !== '' && !empty($c['search'])) {
            $or = [];
            foreach ($c['search'] as $col) { Database::assertIdent($col); $or[] = "`$col` LIKE ?"; $p[] = '%' . $q . '%'; }
            $w[] = '(' . implode(' OR ', $or) . ')';
        }
        $demo = $_GET['demo'] ?? '';
        if ($hasDemo && in_array($demo, ['0', '1'], true)) { $w[] = 'is_demo=' . (int)$demo; }
        $where = implode(' AND ', $w);
        $pg = paginate((int)Database::val("SELECT COUNT(*) FROM `$t` WHERE $where", $p), 20, (int)($_GET['page'] ?? 1));
        $order = preg_match('/^[a-z_ ,]+(DESC|ASC)?[a-z_ ,]*$/i', $c['order'] ?? 'id DESC') ? $c['order'] : 'id DESC';
        $rows = Database::all("SELECT * FROM `$t` WHERE $where ORDER BY $order LIMIT {$pg['per']} OFFSET {$pg['offset']}", $p);
        $maps = [];
        foreach ($c['fields'] as $f) if (($f['type'] === 'select') && isset($c['cols'][$f['name']])) $maps[$f['name']] = field_options($f);
        View::admin('crud-index', ['c' => $c, 'rows' => $rows, 'pg' => $pg, 'q' => $q, 'demo' => $demo, 'hasDemo' => $hasDemo, 'maps' => $maps, 'title' => $c['label']]);
    }

    public function form(string $module, ?string $id = null): void
    {
        $c = $this->cfg($module);
        $row = null;
        if ($id !== null) {
            $row = Database::one("SELECT * FROM `{$c['table']}` WHERE id=?" . (!empty($c['soft']) ? ' AND deleted_at IS NULL' : ''), [(int)$id]);
            if (!$row) { http_response_code(404); View::raw('errors/404', []); return; }
        } elseif (!empty($c['no_create'])) { http_response_code(403); View::raw('errors/403', ['msg' => 'Modul ini tidak mendukung tambah data.']); return; }
        $opts = [];
        foreach ($c['fields'] as $f) if ($f['type'] === 'select') $opts[$f['name']] = field_options($f);
        $suggest = [];
        foreach ($c['fields'] as $f) {
            if (empty($f['suggest'])) continue;
            Database::assertIdent($f['name']);
            $existing = array_column(Database::all("SELECT DISTINCT `{$f['name']}` AS v FROM `{$c['table']}` WHERE `{$f['name']}` IS NOT NULL AND `{$f['name']}`<>'' ORDER BY v"), 'v');
            $suggest[$f['name']] = array_values(array_unique(array_merge($f['suggest'], $existing)));
        }
        View::admin('crud-form', ['c' => $c, 'row' => $row, 'opts' => $opts, 'suggest' => $suggest, 'title' => ($row ? 'Edit ' : 'Tambah ') . $c['label']]);
    }

    public function save(string $module): void
    {
        $c = $this->cfg($module);
        $t = $c['table'];
        $id = (int)($_POST['id'] ?? 0);
        $existing = null;
        if ($id) {
            $existing = Database::one("SELECT * FROM `$t` WHERE id=?", [$id]);
            if (!$existing) { http_response_code(404); View::raw('errors/404', []); return; }
        } elseif (!empty($c['no_create'])) { http_response_code(403); View::raw('errors/403', ['msg' => 'Tidak diizinkan.']); return; }

        $errors = []; $data = []; $newFiles = []; $multi = [];
        foreach ($c['fields'] as $f) {
            $n = $f['name']; $label = $f['label']; $req = !empty($f['required']);
            // only_if: kolom hanya dipakai bila field lain bernilai tertentu (mis. video URL hanya untuk jenis "video_url")
            if (!empty($f['only_if']) && (string)($_POST[$f['only_if'][0]] ?? '') !== (string)$f['only_if'][1]) { $data[$n] = null; continue; }
            // required_if: wajib hanya bila field lain bernilai tertentu
            if (!empty($f['required_if']) && (string)($_POST[$f['required_if'][0]] ?? '') === (string)$f['required_if'][1]) $req = true;
            $raw = $_POST[$n] ?? '';
            switch ($f['type']) {
                case 'text': case 'textarea': case 'url':
                    $v = trim((string)$raw);
                    $v = preg_replace('/[\x00-\x08\x0B\x0C\x0E-\x1F]/u', '', $v) ?? '';
                    $max = (int)($f['max'] ?? 255);
                    if ($req && $v === '') { $errors[$n] = "$label wajib diisi."; break; }
                    if (mb_strlen($v) > $max) { $errors[$n] = "$label maksimal $max karakter."; break; }
                    if ($f['type'] === 'url' && $v !== '') {
                        if (!preg_match('~^https?://~i', $v) || !filter_var($v, FILTER_VALIDATE_URL)) { $errors[$n] = "$label harus berupa URL http(s) yang valid."; break; }
                        if (!empty($f['youtube']) && !youtube_id($v)) { $errors[$n] = 'URL YouTube tidak dikenali.'; break; }
                        if (!empty($f['social'])) {
                            $allow = is_array($f['social']) ? $f['social'] : ['youtube', 'instagram', 'tiktok'];
                            $names = ['youtube' => 'YouTube', 'instagram' => 'Instagram', 'tiktok' => 'TikTok'];
                            $sv = social_video($v);
                            if (!$sv && in_array('tiktok', $allow, true) && ($full = resolve_short_video_url($v))) { $v = $full; $sv = social_video($v); } // vm.tiktok.com/…
                            if (!$sv || !in_array($sv['provider'], $allow, true)) {
                                $errors[$n] = 'Link tidak dikenali. Gunakan link video ' . implode(', ', array_map(fn($a) => $names[$a], $allow)) . ' (untuk TikTok: link lengkap berformat tiktok.com/@akun/video/123…).';
                                break;
                            }
                        }
                    }
                    if ($n === 'link' && $v !== '' && !preg_match('~^(/|https?://)~i', $v)) { $errors[$n] = "$label harus diawali / atau http(s)://"; break; }
                    if ($n === 'url' && $v !== '' && !preg_match('~^(/|#|https?://)~i', $v)) { $errors[$n] = "$label harus diawali /, # atau http(s)://"; break; }
                    if (!empty($f['unique']) && $v !== '' && Database::val("SELECT COUNT(*) FROM `$t` WHERE `$n`=? AND id<>?", [$v, $id]) > 0) { $errors[$n] = "$label sudah dipakai."; break; }
                    $data[$n] = ($v === '' && in_array($f['type'], ['url'], true)) ? null : $v;
                    break;
                case 'html':
                    $v = clean_html((string)$raw);
                    if ($req && trim(strip_tags($v)) === '') { $errors[$n] = "$label wajib diisi."; break; }
                    $data[$n] = $v;
                    break;
                case 'number':
                    $s = trim((string)$raw);
                    if ($s === '' && !empty($f['nullable'])) { $data[$n] = null; break; }
                    if ($s === '' && !$req) { $data[$n] = (int)($f['default'] ?? 0); break; }
                    $min = (int)($f['min'] ?? 0); $max = (int)($f['max'] ?? 1000000);
                    if (!preg_match('/^-?\d+$/', $s) || (int)$s < $min || (int)$s > $max) { $errors[$n] = "$label harus angka $min–$max."; break; }
                    $data[$n] = (int)$s;
                    break;
                case 'select':
                    $opts = field_options($f);
                    $s = (string)$raw;
                    if ($s === '' || $s === ($f['options']['blank_value'] ?? null)) {
                        if ($req) { $errors[$n] = "$label wajib dipilih."; break; }
                        $data[$n] = isset($f['options']['blank_value']) ? (int)$f['options']['blank_value'] : null;
                        break;
                    }
                    if (!array_key_exists($s, $opts)) { $errors[$n] = "$label tidak valid."; break; }
                    $data[$n] = ctype_digit($s) && isset($f['options']['sql']) ? (int)$s : $s;
                    break;
                case 'bool':
                    $data[$n] = isset($_POST[$n]) ? 1 : 0;
                    break;
                case 'date':
                    $s = trim((string)$raw);
                    if ($s === '') { if ($req) $errors[$n] = "$label wajib diisi."; else $data[$n] = null; break; }
                    $d = DateTime::createFromFormat('Y-m-d', $s);
                    if (!$d || $d->format('Y-m-d') !== $s) { $errors[$n] = "$label tidak valid."; break; }
                    $data[$n] = $s;
                    break;
                case 'datetime':
                    $s = str_replace('T', ' ', trim((string)$raw));
                    if ($s === '') { $data[$n] = date('Y-m-d H:i:s'); break; }
                    $d = DateTime::createFromFormat('Y-m-d H:i', $s) ?: DateTime::createFromFormat('Y-m-d H:i:s', $s);
                    if (!$d) { $errors[$n] = "$label tidak valid."; break; }
                    $data[$n] = $d->format('Y-m-d H:i:s');
                    break;
                case 'image': case 'file': case 'video':
                    $isImg = $f['type'] === 'image';
                    $folder = $t;
                    $allowed = $isImg ? Upload::IMAGES : ($f['type'] === 'video' ? Upload::VIDEOS : Upload::DOCS);
                    $maxBytes = $isImg ? 5242880 : ($f['type'] === 'video' ? 52428800 : 10485760);
                    // unggah banyak foto hanya bila jenis media = foto (atau modul tak punya pilihan jenis)
                    $multiField = ($c['multi_image'] ?? null) === $n && !$id && (($_POST['media_type'] ?? 'image') === 'image');
                    if ($multiField && isset($_FILES[$n]) && is_array($_FILES[$n]['name'])) {
                        foreach ($_FILES[$n]['name'] as $i => $nm) {
                            $file = ['name' => $nm, 'type' => $_FILES[$n]['type'][$i], 'tmp_name' => $_FILES[$n]['tmp_name'][$i], 'error' => $_FILES[$n]['error'][$i], 'size' => $_FILES[$n]['size'][$i]];
                            if ($file['error'] === UPLOAD_ERR_NO_FILE) continue;
                            $r = Upload::save($file, $folder, $allowed, $maxBytes);
                            if (!$r['ok']) { $errors[$n] = $r['error']; break; }
                            $multi[] = $r['path']; $newFiles[] = $r['path'];
                        }
                        if ($req && !$multi && !isset($errors[$n])) $errors[$n] = "$label wajib diunggah.";
                        break;
                    }
                    $file = $_FILES[$n] ?? null;
                    if ($file && is_array($file['name'])) { // input name="x[]" tetapi hanya satu berkas yang dipakai (mis. thumbnail video)
                        $one = null;
                        foreach ($file['name'] as $i => $nm) if (($file['error'][$i] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_NO_FILE) { $one = ['name' => $nm, 'type' => $file['type'][$i], 'tmp_name' => $file['tmp_name'][$i], 'error' => $file['error'][$i], 'size' => $file['size'][$i]]; break; }
                        $file = $one;
                    }
                    if ($file && !is_array($file['name']) && $file['error'] !== UPLOAD_ERR_NO_FILE) {
                        $r = Upload::save($file, $folder, $allowed, $maxBytes);
                        if (!$r['ok']) { $errors[$n] = $r['error']; break; }
                        $data[$n] = $r['path']; $newFiles[] = $r['path'];
                    } elseif (!empty($_POST[$n . '_remove']) && $existing) {
                        $data[$n] = null;
                    } elseif ($req && (!$existing || empty($existing[$n]))) {
                        $errors[$n] = "$label wajib diunggah.";
                    }
                    break;
            }
        }
        if ($errors) {
            foreach ($newFiles as $p) Upload::delete($p);
            with_old($_POST, $errors); flash('error', 'Periksa kembali isian formulir.');
            redirect('admin/m/' . $module . ($id ? "/$id/edit" : '/baru'));
        }

        if (!empty($c['slug']) && !$existing) $data['slug'] = unique_slug($t, (string)($data[$c['slug']] ?? 'item'));
        if (table_has($t, 'is_demo') && empty($c['no_demo'])) $data['is_demo'] = 0;
        if (!empty($c['author']) && !$existing) $data['author_id'] = Auth::user()['id'];

        if ($multi) {
            foreach ($multi as $path) { $d = $data; $d['image'] = $path; Database::insert($t, $d); }
            log_activity('upload', $t, null, count($multi) . ' foto');
            flash('success', count($multi) . ' foto ditambahkan.'); redirect('admin/m/' . $module);
        }
        if ($existing) {
            Database::update($t, $id, $data);
            foreach ($data as $k => $v) if (in_array($k, array_column(array_filter($c['fields'], fn($f) => in_array($f['type'], ['image', 'file', 'video'], true)), 'name'), true) && ($existing[$k] ?? null) && $existing[$k] !== $v) Upload::delete($existing[$k]);
            log_activity('update', $t, $id, (string)($data['name'] ?? $data['title'] ?? ''));
        } else {
            $id = Database::insert($t, $data);
            log_activity('create', $t, $id, (string)($data['name'] ?? $data['title'] ?? ''));
        }
        flash('success', 'Data berhasil disimpan.');
        redirect('admin/m/' . $module);
    }

    public function delete(string $module, string $id): void
    {
        $c = $this->cfg($module);
        if (!empty($c['no_delete'])) { http_response_code(403); View::raw('errors/403', ['msg' => 'Data ini tidak dapat dihapus.']); return; }
        $row = Database::one("SELECT * FROM `{$c['table']}` WHERE id=?", [(int)$id]);
        if (!$row) { flash('error', 'Data tidak ditemukan.'); redirect('admin/m/' . $module); }
        if (!empty($c['soft'])) {
            Database::run("UPDATE `{$c['table']}` SET deleted_at=NOW(), is_active=0 WHERE id=?", [(int)$id]);
        } else {
            Database::run("DELETE FROM `{$c['table']}` WHERE id=?", [(int)$id]);
            foreach ($c['fields'] as $f) if (in_array($f['type'], ['image', 'file', 'video'], true)) Upload::delete($row[$f['name']] ?? null);
        }
        log_activity('delete', $c['table'], (int)$id, (string)($row['name'] ?? $row['title'] ?? ''));
        flash('success', 'Data dihapus.');
        redirect('admin/m/' . $module);
    }

    public function toggle(string $module, string $id): void
    {
        $c = $this->cfg($module);
        if (!empty($c['no_active']) || !table_has($c['table'], 'is_active')) { http_response_code(400); View::raw('errors/403', ['msg' => 'Modul ini tidak memiliki status tampil.']); return; }
        Database::run("UPDATE `{$c['table']}` SET is_active = 1 - is_active WHERE id=?", [(int)$id]);
        log_activity('update', $c['table'], (int)$id, 'toggle status');
        if (wants_json()) json_out(['ok' => true]);
        redirect('admin/m/' . $module);
    }
}
