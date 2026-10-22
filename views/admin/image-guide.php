<?php
// [Lokasi gambar, Menu admin, URL, Izin, Tampil di mana, Ukuran saran]
$rows = [
 'Identitas & Beranda' => [
  ['Logo sekolah', 'Pengaturan Situs → Identitas → Logo', 'admin/settings', 'settings.manage', 'Navbar, loading page, footer, hero beranda, sidebar admin, PDF bukti PPDB', 'PNG persegi ≥ 200×200'],
  ['Favicon', 'Pengaturan Situs → Identitas → Favicon', 'admin/settings', 'settings.manage', 'Ikon tab browser', 'PNG/ICO 64×64'],
  ['Foto Kepala Sekolah', 'Pengaturan Situs → Kepala Sekolah → Foto', 'admin/settings', 'settings.manage', 'Beranda (Sambutan) & halaman Kepala Sekolah', 'Potret ± 3:4'],
  ['Gambar sisi kanan hero', 'Pengaturan Situs → Beranda (Hero)', 'admin/settings', 'settings.manage', 'Sisi kanan hero beranda (kosong = logo)', 'Potret 4:5, ≥ 800×1000'],
  ['Gambar promosi PPDB', 'Pengaturan Situs → PPDB', 'admin/settings', 'settings.manage', 'Banner atas halaman PPDB', 'Landscape 4:3'],
  ['Background hero', 'Homepage → Hero → Gambar', 'admin/homepage', 'settings.manage', 'Latar belakang hero beranda', 'Landscape ≥ 1600×900'],
  ['Gambar section Tentang / Akademik / Magang', 'Homepage → (pilih section) → Gambar', 'admin/homepage', 'settings.manage', 'Section tersebut di beranda', 'Landscape 4:3'],
 ],
 'Halaman profil' => [
  ['Foto Tentang Sekolah, Sejarah, Visi Misi, Tujuan, Struktur Organisasi, PKL, Magang', 'Halaman Profil → Edit → Gambar', 'admin/m/pages', 'content.manage', 'Di samping teks halaman terkait', 'Landscape 4:3'],
  ['Cover & Logo jurusan', 'Jurusan → Edit → Cover / Logo', 'admin/m/majors', 'content.manage', 'Halaman jurusan, kartu jurusan di beranda', 'Cover landscape, logo persegi'],
  ['Foto guru', 'Guru → Edit → Foto', 'admin/m/teachers', 'content.manage', 'Guru & Staff, halaman jurusan', 'Potret/persegi'],
  ['Foto staff', 'Staff → Edit → Foto', 'admin/m/staff', 'content.manage', 'Guru & Staff', 'Potret/persegi'],
  ['Gambar program', 'Program → Edit → Gambar', 'admin/m/programs', 'content.manage', 'Halaman Program', 'Landscape'],
  ['Foto fasilitas', 'Fasilitas → Edit → Foto', 'admin/m/facilities', 'content.manage', 'Beranda & halaman Fasilitas (lightbox)', 'Landscape 16:10'],
  ['Foto & sertifikat prestasi', 'Prestasi → Edit → Foto / Sertifikat (PDF)', 'admin/m/achievements', 'content.manage', 'Halaman Prestasi, jurusan', 'Landscape 16:10'],
  ['Foto alumni', 'Alumni → Edit → Foto', 'admin/m/alumni', 'content.manage', 'Halaman Alumni & Karier', 'Potret/persegi'],
  ['Logo organisasi', 'Organisasi → Edit → Logo', 'admin/m/organizations', 'content.manage', 'Halaman Organisasi', 'Persegi'],
  ['Logo & dokumentasi ekskul', 'Ekstrakurikuler → Edit → Logo / Dokumentasi', 'admin/m/extracurriculars', 'content.manage', 'Halaman Ekstrakurikuler', 'Landscape'],
  ['Logo mitra industri', 'Mitra → Edit → Logo', 'admin/m/companies', 'content.manage', 'Marquee logo & halaman Mitra, PKL, Magang, BKK', 'PNG transparan'],
  ['Dokumen PDF', 'Dokumen PDF → Edit → File PDF', 'admin/m/documents', 'content.manage', 'Halaman Kurikulum (pratinjau/unduh)', 'PDF ≤ 10 MB'],
 ],
 'Informasi & galeri' => [
  ['Gambar utama berita', 'Berita → Edit → Gambar utama', 'admin/m/news', 'news.manage', 'Daftar & detail berita, beranda', 'Landscape 16:9'],
  ['Cover album', 'Album Galeri → Edit → Cover', 'admin/m/galleries', 'gallery.manage', 'Halaman Galeri', 'Landscape'],
  ['Foto-foto galeri (banyak sekaligus)', 'Foto Galeri → Tambah → pilih banyak file', 'admin/m/gallery_items', 'gallery.manage', 'Galeri (lightbox) & beranda', 'Bebas, ≤ 5 MB/foto'],
  ['Gambar Open Graph (preview share)', 'SEO → Edit → Gambar Open Graph', 'admin/m/seo_metadata', 'settings.manage', 'Pratinjau saat tautan dibagikan', '1200×630'],
  ['Unggah umum / simpan file', 'Media Library', 'admin/media', 'media.manage', 'Penyimpanan file bebas', '—'],
 ],
];
?>
<p class="muted">Daftar lengkap tempat mengubah atau menambah gambar/foto di website. Klik nama menu untuk langsung menuju halamannya. Menu yang tidak sesuai hak akses akun Anda ditandai abu-abu.</p>
<?php foreach ($rows as $group => $items): ?>
<div class="panel"><h2><?= e($group) ?></h2><div class="table-wrap"><table class="t guide"><thead><tr><th>Gambar</th><th>Menu admin</th><th>Tampil di</th><th>Ukuran saran</th></tr></thead><tbody>
<?php foreach ($items as [$what, $menu, $href, $perm, $where, $size]): $ok = Auth::can($perm); ?>
<tr><td><strong><?= e($what) ?></strong></td><td><?php if ($ok): ?><a href="<?= e(url($href)) ?>"><?= e($menu) ?></a><?php else: ?><span class="muted"><?= e($menu) ?> (tidak ada akses)</span><?php endif; ?></td><td><?= e($where) ?></td><td><?= e($size) ?></td></tr>
<?php endforeach; ?></tbody></table></div></div>
<?php endforeach; ?>
<p class="hint">Format: JPG, PNG, WebP (GIF untuk beberapa modul). Foto PPDB maks 2 MB; lainnya maks 5 MB. Setelah menyimpan, tekan Ctrl+F5 di halaman website.</p>
