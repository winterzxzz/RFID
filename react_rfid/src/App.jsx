import { useState } from 'react'
import { BrowserRouter, Routes, Route, useNavigate } from 'react-router-dom'
import './App.css'
import UserList from './pages/list_user';
import DevicesPage from './pages/devices';
import Login from './pages/login';
import DeviceDetailPage from './pages/device_detail';
import UserLogs from './pages/user_logs';
import Navigation from './components/common/navigation';
import { ToastContainer } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

function App() {
  

  return (
    <BrowserRouter>
      <div className="min-h-screen w-full m-0 p-5 box-border bg-gradient-to-br from-[#1a4f4f] to-[#2d8484] text-white overflow-x-hidden">
        <header className="flex justify-between items-center">
          <h1 className="text-2xl font-bold">ĐIỂM DANH SINH VIÊN</h1>
          <Navigation />
        </header>

        <Routes>
          <Route path="/users" element={<UserList />} />
          <Route path="/users-log" element={<UserLogs />} />
          <Route path="/devices" element={<DevicesPage />} />
          <Route path="/devices/:id" element={<DeviceDetailPage />} />
          <Route path="/login" element={<Login />} />
        </Routes>
        <ToastContainer />
      </div>
    </BrowserRouter>
  )
}

export default App
