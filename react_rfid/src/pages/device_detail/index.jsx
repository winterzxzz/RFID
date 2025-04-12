import React, { useState, useEffect } from 'react';
import { Button, Modal, Card } from 'antd';
import { useLocation } from 'react-router-dom';
import * as XLSX from 'xlsx';
import apiClient from '../../configs/api_client';
import { toast } from 'react-toastify';
import io from 'socket.io-client';
import { EnvironmentOutlined, PhoneOutlined, MailOutlined, GlobalOutlined, DeleteOutlined } from '@ant-design/icons';

const DeviceDetailPage = () => {

  const location = useLocation();
  const device = location.state?.deviceData;

  console.log(device);

  // id: 1, device_name: "ESP32", device_dep: "DTVT", device_uid: "8f19e31055c56b05", device_date: "2021-06-20T17:00:00.000Z", device_mode: 1 }



  const [loading, setLoading] = useState(false);
  const [deviceDetail, setDeviceDetail] = useState(device);
  const [userDevices, setUserDevices] = useState([]);
  const [exportLoading, setExportLoading] = useState(false);

  // Filter and export function
  const handleExport = async () => {
    setExportLoading(true);
    try {
      const response = await apiClient.get(`/user-devices/${device.id}`);
      const data = response.data;
      if (data['status_code'] == 200) {
        const workbook = XLSX.utils.book_new();
        const worksheet = XLSX.utils.json_to_sheet(data['data']);
        XLSX.utils.book_append_sheet(workbook, worksheet, 'User Devices');
        XLSX.writeFile(workbook, `user_devices_${device.device_name}.xlsx`);
      } else {
        toast.error(data['message']);
      }
    } catch (error) {
      toast.error(error.response.data.message);
    } finally {
      setExportLoading(false);
    }
  };

  useEffect(() => {
    fetchUserDevices();
  }, []);



  const fetchUserDevices = async () => {
    setLoading(true);
    try {
      const response = await apiClient.get(`/user-devices/${device.id}`);
      const data = response.data;
      if (data['status_code'] == 200) {
        setUserDevices(data['data']);
      } else {
        toast.error(data['message']);
      }
    } catch (error) {
      toast.error(error.response.data.message);
    } finally {
      setLoading(false);
    }
  };

  const handleDeleteUser = async (userId) => {
    Modal.confirm({
      title: 'Bạn có chắc chắn muốn xoá thiết bị này?',
      content: 'Hành động này không thể hoàn tác.',
      okText: 'Xoá',
      okType: 'danger',
      cancelText: 'Hủy',
      onOk: async () => {

        try {
          const response = await apiClient.delete(`/user-devices/${userId}/${device.id}`);
          const data = response.data;
          if (data['status_code'] == 200) {
            toast.success(data['message']);
            let newUserDevices = userDevices.filter(user => user.id !== userId);
            setUserDevices(newUserDevices);
          } else {
            toast.error(data['message']);
          }
        } catch (error) {
          toast.error(error.response.data.message);
        }
      }
  });
  };


  if (loading) {
    // circular loading
    return <div className="loading-container">
      <div className="loading-spinner"></div>
    </div>;
  } 

  return (
    <div className="p-4 w-full">
      <div className="flex gap-4 mb-4 justify-between items-center">
        <h2 className="text-2xl font-semibold">
          Thông tin thiết bị
        </h2>

        <div className="flex gap-4 items-center">
          <Button
            type="primary"
            onClick={handleExport}
            style={{ backgroundColor: '#0d9488' }}
            loading={exportLoading}
          >
            XUẤT EXCEL
          </Button>
        </div>
      </div>

      <div className='grid grid-cols-12 gap-4'>
        {/* Device info card */}
        <div className='col-span-4'>
          <Card className="h-full" style={{ boxShadow: '0 4px 8px rgba(0,0,0,0.1)' }}>
            <div className="p-2">
              <h3 className="text-lg font-bold text-gray-800">{deviceDetail.device_name ?? "N/A"}</h3>
              <p className="text-sm text-yellow-600 font-bold mb-4">{deviceDetail.device_dep ?? "N/A"}</p>
              
              <div className="border-t border-gray-200 my-2"></div>
              
              <div className="flex items-center mt-3">
                <PhoneOutlined className="text-yellow-500 mr-3" />
                <span className="text-gray-700 mr-2">Trạng thái: </span>
                <span className="text-black font-bold">{(deviceDetail.device_mode ?? "N/A") == 0 ? 'ĐĂNG KÝ' : 'ĐIỂM DANH'}</span>
              </div>
              
              <div className="flex items-center mt-3">
                <MailOutlined className="text-yellow-500 mr-3" />
                <span className="text-gray-700 mr-2">ID: </span>
                <span className="text-black font-bold">{deviceDetail.id ?? "N/A"}</span>
              </div>
              
              <div className="flex items-center mt-3">
                <EnvironmentOutlined className="text-yellow-500 mr-3" />
                <span className="text-gray-700 mr-2">Mã thiết bị: </span>
                <span className="text-black font-bold">{deviceDetail.device_uid ?? "N/A"}</span>
              </div>
              
              <div className="flex items-center mt-3">
                <GlobalOutlined className="text-yellow-500 mr-3" />
                <span className="text-gray-700 mr-2">Ngày cập nhật: </span>
                <span className="text-black font-bold">{new Date(deviceDetail.device_date).toLocaleDateString('vi-VN', { 
                        year: 'numeric', 
                        month: '2-digit', 
                        day: '2-digit' 
                      })}</span>
              </div>
            </div>
          </Card>
        </div>

        {/* Users table */}
        <div className='col-span-8'>
          <Card className="h-full shadow-md">
            <div className="overflow-x-auto">
              <table className="w-full">
                <thead>
                  <tr>
                    <th className="p-3 text-left font-semibold">ID | TÊN SINH VIÊN</th>
                    <th className="p-3 text-left font-semibold">MÃ SINH VIÊN</th>
                    <th className="p-3 text-left font-semibold">EMAIL</th>
                    <th className="p-3 text-left font-semibold">GIỚI TÍNH</th>
                    <th className="p-3 text-left font-semibold">CARD UID</th>
                    <th className="p-3 text-left font-semibold">NGÀY TẠO</th>
                    <th className="p-3 text-left font-semibold">HÀNH ĐỘNG</th>
                  </tr>
                </thead>
                <tbody>
                  {userDevices.map((log) => (
                    <tr key={log.id} className="border-b hover:bg-gray-50">
                      <td className="p-3">{log.user_id} | {log.username}</td>
                      <td className="p-3">{log.serialnumber}</td>
                      <td className="p-3">{log.email}</td>
                      <td className="p-3">{log.gender}</td>
                      <td className="p-3">
                        <span className="bg-blue-100 text-blue-800 px-2 py-1 rounded-full text-sm">
                          {log.card_uid}
                        </span>
                      </td>
                      <td className="p-3">{new Date(log.user_date).toLocaleDateString('vi-VN', { 
                        year: 'numeric', 
                        month: '2-digit', 
                        day: '2-digit' 
                      })}</td>
                      <td className="p-3">
                        <Button type="primary" icon={<DeleteOutlined />} onClick={() => handleDeleteUser(log.id)} />
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </Card>
        </div>
      </div>
    </div>
  );
};

export default DeviceDetailPage;
