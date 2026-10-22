<?php
declare(strict_types=1);

final class HomeController
{
    public function index(): void
    {
        $sections = Site::sections();
        $data = [
            'majors' => Site::majors(),
            'stats' => Database::all('SELECT * FROM school_statistics WHERE is_active=1 ORDER BY sort_order'),
            'programs' => Database::all('SELECT * FROM programs WHERE is_active=1 ORDER BY sort_order LIMIT 6'),
            'facilities' => Database::all('SELECT * FROM facilities WHERE is_active=1 ORDER BY sort_order LIMIT 6'),
            'achievements' => Database::all('SELECT a.*, m.code AS major_code FROM achievements a LEFT JOIN majors m ON m.id=a.major_id WHERE a.is_active=1 ORDER BY a.year DESC, a.id DESC LIMIT 3'),
            'companies' => Database::all('SELECT * FROM companies WHERE is_active=1 ORDER BY name LIMIT 12'),
            'news' => Database::all('SELECT n.*, c.name AS category FROM news n LEFT JOIN news_categories c ON c.id=n.category_id WHERE n.is_active=1 AND n.deleted_at IS NULL AND n.published_at<=NOW() ORDER BY n.published_at DESC LIMIT 3'),
            'gallery' => Database::all('SELECT gi.*, g.title AS album FROM gallery_items gi JOIN galleries g ON g.id=gi.gallery_id WHERE g.is_active=1 ORDER BY gi.id DESC LIMIT 6'),
            'albums' => Database::all('SELECT * FROM galleries WHERE is_active=1 ORDER BY id DESC LIMIT 4'),
            'videos' => Database::all('SELECT * FROM videos WHERE is_active=1 ORDER BY id DESC LIMIT 3'),
            'sections' => $sections,
            'meta' => ['key' => 'home'],
        ];
        View::page('home/index', $data);
    }
}
