const jwt = require("jsonwebtoken");
const Student = require("../models/StudentModel"); // Asumsikan kode login di atas ada di model Auth
class AuthController {
  // Middleware untuk verifikasi token
  static async authenticateToken(req, res, next) {
    const token =
      req.cookies.token ||
      req.headers["authorization"]?.split(" ")[1];

      console.log(token)

    if (!token) {
      return res.status(401).json({
        status: "error",
        message: "Token tidak ditemukan",
      });
    }

    jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
      if (err) {
        return res.status(403).json({
          status: "error",
          message: "Token tidak valid",
        });
      }
      req.user = user;
      next();
    });
  }
}

module.exports = {AuthController}