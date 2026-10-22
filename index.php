<?php
declare(strict_types=1);
define('BASE_PATH', __DIR__);
require BASE_PATH . '/core/bootstrap.php';
require BASE_PATH . '/routes/web.php';
Router::dispatch();
