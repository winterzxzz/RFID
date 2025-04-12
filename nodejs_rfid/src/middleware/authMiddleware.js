const jwt = require('jsonwebtoken');
const env = require('../config/env');

const verifyToken = (req, res, next) => {
    const token = req.headers['authorization']?.split(' ')[1];

    if (!token) {
        return res.status(403).json({
            status_code: 403,
            message: 'Yêu cầu token để xác thực',
        });
    }

    try {
        const decoded = jwt.verify(token, env.JWT_SECRET);
        req.admin = decoded;
        next();
    } catch (err) {
        return res.status(401).json({
            status_code: 401,
            message: 'Token không hợp lệ',
        });
    }
};

module.exports = {
    verifyToken
};