-- Versi database: MariaDB 10.4.32
-- Dibuat pada: 07 Desember 2024

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- Database: rpl_school_queue_system
CREATE DATABASE IF NOT EXISTS rpl_pekanit_2024;
USE rpl_pekanit_2024;

-- Tabel Siswa (Tabel Induk)
CREATE TABLE tbl_siswa (
  nisn VARCHAR(255) PRIMARY KEY,
  nama VARCHAR(255) NOT NULL,
  kelas VARCHAR(255) NOT NULL,
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Login untuk Angkatan X
CREATE TABLE tbl_login_x_rpl (
  nisn VARCHAR(255) NOT NULL,
  kelas VARCHAR(50) NOT NULL,
  password VARCHAR(255) NOT NULL,
  FOREIGN KEY (nisn) REFERENCES tbl_siswa(nisn),
  UNIQUE KEY unique_siswa_login (nisn, kelas)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Login untuk Angkatan XI
CREATE TABLE tbl_login_xi_rpl (
  nisn VARCHAR(255) NOT NULL,
  kelas VARCHAR(50) NOT NULL,
  password VARCHAR(255) NOT NULL,
  FOREIGN KEY (nisn) REFERENCES tbl_siswa(nisn),
  UNIQUE KEY unique_siswa_login (nisn, kelas)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Login untuk Angkatan XII
CREATE TABLE tbl_login_xii_rpl (
  nisn VARCHAR(255) NOT NULL,
  kelas VARCHAR(50) NOT NULL,
  password VARCHAR(255) NOT NULL,
  FOREIGN KEY (nisn) REFERENCES tbl_siswa(nisn),
  UNIQUE KEY unique_siswa_login (nisn, kelas)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Tabel Queue untuk Angkatan X
CREATE TABLE tbl_queue_x_rpl (
  nisn VARCHAR(255) NOT NULL,
  nomor_antrian INT NOT NULL,
  kelas VARCHAR(50) NOT NULL,
  tanggal_ambil DATE NOT NULL,
  status ENUM('menunggu', 'sedang_proses', 'selesai') DEFAULT 'menunggu',
  FOREIGN KEY (nisn) REFERENCES tbl_siswa(nisn),
  UNIQUE KEY unique_queue_per_date (nisn, tanggal_ambil, kelas)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Tabel Queue untuk Angkatan XI
CREATE TABLE tbl_queue_xi_rpl (
  nisn VARCHAR(255) NOT NULL,
  nomor_antrian INT NOT NULL,
  kelas VARCHAR(50) NOT NULL,
  tanggal_ambil DATE NOT NULL,
  status ENUM('menunggu', 'sedang_proses', 'selesai') DEFAULT 'menunggu',
  FOREIGN KEY (nisn) REFERENCES tbl_siswa(nisn),
  UNIQUE KEY unique_queue_per_date (nisn, tanggal_ambil, kelas)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Tabel Queue untuk Angkatan XII
CREATE TABLE tbl_queue_xii_rpl (
  nisn VARCHAR(255) NOT NULL,
  nomor_antrian INT NOT NULL,
  kelas VARCHAR(50) NOT NULL,
  tanggal_ambil DATE NOT NULL,
  status ENUM('menunggu', 'sedang_proses', 'selesai') DEFAULT 'menunggu',
  FOREIGN KEY (nisn) REFERENCES tbl_siswa(nisn),
  UNIQUE KEY unique_queue_per_date (nisn, tanggal_ambil, kelas)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Trigger untuk Generate Nomor Antrian Angkatan X
DELIMITER $$
CREATE TRIGGER generate_queue_number_x_rpl
BEFORE INSERT ON tbl_queue_x_rpl
FOR EACH ROW 
BEGIN
  SET NEW.nomor_antrian = (
    SELECT COALESCE(MAX(nomor_antrian), 0) + 1 
    FROM tbl_queue_x_rpl 
    WHERE tanggal_ambil = NEW.tanggal_ambil 
    AND kelas = NEW.kelas
  );
END$$

-- Trigger untuk Generate Nomor Antrian Angkatan XI
CREATE TRIGGER generate_queue_number_xi_rpl
BEFORE INSERT ON tbl_queue_xi_rpl
FOR EACH ROW 
BEGIN
  SET NEW.nomor_antrian = (
    SELECT COALESCE(MAX(nomor_antrian), 0) + 1 
    FROM tbl_queue_xi_rpl 
    WHERE tanggal_ambil = NEW.tanggal_ambil 
    AND kelas = NEW.kelas
  );
END$$

-- Trigger untuk Generate Nomor Antrian Angkatan XII
CREATE TRIGGER generate_queue_number_xii_rpl
BEFORE INSERT ON tbl_queue_xii_rpl
FOR EACH ROW 
BEGIN
  SET NEW.nomor_antrian = (
    SELECT COALESCE(MAX(nomor_antrian), 0) + 1 
    FROM tbl_queue_xii_rpl 
    WHERE tanggal_ambil = NEW.tanggal_ambil 
    AND kelas = NEW.kelas
  );
END$$
DELIMITER ;

-- Index untuk Optimasi Query
CREATE INDEX idx_siswa_kelas ON tbl_siswa(kelas);
CREATE INDEX idx_queue_x_date ON tbl_queue_x_rpl(tanggal_ambil);
CREATE INDEX idx_queue_xi_date ON tbl_queue_xi_rpl(tanggal_ambil);
CREATE INDEX idx_queue_xii_date ON tbl_queue_xii_rpl(tanggal_ambil);

COMMIT;
