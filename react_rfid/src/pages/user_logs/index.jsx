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
  const [exportLoading, setExportLoading] = useState(false);

  // Filter and export function
  const handleExport = async () => {
    setExportLoading(true);
    try {
      let query = '';
      if(dateRange != null) {
        query += `?date_start=${dateRange[0]}&date_end=${dateRange[1]}`;
      }
      if(department != null) {
        if(query != '') {
          query += `&device_dep=${department}`;
        } else {
          query += `?device_dep=${department}`;
        }
      }
      const response = await apiClient.get(`/users-log${query}`);
      const data = response.data;
      const users = data['data']['items'];

      // Create worksheet
      const ws = XLSX.utils.json_to_sheet(users);
      const wb = XLSX.utils.book_new();
      XLSX.utils.book_append_sheet(wb, ws, "User Logs");
      
      const dateRangeString = dateRange ? `${dateRange[0].format('YYYY-MM-DD')} to ${dateRange[1].format('YYYY-MM-DD')}` : '';
      XLSX.writeFile(wb, `user_logs_${dateRangeString}.xlsx`);
    } catch (error) {
      toast.error('Xuất file không thành công');
    } finally {
      setExportLoading(false);
    }
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
        
        setLogs(prevLogs => {
            const index = prevLogs.findIndex(log => log.id === newLog.data.id);
            if (index !== -1) {
                // Update existing log
                const updatedLogs = [...prevLogs];
                updatedLogs[index] = newLog.data;
                return updatedLogs;
            } else {
                // Add new log at the beginning
                return [newLog.data, ...prevLogs];
            }
        });

        setFilteredLogs(prevFilteredLogs => {
            const index = prevFilteredLogs.findIndex(log => log.id === newLog.data.id);
            if (index !== -1) {
                // Update existing log
                const updatedLogs = [...prevFilteredLogs];
                updatedLogs[index] = newLog.data;
                return updatedLogs;
            } else {
                // Add new log at the beginning
                return [newLog.data, ...prevFilteredLogs];
            }
        });
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

  const handleFilter = async (
    isClearDepartment = false,
    isClearDateRange = false
  ) => {
    setLoading(true);
    try {
      let query = `?page=1&limit=${pagination.limit}`;
      if(dateRange != null && !isClearDateRange) {
        query += `&date_start=${dateRange[0]}&date_end=${dateRange[1]}`;
      }
      if(department != null && !isClearDepartment) {
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
} 

  return (
    <div className="p-4">
      <div className="flex gap-4 mb-2 justify-between items-center">
      <h2>
        LỊCH SỬ ĐIỂM DANH
      </h2>
      
      {/* Add filter controls */}
      <div className="flex gap-4justify-center items-center">
        <DatePicker.RangePicker 
          onChange={(dates) => {
            console.log(dates);
            setDateRange(dates);
            if (dates === null) {
              handleFilter(false, true);
            }
          }}
          value={dateRange}
          allowClear
          placeholder="Chọn ngày"
          style={{ width: '256px', margin: '8px' }}
        />


        <Select
          placeholder="Chọn phòng ban"
          onChange={(value) => {
            setDepartment(value);
            console.log(value);
            if (value === undefined) {
              handleFilter(true, false);
            }
          }}
          value={department}
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
          loading={exportLoading}
        >
          XUẤT EXCEL
        </Button>
      </div>
      </div>

      <div className="overflow-x-auto">
        <table>
          <thead>
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
              <tr key={log.id} className="border-b">
                <td className="p-3">{log.id}</td>
                <td className="p-3">{log.username}</td>
                <td className="p-3">{log.serialnumber}</td>
                <td className="p-3">{log.card_uid}</td>
                <td className="p-3">{log.device_dep}</td>
                {/* date format */}
                <td className="p-3">{new Date(log.checkindate).toLocaleDateString(
                  'vi-VN',
                  {
                    year: 'numeric',
                    month: '2-digit',
                    day: '2-digit'
                  }
                )}</td>
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
        />
      </div>
    </div>
  );
};

export default UserLogs;
