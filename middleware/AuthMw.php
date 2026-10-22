<?php
declare(strict_types=1);

final class AuthMw
{
    public static function handle(?string $arg = null): void
    {
        if (!Auth::check()) {
            if (wants_json()) json_out(['ok' => false, 'message' => 'Belum login.'], 401);
            redirect('admin/login');
        }
        $u = Auth::user();
        if (!empty($u['must_change_password']) && !str_contains($_SERVER['REQUEST_URI'] ?? '', '/admin/akun')) {
            // diizinkan lanjut; dashboard menampilkan peringatan ganti password
        }
    }
}
