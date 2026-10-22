-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 22 Okt 2026 pada 09.25
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.4.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smk_infokom_bogor`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `achievements`
--

CREATE TABLE `achievements` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL,
  `team` varchar(150) DEFAULT NULL,
  `major_id` int(10) UNSIGNED DEFAULT NULL,
  `competition` varchar(200) DEFAULT NULL,
  `rank_title` varchar(60) DEFAULT NULL,
  `level` varchar(30) NOT NULL DEFAULT 'Kota',
  `category` varchar(60) DEFAULT NULL,
  `year` smallint(5) UNSIGNED NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `certificate` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_demo` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `achievements`
--

INSERT INTO `achievements` (`id`, `title`, `team`, `major_id`, `competition`, `rank_title`, `level`, `category`, `year`, `image`, `certificate`, `description`, `is_active`, `is_demo`) VALUES
(2, 'e-Sport Mobile Legend Festival Dwi Warna (FDW) 2026 RENASCORA', 'Rafisha Wahyu Assila, Mario Ramdani, Gibran Bijaksa S., Julian Iqbal & Alif Saputra Ramadhan', NULL, 'e-Sport Mobile Legend Festival Dwi Warna (FDW) 2026 RENASCORA', '1', 'Kota', 'E-Sport', 2026, 'uploads/achievements/2026/10/a13032283a12dc9b01dd4e66aa1f9c6c.jpg', NULL, '', 1, 0),
(3, 'Lomba Kanji YUKAINE Festival 2025', 'Tim JIC (Mohamad Arjuna Ali)', 2, 'Lomba Kanji YUKAINE Festival 2025', '1', 'Kota', 'Bahasa', 2025, 'uploads/achievements/2026/10/13e97e49ca6d5ea74abb46b1403a6c1e.jpg', NULL, '', 1, 0),
(4, 'Piala Kemerdekaan FutsalBGR 2025', 'Tim Futsal', NULL, 'Piala Kemerdekaan FutsalBGR 2025', '3', 'Kota', 'Olahraga', 2025, 'uploads/achievements/2026/10/268e93ed2a5ddf7bd45034273400dccd.jpg', NULL, '', 1, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `achievement_images`
--

CREATE TABLE `achievement_images` (
  `id` int(10) UNSIGNED NOT NULL,
  `achievement_id` int(10) UNSIGNED NOT NULL,
  `image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `action` varchar(40) NOT NULL,
  `module` varchar(60) NOT NULL,
  `record_id` int(10) UNSIGNED DEFAULT NULL,
  `detail` varchar(500) DEFAULT NULL,
  `ip` varchar(45) NOT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `activity_logs`
--

INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `module`, `record_id`, `detail`, `ip`, `user_agent`, `created_at`) VALUES
(1, 1, 'login', 'auth', 1, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-17 16:31:06'),
(2, 1, 'settings', 'site_settings', NULL, 'school_name, school_short, tagline, logo, favicon, footer_text, address, phone, whatsapp, email, hours, maps_embed, instagram, youtube, facebook, tiktok, color_primary, color_navy, color_accent, principal_name, principal_title, principal_photo, principal_speech, seo_title, seo_description', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-17 16:33:02'),
(3, 1, 'update', 'majors', 1, 'Teknik Komputer dan Jaringan', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-17 16:34:25'),
(4, 1, 'update', 'pages', 1, 'Tentang Sekolah', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-17 16:38:46'),
(5, 1, 'update', 'sections', 3, 'about', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-17 16:39:51'),
(6, 1, 'update', 'sections', 3, 'about', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-17 16:41:46'),
(7, 1, 'update', 'pages', 1, 'Tentang Sekolah', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-17 16:44:07'),
(8, 1, 'update', 'teachers', 2, 'Guru Produktif RPL', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-17 16:53:20'),
(9, 1, 'update', 'teachers', 2, 'Erwin Hasiholan G., S.Kom', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-17 16:54:43'),
(10, 1, 'update', 'teachers', 1, 'Richo Santana, S.Kom.', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-17 16:58:43'),
(11, 1, 'update', 'teachers', 2, 'Erwin Hasiholan G., S.Kom', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-17 16:59:47'),
(12, 1, 'update', 'teachers', 2, 'Erwin Hasiholan G., S.Kom', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-17 17:00:23'),
(13, 1, 'update', 'facilities', 2, 'Laboratorium RPL', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-17 17:01:38'),
(14, 1, 'login', 'auth', 1, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-18 12:54:00'),
(15, 1, 'settings', 'site_settings', NULL, 'school_name, school_short, tagline, footer_text, address, phone, whatsapp, email, hours, maps_embed, instagram, youtube, facebook, tiktok, color_primary, color_navy, color_accent, principal_name, principal_title, principal_photo, principal_speech, seo_title, seo_description', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-18 12:54:44'),
(16, 1, 'update', 'pages', 1, 'Tentang Sekolah', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-18 12:55:40'),
(17, 1, 'update', 'users', 1, 'Ubah akun sendiri + password', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-18 13:00:02'),
(18, 1, 'logout', 'auth', 1, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-18 13:03:09'),
(19, 1, 'login', 'auth', 1, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-18 13:05:21'),
(20, 1, 'login', 'auth', 1, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 00:53:49'),
(21, 1, 'update', 'majors', 2, 'Rekayasa Perangkat Lunak', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 00:56:30'),
(22, 1, 'update', 'majors', 3, 'Desain Komunikasi Visual', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 00:57:01'),
(23, 1, 'update', 'majors', 4, 'Produksi dan Siaran Program Televisi', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 00:57:23'),
(24, 1, 'update', 'majors', 1, 'Teknik Komputer dan Jaringan', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 00:58:23'),
(25, 1, 'logout', 'auth', 1, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 01:46:08'),
(26, 1, 'login', 'auth', 1, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 01:47:22'),
(27, 1, 'settings', 'site_settings', NULL, 'school_name, school_short, tagline, footer_text, marquee_text, address, phone, whatsapp, email, hours, maps_embed, instagram, youtube, facebook, tiktok, color_primary, color_navy, color_accent, principal_name, principal_title, principal_photo, principal_speech, seo_title, seo_description', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 02:00:41'),
(28, 1, 'update', 'teachers', 3, 'Ibnu Arif, S.I.Kom.', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 02:09:40'),
(29, 1, 'create', 'teachers', 5, 'Ir. Hj. Liliek Rahmaningsih, M.MPd', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 02:15:57'),
(30, 1, 'update', 'teachers', 4, 'Erli Suherli, A.Md.', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 02:22:04'),
(31, 1, 'login', 'auth', 1, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 03:29:20'),
(32, 1, 'update', 'teachers', 3, 'Ibnu Arif, S.I.Kom.', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 03:34:02'),
(33, 1, 'update', 'teachers', 4, 'Erli Suherli, A.Md.', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 03:35:17'),
(34, 1, 'create', 'teachers', 6, 'Ridwan Hala, S.Kom.,Gr.', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 03:37:43'),
(35, 1, 'create', 'teachers', 7, 'Aditya Nugraha, ST.', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 03:49:56'),
(36, 1, 'create', 'teachers', 8, 'Mila Yaelasari, M.Pd.', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 04:13:50'),
(37, 1, 'login', 'auth', 1, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 11:49:47'),
(38, 1, 'create', 'teachers', 9, 'Dea Rijalul Fikri, S.Kom.,Gr.', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 11:59:46'),
(39, 1, 'create', 'teachers', 10, 'R. Radiani Srirestuti Dewi, SS.,Gr.', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 12:03:20'),
(40, 1, 'create', 'teachers', 11, 'Heny Handayani, S.Pd.', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 12:05:51'),
(41, 1, 'create', 'teachers', 12, 'Agus Tiyono, M.Pd.', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 12:08:51'),
(42, 1, 'update', 'teachers', 7, 'Aditya Nugraha, ST.', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 12:11:57'),
(43, 1, 'create', 'teachers', 13, 'Cahyadi Rozi, ST.', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 12:15:43'),
(44, 1, 'create', 'teachers', 14, 'Drs. Puji Marhaen Waluyo', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 12:19:23'),
(45, 1, 'create', 'teachers', 15, 'Putri Riandini, S.Hut., M.Pd.,Gr.', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 12:21:12'),
(46, 1, 'create', 'teachers', 16, 'Ahmad Hotib, S.Pd.I', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 12:35:26'),
(47, 1, 'create', 'teachers', 17, 'Abdul Azis, M.Pd.', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 12:36:28'),
(48, 1, 'login', 'auth', 1, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 14:15:11'),
(49, 1, 'create', 'teachers', 18, 'Vera Yuni Astuti, SP., M.IKom.,Gr.', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 14:17:15'),
(50, 1, 'create', 'teachers', 19, 'M. Fauzan Arifin, S.IKom.,Gr.', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 14:24:17'),
(51, 1, 'create', 'teachers', 20, 'Dra. Popon Puspitasari', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 14:29:29'),
(52, 1, 'update', 'teachers', 17, 'Abdul Azis, M.Pd.', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 14:29:39'),
(53, 1, 'update', 'teachers', 16, 'Ahmad Hotib, S.Pd.I', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 14:29:56'),
(54, 1, 'update', 'teachers', 1, 'Richo Santana, S.Kom.', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 14:31:15'),
(55, 1, 'create', 'teachers', 21, 'Dian Hardianti, S.Kom.,Gr.', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 14:33:29'),
(56, 1, 'create', 'teachers', 22, 'Yeni Yuliawati, S.Pd.,Gr.,', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 14:35:25'),
(57, 1, 'create', 'teachers', 23, 'Rita Widyastuti', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 14:36:14'),
(58, 1, 'create', 'teachers', 24, 'Eva Farida Rahayu, S.Pd.,Gr.', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 14:37:16'),
(59, 1, 'create', 'teachers', 25, 'Jayadi, S.Pd.,Gr.', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 14:39:56'),
(60, 1, 'create', 'teachers', 26, 'Yadi Setiadi, S.Sos.,Gr.', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 14:41:55'),
(61, 1, 'update', 'teachers', 26, 'Yadi Setiadi, S.Sos.,Gr.', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 14:42:26'),
(62, 1, 'create', 'teachers', 27, 'Siti Nuraeni', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 14:44:41'),
(63, 1, 'create', 'teachers', 28, 'Reza Prafitriansyah, S.Kom.,Gr.', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 14:48:33'),
(64, 1, 'create', 'teachers', 29, 'Dra. Diana Octaria', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 14:52:39'),
(65, 1, 'create', 'teachers', 30, 'Nabila Ahmadia Pratama, S.Pd.', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 14:54:04'),
(66, 1, 'create', 'teachers', 31, 'Widyatama Nuranisa, SM.', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 14:55:48'),
(67, 1, 'create', 'teachers', 32, '- Dara Purwanita, S.Pd.,Gr.', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 14:56:26'),
(68, 1, 'update', 'teachers', 5, 'Ir. Hj. Liliek Rahmaningsih, M.MPd', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 14:58:23'),
(69, 1, 'update', 'teachers', 5, 'Ir. Hj. Liliek Rahmaningsih, M.MPd', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 14:59:32'),
(70, 1, 'update', 'teachers', 5, 'Ir. Hj. Liliek Rahmaningsih, M.MPd', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 15:00:10'),
(71, 1, 'delete', 'staff', 1, 'Staff Tata Usaha', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 15:07:03'),
(72, 1, 'delete', 'teachers', 5, 'Ir. Hj. Liliek Rahmaningsih, M.MPd', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 15:07:43'),
(73, 1, 'create', 'teachers', 33, 'Ir. Hj. Liliek Rahmaningsih, M.MPd', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 15:08:12'),
(74, 1, 'login', 'auth', 1, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 16:20:00'),
(75, 1, 'update', 'facilities', 1, 'Laboratorium TKJ', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 16:22:14'),
(76, 1, 'update', 'facilities', 3, 'Laboratorium DKV', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 16:22:32'),
(77, 1, 'update', 'facilities', 4, 'Studio PSPT', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 16:24:07'),
(78, 1, 'update', 'facilities', 4, 'Studio PSPT', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 16:24:44'),
(79, 1, 'update', 'facilities', 5, 'Perpustakaan', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 16:24:59'),
(80, 1, 'update', 'facilities', 6, 'Ruang Kelas', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 16:25:08'),
(81, 1, 'update', 'facilities', 8, 'Tempat Ibadah', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 16:25:23'),
(82, 1, 'update', 'facilities', 7, 'Gedung Kelas', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 16:26:50'),
(83, 1, 'update', 'facilities', 8, 'Mushola', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 16:27:59'),
(84, 1, 'update', 'extracurriculars', 1, 'Pramuka', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 16:39:47'),
(85, 1, 'create', 'extracurriculars', 2, 'Paskibra', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 16:47:40'),
(86, 1, 'create', 'extracurriculars', 3, 'Palang Merah Indonesia', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 17:11:57'),
(87, 1, 'logout', 'auth', 1, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 17:42:54'),
(88, 1, 'login', 'auth', 1, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 15:37:36'),
(89, 1, 'update', 'majors', 1, 'Teknik Komputer dan Jaringan', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 15:38:12'),
(90, 1, 'update', 'majors', 2, 'Rekayasa Perangkat Lunak', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 15:38:45'),
(91, 1, 'update', 'majors', 3, 'Desain Komunikasi Visual', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 15:38:57'),
(92, 1, 'update', 'majors', 4, 'Produksi dan Siaran Program Televisi', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 15:39:07'),
(93, 1, 'login', 'auth', 1, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 17:59:02'),
(94, 1, 'create', 'facilities', 9, 'Kantin Sekolah', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 18:03:43'),
(95, 1, 'update', 'facilities', 9, 'Kantin Sekolah', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 18:06:09'),
(96, 1, 'create', 'facilities', 10, 'Teller Bank Sekolah', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 18:08:05'),
(97, 1, 'create', 'ppdb_registrants', 1, 'PPDB-2026-0001', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 18:17:01'),
(98, 1, 'login', 'auth', 1, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 02:23:43'),
(99, 1, 'settings', 'site_settings', NULL, 'school_name, school_short, tagline, footer_text, marquee_text, address, phone, whatsapp, email, hours, maps_embed, instagram, youtube, facebook, tiktok, color_primary, color_navy, color_accent, principal_name, principal_title, principal_speech, chatbot_enabled, chatbot_name, chatbot_greeting, chatbot_knowledge, seo_title, seo_description', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 03:17:12'),
(100, 1, 'login', 'auth', 1, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 10:44:35'),
(101, 1, 'update', 'achievements', 2, 'e-Sport Mobile Legend Festival Dwi Warna (FDW) 2026 RENASCORA', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 10:46:32'),
(102, 1, 'update', 'achievements', 4, 'Piala Kemerdekaan FutsalBGR 2025', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 10:47:31'),
(103, 1, 'update', 'achievements', 2, 'e-Sport Mobile Legend Festival Dwi Warna (FDW) 2026 RENASCORA', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 10:47:44'),
(104, 1, 'update', 'achievements', 3, 'Lomba Kanji YUKAINE Festival 2025', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 10:48:03'),
(105, 1, 'update', 'industry_visits', 1, 'Kunjungan Industri Universitas Amikom Yogyakarta & PT Git Solution', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 10:50:44'),
(106, 1, 'update', 'industry_visits', 2, 'Studio Visit Trans 7', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 10:51:50'),
(107, 1, 'update', 'gallery_items', 13, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 10:53:11'),
(108, 1, 'update', 'gallery_items', 12, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 10:53:30'),
(109, 1, 'update', 'gallery_items', 11, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 10:53:38'),
(110, 1, 'update', 'gallery_items', 10, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 10:55:28'),
(111, 1, 'update', 'gallery_items', 9, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 10:56:01'),
(112, 1, 'update', 'gallery_items', 8, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 10:56:52'),
(113, 1, 'update', 'gallery_items', 7, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 10:59:50'),
(114, 1, 'update', 'gallery_items', 5, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 11:00:55'),
(115, 1, 'update', 'gallery_items', 5, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 11:01:08'),
(116, 1, 'update', 'gallery_items', 6, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 11:04:21'),
(117, 1, 'create', 'ppdb_registrants', 2, 'PPDB-2026-0002', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 11:13:34'),
(118, 1, 'update', 'companies', 27, 'by.U', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 11:46:09'),
(119, 1, 'update', 'companies', 45, 'Danantara Indonesia', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 11:46:37'),
(120, 1, 'update', 'companies', 4, 'Institut Pertanian Bogor (IPB)', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 11:47:02'),
(121, 1, 'update', 'companies', 19, 'IPB Press', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 11:48:09'),
(122, 1, 'update', 'companies', 4, 'Institut Pertanian Bogor (IPB)', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 11:48:18'),
(123, 1, 'update', 'companies', 15, 'Jawa Pos', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 11:49:11'),
(124, 1, 'update', 'companies', 45, 'Danantara Indonesia', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 11:52:27'),
(125, 1, 'update', 'companies', 45, 'Danantara Indonesia', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 11:53:55'),
(126, 1, 'update', 'companies', 35, 'Azalee Group', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 11:56:30'),
(127, 1, 'update', 'companies', 47, 'Misono Corp (Japan)', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 11:58:54'),
(128, 1, 'update', 'companies', 33, 'MCM', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 12:00:59'),
(129, 1, 'update', 'companies', 26, 'anteraja', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 12:13:35'),
(130, 1, 'update', 'companies', 22, 'Cakrawala Digital Indonesia', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 12:20:57'),
(131, 1, 'update', 'companies', 13, 'Bank BJB Syariah', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 12:25:36'),
(132, 1, 'update', 'companies', 14, 'Bank Mandiri', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 12:27:07'),
(133, 1, 'update', 'companies', 12, 'Bank Syariah Indonesia (BSI)', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 12:27:57'),
(134, 1, 'update', 'companies', 29, 'Bharata Tour Organizer', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 12:29:13'),
(135, 1, 'update', 'companies', 34, 'Bro Tokyo Barbershop', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 12:34:10'),
(136, 1, 'update', 'companies', 47, 'Misono Corp (Japan)', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 12:34:45'),
(137, 1, 'delete', 'companies', 28, 'Cabs', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 12:36:51'),
(138, 1, 'update', 'companies', 21, 'MSV Studio', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 12:38:58'),
(139, 1, 'update', 'companies', 31, 'Laku', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 12:40:25'),
(140, 1, 'update', 'companies', 20, 'BONET IT Solution Partner', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 12:42:42'),
(141, 1, 'update', 'companies', 8, 'Institut Bisnis & Informatika Kesatuan', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 12:44:52'),
(142, 1, 'update', 'companies', 38, 'Sakura Edukasi', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 12:46:36'),
(143, 1, 'update', 'companies', 43, 'PT IJO Inovasi Indonesia', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 12:47:08'),
(144, 1, 'update', 'companies', 46, 'PT Alura Warna Kreasi', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 12:47:26'),
(145, 1, 'update', 'companies', 37, 'Sekisho Group', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 12:49:54'),
(146, 1, 'update', 'companies', 44, 'PT Berkah Legal', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 12:50:20'),
(147, 1, 'update', 'companies', 24, 'AiCI (Artificial Intelligence Center Indonesia)', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 12:51:30'),
(148, 1, 'update', 'companies', 7, 'Universitas Gunadarma', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 12:52:18'),
(149, 1, 'update', 'companies', 5, 'Telkom University', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 12:54:41'),
(150, 1, 'update', 'companies', 6, 'Universitas Pakuan', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 12:55:30'),
(151, 1, 'update', 'companies', 9, 'Universitas Ibn Khaldun (UIKA) Bogor', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 12:56:35'),
(152, 1, 'update', 'companies', 10, 'Universitas Bunda Mulia', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 12:57:18'),
(153, 1, 'update', 'companies', 42, 'PT Aghanim Multi Industri (Octarine Parfume)', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 12:57:37'),
(154, 1, 'update', 'companies', 36, 'PT Dwi Tunggal Jaya Abadi', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 12:57:58'),
(155, 1, 'update', 'companies', 41, 'PT Mitra Copierindo Mandiri (MCM)', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 12:58:25'),
(156, 1, 'update', 'companies', 23, 'CitraWeb Solusi Teknologi', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 13:00:15'),
(157, 1, 'update', 'companies', 30, 'Mega Motor', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 13:02:03'),
(158, 1, 'update', 'companies', 11, 'The Japan Foundation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 13:03:01'),
(159, 1, 'update', 'companies', 11, 'The Japan Foundation', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 13:03:17'),
(160, 1, 'update', 'companies', 39, 'Tenma Hospital Group', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 13:04:11'),
(161, 1, 'delete', 'companies', 40, 'Taman Safari Bogor', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 13:06:14'),
(162, 1, 'update', 'companies', 16, 'AdiTV', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 13:06:58'),
(163, 1, 'update', 'companies', 17, 'Tribunnews.com', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 13:08:13'),
(164, 1, 'update', 'curriculum', 6, 'Sertifikasi', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 13:25:46'),
(165, 1, 'update', 'curriculum', 7, 'Teaching Factory', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 13:26:48'),
(166, 1, 'update', 'faq', 3, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 13:27:21'),
(167, 1, 'update', 'news', 2, 'Peringatan Maulid Nabi Muhammad SAW di SMK Infokom', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 13:28:06'),
(168, 1, 'update', 'news', 3, 'Lomba 17 Agustus SMK Infokom', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 13:28:23'),
(169, 1, 'update', 'news', 7, 'Peringatan Isra Mi\'raj Nabi Muhammad SAW', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 13:29:01'),
(170, 1, 'update', 'news', 4, 'Upacara Tahun Ajaran Baru 2026/2027 SMK Infokom', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 13:29:10'),
(171, 1, 'update', 'news', 5, 'Siswa SMK Infokom Berhasil Diterima Program Magang ke Jepang', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 13:29:20'),
(172, 1, 'update', 'news', 6, 'Uji Kompetensi Keahlian (UKK) SMK Infokom', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 13:29:31'),
(173, 1, 'update', 'news', 5, 'Siswa SMK Infokom Berhasil Diterima Program Magang ke Jepang', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 13:32:59'),
(174, 1, 'update', 'news', 5, 'Siswa SMK Infokom Berhasil Diterima Program Magang ke Jepang', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 13:33:07'),
(175, 1, 'update', 'pages', 5, 'Struktur Organisasi', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 13:38:32'),
(176, 1, 'update', 'organizations', 1, 'OSIS SMK Infokom', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 13:46:44'),
(177, 1, 'update', 'pages', 11, 'BKK (Bursa Kerja Khusus)', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 13:50:08'),
(178, 1, 'settings', 'ppdb_settings', 1, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 13:53:21'),
(179, 1, 'update', 'ppdb_periods', 1, 'Gelombang 1', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 13:55:51'),
(180, 1, 'create', 'ppdb_periods', 2, 'Gelombang 2', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 13:56:50'),
(181, 1, 'create', 'ppdb_periods', 3, 'Gelombang 3', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 13:57:33'),
(182, 1, 'settings', 'site_settings', NULL, 'school_name, school_short, tagline, footer_text, marquee_text, address, phone, whatsapp, email, hours, maps_embed, instagram, youtube, facebook, tiktok, color_primary, color_navy, color_accent, principal_name, principal_title, principal_speech, ppdb_banner, chatbot_enabled, chatbot_name, chatbot_greeting, chatbot_knowledge, seo_title, seo_description', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 14:11:09'),
(183, 1, 'update', 'alumni', 1, 'Ahmad Fadilah', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 14:15:05'),
(184, 1, 'update', 'alumni', 1, 'Ahmad Fadilah', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 14:15:27'),
(185, 1, 'login', 'auth', 1, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 15:20:41'),
(186, 1, 'login', 'auth', 1, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 16:14:28'),
(187, 1, 'login', 'auth', 1, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 17:50:01'),
(188, 1, 'logout', 'auth', 1, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 17:56:27'),
(189, 1, 'login', 'auth', 1, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 17:56:48'),
(190, 1, 'login', 'auth', 1, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 00:15:14'),
(191, 1, 'update', 'pages', 8, 'Kurikulum', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 00:16:27'),
(192, 1, 'update', 'gallery_items', 2, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 00:21:18'),
(193, 1, 'update', 'gallery_items', 3, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 00:21:51'),
(194, 1, 'update', 'gallery_items', 1, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 00:22:19'),
(195, 1, 'create', 'galleries', 12, 'Magang', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 00:24:03'),
(196, 1, 'create', 'gallery_items', 14, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 00:24:59'),
(197, 1, 'update', 'gallery_items', 14, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 00:29:24'),
(198, 1, 'update', 'gallery_items', 8, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 00:32:00'),
(199, 1, 'update', 'programs', 2, 'Magang', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 00:45:29'),
(200, 1, 'update', 'programs', 2, 'Magang', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 00:46:24'),
(201, 1, 'update', 'internship_media', 1, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 00:47:06'),
(202, 1, 'update', 'internship_media', 2, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 00:47:17'),
(203, 1, 'update', 'internship_media', 3, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 00:47:28'),
(204, 1, 'create', 'videos', 3, 'PEMBUKAAN PRAKTIK KERJA INDUSTI (PKL) dan WORKSHOP PENGUATAN KARAKTER SMK INFOKOM BOGOR #smkbisa', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 01:05:12'),
(205, 1, 'update', 'sections', 9, 'magang', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 01:17:29'),
(206, 1, 'update', 'sections', 9, 'magang', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 01:19:59'),
(207, 1, 'update', 'sections', 7, 'academic', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 01:21:22'),
(208, 1, 'login', 'auth', 1, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 04:19:00'),
(209, 1, 'create', 'teachers', 34, 'Rafa Pratama', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 04:20:03'),
(210, 1, 'update', 'teachers', 34, 'Pak Ridwan Hala', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 04:21:17'),
(211, 1, 'delete', 'teachers', 34, 'Pak Ridwan Hala', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 04:21:59'),
(212, 1, 'settings', 'ppdb_settings', 1, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 04:43:44'),
(213, 1, 'update', 'ppdb_periods', 2, 'Gelombang 2', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 04:47:18'),
(214, 1, 'update', 'ppdb_periods', 3, 'Gelombang 3', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 04:50:27'),
(215, 1, 'login', 'auth', 1, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 07:18:31');

-- --------------------------------------------------------

--
-- Struktur dari tabel `agenda`
--

CREATE TABLE `agenda` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` varchar(400) DEFAULT NULL,
  `location` varchar(150) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_demo` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `agenda`
--

INSERT INTO `agenda` (`id`, `title`, `description`, `location`, `start_date`, `end_date`, `is_active`, `is_demo`) VALUES
(2, 'Awal Tahun Ajaran Baru 2026/2027', 'Akademik — Hari pertama masuk sekolah tahun ajaran baru.', NULL, '2026-07-15', NULL, 1, 0),
(3, 'MPLS (Masa Pengenalan Lingkungan Sekolah)', 'Kegiatan — Kegiatan pengenalan untuk siswa baru.', NULL, '2026-07-15', '2026-07-17', 1, 0),
(4, 'HUT Kemerdekaan RI', 'Libur — Peringatan Hari Kemerdekaan Republik Indonesia.', NULL, '2026-08-17', NULL, 1, 0),
(5, 'Penilaian Tengah Semester (PTS) Ganjil', 'Ujian — Ujian tengah semester ganjil.', NULL, '2026-10-21', '2026-10-25', 1, 0),
(6, 'Penilaian Akhir Semester (PAS) Ganjil', 'Ujian — Ujian akhir semester ganjil.', NULL, '2026-12-01', '2026-12-10', 1, 0),
(7, 'Libur Semester 1', 'Libur — Libur akhir semester ganjil.', NULL, '2026-12-20', '2027-01-03', 1, 0),
(8, 'Hari Raya Natal', 'Libur — Hari Raya Natal.', NULL, '2026-12-25', NULL, 1, 0),
(9, 'Tahun Baru 2027', 'Libur — Tahun Baru Masehi.', NULL, '2027-01-01', NULL, 1, 0),
(10, 'Penilaian Tengah Semester (PTS) Genap', 'Ujian — Ujian tengah semester genap.', NULL, '2027-03-10', '2027-03-14', 1, 0),
(11, 'Hari Raya Idul Fitri', 'Libur — Hari Raya Idul Fitri.', NULL, '2027-03-20', '2027-03-21', 1, 0),
(12, 'Penilaian Akhir Semester (PAS) Genap', 'Ujian — Ujian akhir semester genap.', NULL, '2027-06-01', '2027-06-10', 1, 0),
(13, 'Libur Semester 2 / Akhir Tahun Ajaran', 'Libur — Libur akhir tahun ajaran.', NULL, '2027-06-20', '2027-07-11', 1, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `alumni`
--

CREATE TABLE `alumni` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `grad_year` smallint(5) UNSIGNED NOT NULL,
  `major_id` int(10) UNSIGNED DEFAULT NULL,
  `job` varchar(120) DEFAULT NULL,
  `company` varchar(150) DEFAULT NULL,
  `college` varchar(150) DEFAULT NULL,
  `entrepreneur` varchar(150) DEFAULT NULL,
  `testimonial` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_demo` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `alumni`
--

INSERT INTO `alumni` (`id`, `name`, `photo`, `grad_year`, `major_id`, `job`, `company`, `college`, `entrepreneur`, `testimonial`, `is_active`, `is_demo`) VALUES
(1, 'Ahmad Fadilah', NULL, 2023, 2, 'Software Engineering', 'PT Kosmik Computer', '', '', '\"Saya mengambil jurusan RPL karena memiliki minat dalam bidang coding. Minat tersebut muncul sejak SMP dan kemudian diseriusi di SMK SMK Infokom Kota Bogor dengan bimbingan guru-guru yang sangat membantu dan fasilitas praktik yang memadai.\"', 1, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `announcements`
--

CREATE TABLE `announcements` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL,
  `body` text DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `show_in_bar` tinyint(1) NOT NULL DEFAULT 0,
  `starts_at` date DEFAULT NULL,
  `ends_at` date DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_demo` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `announcements`
--

INSERT INTO `announcements` (`id`, `title`, `body`, `link`, `show_in_bar`, `starts_at`, `ends_at`, `is_active`, `is_demo`, `created_at`) VALUES
(1, 'Informasi PPDB SMK Infokom dibuka. Cek jadwal dan persyaratan.', 'Pendaftaran peserta didik baru dapat dilakukan online.', '/ppdb', 1, NULL, NULL, 1, 0, '2026-10-17 16:23:24');

-- --------------------------------------------------------

--
-- Struktur dari tabel `bkk`
--

CREATE TABLE `bkk` (
  `id` int(10) UNSIGNED NOT NULL,
  `kind` varchar(30) NOT NULL DEFAULT 'profil',
  `title` varchar(150) NOT NULL,
  `content` text DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_demo` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `bkk`
--

INSERT INTO `bkk` (`id`, `kind`, `title`, `content`, `sort_order`, `is_active`, `is_demo`) VALUES
(5, 'profil', 'Apa Itu BKK?', 'Jembatan ke Dunia Kerja, Bukan Sekadar Info Loker. Bursa Kerja Khusus (BKK) adalah unit resmi sekolah yang menghubungkan alumni SMK INFOKOM — dan masyarakat umum — dengan perusahaan mitra yang sedang membuka lowongan.', 1, 1, 0),
(6, 'profil', 'Kenapa Lewat BKK?', 'Lowongan sudah diverifikasi sekolah, bukan broadcast sembarangan.\nTerbuka untuk alumni maupun masyarakat umum.\nKontak perusahaan jelas — WA, email, sampai link lamar.', 2, 1, 0),
(7, 'rekrutmen', 'Update Lowongan Terbaru', 'Follow Instagram @bkkinfokom (https://www.instagram.com/bkkinfokom) untuk update lowongan terbaru.', 3, 1, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `companies`
--

CREATE TABLE `companies` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `industry` varchar(100) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `location` varchar(150) DEFAULT NULL,
  `cooperation` varchar(255) DEFAULT NULL,
  `is_pkl` tinyint(1) NOT NULL DEFAULT 0,
  `is_magang` tinyint(1) NOT NULL DEFAULT 0,
  `is_recruit` tinyint(1) NOT NULL DEFAULT 0,
  `is_tefa` tinyint(1) NOT NULL DEFAULT 0,
  `since_year` smallint(5) UNSIGNED DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_demo` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `companies`
--

INSERT INTO `companies` (`id`, `name`, `logo`, `industry`, `website`, `location`, `cooperation`, `is_pkl`, `is_magang`, `is_recruit`, `is_tefa`, `since_year`, `is_active`, `is_demo`) VALUES
(4, 'Institut Pertanian Bogor (IPB)', 'uploads/companies/2026/10/aa29cd0cbfebfa3eed60d98761d38f73.webp', 'Kerjasama Universitas', NULL, '', 'Kerja sama akademik: jalur lanjut ke perguruan tinggi', 1, 0, 0, 0, NULL, 1, 0),
(5, 'Telkom University', 'uploads/companies/2026/10/61252a28564a42d0e561dabd086960aa.webp', 'Kerjasama Universitas', NULL, '', 'Kerja sama akademik: jalur lanjut ke perguruan tinggi', 0, 0, 0, 0, NULL, 1, 0),
(6, 'Universitas Pakuan', 'uploads/companies/2026/10/ca6d27ba7b32e728c62e8a52b4f4ec07.webp', 'Kerjasama Universitas', NULL, '', 'Kerja sama akademik: jalur lanjut ke perguruan tinggi', 0, 0, 0, 0, NULL, 1, 0),
(7, 'Universitas Gunadarma', 'uploads/companies/2026/10/83ac8da08651846ee60c83aff7c7487a.webp', 'Kerjasama Universitas', NULL, '', 'Kerja sama akademik: jalur lanjut ke perguruan tinggi', 0, 0, 0, 0, NULL, 1, 0),
(8, 'Institut Bisnis & Informatika Kesatuan', 'uploads/companies/2026/10/3133f271d01cf45ac475660dac2f3333.png', 'Kerjasama Universitas', NULL, '', 'Kerja sama akademik: jalur lanjut ke perguruan tinggi', 1, 0, 0, 0, NULL, 1, 0),
(9, 'Universitas Ibn Khaldun (UIKA) Bogor', 'uploads/companies/2026/10/77bbd9151163e73fd833da6537aa95b4.png', 'Kerjasama Universitas', NULL, '', 'Kerja sama akademik: jalur lanjut ke perguruan tinggi', 0, 0, 0, 0, NULL, 1, 0),
(10, 'Universitas Bunda Mulia', 'uploads/companies/2026/10/7c2536f8edae1450984e645fed0fcb41.webp', 'Kerjasama Universitas', NULL, '', 'Kerja sama akademik: jalur lanjut ke perguruan tinggi', 0, 0, 0, 0, NULL, 1, 0),
(11, 'The Japan Foundation', 'uploads/companies/2026/10/29129ee1589ac10dd5869741d94ae937.png', 'Kerjasama Universitas', NULL, '', 'Kerja sama akademik: jalur lanjut ke perguruan tinggi', 0, 1, 0, 0, NULL, 1, 0),
(12, 'Bank Syariah Indonesia (BSI)', 'uploads/companies/2026/10/f81abf0ba92225fbba5923a6f66effe2.jpg', 'Industri & Instansi', NULL, '', 'Mitra PKL & rekrutmen alumni', 1, 0, 0, 0, NULL, 1, 0),
(13, 'Bank BJB Syariah', 'uploads/companies/2026/10/5a687f2f2284dfbb0b67a6c91542e39c.jpg', 'Industri & Instansi', NULL, '', 'Mitra PKL & rekrutmen alumni', 1, 0, 0, 0, NULL, 1, 0),
(14, 'Bank Mandiri', 'uploads/companies/2026/10/c5d54058bcdfaa21b498d34bec89f3c6.jpg', 'Industri & Instansi', NULL, '', 'Mitra PKL & rekrutmen alumni', 1, 0, 0, 0, NULL, 1, 0),
(15, 'Jawa Pos', 'uploads/companies/2026/10/20a8a19913c50d5909a58bd2e513babc.png', 'Industri & Instansi', NULL, '', 'Mitra PKL & rekrutmen alumni', 1, 0, 0, 0, NULL, 1, 0),
(16, 'AdiTV', 'uploads/companies/2026/10/053a24c050b5f61dfa9949b8bce754bc.gif', 'Industri & Instansi', NULL, '', 'Mitra PKL & rekrutmen alumni', 1, 0, 1, 0, NULL, 1, 0),
(17, 'Tribunnews.com', 'uploads/companies/2026/10/15567bbeaaa46ba8ac655064bd168dee.webp', 'Industri & Instansi', NULL, '', 'Mitra PKL & rekrutmen alumni', 1, 0, 1, 0, NULL, 1, 0),
(18, 'Pasundan Media Net', NULL, 'Industri & Instansi', NULL, NULL, 'Mitra PKL & rekrutmen alumni', 1, 0, 0, 0, NULL, 1, 0),
(19, 'IPB Press', 'uploads/companies/2026/10/0050c4a8d893aad5ace650826d683a39.png', 'Industri & Instansi', NULL, '', 'Mitra PKL & rekrutmen alumni', 1, 0, 0, 0, NULL, 1, 0),
(20, 'BONET IT Solution Partner', 'uploads/companies/2026/10/74af3e528bd8e42b787de7df48b64887.jpg', 'Industri & Instansi', NULL, '', 'Mitra PKL & rekrutmen alumni', 1, 0, 1, 0, NULL, 1, 0),
(21, 'MSV Studio', 'uploads/companies/2026/10/371027461310560826999d0854b83319.jpg', 'Industri & Instansi', NULL, '', 'Mitra PKL & rekrutmen alumni', 1, 1, 1, 0, NULL, 1, 0),
(22, 'Cakrawala Digital Indonesia', 'uploads/companies/2026/10/bc3506372f34a0a23b04ce9d75b1717b.png', 'Industri & Instansi', NULL, '', 'Mitra PKL & rekrutmen alumni', 1, 0, 1, 0, NULL, 1, 0),
(23, 'CitraWeb Solusi Teknologi', 'uploads/companies/2026/10/e1df70ba66c777b0c7bdeea11f1d2b43.jpg', 'Industri & Instansi', NULL, '', 'Mitra PKL & rekrutmen alumni', 1, 0, 0, 0, NULL, 1, 0),
(24, 'AiCI (Artificial Intelligence Center Indonesia)', 'uploads/companies/2026/10/5152dee92bc976c71c77ae306404c1ac.png', 'Industri & Instansi', NULL, '', 'Mitra PKL & rekrutmen alumni', 1, 0, 1, 0, NULL, 1, 0),
(25, 'OSM (PT Ovall Solusindo Mandiri)', NULL, 'Industri & Instansi', NULL, NULL, 'Mitra PKL & rekrutmen alumni', 1, 0, 0, 0, NULL, 1, 0),
(26, 'anteraja', 'uploads/companies/2026/10/a5714a126c579f0254fe4282877a5e80.jpg', 'Industri & Instansi', NULL, '', 'Mitra PKL & rekrutmen alumni', 1, 0, 0, 0, NULL, 1, 0),
(27, 'by.U', 'uploads/companies/2026/10/9e635274ff636e92a6da09046d19a388.png', 'Industri & Instansi', NULL, '', 'Mitra PKL & rekrutmen alumni', 1, 0, 0, 0, NULL, 1, 0),
(29, 'Bharata Tour Organizer', 'uploads/companies/2026/10/8ad287a1d9d1fd17f5a13101d89a2183.jpg', 'Industri & Instansi', NULL, '', 'Mitra PKL & rekrutmen alumni', 1, 0, 0, 0, NULL, 1, 0),
(30, 'Mega Motor', 'uploads/companies/2026/10/5718feacb11f290766c6ad991ecb5a72.png', 'Industri & Instansi', NULL, '', 'Mitra PKL & rekrutmen alumni', 1, 0, 1, 0, NULL, 1, 0),
(31, 'Laku', 'uploads/companies/2026/10/33084a17ca9242b484ce2c4c09274396.png', 'Industri & Instansi', NULL, '', 'Mitra PKL & rekrutmen alumni', 1, 0, 1, 0, NULL, 1, 0),
(32, 'Almadita Sinergi Solusi', NULL, 'Industri & Instansi', NULL, NULL, 'Mitra PKL & rekrutmen alumni', 1, 0, 0, 0, NULL, 1, 0),
(33, 'MCM', 'uploads/companies/2026/10/b4adbc4b365fb46cc909df570761e3b9.jpg', 'Industri & Instansi', NULL, '', 'Mitra PKL & rekrutmen alumni', 1, 0, 0, 0, NULL, 1, 0),
(34, 'Bro Tokyo Barbershop', 'uploads/companies/2026/10/ecbdd4148db3024675de78934734f422.png', 'Industri & Instansi', NULL, '', 'Mitra PKL & rekrutmen alumni', 0, 1, 1, 0, NULL, 1, 0),
(35, 'Azalee Group', 'uploads/companies/2026/10/79ce97b0845faacd036d8fa72ab2308c.jpg', 'Industri & Instansi', NULL, '', 'Mitra PKL & rekrutmen alumni', 1, 0, 0, 0, NULL, 1, 0),
(36, 'PT Dwi Tunggal Jaya Abadi', 'uploads/companies/2026/10/3cdf6bbf50b12f5784172d6164bbe882.jpg', 'Teknologi & Administrasi', NULL, 'Bogor', 'PKL & rekrutmen Admin / Programmer', 1, 0, 1, 0, NULL, 1, 0),
(37, 'Sekisho Group', 'uploads/companies/2026/10/b597a6c981b1b694c04e81025c5ef782.png', 'Industri & Instansi', NULL, '', 'Mitra PKL & rekrutmen alumni', 1, 1, 1, 0, NULL, 1, 0),
(38, 'Sakura Edukasi', 'uploads/companies/2026/10/084cbc5c5dc4ba78f7596e4b575798ee.jpg', 'Industri & Instansi', NULL, '', 'Mitra PKL & rekrutmen alumni', 0, 1, 1, 0, NULL, 1, 0),
(39, 'Tenma Hospital Group', 'uploads/companies/2026/10/6997d7ee813b5073fbc054a274172bb4.png', 'Industri & Instansi', NULL, '', 'Mitra PKL & rekrutmen alumni', 1, 0, 1, 0, NULL, 1, 0),
(41, 'PT Mitra Copierindo Mandiri (MCM)', 'uploads/companies/2026/10/501442095b4f2ff75eea2b1693733a03.jpg', 'Teknologi', NULL, 'Bogor', 'Rekrutmen & Prakerin TKJ — penyedia solusi perangkat kantor & printer', 1, 0, 1, 0, NULL, 1, 0),
(42, 'PT Aghanim Multi Industri (Octarine Parfume)', 'uploads/companies/2026/10/e02c562d9f15555a36ff11536a023ec9.jpg', 'Industri Manufaktur', NULL, '', 'Rekrutmen Production Operator — perusahaan manufaktur parfum', 0, 0, 1, 0, NULL, 1, 0),
(43, 'PT IJO Inovasi Indonesia', 'uploads/companies/2026/10/edc18ae21126159dd3bf790a8d2702ce.jpg', 'Kreatif & Media', NULL, '', 'Rekrutmen Design & Video — studio kreatif bidang multimedia', 1, 0, 1, 0, NULL, 1, 0),
(44, 'PT Berkah Legal', 'uploads/companies/2026/10/ba30e04a6cd850a16326816874d483af.webp', 'Hukum & Digital', NULL, '', 'Rekrutmen SEO Website — perusahaan jasa legal & SEO', 0, 0, 1, 0, NULL, 1, 0),
(45, 'Danantara Indonesia', 'uploads/companies/2026/10/2b3d5a803ec76719c2afcbe8e77920af.jpg', 'Keuangan / Pembiayaan', NULL, '', 'Rekrutmen Account Officer — perusahaan pembiayaan mikro', 0, 0, 1, 0, NULL, 1, 0),
(46, 'PT Alura Warna Kreasi', 'uploads/companies/2026/10/91067b871d704fc334b05f44c1897219.png', 'Fotografi & Media', NULL, 'Cikarang', 'Rekrutmen Photographer — studio fotografi profesional', 1, 0, 1, 0, NULL, 1, 0),
(47, 'Misono Corp (Japan)', 'uploads/companies/2026/10/2f2db66d964b23e275f78948e7bdbe43.png', 'Manufaktur Makanan', NULL, 'Kagoshima, Jepang', 'Program Magang Internasional — pengolahan makanan', 0, 1, 1, 0, NULL, 1, 0),
(48, 'River Co', 'uploads/impor/mitra/river-co.jpeg', 'Manufaktur Makanan', NULL, 'Tokyo, Jepang', 'Program Magang ke Tokyo untuk alumni SMK INFOKOM', 0, 1, 0, 0, NULL, 1, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `company_partnerships`
--

CREATE TABLE `company_partnerships` (
  `id` int(10) UNSIGNED NOT NULL,
  `company_id` int(10) UNSIGNED NOT NULL,
  `type` varchar(40) NOT NULL,
  `note` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `contact_messages`
--

CREATE TABLE `contact_messages` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `subject` varchar(150) NOT NULL,
  `message` text NOT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `curriculum`
--

CREATE TABLE `curriculum` (
  `id` int(10) UNSIGNED NOT NULL,
  `category` varchar(40) NOT NULL,
  `title` varchar(160) NOT NULL,
  `content` text DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_demo` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `curriculum`
--

INSERT INTO `curriculum` (`id`, `category`, `title`, `content`, `sort_order`, `is_active`, `is_demo`) VALUES
(1, 'Kurikulum', 'Kurikulum Satuan Pendidikan', 'Kurikulum berstandar nasional yang dikembangkan bersama DU/DI.', 1, 1, 0),
(2, 'Kalender', 'Kalender Akademik', 'Kalender pendidikan dipublikasikan oleh sekolah. Admin dapat mengunggah dokumen pada menu Dokumen.', 2, 1, 0),
(3, 'Mata Pelajaran', 'Mata Pelajaran', 'Kelompok umum, dasar program keahlian, dan kompetensi keahlian.', 3, 1, 0),
(4, 'Pembelajaran', 'Pembelajaran', 'Pembelajaran teori dan praktik berbasis kompetensi.', 4, 1, 0),
(5, 'UKK', 'Uji Kompetensi Keahlian (UKK)', 'Uji kompetensi untuk kelas akhir bersama penguji industri.', 5, 1, 0),
(6, 'Sertifikasi LSP', 'Sertifikasi', 'Sertifikasi berlambang garuda kompetensi sesuai jurusan.', 6, 1, 0),
(7, 'Teaching Factory', 'Teaching Factory', 'Model pembelajaran berbasis produksi atau jasa di sekolah vokasi (SMK) dan politeknik yang menerapkan standar, suasana, dan tata kelola kerja industri sesungguhnya', 7, 1, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `documents`
--

CREATE TABLE `documents` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL,
  `category` varchar(60) NOT NULL DEFAULT 'Akademik',
  `file_path` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_demo` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `documents`
--

INSERT INTO `documents` (`id`, `title`, `category`, `file_path`, `is_active`, `is_demo`, `created_at`) VALUES
(1, 'Kalender Akademik', 'Akademik', NULL, 1, 1, '2026-10-17 16:23:24');

-- --------------------------------------------------------

--
-- Struktur dari tabel `extracurriculars`
--

CREATE TABLE `extracurriculars` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `coach` varchar(150) DEFAULT NULL,
  `schedule` varchar(150) DEFAULT NULL,
  `place` varchar(150) DEFAULT NULL,
  `achievements` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_demo` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `extracurriculars`
--

INSERT INTO `extracurriculars` (`id`, `name`, `logo`, `description`, `coach`, `schedule`, `place`, `achievements`, `image`, `is_active`, `is_demo`) VALUES
(1, 'Pramuka', NULL, 'Pramuka di SMK Infokom Kota Bogor merupakan salah satu wadah pembinaan nonformal untuk membentuk karakter peserta didik yang disiplin, tangguh, mandiri, dan berjiwa kepemimpinan.', 'Heny Handayani, S.Pd.', 'Sabtu 08.00', 'Sekolah', 'Prestasi utama Pramuka SMK Infokom Kota Bogor (Ambalan Arjuna Panduwinata & Dewi Srikandi) berfokus pada keaktifan partisipasi kegiatan daerah, pembentukan karakter, dan pencapaian tanda kecakapan anggotanya.', 'uploads/extracurriculars/2026/10/26e23ae18438340f6399279638999694.jpg', 1, 0),
(2, 'Paskibra', NULL, 'Ekstrakurikuler Paskibra di SMK Infokom Kota Bogor dinaungi oleh satuan khusus bernama Korps Reswara Abhinaya, yang lebih dikenal luas dengan singkatan KRESNA. Ekstrakurikuler ini didirikan pada 10 Oktober 2014 (awalnya bernama Fatra Jandala sebelum bertransformasi menjadi KRESNA pada tahun 2019) dan menjadi salah satu wadah utama pembentukan karakter kepemimpinan siswa di sekolah.', 'Muhammad Yanuar', 'Sabtu 08.00', 'Sekolah', 'Partisipasi Ajang LKBB: Aktif mengirimkan delegasi pasukan terbaiknya untuk bersaing dalam kompetisi ketangkasan baris-berbaris tingkat pelajar, baik di wilayah Kota maupun Kabupaten Bogor.', 'uploads/extracurriculars/2026/10/d99c642bf7834bac900cfe4f8a7093da.jpg', 1, 0),
(3, 'Palang Merah Indonesia', NULL, 'Ekstrakurikuler Palang Merah Remaja (PMR) di SMK Infokom Kota Bogor merupakan wadah bagi para siswa untuk mengembangkan jiwa kemanusiaan, kepedulian sosial, serta kesiapsiagaan dalam bidang kesehatan dan pertolongan pertama. Satuan PMR di sekolah ini dikenal dengan semboyan perjuangan/identitas ASPESIA (\"ASPESIA? Humanity!\").', 'M. Fauzan Arifin, S.IKom.,Gr.', 'Sabtu 09.00', 'Sekolah', 'Prestasi utama dari PMR SMK Infokom Kota Bogor (ASPESIA) berfokus pada kesiapsiagaan layanan kesehatan internal sekolah, kontribusi kemanusiaan, serta keaktifan dalam jejaring sukarelawan muda di tingkat Kota Bogor.', 'uploads/extracurriculars/2026/10/3d852fe36c41502e4ff190ce1975f14e.jpg', 1, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `facilities`
--

CREATE TABLE `facilities` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `category` varchar(60) NOT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_demo` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `facilities`
--

INSERT INTO `facilities` (`id`, `name`, `category`, `description`, `image`, `sort_order`, `is_active`, `is_demo`) VALUES
(1, 'Laboratorium TKJ', 'TKJ', 'Laboratorium praktik jaringan dan perakitan komputer.', 'uploads/facilities/2026/10/ede247f510432d798d776efd523b6ccb.jpg', 1, 1, 0),
(2, 'Laboratorium RPL', 'RPL', 'Laboratorium pemrograman dan pengembangan aplikasi.', 'uploads/facilities/2026/10/e95b7afdf71d258267f48edff41302fb.jpg', 2, 1, 0),
(3, 'Laboratorium DKV', 'DKV', 'Laboratorium desain dan produksi karya visual.', 'uploads/facilities/2026/10/9ecb0cdcad8b7d9969cd47939bd2afdb.jpg', 3, 1, 0),
(4, 'Studio PSPT', 'Studio PSPT', 'Studio produksi dan penyiaran program televisi.', 'uploads/facilities/2026/10/4a2d77f5e79d8be81cae10054d10644b.jpg', 4, 1, 0),
(5, 'Perpustakaan', 'Perpustakaan', 'Koleksi buku dan ruang baca siswa.', 'uploads/facilities/2026/10/2ad82dfd5c966835165a6f4e09ea4f15.jpg', 5, 1, 0),
(6, 'Ruang Kelas', 'Ruang kelas', 'Ruang kelas untuk kegiatan pembelajaran.', 'uploads/facilities/2026/10/feb8e33a90a3d3e436e860beed7fb9f2.jpg', 6, 1, 0),
(7, 'Gedung Kelas', 'Ruang kelas', 'Sarana Prasarana Ruang Pembelajaran', 'uploads/facilities/2026/10/b8ebfa5bf60d2530cac6903f0d203250.jpg', 7, 1, 0),
(8, 'Mushola', 'Tempat ibadah', 'Sarana ibadah warga sekolah.', 'uploads/facilities/2026/10/3a4f854360eb28df60d520e9a37c3700.jpg', 8, 1, 0),
(9, 'Kantin Sekolah', 'Kantin', 'Kantin sekolah adalah fasilitas penunjang di area sekolah yang berfungsi sebagai tempat penyediaan dan penjualan makanan serta minuman bagi siswa, guru, dan staf.', 'uploads/facilities/2026/10/56d86f22a054e643fab984c5337c70b7.jpg', 0, 1, 0),
(10, 'Teller Bank Sekolah', 'Teller', 'Ruang petugas administrasi keuangan yang bertanggung jawab untuk melayani dan mencatat seluruh transaksi pembayaran dari siswa atau orang tua di lingkungan sekolah.', 'uploads/facilities/2026/10/4180eeeb15eabb21fe317b64eeac0564.jpg', 0, 1, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `faq`
--

CREATE TABLE `faq` (
  `id` int(10) UNSIGNED NOT NULL,
  `scope` varchar(30) NOT NULL DEFAULT 'ppdb',
  `question` varchar(255) NOT NULL,
  `answer` text NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_demo` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `faq`
--

INSERT INTO `faq` (`id`, `scope`, `question`, `answer`, `sort_order`, `is_active`, `is_demo`) VALUES
(1, 'ppdb', 'Bagaimana cara mendaftar PPDB?', 'Isi formulir pendaftaran online pada halaman PPDB, lalu unduh bukti pendaftaran dalam bentuk PDF.', 1, 1, 0),
(2, 'ppdb', 'Jurusan apa saja yang tersedia?', 'TKJ, RPL, DKV, dan PSPT.', 2, 1, 0),
(3, 'ppdb', 'Apakah ada biaya pendaftaran?', 'Informasi biaya diatur admin pada pengaturan PPDB.', 3, 1, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `galleries`
--

CREATE TABLE `galleries` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(160) NOT NULL,
  `category` varchar(40) NOT NULL DEFAULT 'Kegiatan',
  `description` varchar(300) DEFAULT NULL,
  `cover` varchar(255) DEFAULT NULL,
  `event_date` date DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_demo` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `galleries`
--

INSERT INTO `galleries` (`id`, `title`, `category`, `description`, `cover`, `event_date`, `is_active`, `is_demo`) VALUES
(2, 'Suasana Belajar Di Lab SMK Infokom', 'Kegiatan', NULL, 'uploads/impor/galeri/img_20260928_055455_b1ddffd6.jpg', '2026-09-27', 1, 0),
(3, 'Upacara', 'Kegiatan', NULL, 'uploads/impor/galeri/img_20260920_143709_776959eb.jpg', '2026-09-20', 1, 0),
(4, 'Robotik', 'Kegiatan', NULL, 'uploads/impor/galeri/img_20260920_143654_3906eb7b.jpg', '2026-09-20', 1, 0),
(5, 'Kegiatan Pembelajaran', 'Kegiatan', NULL, 'uploads/impor/galeri/bljr.jpg', '2026-09-17', 1, 0),
(6, 'Gelar Karya Siswa Vol. 2', 'Kegiatan', NULL, 'uploads/impor/galeri/img_20260920_143906_e6f3f15c.jpg', '2026-06-10', 1, 0),
(7, 'Praktik Siswa', 'Kegiatan', NULL, 'uploads/impor/galeri/img_20260920_143401_5841073a.jpg', '2026-04-19', 1, 0),
(8, 'Gedung SMK INFOKOM', 'Fasilitas', NULL, 'uploads/impor/galeri/gedung-smk-infokom.jpg', '2025-12-16', 1, 0),
(9, 'Vlog Siswa Goes to Museum Jakarta', 'Kegiatan', NULL, 'uploads/impor/galeri/hqdefault.jpg', '2025-11-14', 1, 0),
(10, 'Gelar Karya Siswa Vol. 1', 'Kegiatan', NULL, 'uploads/impor/galeri/img_20260926_075701_5e1067cd.jpg', '2025-06-03', 1, 0),
(11, 'Galeri Kunjungan Industri', 'Kunjungan Industri', NULL, 'uploads/impor/kunjungan/kunjungan-uamy-depan-gedung.jpg', NULL, 1, 0),
(12, 'Magang', 'Magang', '', NULL, NULL, 1, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `gallery_items`
--

CREATE TABLE `gallery_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `gallery_id` int(10) UNSIGNED NOT NULL,
  `media_type` varchar(20) NOT NULL DEFAULT 'image',
  `image` varchar(255) DEFAULT NULL,
  `video_file` varchar(255) DEFAULT NULL,
  `media_url` varchar(500) DEFAULT NULL,
  `caption` varchar(200) DEFAULT NULL,
  `is_demo` tinyint(1) NOT NULL DEFAULT 0,
  `video_path` varchar(255) DEFAULT NULL,
  `video_url` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `gallery_items`
--

INSERT INTO `gallery_items` (`id`, `gallery_id`, `media_type`, `image`, `video_file`, `media_url`, `caption`, `is_demo`, `video_path`, `video_url`) VALUES
(1, 2, 'image', 'uploads/gallery_items/2026/10/4f295874856f5382e0df1b2839d9d108.jpg', NULL, NULL, 'Suasana Belajar Di Lab SMK Infokom', 0, NULL, NULL),
(2, 3, 'image', 'uploads/gallery_items/2026/10/5706934f9429df1459a1c59226eb8ff0.jpg', NULL, NULL, 'Upacara', 0, NULL, NULL),
(3, 4, 'image', 'uploads/gallery_items/2026/10/8607d498f8a015dbae0f763781577252.jpg', NULL, NULL, 'Robotik', 0, NULL, NULL),
(4, 5, 'image', 'uploads/impor/galeri/bljr.jpg', NULL, NULL, 'Kegiatan Pembelajaran', 0, NULL, NULL),
(5, 6, 'image', 'uploads/gallery_items/2026/10/338420910f9d342a17c3b6cf920d8c63.jpg', NULL, NULL, 'Gelar Karya Siswa Vol. 2', 0, NULL, NULL),
(6, 7, 'image', 'uploads/gallery_items/2026/10/e544414b06094298d9f1a8524110d316.jpg', NULL, NULL, 'Praktik Siswa', 0, NULL, NULL),
(7, 8, 'image', 'uploads/gallery_items/2026/10/4d552cc3982472fca43316bb57369ec9.jpg', NULL, NULL, 'Gedung SMK INFOKOM', 0, NULL, NULL),
(8, 9, 'video_url', 'uploads/gallery_items/2026/10/64cd7d237e4388831c138fad84879c90.jpg', NULL, NULL, 'Vlog Siswa Goes to Museum Jakarta', 0, NULL, 'https://youtu.be/f01bKvdiePE?si=c-4MEJ28SIujrXlA'),
(9, 10, 'image', 'uploads/gallery_items/2026/10/cdfe823bec43aa4d25a2d234b346e061.jpg', NULL, NULL, 'Gelar Karya Siswa Vol. 1', 0, NULL, NULL),
(10, 11, 'image', 'uploads/gallery_items/2026/10/420e163a3f7588c13c032ba8b519b97d.jpg', NULL, NULL, 'Foto bersama di Amikom Creative Economy Park', 0, NULL, NULL),
(11, 11, 'image', 'uploads/gallery_items/2026/10/ed2358a13a4cd510052d6ead037da1ed.jpg', NULL, NULL, 'Penyerahan cenderamata di Universitas Amikom Yogyakarta', 0, NULL, NULL),
(12, 11, 'image', 'uploads/gallery_items/2026/10/01025c423718d682b8f5b4b91c48a03f.jpg', NULL, NULL, 'Studio Visit Trans 7', 0, NULL, NULL),
(13, 11, 'image', 'uploads/gallery_items/2026/10/492836a647dff3c2124aea1704db6b0a.jpg', NULL, NULL, 'Kunjungan Industri Universitas Amikom Pt. Git Solution', 0, NULL, NULL),
(14, 12, 'video_url', 'uploads/gallery_items/2026/10/8d7d3c3aa8a4cf93a2a67e7ddef3d259.png', NULL, NULL, '', 0, NULL, 'https://www.instagram.com/reel/DZE77u4oNN_/?xtok=MTZzODZ4ZWR6d2trbA==');

-- --------------------------------------------------------

--
-- Struktur dari tabel `industry_visits`
--

CREATE TABLE `industry_visits` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL,
  `company` varchar(150) NOT NULL,
  `location` varchar(150) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `major_id` int(10) UNSIGNED DEFAULT NULL,
  `participants` varchar(150) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `learnings` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_demo` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `industry_visits`
--

INSERT INTO `industry_visits` (`id`, `title`, `company`, `location`, `visit_date`, `major_id`, `participants`, `description`, `learnings`, `image`, `is_active`, `is_demo`) VALUES
(1, 'Kunjungan Industri Universitas Amikom Yogyakarta & PT Git Solution', 'Universitas Amikom Yogyakarta', 'Yogyakarta', NULL, NULL, 'Siswa SMK Infokom didampingi guru pendamping', 'Siswa berkunjung ke Universitas Amikom Yogyakarta, Amikom Creative Economy Park, dan PT Git Solution, termasuk sesi foto bersama dan penyerahan cenderamata.', 'Penerapan ilmu jurusan di industri\r\nBerdialog dengan praktisi\r\nTeknologi & standar kerja terkini', 'uploads/industry_visits/2026/10/f9cd95a5d837067215631ae7fe1650a1.jpg', 1, 0),
(2, 'Studio Visit Trans 7', 'Trans 7', 'Studio Trans 7', NULL, 4, 'Siswa SMK Infokom didampingi guru pendamping', 'Siswa melihat langsung proses kerja dan produksi di studio Trans 7.', 'Alur kerja industri media\r\nKompetensi yang dicari industri\r\nWawasan karier', 'uploads/industry_visits/2026/10/77f4f62ae7738d50711d7c00bc736b45.jpg', 1, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `internships`
--

CREATE TABLE `internships` (
  `id` int(10) UNSIGNED NOT NULL,
  `kind` varchar(30) NOT NULL DEFAULT 'proses',
  `title` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_demo` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `internships`
--

INSERT INTO `internships` (`id`, `kind`, `title`, `description`, `sort_order`, `is_active`, `is_demo`) VALUES
(5, 'informasi', 'Program Magang untuk Siswa & Alumni', 'Dibekali pelatihan bahasa Jepang 1 tahun, langsung kerja di perusahaan ternama. 10+ alumni magang, 2 kota tujuan (Kagoshima & Tokyo).', 1, 1, 0),
(6, 'informasi', 'Misono Corp — Kagoshima, Jepang (Pengolahan Makanan)', 'Beasiswa Pendidikan Bahasa Jepang 1 Tahun + bekerja di Misono Corp bidang pengolahan makanan.\nBenefit: kesempatan karier & pengalaman internasional.\nDeadline pendaftaran: 2 September 2026.', 2, 1, 0),
(7, 'informasi', 'River Co — Tokyo, Jepang (Pengolahan Makanan)', 'Program magang untuk alumni SMK INFOKOM yang sukses bekerja di River Co, Kota Tokyo — bukti nyata alumni berkarier internasional.\nBenefit: kerja di River Co, pengalaman internasional, gaji sesuai standar Jepang.', 3, 1, 0),
(8, 'persyaratan', 'Kualifikasi Misono Corp', 'Perempuan\nMau belajar bahasa Jepang selama 1 tahun\nMemiliki ketertarikan di bidang pengolahan makanan', 4, 1, 0),
(9, 'persyaratan', 'Kualifikasi River Co', 'Alumni SMK INFOKOM\nLulus seleksi program\nSehat jasmani & rohani', 5, 1, 0),
(10, 'proses', '1. Pendaftaran', 'Kirim CV & dokumen ke BKK INFOKOM.', 6, 1, 0),
(11, 'proses', '2. Interview', 'Interview via Zoom bersama perusahaan Jepang.', 7, 1, 0),
(12, 'proses', '3. Pelatihan', 'Beasiswa bahasa Jepang selama 1 tahun.', 8, 1, 0),
(13, 'proses', '4. Berangkat', 'Terbang ke Jepang, kerja & dibayar.', 9, 1, 0),
(14, 'timeline', 'Deadline Misono Corp', 'Pendaftaran ditutup 2 September 2026.', 10, 1, 0),
(15, 'dokumentasi', 'Instagram Reels Pemberangkatan Magang', 'Tonton: https://www.instagram.com/reel/DZGAwIkSZYa/ dan https://www.instagram.com/reel/DZF46soytMP/\nGaleri foto: https://www.instagram.com/p/Dasw_tdEmFI/', 11, 1, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `internship_media`
--

CREATE TABLE `internship_media` (
  `id` int(10) UNSIGNED NOT NULL,
  `media_type` varchar(12) NOT NULL DEFAULT 'image',
  `image` varchar(255) DEFAULT NULL,
  `video_path` varchar(255) DEFAULT NULL,
  `video_url` varchar(500) DEFAULT NULL,
  `caption` varchar(200) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `internship_media`
--

INSERT INTO `internship_media` (`id`, `media_type`, `image`, `video_path`, `video_url`, `caption`, `sort_order`, `is_active`) VALUES
(1, 'video_url', 'uploads/internship_media/2026/10/2f4ad88efa8257973b97873b34ff6169.png', NULL, 'https://www.instagram.com/reel/DZGAwIkSZYa/', 'Reels pemberangkatan magang (1)', 1, 1),
(2, 'video_url', 'uploads/internship_media/2026/10/539a7550e9934147835e2addb85260ad.png', NULL, 'https://www.instagram.com/reel/DZF46soytMP/', 'Reels pemberangkatan magang (2)', 2, 1),
(3, 'video_url', 'uploads/internship_media/2026/10/3aa9f44623a2998baa493aa42a870bfe.png', NULL, 'https://www.instagram.com/p/Dasw_tdEmFI/', 'Galeri foto keberangkatan magang', 3, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `jobs`
--

CREATE TABLE `jobs` (
  `id` int(10) UNSIGNED NOT NULL,
  `company` varchar(150) NOT NULL,
  `position` varchar(150) NOT NULL,
  `location` varchar(150) DEFAULT NULL,
  `major_id` int(10) UNSIGNED DEFAULT NULL,
  `type` varchar(30) NOT NULL DEFAULT 'Full-time',
  `requirements` text DEFAULT NULL,
  `deadline` date DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_demo` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `jobs`
--

INSERT INTO `jobs` (`id`, `company`, `position`, `location`, `major_id`, `type`, `requirements`, `deadline`, `link`, `is_active`, `is_demo`) VALUES
(2, 'Danantara Indonesia / MUM / PNM', 'Account Officer', 'Kota & Kab. Bogor', NULL, 'Full-time', 'Mensosialisasikan produk mekar ke nasabah (mencari nasabah), melakukan uji kelayakan nasabah, melakukan persiapan pembiayaan, dan melakukan pertemuan kelompok mingguan.\nJurusan: Semua Jurusan', NULL, NULL, 1, 0),
(3, 'PT. Dwi Tunggal Jaya Abadi', 'Programmer / Operator Komputer (Laki-laki)', 'Bogor', NULL, 'Full-time', 'Programmer / Operator Komputer Operasional.\nJurusan: RPL/TKJ', NULL, NULL, 1, 0),
(4, 'PT Mitra Copierindo Mandiri (MCM)', 'Technician (7 Male)', 'Bogor', 1, 'Full-time', 'Teknisi perangkat kantor / printer.\nJurusan: TKJ', NULL, NULL, 1, 0),
(5, 'PT. Alura Warna Kreasi', 'Assistant Photographer', 'Cikarang', NULL, 'Full-time', 'Asisten fotografer untuk event & studio. Area operasional Cikarang. Lowongan ini tidak dipungut biaya apapun.\nJurusan: DKV/PSPT', NULL, NULL, 1, 0),
(6, 'Misono Corp (Kagoshima, Jepang)', 'Beasiswa Bahasa Jepang 1 Tahun + Kerja di Misono Corp', 'Kagoshima, Jepang', NULL, 'Magang', 'Rekrutmen beasiswa pendidikan bahasa Jepang selama 1 tahun di Kagoshima, Jepang, sambil bekerja di Misono Corp bidang pengolahan makanan. Belajar bahasa Jepang, raih masa depan cemerlang di Jepang.\nJurusan: Semua Jurusan', '2026-09-02', NULL, 1, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `login_attempts`
--

CREATE TABLE `login_attempts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ip` varchar(45) NOT NULL,
  `email` varchar(150) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `majors`
--

CREATE TABLE `majors` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(10) NOT NULL,
  `slug` varchar(20) NOT NULL,
  `name` varchar(120) NOT NULL,
  `short_desc` varchar(300) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `competencies` text DEFAULT NULL,
  `materials` text DEFAULT NULL,
  `practices` text DEFAULT NULL,
  `facilities_text` text DEFAULT NULL,
  `career` text DEFAULT NULL,
  `certifications` text DEFAULT NULL,
  `activities` text DEFAULT NULL,
  `cover` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `icon` varchar(40) NOT NULL DEFAULT 'cpu',
  `ppdb_quota` int(10) UNSIGNED NOT NULL DEFAULT 72,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_demo` tinyint(1) NOT NULL DEFAULT 0,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `majors`
--

INSERT INTO `majors` (`id`, `code`, `slug`, `name`, `short_desc`, `description`, `competencies`, `materials`, `practices`, `facilities_text`, `career`, `certifications`, `activities`, `cover`, `logo`, `icon`, `ppdb_quota`, `sort_order`, `is_active`, `is_demo`, `updated_at`) VALUES
(1, 'TKJ', 'tkj', 'Teknik Komputer dan Jaringan', 'Merakit komputer, membangun dan mengamankan jaringan LAN/WAN.', 'Kompetensi keahlian yang membekali siswa dengan keterampilan dukungan teknis, administrasi jaringan, dan keamanan jaringan.', 'IT Support Jaringan\r\nPerakitan dan Perbaikan Komputer\r\nAdministrator Jaringan Komputer LAN dan WAN\r\nAplikasi Teknik Komputer dan Jaringan interaktif\r\nKeamanan Jaringan Terpusat', 'Dasar-dasar komputer dan jaringan\r\nAdministrasi sistem server\r\nKonfigurasi router dan switch\r\nKeamanan jaringan', 'Perakitan komputer\r\nInstalasi dan konfigurasi jaringan\r\nTroubleshooting perangkat', 'Laboratorium komputer dan jaringan', 'Teknisi jaringan\r\nIT Support\r\nNetwork administrator\r\nTeknisi komputer', 'Sertifikasi kompetensi bidang jaringan (sesuai program sekolah)', 'Praktik lab, PKL industri', 'uploads/majors/2026/10/e05107fa2ccd4ab839bd393a91da6bd8.png', 'uploads/majors/2026/10/f6bd8170aa6a8660fc8c9858fd055be9.jpg', 'server', 72, 1, 1, 0, '2026-10-20 15:38:12'),
(2, 'RPL', 'rpl', 'Rekayasa Perangkat Lunak', 'Merancang dan membangun aplikasi desktop, mobile, web, dan enterprise.', 'Kompetensi keahlian untuk membangun perangkat lunak: analisis, perancangan sistem, pemrograman, dan pengujian.', 'Pemrograman Aplikasi Berbasis Desktop\r\nAnalisa dan Perancangan sistem\r\nArsitektur Aplikasi Desktop, Mobile, Web dan Enterprise', 'Algoritma dan pemrograman\r\nBasis data\r\nPemrograman web dan mobile\r\nRekayasa perangkat lunak', 'Proyek aplikasi\r\nPengembangan web dan mobile', 'Laboratorium komputer', 'Programmer\r\nWeb developer\r\nMobile developer\r\nSoftware tester', 'Sertifikasi kompetensi bidang pemrograman (sesuai program sekolah)', 'Proyek aplikasi, lomba kompetensi', 'uploads/majors/2026/10/bbd899618f684ac1ee05d833f91801e4.png', 'uploads/majors/2026/10/dc3421540ed64b69ccb1349dcf26256e.jpg', 'code', 72, 2, 1, 0, '2026-10-20 15:38:45'),
(3, 'DKV', 'dkv', 'Desain Komunikasi Visual', 'Menyampaikan pesan lewat desain, ilustrasi, fotografi, dan media digital.', 'Kompetensi keahlian di bidang desain visual: citra dan animasi digital, web interaktif, serta produksi audio-video. Deskripsi disesuaikan dengan nama jurusan DKV; admin dapat mengubahnya melalui dashboard.', 'Mengembangkan citra dan animasi digital\r\nMengembangkan laman (web) interaktif\r\nMerekam dan menyunting audio-video\r\nMengembangkan aplikasi visual interaktif', 'Desain grafis\r\nTipografi dan branding\r\nIlustrasi digital\r\nFotografi dan videografi', 'Praktik desain dan produksi karya\r\nPortofolio siswa', 'Laboratorium DKV', 'Desainer grafis\r\nIlustrator\r\nFotografer\r\nVideo editor', 'Sertifikasi desain (sesuai program sekolah)', 'Pameran karya, lomba desain', 'uploads/majors/2026/10/6009519ad23ee7cc84001a0819f4bb63.png', 'uploads/majors/2026/10/d2aacbccbc9d2ffa51299484b889aee6.jpg', 'palette', 72, 3, 1, 0, '2026-10-21 17:55:20'),
(4, 'PSPT', 'pspt', 'Produksi dan Siaran Program Televisi', 'Memproduksi program televisi: kamera, penyuntingan, penyutradaraan, dan penyiaran.', 'Kompetensi keahlian produksi dan penyiaran program pertelevisian.', 'Program Pertelevisian\r\nPenyutradaraan, Editor, Kameramen\r\nPenata Artistik dan Suara, Penulis Naskah dan Skenario\r\nAplikasi Teknik Produksi dan Penyiaran Program Pertelevisian interaktif', 'Dasar produksi program TV\r\nPenulisan naskah dan skenario\r\nTeknik kamera dan pencahayaan\r\nPenyuntingan gambar dan suara', 'Produksi program siaran\r\nPraktik studio', 'Studio PSPT', 'Kameramen\r\nEditor video\r\nPenulis skenario\r\nAsisten sutradara', 'Sertifikasi penyiaran (sesuai program sekolah)', 'Produksi program, liputan kegiatan', 'uploads/majors/2026/10/902ba6495a371ee4010b24aff057063c.png', 'uploads/majors/2026/10/45533c4d61fd0257f2cd3621c9585934.jpg', 'video', 72, 4, 1, 0, '2026-10-21 17:55:20');

-- --------------------------------------------------------

--
-- Struktur dari tabel `major_subjects`
--

CREATE TABLE `major_subjects` (
  `id` int(10) UNSIGNED NOT NULL,
  `major_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `grade` varchar(10) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_demo` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `media`
--

CREATE TABLE `media` (
  `id` int(10) UNSIGNED NOT NULL,
  `filename` varchar(200) NOT NULL,
  `path` varchar(255) NOT NULL,
  `mime` varchar(80) NOT NULL,
  `size` int(10) UNSIGNED NOT NULL,
  `folder` varchar(60) NOT NULL DEFAULT 'umum',
  `category` varchar(60) DEFAULT NULL,
  `alt` varchar(200) DEFAULT NULL,
  `uploaded_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `navigation`
--

CREATE TABLE `navigation` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(80) NOT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  `parent_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `icon` varchar(40) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `target` varchar(10) NOT NULL DEFAULT '_self',
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `navigation`
--

INSERT INTO `navigation` (`id`, `name`, `url`, `parent_id`, `icon`, `sort_order`, `target`, `is_active`) VALUES
(1, 'Home', '/', 0, NULL, 1, '_self', 1),
(2, 'Profil', '', 0, NULL, 2, '_self', 1),
(3, 'Akademik', '', 0, NULL, 3, '_self', 1),
(4, 'Kesiswaan', '', 0, NULL, 4, '_self', 1),
(5, 'Fasilitas', '/fasilitas', 0, NULL, 5, '_self', 1),
(6, 'Industri & Karier', '', 0, NULL, 6, '_self', 1),
(7, 'Informasi', '', 0, NULL, 7, '_self', 1),
(8, 'PPDB', '/ppdb', 0, NULL, 8, '_self', 1),
(9, 'Kontak', '/kontak', 0, NULL, 9, '_self', 1),
(10, 'Tentang Sekolah', '/profil/tentang-sekolah', 2, NULL, 1, '_self', 1),
(11, 'Sejarah', '/profil/sejarah', 2, NULL, 2, '_self', 1),
(12, 'Visi & Misi', '/profil/visi-misi', 2, NULL, 3, '_self', 1),
(13, 'Tujuan', '/profil/tujuan', 2, NULL, 4, '_self', 1),
(14, 'Struktur Organisasi', '/profil/struktur-organisasi', 2, NULL, 5, '_self', 1),
(15, 'Kepala Sekolah', '/profil/kepala-sekolah', 2, NULL, 6, '_self', 1),
(16, 'Guru & Staff', '/profil/guru-staff', 2, NULL, 7, '_self', 1),
(17, 'Akademik', '/akademik', 3, NULL, 1, '_self', 1),
(18, 'Kurikulum', '/akademik/kurikulum', 3, NULL, 2, '_self', 1),
(19, 'Jurusan', '/jurusan', 3, NULL, 3, '_self', 1),
(20, 'Program', '/program', 3, NULL, 4, '_self', 1),
(21, 'PKL', '/pkl', 3, NULL, 5, '_self', 1),
(22, 'Magang', '/magang', 3, NULL, 6, '_self', 1),
(23, 'Organisasi', '/organisasi', 4, NULL, 1, '_self', 1),
(24, 'Ekstrakurikuler', '/ekstrakurikuler', 4, NULL, 2, '_self', 1),
(25, 'Prestasi', '/prestasi', 4, NULL, 3, '_self', 1),
(26, 'Alumni', '/alumni', 4, NULL, 4, '_self', 1),
(27, 'BKK', '/bkk', 6, NULL, 1, '_self', 1),
(28, 'Lowongan', '/karier#lowongan', 6, NULL, 2, '_self', 1),
(29, 'Mitra', '/mitra', 6, NULL, 3, '_self', 1),
(30, 'Karier', '/karier', 6, NULL, 5, '_self', 1),
(31, 'Berita', '/berita', 7, NULL, 1, '_self', 1),
(32, 'Pengumuman', '/pengumuman', 7, NULL, 2, '_self', 1),
(33, 'Galeri', '/galeri', 7, NULL, 3, '_self', 1),
(34, 'Video', '/video', 7, NULL, 4, '_self', 1),
(35, 'Agenda', '/agenda', 7, NULL, 5, '_self', 1),
(36, 'Kunjungan Industri', '/kunjungan-industri', 6, NULL, 4, '_self', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `news`
--

CREATE TABLE `news` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(220) NOT NULL,
  `slug` varchar(240) NOT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `excerpt` varchar(320) DEFAULT NULL,
  `content` mediumtext DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_demo` tinyint(1) NOT NULL DEFAULT 0,
  `published_at` datetime NOT NULL DEFAULT current_timestamp(),
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `views` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `deleted_at` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `news`
--

INSERT INTO `news` (`id`, `title`, `slug`, `category_id`, `excerpt`, `content`, `image`, `is_featured`, `is_active`, `is_demo`, `published_at`, `author_id`, `views`, `deleted_at`, `updated_at`) VALUES
(2, 'Peringatan Maulid Nabi Muhammad SAW di SMK Infokom', 'peringatan-maulid-nabi-muhammad-saw-di-smk-infokom', 4, 'SMK Infokom menyelenggarakan kegiatan Peringatan Maulid Nabi Muhammad SAW pada Kamis, 27 Agustus, sebagai bentuk kecintaan dan pen…', '<p>SMK Infokom menyelenggarakan kegiatan Peringatan Maulid Nabi Muhammad SAW pada Kamis, 27 Agustus, sebagai bentuk kecintaan dan pen…</p>', 'uploads/news/2026/10/02342b71ac462e26d7e86c7505d0e6f5.png', 1, 1, 0, '2026-08-27 08:00:00', NULL, 0, NULL, '2026-10-21 13:28:06'),
(3, 'Lomba 17 Agustus SMK Infokom', 'lomba-17-agustus-smk-infokom', 5, 'SMK INFOKOM Kota Bogor Mengadakan Lomba 17 Agustus, Lomba ini Diikuti Oleh siswa & Guru', '<p>SMK INFOKOM Kota Bogor Mengadakan Lomba 17 Agustus, Lomba ini Diikuti Oleh siswa &amp; Guru</p><p>Tonton videonya: <a href=\"https://www.youtube.com/watch?v=wCC_ofY7y0w\">youtube.com/watch?v=wCC_ofY7y0w</a></p>', 'uploads/news/2026/10/a224258c301d117469f611d8cd63d650.jpg', 0, 1, 0, '2026-08-17 08:00:00', NULL, 0, NULL, '2026-10-21 13:28:23'),
(4, 'Upacara Tahun Ajaran Baru 2026/2027 SMK Infokom', 'upacara-tahun-ajaran-baru-2026-2027-smk-infokom', 6, 'SMK Informatika & Telekomunikasi (Infokom) Kota Bogor mengawali Tahun Ajaran 2026/2027 dengan pelaksanaan upacara bersama seluruh …', '<p>SMK Informatika &amp; Telekomunikasi (Infokom) Kota Bogor mengawali Tahun Ajaran 2026/2027 dengan pelaksanaan upacara bersama seluruh …</p>', 'uploads/news/2026/10/79cddd42d828c43103325e117a79ac21.jpg', 0, 1, 0, '2026-07-13 08:00:00', NULL, 0, NULL, '2026-10-21 13:29:10'),
(5, 'Siswa SMK Infokom Berhasil Diterima Program Magang ke Jepang', 'siswa-smk-infokom-berhasil-diterima-program-magang-ke-jepang', 7, 'Kabar membanggakan datang dari SMK Infokom. Sejumlah siswa berhasil diterima dalam program magang ke Jepang, sebagai bagian dari u…', '<p>Kabar membanggakan datang dari SMK Infokom. Sejumlah siswa berhasil diterima dalam program magang ke Jepang, sebagai bagian dari u…</p>', 'uploads/news/2026/10/059f53d91d5fd92a36db045316fe5da5.jpg', 1, 1, 0, '2026-07-12 08:00:00', NULL, 1, NULL, '2026-10-21 13:33:21'),
(6, 'Uji Kompetensi Keahlian (UKK) SMK Infokom', 'uji-kompetensi-keahlian-ukk-smk-infokom', 8, 'SMK Informatika & Telekomunikasi (Infokom) Kota Bogor melaksanakan kegiatan Uji Kompetensi Keahlian (UKK) sebagai bagian dari pros…', '<p>SMK Informatika &amp; Telekomunikasi (Infokom) Kota Bogor melaksanakan kegiatan Uji Kompetensi Keahlian (UKK) sebagai bagian dari pros…</p>', 'uploads/news/2026/10/8cacbd8f8cd34a160f31986d7d5e5524.jpg', 0, 1, 0, '2026-04-13 08:00:00', NULL, 0, NULL, '2026-10-21 13:29:31'),
(7, 'Peringatan Isra Mi\'raj Nabi Muhammad SAW', 'peringatan-isra-mi-raj-nabi-muhammad-saw', 9, 'SMK Informatika & Telekomunikasi (Infokom) Kota Bogor memperingati Isra Mi\'raj Nabi Muhammad SAW sebagai momentum untuk meningkatk…', '<p>SMK Informatika &amp; Telekomunikasi (Infokom) Kota Bogor memperingati Isra Mi\'raj Nabi Muhammad SAW sebagai momentum untuk meningkatk…</p>', 'uploads/news/2026/10/3bad32da8abd32905bc7bcbf086537b6.jpg', 0, 1, 0, '2026-01-16 08:00:00', NULL, 1, NULL, '2026-10-21 13:29:45');

-- --------------------------------------------------------

--
-- Struktur dari tabel `news_categories`
--

CREATE TABLE `news_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(80) NOT NULL,
  `slug` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `news_categories`
--

INSERT INTO `news_categories` (`id`, `name`, `slug`) VALUES
(1, 'Berita Sekolah', 'berita-sekolah'),
(2, 'Prestasi', 'prestasi'),
(3, 'PPDB', 'ppdb'),
(4, 'Maulid', 'maulid'),
(5, '17 Agustus', '17-agustus'),
(6, 'Langkah Baru', 'langkah-baru'),
(7, 'Karier', 'karier'),
(8, 'Uji Kompetensi', 'uji-kompetensi'),
(9, 'Meneladani Perjalanan Nabi', 'meneladani-perjalanan-nabi');

-- --------------------------------------------------------

--
-- Struktur dari tabel `organizations`
--

CREATE TABLE `organizations` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `type` varchar(40) NOT NULL DEFAULT 'OSIS',
  `description` text DEFAULT NULL,
  `leaders` text DEFAULT NULL,
  `work_programs` text DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_demo` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `organizations`
--

INSERT INTO `organizations` (`id`, `name`, `type`, `description`, `leaders`, `work_programs`, `logo`, `sort_order`, `is_active`, `is_demo`) VALUES
(1, 'OSIS SMK Infokom', 'OSIS', 'Organisasi Siswa Intra Sekolah.', 'Ketua OSIS Azhiim Adzikri', 'Class Meeting: Mengadakan turnamen olahraga antarkelas setelah ujian semester (PTS/PAS). Karena berlatar belakang sekolah IT, selain kompetisi fisik seperti futsal, biasanya diadakan juga turnamen E-Sports (seperti Mobile Legends).\r\nAspirasi & Advokasi Siswa: Wadah penampungan saran, kritik, serta koordinasi kegiatan ekstrakurikuler di lingkungan SMK Infokom Bogor.\r\nPeringatan Hari Besar Nasional/Keagamaan: Mengoordinasikan kegiatan keagamaan seperti Maulid Nabi Muhammad SAW serta upacara atau lomba hari nasional.', NULL, 1, 1, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pages`
--

CREATE TABLE `pages` (
  `id` int(10) UNSIGNED NOT NULL,
  `slug` varchar(120) NOT NULL,
  `title` varchar(200) NOT NULL,
  `excerpt` varchar(300) DEFAULT NULL,
  `content` mediumtext DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_demo` tinyint(1) NOT NULL DEFAULT 0,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pages`
--

INSERT INTO `pages` (`id`, `slug`, `title`, `excerpt`, `content`, `image`, `is_active`, `is_demo`, `updated_at`) VALUES
(1, 'tentang-sekolah', 'Tentang Sekolah', 'Profil singkat SMK Infokom Kota Bogor', '<p>Yayasan Telekomunikasi Nasional berlokasi di dua tempat: Jalan RE Abdullah No. 15 Gunung Batu, Bogor (lahan 800 m², SMP Infokom Bogor) dan Jalan Letjen Ibrahim Adjie No. 178 Sindangbarang, Bogor (lahan 2.600 m², SMK Infokom Bogor).</p><p>Sekolah memiliki empat kompetensi keahlian di bidang teknologi informasi, desain, dan penyiaran dengan orientasi pada kesiapan kerja dan kewirausahaan.</p>', 'uploads/pages/2026/10/5c4793c8408fb047c425fe320b6fcfaf.webp', 1, 0, '2026-10-18 12:55:40'),
(2, 'sejarah', 'Sejarah', 'Sekilas sejarah SMK Infokom Kota Bogor', '<h2>Sekilas Sejarah</h2><h3>2006 — Awal Berdiri</h3><p>SMK INFOKOM didirikan dengan fokus awal pada bidang teknologi informasi.</p><h3>2010 — Penambahan Jurusan</h3><p>Membuka jurusan baru untuk menjawab kebutuhan industri kreatif &amp; media.</p><h3>2018 — Akreditasi A</h3><p>Meraih akreditasi A, menandai standar kualitas pendidikan yang terus meningkat.</p><h3>2026 — Sekarang</h3><p>900+ siswa aktif, kerja sama industri dalam &amp; luar negeri terus berkembang.</p>', NULL, 1, 0, '2026-10-21 17:55:20'),
(3, 'visi-misi', 'Visi & Misi', 'Arah dan komitmen sekolah', '<h3>Visi</h3><p>Terwujudnya SMK Infokom Bogor sebagai SMK yang peduli dan berbudaya lingkungan hidup dengan tamatan yang kompeten dan mampu bersaing di tingkat Nasional maupun Internasional.</p><h3>Misi</h3><ol><li>Membangun mental dan sikap peserta didik yang beriman dan bertaqwa kepada Tuhan Yang Maha Esa.</li><li>Mengembangkan kurikulum dan menyelenggarakan pembelajaran berstandar Nasional.</li><li>Melalui kemitraan, keterbukaan dan pelayanan prima, SMK Infokom Kota Bogor: meningkatkan kualitas dan kuantitas tamatan yang siap kerja; menyiapkan wirausahawan yang handal dan mampu bersaing; menyiapkan tenaga terampil yang memiliki etos kerja dan kepribadian.</li></ol>', NULL, 1, 0, '2026-10-17 16:23:24'),
(4, 'tujuan', 'Tujuan', 'Tujuan pendidikan SMK Infokom', '<ol><li>Menyiapkan lulusan yang bertaqwa kepada Tuhan Yang Maha Esa dan siap memasuki lapangan kerja.</li><li>Menyiapkan lulusan yang peduli lingkungan, produktif, adaptif, dan kreatif.</li><li>Menyiapkan lulusan yang memahami sistem manajemen mutu agar mampu berkarier, berkompetisi, dan profesional.</li><li>Menyiapkan tenaga kerja tingkat menengah untuk mengisi kebutuhan dunia kerja berskala global.</li><li>Mempersiapkan peserta didik mampu bekerja mandiri serta mengisi lowongan di DU/DI sebagai tenaga tingkat menengah sesuai program keahlian.</li><li>Membekali peserta didik agar mampu mengembangkan sikap profesional dalam bidang keahliannya.</li><li>Membekali peserta didik dengan ilmu pengetahuan dan teknologi agar mampu berkembang secara mandiri maupun melalui jenjang pendidikan yang lebih tinggi.</li></ol>', NULL, 1, 0, '2026-10-17 16:23:24'),
(5, 'struktur-organisasi', 'Struktur Organisasi', 'Susunan organisasi sekolah', '<div class=\"org-chart\"><div class=\"org-node org-top\">Kepala Sekolah</div><div class=\"org-row\"><div class=\"org-node\">Wakil Kepala Sekolah </div><div class=\"org-node\">Kepala Program Keahlian </div><div class=\"org-node\">Kepala Tata Usaha </div></div><div class=\"org-row\"><div class=\"org-node\">Kurikulum</div><div class=\"org-node\">Kesiswaan</div><div class=\"org-node\">Hubungan Industri</div><div class=\"org-node\">Sarana Prasarana</div></div></div>', NULL, 1, 0, '2026-10-21 17:55:20'),
(6, 'kepala-sekolah', 'Kepala Sekolah', 'Sambutan Kepala Sekolah', '<p>Lihat sambutan pada bagian atas halaman. Teks sambutan dikelola melalui Pengaturan Situs.</p>', NULL, 1, 0, '2026-10-17 16:23:24'),
(7, 'akademik', 'Akademik', 'Informasi akademik', '<p>Pembelajaran di SMK Infokom memadukan teori dan praktik berbasis kompetensi. Rincian kurikulum, kalender pendidikan, UKK, sertifikasi, dan teaching factory tersedia pada halaman Kurikulum.</p>', NULL, 1, 0, '2026-10-17 16:23:24'),
(8, 'kurikulum', 'Kurikulum', 'Kurikulum, kalender akademik, dan dokumen', '<p>Kurikulum SMK Infokom dikembangkan berstandar nasional dan bersama dunia usaha dan industri.</p>', 'uploads/pages/2026/10/ae777a51ee8089820ddd0c881262de93.jpg', 1, 0, '2026-10-22 00:16:27'),
(9, 'pkl', 'Praktik Kerja Lapangan (PKL)', 'Program wajib kelas XII: kerja sungguhan di perusahaan & instansi mitra', '<p>Praktik Kerja Lapangan (PKL) adalah program pembelajaran wajib bagi <strong>siswa kelas XII SMK</strong> yang diselenggarakan sekolah bekerja sama dengan perusahaan atau instansi mitra. Selama periode tertentu, siswa langsung bekerja di tempat kerja sungguhan untuk mempraktikkan ilmu dan keterampilan sesuai program keahlian masing-masing (TKJ, RPL, DKV, maupun PSPT).</p><p>Selama PKL, siswa didampingi dua pembimbing sekaligus: guru pembimbing dari sekolah dan pembimbing lapangan dari perusahaan/instansi mitra. Nilai dan pengalaman selama PKL menjadi bagian dari penilaian kelulusan siswa.</p><h3>Kenapa PKL penting?</h3><ul><li>Merasakan langsung budaya &amp; disiplin kerja di industri</li><li>Mempraktikkan ilmu jurusan di pekerjaan nyata</li><li>Membangun portofolio &amp; pengalaman kerja sejak SMK</li><li>Membuka peluang direkrut oleh perusahaan tempat PKL</li><li>Melatih tanggung jawab &amp; kesiapan mental kerja</li></ul><h3>Jadwal pelaksanaan PKL</h3><p>Mulai <strong>9 November 2026</strong> sampai <strong>10 April 2027</strong> (± 5 bulan / 22 minggu).</p><h3>Kuota yang sedang dibuka (6 mitra)</h3><ul><li><strong>Bank Syariah Indonesia (BSI)</strong> — Staf Administrasi, Layanan Nasabah (TKJ, RPL)</li><li><strong>Bank BJB Syariah</strong> — Staf Operasional, IT Support (TKJ, RPL)</li><li><strong>Bank Mandiri</strong> — Staf Administrasi, Layanan Nasabah (TKJ, RPL)</li><li><strong>IPB Press</strong> — Desain Layout Buku, Ilustrasi &amp; Sampul (DKV)</li><li><strong>MSV Studio</strong> — Kru Produksi, Editor Video (PSPT, DKV)</li><li><strong>Mega Motor</strong> — Staf Administrasi, Konten &amp; Digital Marketing (DKV, RPL)</li></ul><p>Tanya kuota langsung ke panitia BKK SMK INFOKOM via WhatsApp (0878-7307-1400).</p>', NULL, 1, 0, '2026-10-21 09:16:24'),
(10, 'magang', 'Magang', 'Karier mendunia dimulai dari sini: magang ke Jepang untuk siswa & alumni', '<p>Program magang untuk siswa &amp; alumni SMK INFOKOM. Peserta dibekali <strong>pelatihan bahasa Jepang selama 1 tahun</strong>, lalu langsung bekerja di perusahaan ternama di Jepang.</p><ul><li>10+ alumni magang</li><li>2 kota tujuan: Kagoshima (Misono Corp) dan Tokyo (River Co)</li><li>1 tahun pelatihan bahasa</li></ul><p>Peluang magang untuk siswa &amp; alumni, pengalaman kerja nyata di industri, serta disiplin, etos kerja, dan skill siap pakai. Tanya program terbaru ke sekolah.</p><p>Hubungi BKK INFOKOM untuk info lengkap, persyaratan, dan jadwal seleksi: WhatsApp 0856-1999-553.</p>', NULL, 1, 0, '2026-10-21 09:16:24'),
(11, 'bkk', 'BKK (Bursa Kerja Khusus)', 'Jembatan ke dunia kerja, bukan sekadar info loker', '<p>Bursa Kerja Khusus (BKK) adalah unit resmi sekolah yang menghubungkan alumni SMK INFOKOM — dan masyarakat umum — dengan perusahaan mitra yang sedang membuka lowongan. Setiap informasi sudah dicek sekolah dulu sebelum ditayangkan.</p><p>Follow Instagram <strong>@bkkinfokom</strong> untuk update lowongan terbaru.</p>', 'uploads/pages/2026/10/52c41ffb29b5660c8fe76026c38bef15.jpg', 1, 0, '2026-10-21 13:50:08'),
(12, 'karier', 'Karier', 'Informasi karier lulusan', '<p>Informasi karier, lowongan, dan jalur karier setiap jurusan untuk membantu lulusan merencanakan masa depan.</p>', NULL, 1, 0, '2026-10-17 16:23:24'),
(13, 'tracer-alumni', 'Tracer Alumni', 'Pelacakan alumni', '<p>Tracer alumni membantu sekolah memantau keterserapan lulusan di dunia kerja, perguruan tinggi, dan wirausaha. Alumni dapat memperbarui data melalui Humas sekolah.</p>', NULL, 1, 0, '2026-10-17 16:23:24'),
(14, 'kunjungan-industri', 'Kunjungan Industri', 'Belajar langsung di lapangan: lihat dunia kerja dari dalam', '<p>Kunjungan Industri adalah kegiatan belajar di luar kelas, ketika siswa berkunjung ke perusahaan, instansi, atau lembaga mitra untuk mengamati langsung bagaimana ilmu dari jurusan mereka dipakai di dunia kerja.</p><p>Berbeda dengan PKL yang berlangsung berbulan-bulan, kunjungan industri berdurasi singkat dan bersifat pengenalan. Siswa melihat ruang kerja, berdialog dengan praktisi, dan memahami kompetensi yang dicari industri, sehingga pembelajaran di sekolah menjadi lebih relevan dan terarah.</p><h3>Apa yang didapat siswa?</h3><ul><li>Melihat langsung penerapan ilmu jurusan di industri</li><li>Berdialog dengan praktisi dan profesional</li><li>Mengenal teknologi, alat, dan standar kerja terkini</li><li>Memetakan keterampilan yang perlu diasah</li><li>Membuka wawasan untuk PKL dan pilihan karier</li></ul>', NULL, 1, 0, '2026-10-21 09:16:24');

-- --------------------------------------------------------

--
-- Struktur dari tabel `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `slug` varchar(60) NOT NULL,
  `name` varchar(120) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `permissions`
--

INSERT INTO `permissions` (`id`, `slug`, `name`) VALUES
(1, 'content.manage', 'Kelola konten (guru, jurusan, program, fasilitas, prestasi, dll.)'),
(2, 'news.manage', 'Kelola berita, pengumuman, agenda'),
(3, 'gallery.manage', 'Kelola galeri & video'),
(4, 'media.manage', 'Kelola media library'),
(5, 'ppdb.manage', 'Kelola PPDB'),
(6, 'messages.manage', 'Kelola pesan kontak'),
(7, 'settings.manage', 'Kelola pengaturan situs, navigasi, homepage, SEO'),
(8, 'users.manage', 'Kelola pengguna & role'),
(9, 'logs.view', 'Lihat activity log');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pkl`
--

CREATE TABLE `pkl` (
  `id` int(10) UNSIGNED NOT NULL,
  `step_order` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `icon` varchar(40) NOT NULL DEFAULT 'check',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_demo` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pkl`
--

INSERT INTO `pkl` (`id`, `step_order`, `title`, `description`, `icon`, `is_active`, `is_demo`) VALUES
(8, 1, 'Pembekalan siswa', 'Etika kerja, tata tertib, dan target kompetensi sebelum terjun ke industri.', 'clipboard', 1, 0),
(9, 2, 'Penempatan mitra', 'Disalurkan ke perusahaan/instansi mitra sesuai program keahlian & kuota.', 'handshake', 1, 0),
(10, 3, 'Pelaksanaan & bimbingan', 'Bekerja di lapangan, dibimbing guru sekolah & pembimbing industri secara berkala.', 'briefcase', 1, 0),
(11, 4, 'Laporan akhir', 'Menyusun laporan kegiatan sebagai bukti tertulis kompetensi di lapangan.', 'book', 1, 0),
(12, 5, 'Penilaian & sertifikat', 'Dinilai mitra & sekolah, lalu menerima sertifikat PKL sebagai bekal kerja.', 'award', 1, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `ppdb_documents`
--

CREATE TABLE `ppdb_documents` (
  `id` int(10) UNSIGNED NOT NULL,
  `registrant_id` int(10) UNSIGNED NOT NULL,
  `doc_type` varchar(40) NOT NULL,
  `file_path` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `ppdb_documents`
--

INSERT INTO `ppdb_documents` (`id`, `registrant_id`, `doc_type`, `file_path`) VALUES
(1, 1, 'berkas', 'uploads/ppdb/dokumen/2026/10/4438b03d7180c272931b2be20e345678.jpg'),
(2, 2, 'berkas', 'uploads/ppdb/dokumen/2026/10/d70e5dfccf1a06c98d16af44068631ec.jpg');

-- --------------------------------------------------------

--
-- Struktur dari tabel `ppdb_periods`
--

CREATE TABLE `ppdb_periods` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `description` varchar(300) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_demo` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `ppdb_periods`
--

INSERT INTO `ppdb_periods` (`id`, `name`, `start_date`, `end_date`, `description`, `is_active`, `is_demo`) VALUES
(1, 'Gelombang 1', '2025-12-15', '2026-04-30', 'Free 1 Unit Laptop Chromebook', 1, 0),
(2, 'Gelombang 2', '2026-10-22', '2026-12-31', 'Free SPP 3 Bulan', 1, 0),
(3, 'Gelombang 3', '2027-01-10', '2027-08-20', 'Free Seragam Lengkap', 1, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `ppdb_registrants`
--

CREATE TABLE `ppdb_registrants` (
  `id` int(10) UNSIGNED NOT NULL,
  `reg_number` varchar(30) NOT NULL,
  `verify_token` char(32) NOT NULL,
  `period_id` int(10) UNSIGNED NOT NULL,
  `major_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `nisn` char(10) NOT NULL,
  `school_origin` varchar(150) NOT NULL,
  `birth_place` varchar(100) NOT NULL,
  `birth_date` date NOT NULL,
  `gender` char(1) NOT NULL,
  `address` varchar(300) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `father_name` varchar(150) NOT NULL,
  `mother_name` varchar(150) NOT NULL,
  `parent_job` varchar(100) NOT NULL,
  `parent_income` varchar(60) NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'baru',
  `note` varchar(300) DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `ppdb_registrants`
--

INSERT INTO `ppdb_registrants` (`id`, `reg_number`, `verify_token`, `period_id`, `major_id`, `name`, `nisn`, `school_origin`, `birth_place`, `birth_date`, `gender`, `address`, `phone`, `email`, `father_name`, `mother_name`, `parent_job`, `parent_income`, `photo`, `status`, `note`, `ip`, `deleted_at`, `created_at`) VALUES
(1, 'PPDB-2026-0001', 'cf1f61efdc6ebcf3090486583ad6291e', 1, 2, 'Fazriansyah Azis', '0093142245', 'SMPN 7', 'Rumah Sakit', '2010-12-23', 'L', 'Bogor Jawa Barat', '0896376724353', 'fazriansyahaz@gmail.com', 'Sobri Azis', 'Maemunah', 'Pekerja Swasta', 'Rp 1.000.000 – 3.000.000', 'uploads/ppdb/foto/2026/10/accfdfc4d3fb9ad77b8592eb8d1c263b.jpg', 'baru', NULL, '::1', NULL, '2026-10-20 18:17:01'),
(2, 'PPDB-2026-0002', 'f928246045c0db2a76d51f38421d069b', 1, 1, 'Fahri Audero', '0089456377', 'SMPN 6', 'Bogor Kota', '2011-09-13', 'L', 'Baranangsiang Kota Bogor', '0867324567823', 'fhriansz322@gmail.com', 'Steven Audero', 'Shopia Jane', 'Karyawan Swasta', 'Rp 3.000.000 – 5.000.000', 'uploads/ppdb/foto/2026/10/f5c57590e63253aaf5beab45a78968f7.jpg', 'baru', NULL, '::1', NULL, '2026-10-21 11:13:34');

-- --------------------------------------------------------

--
-- Struktur dari tabel `ppdb_settings`
--

CREATE TABLE `ppdb_settings` (
  `id` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `is_open` tinyint(1) NOT NULL DEFAULT 1,
  `info` text DEFAULT NULL,
  `requirements` text DEFAULT NULL,
  `fees` text DEFAULT NULL,
  `flow` text DEFAULT NULL,
  `closed_message` varchar(300) DEFAULT NULL,
  `auto_accept` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `ppdb_settings`
--

INSERT INTO `ppdb_settings` (`id`, `is_open`, `info`, `requirements`, `fees`, `flow`, `closed_message`, `auto_accept`) VALUES
(1, 1, 'Penerimaan peserta didik baru SMK Infokom Kota Bogor untuk jurusan TKJ, RPL, DKV, dan PSPT.', 'Fotokopi ijazah/SKL\r\nFotokopi Kartu Keluarga\r\nPas foto terbaru\r\nNISN', 'Informasi biaya akan diumumkan oleh panitia.', 'Isi formulir\r\nUnggah foto\r\nUnduh bukti pendaftaran\r\nVerifikasi berkas di sekolah', 'Pendaftaran PPDB sedang ditutup.', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `programs`
--

CREATE TABLE `programs` (
  `id` int(10) UNSIGNED NOT NULL,
  `slug` varchar(120) NOT NULL,
  `title` varchar(150) NOT NULL,
  `summary` varchar(300) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `icon` varchar(40) NOT NULL DEFAULT 'layers',
  `image` varchar(255) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_demo` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `programs`
--

INSERT INTO `programs` (`id`, `slug`, `title`, `summary`, `description`, `icon`, `image`, `sort_order`, `is_active`, `is_demo`) VALUES
(1, 'pkl', 'PKL', 'Praktik Kerja Lapangan di industri mitra.', 'Siswa menjalani praktik kerja di dunia usaha dan industri sesuai kompetensi keahlian.', 'briefcase', NULL, 1, 1, 0),
(2, 'magang', 'Magang', 'Pengalaman kerja lebih panjang bersama mitra.', 'Program magang untuk memperdalam keterampilan kerja.', 'building', NULL, 2, 1, 0),
(3, 'teaching-factory', 'Teaching Factory', 'Pembelajaran berbasis produksi nyata.', 'Siswa mengerjakan proyek/produk nyata dengan standar industri.', 'factory', NULL, 3, 1, 1),
(4, 'sertifikasi', 'Sertifikasi', 'Sertifikasi kompetensi siswa.', 'Uji kompetensi dan sertifikasi sesuai jurusan.', 'award', NULL, 4, 1, 1),
(5, 'industry-class', 'Industry Class', 'Kelas bersama industri.', 'Pembelajaran khusus bersama mitra industri.', 'layers', NULL, 5, 1, 1),
(6, 'guest-teacher', 'Guest Teacher', 'Praktisi industri mengajar di kelas.', 'Praktisi hadir berbagi pengalaman.', 'user-check', NULL, 6, 1, 1),
(7, 'entrepreneurship', 'Entrepreneurship', 'Menyiapkan wirausahawan muda.', 'Sesuai misi sekolah, siswa dibekali kemampuan berwirausaha.', 'trending-up', NULL, 7, 1, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `rate_limits`
--

CREATE TABLE `rate_limits` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `bucket` varchar(40) NOT NULL,
  `ip` varchar(45) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `rate_limits`
--

INSERT INTO `rate_limits` (`id`, `bucket`, `ip`, `created_at`) VALUES
(1, 'chat', '::1', '2026-10-20 15:36:32'),
(2, 'chat', '::1', '2026-10-20 15:36:43'),
(3, 'chat', '::1', '2026-10-20 16:01:32'),
(5, 'chat', '::1', '2026-10-21 02:46:48'),
(6, 'chat', '::1', '2026-10-21 02:47:02'),
(7, 'chat', '::1', '2026-10-21 03:15:46'),
(8, 'chat', '::1', '2026-10-21 03:34:15'),
(9, 'chat', '::1', '2026-10-21 03:34:35'),
(10, 'chat', '::1', '2026-10-21 03:35:32'),
(11, 'chat', '::1', '2026-10-21 09:54:34'),
(12, 'chat', '::1', '2026-10-21 09:54:48'),
(13, 'chat', '::1', '2026-10-21 09:55:07'),
(15, 'chat', '::1', '2026-10-21 16:12:11'),
(16, 'chat', '::1', '2026-10-21 16:12:38'),
(17, 'chat', '::1', '2026-10-21 16:13:11'),
(18, 'chat', '::1', '2026-10-21 16:13:47'),
(19, 'chat', '::1', '2026-10-22 06:57:02'),
(4, 'ppdb', '::1', '2026-10-20 18:17:01'),
(14, 'ppdb', '::1', '2026-10-21 11:13:34');

-- --------------------------------------------------------

--
-- Struktur dari tabel `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `slug` varchar(40) NOT NULL,
  `name` varchar(80) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `roles`
--

INSERT INTO `roles` (`id`, `slug`, `name`, `created_at`) VALUES
(1, 'super_admin', 'Super Admin', '2026-10-17 16:23:24'),
(2, 'admin', 'Admin', '2026-10-17 16:23:24'),
(3, 'editor', 'Editor', '2026-10-17 16:23:24');

-- --------------------------------------------------------

--
-- Struktur dari tabel `role_permissions`
--

CREATE TABLE `role_permissions` (
  `role_id` int(10) UNSIGNED NOT NULL,
  `permission_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `role_permissions`
--

INSERT INTO `role_permissions` (`role_id`, `permission_id`) VALUES
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(2, 6),
(2, 7),
(2, 9),
(3, 1),
(3, 2),
(3, 3),
(3, 4);

-- --------------------------------------------------------

--
-- Struktur dari tabel `school_statistics`
--

CREATE TABLE `school_statistics` (
  `id` int(10) UNSIGNED NOT NULL,
  `label` varchar(60) NOT NULL,
  `value` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `suffix` varchar(10) NOT NULL DEFAULT '',
  `icon` varchar(40) NOT NULL DEFAULT 'users',
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_demo` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `school_statistics`
--

INSERT INTO `school_statistics` (`id`, `label`, `value`, `suffix`, `icon`, `sort_order`, `is_active`, `is_demo`) VALUES
(1, 'Siswa', 900, '+', 'users', 1, 1, 0),
(2, 'Guru', 32, '', 'user-check', 2, 1, 0),
(3, 'Staff', 12, '', 'briefcase', 3, 1, 0),
(4, 'Jurusan', 4, '', 'layers', 4, 0, 0),
(5, 'Prestasi', 5, '', 'trophy', 4, 1, 0),
(6, 'Mitra', 30, '+', 'handshake', 5, 1, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `sections`
--

CREATE TABLE `sections` (
  `id` int(10) UNSIGNED NOT NULL,
  `key` varchar(40) NOT NULL,
  `label` varchar(80) NOT NULL,
  `badge` varchar(120) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `subtitle` varchar(255) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `button_text` varchar(80) DEFAULT NULL,
  `button_url` varchar(255) DEFAULT NULL,
  `button2_text` varchar(80) DEFAULT NULL,
  `button2_url` varchar(255) DEFAULT NULL,
  `is_enabled` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `sections`
--

INSERT INTO `sections` (`id`, `key`, `label`, `badge`, `title`, `subtitle`, `content`, `image`, `button_text`, `button_url`, `button2_text`, `button2_url`, `is_enabled`, `sort_order`) VALUES
(1, 'hero', 'Hero', 'Penerimaan Peserta Didik Baru', 'Siap Kerja, Siap Kuliah, Siap Berwirausaha', 'SMK Infokom Kota Bogor', 'Empat kompetensi keahlian — TKJ, RPL, DKV, dan PSPT — dengan praktik industri, PKL, dan jalur karier melalui BKK.', NULL, 'Daftar PPDB', '/ppdb', 'Lihat Jurusan', '/jurusan', 1, 1),
(2, 'statistics', 'Statistik', NULL, 'SMK Infokom dalam Angka', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 2),
(3, 'about', 'Tentang Sekolah', 'Tentang Kami', 'SMK Informatika & Telekomunikasi Kota Bogor', 'Di bawah naungan Yayasan Telekomunikasi Nasional', 'SMK Infokom Bogor menempati lahan seluas 2.600 m² di Jalan Letjen Ibrahim Adjie No. 178, Sindangbarang, Bogor Barat. Sekolah berfokus pada kompetensi teknologi informasi, desain, dan penyiaran dengan kurikulum berstandar nasional dan kemitraan industri.', 'uploads/sections/2026/10/e3996a807ed01474b864360729094df5.jpg', 'Selengkapnya', '/profil/tentang-sekolah', NULL, NULL, 1, 3),
(4, 'principal', 'Sambutan Kepala Sekolah', 'Sambutan', NULL, NULL, NULL, NULL, 'Baca Sambutan', '/profil/kepala-sekolah', NULL, NULL, 1, 4),
(5, 'majors', 'Jurusan', 'Kompetensi Keahlian', 'Empat Jurusan, Satu Arah: Dunia Kerja', 'Pilih jalur yang sesuai minat dan bakat', NULL, NULL, 'Semua Jurusan', '/jurusan', NULL, NULL, 1, 5),
(6, 'programs', 'Program', 'Program Sekolah', 'Program Penguatan Kompetensi', NULL, NULL, NULL, 'Semua Program', '/program', NULL, NULL, 1, 6),
(7, 'academic', 'Akademik', 'Akademik', 'Kurikulum Berstandar Nasional', 'Pembelajaran teori dan praktik yang seimbang', 'Kurikulum dikembangkan bersama dunia usaha dan dunia industri agar lulusan memiliki kompetensi yang relevan.', 'uploads/sections/2026/10/a8ea481c05a06f82f11107e892fb0042.jpg', 'Lihat Kurikulum', '/akademik/kurikulum', NULL, NULL, 1, 7),
(8, 'pkl', 'PKL', 'Praktik Kerja Lapangan', 'Belajar Langsung di Industri', NULL, 'Siswa menjalani PKL di mitra industri dengan pendampingan pembimbing sekolah dan industri.', NULL, 'Alur PKL', '/pkl', NULL, NULL, 1, 8),
(9, 'magang', 'Magang', 'Magang', 'Magang untuk Pengalaman Kerja Nyata', NULL, 'Program magang melengkapi PKL dengan pengalaman kerja yang lebih panjang dan mendalam.', 'uploads/sections/2026/10/aca811e641acf5e7706323c0f353eb9f.png', 'Info Magang', '/magang', NULL, NULL, 1, 9),
(10, 'facilities', 'Fasilitas', 'Fasilitas', 'Fasilitas Belajar', NULL, NULL, NULL, 'Semua Fasilitas', '/fasilitas', NULL, NULL, 1, 10),
(11, 'achievements', 'Prestasi', 'Prestasi', 'Prestasi Siswa', NULL, NULL, NULL, 'Semua Prestasi', '/prestasi', NULL, NULL, 1, 11),
(12, 'partners', 'Mitra', 'Industri & Karier', 'Mitra Industri', NULL, NULL, NULL, 'Semua Mitra', '/mitra', NULL, NULL, 1, 12),
(13, 'news', 'Berita', 'Informasi', 'Berita Terbaru', NULL, NULL, NULL, 'Semua Berita', '/berita', NULL, NULL, 1, 13),
(14, 'gallery', 'Galeri', 'Galeri', 'Galeri Kegiatan', NULL, NULL, NULL, 'Buka Galeri', '/galeri', NULL, NULL, 1, 14),
(15, 'video', 'Video', 'Video', 'Video Sekolah', NULL, NULL, NULL, 'Semua Video', '/video', NULL, NULL, 1, 15),
(16, 'cta', 'CTA PPDB', 'PPDB', 'Bergabung bersama SMK Infokom', NULL, 'Cek jadwal, persyaratan, dan daftar secara online.', NULL, 'Daftar Sekarang', '/ppdb', 'Hubungi Kami', '/kontak', 1, 16),
(17, 'contact', 'Kontak', 'Kontak', 'Hubungi Kami', NULL, NULL, NULL, 'Halaman Kontak', '/kontak', NULL, NULL, 1, 17);

-- --------------------------------------------------------

--
-- Struktur dari tabel `seo_metadata`
--

CREATE TABLE `seo_metadata` (
  `id` int(10) UNSIGNED NOT NULL,
  `page_key` varchar(120) NOT NULL,
  `title` varchar(200) DEFAULT NULL,
  `description` varchar(300) DEFAULT NULL,
  `og_image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `seo_metadata`
--

INSERT INTO `seo_metadata` (`id`, `page_key`, `title`, `description`, `og_image`) VALUES
(1, 'home', 'SMK Infokom Kota Bogor — TKJ, RPL, DKV, PSPT', 'Website profil resmi SMK Infokom Kota Bogor.', NULL),
(2, 'ppdb', 'PPDB SMK Infokom Kota Bogor', 'Informasi dan pendaftaran online PPDB SMK Infokom Kota Bogor.', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `site_settings`
--

CREATE TABLE `site_settings` (
  `key` varchar(60) NOT NULL,
  `value` text DEFAULT NULL,
  `group` varchar(30) NOT NULL DEFAULT 'general',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `site_settings`
--

INSERT INTO `site_settings` (`key`, `value`, `group`, `updated_at`) VALUES
('address', 'Jl. Letjen Ibrahim Adjie No.178, RT.03/RW.08, Sindangbarang, Kecamatan Bogor Barat, Kota Bogor, Jawa Barat 16117', 'contact', '2026-10-17 16:23:24'),
('chatbot_enabled', '1', 'general', '2026-10-21 03:17:12'),
('chatbot_greeting', '', 'general', '2026-10-21 03:17:12'),
('chatbot_knowledge', 'Apakah ada beasiswa? | Ada beasiswa prestasi dan KIP. Info lengkap hubungi Humas 0878-7307-1400.\r\nApakah siswa boleh membawa HP? | Boleh, dengan aturan: dipakai saat jam istirahat dan keperluan belajar.\r\nGelombang 1 dapat bonus apa? | Mendapatkan 1 unit Laptop Chromebook gratis\r\nGelombang 2 dapat bonus apa? | Mendapatkan SPP 3 Bulan secara gratis\r\nGelombang 3 dapat bonus apa? | Mendapatkan seragam sekolah lengkap secara gratis', 'general', '2026-10-21 14:11:09'),
('chatbot_name', '', 'general', '2026-10-21 03:17:12'),
('color_accent', '#f5b800', 'theme', '2026-10-17 16:33:02'),
('color_navy', '#0a2a5e', 'theme', '2026-10-17 16:33:02'),
('color_primary', '#0b4da2', 'theme', '2026-10-17 16:33:02'),
('email', 'smk.infokom@gmail.com', 'contact', '2026-10-17 16:23:24'),
('facebook', 'https://m.facebook.com/SMK-Infokom-105202311143756/', 'social', '2026-10-17 16:23:24'),
('favicon', 'uploads/settings/2026/10/476f3b2cb5f7f07b17e9b696cc073fee.png', 'general', '2026-10-17 16:33:02'),
('footer_text', 'Sekolah menengah kejuruan di Kota Bogor yang menyiapkan lulusan kompeten, siap kerja, dan berwirausaha.', 'general', '2026-10-17 16:23:24'),
('hours', 'Senin - Jumat : 07:00 - 17:00', 'contact', '2026-10-17 16:23:24'),
('instagram', 'https://instagram.com/smk.infokom_official', 'social', '2026-10-17 16:23:24'),
('logo', 'uploads/settings/2026/10/ac9a3ddf706a41a824dcd019978c8fdc.png', 'general', '2026-10-17 16:33:02'),
('maps_embed', 'https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d15854.132466943049!2d106.767275!3d-6.580448!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x6b93a4462670547c!2sSMK%20Infokom%20Kota%20Bogor!5e0!3m2!1sen!2sid!4v1633234498228!5m2!1sen!2sid', 'contact', '2026-10-17 16:23:24'),
('marquee_text', '', 'general', '2026-10-19 02:00:41'),
('phone', '0251-8348108', 'contact', '2026-10-17 16:23:24'),
('ppdb_banner', 'uploads/settings/2026/10/2dafe5aee0303d3fc9673bc01d67af99.jpg', 'general', '2026-10-21 14:11:09'),
('principal_name', 'Ir. Hj. Liliek Rahmaningsih, M.MPd', 'principal', '2026-10-17 16:23:24'),
('principal_photo', 'uploads/settings/2026/10/c10dc548988d86a08260673a6c573c2b.png', 'principal', '2026-10-19 02:00:41'),
('principal_speech', 'Selamat datang di website resmi SMK INFOKOM Kota Bogor. Di era digital saat ini, website sekolah adalah pintu gerbang informasi untuk menyebarluaskan kemajuan pendidikan dan pencapaian sekolah. Kami berharap website ini juga menjadi sarana silaturahmi antara sekolah, siswa, orang tua, dan alumni sebagai keluarga besar yang solid. SMK, Bisa...! SMK INFOKOM, Luar Biasa…!', 'principal', '2026-10-17 16:23:24'),
('principal_title', 'Kepala Sekolah', 'principal', '2026-10-17 16:23:24'),
('school_name', 'SMK INFOKOM KOTA BOGOR', 'general', '2026-10-17 16:23:24'),
('school_npsn', '', 'general', '2026-10-17 16:23:24'),
('school_short', 'SMK Infokom Bogor', 'general', '2026-10-17 16:23:24'),
('seo_description', 'Website profil SMK Infokom Kota Bogor: jurusan TKJ, RPL, DKV, dan PSPT, PPDB online, prestasi, BKK, dan informasi sekolah.', 'seo', '2026-10-17 16:23:24'),
('seo_title', 'SMK Infokom Kota Bogor — TKJ, RPL, DKV, PSPT', 'seo', '2026-10-17 16:23:24'),
('tagline', 'SMK, Bisa...! SMK INFOKOM, Luar Biasa…!', 'general', '2026-10-17 16:23:24'),
('tiktok', '', 'social', '2026-10-17 16:23:24'),
('whatsapp', '0878-7307-1400', 'contact', '2026-10-17 16:23:24'),
('youtube', 'https://youtube.com/channel/UCM1wHznYF69jhzSvrR5bKGQ', 'social', '2026-10-17 16:23:24');

-- --------------------------------------------------------

--
-- Struktur dari tabel `staff`
--

CREATE TABLE `staff` (
  `id` int(10) UNSIGNED NOT NULL,
  `slug` varchar(160) NOT NULL,
  `name` varchar(150) NOT NULL,
  `position` varchar(120) DEFAULT NULL,
  `education` varchar(120) DEFAULT NULL,
  `field` varchar(120) DEFAULT NULL,
  `subjects` varchar(255) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_demo` tinyint(1) NOT NULL DEFAULT 0,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `teachers`
--

CREATE TABLE `teachers` (
  `id` int(10) UNSIGNED NOT NULL,
  `slug` varchar(160) NOT NULL,
  `name` varchar(150) NOT NULL,
  `position` varchar(120) DEFAULT NULL,
  `education` varchar(120) DEFAULT NULL,
  `field` varchar(120) DEFAULT NULL,
  `subjects` varchar(255) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `major_id` int(10) UNSIGNED DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_demo` tinyint(1) NOT NULL DEFAULT 0,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `teachers`
--

INSERT INTO `teachers` (`id`, `slug`, `name`, `position`, `education`, `field`, `subjects`, `bio`, `photo`, `major_id`, `sort_order`, `is_active`, `is_demo`, `updated_at`) VALUES
(1, 'demo-guru-produktif-tkj', 'Richo Santana, S.Kom.', '⁠Guru Bimbingan & Konseling', 'S1', 'Teknik Komputer dan Jaringan', 'Pemrograman Web', '', 'uploads/teachers/2026/10/457520722e2cdd019e6d96c7c7260e81.png', 2, 1, 1, 0, '2026-10-19 14:31:15'),
(2, 'demo-guru-produktif-rpl', 'Erwin Hasiholan G., S.Kom', 'Guru Produktif', 'S1', 'Rekayasa Perangkat Lunak', 'Pemrograman Web', '', 'uploads/teachers/2026/10/cea7f64b2849d566d483954f68b7b090.png', 2, 2, 1, 0, '2026-10-17 17:00:23'),
(3, 'demo-guru-produktif-dkv', 'Ibnu Arif, S.I.Kom.', 'Kepala Program DKV', 'S1', 'Desain Komunikasi Visual', 'Desain Grafis', '', 'uploads/teachers/2026/10/c8b130f6804df101011a8b25a8dae0ac.png', 3, 3, 1, 0, '2026-10-19 03:34:02'),
(4, 'demo-guru-produktif-pspt', 'Erli Suherli, A.Md.', 'Kepala Program PSPT', 'D3', 'Produksi dan Siaran Program Televisi', 'Produksi Program TV', '', 'uploads/teachers/2026/10/746a1b64c7f7402651cc17fcfd67c3f7.png', 4, 4, 1, 0, '2026-10-19 03:35:17'),
(6, 'ridwan-hala-s-kom-gr', 'Ridwan Hala, S.Kom.,Gr.', 'Kepala Program RPL', 'S1', 'Rekayasa Perangkat Lunak', 'Robotik', '', 'uploads/teachers/2026/10/e7e8a26fd6b05426253e8e1f8668a2c4.png', NULL, 0, 1, 0, '2026-10-19 03:37:43'),
(7, 'aditya-nugraha-st', 'Aditya Nugraha, ST.', 'Kepala Program TKJ dan Ketua Manajemen Mutu', 'S1', 'Teknik Komputer dan Jaringan', 'Administrasi Sistem Jaringan', '', 'uploads/teachers/2026/10/80d5cec2719e137780a4498cb693cfc9.png', 1, 0, 1, 0, '2026-10-19 12:11:57'),
(8, 'mila-yaelasari-m-pd', 'Mila Yaelasari, M.Pd.', 'Wakil Kepala Sekolah Bidang Kurikulum', 'S2', '', 'Matematika', '', 'uploads/teachers/2026/10/24934469435a995be66f04aae8cf9ca0.png', NULL, 0, 1, 0, '2026-10-19 04:13:50'),
(9, 'dea-rijalul-fikri-s-kom-gr', 'Dea Rijalul Fikri, S.Kom.,Gr.', 'Wakil Kepala Sekolah Bidang Kesiswaan', 'S1', 'Desain Komunikasi Visual', 'Fotografi dan Videografi Editing', '', 'uploads/teachers/2026/10/8f8335a5c5f749951c25c8b642a7d44b.png', 3, 0, 1, 0, '2026-10-19 11:59:46'),
(10, 'r-radiani-srirestuti-dewi-ss-gr', 'R. Radiani Srirestuti Dewi, SS.,Gr.', 'Wakil Kepala Sekolah Bidang Hubungan Industri dan Masyarakat', 'S1', '', 'Bahasa Jepang', '', 'uploads/teachers/2026/10/8fcae51ed82d81715dffa68ed742e9ce.png', NULL, 0, 1, 0, '2026-10-19 12:03:20'),
(11, 'heny-handayani-s-pd', 'Heny Handayani, S.Pd.', '⁠Wakil Kepala Sekolah Bidang Pengembangan Sumber Daya Manusia', 'S1', '', 'Seni Budaya', '', 'uploads/teachers/2026/10/5a98a278d8df0b5743a1758a4318e398.png', NULL, 0, 1, 0, '2026-10-19 12:05:51'),
(12, 'agus-tiyono-m-pd', 'Agus Tiyono, M.Pd.', '⁠Wakil Kepala Sekolah Bidang Sarana dan Prasarana', 'S2', '', 'Sejarah', '', 'uploads/teachers/2026/10/22395affdf5bad0d21f9e6fa4dbc1120.png', NULL, 0, 1, 0, '2026-10-19 12:08:51'),
(13, 'cahyadi-rozi-st', 'Cahyadi Rozi, ST.', 'Kepala Tata Usaha', 'S1', 'Teknik Komputer dan Jaringan', 'Teknologi Layanan Jaringan (TLJ)', '', 'uploads/teachers/2026/10/2007d13a0d9d904f146fa3fbe8c81b1e.png', 1, 0, 1, 0, '2026-10-19 12:15:43'),
(14, 'drs-puji-marhaen-waluyo', 'Drs. Puji Marhaen Waluyo', 'Kepala Perpustakaan', 'S1', '', 'Pendidikan Pancasila dan Kewarganegaraan', '', 'uploads/teachers/2026/10/dbb3e1e9b8937b229e62bd7052a42805.png', NULL, 0, 1, 0, '2026-10-19 12:19:23'),
(15, 'putri-riandini-s-hut-m-pd-gr', 'Putri Riandini, S.Hut., M.Pd.,Gr.', 'Kepala Bendahara', 'S2', '', 'Matematika', '', 'uploads/teachers/2026/10/ab9dcc79bd8b0010bb65e1a96099b7d5.png', NULL, 0, 1, 0, '2026-10-19 12:21:12'),
(16, 'ahmad-hotib-s-pd-i', 'Ahmad Hotib, S.Pd.I', 'Pembina OSIS', 'S1', '', 'Pendidikan Agama dan Budi Pekerti', '', 'uploads/teachers/2026/10/6a8cac64c6946c476b69bb64143a21db.png', NULL, 0, 1, 0, '2026-10-19 14:29:56'),
(17, 'abdul-azis-m-pd', 'Abdul Azis, M.Pd.', 'Pembina OSIS', 'S2', '', 'Pendidikan Agama dan Budi Pekerti', '', 'uploads/teachers/2026/10/2524de0f6278c7e3d747f1d110b3fd12.png', NULL, 0, 1, 0, '2026-10-19 14:29:39'),
(18, 'vera-yuni-astuti-sp-m-ikom-gr', 'Vera Yuni Astuti, SP., M.IKom.,Gr.', 'Staf Kurikulum', 'S2', '', 'PIPAS', '', 'uploads/teachers/2026/10/4034884bb4f79288b7439419a116038f.png', NULL, 0, 1, 0, '2026-10-19 14:17:15'),
(19, 'm-fauzan-arifin-s-ikom-gr', 'M. Fauzan Arifin, S.IKom.,Gr.', 'Staf Kurikulum', 'S1', 'Desain Komunikasi Visual', 'Desain Publikasi', '', 'uploads/teachers/2026/10/59e23e863b9abedcee45cf60330a5813.png', 3, 0, 1, 0, '2026-10-19 14:24:17'),
(20, 'dra-popon-puspitasari', 'Dra. Popon Puspitasari', '⁠Guru Bimbingan & Konseling', 'S1', '', 'Pendidikan Agama dan Budi Pekerti', '', 'uploads/teachers/2026/10/1db66bb0881c4ef96fd20b2465861325.png', NULL, 0, 1, 0, '2026-10-19 14:29:29'),
(21, 'dian-hardianti-s-kom-gr', 'Dian Hardianti, S.Kom.,Gr.', '⁠Guru Bimbingan & Konseling', 'S1', 'Rekayasa Perangkat Lunak', 'Basis Data dan PPLG', '', 'uploads/teachers/2026/10/802d4db632365ce5b3f19df63381efc7.png', 2, 0, 1, 0, '2026-10-19 14:33:29'),
(22, 'yeni-yuliawati-s-pd-gr', 'Yeni Yuliawati, S.Pd.,Gr.,', 'Staf Teller (Bendahara)', 'S1', '', 'Bahasa Indonesia', '', 'uploads/teachers/2026/10/1b80e31c6d649bb29b420905996e09b0.png', NULL, 0, 1, 0, '2026-10-19 14:35:25'),
(23, 'rita-widyastuti', 'Rita Widyastuti', 'Staf Teller (Bendahara)', '', '', '', '', 'uploads/teachers/2026/10/e5c012cd82da680874889cc7a30bc094.png', NULL, 0, 1, 0, '2026-10-19 14:36:14'),
(24, 'eva-farida-rahayu-s-pd-gr', 'Eva Farida Rahayu, S.Pd.,Gr.', 'Staf Teller (Bendahara)', 'S1', '', 'Bahasa Indonesia', '', 'uploads/teachers/2026/10/9adbc1ca32a0c6ad5360764df2a6f035.png', NULL, 0, 1, 0, '2026-10-19 14:37:16'),
(25, 'jayadi-s-pd-gr', 'Jayadi, S.Pd.,Gr.', 'Staf Tata Usaha', 'S1', '', 'Pendidikan Jasmani, Olahraga & Kesehatan', '', 'uploads/teachers/2026/10/5979a93f962e6fbd0ee9171cc55c14aa.png', NULL, 0, 1, 0, '2026-10-19 14:39:56'),
(26, 'yadi-setiadi-s-sos-gr', 'Yadi Setiadi, S.Sos.,Gr.', 'Staf Tata Usaha', 'S1', '', 'Produk Kreatif dan Kewirausahaan', '', 'uploads/teachers/2026/10/360cad2207c288cc1e63c584bd54d83b.png', NULL, 0, 1, 0, '2026-10-19 14:42:26'),
(27, 'siti-nuraeni', 'Siti Nuraeni', 'Staf Tata Usaha', '', '', '', '', 'uploads/teachers/2026/10/4da7fddb106aa6e7d1c7351873fee494.png', NULL, 0, 1, 0, '2026-10-19 14:44:41'),
(28, 'reza-prafitriansyah-s-kom-gr', 'Reza Prafitriansyah, S.Kom.,Gr.', 'Staf Perpustakaan', 'S1', 'Desain Komunikasi Visual', 'Dasar-Dasar Program Keahlian Desain Komunikasi Visual', '', 'uploads/teachers/2026/10/9a945889fba6b2b9c5e3a7abd9db16a0.png', 3, 0, 1, 0, '2026-10-19 14:48:33'),
(29, 'dra-diana-octaria', 'Dra. Diana Octaria', '', 'S1', '', 'PIPAS', '', 'uploads/teachers/2026/10/83ac90126d25c7b0deb4ff6c2dcd5bb2.png', NULL, 0, 1, 0, '2026-10-19 14:52:39'),
(30, 'nabila-ahmadia-pratama-s-pd', 'Nabila Ahmadia Pratama, S.Pd.', '', 'S1', '', 'Bahasa Indonesia', '', 'uploads/teachers/2026/10/f8d90a51d294c81768e2cf1d5566c6ec.png', NULL, 0, 1, 0, '2026-10-19 14:54:04'),
(31, 'widyatama-nuranisa-sm', 'Widyatama Nuranisa, SM.', '', 'S1', '', 'Produk Kreatif dan Kewirausahaan', '', 'uploads/teachers/2026/10/a294470bc7d33188c168866f6f654fab.png', NULL, 0, 1, 0, '2026-10-19 14:55:48'),
(32, 'dara-purwanita-s-pd-gr', '- Dara Purwanita, S.Pd.,Gr.', '', 'S1', '', 'Bahasa Inggris', '', 'uploads/teachers/2026/10/7be03590ff72075f4fc58842122d4f9e.png', NULL, 0, 1, 0, '2026-10-19 14:56:26'),
(33, 'ir-hj-liliek-rahmaningsih-m-mpd', 'Ir. Hj. Liliek Rahmaningsih, M.MPd', 'Kepala Sekolah', 'S2', '', '', '', 'uploads/teachers/2026/10/ee8c381dab482ef364f5ca5a51be0256.png', NULL, 0, 1, 0, '2026-10-19 15:08:12');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `must_change_password` tinyint(1) NOT NULL DEFAULT 0,
  `last_login_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role_id`, `is_active`, `must_change_password`, `last_login_at`, `created_at`, `updated_at`) VALUES
(1, 'Super Admin', 'admin@smkinfokom.local', '$2y$12$l3QwBYQXNnRhoRJ02NspweO5ZUsWf8N0tFqSB2q0EawST5jkcP8cu', 1, 1, 0, '2026-10-22 14:18:31', '2026-10-17 16:23:24', '2026-10-22 07:18:31');

-- --------------------------------------------------------

--
-- Struktur dari tabel `videos`
--

CREATE TABLE `videos` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL,
  `youtube_url` varchar(255) NOT NULL,
  `description` varchar(300) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_demo` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `videos`
--

INSERT INTO `videos` (`id`, `title`, `youtube_url`, `description`, `is_active`, `is_demo`, `created_at`) VALUES
(2, 'Lomba 17 Agustus SMK Infokom', 'https://www.youtube.com/watch?v=wCC_ofY7y0w', 'SMK INFOKOM Kota Bogor mengadakan lomba 17 Agustus yang diikuti oleh siswa & guru.', 1, 0, '2026-10-21 09:16:24'),
(3, 'PEMBUKAAN PRAKTIK KERJA INDUSTI (PKL) dan WORKSHOP PENGUATAN KARAKTER SMK INFOKOM BOGOR #smkbisa', 'https://youtu.be/ZXW0Ivs_fnU?si=nyzSFr3LhdCuqMm_', 'SMK INFOKOM merupakan salah satu sekolah yang mempelajari bidang Teknologi Informasi dengan Kejuruan : 1. Teknik Komputer dan Jaringan (TKJ) 2. Rekayasa Perangkat Lunak (RPL) 3. Desain Komunikasi Visual (DKV) 4. Produksi Siaran dan Program Televisi (PSPT) Dari keempat kejuruan tersebut SMK INFOKOM j', 1, 0, '2026-10-22 01:05:12');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `achievements`
--
ALTER TABLE `achievements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_a_year` (`year`),
  ADD KEY `major_id` (`major_id`);

--
-- Indeks untuk tabel `achievement_images`
--
ALTER TABLE `achievement_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `achievement_id` (`achievement_id`);

--
-- Indeks untuk tabel `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_created` (`created_at`),
  ADD KEY `idx_user` (`user_id`);

--
-- Indeks untuk tabel `agenda`
--
ALTER TABLE `agenda`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `alumni`
--
ALTER TABLE `alumni`
  ADD PRIMARY KEY (`id`),
  ADD KEY `major_id` (`major_id`);

--
-- Indeks untuk tabel `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `bkk`
--
ALTER TABLE `bkk`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `company_partnerships`
--
ALTER TABLE `company_partnerships`
  ADD PRIMARY KEY (`id`),
  ADD KEY `company_id` (`company_id`);

--
-- Indeks untuk tabel `contact_messages`
--
ALTER TABLE `contact_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `curriculum`
--
ALTER TABLE `curriculum`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `extracurriculars`
--
ALTER TABLE `extracurriculars`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `facilities`
--
ALTER TABLE `facilities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_f_cat` (`category`);

--
-- Indeks untuk tabel `faq`
--
ALTER TABLE `faq`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `galleries`
--
ALTER TABLE `galleries`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `gallery_items`
--
ALTER TABLE `gallery_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_gallery_media` (`gallery_id`,`media_type`);

--
-- Indeks untuk tabel `industry_visits`
--
ALTER TABLE `industry_visits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_visit_date` (`visit_date`);

--
-- Indeks untuk tabel `internships`
--
ALTER TABLE `internships`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `internship_media`
--
ALTER TABLE `internship_media`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `major_id` (`major_id`);

--
-- Indeks untuk tabel `login_attempts`
--
ALTER TABLE `login_attempts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ip` (`ip`,`created_at`),
  ADD KEY `idx_email` (`email`,`created_at`);

--
-- Indeks untuk tabel `majors`
--
ALTER TABLE `majors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indeks untuk tabel `major_subjects`
--
ALTER TABLE `major_subjects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `major_id` (`major_id`);

--
-- Indeks untuk tabel `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uploaded_by` (`uploaded_by`);

--
-- Indeks untuk tabel `navigation`
--
ALTER TABLE `navigation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_parent` (`parent_id`,`sort_order`);

--
-- Indeks untuk tabel `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `idx_news_pub` (`is_active`,`deleted_at`,`published_at`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `author_id` (`author_id`);
ALTER TABLE `news` ADD FULLTEXT KEY `ft_news` (`title`,`excerpt`);

--
-- Indeks untuk tabel `news_categories`
--
ALTER TABLE `news_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indeks untuk tabel `organizations`
--
ALTER TABLE `organizations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indeks untuk tabel `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indeks untuk tabel `pkl`
--
ALTER TABLE `pkl`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `ppdb_documents`
--
ALTER TABLE `ppdb_documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `registrant_id` (`registrant_id`);

--
-- Indeks untuk tabel `ppdb_periods`
--
ALTER TABLE `ppdb_periods`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `ppdb_registrants`
--
ALTER TABLE `ppdb_registrants`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reg_number` (`reg_number`),
  ADD UNIQUE KEY `verify_token` (`verify_token`),
  ADD UNIQUE KEY `uq_nisn_period` (`nisn`,`period_id`),
  ADD KEY `idx_pr_major` (`major_id`,`status`),
  ADD KEY `period_id` (`period_id`);

--
-- Indeks untuk tabel `ppdb_settings`
--
ALTER TABLE `ppdb_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `programs`
--
ALTER TABLE `programs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indeks untuk tabel `rate_limits`
--
ALTER TABLE `rate_limits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_rl` (`bucket`,`ip`,`created_at`);

--
-- Indeks untuk tabel `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indeks untuk tabel `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`role_id`,`permission_id`),
  ADD KEY `permission_id` (`permission_id`);

--
-- Indeks untuk tabel `school_statistics`
--
ALTER TABLE `school_statistics`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `sections`
--
ALTER TABLE `sections`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `key` (`key`);

--
-- Indeks untuk tabel `seo_metadata`
--
ALTER TABLE `seo_metadata`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `page_key` (`page_key`);

--
-- Indeks untuk tabel `site_settings`
--
ALTER TABLE `site_settings`
  ADD PRIMARY KEY (`key`);

--
-- Indeks untuk tabel `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indeks untuk tabel `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `idx_t_active` (`is_active`,`sort_order`),
  ADD KEY `major_id` (`major_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `role_id` (`role_id`);

--
-- Indeks untuk tabel `videos`
--
ALTER TABLE `videos`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `achievements`
--
ALTER TABLE `achievements`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `achievement_images`
--
ALTER TABLE `achievement_images`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=216;

--
-- AUTO_INCREMENT untuk tabel `agenda`
--
ALTER TABLE `agenda`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT untuk tabel `alumni`
--
ALTER TABLE `alumni`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `announcements`
--
ALTER TABLE `announcements`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `bkk`
--
ALTER TABLE `bkk`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `companies`
--
ALTER TABLE `companies`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT untuk tabel `company_partnerships`
--
ALTER TABLE `company_partnerships`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `contact_messages`
--
ALTER TABLE `contact_messages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `curriculum`
--
ALTER TABLE `curriculum`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `documents`
--
ALTER TABLE `documents`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `extracurriculars`
--
ALTER TABLE `extracurriculars`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `facilities`
--
ALTER TABLE `facilities`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `faq`
--
ALTER TABLE `faq`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `galleries`
--
ALTER TABLE `galleries`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT untuk tabel `gallery_items`
--
ALTER TABLE `gallery_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT untuk tabel `industry_visits`
--
ALTER TABLE `industry_visits`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `internships`
--
ALTER TABLE `internships`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT untuk tabel `internship_media`
--
ALTER TABLE `internship_media`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `login_attempts`
--
ALTER TABLE `login_attempts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `majors`
--
ALTER TABLE `majors`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `major_subjects`
--
ALTER TABLE `major_subjects`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `media`
--
ALTER TABLE `media`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `navigation`
--
ALTER TABLE `navigation`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT untuk tabel `news`
--
ALTER TABLE `news`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `news_categories`
--
ALTER TABLE `news_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `organizations`
--
ALTER TABLE `organizations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT untuk tabel `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `pkl`
--
ALTER TABLE `pkl`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT untuk tabel `ppdb_documents`
--
ALTER TABLE `ppdb_documents`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `ppdb_periods`
--
ALTER TABLE `ppdb_periods`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `ppdb_registrants`
--
ALTER TABLE `ppdb_registrants`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `programs`
--
ALTER TABLE `programs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `rate_limits`
--
ALTER TABLE `rate_limits`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT untuk tabel `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `school_statistics`
--
ALTER TABLE `school_statistics`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `sections`
--
ALTER TABLE `sections`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT untuk tabel `seo_metadata`
--
ALTER TABLE `seo_metadata`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `staff`
--
ALTER TABLE `staff`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `teachers`
--
ALTER TABLE `teachers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `videos`
--
ALTER TABLE `videos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `achievements`
--
ALTER TABLE `achievements`
  ADD CONSTRAINT `achievements_ibfk_1` FOREIGN KEY (`major_id`) REFERENCES `majors` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `achievement_images`
--
ALTER TABLE `achievement_images`
  ADD CONSTRAINT `achievement_images_ibfk_1` FOREIGN KEY (`achievement_id`) REFERENCES `achievements` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `activity_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `alumni`
--
ALTER TABLE `alumni`
  ADD CONSTRAINT `alumni_ibfk_1` FOREIGN KEY (`major_id`) REFERENCES `majors` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `company_partnerships`
--
ALTER TABLE `company_partnerships`
  ADD CONSTRAINT `company_partnerships_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `gallery_items`
--
ALTER TABLE `gallery_items`
  ADD CONSTRAINT `gallery_items_ibfk_1` FOREIGN KEY (`gallery_id`) REFERENCES `galleries` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `jobs`
--
ALTER TABLE `jobs`
  ADD CONSTRAINT `jobs_ibfk_1` FOREIGN KEY (`major_id`) REFERENCES `majors` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `major_subjects`
--
ALTER TABLE `major_subjects`
  ADD CONSTRAINT `major_subjects_ibfk_1` FOREIGN KEY (`major_id`) REFERENCES `majors` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `media`
--
ALTER TABLE `media`
  ADD CONSTRAINT `media_ibfk_1` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `news`
--
ALTER TABLE `news`
  ADD CONSTRAINT `news_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `news_categories` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `news_ibfk_2` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `ppdb_documents`
--
ALTER TABLE `ppdb_documents`
  ADD CONSTRAINT `ppdb_documents_ibfk_1` FOREIGN KEY (`registrant_id`) REFERENCES `ppdb_registrants` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `ppdb_registrants`
--
ALTER TABLE `ppdb_registrants`
  ADD CONSTRAINT `ppdb_registrants_ibfk_1` FOREIGN KEY (`period_id`) REFERENCES `ppdb_periods` (`id`),
  ADD CONSTRAINT `ppdb_registrants_ibfk_2` FOREIGN KEY (`major_id`) REFERENCES `majors` (`id`);

--
-- Ketidakleluasaan untuk tabel `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `role_permissions_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `teachers`
--
ALTER TABLE `teachers`
  ADD CONSTRAINT `teachers_ibfk_1` FOREIGN KEY (`major_id`) REFERENCES `majors` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
