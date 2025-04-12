const express = require('express');
const router = express.Router();
const logController = require('../controllers/logController');
const { verifyToken } = require('../middleware/authMiddleware');

// Get all logs (protected)
router.get('/', verifyToken, logController.getAllLogs);

// Add user log
router.post('/', logController.addUserLog);

module.exports = router;