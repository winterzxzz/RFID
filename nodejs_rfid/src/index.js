const express = require('express');
const dotenv = require('dotenv');
const bodyParser = require('body-parser');
const morgan = require('morgan');
const mysql = require('mysql2');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const cors = require('cors');
const http = require('http');
const { Server } = require('socket.io');
const moment = require('moment');
dotenv.config();

const JWT_SECRET = process.env.JWT_SECRET || 'your-secret-key';



// Add JWT secret key to your environment variables

// Create MySQL connection
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',  // default XAMPP password is empty
    database: 'rfidattendance'  // replace with your database name
});

// Connect to MySQL
db.connect((err) => {
    if (err) {
        console.error('Error connecting to MySQL:', err);
        return;
    }
    console.log('Connected to MySQL database');
});

const app = express();

const server = http.createServer(app);
const io = new Server(server, {
    cors: {
        origin: 'http://localhost:5173',
        methods: ['GET', 'POST'],
        allowedHeaders: ['Authorization'],
    }
});

app.use(cors({
    origin: 'http://localhost:5173  ',  // Your frontend URL
    credentials: true
  }));


io.on('connection', (socket) => {
    console.log('A user connected:', socket.id);

    socket.on('disconnect', () => {
        console.log('A user disconnected:', socket.id);
    });
});


app.use(bodyParser.json());
app.use(morgan('dev'));

app.get('/', (req, res) => {
    res.send('Hello World');
});

server.listen(3000, () => {
    console.log('Server is running on port 3000');
});

// Add middleware to verify JWT token
const verifyToken = (req, res, next) => {
    const token = req.headers['authorization']?.split(' ')[1];

    if (!token) {
        return res.status(403).json({
            status_code: 403,
            message: 'Yêu cầu token để xác thực',
        });
    }

    try {
        const decoded = jwt.verify(token, JWT_SECRET);
        req.admin = decoded;
        next();
    } catch (err) {
        return res.status(401).json({
            status_code: 401,
            message: 'Token không hợp lệ',
        });
    }
};

// Example of protected route using the middleware
app.get('/protected', verifyToken, (req, res) => {
    res.status(200).json({ message: 'Protected data', admin: req.admin });
});

// login admin
app.post('/login', (req, res) => {
    const { admin_email, admin_pwd } = req.body;
    const query = 'SELECT * FROM admin WHERE admin_email = ?';
    db.query(query, [admin_email], (err, result) => {
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
        let passwordHash = bcrypt.hashSync(admin_pwd, 10);
        let isMatch = bcrypt.compareSync(admin_pwd, passwordHash);
        if (!isMatch) {
            return res.status(401).json({
                status_code: 401,
                message: 'Mật khẩu không đúng',
            });
        }
        const token = jwt.sign(
            { admin_id: admin.admin_id, email: admin.admin_email },
            JWT_SECRET,
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
});

// get user info
app.get('/user-info', verifyToken, (req, res) => {
    const query = 'SELECT * FROM admin WHERE admin_email = ?';
    db.query(query, [req.admin.email], (err, result) => {
        res.status(200).json({
            status_code: 200,
            message: 'Lấy thông tin người dùng thành công',
            data: {
                name: result[0].admin_name,
                email: result[0].admin_email,
            }
        });
    });
});

// change password admin
app.post('/change-password', verifyToken, (req, res) => {
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
});

// get all users
app.get('/users', verifyToken, (req, res) => {
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
});


// update user
app.put('/users/:id', (req, res) => {
    const userId = req.params.id;
    const { username, serialnumber, gender, email, device_uid } = req.body;

    if (!device_uid) {
        return res.status(400).json({
            status_code: 400,
            message: 'Device is required',
        });
    }

    db.query('SELECT * FROM devices WHERE device_uid = ?', [device_uid], (err, result) => {
        if (err) {
            return res.status(500).json({
                status_code: 500,
                message: err.message
            });
        }

        const { device_dep } = result[0];

        const query = 'UPDATE users SET username = ?, serialnumber = ?, gender = ?, email = ?, device_dep = ?, device_uid = ?, add_card = ? WHERE id = ?';


        db.query(query, [username, serialnumber, gender, email, device_dep, device_uid, 1, userId], (err, result) => {
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
    });

    
});

// delete user
app.delete('/users/:id', verifyToken, (req, res) => {
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
});



// get all devices
app.get('/devices', verifyToken, (req, res) => {
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
});


// add new device
app.post('/devices', verifyToken, (req, res) => {
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
});

// update device
app.put('/devices/:id', verifyToken, (req, res) => {
    const deviceId = req.params.id;
    const { device_name, device_dep, device_mode } = req.body;
    console.log(req.body);
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
});

// delete device
app.delete('/devices/:id', verifyToken, (req, res) => {
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
});


// get all users log
app.get('/users-log', verifyToken, (req, res) => {
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
        whereClause += ' AND DATE(checkindate) BETWEEN ? AND ?';
        queryParams.push(date_start, date_end);
    }

    if (device_dep) {
        whereClause += ' AND device_dep = ?';
        queryParams.push(device_dep);
    }

    const countQuery = `SELECT COUNT(*) as total FROM users_logs WHERE ${whereClause}`;
    db.query(countQuery, queryParams, (err, countResult) => {
        if (err) {
            return res.status(500).json({
                status_code: 500,
                message: 'Lỗi lấy lịch sử điểm danh',
            });
        }

        const total = countResult[0].total;
        const totalPages = Math.ceil(total / limit);

        const query = `SELECT * FROM users_logs WHERE ${whereClause} ORDER BY id ${direction} LIMIT ? OFFSET ?`;
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
});

function convertVietnameseNameToEnglish(vietnameseName) {
    return vietnameseName
        .normalize('NFD') // Normalize to separate diacritics from characters
        .replace(/[\u0300-\u036f]/g, '') // Remove diacritic marks
        .replace(/đ/g, 'd') // Replace lowercase đ
        .replace(/Đ/g, 'D'); // Replace uppercase Đ
}

// add user log
app.post('/users-log', async (req, res) => {
    const { card_uid, device_uid } = req.query;
    
    if (!card_uid || !device_uid) {
        return res.status(400).json({
            status_code: 400,
            message: 'Missing parameters',
        });
    }

    try {
        // Check device - Convert to promise-based query
        const [devices] = await db.promise().query('SELECT * FROM devices WHERE device_uid = ?', [device_uid]);
        const device = devices[0];
        
        if (!device) {
            return res.status(400).json({
                status_code: 400,
                message: 'Not allowed!',
            });
        }

        const device_mode = device.device_mode;
        const device_dep = device.device_dep;

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

            if (user.device_uid !== device_uid && user.device_uid !== 0) {
                return res.status(400).json({
                    status_code: 400,
                    message: 'Not allowed!',
                });
            }

            const currentDate = moment().format('YYYY-MM-DD');
            const currentTime = moment().format('HH:mm:ss');

            // Check if user has an incomplete log (no timeout) for today
            const [logs] = await db.promise().query(
                'SELECT * FROM users_logs WHERE card_uid = ? AND checkindate = ? AND timeout = "00:00:00" ORDER BY id DESC LIMIT 1',
                [card_uid, currentDate]
            );
            const incompleteLog = logs[0];

            // Handle login/logout
            if (!incompleteLog) {
                // Create new check-in entry
                await db.promise().query(
                    'INSERT INTO users_logs (username, serialnumber, card_uid, device_uid, device_dep, checkindate, timein, timeout) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
                    [user.username, user.serialnumber, card_uid, device_uid, device_dep, currentDate, currentTime, '00:00:00']
                );
                io.emit('attendance', {
                    status_code: 200,
                    message: 'CHECK IN ' + user.username,
                });
                return res.status(200).json({
                    status_code: 200,
                    message: 'CHECK IN ' + convertVietnameseNameToEnglish(user.username),
                });
            } else {
                // Complete the existing check-in with a timeout
                await db.promise().query(
                    'UPDATE users_logs SET timeout = ? WHERE id = ?',
                    [currentTime, incompleteLog.id]
                );
                io.emit('attendance', {
                    status_code: 200,
                    message: 'CHECK OUT ' + user.username,
                });
                return res.status(200).json({
                    status_code: 200,
                    // convert user.name to from vietnamese to english
                    message: 'CHECK OUT ' + convertVietnameseNameToEnglish(user.username),
                });
            }
        }
        // Device mode 0 - Card registration mode
        else if (device_mode === 0) {
            const [cards] = await db.promise().query('SELECT * FROM users WHERE card_uid = ?', [card_uid]);
            const existingCard = cards[0];

            if (existingCard) {
                await db.promise().query('UPDATE users SET card_select = 0');
                await db.promise().query('UPDATE users SET card_select = 1 WHERE card_uid = ?', [card_uid]);
                io.emit('add-card', {
                    status_code: 400,
                    message: 'Card ' + card_uid + ' already registered',
                });
                return res.status(400).json({
                    status_code: 400,
                    message: 'Card ' + card_uid + ' already registered',
                });
            } else {
                await db.promise().query('UPDATE users SET card_select = 0');
                // First insert the new user
                const [result] = await db.promise().query(
                    'INSERT INTO users (card_uid, card_select, device_uid, device_dep, user_date) VALUES (?, 1, ?, ?, CURDATE())',
                    [card_uid, device_uid, device_dep]
                );
                // Then fetch the newly created user
                const [newUsers] = await db.promise().query(
                    'SELECT * FROM users WHERE id = ?',
                    [result.insertId]
                );
                const newUser = newUsers[0];
                console.log(newUser);
                io.emit('add-card', {
                    status_code: 200,
                    message: 'Register card ' + card_uid + ' success',
                    data: newUser
                });
                return res.status(200).json({
                    status_code: 200,
                    message: 'Register card ' + card_uid + ' success',
                    data: newUser
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
});

