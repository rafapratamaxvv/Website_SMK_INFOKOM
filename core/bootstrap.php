<?php
declare(strict_types=1);

if (is_file(BASE_PATH . '/vendor/autoload.php')) require BASE_PATH . '/vendor/autoload.php';
require BASE_PATH . '/helpers/functions.php';

// .env
$env = [];
if (is_file(BASE_PATH . '/.env')) {
    foreach (file(BASE_PATH . '/.env', FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES) as $l) {
        if ($l[0] === '#' || !str_contains($l, '=')) continue;
        [$k, $v] = explode('=', $l, 2);
        $env[trim($k)] = trim($v);
    }
}
$GLOBALS['__env'] = $env;

$debug = env('APP_DEBUG', 'false') === 'true';
error_reporting(E_ALL);
ini_set('display_errors', $debug ? '1' : '0');
ini_set('log_errors', '1');
ini_set('error_log', BASE_PATH . '/storage/logs/php-error.log');
date_default_timezone_set('Asia/Jakarta');

foreach (['Database', 'Router', 'Auth', 'Csrf', 'View', 'Upload', 'Validator'] as $c) require BASE_PATH . "/core/$c.php";
foreach (glob(BASE_PATH . '/models/*.php') as $f) require $f;
foreach (glob(BASE_PATH . '/middleware/*.php') as $f) require $f;
foreach (glob(BASE_PATH . '/controllers/*.php') as $f) require $f;

set_exception_handler(function (Throwable $e) use ($debug) {
    error_log((string)$e);
    http_response_code(500);
    if (!headers_sent()) header('Content-Type: text/html; charset=utf-8');
    View::raw('errors/500', ['detail' => $debug ? $e->getMessage() : null]);
});

Auth::startSession();
send_security_headers();
