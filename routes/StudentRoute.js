// routes/index.js
const express = require('express');
const router = express.Router();
const StudentController = require('../controllers/StudentController');

// Auth routes
router.post('/login/auth', StudentController.login);

// Queue routes
router.post('/generate-queue', StudentController.generateQueue);

// Queue routes
router.post('/add-siswa', StudentController.create);

module.exports = router;
