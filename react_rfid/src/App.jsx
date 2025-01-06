import { useState } from 'react'
import { BrowserRouter, Routes, Route, useNavigate } from 'react-router-dom'
import './App.css'
import UserList from './pages/list_user';
import DevicesPage from './pages/devices';
import Login from './pages/login';
import UserLogs from './pages/user_logs';
import Navigation from './components/common/navigation';
import { ToastContainer } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

function App() {
  

  return (
    <BrowserRouter>
      <div className="container">
        <header>
          <h1>RFID Attendance</h1>
          <Navigation />
        </header>

        <Routes>
          <Route path="/" element={<UserList />} />
          <Route path="/users-log" element={<UserLogs />} />
          <Route path="/devices" element={<DevicesPage />} />
          <Route path="/login" element={<Login />} />
        </Routes>
        <ToastContainer />
      </div>
    </BrowserRouter>
  )
}

export default App
