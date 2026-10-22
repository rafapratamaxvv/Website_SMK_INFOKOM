<?php
declare(strict_types=1);

final class ContactController
{
    public function show(): void
    {
        View::page('pages/kontak', ['meta' => ['title' => 'Kontak', 'description' => 'Hubungi SMK Infokom Kota Bogor.']]);
    }

    public function send(): void
    {
        $v = new Validator($_POST);
        $v->str('name', 'Nama', true, 100, 3)->email('email', 'Email')->regex('phone', 'Telepon', '/^[0-9+\-\s]{8,20}$/', 'Nomor telepon tidak valid.', false, 20)->str('subject', 'Subjek', true, 150, 3)->str('message', 'Pesan', true, 2000, 10);
        if (trim((string)($_POST['website'] ?? '')) !== '') { json_or_redirect(true, 'Terima kasih.', 'kontak'); }
        if ($v->fails()) {
            if (wants_json()) json_out(['ok' => false, 'errors' => $v->errors], 422);
            with_old($v->data, $v->errors); flash('error', 'Periksa kembali isian Anda.'); redirect('kontak');
        }
        Database::insert('contact_messages', $v->data + ['ip' => client_ip()]);
        log_activity('create', 'contact_messages', null, 'Pesan kontak masuk');
        json_or_redirect(true, 'Pesan Anda telah terkirim. Terima kasih!', 'kontak');
    }
}

function json_or_redirect(bool $ok, string $msg, string $to): never
{
    if (wants_json()) json_out(['ok' => $ok, 'message' => $msg]);
    clear_old(); flash($ok ? 'success' : 'error', $msg); redirect($to);
}
