const db = require('../config/db');

// get all devices
const getAllDevices = (req, res) => {
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 10;
    const offset = (page - 1) * limit;
    const device_name = req.query.q || '';
    const direction = req.query.direction === 'asc' ? 'ASC' : 'DESC';

    // Add WHERE clause for device_name search
    const whereClause = device_name ? 'WHERE device_name LIKE ?' : '';
    const searchParam = device_name ? `%${device_name}%` : null;

    // First, get total count with search
    const countQuery = `SELECT COUNT(*) as total FROM devices ${whereClause}`;
    db.query(countQuery, searchParam ? [searchParam] : [], (err, countResult) => {
        if (err) {
            return res.status(500).json({
                status_code: 500,
                message: 'Lỗi lấy danh sách thiết bị',
            });
        }

        const total = countResult[0].total;
        const totalPages = Math.ceil(total / limit);

        // Then get paginated data with search and sorting
        const query = `SELECT * FROM devices ${whereClause} ORDER BY id ${direction} LIMIT ? OFFSET ?`;
        const queryParams = searchParam ? [searchParam, limit, offset] : [limit, offset];

        db.query(query, queryParams, (err, result) => {
            if (err) {
                return res.status(500).json({
                    status_code: 500,
                    message: 'Lỗi lấy danh sách thiết bị',
                });
            }
            res.status(200).json({
                status_code: 200,
                message: 'Lấy danh sách thiết bị thành công',
                data: {
                    pagination: {
                        total,
                        totalPages,
                        currentPage: page,
                        limit
                    },
                    items: result
                },
            });
        });
    });
};


// add new device
const addDevice = (req, res) => {
    const { device_name, device_dep } = req.body;
    const device_uid = Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
    const query = 'INSERT INTO devices (device_name, device_dep, device_uid, device_date) VALUES (?, ?, ?, CURDATE())';

    db.query(query, [device_name, device_dep, device_uid], (err, result) => {
        if (err) {
            return res.status(500).json({
                status_code: 500,
                message: 'Lỗi thêm thiết bị',
                error: err.message
            });
        }

        // Fetch the newly created device
        db.query('SELECT * FROM devices WHERE id = ?', [result.insertId], (err, devices) => {
            if (err) {
                return res.status(500).json({
                    status_code: 500,
                    message: 'Lỗi lấy thông tin thiết bị',
                    error: err.message
                });
            }

            res.status(200).json({
                status_code: 200,
                message: 'Thêm thiết bị thành công',
                data: devices[0]
            });
        });
    });
};

// update device
const updateDevice = (req, res) => {
    const deviceId = req.params.id;
    const { device_name, device_dep, device_mode } = req.body;
    const query = 'UPDATE devices SET device_name = ?, device_dep = ?, device_mode = ? WHERE id = ?';

    db.query(query, [device_name, device_dep, device_mode, deviceId], (err, result) => {
        if (err) {
            console.log(err);
            return res.status(500).json({
                status_code: 500,
                message: 'Lỗi cập nhật thiết bị',
                error: err.message
            });
        }
        if (result.affectedRows === 0) {
            return res.status(404).json({
                status_code: 404,
                message: 'Thiết bị không tồn tại'
            });
        }
        res.status(200).json({
            status_code: 200,
            message: 'Cập nhật thiết bị thành công'
        });
    });
};

// delete device
const deleteDevice = (req, res) => {
    const deviceId = req.params.id;
    const query = 'DELETE FROM devices WHERE id = ?';

    db.query(query, [deviceId], (err, result) => {
        if (err) {
            return res.status(500).json({
                status_code: 500,
                message: 'Lỗi xoá thiết bị',
                error: err.message
            });
        }
        if (result.affectedRows === 0) {
            return res.status(404).json({
                status_code: 404,
                message: 'Thiết bị không tồn tại'
            });
        }
        res.status(200).json({
            status_code: 200,
            message: 'Xoá thiết bị thành công'
        });
    });
};

module.exports = {
    getAllDevices,
    addDevice,
    updateDevice,
    deleteDevice
};