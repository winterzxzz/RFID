const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');
const { verifyToken } = require('../middleware/authMiddleware');

// Login route
router.post('/login', authController.login);

// Get user info (protected)
router.get('/user-info', verifyToken, authController.getUserInfo);

// Change password (protected)
router.post('/change-password', verifyToken, authController.changePassword);

module.exports = router;