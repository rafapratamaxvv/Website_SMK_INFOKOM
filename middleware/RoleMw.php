<?php
declare(strict_types=1);

final class RoleMw
{
    public static function handle(?string $role = null): void
    {
        AuthMw::handle();
        if ($role && (Auth::user()['role'] ?? '') !== $role) {
            http_response_code(403);
            if (wants_json()) json_out(['ok' => false, 'message' => 'Hanya untuk ' . $role . '.'], 403);
            View::raw('errors/403', ['msg' => 'Fitur ini khusus Super Admin.']);
            exit;
        }
    }
}
