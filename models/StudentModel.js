const conn = require("../config/conn");

class Student {
  static async login(nisn, password, kelas) {
    console.log("NISN:", nisn);
    console.log("Password:", password);
    console.log("Kelas:", kelas);

    try {
      let table = "";
      if (kelas.startsWith("X")) {
        if (kelas.includes("RPL")) {
          table = "tbl_login_x_rpl";
        } else if (kelas.includes("TKJ")) {
          table = "tbl_login_x_tkj";
        } else if (kelas.includes("MM") || kelas.includes("DKV")) {
          table = "tbl_login_x_mm";
        } else if (kelas.includes("PKM") || kelas.includes("LPB")) {
          table = "tbl_login_x_pkm";
        }
      } else if (kelas.startsWith("XI")) {
        if (kelas.includes("RPL")) {
          table = "tbl_login_xi_rpl";
        } else if (kelas.includes("TKJ")) {
          table = "tbl_login_xi_tkj";
        } else if (kelas.includes("MM") || kelas.includes("DKV")) {
          table = "tbl_login_xi_mm";
        } else if (kelas.includes("PKM") || kelas.includes("LPB")) {
          table = "tbl_login_xi_pkm";
        }
      } else if (kelas.startsWith("XII")) {
        if (kelas.includes("RPL")) {
          table = "tbl_login_xii_rpl";
        } else if (kelas.includes("TKJ")) {
          table = "tbl_login_xii_tkj";
        } else if (kelas.includes("MM") || kelas.includes("DKV")) {
          table = "tbl_login_xii_mm";
        } else if (kelas.includes("PKM") || kelas.includes("LPB")) {
          table = "tbl_login_xii_pkm";
        }
      }

      if (!table) {
        throw new Error(
          "Kelas tidak valid. Tidak dapat menentukan tabel login."
        );
      }
  
      const [rows] = await conn.execute(
        `SELECT s.nisn, s.nama, k.nama_kelas FROM ${table} l 
         JOIN tbl_siswa s ON s.nisn = l.nisn 
         JOIN tbl_kelas k ON s.kelas_id = k.id
         WHERE l.nisn = ? AND l.password = ?`,
        [nisn, password]
      );

      if (rows.length === 0) {
        throw new Error("Login gagal. Data tidak ditemukan.");
      }

      return rows[0];
    } catch (error) {
      console.error("Error:", error.message);
      throw error;
    }
  }

  static async generateQueue(nisn, kelas, tanggal) {
    try {
      // Determine the queue table based on the class and department
      let table = "";
      if (kelas.startsWith("X")) {
        if (kelas.includes("RPL")) {
          table = "tbl_queue_x_rpl";
        } else if (kelas.includes("TKJ")) {
          table = "tbl_queue_x_tkj";
        } else if (kelas.includes("MM") || kelas.includes("DKV")) {
          table = "tbl_queue_x_mm";
        } else if (kelas.includes("PKM") || kelas.includes("LPB")) {
          table = "tbl_queue_x_pkm";
        }
      } else if (kelas.startsWith("XI")) {
        if (kelas.includes("RPL")) {
          table = "tbl_queue_xi_rpl";
        } else if (kelas.includes("TKJ")) {
          table = "tbl_queue_xi_tkj";
        } else if (kelas.includes("MM") || kelas.includes("DKV")) {
          table = "tbl_queue_xi_mm";
        } else if (kelas.includes("PKM") || kelas.includes("LPB")) {
          table = "tbl_queue_xi_pkm";
        }
      } else if (kelas.startsWith("XII")) {
        if (kelas.includes("RPL")) {
          table = "tbl_queue_xii_rpl";
        } else if (kelas.includes("TKJ")) {
          table = "tbl_queue_xii_tkj";
        } else if (kelas.includes("MM") || kelas.includes("DKV")) {
          table = "tbl_queue_xii_mm";
        } else if (kelas.includes("PKM") || kelas.includes("LPB")) {
          table = "tbl_queue_xii_pkm";
        }
      } else {
        throw new Error("Kelas tidak valid");
      }

      // Check if the NISN already exists for the given date
      const [existingQueue] = await conn.execute(
        `SELECT nomor_antrian FROM ${table} WHERE nisn = ? AND tanggal_ambil = ?`,
        [nisn, tanggal]
      );

      if (existingQueue.length > 0) {
        // If the NISN exists, return the existing queue number
        return {
          message: "Siswa sudah memiliki nomor antrian",
          nomor_antrian: existingQueue[0].nomor_antrian,
        };
      }

      // Insert into the appropriate queue table
      await conn.execute(
        `INSERT INTO ${table} (nisn, kelas_id, tanggal_ambil) VALUES (?, (SELECT id FROM tbl_kelas WHERE nama_kelas = ?), ?)`,
        [nisn, kelas, tanggal]
      );

      // Retrieve the new queue entry
      const [queue] = await conn.execute(
        `SELECT nomor_antrian FROM ${table} WHERE nisn = ? AND tanggal_ambil = ?`,
        [nisn, tanggal]
      );

      return {
        message: "Nomor antrian berhasil dibuat",
        nomor_antrian: queue[0].nomor_antrian,
      };
    } catch (error) {
      throw error;
    }
  }

  static async create(data) {
    const { nisn, nama, kelas } = data;

    let connection;

    try {
      // Ambil koneksi dari pool
      connection = await conn.getConnection();

      // Mulai transaksi
      await connection.beginTransaction();

      try {
        // 1. Get kelas_id from tbl_kelas
        const [kelasResult] = await connection.execute(
          "SELECT id FROM tbl_kelas WHERE nama_kelas = ?",
          [kelas]
        );

        if (kelasResult.length === 0) {
          throw new Error("Kelas tidak ditemukan");
        }

        const kelas_id = kelasResult[0].id;

        // 2. Insert ke tabel siswa
        await connection.execute(
          "INSERT INTO tbl_siswa (nisn, nama, kelas_id) VALUES (?, ?, ?)",
          [nisn, nama, kelas_id]
        );

        // 3. Generate password
        const password = `PEKANIT-2024`;

        // 4. Tentukan tabel login berdasarkan jurusan dan tingkat kelas
        let loginTable = "";
        if (kelas.startsWith("X")) {
          if (kelas.includes("RPL")) {
            loginTable = "tbl_login_x_rpl";
          } else if (kelas.includes("TKJ")) {
            loginTable = "tbl_login_x_tkj";
          } else if (kelas.includes("MM") || kelas.includes("DKV")) {
            loginTable = "tbl_login_x_mm";
          } else if (kelas.includes("PKM") || kelas.includes("LPB")) {
            loginTable = "tbl_login_x_pkm";
          }
        } else if (kelas.startsWith("XI")) {
          if (kelas.includes("RPL")) {
            loginTable = "tbl_login_xi_rpl";
          } else if (kelas.includes("TKJ")) {
            loginTable = "tbl_login_xi_tkj";
          } else if (kelas.includes("MM") || kelas.includes("DKV")) {
            loginTable = "tbl_login_xi_mm";
          } else if (kelas.includes("PKM") || kelas.includes("LPB")) {
            loginTable = "tbl_login_xi_pkm";
          }
        } else if (kelas.startsWith("XII")) {
          if (kelas.includes("RPL")) {
            loginTable = "tbl_login_xii_rpl";
          } else if (kelas.includes("TKJ")) {
            loginTable = "tbl_login_xii_tkj";
          } else if (kelas.includes("MM") || kelas.includes("DKV")) {
            loginTable = "tbl_login_xii_mm";
          } else if (kelas.includes("PKM") || kelas.includes("LPB")) {
            loginTable = "tbl_login_xii_pkm";
          }
        } else {
          throw new Error("Kelas tidak valid");
        }

        // 5. Insert ke tabel login
        await connection.execute(
          `INSERT INTO ${loginTable} (nisn, kelas_id, password) VALUES (?, ?, ?)`,
          [nisn, kelas_id, password]
        );

        // 6. Commit transaction jika semua berhasil
        await connection.commit();

        // 7. Return data siswa yang berhasil dibuat
        const [student] = await connection.execute(
          "SELECT * FROM tbl_siswa WHERE nisn = ?",
          [nisn]
        );

        return {
          message: "Data siswa berhasil ditambahkan",
          data: student[0],
          loginCredentials: {
            nisn,
            password,
            kelas,
          },
        };
      } catch (error) {
        // Rollback jika terjadi error
        await connection.rollback();
        throw error;
      }
    } catch (error) {
      throw error;
    } finally {
      // Pastikan koneksi dilepas kembali ke pool
      if (connection) {
        connection.release();
      }
    }
  }
}

module.exports = Student;
