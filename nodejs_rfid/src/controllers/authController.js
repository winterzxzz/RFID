const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const db = require('../config/db');
const env = require('../config/env');

// login admin
const login = async (req, res) => {
    const { admin_email, admin_pwd } = req.body;
    if (!admin_email || !admin_pwd) {
        return res.status(400).json({
            status_code: 400,
            message: 'Vui lòng nhập đầy đủ thông tin',
        });
    }


    const query = 'SELECT * FROM admin WHERE admin_email = ?';

    db.query(query, [admin_email], async (err, result) => {
        if (err) {
            return res.status(500).json({
                status_code: 500,
                message: 'Lỗi đăng nhập',
            });
        }

        if (result.length === 0) {
            return res.status(401).json({
                status_code: 401,
                message: 'Tài khoản không tồn tại',
            });
        }

        // Create JWT token
        const admin = result[0];
        let isMatch = bcrypt.compareSync(admin_pwd, admin.admin_pwd);
        if (!isMatch) {
            return res.status(401).json({
                status_code: 401,
                message: 'Mật khẩu không đúng',
            });
        }
        const token = jwt.sign(
            { admin_id: admin.admin_id, email: admin.admin_email },
            env.JWT_SECRET,
            { expiresIn: '24h' }
        );

        res.status(200).json({
            status_code: 200,
            message: 'Đăng nhập thành công',
            token: token,
            data: {
                name: admin.admin_name,
                email: admin.admin_email,
            }
        });
    });
};

// get user info
const getUserInfo = (req, res) => {
    const query = 'SELECT * FROM admin WHERE admin_email = ?';
    db.query(query, [req.admin.email], (err, result) => {
        if (err) {
            return res.status(500).json({
                status_code: 500,
                message: 'Lỗi lấy thông tin người dùng',
            });
        }
        res.status(200).json({
            status_code: 200,
            message: 'Lấy thông tin người dùng thành công',
            data: {
                name: result[0].admin_name,
                email: result[0].admin_email,
            }
        });
    });
};

// change password admin
const changePassword = (req, res) => {
    const { admin_email, admin_pwd } = req.body;
    const query = 'UPDATE admin SET admin_pwd = ? WHERE admin_email = ?';
    db.query(query, [admin_pwd, admin_email], (err, result) => {
        if (err) {
            return res.status(500).json({
                status_code: 500,
                message: 'Lỗi thay đổi mật khẩu',
            });
        }
        res.status(200).json({
            status_code: 200,
            message: 'Thay đổi mật khẩu thành công',
        });
    });
};

module.exports = {
    login,
    getUserInfo,
    changePassword
};