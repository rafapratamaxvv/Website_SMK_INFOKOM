<?php
declare(strict_types=1);

final class PageController
{
    private function render(string $view, array $d = []): void { View::page('pages/' . $view, $d); }
    private function notFound(): never { http_response_code(404); View::raw('errors/404', []); exit; }

    private function textPage(string $slug, array $extra = [], string $view = 'text'): void
    {
        $p = Site::page($slug) ?? $this->notFound();
        $this->render($view, ['page' => $p, 'meta' => ['title' => $p['title'], 'description' => $p['excerpt']]] + $extra);
    }

    public function profil(): void
    {
        $this->render('profil', ['meta' => ['title' => 'Profil Sekolah', 'description' => 'Profil SMK Infokom Kota Bogor.'], 'pages' => Database::all("SELECT slug,title,excerpt FROM pages WHERE slug IN ('tentang-sekolah','sejarah','visi-misi','tujuan','struktur-organisasi') AND is_active=1")]);
    }

    public function profilPage(string $slug): void
    {
        if (!in_array($slug, ['tentang-sekolah', 'sejarah', 'visi-misi', 'tujuan', 'struktur-organisasi'], true)) $this->notFound();
        $this->textPage($slug);
    }

    public function kepalaSekolah(): void
    {
        $this->render('kepsek', ['meta' => ['title' => 'Kepala Sekolah', 'description' => 'Sambutan Kepala Sekolah SMK Infokom Kota Bogor.']]);
    }

    public function guruStaff(): void
    {
        $q = trim((string)($_GET['q'] ?? ''));
        $type = in_array($_GET['tipe'] ?? '', ['guru', 'staff'], true) ? $_GET['tipe'] : '';
        $major = (int)($_GET['jurusan'] ?? 0);
        $page = max(1, (int)($_GET['page'] ?? 1));
        $parts = [];
        if ($type !== 'staff') $parts[] = "SELECT 'guru' AS tipe,id,slug,name,position,education,field,subjects,bio,photo,major_id,sort_order,is_demo FROM teachers WHERE is_active=1";
        if ($type !== 'guru' && !$major) $parts[] = "SELECT 'staff' AS tipe,id,slug,name,position,education,field,subjects,bio,photo,NULL,sort_order,is_demo FROM staff WHERE is_active=1";
        $union = implode(' UNION ALL ', $parts);
        $where = ' WHERE 1=1'; $p = [];
        if ($q !== '') { $where .= ' AND (name LIKE ? OR position LIKE ? OR subjects LIKE ? OR field LIKE ?)'; $l = '%' . $q . '%'; array_push($p, $l, $l, $l, $l); }
        if ($major) { $where .= ' AND major_id=?'; $p[] = $major; }
        $total = (int)Database::val("SELECT COUNT(*) FROM ($union) x $where", $p);
        $pg = paginate($total, 12, $page);
        $rows = Database::all("SELECT * FROM ($union) x $where ORDER BY sort_order, name LIMIT {$pg['per']} OFFSET {$pg['offset']}", $p);
        $this->render('guru-staff', ['rows' => $rows, 'pg' => $pg, 'q' => $q, 'type' => $type, 'major' => $major, 'majors' => Site::majors(), 'meta' => ['title' => 'Guru & Staff', 'description' => 'Daftar guru dan staff SMK Infokom Kota Bogor.']]);
    }

    public function akademik(): void
    {
        $this->textPage('akademik', ['majors' => Site::majors(), 'docs' => Database::all('SELECT * FROM documents WHERE is_active=1 ORDER BY id DESC')], 'akademik');
    }

    public function kurikulum(): void
    {
        $this->textPage('kurikulum', ['items' => Database::all('SELECT * FROM curriculum WHERE is_active=1 ORDER BY sort_order'), 'docs' => Database::all('SELECT * FROM documents WHERE is_active=1 ORDER BY id DESC')], 'kurikulum');
    }

    public function jurusanIndex(): void
    {
        $this->render('jurusan-index', ['majors' => Site::majors(), 'meta' => ['title' => 'Jurusan', 'description' => 'Jurusan TKJ, RPL, DKV, dan PSPT di SMK Infokom Kota Bogor.']]);
    }

    public function jurusanShow(string $slug): void
    {
        $m = Database::one('SELECT * FROM majors WHERE slug=? AND is_active=1', [$slug]) ?? $this->notFound();
        $this->render('jurusan-show', [
            'm' => $m,
            'teachers' => Database::all('SELECT * FROM teachers WHERE major_id=? AND is_active=1 ORDER BY sort_order', [$m['id']]),
            'subjects' => Database::all('SELECT * FROM major_subjects WHERE major_id=? AND is_active=1 ORDER BY grade,id', [$m['id']]),
            'facilities' => Database::all('SELECT * FROM facilities WHERE is_active=1 AND (category=? OR category=?) ORDER BY sort_order', [$m['code'], 'Studio ' . $m['code']]),
            'works' => Database::all('SELECT * FROM achievements WHERE major_id=? AND is_active=1 ORDER BY year DESC LIMIT 6', [$m['id']]),
            'albums' => Database::all('SELECT * FROM galleries WHERE is_active=1 AND category=? ORDER BY id DESC LIMIT 4', [$m['code']]),
            'jobs' => Database::all('SELECT * FROM jobs WHERE is_active=1 AND major_id=? ORDER BY deadline LIMIT 4', [$m['id']]),
            'faq' => Database::all("SELECT * FROM faq WHERE is_active=1 AND scope IN ('jurusan', ?) ORDER BY sort_order", [$m['code']]),
            'meta' => ['title' => $m['name'] . ' (' . $m['code'] . ')', 'description' => $m['short_desc'], 'image' => $m['cover']],
        ]);
    }

    public function program(): void
    {
        $this->render('program', ['rows' => Database::all('SELECT * FROM programs WHERE is_active=1 ORDER BY sort_order'), 'meta' => ['title' => 'Program Sekolah', 'description' => 'PKL, magang, teaching factory, sertifikasi, dan program lainnya.']]);
    }

    public function pkl(): void
    {
        $this->textPage('pkl', ['steps' => Database::all('SELECT * FROM pkl WHERE is_active=1 ORDER BY step_order'), 'companies' => Database::all('SELECT * FROM companies WHERE is_active=1 AND is_pkl=1 ORDER BY name')], 'pkl');
    }

    public function magang(): void
    {
        $items = Database::all('SELECT * FROM internships WHERE is_active=1 ORDER BY sort_order');
        $by = [];
        foreach ($items as $i) $by[$i['kind']][] = $i;
        try { $media = Database::all('SELECT * FROM internship_media WHERE is_active=1 ORDER BY sort_order, id DESC'); }
        catch (Throwable $e) { error_log('Magang media: ' . $e->getMessage()); $media = []; } // tabel belum dimigrasi
        $this->textPage('magang', ['media' => $media, 'by' => $by, 'companies' => Database::all('SELECT * FROM companies WHERE is_active=1 AND is_magang=1 ORDER BY name'), 'albums' => Database::all("SELECT * FROM galleries WHERE is_active=1 AND category='Magang' ORDER BY id DESC LIMIT 4")], 'magang');
    }

    public function kunjungan(): void
    {
        $page = Site::page('kunjungan-industri') ?: ['slug' => 'kunjungan-industri', 'title' => 'Kunjungan Industri', 'excerpt' => 'Belajar langsung di dunia usaha dan industri.', 'content' => '<p>Kunjungan industri membawa siswa melihat langsung proses kerja, teknologi, dan budaya profesional di perusahaan mitra.</p>', 'image' => null];
        $year = (int)($_GET['tahun'] ?? 0);
        try {
            $years = array_column(Database::all('SELECT DISTINCT YEAR(visit_date) y FROM industry_visits WHERE is_active=1 ORDER BY y DESC'), 'y');
            $visits = Database::all('SELECT v.*, m.code AS major_code FROM industry_visits v LEFT JOIN majors m ON m.id=v.major_id WHERE v.is_active=1' . ($year ? ' AND YEAR(v.visit_date)=' . $year : '') . ' ORDER BY v.visit_date DESC, v.id DESC LIMIT 60');
        } catch (Throwable $e) { // tabel belum diimpor (jalankan database/migrasi-kunjungan-industri.sql)
            error_log('Kunjungan industri: ' . $e->getMessage()); $years = []; $visits = [];
        }
        $albums = Database::all("SELECT * FROM galleries WHERE is_active=1 AND category='Kunjungan Industri' ORDER BY id DESC LIMIT 4");
        $companies = Database::all('SELECT * FROM companies WHERE is_active=1 ORDER BY name LIMIT 12');
        $this->render('kunjungan', ['page' => $page, 'visits' => $visits, 'years' => $years, 'year' => $year, 'albums' => $albums, 'companies' => $companies,
            'meta' => ['title' => 'Kunjungan Industri', 'description' => 'Kunjungan industri siswa SMK Infokom Kota Bogor ke perusahaan mitra.']]);
    }

    public function fasilitas(): void
    {
        $this->render('fasilitas', ['rows' => Database::all('SELECT * FROM facilities WHERE is_active=1 ORDER BY sort_order'), 'cat' => (string)($_GET['kategori'] ?? ''), 'meta' => ['title' => 'Fasilitas', 'description' => 'Laboratorium, studio, perpustakaan, dan fasilitas SMK Infokom.']]);
    }

    public function prestasi(): void
    {
        $f = ['tahun' => (int)($_GET['tahun'] ?? 0), 'jurusan' => (int)($_GET['jurusan'] ?? 0), 'kategori' => trim((string)($_GET['kategori'] ?? '')), 'tingkat' => trim((string)($_GET['tingkat'] ?? ''))];
        $w = 'WHERE a.is_active=1'; $p = [];
        if ($f['tahun']) { $w .= ' AND a.year=?'; $p[] = $f['tahun']; }
        if ($f['jurusan']) { $w .= ' AND a.major_id=?'; $p[] = $f['jurusan']; }
        if ($f['kategori'] !== '') { $w .= ' AND a.category=?'; $p[] = $f['kategori']; }
        if ($f['tingkat'] !== '') { $w .= ' AND a.level=?'; $p[] = $f['tingkat']; }
        $pg = paginate((int)Database::val("SELECT COUNT(*) FROM achievements a $w", $p), 9, (int)($_GET['page'] ?? 1));
        $this->render('prestasi', [
            'rows' => Database::all("SELECT a.*, m.code AS major_code FROM achievements a LEFT JOIN majors m ON m.id=a.major_id $w ORDER BY a.year DESC, a.id DESC LIMIT {$pg['per']} OFFSET {$pg['offset']}", $p),
            'pg' => $pg, 'f' => $f, 'majors' => Site::majors(),
            'years' => array_column(Database::all('SELECT DISTINCT year FROM achievements WHERE is_active=1 ORDER BY year DESC'), 'year'),
            'cats' => array_column(Database::all('SELECT DISTINCT category FROM achievements WHERE is_active=1 AND category IS NOT NULL ORDER BY category'), 'category'),
            'meta' => ['title' => 'Prestasi', 'description' => 'Prestasi siswa SMK Infokom Kota Bogor.'],
        ]);
    }

    public function alumni(): void
    {
        $this->render('alumni', [
            'rows' => Database::all('SELECT a.*, m.code AS major_code FROM alumni a LEFT JOIN majors m ON m.id=a.major_id WHERE a.is_active=1 ORDER BY a.grad_year DESC, a.id DESC'),
            'tracer' => Site::page('tracer-alumni'),
            'meta' => ['title' => 'Alumni', 'description' => 'Alumni dan tracer study SMK Infokom Kota Bogor.'],
        ]);
    }

    public function ekskul(): void
    {
        $this->render('ekskul', ['rows' => Database::all('SELECT * FROM extracurriculars WHERE is_active=1 ORDER BY name'), 'meta' => ['title' => 'Ekstrakurikuler', 'description' => 'Kegiatan ekstrakurikuler SMK Infokom.']]);
    }

    public function organisasi(): void
    {
        $this->render('organisasi', ['rows' => Database::all('SELECT * FROM organizations WHERE is_active=1 ORDER BY sort_order'), 'struktur' => Site::page('struktur-organisasi'), 'meta' => ['title' => 'Organisasi Siswa', 'description' => 'OSIS dan organisasi siswa SMK Infokom.']]);
    }

    public function bkk(): void
    {
        $this->textPage('bkk', ['items' => Database::all('SELECT * FROM bkk WHERE is_active=1 ORDER BY sort_order'), 'jobs' => $this->jobs(), 'companies' => Database::all('SELECT * FROM companies WHERE is_active=1 AND is_recruit=1 ORDER BY name')], 'bkk');
    }

    public function karier(): void
    {
        $this->textPage('karier', ['jobs' => $this->jobs(), 'majors' => Site::majors(), 'companies' => Database::all('SELECT * FROM companies WHERE is_active=1 AND is_recruit=1 ORDER BY name'), 'alumni' => Database::all('SELECT a.*, m.code AS major_code FROM alumni a LEFT JOIN majors m ON m.id=a.major_id WHERE a.is_active=1 ORDER BY a.grad_year DESC LIMIT 4')], 'karier');
    }

    private function jobs(): array
    {
        return Database::all('SELECT j.*, m.code AS major_code FROM jobs j LEFT JOIN majors m ON m.id=j.major_id WHERE j.is_active=1 AND (j.deadline IS NULL OR j.deadline>=CURDATE()) ORDER BY j.deadline IS NULL, j.deadline');
    }

    public function mitra(): void
    {
        $this->render('mitra', ['rows' => Database::all('SELECT * FROM companies WHERE is_active=1 ORDER BY name'), 'meta' => ['title' => 'Mitra Industri', 'description' => 'Mitra industri SMK Infokom Kota Bogor.']]);
    }

    public function pengumuman(): void
    {
        $this->render('pengumuman', ['rows' => Database::all('SELECT * FROM announcements WHERE is_active=1 AND (ends_at IS NULL OR ends_at>=CURDATE()) ORDER BY id DESC'), 'meta' => ['title' => 'Pengumuman', 'description' => 'Pengumuman resmi SMK Infokom.']]);
    }

    public function galeri(): void
    {
        $cat = trim((string)($_GET['kategori'] ?? ''));
        $w = 'WHERE g.is_active=1'; $p = [];
        if ($cat !== '') { $w .= ' AND g.category=?'; $p[] = $cat; }
        $pg = paginate((int)Database::val("SELECT COUNT(*) FROM galleries g $w", $p), 8, (int)($_GET['page'] ?? 1));
        $albums = Database::all("SELECT g.* FROM galleries g $w ORDER BY g.event_date DESC, g.id DESC LIMIT {$pg['per']} OFFSET {$pg['offset']}", $p);
        $items = [];
        foreach ($albums as $a) $items[$a['id']] = Database::all('SELECT * FROM gallery_items WHERE gallery_id=? ORDER BY id', [$a['id']]);
        $this->render('galeri', ['albums' => $albums, 'items' => $items, 'pg' => $pg, 'cat' => $cat, 'meta' => ['title' => 'Galeri', 'description' => 'Galeri foto kegiatan SMK Infokom.']]);
    }

    public function video(): void
    {
        $this->render('video', ['rows' => Database::all('SELECT * FROM videos WHERE is_active=1 ORDER BY id DESC'), 'meta' => ['title' => 'Video', 'description' => 'Video kegiatan SMK Infokom.']]);
    }

    public function agenda(): void
    {
        $this->render('agenda', ['rows' => Database::all('SELECT * FROM agenda WHERE is_active=1 AND COALESCE(end_date,start_date)>=CURDATE() ORDER BY start_date'), 'meta' => ['title' => 'Agenda', 'description' => 'Agenda kegiatan SMK Infokom.']]);
    }
}
