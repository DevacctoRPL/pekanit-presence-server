const express = require('express');
const session = require('express-session');
const cors = require('cors')
const StudentRoutes = require('./routes/StudentRoute');
const cookieParser = require('cookie-parser');
require('dotenv').config();

const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());
app.use(session({
  secret: 'your-session-secret', // Ganti dengan secret yang aman
  resave: false,
  saveUninitialized: false,
  cookie: {
    secure: process.env.NODE_ENV === 'production',
    httpOnly: true,
    maxAge: 24 * 60 * 60 * 1000 // 24 jam
  }
}));

// In your server configuration
app.use(cors({
  origin: 'https://49kdgk28-5173.asse.devtunnels.ms', // or your frontend domain
  credentials: true
}));

app.use(cookieParser());

// Routes
app.use('/api', StudentRoutes);

// Error handler
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({
    status: 'error',
    message: 'Terjadi kesalahan pada server'
  });
});

app.get('/', (req, res)=>{
  res.send('ping pong!')
})



const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server berjalan di port ${PORT}`);
});
