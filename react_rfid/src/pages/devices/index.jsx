import React, { useState, useEffect } from 'react';
import { Table, Space, Button, Modal, Form, Input, Select } from 'antd';
import { PlusOutlined } from '@ant-design/icons';
import { EditOutlined, DeleteOutlined } from '@ant-design/icons';
import apiClient from '../../configs/api_client';
import { toast } from 'react-toastify';
import { useNavigate } from 'react-router-dom';


const DevicesPage = () => {
    const [devices, setDevices] = useState([]);
    const [isLoading, setIsLoading] = useState(false);
    const [isModalVisible, setIsModalVisible] = useState(false);
    const [editingDevice, setEditingDevice] = useState(null);
    const [form] = Form.useForm();

    useEffect(() => {
        fetchDevices();
    }, []);

    const fetchDevices = async () => {
        setIsLoading(true);
        try {
            const response = await apiClient.get('/devices');
            const data = response.data;
            if (data['status_code'] == 200) {
                setDevices([...data['data']]);
            } else {
                toast.error(data['message']);
            }
        } catch (error) {
            toast.error('Failed to fetch devices: ' + error.message);
        } finally {
            setIsLoading(false);
        }
    };

    const handleEdit = (device) => {
        setEditingDevice(device);
        form.setFieldsValue(device);
        setIsModalVisible(true);
    };

    const handleAdd = () => {
        setEditingDevice(null);
        form.resetFields();
        setIsModalVisible(true);
    };

    const handleModalSubmit = async () => {
        try {
            const values = await form.validateFields();
            if (editingDevice) {
                // Handle update
                const response = await apiClient.put(`/devices/${editingDevice.id}`, values);
                if (response.data.status_code === 200) {
                    fetchDevices();
                }
            } else {
                // Handle create
                const response = await apiClient.post('/devices', values);
                if (response.data.status_code === 200) {
                    toast.success('Device created successfully');
                    fetchDevices();
                }
            }
            setIsModalVisible(false);
        } catch (error) {
            toast.error('Error: ' + error.message);
        }
    };

    const handleUpdate = async (device) => {
        try {
            const response = await apiClient.put(`/devices/${device.id}`, device);
            if (response.data.status_code === 200) {
                fetchDevices();
            }
        } catch (error) {
            toast.error('Error: ' + error.message);
        }
    };

    const handleDelete = async (deviceId) => {
        Modal.confirm({
            title: 'Are you sure you want to delete this device?',
            content: 'This action cannot be undone.',
            okText: 'Yes',
            okType: 'danger',
            cancelText: 'No',
            onOk: async () => {
                try {
                    const response = await apiClient.delete(`/devices/${deviceId}`);
                    if (response.data.status_code === 200) {
                        fetchDevices();
                    } else {
                        toast.error(response.data.message);
                    }
                } catch (error) {
                    toast.error('Error deleting device: ' + error.message);
                }
            }
        });
    };


    if (isLoading) {
        // circular loading
        return <div className="loading-container">
            <div className="loading-spinner"></div>
        </div>;
    } else {
        if (devices.length === 0) {
            return <div>No devices found</div>;
        }
    }

    return (
        <div style={{ padding: '24px' }}>
            <main>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '16px' }}>
                    <h2>Manage Devices</h2>
                    <Button
                        type="primary"
                        icon={<PlusOutlined />}
                        onClick={handleAdd}
                    >
                        Add Device
                    </Button>
                </div>
                <table>
                    <thead>
                        <tr>
                            <th>De.Name</th>
                            <th>De.Department</th>
                            <th>De.UID</th>
                            <th>De.Date</th>
                            <th>De.Mode</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        {devices.map(device => (
                            <tr key={device.id}>
                                <td>{device.device_name}</td>
                                <td>{device.device_dep}</td>
                                <td>{device.device_uid}</td>
                                <td>{device.device_date}</td>
                                {/* toggle device mode */}
                                <td style={{ display: 'flex', justifyContent: 'start', gap: '10px' }}>
                                    <Button
                                        onClick={() => handleUpdate({ ...device, device_mode: device.device_mode === 0 ? 1 : 0 })}
                                        type={device.device_mode === 0 ? 'primary' : 'default'}
                                    >
                                        Enrollment
                                    </Button>

                                    <Button
                                        onClick={() => handleUpdate({ ...device, device_mode: device.device_mode === 1 ? 0 : 1 })}
                                        type={device.device_mode === 1 ? 'primary' : 'default'}
                                    >
                                        Attendance
                                    </Button>
                                </td>
                                <td>
                                    <Space>
                                        <Button
                                            type="primary"
                                            icon={<EditOutlined />}
                                            onClick={() => handleEdit(device)}
                                        >
                                            Edit
                                        </Button>
                                        <Button
                                            danger
                                            icon={<DeleteOutlined />}
                                            onClick={() => handleDelete(device.id)}
                                        >
                                            Delete
                                        </Button>
                                    </Space>
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </main>

            <Modal
                title={editingDevice ? 'Edit Device' : 'Add Device'}
                open={isModalVisible}
                onOk={handleModalSubmit}
                onCancel={() => setIsModalVisible(false)}
            >
                <Form
                    form={form}
                    layout="vertical"
                >
                    <Form.Item
                        name="device_name"
                        label="Name"
                        rules={[{ required: true, message: 'Please input name!', }]}
                    >
                        <Input />
                    </Form.Item>
                    <Form.Item
                        name="device_dep"
                        label="Department"
                        rules={[{ required: true, message: 'Please input department!' }]}
                    >
                        <Select
                            placeholder="Select department"
                        >
                            <Select.Option value="CTX">CTX</Select.Option>
                            <Select.Option value="ATTZ">ATTZ</Select.Option>
                            <Select.Option value="DTVTC">DTVTC</Select.Option>
                        </Select>
                    </Form.Item>
                </Form>
            </Modal>
        </div>
    );
};

export default DevicesPage;
