const Student = require('../models/StudentModel');

class StudentController {
  static async generateQueue(req, res) {
    try {
      // Cek apakah user sudah login
      if (!req.session.student) {
        return res.status(401).json({
          status: 'error',
          message: 'Silakan login terlebih dahulu'
        });
      }
  
      const { nisn, kelas } = req.session.student;
      const tanggal = new Date().toISOString().split('T')[0];
  
      const queue = await Student.generateQueue(nisn, kelas, tanggal);
  
      res.json({
        status: 'success',
        message: 'Nomor antrian berhasil dibuat',
        data: queue
      });
    } catch (error) {
      res.status(500).json({
        status: 'error',
        message: error.message
      });
    }
  };

  static async login(req, res) {
    try {
      const { nisn, password, kelas } = req.body;
  
      if (!nisn || !password || !kelas) {
        return res.status(400).json({
          status: 'error',
          message: 'NISN, password, dan kelas harus diisi'
        });
      }
  
      const student = await Student.login(nisn, password, kelas);
  
      if (!student) {
        return res.status(401).json({
          status: 'error',
          message: 'NISN atau password salah'
        });
      }
  
      // Simpan data siswa di session
      req.session.student = {
        nisn: student.nisn,
        nama: student.nama,
        kelas: student.kelas
      };
  
      res.json({
        status: 'success',
        message: 'Login berhasil',
        data: student
      });
    } catch (error) {
      res.status(500).json({
        status: 'error',
        message: error.message
      });
    }
  };

  static async create(req, res) {
    try {
      const { nisn, nama, kelas } = req.body;

      // Validasi input
      if (!nisn || !nama || !kelas) {
        return res.status(400).json({
          status: 'error',
          message: 'Semua field harus diisi'
        });
      }

      // Panggil method create dari model Student
      const result = await Student.create({ nisn, nama, kelas });

      res.status(201).json({
        status: 'success',
        ...result
      });

    } catch (error) {
      res.status(500).json({
        status: 'error',
        message: error.message
      });
    }
  }
}


module.exports = StudentController