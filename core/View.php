<?php
declare(strict_types=1);

final class View
{
    public static function raw(string $view, array $data = []): void
    {
        extract($data, EXTR_SKIP);
        require BASE_PATH . '/views/' . $view . '.php';
    }

    public static function page(string $view, array $data = [], string $layout = 'layouts/main'): void
    {
        extract($data, EXTR_SKIP);
        ob_start();
        require BASE_PATH . '/views/' . $view . '.php';
        $content = ob_get_clean();
        require BASE_PATH . '/views/' . $layout . '.php';
    }

    public static function admin(string $view, array $data = []): void
    {
        self::page('admin/' . $view, $data, 'layouts/admin');
    }
}
