<?php
declare(strict_types=1);

final class AuthController
{
    public function form(): void
    {
        if (Auth::check()) redirect('admin/dashboard');
        View::raw('admin/login', ['flash' => flash()]);
    }

    public function login(): void
    {
        $email = mb_strtolower(trim((string)($_POST['email'] ?? '')));
        $pass = (string)($_POST['password'] ?? '');
        if ($email === '' || $pass === '' || mb_strlen($email) > 150 || strlen($pass) > 200) { flash('error', 'Email dan password wajib diisi.'); redirect('admin/login'); }
        if (Auth::tooManyAttempts($email)) { flash('error', 'Terlalu banyak percobaan gagal. Coba lagi dalam 15 menit.'); redirect('admin/login'); }
        if (!Auth::attempt($email, $pass)) { flash('error', 'Email atau password salah.'); redirect('admin/login'); }
        redirect('admin/dashboard');
    }

    public function logout(): void
    {
        Auth::logout();
        redirect('admin/login');
    }
}
