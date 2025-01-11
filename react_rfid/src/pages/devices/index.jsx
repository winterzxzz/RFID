import React, { useState, useEffect } from 'react';
import { Table, Space, Button, Modal, Form, Input, Select, Pagination } from 'antd';
import { PlusOutlined } from '@ant-design/icons';
import { EditOutlined, DeleteOutlined } from '@ant-design/icons';
import apiClient from '../../configs/api_client';
import { toast } from 'react-toastify';


const DevicesPage = () => {
    const [devices, setDevices] = useState([]);
    const [isLoading, setIsLoading] = useState(false);
    const [isModalVisible, setIsModalVisible] = useState(false);
    const [editingDevice, setEditingDevice] = useState(null);
    const [form] = Form.useForm();
    const [pagination, setPagination] = useState({
        total: 0,
        totalPages: 0,
        currentPage: 1,
        limit: 10
    });

    useEffect(() => {
        fetchDevices(pagination.currentPage, pagination.limit);
    }, [pagination.currentPage, pagination.limit]);

    const fetchDevices = async (page, limit) => {
        setIsLoading(true);
        try {
            const response = await apiClient.get(`/devices?page=${page}&limit=${limit}`);
            const data = response.data;
            if (data['status_code'] == 200) {
                setDevices([...data['data']['items']]);
                setPagination(data['data']['pagination']);
            } else {
                toast.error(data['message']);
            }
        } catch (error) {
            toast.error(error.response.data.message);
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
                const response = await apiClient.put(`/devices/${editingDevice.id}`, {
                    device_name: values.device_name,
                    device_dep: values.device_dep,
                    device_mode: editingDevice.device_mode,
                });
                if (response.data.status_code === 200) {
                    fetchDevices();
                    toast.success('Cập nhật thiết bị thành công');
                }
            } else {
                // Handle create
                const response = await apiClient.post('/devices', values);
                if (response.data.status_code === 200) {
                    fetchDevices();
                    toast.success('Thêm thiết bị thành công');
                }
            }
            setIsModalVisible(false);
        } catch (error) {
            toast.error(error.response.data.message);
        }
    };

    const handleChangeMode = async (device) => {
        try {
            const response = await apiClient.put(`/devices/${device.id}`, device);
            if (response.data.status_code === 200) {
                fetchDevices();
            }
        } catch (error) {
            toast.error(error.response.data.message);
        }
    };

    const handleDelete = async (deviceId) => {
        Modal.confirm({
            title: 'Bạn có chắc chắn muốn xoá thiết bị này?',
            content: 'Hành động này không thể hoàn tác.',
            okText: 'Xoá',
            okType: 'danger',
            cancelText: 'Hủy',
            onOk: async () => {
                try {
                    const response = await apiClient.delete(`/devices/${deviceId}`);
                    if (response.data.status_code === 200) {
                        fetchDevices();
                    } else {
                        toast.error(response.data.message);
                    }
                } catch (error) {
                    toast.error(error.response.data.message);
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
            return <div>Không có dữ liệu</div>;
        }
    }

    return (
        <div style={{ padding: '24px' }}>
            <main>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '16px' }}>

                    <div>
                    <h2>QUẢN LÝ THIẾT BỊ</h2>

                    <Button
                        type="primary"
                        icon={<PlusOutlined />}
                        onClick={handleAdd}
                    >
                        THÊM THIẾT BỊ
                    </Button>

                    </div>

                    {/* pagination */}
                    <Pagination
                        current={pagination.currentPage}
                        pageSize={pagination.limit}
                        total={pagination.total}
                        onChange={(page, size) => {
                            setPagination({
                                ...pagination,
                                currentPage: page,
                                limit: size
                            });
                        }}
                        showSizeChanger
                        showTotal={(total) => `Tổng ${total} bản ghi`}
                        style={{ color: '#ffffff' }}
                    />

                </div>
                <table>
                    <thead>
                        <tr>
                            <th>TÊN THIẾT BỊ</th>
                            <th>PHÒNG</th>
                            <th>MÃ THIẾT BỊ</th>
                            <th>NGÀY CẬP NHẬT</th>
                            <th>TRẠNG THÁI</th>
                            <th>HÀNH ĐỘNG</th>
                        </tr>
                    </thead>
                    <tbody>
                        {devices.map(device => (
                            <tr key={device.id}>
                                <td>{device.device_name}</td>
                                <td>{device.device_dep}</td>
                                <td>{device.device_uid}</td>
                                <td>{new Date(device.device_date).toLocaleDateString()}</td>
                                {/* toggle device mode */}
                                <td style={{ display: 'flex', justifyContent: 'start', gap: '10px' }}>
                                    <Button
                                        onClick={() => handleChangeMode({ ...device, device_mode: device.device_mode === 0 ? 1 : 0 })}
                                        type={device.device_mode === 0 ? 'primary' : 'default'}
                                    >
                                        ĐĂNG KÝ
                                    </Button>

                                    <Button
                                        onClick={() => handleChangeMode({ ...device, device_mode: device.device_mode === 1 ? 0 : 1 })}
                                        type={device.device_mode === 1 ? 'primary' : 'default'}
                                    >
                                        ĐIỂM DANH
                                    </Button>
                                </td>
                                <td>
                                    <Space>
                                        <Button
                                            type="primary"
                                            icon={<EditOutlined />}
                                            onClick={() => handleEdit(device)}
                                        >
                                            SỬA
                                        </Button>
                                        <Button
                                            danger
                                            icon={<DeleteOutlined />}
                                            onClick={() => handleDelete(device.id)}
                                        >
                                            XOÁ
                                        </Button>
                                    </Space>
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </main>

            <Modal
                title={editingDevice ? 'SỬA THIẾT BỊ' : 'THÊM THIẾT BỊ'}
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
                        label="TÊN THIẾT BỊ"
                        rules={[{ required: true, message: 'Vui lòng nhập tên thiết bị!', }]}
                    >
                        <Input />
                    </Form.Item>
                    <Form.Item
                        name="device_dep"
                        label="PHÒNG"
                        rules={[{ required: true, message: 'Vui lòng nhập phòng!' }]}
                    >
                        <Input />
                    </Form.Item>
                </Form>
            </Modal>
        </div>
    );
};

export default DevicesPage;
