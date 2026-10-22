<?php
$tickerDone = false;
$hasStats = in_array('statistics', array_column($sections, 'key'), true);
foreach ($sections as $s) {
    $f = BASE_PATH . '/views/home/' . preg_replace('/[^a-z]/', '', $s['key']) . '.php';
    if (is_file($f)) { echo "\n<!-- section: " . e($s['key']) . " -->\n"; require $f; }
    if (!$tickerDone && (($s['key'] === 'statistics') || ($s['key'] === 'hero' && !$hasStats))) { $tickerDone = true; require BASE_PATH . '/views/home/ticker.php'; }
}
