const dotenv = require('dotenv');
dotenv.config();

module.exports = {
    JWT_SECRET: process.env.JWT_SECRET || 'your-secret-key',
    PORT: process.env.PORT || 3000,
    FRONTEND_URL: process.env.FRONTEND_URL || 'http://localhost:5173'
};