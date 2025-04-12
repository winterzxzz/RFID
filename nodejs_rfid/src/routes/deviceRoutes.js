const express = require('express');
const router = express.Router();
const deviceController = require('../controllers/deviceController');
const { verifyToken } = require('../middleware/authMiddleware');

// Get all devices (protected)
router.get('/', verifyToken, deviceController.getAllDevices);

// Add new device (protected)
router.post('/', verifyToken, deviceController.addDevice);

// Update device (protected)
router.put('/:id', verifyToken, deviceController.updateDevice);

// Delete device (protected)
router.delete('/:id', verifyToken, deviceController.deleteDevice);

module.exports = router;