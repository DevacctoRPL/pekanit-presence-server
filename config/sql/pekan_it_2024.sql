-- Versi database: MariaDB 10.4.32
-- Dibuat pada: 09 Desember 2024

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- Database: pekan_it_2024
CREATE DATABASE IF NOT EXISTS pekan_it_2024;
USE pekan_it_2024;

-- Tabel Kelas
CREATE TABLE tbl_kelas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nama_kelas VARCHAR(255) UNIQUE NOT NULL 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Insert kelas data
INSERT INTO tbl_kelas (nama_kelas) VALUES
('X-RPL-1'), ('X-RPL-2'), ('X-TKJ-1'), ('X-TKJ-2'), ('X-TKJ-3'),
('X-DKV-1'), ('X-DKV-2'), ('X-DKV-3'), ('X-DKV-4'), ('X-LPB-1'), ('X-LPB-2'),
('XI-RPL-1'), ('XI-RPL-2'), ('XI-RPL-3'), ('XI-TKJ-1'), ('XI-TKJ-2'),
('XI-MM-1'), ('XI-MM-2'), ('XI-MM-3'), ('XI-MM-4'), ('XI-PKM-1'), ('XI-PKM-2'),
('XII-RPL-1'), ('XII-RPL-2'), ('XII-RPL-3'), ('XII-TKJ-1'), ('XII-TKJ-2'),
('XII-MM-1'), ('XII-MM-2'), ('XII-MM-3'), ('XII-MM-4'), ('XII-PKM-1'), ('XII-PKM-2');

-- Tabel Siswa (Tabel Induk)
CREATE TABLE tbl_siswa (
  nisn VARCHAR(255) PRIMARY KEY,
  nama VARCHAR(255) NOT NULL,
  kelas_id INT NOT NULL,
  FOREIGN KEY (kelas_id) REFERENCES tbl_kelas(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Login tables for each department and grade
CREATE TABLE tbl_login_x_rpl (
  nisn VARCHAR(255) NOT NULL,
  kelas_id INT NOT NULL,
  password VARCHAR(255) NOT NULL,
  FOREIGN KEY (nisn) REFERENCES tbl_siswa(nisn),
  FOREIGN KEY (kelas_id) REFERENCES tbl_kelas(id),
  UNIQUE KEY unique_siswa_login (nisn, kelas_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE tbl_login_xi_rpl (
  nisn VARCHAR(255) NOT NULL,
  kelas_id INT NOT NULL,
  password VARCHAR(255) NOT NULL,
  FOREIGN KEY (nisn) REFERENCES tbl_siswa(nisn),
  FOREIGN KEY (kelas_id) REFERENCES tbl_kelas(id),
  UNIQUE KEY unique_siswa_login (nisn, kelas_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE tbl_login_xii_rpl (
  nisn VARCHAR(255) NOT NULL,
  kelas_id INT NOT NULL,
  password VARCHAR(255) NOT NULL,
  FOREIGN KEY (nisn) REFERENCES tbl_siswa(nisn),
  FOREIGN KEY (kelas_id) REFERENCES tbl_kelas(id),
  UNIQUE KEY unique_siswa_login (nisn, kelas_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE tbl_login_x_tkj (
  nisn VARCHAR(255) NOT NULL,
  kelas_id INT NOT NULL,
  password VARCHAR(255) NOT NULL,
  FOREIGN KEY (nisn) REFERENCES tbl_siswa(nisn),
  FOREIGN KEY (kelas_id) REFERENCES tbl_kelas(id),
  UNIQUE KEY unique_siswa_login (nisn, kelas_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE tbl_login_xi_tkj (
  nisn VARCHAR(255) NOT NULL,
  kelas_id INT NOT NULL,
  password VARCHAR(255) NOT NULL,
  FOREIGN KEY (nisn) REFERENCES tbl_siswa(nisn),
  FOREIGN KEY (kelas_id) REFERENCES tbl_kelas(id),
  UNIQUE KEY unique_siswa_login (nisn, kelas_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE tbl_login_xii_tkj (
  nisn VARCHAR(255) NOT NULL,
  kelas_id INT NOT NULL,
  password VARCHAR(255) NOT NULL,
  FOREIGN KEY (nisn) REFERENCES tbl_siswa(nisn),
  FOREIGN KEY (kelas_id) REFERENCES tbl_kelas(id),
  UNIQUE KEY unique_siswa_login (nisn, kelas_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE tbl_login_x_mm (
  nisn VARCHAR(255) NOT NULL,
  kelas_id INT NOT NULL,
  password VARCHAR(255) NOT NULL,
  FOREIGN KEY (nisn) REFERENCES tbl_siswa(nisn),
  FOREIGN KEY (kelas_id) REFERENCES tbl_kelas(id),
  UNIQUE KEY unique_siswa_login (nisn, kelas_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE tbl_login_xi_mm (
  nisn VARCHAR(255) NOT NULL,
  kelas_id INT NOT NULL,
  password VARCHAR(255) NOT NULL,
  FOREIGN KEY (nisn) REFERENCES tbl_siswa(nisn),
  FOREIGN KEY (kelas_id) REFERENCES tbl_kelas(id),
  UNIQUE KEY unique_siswa_login (nisn, kelas_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE tbl_login_xii_mm (
  nisn VARCHAR(255) NOT NULL,
  kelas_id INT NOT NULL,
  password VARCHAR(255) NOT NULL,
  FOREIGN KEY (nisn) REFERENCES tbl_siswa(nisn),
  FOREIGN KEY (kelas_id) REFERENCES tbl_kelas(id),
  UNIQUE KEY unique_siswa_login (nisn, kelas_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE tbl_login_x_pkm (
  nisn VARCHAR(255) NOT NULL,
  kelas_id INT NOT NULL,
  password VARCHAR(255) NOT NULL,
  FOREIGN KEY (nisn) REFERENCES tbl_siswa(nisn),
  FOREIGN KEY (kelas_id) REFERENCES tbl_kelas(id),
  UNIQUE KEY unique_siswa_login (nisn, kelas_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE tbl_login_xi_pkm (
  nisn VARCHAR(255) NOT NULL,
  kelas_id INT NOT NULL,
  password VARCHAR(255) NOT NULL,
  FOREIGN KEY (nisn) REFERENCES tbl_siswa(nisn),
  FOREIGN KEY (kelas_id) REFERENCES tbl_kelas(id),
  UNIQUE KEY unique_siswa_login (nisn, kelas_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE tbl_login_xii_pkm (
  nisn VARCHAR(255) NOT NULL,
  kelas_id INT NOT NULL,
  password VARCHAR(255) NOT NULL,
  FOREIGN KEY (nisn) REFERENCES tbl_siswa(nisn),
  FOREIGN KEY (kelas_id) REFERENCES tbl_kelas(id),
  UNIQUE KEY unique_siswa_login (nisn, kelas_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Queue tables for each department and grade
CREATE TABLE tbl_queue_x_rpl (
  nisn VARCHAR(255) NOT NULL,
  nomor_antrian INT NOT NULL,
  kelas_id INT NOT NULL,
  tanggal_ambil DATE NOT NULL,
  status ENUM('menunggu', 'sedang_proses', 'selesai') DEFAULT 'menunggu',
  FOREIGN KEY (nisn) REFERENCES tbl_siswa(nisn),
  FOREIGN KEY (kelas_id) REFERENCES tbl_kelas(id),
  UNIQUE KEY unique_queue_per_date (nisn, tanggal_ambil, kelas_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE tbl_queue_xi_rpl (
  nisn VARCHAR(255) NOT NULL,
  nomor_antrian INT NOT NULL,
  kelas_id INT NOT NULL,
  tanggal_ambil DATE NOT NULL,
  status ENUM('menunggu', 'sedang_proses', 'selesai') DEFAULT 'menunggu',
  FOREIGN KEY (nisn) REFERENCES tbl_siswa(nisn),
  FOREIGN KEY (kelas_id) REFERENCES tbl_kelas(id),
  UNIQUE KEY unique_queue_per_date (nisn, tanggal_ambil, kelas_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE tbl_queue_xii_rpl (
  nisn VARCHAR(255) NOT NULL,
  nomor_antrian INT NOT NULL,
  kelas_id INT NOT NULL,
  tanggal_ambil DATE NOT NULL,
  status ENUM('menunggu', 'sedang_proses', 'selesai') DEFAULT 'menunggu',
  FOREIGN KEY (nisn) REFERENCES tbl_siswa(nisn),
  FOREIGN KEY (kelas_id) REFERENCES tbl_kelas(id),
  UNIQUE KEY unique_queue_per_date (nisn, tanggal_ambil, kelas_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE tbl_queue_x_tkj (
  nisn VARCHAR(255) NOT NULL,
  nomor_antrian INT NOT NULL,
  kelas_id INT NOT NULL,
  tanggal_ambil DATE NOT NULL,
  status ENUM('menunggu', 'sedang_proses', 'selesai') DEFAULT 'menunggu',
  FOREIGN KEY (nisn) REFERENCES tbl_siswa(nisn),
  FOREIGN KEY (kelas_id) REFERENCES tbl_kelas(id),
  UNIQUE KEY unique_queue_per_date (nisn, tanggal_ambil, kelas_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE tbl_queue_xi_tkj (
  nisn VARCHAR(255) NOT NULL,
  nomor_antrian INT NOT NULL,
  kelas_id INT NOT NULL,
  tanggal_ambil DATE NOT NULL,
  status ENUM('menunggu', 'sedang_proses', 'selesai') DEFAULT 'menunggu',
  FOREIGN KEY (nisn) REFERENCES tbl_siswa(nisn),
  FOREIGN KEY (kelas_id) REFERENCES tbl_kelas(id),
  UNIQUE KEY unique_queue_per_date (nisn, tanggal_ambil, kelas_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE tbl_queue_xii_tkj (
  nisn VARCHAR(255) NOT NULL,
  nomor_antrian INT NOT NULL,
  kelas_id INT NOT NULL,
  tanggal_ambil DATE NOT NULL,
  status ENUM('menunggu', 'sedang_proses', 'selesai') DEFAULT 'menunggu',
  FOREIGN KEY (nisn) REFERENCES tbl_siswa(nisn),
  FOREIGN KEY (kelas_id) REFERENCES tbl_kelas(id),
  UNIQUE KEY unique_queue_per_date (nisn, tanggal_ambil, kelas_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE tbl_queue_x_mm (
  nisn VARCHAR(255) NOT NULL,
  nomor_antrian INT NOT NULL,
  kelas_id INT NOT NULL,
  tanggal_ambil DATE NOT NULL,
  status ENUM('menunggu', 'sedang_proses', 'selesai') DEFAULT 'menunggu',
  FOREIGN KEY (nisn) REFERENCES tbl_siswa(nisn),
  FOREIGN KEY (kelas_id) REFERENCES tbl_kelas(id),
  UNIQUE KEY unique_queue_per_date (nisn, tanggal_ambil, kelas_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE tbl_queue_xi_mm (
  nisn VARCHAR(255) NOT NULL,
  nomor_antrian INT NOT NULL,
  kelas_id INT NOT NULL,
  tanggal_ambil DATE NOT NULL,
  status ENUM('menunggu', 'sedang_proses', 'selesai') DEFAULT 'menunggu',
  FOREIGN KEY (nisn) REFERENCES tbl_siswa(nisn),
  FOREIGN KEY (kelas_id) REFERENCES tbl_kelas(id),
  UNIQUE KEY unique_queue_per_date (nisn, tanggal_ambil, kelas_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE tbl_queue_xii_mm (
  nisn VARCHAR(255) NOT NULL,
  nomor_antrian INT NOT NULL,
  kelas_id INT NOT NULL,
  tanggal_ambil DATE NOT NULL,
  status ENUM('menunggu', 'sedang_proses', 'selesai') DEFAULT 'menunggu',
  FOREIGN KEY (nisn) REFERENCES tbl_siswa(nisn),
  FOREIGN KEY (kelas_id) REFERENCES tbl_kelas(id),
  UNIQUE KEY unique_queue_per_date (nisn, tanggal_ambil, kelas_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE tbl_queue_x_pkm (
  nisn VARCHAR(255) NOT NULL,
  nomor_antrian INT NOT NULL,
  kelas_id INT NOT NULL,
  tanggal_ambil DATE NOT NULL,
  status ENUM('menunggu', 'sedang_proses', 'selesai') DEFAULT 'menunggu',
  FOREIGN KEY (nisn) REFERENCES tbl_siswa(nisn),
  FOREIGN KEY (kelas_id) REFERENCES tbl_kelas(id),
  UNIQUE KEY unique_queue_per_date (nisn, tanggal_ambil, kelas_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE tbl_queue_xi_pkm (
  nisn VARCHAR(255) NOT NULL,
  nomor_antrian INT NOT NULL,
  kelas_id INT NOT NULL,
  tanggal_ambil DATE NOT NULL,
  status ENUM('menunggu', 'sedang_proses', 'selesai') DEFAULT 'menunggu',
  FOREIGN KEY (nisn) REFERENCES tbl_siswa(nisn),
  FOREIGN KEY (kelas_id) REFERENCES tbl_kelas(id),
  UNIQUE KEY unique_queue_per_date (nisn, tanggal_ambil, kelas_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE tbl_queue_xii_pkm (
  nisn VARCHAR(255) NOT NULL,
  nomor_antrian INT NOT NULL,
  kelas_id INT NOT NULL,
  tanggal_ambil DATE NOT NULL,
  status ENUM('menunggu', 'sedang_proses', 'selesai') DEFAULT 'menunggu',
  FOREIGN KEY (nisn) REFERENCES tbl_siswa(nisn),
  FOREIGN KEY (kelas_id) REFERENCES tbl_kelas(id),
  UNIQUE KEY unique_queue_per_date (nisn, tanggal_ambil, kelas_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Triggers for generating queue numbers
DELIMITER $$

CREATE TRIGGER generate_queue_number_x_rpl
BEFORE INSERT ON tbl_queue_x_rpl
FOR EACH ROW 
BEGIN
  SET NEW.nomor_antrian = (
    SELECT COALESCE(MAX(nomor_antrian), 0) + 1 
    FROM tbl_queue_x_rpl 
    WHERE tanggal_ambil = NEW.tanggal_ambil 
    AND kelas_id = NEW.kelas_id
  );
END$$

CREATE TRIGGER generate_queue_number_xi_rpl
BEFORE INSERT ON tbl_queue_xi_rpl
FOR EACH ROW 
BEGIN
  SET NEW.nomor_antrian = (
    SELECT COALESCE(MAX(nomor_antrian), 0) + 1 
    FROM tbl_queue_xi_rpl 
    WHERE tanggal_ambil = NEW.tanggal_ambil 
    AND kelas_id = NEW.kelas_id
  );
END$$

CREATE TRIGGER generate_queue_number_xii_rpl
BEFORE INSERT ON tbl_queue_xii_rpl
FOR EACH ROW 
BEGIN
  SET NEW.nomor_antrian = (
    SELECT COALESCE(MAX(nomor_antrian), 0) + 1 
    FROM tbl_queue_xii_rpl 
    WHERE tanggal_ambil = NEW.tanggal_ambil 
    AND kelas_id = NEW.kelas_id
  );
END$$

CREATE TRIGGER generate_queue_number_x_tkj
BEFORE INSERT ON tbl_queue_x_tkj
FOR EACH ROW 
BEGIN
  SET NEW.nomor_antrian = (
    SELECT COALESCE(MAX(nomor_antrian), 0) + 1 
    FROM tbl_queue_x_tkj 
    WHERE tanggal_ambil = NEW.tanggal_ambil 
    AND kelas_id = NEW.kelas_id
  );
END$$

CREATE TRIGGER generate_queue_number_xi_tkj
BEFORE INSERT ON tbl_queue_xi_tkj
FOR EACH ROW 
BEGIN
  SET NEW.nomor_antrian = (
    SELECT COALESCE(MAX(nomor_antrian), 0) + 1 
    FROM tbl_queue_xi_tkj 
    WHERE tanggal_ambil = NEW.tanggal_ambil 
    AND kelas_id = NEW.kelas_id
  );
END$$

CREATE TRIGGER generate_queue_number_xii_tkj
BEFORE INSERT ON tbl_queue_xii_tkj
FOR EACH ROW 
BEGIN
  SET NEW.nomor_antrian = (
    SELECT COALESCE(MAX(nomor_antrian), 0) + 1 
    FROM tbl_queue_xii_tkj 
    WHERE tanggal_ambil = NEW.tanggal_ambil 
    AND kelas_id = NEW.kelas_id
  );
END$$

CREATE TRIGGER generate_queue_number_x_mm
BEFORE INSERT ON tbl_queue_x_mm
FOR EACH ROW 
BEGIN
  SET NEW.nomor_antrian = (
    SELECT COALESCE(MAX(nomor_antrian), 0) + 1 
    FROM tbl_queue_x_mm 
    WHERE tanggal_ambil = NEW.tanggal_ambil 
    AND kelas_id = NEW.kelas_id
  );
END$$

CREATE TRIGGER generate_queue_number_xi_mm
BEFORE INSERT ON tbl_queue_xi_mm
FOR EACH ROW 
BEGIN
  SET NEW.nomor_antrian = (
    SELECT COALESCE(MAX(nomor_antrian), 0) + 1 
    FROM tbl_queue_xi_mm 
    WHERE tanggal_ambil = NEW.tanggal_ambil 
    AND kelas_id = NEW.kelas_id
  );
END$$

CREATE TRIGGER generate_queue_number_xii_mm
BEFORE INSERT ON tbl_queue_xii_mm
FOR EACH ROW 
BEGIN
  SET NEW.nomor_antrian = (
    SELECT COALESCE(MAX(nomor_antrian), 0) + 1 
    FROM tbl_queue_xii_mm 
    WHERE tanggal_ambil = NEW.tanggal_ambil 
    AND kelas_id = NEW.kelas_id
  );
END$$

CREATE TRIGGER generate_queue_number_x_pkm
BEFORE INSERT ON tbl_queue_x_pkm
FOR EACH ROW 
BEGIN
  SET NEW.nomor_antrian = (
    SELECT COALESCE(MAX(nomor_antrian), 0) + 1 
    FROM tbl_queue_x_pkm 
    WHERE tanggal_ambil = NEW.tanggal_ambil 
    AND kelas_id = NEW.kelas_id
  );
END$$

CREATE TRIGGER generate_queue_number_xi_pkm
BEFORE INSERT ON tbl_queue_xi_pkm
FOR EACH ROW 
BEGIN
  SET NEW.nomor_antrian = (
    SELECT COALESCE(MAX(nomor_antrian), 0) + 1 
    FROM tbl_queue_xi_pkm 
    WHERE tanggal_ambil = NEW.tanggal_ambil 
    AND kelas_id = NEW.kelas_id
  );
END$$

CREATE TRIGGER generate_queue_number_xii_pkm
BEFORE INSERT ON tbl_queue_xii_pkm
FOR EACH ROW 
BEGIN
  SET NEW.nomor_antrian = (
    SELECT COALESCE(MAX(nomor_antrian), 0) + 1 
    FROM tbl_queue_xii_pkm 
    WHERE tanggal_ambil = NEW.tanggal_ambil 
    AND kelas_id = NEW.kelas_id
  );
END$$

DELIMITER ;

-- Index untuk Optimasi Query
CREATE INDEX idx_siswa_kelas_id ON tbl_siswa(kelas_id);
CREATE INDEX idx_queue_x_date ON tbl_queue_x_rpl(tanggal_ambil);
CREATE INDEX idx_queue_xi_date ON tbl_queue_xi_rpl(tanggal_ambil);
CREATE INDEX idx_queue_xii_date ON tbl_queue_xii_rpl(tanggal_ambil);
CREATE INDEX idx_queue_x_tkj_date ON tbl_queue_x_tkj(tanggal_ambil);
CREATE INDEX idx_queue_xi_tkj_date ON tbl_queue_xi_tkj(tanggal_ambil);
CREATE INDEX idx_queue_xii_tkj_date ON tbl_queue_xii_tkj(tanggal_ambil);
CREATE INDEX idx_queue_x_mm_date ON tbl_queue_x_mm(tanggal_ambil);
CREATE INDEX idx_queue_xi_mm_date ON tbl_queue_xi_mm(tanggal_ambil);
CREATE INDEX idx_queue_xii_mm_date ON tbl_queue_xii_mm(tanggal_ambil);
CREATE INDEX idx_queue_x_pkm_date ON tbl_queue_x_pkm(tanggal_ambil);
CREATE INDEX idx_queue_xi_pkm_date ON tbl_queue_xi_pkm(tanggal_ambil);
CREATE INDEX idx_queue_xii_pkm_date ON tbl_queue_xii_pkm(tanggal_ambil);

COMMIT;
