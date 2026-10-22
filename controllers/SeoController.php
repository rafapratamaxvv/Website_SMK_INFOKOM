<?php
declare(strict_types=1);

final class SeoController
{
    public function sitemap(): void
    {
        header('Content-Type: application/xml; charset=utf-8');
        $paths = ['', 'profil', 'profil/tentang-sekolah', 'profil/sejarah', 'profil/visi-misi', 'profil/tujuan', 'profil/struktur-organisasi', 'profil/kepala-sekolah', 'profil/guru-staff', 'akademik', 'akademik/kurikulum', 'jurusan', 'program', 'pkl', 'magang', 'kunjungan-industri', 'fasilitas', 'prestasi', 'alumni', 'ekstrakurikuler', 'organisasi', 'bkk', 'karier', 'mitra', 'berita', 'pengumuman', 'galeri', 'video', 'agenda', 'ppdb', 'kontak'];
        foreach (Database::all('SELECT slug FROM majors WHERE is_active=1') as $m) $paths[] = 'jurusan/' . $m['slug'];
        echo '<?xml version="1.0" encoding="UTF-8"?><urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">';
        foreach ($paths as $p) echo '<url><loc>' . e(abs_url($p)) . '</loc></url>';
        foreach (Database::all('SELECT slug, updated_at FROM news WHERE is_active=1 AND deleted_at IS NULL ORDER BY id DESC LIMIT 500') as $n)
            echo '<url><loc>' . e(abs_url('berita/' . $n['slug'])) . '</loc><lastmod>' . date('c', strtotime($n['updated_at'])) . '</lastmod></url>';
        echo '</urlset>';
    }

    public function robots(): void
    {
        header('Content-Type: text/plain; charset=utf-8');
        echo "User-agent: *\nDisallow: /admin\nDisallow: /api/\nDisallow: /ppdb/bukti/\nAllow: /\n\nSitemap: " . abs_url('sitemap.xml') . "\n";
    }
}
