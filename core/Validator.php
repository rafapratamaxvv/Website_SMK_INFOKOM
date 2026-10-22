<?php
declare(strict_types=1);

final class Validator
{
    public array $errors = [];
    public array $data = [];

    public function __construct(private array $input) {}

    public function str(string $f, string $label, bool $req = true, int $max = 255, int $min = 0): self
    {
        $v = trim((string)($this->input[$f] ?? ''));
        $v = preg_replace('/[\x00-\x08\x0B\x0C\x0E-\x1F]/u', '', $v) ?? '';
        if ($req && $v === '') $this->errors[$f] = "$label wajib diisi.";
        elseif ($v !== '' && mb_strlen($v) > $max) $this->errors[$f] = "$label maksimal $max karakter.";
        elseif ($v !== '' && mb_strlen($v) < $min) $this->errors[$f] = "$label minimal $min karakter.";
        $this->data[$f] = $v;
        return $this;
    }
    public function email(string $f, string $label, bool $req = true): self
    {
        $this->str($f, $label, $req, 150);
        if (!isset($this->errors[$f]) && $this->data[$f] !== '' && !filter_var($this->data[$f], FILTER_VALIDATE_EMAIL)) $this->errors[$f] = "Format $label tidak valid.";
        return $this;
    }
    public function regex(string $f, string $label, string $re, string $msg, bool $req = true, int $max = 50): self
    {
        $this->str($f, $label, $req, $max);
        if (!isset($this->errors[$f]) && $this->data[$f] !== '' && !preg_match($re, $this->data[$f])) $this->errors[$f] = $msg;
        return $this;
    }
    public function inList(string $f, string $label, array $list, bool $req = true): self
    {
        $this->str($f, $label, $req, 100);
        if (!isset($this->errors[$f]) && $this->data[$f] !== '' && !in_array($this->data[$f], $list, true)) $this->errors[$f] = "$label tidak valid.";
        return $this;
    }
    public function date(string $f, string $label, bool $req = true): self
    {
        $this->str($f, $label, $req, 10);
        if (!isset($this->errors[$f]) && $this->data[$f] !== '') {
            $d = DateTime::createFromFormat('Y-m-d', $this->data[$f]);
            if (!$d || $d->format('Y-m-d') !== $this->data[$f]) $this->errors[$f] = "$label tidak valid.";
        }
        return $this;
    }
    public function int(string $f, string $label, int $min = 0, int $max = PHP_INT_MAX, bool $req = true): self
    {
        $raw = trim((string)($this->input[$f] ?? ''));
        if ($raw === '' && !$req) { $this->data[$f] = null; return $this; }
        if (!preg_match('/^-?\d+$/', $raw) || (int)$raw < $min || (int)$raw > $max) { $this->errors[$f] = "$label harus angka $min–$max."; $this->data[$f] = 0; }
        else $this->data[$f] = (int)$raw;
        return $this;
    }
    public function fails(): bool { return $this->errors !== []; }
}
