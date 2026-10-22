-- SMK Infokom Kota Bogor — database lengkap (schema + data resmi + data demo)
CREATE DATABASE IF NOT EXISTS smk_infokom_bogor CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE smk_infokom_bogor;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE roles (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  slug VARCHAR(40) NOT NULL UNIQUE,
  name VARCHAR(80) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE permissions (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  slug VARCHAR(60) NOT NULL UNIQUE,
  name VARCHAR(120) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE role_permissions (
  role_id INT UNSIGNED NOT NULL,
  permission_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (role_id, permission_id),
  FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
  FOREIGN KEY (permission_id) REFERENCES permissions(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE users (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  role_id INT UNSIGNED NOT NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  must_change_password TINYINT(1) NOT NULL DEFAULT 0,
  last_login_at DATETIME NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (role_id) REFERENCES roles(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE login_attempts (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  ip VARCHAR(45) NOT NULL,
  email VARCHAR(150) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_ip (ip, created_at), INDEX idx_email (email, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE rate_limits (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  bucket VARCHAR(40) NOT NULL,
  ip VARCHAR(45) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_rl (bucket, ip, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE activity_logs (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NULL,
  action VARCHAR(40) NOT NULL,
  module VARCHAR(60) NOT NULL,
  record_id INT UNSIGNED NULL,
  detail VARCHAR(500) NULL,
  ip VARCHAR(45) NOT NULL,
  user_agent VARCHAR(255) NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_created (created_at), INDEX idx_user (user_id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE site_settings (
  `key` VARCHAR(60) PRIMARY KEY,
  `value` TEXT NULL,
  `group` VARCHAR(30) NOT NULL DEFAULT 'general',
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE navigation (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(80) NOT NULL,
  url VARCHAR(255) NOT NULL DEFAULT '',
  parent_id INT UNSIGNED NOT NULL DEFAULT 0,
  icon VARCHAR(40) NULL,
  sort_order INT NOT NULL DEFAULT 0,
  target VARCHAR(10) NOT NULL DEFAULT '_self',
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  INDEX idx_parent (parent_id, sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE sections (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `key` VARCHAR(40) NOT NULL UNIQUE,
  label VARCHAR(80) NOT NULL,
  badge VARCHAR(120) NULL,
  title VARCHAR(255) NULL,
  subtitle VARCHAR(255) NULL,
  content TEXT NULL,
  image VARCHAR(255) NULL,
  button_text VARCHAR(80) NULL,
  button_url VARCHAR(255) NULL,
  button2_text VARCHAR(80) NULL,
  button2_url VARCHAR(255) NULL,
  is_enabled TINYINT(1) NOT NULL DEFAULT 1,
  sort_order INT NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE pages (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  slug VARCHAR(120) NOT NULL UNIQUE,
  title VARCHAR(200) NOT NULL,
  excerpt VARCHAR(300) NULL,
  content MEDIUMTEXT NULL,
  image VARCHAR(255) NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  is_demo TINYINT(1) NOT NULL DEFAULT 0,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE seo_metadata (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  page_key VARCHAR(120) NOT NULL UNIQUE,
  title VARCHAR(200) NULL,
  description VARCHAR(300) NULL,
  og_image VARCHAR(255) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE school_statistics (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  label VARCHAR(60) NOT NULL,
  value INT UNSIGNED NOT NULL DEFAULT 0,
  suffix VARCHAR(10) NOT NULL DEFAULT '',
  icon VARCHAR(40) NOT NULL DEFAULT 'users',
  sort_order INT NOT NULL DEFAULT 0,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  is_demo TINYINT(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE majors (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  code VARCHAR(10) NOT NULL UNIQUE,
  slug VARCHAR(20) NOT NULL UNIQUE,
  name VARCHAR(120) NOT NULL,
  short_desc VARCHAR(300) NULL,
  description TEXT NULL,
  competencies TEXT NULL,
  materials TEXT NULL,
  practices TEXT NULL,
  facilities_text TEXT NULL,
  career TEXT NULL,
  certifications TEXT NULL,
  activities TEXT NULL,
  cover VARCHAR(255) NULL,
  logo VARCHAR(255) NULL,
  icon VARCHAR(40) NOT NULL DEFAULT 'cpu',
  ppdb_quota INT UNSIGNED NOT NULL DEFAULT 72,
  sort_order INT NOT NULL DEFAULT 0,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  is_demo TINYINT(1) NOT NULL DEFAULT 0,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE major_subjects (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  major_id INT UNSIGNED NOT NULL,
  name VARCHAR(150) NOT NULL,
  grade VARCHAR(10) NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  is_demo TINYINT(1) NOT NULL DEFAULT 0,
  FOREIGN KEY (major_id) REFERENCES majors(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE teachers (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  slug VARCHAR(160) NOT NULL UNIQUE,
  name VARCHAR(150) NOT NULL,
  position VARCHAR(120) NULL,
  education VARCHAR(120) NULL,
  field VARCHAR(120) NULL,
  subjects VARCHAR(255) NULL,
  bio TEXT NULL,
  photo VARCHAR(255) NULL,
  major_id INT UNSIGNED NULL,
  sort_order INT NOT NULL DEFAULT 0,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  is_demo TINYINT(1) NOT NULL DEFAULT 0,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_t_active (is_active, sort_order),
  FOREIGN KEY (major_id) REFERENCES majors(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE staff (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  slug VARCHAR(160) NOT NULL UNIQUE,
  name VARCHAR(150) NOT NULL,
  position VARCHAR(120) NULL,
  education VARCHAR(120) NULL,
  field VARCHAR(120) NULL,
  subjects VARCHAR(255) NULL,
  bio TEXT NULL,
  photo VARCHAR(255) NULL,
  sort_order INT NOT NULL DEFAULT 0,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  is_demo TINYINT(1) NOT NULL DEFAULT 0,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE programs (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  slug VARCHAR(120) NOT NULL UNIQUE,
  title VARCHAR(150) NOT NULL,
  summary VARCHAR(300) NULL,
  description TEXT NULL,
  icon VARCHAR(40) NOT NULL DEFAULT 'layers',
  image VARCHAR(255) NULL,
  sort_order INT NOT NULL DEFAULT 0,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  is_demo TINYINT(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE curriculum (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  category VARCHAR(40) NOT NULL,
  title VARCHAR(160) NOT NULL,
  content TEXT NULL,
  sort_order INT NOT NULL DEFAULT 0,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  is_demo TINYINT(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE facilities (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  category VARCHAR(60) NOT NULL,
  description TEXT NULL,
  image VARCHAR(255) NULL,
  sort_order INT NOT NULL DEFAULT 0,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  is_demo TINYINT(1) NOT NULL DEFAULT 0,
  INDEX idx_f_cat (category)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE achievements (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(200) NOT NULL,
  team VARCHAR(150) NULL,
  major_id INT UNSIGNED NULL,
  competition VARCHAR(200) NULL,
  rank_title VARCHAR(60) NULL,
  level VARCHAR(30) NOT NULL DEFAULT 'Kota',
  category VARCHAR(60) NULL,
  year SMALLINT UNSIGNED NOT NULL,
  image VARCHAR(255) NULL,
  certificate VARCHAR(255) NULL,
  description TEXT NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  is_demo TINYINT(1) NOT NULL DEFAULT 0,
  INDEX idx_a_year (year),
  FOREIGN KEY (major_id) REFERENCES majors(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE achievement_images (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  achievement_id INT UNSIGNED NOT NULL,
  image VARCHAR(255) NOT NULL,
  FOREIGN KEY (achievement_id) REFERENCES achievements(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE alumni (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  photo VARCHAR(255) NULL,
  grad_year SMALLINT UNSIGNED NOT NULL,
  major_id INT UNSIGNED NULL,
  job VARCHAR(120) NULL,
  company VARCHAR(150) NULL,
  college VARCHAR(150) NULL,
  entrepreneur VARCHAR(150) NULL,
  testimonial TEXT NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  is_demo TINYINT(1) NOT NULL DEFAULT 0,
  FOREIGN KEY (major_id) REFERENCES majors(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE organizations (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  type VARCHAR(40) NOT NULL DEFAULT 'OSIS',
  description TEXT NULL,
  leaders TEXT NULL,
  work_programs TEXT NULL,
  logo VARCHAR(255) NULL,
  sort_order INT NOT NULL DEFAULT 0,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  is_demo TINYINT(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE extracurriculars (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  logo VARCHAR(255) NULL,
  description TEXT NULL,
  coach VARCHAR(150) NULL,
  schedule VARCHAR(150) NULL,
  place VARCHAR(150) NULL,
  achievements TEXT NULL,
  image VARCHAR(255) NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  is_demo TINYINT(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE pkl (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  step_order INT NOT NULL,
  title VARCHAR(100) NOT NULL,
  description TEXT NULL,
  icon VARCHAR(40) NOT NULL DEFAULT 'check',
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  is_demo TINYINT(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE internships (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  kind VARCHAR(30) NOT NULL DEFAULT 'proses',
  title VARCHAR(150) NOT NULL,
  description TEXT NULL,
  sort_order INT NOT NULL DEFAULT 0,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  is_demo TINYINT(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE industry_visits (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(200) NOT NULL,
  company VARCHAR(150) NOT NULL,
  location VARCHAR(150) NULL,
  visit_date DATE NULL,
  major_id INT UNSIGNED NULL,
  participants VARCHAR(150) NULL,
  description TEXT NULL,
  learnings TEXT NULL,
  image VARCHAR(255) NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  is_demo TINYINT(1) NOT NULL DEFAULT 0,
  KEY idx_visit_date (visit_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE bkk (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  kind VARCHAR(30) NOT NULL DEFAULT 'profil',
  title VARCHAR(150) NOT NULL,
  content TEXT NULL,
  sort_order INT NOT NULL DEFAULT 0,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  is_demo TINYINT(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE companies (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  logo VARCHAR(255) NULL,
  industry VARCHAR(100) NULL,
  website VARCHAR(255) NULL,
  location VARCHAR(150) NULL,
  cooperation VARCHAR(255) NULL,
  is_pkl TINYINT(1) NOT NULL DEFAULT 0,
  is_magang TINYINT(1) NOT NULL DEFAULT 0,
  is_recruit TINYINT(1) NOT NULL DEFAULT 0,
  is_tefa TINYINT(1) NOT NULL DEFAULT 0,
  since_year SMALLINT UNSIGNED NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  is_demo TINYINT(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE company_partnerships (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  company_id INT UNSIGNED NOT NULL,
  type VARCHAR(40) NOT NULL,
  note VARCHAR(255) NULL,
  FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE jobs (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  company VARCHAR(150) NOT NULL,
  position VARCHAR(150) NOT NULL,
  location VARCHAR(150) NULL,
  major_id INT UNSIGNED NULL,
  type VARCHAR(30) NOT NULL DEFAULT 'Full-time',
  requirements TEXT NULL,
  deadline DATE NULL,
  link VARCHAR(255) NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  is_demo TINYINT(1) NOT NULL DEFAULT 0,
  FOREIGN KEY (major_id) REFERENCES majors(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE news_categories (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(80) NOT NULL,
  slug VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE news (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(220) NOT NULL,
  slug VARCHAR(240) NOT NULL UNIQUE,
  category_id INT UNSIGNED NULL,
  excerpt VARCHAR(320) NULL,
  content MEDIUMTEXT NULL,
  image VARCHAR(255) NULL,
  is_featured TINYINT(1) NOT NULL DEFAULT 0,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  is_demo TINYINT(1) NOT NULL DEFAULT 0,
  published_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  author_id INT UNSIGNED NULL,
  views INT UNSIGNED NOT NULL DEFAULT 0,
  deleted_at DATETIME NULL,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_news_pub (is_active, deleted_at, published_at),
  FULLTEXT KEY ft_news (title, excerpt),
  FOREIGN KEY (category_id) REFERENCES news_categories(id) ON DELETE SET NULL,
  FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE galleries (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(160) NOT NULL,
  category VARCHAR(40) NOT NULL DEFAULT 'Kegiatan',
  description VARCHAR(300) NULL,
  cover VARCHAR(255) NULL,
  event_date DATE NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  is_demo TINYINT(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE gallery_items (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  gallery_id INT UNSIGNED NOT NULL,
  image VARCHAR(255) NOT NULL,
  caption VARCHAR(200) NULL,
  is_demo TINYINT(1) NOT NULL DEFAULT 0,
  FOREIGN KEY (gallery_id) REFERENCES galleries(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE videos (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(200) NOT NULL,
  youtube_url VARCHAR(255) NOT NULL,
  description VARCHAR(300) NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  is_demo TINYINT(1) NOT NULL DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE announcements (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(200) NOT NULL,
  body TEXT NULL,
  link VARCHAR(255) NULL,
  show_in_bar TINYINT(1) NOT NULL DEFAULT 0,
  starts_at DATE NULL,
  ends_at DATE NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  is_demo TINYINT(1) NOT NULL DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE agenda (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(200) NOT NULL,
  description VARCHAR(400) NULL,
  location VARCHAR(150) NULL,
  start_date DATE NOT NULL,
  end_date DATE NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  is_demo TINYINT(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE faq (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  scope VARCHAR(30) NOT NULL DEFAULT 'ppdb',
  question VARCHAR(255) NOT NULL,
  answer TEXT NOT NULL,
  sort_order INT NOT NULL DEFAULT 0,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  is_demo TINYINT(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE documents (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(200) NOT NULL,
  category VARCHAR(60) NOT NULL DEFAULT 'Akademik',
  file_path VARCHAR(255) NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  is_demo TINYINT(1) NOT NULL DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE ppdb_settings (
  id TINYINT UNSIGNED PRIMARY KEY DEFAULT 1,
  is_open TINYINT(1) NOT NULL DEFAULT 1,
  info TEXT NULL,
  requirements TEXT NULL,
  fees TEXT NULL,
  flow TEXT NULL,
  closed_message VARCHAR(300) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE ppdb_periods (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  description VARCHAR(300) NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  is_demo TINYINT(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE ppdb_registrants (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  reg_number VARCHAR(30) NOT NULL UNIQUE,
  verify_token CHAR(32) NOT NULL UNIQUE,
  period_id INT UNSIGNED NOT NULL,
  major_id INT UNSIGNED NOT NULL,
  name VARCHAR(150) NOT NULL,
  nisn CHAR(10) NOT NULL,
  school_origin VARCHAR(150) NOT NULL,
  birth_place VARCHAR(100) NOT NULL,
  birth_date DATE NOT NULL,
  gender CHAR(1) NOT NULL,
  address VARCHAR(300) NOT NULL,
  phone VARCHAR(20) NOT NULL,
  email VARCHAR(150) NULL,
  father_name VARCHAR(150) NOT NULL,
  mother_name VARCHAR(150) NOT NULL,
  parent_job VARCHAR(100) NOT NULL,
  parent_income VARCHAR(60) NOT NULL,
  photo VARCHAR(255) NULL,
  status VARCHAR(20) NOT NULL DEFAULT 'baru',
  note VARCHAR(300) NULL,
  ip VARCHAR(45) NULL,
  deleted_at DATETIME NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_nisn_period (nisn, period_id),
  INDEX idx_pr_major (major_id, status),
  FOREIGN KEY (period_id) REFERENCES ppdb_periods(id),
  FOREIGN KEY (major_id) REFERENCES majors(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE ppdb_documents (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  registrant_id INT UNSIGNED NOT NULL,
  doc_type VARCHAR(40) NOT NULL,
  file_path VARCHAR(255) NOT NULL,
  FOREIGN KEY (registrant_id) REFERENCES ppdb_registrants(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE media (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  filename VARCHAR(200) NOT NULL,
  path VARCHAR(255) NOT NULL,
  mime VARCHAR(80) NOT NULL,
  size INT UNSIGNED NOT NULL,
  folder VARCHAR(60) NOT NULL DEFAULT 'umum',
  category VARCHAR(60) NULL,
  alt VARCHAR(200) NULL,
  uploaded_by INT UNSIGNED NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (uploaded_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE contact_messages (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL,
  phone VARCHAR(20) NULL,
  subject VARCHAR(150) NOT NULL,
  message TEXT NOT NULL,
  ip VARCHAR(45) NULL,
  is_read TINYINT(1) NOT NULL DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET FOREIGN_KEY_CHECKS = 1;

SET NAMES utf8mb4;

INSERT INTO roles (id,slug,name) VALUES (1,'super_admin','Super Admin'),(2,'admin','Admin'),(3,'editor','Editor');

INSERT INTO permissions (slug,name) VALUES
('content.manage','Kelola konten (guru, jurusan, program, fasilitas, prestasi, dll.)'),
('news.manage','Kelola berita, pengumuman, agenda'),
('gallery.manage','Kelola galeri & video'),
('media.manage','Kelola media library'),
('ppdb.manage','Kelola PPDB'),
('messages.manage','Kelola pesan kontak'),
('settings.manage','Kelola pengaturan situs, navigasi, homepage, SEO'),
('users.manage','Kelola pengguna & role'),
('logs.view','Lihat activity log');

-- Admin: semua kecuali users & logs & settings; Editor: konten, berita, galeri, media
INSERT INTO role_permissions (role_id,permission_id) SELECT 2,id FROM permissions WHERE slug IN ('content.manage','news.manage','gallery.manage','media.manage','ppdb.manage','messages.manage','settings.manage','logs.view');
INSERT INTO role_permissions (role_id,permission_id) SELECT 3,id FROM permissions WHERE slug IN ('content.manage','news.manage','gallery.manage','media.manage');

INSERT INTO users (name,email,password,role_id,must_change_password) VALUES ('Super Admin','admin@smkinfokom.local','$2y$10$.hwnQLbN/nZrcwi52.ixN.qsjhe46wimpDEelIFj/73CqzJJ2iXY6',1,1);

INSERT INTO site_settings (`key`,`value`,`group`) VALUES
('school_name','SMK INFOKOM KOTA BOGOR','general'),
('school_short','SMK Infokom Bogor','general'),
('tagline','SMK, Bisa...! SMK INFOKOM, Luar Biasa…!','general'),
('logo','','general'),
('favicon','','general'),
('address','Jl. Letjen Ibrahim Adjie No.178, RT.03/RW.08, Sindangbarang, Kecamatan Bogor Barat, Kota Bogor, Jawa Barat 16117','contact'),
('phone','0251-8348108','contact'),
('whatsapp','0878-7307-1400','contact'),
('email','smk.infokom@gmail.com','contact'),
('hours','Senin - Jumat : 07:00 - 17:00','contact'),
('maps_embed','https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d15854.132466943049!2d106.767275!3d-6.580448!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x6b93a4462670547c!2sSMK%20Infokom%20Kota%20Bogor!5e0!3m2!1sen!2sid!4v1633234498228!5m2!1sen!2sid','contact'),
('instagram','https://instagram.com/smk.infokom_official','social'),
('youtube','https://youtube.com/channel/UCM1wHznYF69jhzSvrR5bKGQ','social'),
('facebook','https://m.facebook.com/SMK-Infokom-105202311143756/','social'),
('tiktok','','social'),
('color_primary','#0B4DA2','theme'),
('color_navy','#0A2A5E','theme'),
('color_accent','#F5B800','theme'),
('footer_text','Sekolah menengah kejuruan di Kota Bogor yang menyiapkan lulusan kompeten, siap kerja, dan berwirausaha.','general'),
('seo_title','SMK Infokom Kota Bogor — TKJ, RPL, DKV, PSPT','seo'),
('seo_description','Website profil SMK Infokom Kota Bogor: jurusan TKJ, RPL, DKV, dan PSPT, PPDB online, prestasi, BKK, dan informasi sekolah.','seo'),
('principal_name','Ir. Hj. Liliek Rahmaningsih, M.MPd','principal'),
('principal_title','Kepala Sekolah','principal'),
('principal_photo','','principal'),
('principal_speech','Selamat datang di website resmi SMK INFOKOM Kota Bogor. Di era digital saat ini, website sekolah adalah pintu gerbang informasi untuk menyebarluaskan kemajuan pendidikan dan pencapaian sekolah. Kami berharap website ini juga menjadi sarana silaturahmi antara sekolah, siswa, orang tua, dan alumni sebagai keluarga besar yang solid. SMK, Bisa...! SMK INFOKOM, Luar Biasa…!','principal'),
('school_npsn','','general');

INSERT INTO sections (`key`,label,badge,title,subtitle,content,button_text,button_url,button2_text,button2_url,is_enabled,sort_order) VALUES
('hero','Hero','Penerimaan Peserta Didik Baru','Siap Kerja, Siap Kuliah, Siap Berwirausaha','SMK Infokom Kota Bogor','Empat kompetensi keahlian — TKJ, RPL, DKV, dan PSPT — dengan praktik industri, PKL, dan jalur karier melalui BKK.','Daftar PPDB','/ppdb','Lihat Jurusan','/jurusan',1,1),
('statistics','Statistik',NULL,'SMK Infokom dalam Angka',NULL,NULL,NULL,NULL,NULL,NULL,1,2),
('about','Tentang Sekolah','Tentang Kami','SMK Informatika & Telekomunikasi Kota Bogor','Di bawah naungan Yayasan Telekomunikasi Nasional','SMK Infokom Bogor menempati lahan seluas 2.600 m² di Jalan Letjen Ibrahim Adjie No. 178, Sindangbarang, Bogor Barat. Sekolah berfokus pada kompetensi teknologi informasi, desain, dan penyiaran dengan kurikulum berstandar nasional dan kemitraan industri.','Selengkapnya','/profil/tentang-sekolah',NULL,NULL,1,3),
('principal','Sambutan Kepala Sekolah','Sambutan',NULL,NULL,NULL,'Baca Sambutan','/profil/kepala-sekolah',NULL,NULL,1,4),
('majors','Jurusan','Kompetensi Keahlian','Empat Jurusan, Satu Arah: Dunia Kerja','Pilih jalur yang sesuai minat dan bakat',NULL,'Semua Jurusan','/jurusan',NULL,NULL,1,5),
('programs','Program','Program Sekolah','Program Penguatan Kompetensi',NULL,NULL,'Semua Program','/program',NULL,NULL,1,6),
('academic','Akademik','Akademik','Kurikulum Berstandar Nasional','Pembelajaran teori dan praktik yang seimbang','Kurikulum dikembangkan bersama dunia usaha dan dunia industri agar lulusan memiliki kompetensi yang relevan.','Lihat Kurikulum','/akademik/kurikulum',NULL,NULL,1,7),
('pkl','PKL','Praktik Kerja Lapangan','Belajar Langsung di Industri',NULL,'Siswa menjalani PKL di mitra industri dengan pendampingan pembimbing sekolah dan industri.','Alur PKL','/pkl',NULL,NULL,1,8),
('magang','Magang','Magang','Magang untuk Pengalaman Kerja Nyata',NULL,'Program magang melengkapi PKL dengan pengalaman kerja yang lebih panjang dan mendalam.','Info Magang','/magang',NULL,NULL,1,9),
('facilities','Fasilitas','Fasilitas','Fasilitas Belajar',NULL,NULL,'Semua Fasilitas','/fasilitas',NULL,NULL,1,10),
('achievements','Prestasi','Prestasi','Prestasi Siswa',NULL,NULL,'Semua Prestasi','/prestasi',NULL,NULL,1,11),
('partners','Mitra','Industri & Karier','Mitra Industri',NULL,NULL,'Semua Mitra','/mitra',NULL,NULL,1,12),
('news','Berita','Informasi','Berita Terbaru',NULL,NULL,'Semua Berita','/berita',NULL,NULL,1,13),
('gallery','Galeri','Galeri','Galeri Kegiatan',NULL,NULL,'Buka Galeri','/galeri',NULL,NULL,1,14),
('video','Video','Video','Video Sekolah',NULL,NULL,'Semua Video','/video',NULL,NULL,1,15),
('cta','CTA PPDB','PPDB','Bergabung bersama SMK Infokom',NULL,'Cek jadwal, persyaratan, dan daftar secara online.','Daftar Sekarang','/ppdb','Hubungi Kami','/kontak',1,16),
('contact','Kontak','Kontak','Hubungi Kami',NULL,NULL,'Halaman Kontak','/kontak',NULL,NULL,1,17);

INSERT INTO school_statistics (label,value,suffix,icon,sort_order,is_demo) VALUES
('Siswa',0,'+','users',1,1),('Guru',0,'','user-check',2,1),('Staff',0,'','briefcase',3,1),('Jurusan',4,'','layers',4,0),('Prestasi',0,'','trophy',5,1),('Mitra',0,'','handshake',6,1);

INSERT INTO majors (code,slug,name,short_desc,description,competencies,materials,practices,facilities_text,career,certifications,activities,icon,sort_order,is_demo) VALUES
('TKJ','tkj','Teknik Komputer dan Jaringan','Merakit komputer, membangun dan mengamankan jaringan LAN/WAN.','Kompetensi keahlian yang membekali siswa dengan keterampilan dukungan teknis, administrasi jaringan, dan keamanan jaringan.','IT Support Jaringan
Perakitan dan Perbaikan Komputer
Administrator Jaringan Komputer LAN dan WAN
Aplikasi Teknik Komputer dan Jaringan interaktif
Keamanan Jaringan Terpusat','Dasar-dasar komputer dan jaringan
Administrasi sistem server
Konfigurasi router dan switch
Keamanan jaringan','Perakitan komputer
Instalasi dan konfigurasi jaringan
Troubleshooting perangkat','Laboratorium komputer dan jaringan','Teknisi jaringan
IT Support
Network administrator
Teknisi komputer','Sertifikasi kompetensi bidang jaringan (sesuai program sekolah)','Praktik lab, PKL industri','server',1,0),
('RPL','rpl','Rekayasa Perangkat Lunak','Merancang dan membangun aplikasi desktop, mobile, web, dan enterprise.','Kompetensi keahlian untuk membangun perangkat lunak: analisis, perancangan sistem, pemrograman, dan pengujian.','Pemrograman Aplikasi Berbasis Desktop
Analisa dan Perancangan sistem
Arsitektur Aplikasi Desktop, Mobile, Web dan Enterprise','Algoritma dan pemrograman
Basis data
Pemrograman web dan mobile
Rekayasa perangkat lunak','Proyek aplikasi
Pengembangan web dan mobile','Laboratorium komputer','Programmer
Web developer
Mobile developer
Software tester','Sertifikasi kompetensi bidang pemrograman (sesuai program sekolah)','Proyek aplikasi, lomba kompetensi','code',2,0),
('DKV','dkv','Desain Komunikasi Visual','Menyampaikan pesan lewat desain, ilustrasi, fotografi, dan media digital.','Kompetensi keahlian di bidang desain visual: citra dan animasi digital, web interaktif, serta produksi audio-video. [DEMO] Deskripsi disesuaikan dengan nama jurusan DKV; admin dapat mengubahnya melalui dashboard.','Mengembangkan citra dan animasi digital
Mengembangkan laman (web) interaktif
Merekam dan menyunting audio-video
Mengembangkan aplikasi visual interaktif','Desain grafis
Tipografi dan branding
Ilustrasi digital
Fotografi dan videografi','Praktik desain dan produksi karya
Portofolio siswa','Laboratorium DKV','Desainer grafis
Ilustrator
Fotografer
Video editor','[DEMO] Sertifikasi desain (sesuai program sekolah)','Pameran karya, lomba desain','palette',3,0),
('PSPT','pspt','Produksi dan Siaran Program Televisi','Memproduksi program televisi: kamera, penyuntingan, penyutradaraan, dan penyiaran.','Kompetensi keahlian produksi dan penyiaran program pertelevisian.','Program Pertelevisian
Penyutradaraan, Editor, Kameramen
Penata Artistik dan Suara, Penulis Naskah dan Skenario
Aplikasi Teknik Produksi dan Penyiaran Program Pertelevisian interaktif','Dasar produksi program TV
Penulisan naskah dan skenario
Teknik kamera dan pencahayaan
Penyuntingan gambar dan suara','Produksi program siaran
Praktik studio','Studio PSPT','Kameramen
Editor video
Penulis skenario
Asisten sutradara','[DEMO] Sertifikasi penyiaran (sesuai program sekolah)','Produksi program, liputan kegiatan','video',4,0);

INSERT INTO pages (slug,title,excerpt,content,is_demo) VALUES
('tentang-sekolah','Tentang Sekolah','Profil singkat SMK Infokom Kota Bogor','<p>Yayasan Telekomunikasi Nasional berlokasi di dua tempat: Jalan RE Abdullah No. 15 Gunung Batu, Bogor (lahan 800 m², SMP Infokom Bogor) dan Jalan Letjen Ibrahim Adjie No. 178 Sindangbarang, Bogor (lahan 2.600 m², SMK Infokom Bogor).</p><p>Sekolah memiliki empat kompetensi keahlian di bidang teknologi informasi, desain, dan penyiaran dengan orientasi pada kesiapan kerja dan kewirausahaan.</p>',0),
('sejarah','Sejarah','Perjalanan Yayasan Telekomunikasi Nasional dan SMK Infokom','<p>Berdasarkan Akte Pendirian Nomor 137 dari Notaris Rinasari Dwi Juli, SH. tanggal 10 Juni 2010, Yayasan Telekomunikasi Nasional (Yatelnas) didirikan oleh Ir. Gun Gun Gunawan, M.Si., Ir. Aan Chandra, Wieke Erwina, M.Si., Moelyati Effendi, MS., Dra. Moerfiah, MS., dan Dedi Kusdinar SH, MM.</p><p>Pada awal berdirinya, yang pertama dirintis adalah lembaga pendidikan setara perguruan tinggi “Akademi Telekomunikasi Nasional” yang beroperasi sejak tahun 2003 hingga 2014, kemudian pengelolaannya dialihkan kepada Yayasan Ganesha Bandung.</p><p>Uraian sejarah selengkapnya dapat dilengkapi admin melalui dashboard.</p>',0),
('visi-misi','Visi & Misi','Arah dan komitmen sekolah','<h3>Visi</h3><p>Terwujudnya SMK Infokom Bogor sebagai SMK yang peduli dan berbudaya lingkungan hidup dengan tamatan yang kompeten dan mampu bersaing di tingkat Nasional maupun Internasional.</p><h3>Misi</h3><ol><li>Membangun mental dan sikap peserta didik yang beriman dan bertaqwa kepada Tuhan Yang Maha Esa.</li><li>Mengembangkan kurikulum dan menyelenggarakan pembelajaran berstandar Nasional.</li><li>Melalui kemitraan, keterbukaan dan pelayanan prima, SMK Infokom Kota Bogor: meningkatkan kualitas dan kuantitas tamatan yang siap kerja; menyiapkan wirausahawan yang handal dan mampu bersaing; menyiapkan tenaga terampil yang memiliki etos kerja dan kepribadian.</li></ol>',0),
('tujuan','Tujuan','Tujuan pendidikan SMK Infokom','<ol><li>Menyiapkan lulusan yang bertaqwa kepada Tuhan Yang Maha Esa dan siap memasuki lapangan kerja.</li><li>Menyiapkan lulusan yang peduli lingkungan, produktif, adaptif, dan kreatif.</li><li>Menyiapkan lulusan yang memahami sistem manajemen mutu agar mampu berkarier, berkompetisi, dan profesional.</li><li>Menyiapkan tenaga kerja tingkat menengah untuk mengisi kebutuhan dunia kerja berskala global.</li><li>Mempersiapkan peserta didik mampu bekerja mandiri serta mengisi lowongan di DU/DI sebagai tenaga tingkat menengah sesuai program keahlian.</li><li>Membekali peserta didik agar mampu mengembangkan sikap profesional dalam bidang keahliannya.</li><li>Membekali peserta didik dengan ilmu pengetahuan dan teknologi agar mampu berkembang secara mandiri maupun melalui jenjang pendidikan yang lebih tinggi.</li></ol>',0),
('struktur-organisasi','Struktur Organisasi','Susunan organisasi sekolah','<div class="org-chart"><div class="org-node org-top">Kepala Sekolah</div><div class="org-row"><div class="org-node">Wakil Kepala Sekolah [DEMO]</div><div class="org-node">Kepala Program Keahlian [DEMO]</div><div class="org-node">Kepala Tata Usaha [DEMO]</div></div><div class="org-row"><div class="org-node">Kurikulum</div><div class="org-node">Kesiswaan</div><div class="org-node">Hubungan Industri</div><div class="org-node">Sarana Prasarana</div></div></div><p>[DEMO] Bagan di atas adalah contoh. Admin dapat mengganti dengan struktur resmi.</p>',1),
('kepala-sekolah','Kepala Sekolah','Sambutan Kepala Sekolah','<p>Lihat sambutan pada bagian atas halaman. Teks sambutan dikelola melalui Pengaturan Situs.</p>',0),
('akademik','Akademik','Informasi akademik','<p>Pembelajaran di SMK Infokom memadukan teori dan praktik berbasis kompetensi. Rincian kurikulum, kalender pendidikan, UKK, sertifikasi, dan teaching factory tersedia pada halaman Kurikulum.</p>',0),
('kurikulum','Kurikulum','Kurikulum, kalender akademik, dan dokumen','<p>Kurikulum SMK Infokom dikembangkan berstandar nasional dan bersama dunia usaha dan industri.</p>',0),
('pkl','Praktik Kerja Lapangan (PKL)','Alur PKL siswa','<p>PKL adalah program wajib berupa praktik kerja di industri mitra untuk membangun kompetensi dan etos kerja.</p>',0),
('magang','Magang','Program magang','<p>Magang berbeda dari PKL: magang bersifat pengalaman kerja yang lebih panjang dan mendalam, dengan kesepakatan khusus antara siswa/lulusan, sekolah, dan mitra industri.</p>',0),
('bkk','BKK (Bursa Kerja Khusus)','Penyaluran lulusan ke dunia kerja','<p>BKK SMK Infokom menjembatani lulusan dengan perusahaan mitra melalui informasi lowongan, job fair, rekrutmen, dan tracer study.</p>',0),
('karier','Karier','Informasi karier lulusan','<p>Informasi karier, lowongan, dan jalur karier setiap jurusan untuk membantu lulusan merencanakan masa depan.</p>',0),
('tracer-alumni','Tracer Alumni','Pelacakan alumni','<p>Tracer alumni membantu sekolah memantau keterserapan lulusan di dunia kerja, perguruan tinggi, dan wirausaha. Alumni dapat memperbarui data melalui Humas sekolah.</p>',0);

INSERT INTO teachers (slug,name,position,education,field,subjects,bio,major_id,sort_order,is_demo) VALUES
('demo-guru-produktif-tkj','[DEMO] Guru Produktif TKJ','Guru Produktif','S1 [DEMO]','Teknik Komputer dan Jaringan','Administrasi Infrastruktur Jaringan','Profil contoh. Ganti melalui dashboard.',1,1,1),
('demo-guru-produktif-rpl','[DEMO] Guru Produktif RPL','Guru Produktif','S1 [DEMO]','Rekayasa Perangkat Lunak','Pemrograman Web','Profil contoh. Ganti melalui dashboard.',2,2,1),
('demo-guru-produktif-dkv','[DEMO] Guru Produktif DKV','Guru Produktif','S1 [DEMO]','Desain Komunikasi Visual','Desain Grafis','Profil contoh. Ganti melalui dashboard.',3,3,1),
('demo-guru-produktif-pspt','[DEMO] Guru Produktif PSPT','Guru Produktif','S1 [DEMO]','Produksi dan Siaran Program Televisi','Produksi Program TV','Profil contoh. Ganti melalui dashboard.',4,4,1);

INSERT INTO staff (slug,name,position,bio,sort_order,is_demo) VALUES
('demo-staff-tata-usaha','[DEMO] Staff Tata Usaha','Tata Usaha','Profil contoh. Ganti melalui dashboard.',1,1);

INSERT INTO programs (slug,title,summary,description,icon,sort_order,is_demo) VALUES
('pkl','PKL','Praktik Kerja Lapangan di industri mitra.','Siswa menjalani praktik kerja di dunia usaha dan industri sesuai kompetensi keahlian.','briefcase',1,0),
('magang','Magang','Pengalaman kerja lebih panjang bersama mitra.','Program magang untuk memperdalam keterampilan kerja.','building',2,1),
('teaching-factory','Teaching Factory','Pembelajaran berbasis produksi nyata.','[DEMO] Siswa mengerjakan proyek/produk nyata dengan standar industri.','factory',3,1),
('sertifikasi','Sertifikasi','Sertifikasi kompetensi siswa.','[DEMO] Uji kompetensi dan sertifikasi sesuai jurusan.','award',4,1),
('industry-class','Industry Class','Kelas bersama industri.','[DEMO] Pembelajaran khusus bersama mitra industri.','layers',5,1),
('guest-teacher','Guest Teacher','Praktisi industri mengajar di kelas.','[DEMO] Praktisi hadir berbagi pengalaman.','user-check',6,1),
('entrepreneurship','Entrepreneurship','Menyiapkan wirausahawan muda.','Sesuai misi sekolah, siswa dibekali kemampuan berwirausaha.','trending-up',7,0);

INSERT INTO curriculum (category,title,content,sort_order,is_demo) VALUES
('Kurikulum','Kurikulum Satuan Pendidikan','Kurikulum berstandar nasional yang dikembangkan bersama DU/DI.',1,0),
('Kalender','Kalender Akademik','Kalender pendidikan dipublikasikan oleh sekolah. Admin dapat mengunggah dokumen pada menu Dokumen.',2,0),
('Mata Pelajaran','Mata Pelajaran','Kelompok umum, dasar program keahlian, dan kompetensi keahlian.',3,0),
('Pembelajaran','Pembelajaran','Pembelajaran teori dan praktik berbasis kompetensi.',4,0),
('UKK','Uji Kompetensi Keahlian (UKK)','Uji kompetensi untuk kelas akhir bersama penguji industri.',5,0),
('Sertifikasi','Sertifikasi','Sertifikasi kompetensi sesuai jurusan.',6,1),
('Teaching Factory','Teaching Factory','Pembelajaran berbasis produksi.',7,1);

INSERT INTO facilities (name,category,description,sort_order,is_demo) VALUES
('Laboratorium TKJ','TKJ','Laboratorium praktik jaringan dan perakitan komputer.',1,1),
('Laboratorium RPL','RPL','Laboratorium pemrograman dan pengembangan aplikasi.',2,1),
('Laboratorium DKV','DKV','Laboratorium desain dan produksi karya visual.',3,1),
('Studio PSPT','Studio PSPT','Studio produksi dan penyiaran program televisi.',4,1),
('Perpustakaan','Perpustakaan','Koleksi buku dan ruang baca siswa.',5,1),
('Ruang Kelas','Ruang kelas','Ruang kelas untuk kegiatan pembelajaran.',6,1),
('Lapangan','Lapangan','Sarana olahraga dan upacara.',7,1),
('Tempat Ibadah','Tempat ibadah','Sarana ibadah warga sekolah.',8,1);

INSERT INTO achievements (title,team,major_id,competition,rank_title,level,category,year,description,is_demo) VALUES
('[DEMO] Prestasi Siswa',  '[DEMO] Tim Siswa',2,'[DEMO] Lomba Kompetensi Siswa','Juara 1','Kota','Akademik',2025,'Data contoh prestasi. Ganti melalui dashboard.',1);

INSERT INTO alumni (name,grad_year,major_id,job,company,college,testimonial,is_demo) VALUES
('[DEMO] Alumni SMK Infokom',2023,1,'Network Engineer','[DEMO] Mitra Industri',NULL,'Testimoni contoh. Ganti melalui dashboard.',1);

INSERT INTO organizations (name,type,description,leaders,work_programs,sort_order,is_demo) VALUES
('OSIS SMK Infokom','OSIS','Organisasi Siswa Intra Sekolah.','Ketua OSIS','Program kerja contoh.',1,1),
('MPK','MPK','Majelis Perwakilan Kelas.','Ketua MPK','[DEMO] Program kerja contoh.',2,1);

INSERT INTO extracurriculars (name,description,coach,schedule,place,is_demo) VALUES
('[DEMO] Ekstrakurikuler Contoh','Deskripsi contoh. Ganti melalui dashboard.','[DEMO] Pembina','[DEMO] Jumat 14:00','Sekolah',1);

INSERT INTO pkl (step_order,title,description,icon,is_demo) VALUES
(1,'Persiapan','Pembekalan siswa dan penyusunan program PKL.','clipboard',0),
(2,'Seleksi','Seleksi administrasi dan kesiapan siswa.','filter',0),
(3,'Penempatan','Penempatan siswa di industri mitra.','map-pin',0),
(4,'Pelaksanaan','Siswa bekerja dan belajar di industri.','briefcase',0),
(5,'Monitoring','Pemantauan oleh pembimbing sekolah dan industri.','eye',0),
(6,'Penilaian','Penilaian bersama sekolah dan industri.','check-square',0),
(7,'Sertifikat','Penerbitan sertifikat PKL.','award',0);

INSERT INTO internships (kind,title,description,sort_order,is_demo) VALUES
('informasi','Apa itu Magang','Magang adalah pengalaman kerja yang lebih panjang daripada PKL.',1,1),
('persyaratan','Persyaratan','[DEMO] Nilai kompetensi minimal, surat izin orang tua, dan rekomendasi sekolah.',2,1),
('proses','Proses','[DEMO] Pendaftaran, seleksi, penempatan, evaluasi.',3,1),
('timeline','Timeline','[DEMO] Pendaftaran satu bulan sebelum penempatan.',4,1);

INSERT INTO bkk (kind,title,content,sort_order,is_demo) VALUES
('profil','Profil BKK','BKK SMK Infokom menjembatani lulusan dengan dunia kerja.',1,0),
('jobfair','Job Fair','[DEMO] Jadwal job fair akan diumumkan.',2,1),
('rekrutmen','Rekrutmen','[DEMO] Rekrutmen oleh mitra industri.',3,1),
('tracer','Tracer Study','Tracer study memantau keterserapan lulusan.',4,0);

INSERT INTO companies (name,industry,location,cooperation,is_pkl,is_magang,is_recruit,since_year,is_demo) VALUES
('[DEMO] Mitra Industri A','Teknologi Informasi','Bogor','PKL & rekrutmen',1,0,1,2024,1),
('[DEMO] Mitra Industri B','Media & Penyiaran','Jakarta','PKL & magang',1,1,0,2024,1),
('[DEMO] Mitra Industri C','Desain & Kreatif','Bogor','Magang',0,1,0,2025,1);

INSERT INTO jobs (company,position,location,major_id,type,requirements,deadline,link,is_demo) VALUES
('[DEMO] Mitra Industri A','Teknisi Jaringan','Bogor',1,'Full-time','Lulusan SMK TKJ, bersedia belajar.',DATE_ADD(CURDATE(), INTERVAL 30 DAY),NULL,1);

INSERT INTO news_categories (name,slug) VALUES ('Berita Sekolah','berita-sekolah'),('Prestasi','prestasi'),('PPDB','ppdb');

INSERT INTO news (title,slug,category_id,excerpt,content,is_featured,is_demo,published_at) VALUES
('[DEMO] Selamat Datang di Website SMK Infokom','demo-selamat-datang',1,'Berita contoh untuk menunjukkan tampilan.','<p>Ini berita contoh. Admin dapat menghapus atau menggantinya melalui dashboard.</p>',1,1,NOW());

INSERT INTO galleries (title,category,description,event_date,is_demo) VALUES
('[DEMO] Kegiatan Sekolah','Kegiatan','Album contoh. Unggah foto melalui dashboard.',CURDATE(),1);

INSERT INTO videos (title,youtube_url,description,is_demo) VALUES
('[DEMO] Video Profil','https://www.youtube.com/watch?v=dQw4w9WgXcQ','Video contoh. Ganti dengan video resmi sekolah.',1);

INSERT INTO announcements (title,body,link,show_in_bar,is_demo) VALUES
('Informasi PPDB SMK Infokom dibuka. Cek jadwal dan persyaratan.','Pendaftaran peserta didik baru dapat dilakukan online.','/ppdb',1,0);

INSERT INTO agenda (title,description,location,start_date,is_demo) VALUES
('[DEMO] Open House','Agenda contoh.','SMK Infokom',DATE_ADD(CURDATE(), INTERVAL 14 DAY),1);

INSERT INTO faq (scope,question,answer,sort_order,is_demo) VALUES
('ppdb','Bagaimana cara mendaftar PPDB?','Isi formulir pendaftaran online pada halaman PPDB, lalu unduh bukti pendaftaran dalam bentuk PDF.',1,0),
('ppdb','Jurusan apa saja yang tersedia?','TKJ, RPL, DKV, dan PSPT.',2,0),
('ppdb','Apakah ada biaya pendaftaran?','[DEMO] Informasi biaya diatur admin pada pengaturan PPDB.',3,1);

INSERT INTO documents (title,category,is_demo) VALUES ('[DEMO] Kalender Akademik','Akademik',1);

INSERT INTO ppdb_settings (id,is_open,info,requirements,fees,flow,closed_message) VALUES
(1,1,'Penerimaan peserta didik baru SMK Infokom Kota Bogor untuk jurusan TKJ, RPL, DKV, dan PSPT.','Fotokopi ijazah/SKL
Fotokopi Kartu Keluarga
Pas foto terbaru
NISN','[DEMO] Informasi biaya akan diumumkan oleh panitia.','Isi formulir
Unggah foto
Unduh bukti pendaftaran
Verifikasi berkas di sekolah','Pendaftaran PPDB sedang ditutup.');

INSERT INTO ppdb_periods (name,start_date,end_date,description,is_active,is_demo) VALUES
('[DEMO] Gelombang 1',CURDATE(),DATE_ADD(CURDATE(), INTERVAL 60 DAY),'Periode contoh. Atur melalui dashboard PPDB.',1,1);

INSERT INTO seo_metadata (page_key,title,description) VALUES
('home','SMK Infokom Kota Bogor — TKJ, RPL, DKV, PSPT','Website profil resmi SMK Infokom Kota Bogor.'),
('ppdb','PPDB SMK Infokom Kota Bogor','Informasi dan pendaftaran online PPDB SMK Infokom Kota Bogor.');

INSERT INTO navigation (id,name,url,parent_id,sort_order) VALUES
(1,'Home','/',0,1),(2,'Profil','',0,2),(3,'Akademik','',0,3),(4,'Kesiswaan','',0,4),(5,'Fasilitas','/fasilitas',0,5),(6,'Industri & Karier','',0,6),(7,'Informasi','',0,7),(8,'PPDB','/ppdb',0,8),(9,'Kontak','/kontak',0,9);
INSERT INTO navigation (name,url,parent_id,sort_order) VALUES
('Tentang Sekolah','/profil/tentang-sekolah',2,1),('Sejarah','/profil/sejarah',2,2),('Visi & Misi','/profil/visi-misi',2,3),('Tujuan','/profil/tujuan',2,4),('Struktur Organisasi','/profil/struktur-organisasi',2,5),('Kepala Sekolah','/profil/kepala-sekolah',2,6),('Guru & Staff','/profil/guru-staff',2,7),
('Akademik','/akademik',3,1),('Kurikulum','/akademik/kurikulum',3,2),('Jurusan','/jurusan',3,3),('Program','/program',3,4),('PKL','/pkl',3,5),('Magang','/magang',3,6),
('Organisasi','/organisasi',4,1),('Ekstrakurikuler','/ekstrakurikuler',4,2),('Prestasi','/prestasi',4,3),('Alumni','/alumni',4,4),
('BKK','/bkk',6,1),('Lowongan','/karier#lowongan',6,2),('Mitra','/mitra',6,3),('Kunjungan Industri','/kunjungan-industri',6,4),('Karier','/karier',6,5),
('Berita','/berita',7,1),('Pengumuman','/pengumuman',7,2),('Galeri','/galeri',7,3),('Video','/video',7,4),('Agenda','/agenda',7,5);


-- ===== Pembaruan 22 Okt 2026 (migrasi-2026-10-22.sql) =====
-- ============================================================
-- Migrasi 22 Okt 2026 — SMK Infokom Kota Bogor
-- Aman dijalankan berulang kali (idempotent). Data yang ada TIDAK dihapus,
-- kecuali baris organisasi "MPK" (sesuai permintaan).
-- Jalankan di phpMyAdmin → pilih database smk_infokom_bogor → tab SQL / Import.
-- ============================================================

-- 1) Galeri: dukung video (file / link YouTube, TikTok, Instagram)
SET @s = (SELECT IF(COUNT(*)=0, 'ALTER TABLE `gallery_items` ADD COLUMN `media_type` VARCHAR(12) NOT NULL DEFAULT 'image' AFTER `gallery_id`', 'SELECT 1') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='gallery_items' AND COLUMN_NAME='media_type');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;
SET @s = (SELECT IF(COUNT(*)=0, 'ALTER TABLE `gallery_items` ADD COLUMN `video_path` VARCHAR(255) NULL DEFAULT NULL', 'SELECT 1') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='gallery_items' AND COLUMN_NAME='video_path');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;
SET @s = (SELECT IF(COUNT(*)=0, 'ALTER TABLE `gallery_items` ADD COLUMN `video_url` VARCHAR(500) NULL DEFAULT NULL', 'SELECT 1') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='gallery_items' AND COLUMN_NAME='video_url');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;
ALTER TABLE `gallery_items` MODIFY `image` VARCHAR(255) NULL DEFAULT NULL;

-- 2) Magang: tabel dokumentasi foto & video (YouTube / Instagram)
CREATE TABLE IF NOT EXISTS `internship_media` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `media_type` varchar(12) NOT NULL DEFAULT 'image',
  `image` varchar(255) DEFAULT NULL,
  `video_path` varchar(255) DEFAULT NULL,
  `video_url` varchar(500) DEFAULT NULL,
  `caption` varchar(200) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `internship_media` (`media_type`,`video_url`,`caption`,`sort_order`,`is_active`)
SELECT 'video_url','https://www.instagram.com/reel/DZGAwIkSZYa/','Reels pemberangkatan magang (1)',1,1 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `internship_media` WHERE `video_url`='https://www.instagram.com/reel/DZGAwIkSZYa/');
INSERT INTO `internship_media` (`media_type`,`video_url`,`caption`,`sort_order`,`is_active`)
SELECT 'video_url','https://www.instagram.com/reel/DZF46soytMP/','Reels pemberangkatan magang (2)',2,1 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `internship_media` WHERE `video_url`='https://www.instagram.com/reel/DZF46soytMP/');
INSERT INTO `internship_media` (`media_type`,`video_url`,`caption`,`sort_order`,`is_active`)
SELECT 'video_url','https://www.instagram.com/p/Dasw_tdEmFI/','Galeri foto keberangkatan magang',3,1 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `internship_media` WHERE `video_url`='https://www.instagram.com/p/Dasw_tdEmFI/');

-- 3) PPDB: opsi "otomatis diterima" (default MATI) untuk halaman Cek Status
SET @s = (SELECT IF(COUNT(*)=0, 'ALTER TABLE `ppdb_settings` ADD COLUMN `auto_accept` TINYINT(1) NOT NULL DEFAULT 0', 'SELECT 1') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ppdb_settings' AND COLUMN_NAME='auto_accept');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- 4) Halaman Sejarah
UPDATE `pages` SET `content`='<h2>Sekilas Sejarah</h2><h3>2006 — Awal Berdiri</h3><p>SMK INFOKOM didirikan dengan fokus awal pada bidang teknologi informasi.</p><h3>2010 — Penambahan Jurusan</h3><p>Membuka jurusan baru untuk menjawab kebutuhan industri kreatif &amp; media.</p><h3>2018 — Akreditasi A</h3><p>Meraih akreditasi A, menandai standar kualitas pendidikan yang terus meningkat.</p><h3>2026 — Sekarang</h3><p>900+ siswa aktif, kerja sama industri dalam &amp; luar negeri terus berkembang.</p>', `is_demo`=0 WHERE `slug`='sejarah';

-- 5) Statistik beranda (Siswa 900+, Guru 32, Staff 12, Prestasi 5, Mitra 30+)
UPDATE `school_statistics` SET `value`=900, `suffix`='+', `is_demo`=0 WHERE `label`='Siswa';
UPDATE `school_statistics` SET `value`=32, `suffix`='', `is_demo`=0 WHERE `label`='Guru';
UPDATE `school_statistics` SET `value`=12, `suffix`='', `is_demo`=0 WHERE `label`='Staff';
UPDATE `school_statistics` SET `value`=5, `suffix`='', `is_demo`=0 WHERE `label`='Prestasi';
UPDATE `school_statistics` SET `value`=30, `suffix`='+', `is_demo`=0 WHERE `label`='Mitra';

-- 6) Hapus MPK
DELETE FROM `organizations` WHERE `type`='MPK' OR `name`='MPK';

-- 7) Hapus teks "[DEMO]" dari isi data (barisnya TIDAK dihapus)
UPDATE `achievements` SET `title`=TRIM(REPLACE(`title`,'[DEMO]','')) WHERE `title` LIKE '%[DEMO]%';
UPDATE `achievements` SET `team`=TRIM(REPLACE(`team`,'[DEMO]','')) WHERE `team` LIKE '%[DEMO]%';
UPDATE `achievements` SET `competition`=TRIM(REPLACE(`competition`,'[DEMO]','')) WHERE `competition` LIKE '%[DEMO]%';
UPDATE `achievements` SET `rank_title`=TRIM(REPLACE(`rank_title`,'[DEMO]','')) WHERE `rank_title` LIKE '%[DEMO]%';
UPDATE `achievements` SET `level`=TRIM(REPLACE(`level`,'[DEMO]','')) WHERE `level` LIKE '%[DEMO]%';
UPDATE `achievements` SET `category`=TRIM(REPLACE(`category`,'[DEMO]','')) WHERE `category` LIKE '%[DEMO]%';
UPDATE `achievements` SET `image`=TRIM(REPLACE(`image`,'[DEMO]','')) WHERE `image` LIKE '%[DEMO]%';
UPDATE `achievements` SET `certificate`=TRIM(REPLACE(`certificate`,'[DEMO]','')) WHERE `certificate` LIKE '%[DEMO]%';
UPDATE `achievements` SET `description`=TRIM(REPLACE(`description`,'[DEMO]','')) WHERE `description` LIKE '%[DEMO]%';
UPDATE `agenda` SET `title`=TRIM(REPLACE(`title`,'[DEMO]','')) WHERE `title` LIKE '%[DEMO]%';
UPDATE `agenda` SET `description`=TRIM(REPLACE(`description`,'[DEMO]','')) WHERE `description` LIKE '%[DEMO]%';
UPDATE `agenda` SET `location`=TRIM(REPLACE(`location`,'[DEMO]','')) WHERE `location` LIKE '%[DEMO]%';
UPDATE `alumni` SET `name`=TRIM(REPLACE(`name`,'[DEMO]','')) WHERE `name` LIKE '%[DEMO]%';
UPDATE `alumni` SET `photo`=TRIM(REPLACE(`photo`,'[DEMO]','')) WHERE `photo` LIKE '%[DEMO]%';
UPDATE `alumni` SET `job`=TRIM(REPLACE(`job`,'[DEMO]','')) WHERE `job` LIKE '%[DEMO]%';
UPDATE `alumni` SET `company`=TRIM(REPLACE(`company`,'[DEMO]','')) WHERE `company` LIKE '%[DEMO]%';
UPDATE `alumni` SET `college`=TRIM(REPLACE(`college`,'[DEMO]','')) WHERE `college` LIKE '%[DEMO]%';
UPDATE `alumni` SET `entrepreneur`=TRIM(REPLACE(`entrepreneur`,'[DEMO]','')) WHERE `entrepreneur` LIKE '%[DEMO]%';
UPDATE `alumni` SET `testimonial`=TRIM(REPLACE(`testimonial`,'[DEMO]','')) WHERE `testimonial` LIKE '%[DEMO]%';
UPDATE `announcements` SET `title`=TRIM(REPLACE(`title`,'[DEMO]','')) WHERE `title` LIKE '%[DEMO]%';
UPDATE `announcements` SET `body`=TRIM(REPLACE(`body`,'[DEMO]','')) WHERE `body` LIKE '%[DEMO]%';
UPDATE `announcements` SET `link`=TRIM(REPLACE(`link`,'[DEMO]','')) WHERE `link` LIKE '%[DEMO]%';
UPDATE `bkk` SET `kind`=TRIM(REPLACE(`kind`,'[DEMO]','')) WHERE `kind` LIKE '%[DEMO]%';
UPDATE `bkk` SET `title`=TRIM(REPLACE(`title`,'[DEMO]','')) WHERE `title` LIKE '%[DEMO]%';
UPDATE `bkk` SET `content`=TRIM(REPLACE(`content`,'[DEMO]','')) WHERE `content` LIKE '%[DEMO]%';
UPDATE `companies` SET `name`=TRIM(REPLACE(`name`,'[DEMO]','')) WHERE `name` LIKE '%[DEMO]%';
UPDATE `companies` SET `logo`=TRIM(REPLACE(`logo`,'[DEMO]','')) WHERE `logo` LIKE '%[DEMO]%';
UPDATE `companies` SET `industry`=TRIM(REPLACE(`industry`,'[DEMO]','')) WHERE `industry` LIKE '%[DEMO]%';
UPDATE `companies` SET `website`=TRIM(REPLACE(`website`,'[DEMO]','')) WHERE `website` LIKE '%[DEMO]%';
UPDATE `companies` SET `location`=TRIM(REPLACE(`location`,'[DEMO]','')) WHERE `location` LIKE '%[DEMO]%';
UPDATE `companies` SET `cooperation`=TRIM(REPLACE(`cooperation`,'[DEMO]','')) WHERE `cooperation` LIKE '%[DEMO]%';
UPDATE `company_partnerships` SET `type`=TRIM(REPLACE(`type`,'[DEMO]','')) WHERE `type` LIKE '%[DEMO]%';
UPDATE `company_partnerships` SET `note`=TRIM(REPLACE(`note`,'[DEMO]','')) WHERE `note` LIKE '%[DEMO]%';
UPDATE `curriculum` SET `category`=TRIM(REPLACE(`category`,'[DEMO]','')) WHERE `category` LIKE '%[DEMO]%';
UPDATE `curriculum` SET `title`=TRIM(REPLACE(`title`,'[DEMO]','')) WHERE `title` LIKE '%[DEMO]%';
UPDATE `curriculum` SET `content`=TRIM(REPLACE(`content`,'[DEMO]','')) WHERE `content` LIKE '%[DEMO]%';
UPDATE `documents` SET `title`=TRIM(REPLACE(`title`,'[DEMO]','')) WHERE `title` LIKE '%[DEMO]%';
UPDATE `documents` SET `category`=TRIM(REPLACE(`category`,'[DEMO]','')) WHERE `category` LIKE '%[DEMO]%';
UPDATE `documents` SET `file_path`=TRIM(REPLACE(`file_path`,'[DEMO]','')) WHERE `file_path` LIKE '%[DEMO]%';
UPDATE `extracurriculars` SET `name`=TRIM(REPLACE(`name`,'[DEMO]','')) WHERE `name` LIKE '%[DEMO]%';
UPDATE `extracurriculars` SET `logo`=TRIM(REPLACE(`logo`,'[DEMO]','')) WHERE `logo` LIKE '%[DEMO]%';
UPDATE `extracurriculars` SET `description`=TRIM(REPLACE(`description`,'[DEMO]','')) WHERE `description` LIKE '%[DEMO]%';
UPDATE `extracurriculars` SET `coach`=TRIM(REPLACE(`coach`,'[DEMO]','')) WHERE `coach` LIKE '%[DEMO]%';
UPDATE `extracurriculars` SET `schedule`=TRIM(REPLACE(`schedule`,'[DEMO]','')) WHERE `schedule` LIKE '%[DEMO]%';
UPDATE `extracurriculars` SET `place`=TRIM(REPLACE(`place`,'[DEMO]','')) WHERE `place` LIKE '%[DEMO]%';
UPDATE `extracurriculars` SET `achievements`=TRIM(REPLACE(`achievements`,'[DEMO]','')) WHERE `achievements` LIKE '%[DEMO]%';
UPDATE `extracurriculars` SET `image`=TRIM(REPLACE(`image`,'[DEMO]','')) WHERE `image` LIKE '%[DEMO]%';
UPDATE `facilities` SET `name`=TRIM(REPLACE(`name`,'[DEMO]','')) WHERE `name` LIKE '%[DEMO]%';
UPDATE `facilities` SET `category`=TRIM(REPLACE(`category`,'[DEMO]','')) WHERE `category` LIKE '%[DEMO]%';
UPDATE `facilities` SET `description`=TRIM(REPLACE(`description`,'[DEMO]','')) WHERE `description` LIKE '%[DEMO]%';
UPDATE `facilities` SET `image`=TRIM(REPLACE(`image`,'[DEMO]','')) WHERE `image` LIKE '%[DEMO]%';
UPDATE `faq` SET `scope`=TRIM(REPLACE(`scope`,'[DEMO]','')) WHERE `scope` LIKE '%[DEMO]%';
UPDATE `faq` SET `question`=TRIM(REPLACE(`question`,'[DEMO]','')) WHERE `question` LIKE '%[DEMO]%';
UPDATE `faq` SET `answer`=TRIM(REPLACE(`answer`,'[DEMO]','')) WHERE `answer` LIKE '%[DEMO]%';
UPDATE `galleries` SET `title`=TRIM(REPLACE(`title`,'[DEMO]','')) WHERE `title` LIKE '%[DEMO]%';
UPDATE `galleries` SET `category`=TRIM(REPLACE(`category`,'[DEMO]','')) WHERE `category` LIKE '%[DEMO]%';
UPDATE `galleries` SET `description`=TRIM(REPLACE(`description`,'[DEMO]','')) WHERE `description` LIKE '%[DEMO]%';
UPDATE `galleries` SET `cover`=TRIM(REPLACE(`cover`,'[DEMO]','')) WHERE `cover` LIKE '%[DEMO]%';
UPDATE `gallery_items` SET `image`=TRIM(REPLACE(`image`,'[DEMO]','')) WHERE `image` LIKE '%[DEMO]%';
UPDATE `gallery_items` SET `caption`=TRIM(REPLACE(`caption`,'[DEMO]','')) WHERE `caption` LIKE '%[DEMO]%';
UPDATE `industry_visits` SET `title`=TRIM(REPLACE(`title`,'[DEMO]','')) WHERE `title` LIKE '%[DEMO]%';
UPDATE `industry_visits` SET `company`=TRIM(REPLACE(`company`,'[DEMO]','')) WHERE `company` LIKE '%[DEMO]%';
UPDATE `industry_visits` SET `location`=TRIM(REPLACE(`location`,'[DEMO]','')) WHERE `location` LIKE '%[DEMO]%';
UPDATE `industry_visits` SET `participants`=TRIM(REPLACE(`participants`,'[DEMO]','')) WHERE `participants` LIKE '%[DEMO]%';
UPDATE `industry_visits` SET `description`=TRIM(REPLACE(`description`,'[DEMO]','')) WHERE `description` LIKE '%[DEMO]%';
UPDATE `industry_visits` SET `learnings`=TRIM(REPLACE(`learnings`,'[DEMO]','')) WHERE `learnings` LIKE '%[DEMO]%';
UPDATE `industry_visits` SET `image`=TRIM(REPLACE(`image`,'[DEMO]','')) WHERE `image` LIKE '%[DEMO]%';
UPDATE `internships` SET `kind`=TRIM(REPLACE(`kind`,'[DEMO]','')) WHERE `kind` LIKE '%[DEMO]%';
UPDATE `internships` SET `title`=TRIM(REPLACE(`title`,'[DEMO]','')) WHERE `title` LIKE '%[DEMO]%';
UPDATE `internships` SET `description`=TRIM(REPLACE(`description`,'[DEMO]','')) WHERE `description` LIKE '%[DEMO]%';
UPDATE `jobs` SET `company`=TRIM(REPLACE(`company`,'[DEMO]','')) WHERE `company` LIKE '%[DEMO]%';
UPDATE `jobs` SET `position`=TRIM(REPLACE(`position`,'[DEMO]','')) WHERE `position` LIKE '%[DEMO]%';
UPDATE `jobs` SET `location`=TRIM(REPLACE(`location`,'[DEMO]','')) WHERE `location` LIKE '%[DEMO]%';
UPDATE `jobs` SET `type`=TRIM(REPLACE(`type`,'[DEMO]','')) WHERE `type` LIKE '%[DEMO]%';
UPDATE `jobs` SET `requirements`=TRIM(REPLACE(`requirements`,'[DEMO]','')) WHERE `requirements` LIKE '%[DEMO]%';
UPDATE `jobs` SET `link`=TRIM(REPLACE(`link`,'[DEMO]','')) WHERE `link` LIKE '%[DEMO]%';
UPDATE `majors` SET `code`=TRIM(REPLACE(`code`,'[DEMO]','')) WHERE `code` LIKE '%[DEMO]%';
UPDATE `majors` SET `slug`=TRIM(REPLACE(`slug`,'[DEMO]','')) WHERE `slug` LIKE '%[DEMO]%';
UPDATE `majors` SET `name`=TRIM(REPLACE(`name`,'[DEMO]','')) WHERE `name` LIKE '%[DEMO]%';
UPDATE `majors` SET `short_desc`=TRIM(REPLACE(`short_desc`,'[DEMO]','')) WHERE `short_desc` LIKE '%[DEMO]%';
UPDATE `majors` SET `description`=TRIM(REPLACE(`description`,'[DEMO]','')) WHERE `description` LIKE '%[DEMO]%';
UPDATE `majors` SET `competencies`=TRIM(REPLACE(`competencies`,'[DEMO]','')) WHERE `competencies` LIKE '%[DEMO]%';
UPDATE `majors` SET `materials`=TRIM(REPLACE(`materials`,'[DEMO]','')) WHERE `materials` LIKE '%[DEMO]%';
UPDATE `majors` SET `practices`=TRIM(REPLACE(`practices`,'[DEMO]','')) WHERE `practices` LIKE '%[DEMO]%';
UPDATE `majors` SET `facilities_text`=TRIM(REPLACE(`facilities_text`,'[DEMO]','')) WHERE `facilities_text` LIKE '%[DEMO]%';
UPDATE `majors` SET `career`=TRIM(REPLACE(`career`,'[DEMO]','')) WHERE `career` LIKE '%[DEMO]%';
UPDATE `majors` SET `certifications`=TRIM(REPLACE(`certifications`,'[DEMO]','')) WHERE `certifications` LIKE '%[DEMO]%';
UPDATE `majors` SET `activities`=TRIM(REPLACE(`activities`,'[DEMO]','')) WHERE `activities` LIKE '%[DEMO]%';
UPDATE `majors` SET `cover`=TRIM(REPLACE(`cover`,'[DEMO]','')) WHERE `cover` LIKE '%[DEMO]%';
UPDATE `majors` SET `logo`=TRIM(REPLACE(`logo`,'[DEMO]','')) WHERE `logo` LIKE '%[DEMO]%';
UPDATE `majors` SET `icon`=TRIM(REPLACE(`icon`,'[DEMO]','')) WHERE `icon` LIKE '%[DEMO]%';
UPDATE `major_subjects` SET `name`=TRIM(REPLACE(`name`,'[DEMO]','')) WHERE `name` LIKE '%[DEMO]%';
UPDATE `major_subjects` SET `grade`=TRIM(REPLACE(`grade`,'[DEMO]','')) WHERE `grade` LIKE '%[DEMO]%';
UPDATE `news` SET `title`=TRIM(REPLACE(`title`,'[DEMO]','')) WHERE `title` LIKE '%[DEMO]%';
UPDATE `news` SET `slug`=TRIM(REPLACE(`slug`,'[DEMO]','')) WHERE `slug` LIKE '%[DEMO]%';
UPDATE `news` SET `excerpt`=TRIM(REPLACE(`excerpt`,'[DEMO]','')) WHERE `excerpt` LIKE '%[DEMO]%';
UPDATE `news` SET `content`=TRIM(REPLACE(`content`,'[DEMO]','')) WHERE `content` LIKE '%[DEMO]%';
UPDATE `news` SET `image`=TRIM(REPLACE(`image`,'[DEMO]','')) WHERE `image` LIKE '%[DEMO]%';
UPDATE `news_categories` SET `name`=TRIM(REPLACE(`name`,'[DEMO]','')) WHERE `name` LIKE '%[DEMO]%';
UPDATE `news_categories` SET `slug`=TRIM(REPLACE(`slug`,'[DEMO]','')) WHERE `slug` LIKE '%[DEMO]%';
UPDATE `organizations` SET `name`=TRIM(REPLACE(`name`,'[DEMO]','')) WHERE `name` LIKE '%[DEMO]%';
UPDATE `organizations` SET `type`=TRIM(REPLACE(`type`,'[DEMO]','')) WHERE `type` LIKE '%[DEMO]%';
UPDATE `organizations` SET `description`=TRIM(REPLACE(`description`,'[DEMO]','')) WHERE `description` LIKE '%[DEMO]%';
UPDATE `organizations` SET `leaders`=TRIM(REPLACE(`leaders`,'[DEMO]','')) WHERE `leaders` LIKE '%[DEMO]%';
UPDATE `organizations` SET `work_programs`=TRIM(REPLACE(`work_programs`,'[DEMO]','')) WHERE `work_programs` LIKE '%[DEMO]%';
UPDATE `organizations` SET `logo`=TRIM(REPLACE(`logo`,'[DEMO]','')) WHERE `logo` LIKE '%[DEMO]%';
UPDATE `pages` SET `slug`=TRIM(REPLACE(`slug`,'[DEMO]','')) WHERE `slug` LIKE '%[DEMO]%';
UPDATE `pages` SET `title`=TRIM(REPLACE(`title`,'[DEMO]','')) WHERE `title` LIKE '%[DEMO]%';
UPDATE `pages` SET `excerpt`=TRIM(REPLACE(`excerpt`,'[DEMO]','')) WHERE `excerpt` LIKE '%[DEMO]%';
UPDATE `pages` SET `content`=TRIM(REPLACE(`content`,'[DEMO]','')) WHERE `content` LIKE '%[DEMO]%';
UPDATE `pages` SET `image`=TRIM(REPLACE(`image`,'[DEMO]','')) WHERE `image` LIKE '%[DEMO]%';
UPDATE `pkl` SET `title`=TRIM(REPLACE(`title`,'[DEMO]','')) WHERE `title` LIKE '%[DEMO]%';
UPDATE `pkl` SET `description`=TRIM(REPLACE(`description`,'[DEMO]','')) WHERE `description` LIKE '%[DEMO]%';
UPDATE `pkl` SET `icon`=TRIM(REPLACE(`icon`,'[DEMO]','')) WHERE `icon` LIKE '%[DEMO]%';
UPDATE `ppdb_periods` SET `name`=TRIM(REPLACE(`name`,'[DEMO]','')) WHERE `name` LIKE '%[DEMO]%';
UPDATE `ppdb_periods` SET `description`=TRIM(REPLACE(`description`,'[DEMO]','')) WHERE `description` LIKE '%[DEMO]%';
UPDATE `ppdb_settings` SET `info`=TRIM(REPLACE(`info`,'[DEMO]','')) WHERE `info` LIKE '%[DEMO]%';
UPDATE `ppdb_settings` SET `requirements`=TRIM(REPLACE(`requirements`,'[DEMO]','')) WHERE `requirements` LIKE '%[DEMO]%';
UPDATE `ppdb_settings` SET `fees`=TRIM(REPLACE(`fees`,'[DEMO]','')) WHERE `fees` LIKE '%[DEMO]%';
UPDATE `ppdb_settings` SET `flow`=TRIM(REPLACE(`flow`,'[DEMO]','')) WHERE `flow` LIKE '%[DEMO]%';
UPDATE `ppdb_settings` SET `closed_message`=TRIM(REPLACE(`closed_message`,'[DEMO]','')) WHERE `closed_message` LIKE '%[DEMO]%';
UPDATE `programs` SET `slug`=TRIM(REPLACE(`slug`,'[DEMO]','')) WHERE `slug` LIKE '%[DEMO]%';
UPDATE `programs` SET `title`=TRIM(REPLACE(`title`,'[DEMO]','')) WHERE `title` LIKE '%[DEMO]%';
UPDATE `programs` SET `summary`=TRIM(REPLACE(`summary`,'[DEMO]','')) WHERE `summary` LIKE '%[DEMO]%';
UPDATE `programs` SET `description`=TRIM(REPLACE(`description`,'[DEMO]','')) WHERE `description` LIKE '%[DEMO]%';
UPDATE `programs` SET `icon`=TRIM(REPLACE(`icon`,'[DEMO]','')) WHERE `icon` LIKE '%[DEMO]%';
UPDATE `programs` SET `image`=TRIM(REPLACE(`image`,'[DEMO]','')) WHERE `image` LIKE '%[DEMO]%';
UPDATE `school_statistics` SET `label`=TRIM(REPLACE(`label`,'[DEMO]','')) WHERE `label` LIKE '%[DEMO]%';
UPDATE `school_statistics` SET `suffix`=TRIM(REPLACE(`suffix`,'[DEMO]','')) WHERE `suffix` LIKE '%[DEMO]%';
UPDATE `school_statistics` SET `icon`=TRIM(REPLACE(`icon`,'[DEMO]','')) WHERE `icon` LIKE '%[DEMO]%';
UPDATE `seo_metadata` SET `page_key`=TRIM(REPLACE(`page_key`,'[DEMO]','')) WHERE `page_key` LIKE '%[DEMO]%';
UPDATE `seo_metadata` SET `title`=TRIM(REPLACE(`title`,'[DEMO]','')) WHERE `title` LIKE '%[DEMO]%';
UPDATE `seo_metadata` SET `description`=TRIM(REPLACE(`description`,'[DEMO]','')) WHERE `description` LIKE '%[DEMO]%';
UPDATE `seo_metadata` SET `og_image`=TRIM(REPLACE(`og_image`,'[DEMO]','')) WHERE `og_image` LIKE '%[DEMO]%';
UPDATE `site_settings` SET `key`=TRIM(REPLACE(`key`,'[DEMO]','')) WHERE `key` LIKE '%[DEMO]%';
UPDATE `site_settings` SET `value`=TRIM(REPLACE(`value`,'[DEMO]','')) WHERE `value` LIKE '%[DEMO]%';
UPDATE `site_settings` SET `group`=TRIM(REPLACE(`group`,'[DEMO]','')) WHERE `group` LIKE '%[DEMO]%';
UPDATE `staff` SET `slug`=TRIM(REPLACE(`slug`,'[DEMO]','')) WHERE `slug` LIKE '%[DEMO]%';
UPDATE `staff` SET `name`=TRIM(REPLACE(`name`,'[DEMO]','')) WHERE `name` LIKE '%[DEMO]%';
UPDATE `staff` SET `position`=TRIM(REPLACE(`position`,'[DEMO]','')) WHERE `position` LIKE '%[DEMO]%';
UPDATE `staff` SET `education`=TRIM(REPLACE(`education`,'[DEMO]','')) WHERE `education` LIKE '%[DEMO]%';
UPDATE `staff` SET `field`=TRIM(REPLACE(`field`,'[DEMO]','')) WHERE `field` LIKE '%[DEMO]%';
UPDATE `staff` SET `subjects`=TRIM(REPLACE(`subjects`,'[DEMO]','')) WHERE `subjects` LIKE '%[DEMO]%';
UPDATE `staff` SET `bio`=TRIM(REPLACE(`bio`,'[DEMO]','')) WHERE `bio` LIKE '%[DEMO]%';
UPDATE `staff` SET `photo`=TRIM(REPLACE(`photo`,'[DEMO]','')) WHERE `photo` LIKE '%[DEMO]%';
UPDATE `teachers` SET `slug`=TRIM(REPLACE(`slug`,'[DEMO]','')) WHERE `slug` LIKE '%[DEMO]%';
UPDATE `teachers` SET `name`=TRIM(REPLACE(`name`,'[DEMO]','')) WHERE `name` LIKE '%[DEMO]%';
UPDATE `teachers` SET `position`=TRIM(REPLACE(`position`,'[DEMO]','')) WHERE `position` LIKE '%[DEMO]%';
UPDATE `teachers` SET `education`=TRIM(REPLACE(`education`,'[DEMO]','')) WHERE `education` LIKE '%[DEMO]%';
UPDATE `teachers` SET `field`=TRIM(REPLACE(`field`,'[DEMO]','')) WHERE `field` LIKE '%[DEMO]%';
UPDATE `teachers` SET `subjects`=TRIM(REPLACE(`subjects`,'[DEMO]','')) WHERE `subjects` LIKE '%[DEMO]%';
UPDATE `teachers` SET `bio`=TRIM(REPLACE(`bio`,'[DEMO]','')) WHERE `bio` LIKE '%[DEMO]%';
UPDATE `teachers` SET `photo`=TRIM(REPLACE(`photo`,'[DEMO]','')) WHERE `photo` LIKE '%[DEMO]%';
UPDATE `videos` SET `title`=TRIM(REPLACE(`title`,'[DEMO]','')) WHERE `title` LIKE '%[DEMO]%';
UPDATE `videos` SET `youtube_url`=TRIM(REPLACE(`youtube_url`,'[DEMO]','')) WHERE `youtube_url` LIKE '%[DEMO]%';
UPDATE `videos` SET `description`=TRIM(REPLACE(`description`,'[DEMO]','')) WHERE `description` LIKE '%[DEMO]%';
UPDATE `pages` SET `content`=REPLACE(`content`,' </div>','</div>') WHERE `slug`='struktur-organisasi';
