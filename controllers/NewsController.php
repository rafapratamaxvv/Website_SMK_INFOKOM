<?php
declare(strict_types=1);

final class NewsController
{
    public function index(): void
    {
        $q = trim((string)($_GET['q'] ?? '')); $cat = trim((string)($_GET['kategori'] ?? ''));
        $w = 'WHERE n.is_active=1 AND n.deleted_at IS NULL AND n.published_at<=NOW()'; $p = [];
        if ($q !== '') { $w .= ' AND (n.title LIKE ? OR n.excerpt LIKE ?)'; $p[] = "%$q%"; $p[] = "%$q%"; }
        if ($cat !== '') { $w .= ' AND c.slug=?'; $p[] = $cat; }
        $from = 'FROM news n LEFT JOIN news_categories c ON c.id=n.category_id';
        $pg = paginate((int)Database::val("SELECT COUNT(*) $from $w", $p), 9, (int)($_GET['page'] ?? 1));
        $rows = Database::all("SELECT n.*, c.name AS category, c.slug AS category_slug $from $w ORDER BY n.is_featured DESC, n.published_at DESC LIMIT {$pg['per']} OFFSET {$pg['offset']}", $p);
        View::page('pages/berita', ['rows' => $rows, 'pg' => $pg, 'q' => $q, 'cat' => $cat, 'cats' => Database::all('SELECT * FROM news_categories ORDER BY name'), 'meta' => ['title' => 'Berita', 'description' => 'Berita terbaru SMK Infokom Kota Bogor.']]);
    }

    public function show(string $slug): void
    {
        $n = Database::one('SELECT n.*, c.name AS category FROM news n LEFT JOIN news_categories c ON c.id=n.category_id WHERE n.slug=? AND n.is_active=1 AND n.deleted_at IS NULL AND n.published_at<=NOW()', [$slug]);
        if (!$n) { http_response_code(404); View::raw('errors/404', []); return; }
        Database::run('UPDATE news SET views=views+1 WHERE id=?', [$n['id']]);
        $related = Database::all('SELECT id,title,slug,image,published_at FROM news WHERE is_active=1 AND deleted_at IS NULL AND id<>? AND (category_id<=>?) ORDER BY published_at DESC LIMIT 3', [$n['id'], $n['category_id']]);
        View::page('pages/berita-detail', ['n' => $n, 'related' => $related, 'meta' => ['title' => $n['title'], 'description' => $n['excerpt'], 'image' => $n['image'], 'type' => 'article', 'canonical' => abs_url('berita/' . $n['slug'])]]);
    }
}
