const db = require('../config/db');
const moment = require('moment');
const { getIO } = require('../config/socket');
const { convertVietnameseNameToEnglish, getCurrentDate, getCurrentTime } = require('../utils/helpers');

// get all users log
const getAllLogs = (req, res) => {
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 10000;
    const offset = (page - 1) * limit;
    const direction = req.query.direction === 'asc' ? 'ASC' : 'DESC';

    const date_start = req.query.date_start ? moment(req.query.date_start).format('YYYY-MM-DD') : '';
    const date_end = req.query.date_end ? moment(req.query.date_end).format('YYYY-MM-DD') : '';
    const device_dep = req.query.device_dep || '';

    let whereClause = '1=1'; // Base condition that's always true
    let queryParams = [];

    // Only add date conditions if dates are provided
    if (date_start && date_end) {
        whereClause += ' AND DATE(ul.checkindate) BETWEEN ? AND ?';
        queryParams.push(date_start, date_end);
    }

    if (device_dep) {
        whereClause += ' AND d.device_dep = ?';
        queryParams.push(device_dep);
    }

    const countQuery = `SELECT COUNT(*) as total FROM users_logs ul JOIN devices d ON ul.device_id = d.id WHERE ${whereClause}`;
    db.query(countQuery, queryParams, (err, countResult) => {
        if (err) {
            return res.status(500).json({
                status_code: 500,
                message: 'Lỗi lấy lịch sử điểm danh',
            });
        }

        const total = countResult[0].total;
        const totalPages = Math.ceil(total / limit);

        const query = `
            SELECT ul.*, d.device_dep, d.device_name 
            FROM users_logs ul
            JOIN devices d ON ul.device_id = d.id
            WHERE ${whereClause} 
            ORDER BY ul.id ${direction} 
            LIMIT ? OFFSET ?
        `;
        queryParams.push(limit, offset);

        db.query(query, queryParams, (err, result) => {
            if (err) {
                return res.status(500).json({
                    status_code: 500,
                    message: 'Lỗi lấy lịch sử điểm danh',
                });
            }
            res.status(200).json({
                status_code: 200,
                message: 'Lấy lịch sử điểm danh thành công',
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

// add user log
const addUserLog = async (req, res) => {
    const { card_uid, device_id } = req.query;
    const io = getIO();

    if (!card_uid || !device_id) {
        return res.status(400).json({
            status_code: 400,
            message: 'Missing parameters',
        });
    }

    try {
        // Check device - Convert to promise-based query
        const [devices] = await db.promise().query('SELECT * FROM devices WHERE id = ?', [device_id]);
        const device = devices[0];

        if (!device) {
            return res.status(400).json({
                status_code: 400,
                message: 'Not allowed!',
            });
        }

        const device_mode = device.device_mode;

        // Device mode 1 - Login/Logout mode
        if (device_mode === 1) {
            const [users] = await db.promise().query('SELECT * FROM users WHERE card_uid = ?', [card_uid]);
            const user = users[0];

            if (!user) {
                return res.status(400).json({
                    status_code: 400,
                    message: 'Not found!',
                });
            }

            if (user.add_card !== 1) {
                return res.status(400).json({
                    status_code: 400,
                    message: 'Not Registered!',
                });
            }

            // check device include list devices of user in table user_devices
            const [userDevices] = await db.promise().query('SELECT * FROM user_devices WHERE user_id = ? AND device_id = ?', [user.id, device.id]);
            const userDevice = userDevices[0];

            if (!userDevice) {
                return res.status(400).json({
                    status_code: 400,
                    message: 'Not allowed!',
                });
            }

            const currentDate = getCurrentDate();
            const currentTime = getCurrentTime();

            // Check if user has an incomplete log (no timeout) for today
            const [logs] = await db.promise().query(
                'SELECT * FROM users_logs WHERE device_id = ? AND card_uid = ? AND checkindate = ? AND timeout = "00:00:00" ORDER BY id DESC LIMIT 1',
                [device.id, card_uid, currentDate]
            );
            const incompleteLog = logs[0];

            // Handle login/logout
            if (!incompleteLog) {
                // Create new check-in entry
                const [result] = await db.promise().query(
                    'INSERT INTO users_logs (username, serialnumber, card_uid, device_id, checkindate, timein, timeout) VALUES (?, ?, ?, ?, ?, ?, ?)',
                    [user.username, user.serialnumber, card_uid, device.id, currentDate, currentTime, '00:00:00']
                );

                const [newLogs] = await db.promise().query('SELECT * FROM users_logs WHERE id = ?', [result.insertId]);
                const newLog = newLogs[0];

                io.emit('attendance', {
                    status_code: 200,
                    message: 'CHECK IN ' + user.username,
                    data: {
                        ...newLog, 
                        device_dep: device.device_dep
                    }
                });
                return res.status(200).json({
                    status_code: 200,
                    message: 'CHECK IN ' + convertVietnameseNameToEnglish(user.username),
                    data: {
                        ...newLog,
                        device_dep: device.device_dep
                    }
                });
            } else {
                // Complete the existing check-in with a timeout
                await db.promise().query(
                    'UPDATE users_logs SET timeout = ? WHERE id = ? AND device_id = ?',
                    [currentTime, incompleteLog.id, device.id]
                );

                const [newLogs] = await db.promise().query('SELECT * FROM users_logs WHERE id = ?', [incompleteLog.id]);
                const newLog = newLogs[0];

                io.emit('attendance', {
                    status_code: 200,
                    message: 'CHECK OUT ' + user.username,
                    data: {
                        ...newLog,
                        device_dep: device.device_dep
                    }
                });
                return res.status(200).json({
                    status_code: 200,
                    message: 'CHECK OUT ' + convertVietnameseNameToEnglish(user.username),
                    data: {
                        ...newLog,
                        device_dep: device.device_dep
                    }
                });
            }
        }
        // Device mode 0 - Card registration mode
        else if (device_mode === 0) {
            const [users] = await db.promise().query('SELECT * FROM users WHERE card_uid = ?', [card_uid]);
            const user = users[0];
            var userId;
            var isNew = false;
            if (!user) {
                // create new user
                var currentDate = getCurrentDate();
                const [result] = await db.promise().query(
                    'INSERT INTO users (card_uid, card_select, user_date) VALUES (?, 1, ?)',
                    [card_uid, currentDate]
                );

                // Check result.insertId instead
                if (!result.insertId) {
                    return res.status(400).json({
                        status_code: 400,
                        message: `Card ${card_uid} registration failed`,
                    });
                }

                userId = result.insertId;
                isNew = true;
            } else {
                userId = user.id;
            }

            // check user include list users of device
            const [userDevices] = await db.promise().query('SELECT * FROM user_devices WHERE user_id = ? AND device_id = ?', [userId, device.id]);
            const userDevice = userDevices[0];

            if (userDevice) {
                return res.status(400).json({
                    status_code: 400,
                    message: 'Card ' + card_uid + ' already registered',
                });
            } else {
                // create new user_device
                var currentDate = getCurrentDate();
                const [result2] = await db.promise().query(
                    'INSERT INTO user_devices (user_id, device_id, add_card, card_select, card_uid, add_date) VALUES (?, ?, 1, 1, ?, ?)',
                    [userId, device.id, card_uid, currentDate]
                );

                if (!result2.insertId) {
                    return res.status(400).json({
                        status_code: 400,
                        message: 'Card ' + card_uid + ' registration failed',
                    });
                }

                // fetch user
                const [users2] = await db.promise().query('SELECT * FROM users WHERE id = ?', [userId]);
                const user2 = users2[0];

                if (isNew) {
                    io.emit('add-card', {
                        status_code: 200,
                        message: 'Register card'+ card_uid +'success',
                        data: user2
                    });
                }
                return res.status(200).json({
                    status_code: 200,
                    message: 'Register card ' + card_uid + ' success',
                    data: user2
                });
            }
        }
    } catch (error) {
        console.error('Database error:', error);
        return res.status(500).json({
            status_code: 500,
            message: 'SQL_Error: ' + error.message,
        });
    }
};

module.exports = {
    getAllLogs,
    addUserLog
};