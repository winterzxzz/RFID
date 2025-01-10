import React, { useState, useEffect } from 'react';
import { Button, DatePicker, Select, Pagination } from 'antd';
import * as XLSX from 'xlsx';
import apiClient from '../../configs/api_client';
import { toast } from 'react-toastify';
import io from 'socket.io-client';

const UserLogs = () => {
  const [logs, setLogs] = useState([]);
  const [filteredLogs, setFilteredLogs] = useState([]);
  const [loading, setLoading] = useState(false);
  const [dateRange, setDateRange] = useState(null);
  const [departments, setDepartments] = useState([]);
  const [department, setDepartment] = useState(null);
  const [sortConfig, setSortConfig] = useState({ key: null, direction: 'ascending' });
  const initPagination = {
    total: 0,
    totalPages: 0,
    currentPage: 1,
    limit: 20
  };
  const [pagination, setPagination] = useState(initPagination);

  // Filter and export function
  const handleExport = () => {
    // Create worksheet
    const ws = XLSX.utils.json_to_sheet(filteredLogs);
    const wb = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(wb, ws, "User Logs");
    
    // Export to Excel
    // name user logs + date range
    const dateRangeString = dateRange ? `${dateRange[0].format('YYYY-MM-DD')} to ${dateRange[1].format('YYYY-MM-DD')}` : '';
    XLSX.writeFile(wb, `user_logs_${dateRangeString}.xlsx`);
  };

  useEffect(() => {
    fetchUserLogs();
  }, [pagination.currentPage, pagination.limit]);

  useEffect(() => {
    // Initialize socket connection
    const newSocket = io('http://localhost:3000'); // adjust URL to match your server

    // Listen for new logs
    newSocket.on('attendance', (newLog) => {
        toast.success(newLog.message);
        handleFilter();
    });

    // Cleanup on component unmount
    return () => newSocket.disconnect();
  }, []);

  const fetchUserLogs = async () => {   
    setLoading(true);
    try {
      console.log(department, dateRange);
      let query = `?page=${pagination.currentPage}&limit=${pagination.limit}`;
      if(dateRange != null) {
        query += `&date_start=${dateRange[0]}&date_end=${dateRange[1]}`;
      }
      if(department != null) {
        query += `&device_dep=${department}`;
      }
      const response = await apiClient.get(`/users-log${query}`);
      const data = response.data;
      if(data['status_code'] == 200) {
        setLogs([...data['data']['items']]);
        setFilteredLogs([...data['data']['items']]);
        setPagination(data['data']['pagination']);
        // Create a Set from the departments extracted from logs
        if(departments.length == 0) {
          const uniqueDepartments = [...new Set(data['data']['items'].map(log => log.device_dep))];
          setDepartments(uniqueDepartments);
        }
      } else {
        toast.error(data['message']);
      }
    } catch (error) {
      toast.error(error.response.data.message);
    } finally {
      setLoading(false);
    }
  };

  const handleFilter = async () => {
    setLoading(true);
    try {
      let query = `?page=1&limit=${pagination.limit}`;
      if(dateRange != null) {
        query += `&date_start=${dateRange[0]}&date_end=${dateRange[1]}`;
      }
      if(department != null) {
        query += `&device_dep=${department}`;
      }

      const response = await apiClient.get(`/users-log${query}`);
      const data = response.data;
      if(data['status_code'] == 200) {
        setLogs([...data['data']['items']]);
        setFilteredLogs([...data['data']['items']]);
        setPagination(data['data']['pagination']);
      } else {
        toast.error(data['message']);
      }
    } catch (error) {
      toast.error(error.response.data.message);
    } finally {
      setLoading(false);
    }
  };

  const handleSort = (key) => {
    let direction = 'ascending';
    if (sortConfig.key === key && sortConfig.direction === 'ascending') {
      direction = 'descending';
    }
    setSortConfig({ key, direction });

    const sortedLogs = [...filteredLogs].sort((a, b) => {
      if (a[key] < b[key]) return direction === 'ascending' ? -1 : 1;
      if (a[key] > b[key]) return direction === 'ascending' ? 1 : -1;
      return 0;
    });
    setFilteredLogs(sortedLogs);
  };

  if(loading) {
    // circular loading
    return <div className="loading-container">
        <div className="loading-spinner"></div>
    </div>;
} else {
    if(logs.length === 0) {
        return <div>Không có dữ liệu</div>;
    }
}

  return (
    <div className="p-6">
      <h1 className="text-center text-3xl mb-6">
        LỊCH SỬ ĐIỂM DANH
      </h1>
      
      {/* Add filter controls */}
      <div className="flex justify-center gap-4 mb-8">
        <DatePicker.RangePicker 
          onChange={(dates) => {
            setDateRange(dates);
          }}
          value={dateRange}
          allowClear
          onClear={() => {
            setDateRange(null);
          }}
          placeholder="Chọn ngày"
          style={{ width: '256px', margin: '8px' }}
        />


        <Select
          placeholder="Chọn phòng ban"
          onChange={(value) => {
            setDepartment(value);
          }}
          value={department}
          onClear={() => {
            setDepartment(null);
          }}
          allowClear
          style={{ width: '192px' }}
          options={departments.map(dep => ({ value: dep, label: dep }))}
        />
        
        <Button 
          type="primary" 
          onClick={() => handleFilter()} 
          style={{ backgroundColor: '#0d9488', margin: '8px' }}
        >
          LỌC
        </Button>
        <Button 
          type="primary" 
          onClick={handleExport} 
          style={{ backgroundColor: '#0d9488' }}
        >
          XUẤT EXCEL
        </Button>
      </div>

      <div className="overflow-x-auto">
        <table className="w-full bg-white shadow-md rounded">
          <thead className="bg-sky-100">
            <tr>
              <th className="p-3 text-left cursor-pointer" onClick={() => handleSort('id')}>
                ID {sortConfig.key === 'id' && (sortConfig.direction === 'ascending' ? '↑' : '↓')}
              </th>
              <th className="p-3 text-left cursor-pointer" onClick={() => handleSort('username')}>
                 TÊN SINH VIÊN {sortConfig.key === 'username' && (sortConfig.direction === 'ascending' ? '↑' : '↓')}
              </th>
              <th className="p-3 text-left cursor-pointer" onClick={() => handleSort('serialnumber')}>
                MÃ SINH VIÊN {sortConfig.key === 'serialnumber' && (sortConfig.direction === 'ascending' ? '↑' : '↓')}
              </th>
              <th className="p-3 text-left cursor-pointer" onClick={() => handleSort('card_uid')}>
                CARD UID {sortConfig.key === 'card_uid' && (sortConfig.direction === 'ascending' ? '↑' : '↓')}
              </th>
              <th className="p-3 text-left cursor-pointer" onClick={() => handleSort('device_dep')}>
                THIẾT BỊ PHÒNG {sortConfig.key === 'device_dep' && (sortConfig.direction === 'ascending' ? '↑' : '↓')}
              </th>
              <th className="p-3 text-left cursor-pointer" onClick={() => handleSort('checkindate')}>
                NGÀY {sortConfig.key === 'checkindate' && (sortConfig.direction === 'ascending' ? '↑' : '↓')}
              </th>
              <th className="p-3 text-left cursor-pointer" onClick={() => handleSort('timein')}>
                GIỜ VÀO {sortConfig.key === 'timein' && (sortConfig.direction === 'ascending' ? '↑' : '↓')}
              </th>
              <th className="p-3 text-left cursor-pointer" onClick={() => handleSort('timeout')}>
                GIỜ RA {sortConfig.key === 'timeout' && (sortConfig.direction === 'ascending' ? '↑' : '↓')}
              </th>
            </tr>
          </thead>
          <tbody>
            {filteredLogs.map((log) => (
              <tr key={log.id} className="border-b hover:bg-gray-50">
                <td className="p-3">{log.id}</td>
                <td className="p-3">{log.username}</td>
                <td className="p-3">{log.serialnumber}</td>
                <td className="p-3">{log.card_uid}</td>
                <td className="p-3">{log.device_dep}</td>
                {/* date format */}
                <td className="p-3">{new Date(log.checkindate).toLocaleDateString()}</td>
                <td className="p-3">{log.timein}</td>
                <td className="p-3">{log.timeout}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      <div style={{ marginTop: '16px', display: 'flex', justifyContent: 'center' }}>
        <Pagination
          current={pagination.currentPage}
          pageSize={pagination.limit}
          total={pagination.total}
          pageSizeOptions={['10', '20', '30', '40', '50']}
          onChange={(page, size) => {
            console.log(page, size);
            setPagination({
              ...pagination,
              currentPage: page,
              limit: size, 
            });
          }}
          showSizeChanger
          showQuickJumper
          style={{ color: '#ffffff' }}
        />
      </div>
    </div>
  );
};

export default UserLogs;
