const db = require('../config/db');

// get all users
const getAllUsers = (req, res) => {
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 10;
    const offset = (page - 1) * limit;
    const username = req.query.q || '';
    const direction = req.query.direction === 'asc' ? 'ASC' : 'DESC';

    const whereClause = username ? 'WHERE username LIKE ?' : '';
    const searchParam = username ? `%${username}%` : null;

    const countQuery = `SELECT COUNT(*) as total FROM users ${whereClause}`;
    db.query(countQuery, searchParam ? [searchParam] : [], (err, countResult) => {
        if (err) {
            return res.status(500).json({
                status_code: 500,
                message: 'Lỗi lấy danh sách người dùng',
            });
        }

        const total = countResult[0].total;
        const totalPages = Math.ceil(total / limit);

        const query = `SELECT * FROM users ${whereClause} ORDER BY id ${direction} LIMIT ? OFFSET ?`;
        const queryParams = searchParam ? [searchParam, limit, offset] : [limit, offset];

        db.query(query, queryParams, (err, result) => {
            if (err) {
                return res.status(500).json({
                    status_code: 500,
                    message: 'Lỗi lấy danh sách người dùng',
                });
            }

            // get all departments (id, device_uid device_dep) and make it dis
            const departmentsQuery = 'SELECT id, device_uid, device_dep FROM devices';
            db.query(departmentsQuery, (err, departmentsResult) => {
                if (err) {
                    return res.status(500).json({
                        status_code: 500,
                        message: 'Lỗi lấy danh sách phòng ban',
                    });
                }

                res.status(200).json({
                    status_code: 200,
                    message: 'Lấy danh sách người dùng thành công',
                    data: {
                        pagination: {
                            total,
                            totalPages,
                            currentPage: page,
                            limit
                        },
                        items: result,
                        departments: departmentsResult,
                    },
                });
            });
        });
    });
};

// update user
const updateUser = (req, res) => {
    const userId = req.params.id;
    const { username, serialnumber, gender, email } = req.body;
    // add add_card is 1
    const query = 'UPDATE users SET username = ?, serialnumber = ?, gender = ?, email = ?, add_card = 1 WHERE id = ?';

    db.query(query, [username, serialnumber, gender, email, userId], (err, result) => {
        if (err) {
            console.log(err);
            return res.status(500).json({
                status_code: 500,
                message: err.message,
            });
        }
        if (result.affectedRows === 0) {
            return res.status(404).json({
                status_code: 404,
                message: 'Người dùng không tồn tại'
            });
        }
        res.status(200).json({
            status_code: 200,
            message: 'Cập nhật người dùng thành công',
        });
    });
};

// delete user
const deleteUser = (req, res) => {
    const userId = req.params.id;
    const query = 'DELETE FROM users WHERE id = ?';

    db.query(query, [userId], (err, result) => {
        if (err) {
            return res.status(500).json({
                status_code: 500,
                message: 'Lỗi xoá người dùng',
                error: err.message
            });
        }
        if (result.affectedRows === 0) {
            return res.status(404).json({
                status_code: 404,
                message: 'Người dùng không tồn tại'
            });
        }
        res.status(200).json({
            status_code: 200,
            message: 'Xoá người dùng thành công'
        });
    });
};

module.exports = {
    getAllUsers,
    updateUser,
    deleteUser
};