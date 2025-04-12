const express = require('express');
const http = require('http');
const bodyParser = require('body-parser');
const morgan = require('morgan');
const cors = require('cors');

// Import configuration
const env = require('./config/env');
const { initSocket } = require('./config/socket');
require('./config/db'); // Initialize database connection

// Import routes
const authRoutes = require('./routes/authRoutes');
const userRoutes = require('./routes/userRoutes');
const deviceRoutes = require('./routes/deviceRoutes');
const logRoutes = require('./routes/logRoutes');
const userDeviceRoutes = require('./routes/userDeviceRoutes');

// Create Express app
const app = express();
const server = http.createServer(app);

// Initialize Socket.io
initSocket(server);

// Middleware
app.use(cors({
    origin: env.FRONTEND_URL,
    credentials: true
}));
app.use(bodyParser.json());
app.use(morgan('dev'));

// Routes
app.get('/', (req, res) => {
    res.send('RFID Attendance System API');
});

// API routes
app.use('/', authRoutes);
app.use('/users', userRoutes);
app.use('/devices', deviceRoutes);
app.use('/user-devices', userDeviceRoutes);
app.use('/users-log', logRoutes);

// Protected route example
app.get('/protected', require('./middleware/authMiddleware').verifyToken, (req, res) => {
    res.status(200).json({ message: 'Protected data', admin: req.admin });
});

// Start server
server.listen(env.PORT, () => {
    console.log(`Server is running on port ${env.PORT}`);
});