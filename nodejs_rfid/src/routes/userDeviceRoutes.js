const express = require('express');
const router = express.Router();
const userDeviceController = require('../controllers/userDeviceController');
const { verifyToken } = require('../middleware/authMiddleware');

router.get('/:id', verifyToken, userDeviceController.getUserDevicesByDeviceId);
router.delete('/:userId/:deviceId', verifyToken, userDeviceController.deleteUserDevice);


module.exports = router;