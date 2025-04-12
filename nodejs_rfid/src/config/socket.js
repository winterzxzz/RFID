const { Server } = require('socket.io');
const env = require('./env');

let io;

const initSocket = (server) => {
    io = new Server(server, {
        cors: {
            origin: env.FRONTEND_URL,
            methods: ['GET', 'POST'],
            allowedHeaders: ['Authorization'],
        }
    });

    io.on('connection', (socket) => {
        console.log('A user connected:', socket.id);

        socket.on('disconnect', () => {
            console.log('A user disconnected:', socket.id);
        });
    });

    return io;
};

const getIO = () => {
    if (!io) {
        throw new Error('Socket.io not initialized!');
    }
    return io;
};

module.exports = {
    initSocket,
    getIO
};