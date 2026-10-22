<?php
declare(strict_types=1);

final class Database
{
    private static ?PDO $pdo = null;

    public static function pdo(): PDO
    {
        if (self::$pdo) return self::$pdo;
        $dsn = sprintf('mysql:host=%s;port=%s;dbname=%s;charset=utf8mb4', env('DB_HOST', '127.0.0.1'), env('DB_PORT', '3306'), env('DB_NAME', 'smk_infokom_bogor'));
        try {
            self::$pdo = new PDO($dsn, env('DB_USER', 'root'), env('DB_PASS', ''), [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES => false,
                PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8mb4, time_zone = '" . date('P') . "'",
            ]);
        } catch (PDOException $e) {
            error_log('DB connect: ' . $e->getMessage());
            http_response_code(500);
            View::raw('errors/db', []);
            exit;
        }
        return self::$pdo;
    }

    public static function all(string $sql, array $p = []): array
    {
        $s = self::pdo()->prepare($sql);
        $s->execute($p);
        return $s->fetchAll();
    }

    public static function one(string $sql, array $p = []): ?array
    {
        $s = self::pdo()->prepare($sql);
        $s->execute($p);
        $r = $s->fetch();
        return $r === false ? null : $r;
    }

    public static function val(string $sql, array $p = []): mixed
    {
        $s = self::pdo()->prepare($sql);
        $s->execute($p);
        $r = $s->fetchColumn();
        return $r === false ? null : $r;
    }

    public static function run(string $sql, array $p = []): int
    {
        $s = self::pdo()->prepare($sql);
        $s->execute($p);
        return $s->rowCount();
    }

    public static function insert(string $table, array $data): int
    {
        self::assertIdent($table);
        $cols = array_keys($data);
        foreach ($cols as $c) self::assertIdent($c);
        $sql = 'INSERT INTO `' . $table . '` (`' . implode('`,`', $cols) . '`) VALUES (' . implode(',', array_fill(0, count($cols), '?')) . ')';
        self::run($sql, array_values($data));
        return (int)self::pdo()->lastInsertId();
    }

    public static function update(string $table, int $id, array $data): void
    {
        self::assertIdent($table);
        $sets = [];
        foreach (array_keys($data) as $c) { self::assertIdent($c); $sets[] = "`$c` = ?"; }
        self::run('UPDATE `' . $table . '` SET ' . implode(',', $sets) . ' WHERE id = ?', [...array_values($data), $id]);
    }

    public static function assertIdent(string $s): void
    {
        if (!preg_match('/^[a-z_][a-z0-9_]*$/i', $s)) throw new InvalidArgumentException('Invalid identifier');
    }
}
