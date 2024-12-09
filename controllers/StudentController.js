const Student = require("../models/StudentModel");
const jwt = require("jsonwebtoken");

class StudentController {
  static async generateQueue(req, res) {
    try {
      // Verifikasi token dari header Authorization
      const authHeader = req.headers.authorization;
      if (!authHeader || !authHeader.startsWith("Bearer ")) {
        return res.status(401).json({
          status: "error",
          message: "Token tidak valid",
        });
      }
  
      const token = authHeader.split(" ")[1]; // Correct token extraction
  
      // Menampilkan token ke konsol
      console.log("Token yang diterima:", token);
  
      // Verifikasi token dan dapatkan data student
      let studentData;
      try {
        studentData = jwt.verify(token, process.env.JWT_SECRET);
      } catch (err) {
        console.error("Token verification error:", err);
        return res.status(401).json({
          status: "error",
          message: "Token tidak valid atau kadaluarsa",
        });
      }
  
      // Debug logs
      console.log("Student Data from Token:", studentData);
      console.log("Request Body:", req.body);
  
      // Pastikan data studentData memiliki nisn dan kelas
      if (!studentData.nisn || !studentData.kelas) {
        return res.status(401).json({
          status: "error",
          message: "Token tidak mengandung data yang valid",
        });
      }

      // Generate tanggal dalam format YYYY-MM-DD
      const tanggal = new Date().toISOString().split("T")[0];

      const { nisn, kelas } = studentData; // Ambil nisn dan kelas dari studentData
      const queue = await Student.generateQueue(nisn, kelas, tanggal);;

      res.json({
        status: "success",
        message: "Nomor antrian berhasil dibuat",
        data: queue,
      });
    } catch (error) {
      console.error("Generate Queue Error:", error);
      res.status(500).json({
        status: "error",
        message: error.message || "Terjadi kesalahan saat generate nomor antrian",
      });
    }
  }

  static async login(req, res) {
    try {
      const { nisn, password, kelas } = req.body;
  
      // Validasi input
      if (!nisn || !password || !kelas) {
        return res.status(400).json({
          status: "error",
          message: "NISN, password, dan kelas harus diisi",
        });
      }
  
      // Panggil method login dari model
      const userData = await Student.login(nisn, password, kelas);
      console.log(userData);
  
      // Buat JWT token
      const token = jwt.sign(
        {
          id: userData.id,
          nisn: userData.nisn,
          kelas: kelas,
        },
        process.env.JWT_SECRET, // Ensure this is defined in your environment
        { expiresIn: "24h" }
      );
  
      // Data credential yang akan disimpan
      const credential = {
        nisn: userData.nisn,
        kelas: userData.kelas,
      };
  
      // Set cookie untuk credential
      res.cookie("credential", credential, {
        httpOnly: false, // Agar bisa diakses oleh JavaScript client
        secure: false,
        maxAge: 24 * 60 * 60 * 1000, // 24 jam
      });
  
      // Set session
      req.session.user = {
        id: userData.id,
        nisn: userData.nisn,
        kelas: userData.kelas,
      };
  
      // Set cookie dengan token
      res.cookie("token", token, {
        httpOnly: true,
        secure: process.env.NODE_ENV === "production",
        maxAge: 24 * 60 * 60 * 1000, // 24 jam
      });
  
      // Set Authorization header
      res.setHeader('Authorization', `Bearer ${token}`);
      console.log(userData)
  
      res.status(200).json({
        status: "success",
        message: "Login berhasil",
        user: userData,
        token,
      });
    } catch (error) {
      res.status(401).json({
        status: "error",
        message: error.message,
      });
    }
  }
  

  // Add logout method
  static async logout(req, res) {
    req.session.destroy((err) => {
      if (err) {
        return res.status(500).json({
          status: "error",
          message: "Gagal logout",
        });
      }

      // Clear session cookie
      res.clearCookie("connect.sid");

      res.json({
        status: "success",
        message: "Logout berhasil",
      });
    });
  }

  static async create(req, res) {
    try {
      const { nisn, nama, kelas } = req.body;

      // Validasi input
      if (!nisn || !nama || !kelas) {
        return res.status(400).json({
          status: "error",
          message: "Semua field harus diisi",
        });
      }

      // Panggil method create dari model Student
      const result = await Student.create({ nisn, nama, kelas });

      res.status(201).json({
        status: "success",
        ...result,
      });
    } catch (error) {
      res.status(500).json({
        status: "error",
        message: error.message,
      });
    }
  }
}

module.exports = StudentController;