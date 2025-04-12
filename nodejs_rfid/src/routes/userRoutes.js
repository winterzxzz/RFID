const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');
const { verifyToken } = require('../middleware/authMiddleware');

// Get all users (protected)
router.get('/', verifyToken, userController.getAllUsers);

// Update user
router.put('/:id', userController.updateUser);

// Delete user (protected)
router.delete('/:id', verifyToken, userController.deleteUser);

module.exports = router;