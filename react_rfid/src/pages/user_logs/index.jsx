import React, { useState, useEffect } from 'react';
import { Button, DatePicker, Select } from 'antd';
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
  }, []);

  useEffect(() => {
    // Initialize socket connection
    const newSocket = io('http://localhost:3000'); // adjust URL to match your server

    // Listen for new logs
    newSocket.on('attendance', (newLog) => {
        toast.success(newLog.message);
        fetchUserLogs();
    });

    // Cleanup on component unmount
    return () => newSocket.disconnect();
  }, []);

  const fetchUserLogs = async () => {   
    setLoading(true);
    try {
      const response = await apiClient.get('/users-log');
      const data = response.data;
      if(data['status_code'] == 200) {
        setLogs([...data['data']]);
        setFilteredLogs([...data['data']]);
        // Get unique departments using Set
        const uniqueDepartments = [...new Set(data['data'].map(log => log.device_dep))];
        setDepartments(uniqueDepartments);
      } else {
        toast.error(data['message']);
      }
    } catch (error) {
      toast.error(error.response.data.message);
    } finally {
      setLoading(false);
    }
  };

  const handleFilter = () => {
    if(dateRange == null && department == null) {
        setFilteredLogs(logs);
    } else {
        if(dateRange == null) {
            setFilteredLogs(logs.filter(log => log.device_dep === department));
        }
        if(department == null) {
            setFilteredLogs(logs.filter(log => {
                const logDate = new Date(log.checkindate.split('T')[0]); 
                return logDate >= new Date(dateRange[0]) && logDate <= new Date(dateRange[1]);
            }));
        }
        if(dateRange != null && department != null) {
            setFilteredLogs(logs.filter(log => {
                const logDate = new Date(log.checkindate.split('T')[0]); 
                return logDate >= new Date(dateRange[0]) && logDate <= new Date(dateRange[1]) && log.device_dep === department;
            }));
        }
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
        return <div>No user logs found</div>;
    }
}

  return (
    <div className="p-6">
      <h1 className="text-center text-3xl mb-6">
        HERE ARE THE USERS DAILY LOGS
      </h1>
      
      {/* Add filter controls */}
      <div className="flex justify-center gap-4 mb-8">
        <DatePicker.RangePicker 
          onChange={(dates) => {
            setDateRange(dates);
          }}
          style={{ width: '256px', margin: '8px' }}
        />


        <Select
          placeholder="Select Department"
          onChange={(value) => {
            setDepartment(value);
          }}
          style={{ width: '192px' }}
          options={departments.map(dep => ({ value: dep, label: dep }))}
        />
        
        <Button 
          type="primary" 
          onClick={handleFilter} 
          style={{ backgroundColor: '#0d9488', margin: '8px' }}
        >
          Filter
        </Button>
        <Button 
          type="primary" 
          onClick={handleExport} 
          style={{ backgroundColor: '#0d9488' }}
        >
          Export to Excel
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
                NAME {sortConfig.key === 'username' && (sortConfig.direction === 'ascending' ? '↑' : '↓')}
              </th>
              <th className="p-3 text-left cursor-pointer" onClick={() => handleSort('serialnumber')}>
                SERIAL NUMBER {sortConfig.key === 'serialnumber' && (sortConfig.direction === 'ascending' ? '↑' : '↓')}
              </th>
              <th className="p-3 text-left cursor-pointer" onClick={() => handleSort('card_uid')}>
                CARD UID {sortConfig.key === 'card_uid' && (sortConfig.direction === 'ascending' ? '↑' : '↓')}
              </th>
              <th className="p-3 text-left cursor-pointer" onClick={() => handleSort('device_dep')}>
                DEVICE DEP {sortConfig.key === 'device_dep' && (sortConfig.direction === 'ascending' ? '↑' : '↓')}
              </th>
              <th className="p-3 text-left cursor-pointer" onClick={() => handleSort('checkindate')}>
                DATE {sortConfig.key === 'checkindate' && (sortConfig.direction === 'ascending' ? '↑' : '↓')}
              </th>
              <th className="p-3 text-left cursor-pointer" onClick={() => handleSort('timein')}>
                TIME IN {sortConfig.key === 'timein' && (sortConfig.direction === 'ascending' ? '↑' : '↓')}
              </th>
              <th className="p-3 text-left cursor-pointer" onClick={() => handleSort('timeout')}>
                TIME OUT {sortConfig.key === 'timeout' && (sortConfig.direction === 'ascending' ? '↑' : '↓')}
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
    </div>
  );
};

export default UserLogs;
