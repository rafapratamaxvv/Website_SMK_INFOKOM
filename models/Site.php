<?php
declare(strict_types=1);

final class Site
{
    public static function majors(bool $onlyActive = true): array
    {
        return Database::all('SELECT * FROM majors' . ($onlyActive ? ' WHERE is_active=1' : '') . ' ORDER BY sort_order');
    }
    public static function section(string $key): ?array { return Database::one('SELECT * FROM sections WHERE `key`=?', [$key]); }
    public static function sections(): array { return Database::all('SELECT * FROM sections WHERE is_enabled=1 ORDER BY sort_order'); }
    public static function page(string $slug): ?array { return Database::one('SELECT * FROM pages WHERE slug=? AND is_active=1', [$slug]); }
    public static function seo(string $key): ?array { return Database::one('SELECT * FROM seo_metadata WHERE page_key=?', [$key]); }
    public static function bar(): ?array
    {
        return Database::one('SELECT * FROM announcements WHERE is_active=1 AND show_in_bar=1 AND (starts_at IS NULL OR starts_at<=CURDATE()) AND (ends_at IS NULL OR ends_at>=CURDATE()) ORDER BY id DESC LIMIT 1');
    }
    public static function activePeriod(): ?array
    {
        return Database::one('SELECT * FROM ppdb_periods WHERE is_active=1 AND CURDATE() BETWEEN start_date AND end_date ORDER BY start_date LIMIT 1');
    }
    public static function ppdb(): array
    {
        return Database::one('SELECT * FROM ppdb_settings WHERE id=1') ?? ['is_open' => 0, 'closed_message' => 'PPDB ditutup.'];
    }
    /** Status PPDB: buka hanya jika saklar aktif DAN ada periode berjalan */
    public static function ppdbOpen(): bool { return (int)self::ppdb()['is_open'] === 1 && self::activePeriod() !== null; }
    public static function quotaLeft(int $majorId, int $periodId): int
    {
        $m = Database::one('SELECT ppdb_quota FROM majors WHERE id=?', [$majorId]);
        $used = (int)Database::val("SELECT COUNT(*) FROM ppdb_registrants WHERE major_id=? AND period_id=? AND deleted_at IS NULL AND status<>'ditolak'", [$majorId, $periodId]);
        return max(0, (int)($m['ppdb_quota'] ?? 0) - $used);
    }
}
