<?php
declare(strict_types=1);

final class PpdbController
{
    public const INCOME = ['< Rp 1.000.000', 'Rp 1.000.000 – 3.000.000', 'Rp 3.000.000 – 5.000.000', '> Rp 5.000.000', 'Tidak berpenghasilan'];

    public function index(): void
    {
        $period = Site::activePeriod();
        $majors = Site::majors();
        foreach ($majors as &$m) $m['left'] = $period ? Site::quotaLeft((int)$m['id'], (int)$period['id']) : 0;
        unset($m);
        View::page('ppdb/index', [
            'cfg' => Site::ppdb(), 'open' => Site::ppdbOpen(), 'period' => $period, 'majors' => $majors,
            'periods' => Database::all('SELECT * FROM ppdb_periods WHERE is_active=1 ORDER BY start_date'),
            'faq' => Database::all("SELECT * FROM faq WHERE scope='ppdb' AND is_active=1 ORDER BY sort_order"),
            'meta' => ['title' => 'PPDB', 'description' => 'Informasi dan pendaftaran online PPDB SMK Infokom Kota Bogor.', 'key' => 'ppdb'],
        ]);
    }

    public function submit(): void
    {
        $fail = function (array $errors, array $data = []) {
            if (wants_json()) json_out(['ok' => false, 'errors' => $errors], 422);
            with_old($data, $errors); flash('error', 'Periksa kembali isian formulir.'); redirect('ppdb#formulir');
        };
        if (!Site::ppdbOpen()) { flash('error', 'PPDB sedang ditutup.'); redirect('ppdb'); }
        $period = Site::activePeriod();
        $majorIds = array_map('strval', array_column(Site::majors(), 'id'));

        $v = new Validator($_POST);
        $v->str('name', 'Nama lengkap', true, 150, 3)
          ->regex('nisn', 'NISN', '/^\d{10}$/', 'NISN harus 10 digit angka.', true, 10)
          ->str('school_origin', 'Asal SMP/MTs', true, 150, 3)
          ->str('birth_place', 'Tempat lahir', true, 100)
          ->date('birth_date', 'Tanggal lahir')
          ->inList('gender', 'Jenis kelamin', ['L', 'P'])
          ->str('address', 'Alamat', true, 300, 10)
          ->regex('phone', 'Nomor HP', '/^(\+62|62|0)8\d{8,12}$/', 'Nomor HP harus nomor seluler Indonesia (08xxxxxxxxxx).', true, 20)
          ->email('email', 'Email', false)
          ->str('father_name', 'Nama ayah', true, 150)
          ->str('mother_name', 'Nama ibu', true, 150)
          ->str('parent_job', 'Pekerjaan orang tua', true, 100)
          ->inList('parent_income', 'Penghasilan', self::INCOME)
          ->inList('major_id', 'Jurusan', $majorIds);

        if (!isset($v->errors['birth_date'])) {
            $age = (new DateTime($v->data['birth_date']))->diff(new DateTime())->y;
            if ($age < 11 || $age > 25) $v->errors['birth_date'] = 'Tanggal lahir tidak masuk akal.';
        }
        $photo = $_FILES['photo'] ?? null;
        if (!$photo || ($photo['error'] ?? UPLOAD_ERR_NO_FILE) === UPLOAD_ERR_NO_FILE) $v->errors['photo'] = 'Foto wajib diunggah.';
        if ($v->fails()) $fail($v->errors, $v->data);

        $d = $v->data;
        if (Database::val('SELECT COUNT(*) FROM ppdb_registrants WHERE nisn=? AND period_id=? AND deleted_at IS NULL', [$d['nisn'], $period['id']]) > 0)
            $fail(['nisn' => 'NISN ini sudah terdaftar pada periode ini.'], $d);

        $up = Upload::save($photo, 'ppdb/foto', Upload::IMAGES, 2097152);
        if (!$up['ok']) $fail(['photo' => $up['error']], $d);

        $docs = [];
        foreach ($this->normalizeFiles($_FILES['dokumen'] ?? null) as $i => $f) {
            if (($f['error'] ?? 4) === UPLOAD_ERR_NO_FILE) continue;
            if ($i >= 4) break;
            $r = Upload::save($f, 'ppdb/dokumen', Upload::IMAGES + Upload::DOCS, 3145728);
            if (!$r['ok']) { Upload::delete($up['path']); foreach ($docs as $x) Upload::delete($x); $fail(['dokumen' => 'Dokumen: ' . $r['error']], $d); }
            $docs[] = $r['path'];
        }

        $pdo = Database::pdo();
        try {
            $pdo->beginTransaction();
            Database::val('SELECT ppdb_quota FROM majors WHERE id=? FOR UPDATE', [(int)$d['major_id']]);
            if (Site::quotaLeft((int)$d['major_id'], (int)$period['id']) <= 0) {
                $pdo->rollBack(); Upload::delete($up['path']); foreach ($docs as $x) Upload::delete($x);
                $fail(['major_id' => 'Kuota jurusan ini sudah penuh. Pilih jurusan lain.'], $d);
            }
            $token = bin2hex(random_bytes(16));
            $id = Database::insert('ppdb_registrants', [
                'reg_number' => 'TMP' . substr($token, 0, 20), 'verify_token' => $token, 'period_id' => $period['id'], 'major_id' => (int)$d['major_id'],
                'name' => $d['name'], 'nisn' => $d['nisn'], 'school_origin' => $d['school_origin'], 'birth_place' => $d['birth_place'], 'birth_date' => $d['birth_date'],
                'gender' => $d['gender'], 'address' => $d['address'], 'phone' => preg_replace('/\s+/', '', $d['phone']), 'email' => $d['email'] ?: null,
                'father_name' => $d['father_name'], 'mother_name' => $d['mother_name'], 'parent_job' => $d['parent_job'], 'parent_income' => $d['parent_income'],
                'photo' => $up['path'], 'ip' => client_ip(), 'status' => !empty(Site::ppdb()['auto_accept']) ? 'diterima' : 'baru',
            ]);
            $reg = sprintf('PPDB-%s-%04d', date('Y'), $id);
            Database::run('UPDATE ppdb_registrants SET reg_number=? WHERE id=?', [$reg, $id]);
            foreach ($docs as $p) Database::insert('ppdb_documents', ['registrant_id' => $id, 'doc_type' => 'berkas', 'file_path' => $p]);
            $pdo->commit();
        } catch (PDOException $e) {
            if ($pdo->inTransaction()) $pdo->rollBack();
            Upload::delete($up['path']); foreach ($docs as $x) Upload::delete($x);
            error_log('PPDB insert: ' . $e->getMessage());
            $fail(['nisn' => 'Pendaftaran gagal diproses. Coba lagi.'], $d);
        }
        clear_old();
        log_activity('create', 'ppdb_registrants', $id, $reg);
        if (wants_json()) json_out(['ok' => true, 'redirect' => url('ppdb/sukses/' . $token), 'reg_number' => $reg]);
        redirect('ppdb/sukses/' . $token);
    }

    private function normalizeFiles(?array $f): array
    {
        if (!$f || !is_array($f['name'] ?? null)) return [];
        $out = [];
        foreach ($f['name'] as $i => $n) $out[] = ['name' => $n, 'type' => $f['type'][$i], 'tmp_name' => $f['tmp_name'][$i], 'error' => $f['error'][$i], 'size' => $f['size'][$i]];
        return $out;
    }

    private function find(string $token): array
    {
        if (!preg_match('/^[a-f0-9]{32}$/', $token)) { http_response_code(404); View::raw('errors/404', []); exit; }
        $r = Database::one('SELECT r.*, m.name AS major_name, m.code AS major_code, p.name AS period_name FROM ppdb_registrants r JOIN majors m ON m.id=r.major_id JOIN ppdb_periods p ON p.id=r.period_id WHERE r.verify_token=? AND r.deleted_at IS NULL', [$token]);
        if (!$r) { http_response_code(404); View::raw('errors/404', []); exit; }
        return $r;
    }

    /** Halaman publik "Cek Status PPDB" (diterima / belum). */
    public function statusForm(): void
    {
        View::page('ppdb/status', ['result' => null, 'searched' => false, 'meta' => ['title' => 'Cek Status PPDB', 'description' => 'Cek status penerimaan PPDB SMK Infokom Kota Bogor.', 'noindex' => true]]);
    }

    public function statusCheck(): void
    {
        $nisn = preg_replace('/\D/', '', (string)($_POST['nisn'] ?? '')) ?? '';
        $dob = trim((string)($_POST['birth_date'] ?? ''));
        $d = DateTime::createFromFormat('Y-m-d', $dob);
        $valid = preg_match('/^\d{10}$/', $nisn) === 1 && $d && $d->format('Y-m-d') === $dob;
        $r = null;
        if ($valid) {
            // NISN + tanggal lahir harus cocok (pendaftar terbaru bila ada lebih dari satu)
            $r = Database::one('SELECT r.*, m.name AS major_name, m.code AS major_code, p.name AS period_name FROM ppdb_registrants r JOIN majors m ON m.id=r.major_id JOIN ppdb_periods p ON p.id=r.period_id WHERE r.nisn=? AND r.birth_date=? AND r.deleted_at IS NULL ORDER BY r.id DESC LIMIT 1', [$nisn, $dob]);
        }
        View::page('ppdb/status', ['result' => $r, 'searched' => true, 'valid' => $valid, 'nisn' => $nisn, 'dob' => $dob,
            'meta' => ['title' => 'Cek Status PPDB', 'noindex' => true]]);
    }

    public function success(string $token): void
    {
        View::page('ppdb/success', ['r' => $this->find($token), 'meta' => ['title' => 'Pendaftaran Berhasil', 'noindex' => true]]);
    }

    public function verify(string $token): void
    {
        $r = $this->find($token);
        $mask = fn(string $s) => mb_substr($s, 0, 2) . str_repeat('•', max(0, mb_strlen($s) - 3)) . mb_substr($s, -1);
        View::page('ppdb/verify', ['r' => $r, 'maskedName' => $mask($r['name']), 'meta' => ['title' => 'Verifikasi Pendaftaran', 'noindex' => true]]);
    }

    /** Formulir TERISI (bukti pendaftaran) — PDF unduh / tampil / cetak. */
    public function receipt(string $token): void
    {
        $r = $this->find($token);
        $verifyUrl = abs_url('ppdb/verifikasi/' . $r['verify_token']);
        $html = $this->renderForm([
            'r' => $r, 'photoUri' => $this->dataUri($r['photo']), 'verifyUrl' => $verifyUrl, 'qrUri' => $this->qrDataUri($verifyUrl), 'qrHtml' => $this->qrHtml($verifyUrl),
        ]);
        $this->output($html, 'Formulir-PPDB-' . preg_replace('/[^A-Za-z0-9\-]/', '', $r['reg_number']) . '.pdf');
    }

    /** Formulir KOSONG — bisa diisi tangan. Selalu tersedia walau PPDB ditutup. */
    public function blankForm(): void
    {
        $html = $this->renderForm(['r' => null, 'photoUri' => null, 'verifyUrl' => null, 'qrUri' => null]);
        $this->output($html, 'Formulir-PPDB-Kosong-' . preg_replace('/[^A-Za-z0-9]/', '', setting('school_short', 'SMK-Infokom')) . '.pdf');
    }

    private function renderForm(array $vars): string
    {
        $vars['logoUri'] = $this->logoDataUri(); // logo sekolah otomatis di kiri atas formulir
        $vars += ['qrHtml' => null];
        $vars['majors'] = Site::majors();
        $vars['period'] = Site::activePeriod();
        $vars['cfg'] = Site::ppdb();
        extract($vars, EXTR_SKIP);
        ob_start();
        require BASE_PATH . '/views/ppdb/formulir.php';
        return (string)ob_get_clean();
    }

    /** Logo sekolah untuk kop formulir: Pengaturan Situs → logo; cadangan: berkas bawaan assets/images/logo-smk-infokom.png. */
    private function logoDataUri(): ?string
    {
        foreach ([setting('logo'), 'assets/images/logo-smk-infokom.png', setting('favicon')] as $rel) {
            if (!$rel || str_contains($rel, '..')) continue;
            $f = BASE_PATH . '/' . ltrim($rel, '/');
            if (!is_file($f)) continue;
            $uri = $this->flatLogo($f);
            if ($uri) return $uri;
        }
        return null;
    }

    /** Ratakan logo (PNG transparan → JPEG latar putih, maks 240 px) agar selalu bisa dirender Dompdf. */
    private function flatLogo(string $f): ?string
    {
        $raw = (string)file_get_contents($f);
        if ($raw === '') return null;
        if (function_exists('imagecreatefromstring') && function_exists('imagejpeg')) {
            $im = @imagecreatefromstring($raw);
            if ($im) {
                $w = imagesx($im); $h = imagesy($im);
                $k = min(1, 240 / max($w, $h, 1));
                $nw = max(1, (int)round($w * $k)); $nh = max(1, (int)round($h * $k));
                $bg = imagecreatetruecolor($nw, $nh);
                imagefill($bg, 0, 0, imagecolorallocate($bg, 255, 255, 255));
                imagecopyresampled($bg, $im, 0, 0, 0, 0, $nw, $nh, $w, $h);
                ob_start(); imagejpeg($bg, null, 92); $jpg = (string)ob_get_clean();
                imagedestroy($im); imagedestroy($bg);
                if ($jpg !== '') return 'data:image/jpeg;base64,' . base64_encode($jpg);
            }
        }
        return (new finfo(FILEINFO_MIME_TYPE))->file($f) === 'image/jpeg' ? 'data:image/jpeg;base64,' . base64_encode($raw) : null;
    }

    private function output(string $html, string $filename): void
    {
        while (ob_get_level() > 0) ob_end_clean();
        $print = isset($_GET['print']);
        if (!$print && class_exists('Dompdf\\Dompdf')) {
            // Deprecated/notice dari library tidak boleh ikut tercetak ke badan PDF.
            $prev = error_reporting(error_reporting() & ~E_DEPRECATED & ~E_NOTICE & ~E_WARNING);
            $prevDisp = ini_set('display_errors', '0');
            @set_time_limit(120);
            $pdf = null;
            // Percobaan 1: lengkap dengan gambar. Percobaan 2: tanpa gambar (jika GD/gambar bermasalah).
            foreach ([$html, $this->stripImages($html)] as $try => $doc) {
                try {
                    $pdf = $this->renderPdf($doc);
                    break;
                } catch (Throwable $e) {
                    error_log('PPDB PDF (percobaan ' . ($try + 1) . '): ' . $e->getMessage() . ' @ ' . basename($e->getFile()) . ':' . $e->getLine());
                }
            }
            error_reporting($prev);
            if ($prevDisp !== false) ini_set('display_errors', (string)$prevDisp);
            if ($pdf !== null && $pdf !== '') {
                header('Content-Type: application/pdf');
                header('Content-Disposition: ' . (isset($_GET['unduh']) ? 'attachment' : 'inline') . '; filename="' . $filename . '"');
                header('Content-Length: ' . strlen($pdf));
                header('Cache-Control: private, max-age=0, must-revalidate');
                echo $pdf;
                return;
            }
            // Fallback terakhir: tampilkan versi HTML siap-cetak (Ctrl+P → Simpan sebagai PDF) alih-alih error 500.
            $print = true;
        }
        header('Content-Type: text/html; charset=utf-8');
        echo $html . ($print ? '<script>window.print()</script>' : '');
    }

    private function renderPdf(string $html): string
    {
        $opts = new Dompdf\Options();
        $opts->set('isRemoteEnabled', false);
        $opts->set('isHtml5ParserEnabled', true);
        $opts->set('chroot', BASE_PATH);
        $tmp = BASE_PATH . '/storage/cache';
        if (is_dir($tmp) && is_writable($tmp)) { $opts->set('tempDir', $tmp); $opts->set('fontCache', $tmp); }
        $dompdf = new Dompdf\Dompdf($opts);
        $dompdf->loadHtml($html);
        $dompdf->setPaper('A4', 'portrait');
        $dompdf->render();
        return (string)$dompdf->output();
    }

    /** Hapus <img> data-URI (dipakai saat render gambar gagal, mis. ekstensi GD belum aktif). */
    private function stripImages(string $html): string
    {
        return (string)preg_replace('/<img\b[^>]*>/i', '', $html);
    }

    private function dataUri(?string $rel): ?string
    {
        if (!$rel || str_contains($rel, '..') || !str_starts_with($rel, 'uploads/')) return null;
        $f = BASE_PATH . '/' . $rel;
        if (!is_file($f)) return null;
        $mime = (new finfo(FILEINFO_MIME_TYPE))->file($f);
        $gd = function_exists('imagecreatefromstring') && function_exists('imagecreatefrompng');
        if ($mime === 'image/jpeg') {
            return 'data:image/jpeg;base64,' . base64_encode((string)file_get_contents($f)); // JPEG aman tanpa GD
        }
        if (!$gd) return null; // PNG/GIF/WebP butuh GD di Dompdf; lewati agar PDF tetap jadi (tanpa error 500)
        if ($mime === 'image/png' || $mime === 'image/gif') {
            return 'data:' . $mime . ';base64,' . base64_encode((string)file_get_contents($f));
        }
        if ($mime === 'image/webp' && function_exists('imagecreatefromwebp')) { // Dompdf tidak mendukung WebP → konversi ke JPEG
            $im = @imagecreatefromwebp($f);
            if (!$im) return null;
            $w = imagesx($im); $h = imagesy($im);
            $bg = imagecreatetruecolor($w, $h);
            imagefill($bg, 0, 0, imagecolorallocate($bg, 255, 255, 255));
            imagecopy($bg, $im, 0, 0, 0, 0, $w, $h);
            ob_start(); imagejpeg($bg, null, 88); $jpg = (string)ob_get_clean();
            imagedestroy($im); imagedestroy($bg);
            return $jpg !== '' ? 'data:image/jpeg;base64,' . base64_encode($jpg) : null;
        }
        return null;
    }

    private function qrDataUri(string $text): ?string
    {
        if (!function_exists('imagecreate') || !function_exists('imagepng')) return null;
        $lib = BASE_PATH . '/vendor/phpqrcode/qrlib.php';
        if (!is_file($lib)) return null;
        $prev = error_reporting(error_reporting() & ~E_DEPRECATED & ~E_STRICT & ~E_NOTICE & ~E_WARNING);
        try {
            require_once $lib;
            ob_start();
            QRcode::png($text, false, QR_ECLEVEL_M, 4, 1);
            $png = (string)ob_get_clean();
        } catch (Throwable $e) {
            while (ob_get_level() > 0 && ob_get_length() !== false && ob_get_length() > 0) ob_end_clean();
            $png = '';
        } finally {
            error_reporting($prev);
        }
        return $png !== '' ? 'data:image/png;base64,' . base64_encode($png) : null;
    }

    /** QR berbasis tabel HTML — tidak memerlukan GD, dipakai sebagai cadangan agar QR tetap tampil di PDF. */
    private function qrHtml(string $text): ?string
    {
        if (function_exists('imagecreate') && function_exists('imagepng')) return null; // QR PNG sudah tersedia
        $lib = BASE_PATH . '/vendor/phpqrcode/qrlib.php';
        if (!is_file($lib)) return null;
        $prev = error_reporting(error_reporting() & ~E_DEPRECATED & ~E_STRICT & ~E_NOTICE & ~E_WARNING);
        try {
            require_once $lib;
            $rows = QRcode::text($text, false, QR_ECLEVEL_M, 1, 1);
        } catch (Throwable $e) {
            return null;
        } finally {
            error_reporting($prev);
        }
        if (!is_array($rows) || !$rows) return null;
        $cell = 3;
        $out = '<table cellspacing="0" cellpadding="0" style="border-collapse:collapse;background:#fff">';
        foreach ($rows as $row) {
            $out .= '<tr>';
            foreach (str_split((string)$row) as $c) {
                $out .= '<td style="width:' . $cell . 'px;height:' . $cell . 'px;font-size:1px;line-height:1px;background:' . ($c === '1' ? '#000' : '#fff') . '"></td>';
            }
            $out .= '</tr>';
        }
        return $out . '</table>';
    }
}
