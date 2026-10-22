<?php
declare(strict_types=1);

final class SettingsController
{
    public const FIELDS = [
        'Identitas' => [['school_name', 'Nama sekolah', 'text'], ['school_short', 'Nama singkat', 'text'], ['tagline', 'Tagline', 'text'], ['logo', 'Logo', 'image'], ['favicon', 'Favicon', 'image'], ['footer_text', 'Teks footer', 'textarea'], ['marquee_text', 'Teks berjalan (marquee) di beranda — satu per baris, kosongkan untuk otomatis', 'textarea']],
        'Kontak' => [['address', 'Alamat', 'textarea'], ['phone', 'Telepon', 'tel'], ['whatsapp', 'WhatsApp', 'tel'], ['email', 'Email', 'email'], ['hours', 'Jam operasional', 'text'], ['maps_embed', 'URL embed Google Maps', 'url']],
        'Media sosial' => [['instagram', 'Instagram', 'url'], ['youtube', 'YouTube', 'url'], ['facebook', 'Facebook', 'url'], ['tiktok', 'TikTok', 'url']],
        'Warna' => [['color_primary', 'Biru utama', 'color'], ['color_navy', 'Biru tua', 'color'], ['color_accent', 'Kuning aksen', 'color']],
        'Kepala Sekolah' => [['principal_name', 'Nama', 'text'], ['principal_title', 'Jabatan', 'text'], ['principal_photo', 'Foto', 'image'], ['principal_speech', 'Sambutan', 'textarea']],
        'Beranda (Hero)' => [['hero_visual', 'Gambar sisi kanan hero (opsional — kosongkan untuk memakai logo sekolah)', 'image']],
        'PPDB' => [['ppdb_banner', 'Gambar promosi PPDB (halaman PPDB)', 'image']],
        'Chatbot' => [['chatbot_enabled', 'Aktifkan chatbot di website', 'bool'], ['chatbot_name', 'Nama chatbot', 'text'], ['chatbot_greeting', 'Pesan sambutan chatbot', 'textarea'], ['chatbot_knowledge', 'Pengetahuan tambahan — satu per baris, format: pertanyaan | jawaban', 'textarea']],
        'SEO' => [['seo_title', 'Judul default', 'text'], ['seo_description', 'Meta description default', 'textarea']],
    ];

    public function form(): void { View::admin('settings', ['title' => 'Pengaturan Situs', 'groups' => self::FIELDS]); }

    public function save(): void
    {
        $errors = []; $vals = []; $newFiles = [];
        foreach (self::FIELDS as $fields) foreach ($fields as [$k, $label, $type]) {
            if ($type === 'image') {
                $f = $_FILES[$k] ?? null;
                if ($f && $f['error'] !== UPLOAD_ERR_NO_FILE) {
                    $r = Upload::save($f, 'settings', Upload::IMAGES + ['ico' => ['image/vnd.microsoft.icon', 'image/x-icon']], 2097152);
                    if (!$r['ok']) { $errors[$k] = "$label: " . $r['error']; continue; }
                    $vals[$k] = $r['path']; $newFiles[] = $r['path'];
                } elseif (!empty($_POST[$k . '_remove'])) $vals[$k] = '';
                continue;
            }
            if ($type === 'bool') { $vals[$k] = isset($_POST[$k]) ? '1' : '0'; continue; }
            $v = trim((string)($_POST[$k] ?? ''));
            if (mb_strlen($v) > 6000) { $errors[$k] = "$label terlalu panjang."; continue; }
            if ($type === 'color' && !preg_match('/^#[0-9a-fA-F]{6}$/', $v)) { $errors[$k] = "$label harus berformat #RRGGBB."; continue; }
            if ($type === 'email' && $v !== '' && !filter_var($v, FILTER_VALIDATE_EMAIL)) { $errors[$k] = "$label tidak valid."; continue; }
            if ($type === 'url' && $v !== '' && !preg_match('~^https://~i', $v)) { $errors[$k] = "$label harus diawali https://"; continue; }
            if ($type === 'tel' && $v !== '' && !preg_match('/^[0-9+\-\s()]{6,25}$/', $v)) { $errors[$k] = "$label tidak valid."; continue; }
            if ($k === 'maps_embed' && $v !== '' && !preg_match('~^https://www\.google\.com/maps/embed~i', $v)) { $errors[$k] = 'Gunakan URL embed dari Google Maps (https://www.google.com/maps/embed…).'; continue; }
            if (in_array($k, ['school_name', 'phone', 'whatsapp', 'email', 'address'], true) && $v === '') { $errors[$k] = "$label wajib diisi."; continue; }
            $vals[$k] = $v;
        }
        if ($errors) {
            foreach ($newFiles as $p) Upload::delete($p);
            with_old($_POST, $errors); flash('error', 'Ada isian yang tidak valid.'); redirect('admin/settings');
        }
        $old = array_column(Database::all('SELECT `key`,`value` FROM site_settings'), 'value', 'key');
        foreach ($vals as $k => $v) {
            Database::run('INSERT INTO site_settings (`key`,`value`) VALUES (?,?) ON DUPLICATE KEY UPDATE `value`=VALUES(`value`)', [$k, $v]);
            if (in_array($k, ['logo', 'favicon', 'principal_photo'], true) && !empty($old[$k]) && $old[$k] !== $v) Upload::delete($old[$k]);
        }
        log_activity('settings', 'site_settings', null, implode(', ', array_keys($vals)));
        clear_old(); flash('success', 'Pengaturan disimpan. Perubahan langsung tampil di website.');
        redirect('admin/settings');
    }

    public function homepage(): void
    {
        View::admin('homepage', ['title' => 'Homepage Customizer', 'rows' => Database::all('SELECT * FROM sections ORDER BY sort_order')]);
    }

    public function homepageSave(): void
    {
        $key = (string)($_POST['key'] ?? '');
        $s = Database::one('SELECT * FROM sections WHERE `key`=?', [$key]);
        if (!$s) { flash('error', 'Section tidak ditemukan.'); redirect('admin/homepage'); }
        $str = fn(string $n, int $max) => ($v = trim((string)($_POST[$n] ?? ''))) === '' ? null : mb_substr($v, 0, $max);
        $data = ['badge' => $str('badge', 120), 'title' => $str('title', 255), 'subtitle' => $str('subtitle', 255), 'content' => $str('content', 3000),
            'button_text' => $str('button_text', 80), 'button_url' => $str('button_url', 255), 'button2_text' => $str('button2_text', 80), 'button2_url' => $str('button2_url', 255),
            'is_enabled' => isset($_POST['is_enabled']) ? 1 : 0];
        foreach (['button_url', 'button2_url'] as $u) if ($data[$u] && !preg_match('~^(/|https?://)~i', $data[$u])) { flash('error', 'URL tombol harus diawali / atau http(s)://'); redirect('admin/homepage'); }
        $f = $_FILES['image'] ?? null;
        if ($f && $f['error'] !== UPLOAD_ERR_NO_FILE) {
            $r = Upload::save($f, 'sections', Upload::IMAGES, 5242880);
            if (!$r['ok']) { flash('error', $r['error']); redirect('admin/homepage'); }
            $data['image'] = $r['path']; Upload::delete($s['image']);
        } elseif (!empty($_POST['image_remove'])) { Upload::delete($s['image']); $data['image'] = null; }
        Database::update('sections', (int)$s['id'], $data);
        log_activity('update', 'sections', (int)$s['id'], $key);
        flash('success', 'Section "' . $s['label'] . '" diperbarui.');
        redirect('admin/homepage');
    }

    public function homepageOrder(): void
    {
        $key = (string)($_POST['key'] ?? ''); $dir = ($_POST['dir'] ?? '') === 'up' ? 'up' : 'down';
        $rows = Database::all('SELECT id,`key` FROM sections ORDER BY sort_order, id');
        $i = array_search($key, array_column($rows, 'key'), true);
        $j = $dir === 'up' ? $i - 1 : $i + 1;
        if ($i !== false && isset($rows[$j])) {
            [$rows[$i], $rows[$j]] = [$rows[$j], $rows[$i]];
            foreach ($rows as $n => $r) Database::run('UPDATE sections SET sort_order=? WHERE id=?', [$n + 1, $r['id']]);
            log_activity('update', 'sections', null, "urutan $key $dir");
        }
        redirect('admin/homepage');
    }
}
