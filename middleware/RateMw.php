<?php
declare(strict_types=1);

/** Rate limit berbasis IP: RateMw:bucket,max,menit */
final class RateMw
{
    public static function handle(?string $arg = null): void
    {
        [$bucket, $max, $min] = array_pad(explode(',', (string)$arg), 3, null);
        $bucket = $bucket ?: 'default'; $max = (int)($max ?: 10); $min = (int)($min ?: 10);
        if (($_SERVER['REQUEST_METHOD'] ?? 'GET') !== 'POST') return;
        $ip = client_ip();
        $n = (int)Database::val('SELECT COUNT(*) FROM rate_limits WHERE bucket=? AND ip=? AND created_at > (NOW() - INTERVAL ? MINUTE)', [$bucket, $ip, $min]);
        if ($n >= $max) {
            http_response_code(429);
            if (wants_json()) json_out(['ok' => false, 'message' => 'Terlalu banyak permintaan. Coba lagi nanti.'], 429);
            View::raw('errors/403', ['msg' => 'Terlalu banyak permintaan. Silakan coba lagi beberapa menit lagi.']);
            exit;
        }
        Database::run('INSERT INTO rate_limits (bucket,ip) VALUES (?,?)', [$bucket, $ip]);
        if (random_int(1, 50) === 1) Database::run('DELETE FROM rate_limits WHERE created_at < (NOW() - INTERVAL 1 DAY)');
    }
}
