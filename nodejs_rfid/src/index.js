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
    // get all devices, only device have device_uid in database can be accessd
    const query = 'SELECT * FROM devices';
    // db.query(query, (err, result) => {
    //     if (err) {
    //         return res.status(500).json({
    //             status_code: 500,
    //             message: 'Error getting devices',
    //         });
    //     }
    //     const devices = result.map(device => device.device_uid);
    //     if (!devices.includes(req.headers['device_uid'])) {
    //         return res.status(403).json({
    //             status_code: 403,
    //             message: 'Unauthorized',
    //         });
    //     }
    // });
    next();
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
                message: 'Error logging in',
            });
        }

        if (result.length === 0) {
            return res.status(401).json({
                status_code: 401,
                message: 'User not found',
            });
        }

        // Create JWT token
        const admin = result[0];
        let passwordHash = bcrypt.hashSync(admin_pwd, 10);
        let isMatch = bcrypt.compareSync(admin_pwd, passwordHash);
        if (!isMatch) {
            return res.status(401).json({
                status_code: 401,
                message: 'Wrong password',
            });
        }
        const token = jwt.sign(
            { admin_id: admin.admin_id, email: admin.admin_email },
            JWT_SECRET,
            { expiresIn: '24h' }
        );

        res.status(200).json({
            status_code: 200,
            message: 'Login successful',
            token: token,
            data: {
                id: admin.id,
                email: admin.admin_email,
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
                message: 'Error changing password',
            });
        }
        res.status(200).json({
            status_code: 200,
            message: 'Password changed successfully',
        });
    });
});

// get all users
app.get('/users', verifyToken, (req, res) => {
    const query = 'SELECT * FROM users ORDER BY id DESC';
    db.query(query, (err, result) => {
        if (err) {
            return res.status(500).json({
                status_code: 500,
                message: 'Error getting users',
            });
        }
        res.status(200).json({
            status_code: 200,
            message: 'Users fetched successfully',
            data: result,
        });
    });
});


// add new user
app.post('/users', verifyToken, (req, res) => {
    const { username, serialnumber, gender, email, card_uid, device_uid, device_dep } = req.body;
    const query = 'INSERT INTO users (username, serialnumber, gender, email, card_uid, device_uid, device_dep, user_date) VALUES (?, ?, ?, ?, ?, ?, ?, CURDATE())';
    
    db.query(query, [username, serialnumber, gender, email, card_uid, device_uid, device_dep], (err, result) => {
        if (err) {
            return res.status(500).json({
                status_code: 500,
                message: 'Error adding user',
                error: err.message
            });
        }
        res.status(201).json({
            status_code: 201,
            message: 'User added successfully',
            data: { id: result.insertId }
        });
    });
});

// update user
app.put('/users/:id', verifyToken, (req, res) => {
    const userId = req.params.id;
    const { username, serialnumber, gender, email,  device_dep } = req.body;
    const query = 'UPDATE users SET username = ?, serialnumber = ?, gender = ?, email = ?, device_dep = ?, add_card = ? WHERE id = ?';
    
    db.query(query, [username, serialnumber, gender, email, device_dep, 1, userId], (err, result) => {
        if (err) {
            console.log(err);
            return res.status(500).json({
                status_code: 500,
                message: 'Error updating user',
                error: err.message
            });
        }
        if (result.affectedRows === 0) {
            return res.status(404).json({
                status_code: 404,
                message: 'User not found'
            });
        }
        res.status(200).json({
            status_code: 200,
            message: 'User updated successfully'
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
                message: 'Error deleting user',
                error: err.message
            });
        }
        if (result.affectedRows === 0) {
            return res.status(404).json({
                status_code: 404,
                message: 'User not found'
            });
        }
        res.status(200).json({
            status_code: 200,
            message: 'User deleted successfully'
        });
    });
});



// get all devices
app.get('/devices', verifyToken, (req, res) => {
    const query = 'SELECT * FROM devices';
    db.query(query, (err, result) => {
        if (err) {
            return res.status(500).json({
                status_code: 500,
                message: 'Error getting devices',
            });
        }
        res.status(200).json({
            status_code: 200,
            message: 'Devices fetched successfully',
            data: result,
        });
    });
});


// add new device
app.post('/devices', verifyToken, (req, res) => {
    const { device_name, device_dep } = req.body;
    const query = 'INSERT INTO devices (device_name, device_dep, device_uid, device_date) VALUES (?, ?, ?, CURDATE())';

    // 8f19e31055c56b05 random uid
    const device_uid = Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
    // 2021-06-21
    const device_date = new Date().toISOString().split('T')[0];
    
    db.query(query, [device_name, device_dep, device_uid, device_date], (err, result) => {
        if (err) {
            return res.status(500).json({
                status_code: 500,
                message: 'Error adding device',
                error: err.message
            });
        }
        res.status(201).json({
            status_code: 201,
            message: 'Device added successfully',
            data: { id: result.insertId }
        });
    });
});

// update device
app.put('/devices/:id', verifyToken, (req, res) => {
    const deviceId = req.params.id;
    const { device_name, device_dep, device_uid, device_mode } = req.body;
    console.log(req.body);
    const query = 'UPDATE devices SET device_name = ?, device_dep = ?, device_uid = ?, device_mode = ? WHERE id = ?';
    
    db.query(query, [device_name, device_dep, device_uid, device_mode, deviceId], (err, result) => {
        if (err) {
            return res.status(500).json({
                status_code: 500,
                message: 'Error updating device',
                error: err.message
            });
        }
        if (result.affectedRows === 0) {
            return res.status(404).json({
                status_code: 404,
                message: 'Device not found'
            });
        }
        res.status(200).json({
            status_code: 200,
            message: 'Device updated successfully'
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
                message: 'Error deleting device',
                error: err.message
            });
        }
        if (result.affectedRows === 0) {
            return res.status(404).json({
                status_code: 404,
                message: 'Device not found'
            });
        }
        res.status(200).json({
            status_code: 200,
            message: 'Device deleted successfully'
        });
    });
});


// get all users log
app.get('/users-log', verifyToken, (req, res) => {
    // sort by date desc if the same date, sort by timeout desc
    const query = 'SELECT * FROM users_logs ORDER BY checkindate DESC, timeout DESC';
    db.query(query, (err, result) => {
        if (err) {
            return res.status(500).json({
                status_code: 500,
                message: 'Error getting users log',
            });
        }
        res.status(200).json({
            status_code: 200,
            message: 'Users log fetched successfully',
            data: result,
        });
    });
});

// add user log
app.post('/users-log', verifyToken, async (req, res) => {
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
                message: 'Unauthorized!',
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
                    message: 'Not registerd!',
                });
            }

            if (user.device_uid !== device_uid && user.device_uid !== 0) {
                return res.status(400).json({
                    status_code: 400,
                    message: 'Not Allowed!',
                });
            }

            const currentDate = moment().format('YYYY-MM-DD');
            const currentTime = moment().format('HH:mm:ss');

            // Check if user already has any log today
            const [logs] = await db.promise().query(
                'SELECT * FROM users_logs WHERE card_uid = ? AND checkindate = ? ORDER BY id DESC LIMIT 1',
                [card_uid, currentDate]
            );
            const existingLog = logs[0];

            // Handle login/logout
            if (!existingLog) {
                // First check-in of the day
                await db.promise().query(
                    'INSERT INTO users_logs (username, serialnumber, card_uid, device_uid, device_dep, checkindate, timein, timeout) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
                    [user.username, user.serialnumber, card_uid, device_uid, device_dep, currentDate, currentTime, '00:00:00']
                );
                io.emit('attendance', {
                    status_code: 200,
                    message: 'Check in ' + user.username,
                });
                return res.status(200).json({
                    status_code: 200,
                    message: 'Check in ' + user.username,
                });
            } else {
                // Update the last log's timeout
                await db.promise().query(
                    'UPDATE users_logs SET timeout = ? WHERE card_uid = ? AND checkindate = ? AND id = ?',
                    [currentTime, card_uid, currentDate, existingLog.id]
                );
                io.emit('attendance', {
                    status_code: 200,
                    message: 'Check out ' + user.username,
                });
                return res.status(200).json({
                    status_code: 200,
                    message: 'Check out ' + user.username,
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
                    message: 'Card ' + card_uid + ' is available',
                });
                return res.status(400).json({
                    status_code: 400,
                    message: 'Card ' + card_uid + ' is available',
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
                    message: 'Add Card ' + card_uid,
                    data: newUser
                });
                return res.status(200).json({
                    status_code: 200,
                    message: 'Add Card ' + card_uid,
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

