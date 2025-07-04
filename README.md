# RFID Attendance System

A modern attendance tracking system using RFID technology with multi-platform support. The system consists of three main components:

- **Backend API** (Node.js)
- **Web Dashboard** (React)
- **Mobile App** (Flutter)

## Features

- RFID card registration and management
- Real-time attendance tracking
- Multi-device support
- User management
- Department management
- Attendance logs and reports
- Real-time notifications
- Cross-platform support (Web & Mobile)

## System Architecture

### Backend (Node.js)

- RESTful API built with Express.js
- MySQL database for data storage
- Socket.IO for real-time communication
- JWT authentication
- Support for multiple RFID devices

### Web Dashboard (React)

- Modern React.js application
- Real-time updates using Socket.IO
- Responsive design
- Device management interface
- User management interface
- Attendance monitoring

### Mobile App (Flutter)

- Cross-platform mobile application
- Real-time notifications
- Attendance tracking
- User management
- Device configuration

## Getting Started

### Prerequisites

- Node.js
- MySQL
- Flutter SDK
- XAMPP (for local development)

### Backend Setup

1. Navigate to the `nodejs_rfid` directory
2. Install dependencies:
```bash
npm install
```
3. Configure database in `src/config/db.js`
4. Start the server:
```bash
npm start
```

### Web Dashboard Setup

1. Navigate to the `react_rfid` directory
2. Install dependencies:
```bash
npm install
```
3. Configure API endpoint in `src/configs/api_client.js`
4. Start the development server:
```bash
npm start
```

### Mobile App Setup

1. Navigate to the `flutter_rfid` directory
2. Install dependencies:
```bash
flutter pub get
```
3. Configure API endpoint in app configs
4. Run the app:
```bash
flutter run
```

## Database Configuration

The system uses MySQL database. Default configuration:

```javascript
{
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'rfidattendance'
}
```

## API Endpoints

The backend provides the following main endpoints:

- `/devices` - Device management
- `/users` - User management
- `/auth` - Authentication
- `/logs` - Attendance logs
- `/user-devices` - User-Device associations

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

## License

This project is open source and available under the [MIT License](LICENSE).

## Contact

For support or queries, please open an issue in the GitHub repository.
