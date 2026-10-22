<?php
declare(strict_types=1);

final class Csrf
{
    public static function token(): string
    {
        if (empty($_SESSION['_csrf'])) $_SESSION['_csrf'] = bin2hex(random_bytes(32));
        return $_SESSION['_csrf'];
    }
    public static function field(): string { return '<input type="hidden" name="_csrf" value="' . self::token() . '">'; }
    public static function verifyRequest(): void
    {
        $t = $_POST['_csrf'] ?? ($_SERVER['HTTP_X_CSRF_TOKEN'] ?? '');
        if (!is_string($t) || !hash_equals(self::token(), $t)) {
            http_response_code(419);
            if (wants_json()) { json_out(['ok' => false, 'message' => 'Sesi kedaluwarsa, muat ulang halaman.'], 419); }
            View::raw('errors/403', ['msg' => 'Token keamanan tidak valid. Muat ulang halaman lalu coba lagi.']);
            exit;
        }
    }
}
