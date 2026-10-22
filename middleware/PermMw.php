<?php
declare(strict_types=1);

final class PermMw
{
    public static function handle(?string $perm = null): void
    {
        AuthMw::handle();
        if ($perm && !Auth::can($perm)) {
            http_response_code(403);
            if (wants_json()) json_out(['ok' => false, 'message' => 'Anda tidak memiliki izin.'], 403);
            View::raw('errors/403', ['msg' => 'Anda tidak memiliki izin untuk mengakses halaman ini.']);
            exit;
        }
    }
}
