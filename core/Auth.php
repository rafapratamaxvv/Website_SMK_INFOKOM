<?php
declare(strict_types=1);

final class Auth
{
    private const TIMEOUT = 1800;

    public static function startSession(): void
    {
        if (session_status() === PHP_SESSION_ACTIVE) return;
        $https = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off');
        session_name('SMKINFOKOMSESS');
        session_set_cookie_params(['lifetime' => 0, 'path' => '/', 'secure' => $https, 'httponly' => true, 'samesite' => 'Lax']);
        ini_set('session.use_strict_mode', '1');
        session_start();
        if (isset($_SESSION['uid'])) {
            if (time() - ($_SESSION['last'] ?? 0) > self::TIMEOUT) { self::logout(false); session_start(); }
            else $_SESSION['last'] = time();
        }
    }

    public static function user(): ?array
    {
        static $u = false;
        if ($u !== false) return $u;
        $id = $_SESSION['uid'] ?? null;
        $u = $id ? Database::one('SELECT u.id,u.name,u.email,u.role_id,u.is_active,r.slug AS role FROM users u JOIN roles r ON r.id=u.role_id WHERE u.id=? AND u.is_active=1', [$id]) : null;
        return $u;
    }

    public static function check(): bool { return self::user() !== null; }

    public static function attempt(string $email, string $password): bool
    {
        $ip = client_ip();
        $fails = (int)Database::val('SELECT COUNT(*) FROM login_attempts WHERE (ip=? OR email=?) AND created_at > (NOW() - INTERVAL 15 MINUTE)', [$ip, $email]);
        if ($fails >= 5) return false;
        $u = Database::one('SELECT * FROM users WHERE email=? AND is_active=1', [$email]);
        $hash = $u['password'] ?? '$2y$10$usesomesillystringforsaltandtimingattackdefense000000000000000';
        $ok = password_verify($password, $hash);
        if (!$ok || !$u) {
            Database::run('INSERT INTO login_attempts (ip,email) VALUES (?,?)', [$ip, $email]);
            return false;
        }
        Database::run('DELETE FROM login_attempts WHERE ip=? OR email=?', [$ip, $email]);
        if (password_needs_rehash($u['password'], PASSWORD_DEFAULT)) Database::run('UPDATE users SET password=? WHERE id=?', [password_hash($password, PASSWORD_DEFAULT), $u['id']]);
        session_regenerate_id(true);
        $_SESSION['uid'] = (int)$u['id'];
        $_SESSION['last'] = time();
        Database::run('UPDATE users SET last_login_at=NOW() WHERE id=?', [$u['id']]);
        log_activity('login', 'auth', (int)$u['id']);
        return true;
    }

    public static function tooManyAttempts(string $email): bool
    {
        return (int)Database::val('SELECT COUNT(*) FROM login_attempts WHERE (ip=? OR email=?) AND created_at > (NOW() - INTERVAL 15 MINUTE)', [client_ip(), $email]) >= 5;
    }

    public static function logout(bool $log = true): void
    {
        if ($log && self::check()) log_activity('logout', 'auth', (int)$_SESSION['uid']);
        $_SESSION = [];
        if (ini_get('session.use_cookies')) {
            $p = session_get_cookie_params();
            setcookie(session_name(), '', time() - 42000, $p['path'], $p['domain'], $p['secure'], $p['httponly']);
        }
        session_destroy();
    }

    public static function can(string $perm): bool
    {
        $u = self::user();
        if (!$u) return false;
        if ($u['role'] === 'super_admin') return true;
        static $cache = [];
        if (!isset($cache[$u['role_id']])) {
            $cache[$u['role_id']] = array_column(Database::all('SELECT p.slug FROM role_permissions rp JOIN permissions p ON p.id=rp.permission_id WHERE rp.role_id=?', [$u['role_id']]), 'slug');
        }
        return in_array($perm, $cache[$u['role_id']], true);
    }
}
