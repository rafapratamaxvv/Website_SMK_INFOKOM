<?php
declare(strict_types=1);

final class Upload
{
    public const IMAGES = ['jpg' => ['image/jpeg'], 'jpeg' => ['image/jpeg'], 'png' => ['image/png'], 'webp' => ['image/webp'], 'gif' => ['image/gif']];
    public const DOCS = ['pdf' => ['application/pdf']];
    public const VIDEOS = ['mp4' => ['video/mp4'], 'webm' => ['video/webm'], 'mov' => ['video/quicktime']];

    /** @return array{ok:bool,path?:string,error?:string,name?:string,mime?:string,size?:int} */
    public static function save(array $file, string $folder = 'general', array $allowed = self::IMAGES, int $maxBytes = 5242880): array
    {
        if (!isset($file['error']) || is_array($file['error'])) return ['ok' => false, 'error' => 'Upload tidak valid.'];
        if ($file['error'] === UPLOAD_ERR_NO_FILE) return ['ok' => false, 'error' => 'Tidak ada file.'];
        if ($file['error'] !== UPLOAD_ERR_OK) return ['ok' => false, 'error' => 'Upload gagal (kode ' . (int)$file['error'] . ').'];
        if ($file['size'] > $maxBytes) return ['ok' => false, 'error' => 'Ukuran file melebihi ' . round($maxBytes / 1048576, 1) . ' MB.'];
        if (!is_uploaded_file($file['tmp_name'])) return ['ok' => false, 'error' => 'Upload tidak valid.'];

        $ext = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));
        if (!isset($allowed[$ext])) return ['ok' => false, 'error' => 'Ekstensi file tidak diizinkan.'];
        // Ekstensi dari nama hanya dipakai sebagai pintu awal; yang menentukan adalah FORMAT ASLI file (isi file).
        $mime = (new finfo(FILEINFO_MIME_TYPE))->file($file['tmp_name']);
        if ($mime === 'image/pjpeg') $mime = 'image/jpeg';
        $realExt = ['image/jpeg' => 'jpg', 'image/png' => 'png', 'image/webp' => 'webp', 'image/gif' => 'gif', 'application/pdf' => 'pdf', 'image/vnd.microsoft.icon' => 'ico', 'image/x-icon' => 'ico',
            'video/mp4' => 'mp4', 'video/x-m4v' => 'mp4', 'video/webm' => 'webm', 'video/quicktime' => 'mov'][$mime] ?? null;
        if ($realExt === null || !isset($allowed[$realExt])) {
            $ok = array_keys($allowed);
            return ['ok' => false, 'error' => 'Format file terdeteksi sebagai "' . $mime . '", bukan format yang diizinkan (' . strtoupper(implode(', ', array_unique(array_map(fn($x) => $x === 'jpeg' ? 'jpg' : $x, $ok)))) . '). Simpan ulang/ekspor gambar ke JPG atau PNG.'];
        }
        $ext = $realExt; // file disimpan dengan ekstensi sesuai format aslinya
        if (!self::signatureOk($file['tmp_name'], $ext)) return ['ok' => false, 'error' => 'Signature file tidak valid.'];
        if (isset(self::IMAGES[$ext]) && @getimagesize($file['tmp_name']) === false) return ['ok' => false, 'error' => 'File bukan gambar valid.'];

        if (in_array($ext, ['gif', 'ico'], true)) {
            // GIF/ICO tidak di-encode ulang, jadi dipindai pola kode PHP yang spesifik (bukan byte acak).
            $raw = (string)file_get_contents($file['tmp_name']);
            if (preg_match('/<\?php|<\?=|<script\b/i', $raw)) return ['ok' => false, 'error' => 'File mengandung konten berbahaya.'];
        }
        $folder = implode('/', array_filter(array_map(fn($x) => preg_replace('/[^a-z0-9_-]/i', '', $x), explode('/', $folder)))) ?: 'general';
        $dir = BASE_PATH . '/uploads/' . $folder . '/' . date('Y/m');
        if (!is_dir($dir) && !mkdir($dir, 0755, true) && !is_dir($dir)) return ['ok' => false, 'error' => 'Folder upload tidak dapat dibuat.'];
        $name = bin2hex(random_bytes(16)) . '.' . $ext;
        $dest = $dir . '/' . $name;
        if (!move_uploaded_file($file['tmp_name'], $dest)) return ['ok' => false, 'error' => 'Gagal menyimpan file.'];
        if (!self::reencode($dest, $ext)) { @unlink($dest); return ['ok' => false, 'error' => 'File gambar rusak atau tidak dapat diproses.']; }
        chmod($dest, 0644);
        return ['ok' => true, 'path' => 'uploads/' . $folder . '/' . date('Y/m') . '/' . $name, 'name' => basename($file['name']), 'mime' => $mime, 'size' => (int)$file['size']];
    }

    /** Encode ulang JPG/PNG/WebP via GD untuk membuang metadata dan payload tersembunyi. */
    private static function reencode(string $path, string $ext): bool
    {
        if (!function_exists('imagecreatefromstring') || !in_array($ext, ['jpg', 'jpeg', 'png', 'webp'], true)) return true;
        $im = @imagecreatefromstring((string)file_get_contents($path));
        if (!$im) return false;
        if ($ext === 'png') { imagealphablending($im, false); imagesavealpha($im, true); }
        $ok = match ($ext) { 'jpg', 'jpeg' => imagejpeg($im, $path, 88), 'png' => imagepng($im, $path, 6), 'webp' => function_exists('imagewebp') && imagewebp($im, $path, 85), default => false };
        imagedestroy($im);
        if (!$ok) error_log('Upload reencode gagal: ' . $path);
        return true;
    }

    private static function signatureOk(string $tmp, string $ext): bool
    {
        $h = file_get_contents($tmp, false, null, 0, 16);
        if ($h === false) return false;
        return match ($ext) {
            'jpg', 'jpeg' => str_starts_with($h, "\xFF\xD8\xFF"),
            'png' => str_starts_with($h, "\x89PNG\r\n\x1A\n"),
            'gif' => str_starts_with($h, 'GIF87a') || str_starts_with($h, 'GIF89a'),
            'webp' => str_starts_with($h, 'RIFF') && substr($h, 8, 4) === 'WEBP',
            'pdf' => str_starts_with($h, '%PDF-'),
            'ico' => str_starts_with($h, "\x00\x00\x01\x00"),
            'mp4', 'mov' => substr($h, 4, 4) === 'ftyp',
            'webm' => str_starts_with($h, "\x1A\x45\xDF\xA3"),
            default => false,
        };
    }

    public static function delete(?string $rel): void
    {
        if (!$rel || !str_starts_with($rel, 'uploads/') || str_contains($rel, '..')) return;
        $full = realpath(BASE_PATH . '/' . $rel);
        $root = realpath(BASE_PATH . '/uploads');
        if ($full && $root && str_starts_with($full, $root . DIRECTORY_SEPARATOR) && is_file($full)) @unlink($full);
    }
}
