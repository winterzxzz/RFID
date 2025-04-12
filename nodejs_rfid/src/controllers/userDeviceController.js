const db = require('../config/db');


const getUserDevicesByDeviceId = (req, res) => {
    const deviceId = req.params.id;
    // Get all user devices by device id and join with users table to get complete user information
    const query = `
        SELECT ud.*, u.*
        FROM user_devices ud
        JOIN users u ON ud.user_id = u.id
        WHERE ud.device_id = ?
    `;

    db.query(query, [deviceId], (err, result) => {
        if (err) {
            console.error('Database error:', err);
            return res.status(500).json({
                status_code: 500,
                message: 'Lỗi lấy danh sách người dùng',
                error: process.env.NODE_ENV === 'development' ? err.message : undefined
            });
        }
        res.status(200).json({
            status_code: 200,
            message: 'Lấy danh sách người dùng thành công',
            data: result
        });
    });
}

const deleteUserDevice = (req, res) => {
    const { userId, deviceId } = req.params;
    const query = `
        DELETE FROM user_devices
        WHERE user_id = ? AND device_id = ?
    `;
    db.query(query, [userId, deviceId], (err, result) => {
        if (err) {
            console.error('Database error:', err);
            return res.status(500).json({
                status_code: 500,
                message: 'Lỗi xóa người dùng',
                error: process.env.NODE_ENV === 'development'? err.message : undefined
            });
        }
        console.log(result);
        
        if (result.affectedRows === 0) {
            return res.status(404).json({
                status_code: 404,
                message: 'Người dùng không tồn tại',
            });
        }
        res.status(200).json({
            status_code: 200,
            message: 'Xóa người dùng thành công',
        })
    })
}


module.exports = {
    getUserDevicesByDeviceId, 
    deleteUserDevice
};