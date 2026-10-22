<?php
// Hanya untuk development: php -S localhost:8000 router.php
$path = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
if ($path !== '/' && is_file(__DIR__ . $path) && preg_match('~^/(assets|uploads)/~', $path) && !preg_match('/\.php$/i', $path)) return false;
require __DIR__ . '/index.php';
