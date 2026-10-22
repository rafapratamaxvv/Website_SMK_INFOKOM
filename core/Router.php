<?php
declare(strict_types=1);

final class Router
{
    private static array $routes = [];

    public static function add(string $method, string $pattern, callable|array $handler, array $mw = []): void
    {
        $regex = '#^' . preg_replace('#\{([a-z_]+)\}#', '(?P<$1>[^/]+)', $pattern) . '/?$#';
        self::$routes[] = [$method, $regex, $handler, $mw];
    }
    public static function get(string $p, callable|array $h, array $mw = []): void { self::add('GET', $p, $h, $mw); }
    public static function post(string $p, callable|array $h, array $mw = []): void { self::add('POST', $p, $h, $mw); }

    public static function dispatch(): void
    {
        $uri = parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?: '/';
        $base = base_path_url();
        if ($base !== '' && str_starts_with($uri, $base)) $uri = substr($uri, strlen($base));
        $uri = '/' . trim($uri, '/');
        $method = $_SERVER['REQUEST_METHOD'] ?? 'GET';
        $pathMatched = false;

        foreach (self::$routes as [$m, $regex, $handler, $mw]) {
            if (!preg_match($regex, $uri, $mt)) continue;
            $pathMatched = true;
            if ($m !== $method) continue;
            $params = array_filter($mt, 'is_string', ARRAY_FILTER_USE_KEY);
            foreach ($mw as $name) {
                [$cls, $arg] = array_pad(explode(':', $name, 2), 2, null);
                $cls::handle($arg);
            }
            if ($method === 'POST') Csrf::verifyRequest();
            if (is_array($handler)) { [$c, $fn] = $handler; (new $c())->$fn(...array_values($params)); }
            else $handler(...array_values($params));
            return;
        }
        if ($pathMatched) { http_response_code(405); header('Allow: GET, POST'); View::raw('errors/404', []); return; }
        http_response_code(404);
        View::raw('errors/404', []);
    }
}
