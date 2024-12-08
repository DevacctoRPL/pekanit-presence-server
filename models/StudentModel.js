const conn = require('../config/conn');

class Student {
  static async login(nisn, password, kelas) {
    console.log('NISN:', nisn);
    console.log('Password:', password);
    console.log('Kelas:', kelas);
  
    try {
      let table = '';
      if (kelas.startsWith('X')) {
        table = 'tbl_login_x_rpl';  
      } else if (kelas.startsWith('XI')) {
        table = 'tbl_login_xi_rpl';
      } else if (kelas.startsWith('XII')) {
        table = 'tbl_login_xii_rpl';
      }
  
      if (!table) {
        throw new Error('Kelas tidak valid. Tidak dapat menentukan tabel login.');
      }
  
      const [rows] = await conn.execute(
        `SELECT s.*, l.* FROM ${table} l 
         JOIN tbl_siswa s ON s.nisn = l.nisn 
         WHERE l.nisn = ? AND l.password = ?`,
        [nisn, password]
      );
  
      if (rows.length === 0) {
        throw new Error('Login gagal. Data tidak ditemukan.');
      }
  
      return rows[0];
    } catch (error) {
      console.error('Error:', error.message);
      throw error;
    }
  }
  
  static async generateQueue(nisn, kelas, tanggal) {
    try {
      let table = '';
      if (kelas.startsWith('X')) {
        table = 'tbl_queue_x_rpl';
      } else if (kelas.startsWith('XI')) {
        table = 'tbl_queue_xi_rpl';
      } else if (kelas.startsWith('XII')) {
        table = 'tbl_queue_xii_rpl';
      }

      const [result] = await conn.execute(
        `INSERT INTO ${table} (nisn, kelas, tanggal_ambil) VALUES (?, ?, ?)`,
        [nisn, kelas, tanggal]
      );

      const [queue] = await conn.execute(
        `SELECT * FROM ${table} WHERE nisn = ? AND tanggal_ambil = ?`,
        [nisn, tanggal]
      );

      return queue[0];
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
        // 1. Insert ke tabel siswa
        await connection.execute(
          'INSERT INTO tbl_siswa (nisn, nama, kelas) VALUES (?, ?, ?)',
          [nisn, nama, kelas]
        );

        // 2. Generate password
        const password = `PEKANIT-2024`;

        // 3. Tentukan tabel login berdasarkan tingkat kelas
        let loginTable = '';
        if (kelas.startsWith('X')) {
          loginTable = 'tbl_login_x_rpl';
        } else if (kelas.startsWith('XI')) {
          loginTable = 'tbl_login_xi_rpl';
        } else if (kelas.startsWith('XII')) {
          loginTable = 'tbl_login_xii_rpl';
        } else {
          throw new Error('Kelas tidak valid');
        }

        // 4. Insert ke tabel login
        await connection.execute(
          `INSERT INTO ${loginTable} (nisn, kelas, password) VALUES (?, ?, ?)`,
          [nisn, kelas, password]
        );

        // 5. Commit transaction jika semua berhasil
        await connection.commit();

        // 6. Return data siswa yang berhasil dibuat
        const [student] = await connection.execute(
          'SELECT * FROM tbl_siswa WHERE nisn = ?',
          [nisn]
        );

        return {
          message: 'Data siswa berhasil ditambahkan',
          data: student[0],
          loginCredentials: {
            nisn,
            password,
            kelas
          }
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