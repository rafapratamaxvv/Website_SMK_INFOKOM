<?php
declare(strict_types=1);

function env(string $k, ?string $d = null): ?string { return $GLOBALS['__env'][$k] ?? $d; }

function e(mixed $v): string { return htmlspecialchars((string)($v ?? ''), ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8'); }

function base_path_url(): string
{
    static $b = null;
    if ($b !== null) return $b;
    $cfg = env('APP_URL');
    if ($cfg) { $p = parse_url($cfg, PHP_URL_PATH); return $b = rtrim((string)$p, '/'); }
    $dir = str_replace('\\', '/', dirname($_SERVER['SCRIPT_NAME'] ?? ''));
    return $b = ($dir === '/' || $dir === '.') ? '' : rtrim($dir, '/');
}

function url(string $path = ''): string { return base_path_url() . '/' . ltrim($path, '/'); }
function asset(string $p): string { $f = BASE_PATH . '/assets/' . ltrim($p, '/'); return url('assets/' . ltrim($p, '/')) . (is_file($f) ? '?v=' . filemtime($f) : ''); }
function upload_url(?string $p): string { return $p ? url($p) : url('assets/images/placeholder.svg'); }
function abs_url(string $path = ''): string
{
    $https = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off');
    $host = $_SERVER['HTTP_HOST'] ?? 'localhost';
    if (!preg_match('/^[a-z0-9.\-:]+$/i', $host)) $host = 'localhost';
    return ($https ? 'https://' : 'http://') . $host . url($path);
}

function redirect(string $path, int $code = 302): never
{
    header('Location: ' . (preg_match('#^https?://#', $path) ? $path : url($path)), true, $code);
    exit;
}

function client_ip(): string { $ip = $_SERVER['REMOTE_ADDR'] ?? '0.0.0.0'; return filter_var($ip, FILTER_VALIDATE_IP) ? $ip : '0.0.0.0'; }
function wants_json(): bool { return str_contains($_SERVER['HTTP_ACCEPT'] ?? '', 'application/json') || ($_SERVER['HTTP_X_REQUESTED_WITH'] ?? '') === 'XMLHttpRequest'; }
function json_out(array $d, int $code = 200): never
{
    http_response_code($code);
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode($d, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

function flash(?string $type = null, ?string $msg = null): ?array
{
    if ($type !== null && $msg !== null) { $_SESSION['_flash'] = ['type' => $type, 'msg' => $msg]; return null; }
    $f = $_SESSION['_flash'] ?? null;
    unset($_SESSION['_flash']);
    return $f;
}
function old(string $k, mixed $d = ''): string { return e($_SESSION['_old'][$k] ?? $d); }
function with_old(array $data, array $errors = []): void { $_SESSION['_old'] = $data; $_SESSION['_errors'] = $errors; }
function field_error(string $k): string
{
    $m = $_SESSION['_errors'][$k] ?? '';
    return $m ? '<small class="field-error">' . e($m) . '</small>' : '';
}
function clear_old(): void { unset($_SESSION['_old'], $_SESSION['_errors']); }

function slugify(string $s): string
{
    $s = strtolower(trim($s));
    $s = preg_replace('/[^a-z0-9]+/', '-', $s) ?? '';
    return trim($s, '-') ?: 'item';
}

function unique_slug(string $table, string $base, ?int $ignoreId = null): string
{
    Database::assertIdent($table);
    $slug = slugify($base);
    $i = 1; $try = $slug;
    while (Database::val("SELECT COUNT(*) FROM `$table` WHERE slug=? AND id<>?", [$try, $ignoreId ?? 0]) > 0) $try = $slug . '-' . (++$i);
    return $try;
}

function setting(string $key, string $default = ''): string
{
    static $all = null;
    if ($all === null) {
        try { $all = array_column(Database::all('SELECT `key`,`value` FROM site_settings'), 'value', 'key'); }
        catch (Throwable) { $all = []; }
    }
    $v = $all[$key] ?? '';
    return $v !== '' ? (string)$v : $default;
}

function wa_link(string $text = ''): string
{
    $n = preg_replace('/\D/', '', setting('whatsapp', '087873071400')) ?? '';
    if (str_starts_with($n, '0')) $n = '62' . substr($n, 1);
    return 'https://wa.me/' . $n . ($text !== '' ? '?text=' . rawurlencode($text) : '');
}

function log_activity(string $action, string $module, ?int $recordId = null, ?string $detail = null): void
{
    try {
        Database::insert('activity_logs', [
            'user_id' => $_SESSION['uid'] ?? null, 'action' => $action, 'module' => $module, 'record_id' => $recordId,
            'detail' => $detail ? mb_substr($detail, 0, 500) : null, 'ip' => client_ip(),
            'user_agent' => mb_substr($_SERVER['HTTP_USER_AGENT'] ?? '', 0, 255),
        ]);
    } catch (Throwable $e) { error_log('log_activity: ' . $e->getMessage()); }
}

function send_security_headers(): void
{
    if (headers_sent()) return;
    header('X-Frame-Options: SAMEORIGIN');
    header('X-Content-Type-Options: nosniff');
    header('Referrer-Policy: strict-origin-when-cross-origin');
    header('Permissions-Policy: camera=(), microphone=(), geolocation=(), payment=()');
    header("Content-Security-Policy: default-src 'self'; script-src 'self'; style-src 'self' 'unsafe-inline'; img-src 'self' data: https://i.ytimg.com https://*.tile.openstreetmap.org; frame-src https://www.youtube-nocookie.com https://www.tiktok.com https://www.instagram.com https://www.google.com https://maps.google.com; font-src 'self' data:; object-src 'none'; base-uri 'self'; form-action 'self'; frame-ancestors 'self'");
    header_remove('X-Powered-By');
}

function paginate(int $total, int $perPage, int $page): array
{
    $pages = max(1, (int)ceil($total / $perPage));
    $page = min(max(1, $page), $pages);
    return ['total' => $total, 'per' => $perPage, 'page' => $page, 'pages' => $pages, 'offset' => ($page - 1) * $perPage];
}

function pager(array $p, array $query = []): string
{
    if ($p['pages'] <= 1) return '';
    $out = '<nav class="pager" aria-label="Halaman">';
    for ($i = 1; $i <= $p['pages']; $i++) {
        $q = http_build_query(array_filter([...$query, 'page' => $i], fn($v) => $v !== '' && $v !== null));
        $out .= '<a href="?' . e($q) . '"' . ($i === $p['page'] ? ' class="is-active" aria-current="page"' : '') . '>' . $i . '</a>';
    }
    return $out . '</nav>';
}

function icon(string $name, int $size = 20): string
{
    return '<svg class="ic" width="' . $size . '" height="' . $size . '" aria-hidden="true"><use href="' . e(asset('images/icons.svg')) . '#' . e($name) . '"/></svg>';
}

function fmt_date(?string $d, string $f = 'd M Y'): string
{
    if (!$d) return '';
    $m = ['Jan' => 'Jan', 'Feb' => 'Feb', 'Mar' => 'Mar', 'Apr' => 'Apr', 'May' => 'Mei', 'Jun' => 'Jun', 'Jul' => 'Jul', 'Aug' => 'Agu', 'Sep' => 'Sep', 'Oct' => 'Okt', 'Nov' => 'Nov', 'Dec' => 'Des'];
    $s = date($f, strtotime($d));
    return strtr($s, $m);
}

/** Label "DATA DEMO" sengaja tidak ditampilkan lagi (data bertanda is_demo tetap tersimpan di database). */
function demo_badge(array $r): string { return ''; }

function youtube_id(string $url): ?string
{
    if (preg_match('~(?:youtu\.be/|youtube\.com/(?:watch\?v=|embed/|shorts/))([A-Za-z0-9_-]{11})~', $url, $m)) return $m[1];
    return preg_match('/^[A-Za-z0-9_-]{11}$/', $url) ? $url : null;
}


/**
 * Kenali URL video YouTube / TikTok / Instagram.
 * @return array{provider:string,label:string,id:string,embed:string,watch:string,thumb:?string,ratio:string}|null
 */
function social_video(?string $url): ?array
{
    $url = trim((string)$url);
    if ($url === '') return null;
    if (($yt = youtube_id($url)) !== null && (str_contains($url, 'youtu') || preg_match('/^[A-Za-z0-9_-]{11}$/', $url))) {
        return ['provider' => 'youtube', 'label' => 'YouTube', 'id' => $yt, 'ratio' => '16/9', 'thumb' => 'https://i.ytimg.com/vi/' . $yt . '/hqdefault.jpg',
            'embed' => 'https://www.youtube-nocookie.com/embed/' . $yt . '?autoplay=1&rel=0', 'watch' => 'https://www.youtube.com/watch?v=' . $yt];
    }
    if (preg_match('~instagram\.com/(?:[A-Za-z0-9_.]+/)?(p|reels?|tv)/([A-Za-z0-9_-]+)~i', $url, $m)) {
        $type = strtolower($m[1]) === 'p' ? 'p' : (strtolower($m[1]) === 'tv' ? 'tv' : 'reel');
        return ['provider' => 'instagram', 'label' => 'Instagram', 'id' => $m[2], 'ratio' => '4/5', 'thumb' => null,
            'embed' => 'https://www.instagram.com/' . $type . '/' . $m[2] . '/embed/', 'watch' => 'https://www.instagram.com/' . $type . '/' . $m[2] . '/'];
    }
    if (preg_match('~tiktok\.com/(?:@[\w.\-]+/video|embed(?:/v2)?|v/)/?(\d{8,25})~i', $url, $m)) {
        return ['provider' => 'tiktok', 'label' => 'TikTok', 'id' => $m[1], 'ratio' => '9/16', 'thumb' => null,
            'embed' => 'https://www.tiktok.com/embed/v2/' . $m[1], 'watch' => 'https://www.tiktok.com/video/' . $m[1]];
    }
    return null;
}

/** Link pendek TikTok (vm.tiktok.com / tiktok.com/t/…) diikuti redirect-nya agar ID video diketahui. */
function resolve_short_video_url(string $url): ?string
{
    $host = strtolower((string)parse_url($url, PHP_URL_HOST));
    if (!preg_match('/(^|\.)tiktok\.com$/', $host) || !function_exists('curl_init')) return null;
    $ch = curl_init($url);
    curl_setopt_array($ch, [CURLOPT_RETURNTRANSFER => true, CURLOPT_FOLLOWLOCATION => true, CURLOPT_MAXREDIRS => 5, CURLOPT_TIMEOUT => 8, CURLOPT_CONNECTTIMEOUT => 5,
        CURLOPT_NOBODY => false, CURLOPT_USERAGENT => 'Mozilla/5.0 (compatible; SMKInfokomBot/1.0)', CURLOPT_PROTOCOLS => CURLPROTO_HTTPS | CURLPROTO_HTTP]);
    @curl_exec($ch);
    $final = (string)curl_getinfo($ch, CURLINFO_EFFECTIVE_URL);
    curl_close($ch);
    return $final !== '' ? $final : null;
}

/**
 * Satu item media (foto / video file / video URL) untuk galeri & dokumentasi.
 * Kolom yang dipakai: media_type, image, video_path, video_url, caption.
 */
function media_tile(array $it, string $alt, string $group): string
{
    $type = (string)($it['media_type'] ?? 'image');
    $cap = (string)($it['caption'] ?? '');
    if ($type === 'video_file' && !empty($it['video_path']) && is_file(BASE_PATH . '/' . $it['video_path'])) {
        $poster = (!empty($it['image']) && is_file(BASE_PATH . '/' . $it['image'])) ? ' poster="' . e(upload_url($it['image'])) . '"' : '';
        return '<div class="gv gv-file"><video controls playsinline preload="metadata"' . $poster . ' src="' . e(upload_url($it['video_path'])) . '#t=0.1"></video>'
            . ($cap !== '' ? '<div class="gv-cap">' . e($cap) . '</div>' : '') . '</div>';
    }
    if ($type === 'video_url' && ($sv = social_video($it['video_url'] ?? ''))) {
        $bg = '';
        if (!empty($it['image']) && is_file(BASE_PATH . '/' . $it['image'])) $bg = upload_url($it['image']);
        elseif ($sv['thumb']) $bg = $sv['thumb'];
        $style = $bg !== '' ? 'background-image:url(\'' . e($bg) . '\')' : '';
        return '<div class="gv gv-social gv-' . e($sv['provider']) . '"><div class="gv-box" style="--r:' . e($sv['ratio']) . '"><button type="button" class="gv-play" data-embed="' . e($sv['embed']) . '" data-title="' . e($cap ?: $alt) . '" style="' . $style . '" aria-label="Putar video ' . e($sv['label']) . '">'
            . '<span class="gv-badge">' . e($sv['label']) . '</span><span class="play">' . icon('video', 28) . '</span>' . ($bg === '' ? '<span class="gv-hint">Putar video ' . e($sv['label']) . '</span>' : '') . '</button></div>'
            . '<div class="gv-cap">' . ($cap !== '' ? e($cap) . ' · ' : '') . '<a href="' . e($sv['watch']) . '" target="_blank" rel="noopener noreferrer">Buka di ' . e($sv['label']) . '</a></div></div>';
    }
    if ($type !== 'image' || empty($it['image'])) return '';
    return '<figure class="reveal scale" data-lightbox="' . e($group) . '" data-caption="' . e($cap) . '" data-full="' . e(upload_url($it['image'])) . '">' . img($it['image'], $cap ?: $alt) . '<figcaption>' . e($cap) . '</figcaption></figure>';
}

function nav_tree(): array
{
    try {
        $rows = Database::all('SELECT * FROM navigation WHERE is_active=1 ORDER BY sort_order, id');
    } catch (Throwable) { return []; }
    $by = [];
    foreach ($rows as $r) $by[(int)$r['parent_id']][] = $r;
    $build = function (int $pid) use (&$build, $by): array {
        $out = [];
        foreach ($by[$pid] ?? [] as $r) { $r['children'] = $build((int)$r['id']); $out[] = $r; }
        return $out;
    };
    return $build(0);
}

/** Tabel yang punya flag is_demo */
function demo_tables(): array
{
    return ['teachers', 'staff', 'programs', 'facilities', 'achievements', 'alumni', 'extracurriculars', 'organizations', 'jobs', 'companies', 'news', 'galleries', 'gallery_items', 'videos', 'announcements', 'faq', 'documents', 'agenda', 'ppdb_periods', 'curriculum', 'internships', 'bkk', 'pkl', 'industry_visits'];
}


/** Sanitasi HTML konten CMS: hanya tag aman, tanpa atribut event/skrip. */
function clean_html(string $html): string
{
    $html = strip_tags($html, '<p><br><strong><b><em><i><u><ul><ol><li><h2><h3><h4><blockquote><a><img><table><thead><tbody><tr><th><td><div><span><hr>');
    $html = preg_replace('/\son\w+\s*=\s*("[^"]*"|\'[^\']*\'|[^\s>]+)/i', '', $html) ?? '';
    $html = preg_replace('/(href|src)\s*=\s*("|\')\s*(javascript|data|vbscript):[^"\']*("|\')/i', '$1="#"', $html) ?? '';
    return preg_replace('/\sstyle\s*=\s*("[^"]*"|\'[^\']*\')/i', '', $html) ?? '';
}

function modules(): array { static $m = null; return $m ??= require BASE_PATH . '/config/modules.php'; }

function table_has(string $table, string $col): bool
{
    static $cache = [];
    Database::assertIdent($table);
    if (!isset($cache[$table])) $cache[$table] = array_column(Database::all('SELECT COLUMN_NAME c FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME=?', [$table]), 'c');
    return in_array($col, $cache[$table], true);
}

/** Opsi select: ['value' => 'label'] */
function field_options(array $f): array
{
    $o = $f['options'] ?? [];
    if (is_array($o) && isset($o['sql'])) {
        $out = [];
        foreach (Database::all($o['sql']) as $r) $out[(string)$r['id']] = (string)$r['label'];
        return $out;
    }
    return $o;
}

function lines(?string $s): array { return array_values(array_filter(array_map('trim', preg_split('/\R/', (string)$s) ?: []), fn($x) => $x !== '')); }

function page_hero(string $title, string $sub = '', array $crumbs = [], string $icon = 'sparkles'): void
{
    echo '<section class="page-hero"><span class="ph-shape ph-s1"></span><span class="ph-shape ph-s2"></span><span class="ph-shape ph-s3"></span>';
    echo '<div class="ph-badge" aria-hidden="true">' . icon($icon, 64) . '</div>';
    echo '<div class="container"><nav class="crumbs" aria-label="Breadcrumb"><a href="' . e(url('/')) . '">Beranda</a>';
    foreach ($crumbs as $label => $href) echo ' <span>/</span> ' . ($href ? '<a href="' . e(url($href)) . '">' . e($label) . '</a>' : '<span aria-current="page">' . e($label) . '</span>');
    echo '</nav><h1 class="reveal-text">' . e($title) . '</h1>' . ($sub !== '' ? '<p class="lead reveal">' . e($sub) . '</p>' : '') . '</div>';
    echo '<div class="ph-wave" aria-hidden="true"><svg viewBox="0 0 1440 44" preserveAspectRatio="none"><path fill="currentColor" d="M0,44V22C240,0,480,40,720,26C960,12,1200,-6,1440,18V44Z"/></svg></div></section>';
}

/** Sub-navigasi (pill) untuk halaman-halaman Profil. */
function profil_tabs(string $active): void
{
    $items = ['tentang-sekolah' => ['Tentang Sekolah', 'profil/tentang-sekolah'], 'sejarah' => ['Sejarah', 'profil/sejarah'], 'visi-misi' => ['Visi & Misi', 'profil/visi-misi'],
        'tujuan' => ['Tujuan', 'profil/tujuan'], 'struktur-organisasi' => ['Struktur Organisasi', 'profil/struktur-organisasi'], 'kepala-sekolah' => ['Kepala Sekolah', 'profil/kepala-sekolah'], 'guru-staff' => ['Guru & Staff', 'profil/guru-staff']];
    echo '<nav class="subnav" aria-label="Menu profil"><div class="container">';
    foreach ($items as $k => [$label, $href]) echo '<a href="' . e(url($href)) . '"' . ($k === $active ? ' class="on" aria-current="page"' : '') . '>' . e($label) . '</a>';
    echo '</div></nav>';
}

/**
 * Pecah HTML konten CMS menjadi bagian berjudul: [['title'=>..., 'paras'=>[html...], 'items'=>[html...]], ...].
 * Judul = h2/h3/h4; paragraf = p/div; butir = li dari ol/ul. Bagian awal tanpa judul memakai title ''.
 */
function html_sections(string $html): array
{
    $out = [['title' => '', 'paras' => [], 'items' => []]];
    if (trim($html) === '' || !class_exists('DOMDocument')) return $out;
    $d = new DOMDocument();
    $prev = libxml_use_internal_errors(true);
    $d->loadHTML('<?xml encoding="utf-8"?><div id="r">' . $html . '</div>');
    libxml_clear_errors(); libxml_use_internal_errors($prev);
    $root = $d->getElementById('r');
    if (!$root) return $out;
    $inner = function (DOMNode $n) use ($d): string { $h = ''; foreach ($n->childNodes as $c) $h .= $d->saveHTML($c); return trim($h); };
    foreach ($root->childNodes as $n) {
        if (!($n instanceof DOMElement)) continue;
        $tag = strtolower($n->tagName);
        $i = count($out) - 1;
        if (in_array($tag, ['h2', 'h3', 'h4'], true)) { $out[] = ['title' => trim($n->textContent), 'paras' => [], 'items' => []]; }
        elseif ($tag === 'ol' || $tag === 'ul') { foreach ($n->getElementsByTagName('li') as $li) $out[$i]['items'][] = $inner($li); }
        elseif ($tag === 'p') { if (trim($n->textContent) !== '') $out[$i]['paras'][] = $inner($n); }
        else { $out[$i]['paras'][] = $d->saveHTML($n); }
    }
    return $out[0]['title'] === '' && !$out[0]['paras'] && !$out[0]['items'] && count($out) > 1 ? array_slice($out, 1) : $out;
}

function sec_head(?array $s, string $fallback = '', bool $center = false): void
{
    $badge = $s['badge'] ?? ''; $title = ($s['title'] ?? '') ?: $fallback; $sub = $s['subtitle'] ?? '';
    echo '<header class="sec-head reveal' . ($center ? ' center' : '') . '">';
    if ($badge) echo '<span class="eyebrow">' . e($badge) . '</span>';
    echo '<h2>' . e($title) . '</h2>';
    if ($sub) echo '<p class="muted">' . e($sub) . '</p>';
    echo '</header>';
}

function sec_link(?array $s): string
{
    if (empty($s['button_text']) || empty($s['button_url'])) return '';
    return '<a class="btn btn-outline" href="' . e(url($s['button_url'])) . '">' . e($s['button_text']) . ' ' . icon('arrow-right', 16) . '</a>';
}

function img(?string $path, string $alt = '', string $class = '', bool $lazy = true, string $fallback = ''): string
{
    if ($path && str_starts_with($path, 'uploads/') && !is_file(BASE_PATH . '/' . $path)) $path = null; // berkas belum disalin -> placeholder
    $src = $path ? upload_url($path) : ($fallback ?: asset('images/placeholder.svg'));
    return '<img src="' . e($src) . '" alt="' . e($alt) . '"' . ($class ? ' class="' . e($class) . '"' : '') . ($lazy ? ' loading="lazy" decoding="async"' : '') . '>';
}
