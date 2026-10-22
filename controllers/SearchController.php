<?php
declare(strict_types=1);

final class SearchController
{
    private function run(string $q): array
    {
        if (mb_strlen($q) < 2) return [];
        $l = '%' . addcslashes($q, '%_\\') . '%';
        $defs = [
            ['Berita', "SELECT title AS t, CONCAT('berita/',slug) AS u, excerpt AS d FROM news WHERE is_active=1 AND deleted_at IS NULL AND (title LIKE ? OR excerpt LIKE ?) LIMIT 5", 2],
            ['Jurusan', "SELECT CONCAT(name,' (',code,')') AS t, CONCAT('jurusan/',slug) AS u, short_desc AS d FROM majors WHERE is_active=1 AND (name LIKE ? OR code LIKE ? OR short_desc LIKE ?) LIMIT 5", 3],
            ['Guru', "SELECT name AS t, 'profil/guru-staff?q=' AS u, position AS d FROM teachers WHERE is_active=1 AND (name LIKE ? OR subjects LIKE ?) LIMIT 5", 2],
            ['Staff', "SELECT name AS t, 'profil/guru-staff?q=' AS u, position AS d FROM staff WHERE is_active=1 AND name LIKE ? LIMIT 5", 1],
            ['Fasilitas', "SELECT name AS t, 'fasilitas' AS u, description AS d FROM facilities WHERE is_active=1 AND (name LIKE ? OR description LIKE ?) LIMIT 5", 2],
            ['Prestasi', "SELECT title AS t, 'prestasi' AS u, competition AS d FROM achievements WHERE is_active=1 AND (title LIKE ? OR competition LIKE ?) LIMIT 5", 2],
            ['Alumni', "SELECT name AS t, 'alumni' AS u, job AS d FROM alumni WHERE is_active=1 AND (name LIKE ? OR company LIKE ?) LIMIT 5", 2],
            ['Program', "SELECT title AS t, 'program' AS u, summary AS d FROM programs WHERE is_active=1 AND (title LIKE ? OR summary LIKE ?) LIMIT 5", 2],
            ['BKK', "SELECT title AS t, 'bkk' AS u, content AS d FROM bkk WHERE is_active=1 AND (title LIKE ? OR content LIKE ?) LIMIT 5", 2],
            ['Lowongan', "SELECT CONCAT(position,' — ',company) AS t, 'karier' AS u, location AS d FROM jobs WHERE is_active=1 AND (position LIKE ? OR company LIKE ?) LIMIT 5", 2],
            ['Mitra', "SELECT name AS t, 'mitra' AS u, industry AS d FROM companies WHERE is_active=1 AND (name LIKE ? OR industry LIKE ?) LIMIT 5", 2],
        ];
        $out = [];
        foreach ($defs as [$type, $sql, $n]) {
            foreach (Database::all($sql, array_fill(0, $n, $l)) as $r) {
                $u = $r['u'] === 'profil/guru-staff?q=' ? 'profil/guru-staff?q=' . rawurlencode($r['t']) : $r['u'];
                $out[] = ['type' => $type, 'title' => $r['t'], 'url' => url($u), 'desc' => mb_substr(strip_tags((string)$r['d']), 0, 120)];
            }
        }
        return $out;
    }

    public function api(): void { json_out(['ok' => true, 'results' => $this->run(trim((string)($_GET['q'] ?? '')))]); }

    public function page(): void
    {
        $q = trim((string)($_GET['q'] ?? ''));
        View::page('pages/cari', ['q' => $q, 'results' => $this->run($q), 'meta' => ['title' => 'Pencarian', 'description' => 'Cari informasi di website SMK Infokom.', 'noindex' => true]]);
    }
}
