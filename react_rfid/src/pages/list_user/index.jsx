import React, { useState, useEffect } from 'react';
import { Table, Space, Button, Modal, Form, Input, Select } from 'antd';
import { PlusOutlined } from '@ant-design/icons';
import { EditOutlined, DeleteOutlined } from '@ant-design/icons';
import apiClient from '../../configs/api_client';
import { toast } from 'react-toastify';
import { useNavigate } from 'react-router-dom';
import io from 'socket.io-client';

const UserList = () => {
    const [users, setUsers] = useState([]);
    const [loading, setLoading] = useState(false);
    const [isModalVisible, setIsModalVisible] = useState(false);
    const [editingUser, setEditingUser] = useState(null);
    const [form] = Form.useForm();


    // Fetch users data
    useEffect(() => {
        fetchUsers();
    }, []);

    useEffect(() => {
        // Initialize socket connection
        const newSocket = io('http://localhost:3000');
    
        // Listen for new logs
        newSocket.on('add-card', (newLog) => {
            if(newLog.status_code === 200) {
                toast.success(newLog.message);
                setUsers(prevUsers => [newLog.data, ...prevUsers]);
            } else {
                toast.warning(newLog.message);
            }
        });
    
        return () => newSocket.disconnect();
    }, []);

    const fetchUsers = async () => {
        setLoading(true);
        try {
            const response = await apiClient.get('/users');
            const data = response.data;
            if(data['status_code'] == 200) {
                setUsers([...data['data']]);
            } else {
                toast.error(data['message']);
            }
        } catch (error) {
            toast.error(error.response.data.message);   
        } finally {
            setLoading(false);
        }
    };

    const handleEdit = (user) => {
        setEditingUser(user);
        form.setFieldsValue(user);
        setIsModalVisible(true);
    };

    const handleAdd = () => {
        setEditingUser(null);
        form.resetFields();
        setIsModalVisible(true);
    };

    const handleModalSubmit = async () => {
        try {
            const values = await form.validateFields();
            if (editingUser) {
                // Handle update
                const response = await apiClient.put(`/users/${editingUser.id}`, {
                    username: values.username,
                    serialnumber: values.serialnumber,
                    gender: values.gender,
                    email: editingUser.email,
                    card_uid: values.card_uid,
                    device_uid: editingUser.device_uid,
                    device_dep: values.device_dep
                });
                if (response.data.status_code === 200) {
                    toast.success('User updated successfully');
                    setUsers(users.map(user => user.id === editingUser.id ? response.data.data : user));
                }
            } else {
                // Handle create
                const response = await apiClient.post('/users', {
                    username: values.username,
                    serialnumber: values.serialnumber,
                    gender: values.gender,
                    email: editingUser.email,
                    card_uid: values.card_uid,
                    device_uid: editingUser.device_uid,
                    device_dep: values.device_dep
                });
                if (response.data.status_code === 200) {
                    toast.success('User created successfully');
                    setUsers([...users, response.data.data]);
                }
            }
            fetchUsers();
            setIsModalVisible(false);
        } catch (error) {
            toast.error(error.response.data.message);
        }
    };

    const handleDelete = async (userId) => {
        Modal.confirm({
            title: 'Are you sure you want to delete this user?',
            content: 'This action cannot be undone.',
            okText: 'Yes',
            okType: 'danger',
            cancelText: 'No',
            onOk: async () => {
                try {
                    const response = await apiClient.delete(`/users/${userId}`);
                    if (response.data.status_code === 200) {
                        toast.success('User deleted successfully');
                        fetchUsers();
                    } else {
                        toast.error(response.data.message);
                    }
                } catch (error) {
                    toast.error(error.response.data.message);
                }
            }
        });
    };
    
    if(loading) {
        // circular loading
        return <div className="loading-container">
            <div className="loading-spinner"></div>
        </div>;
    } else {
        if(users.length === 0) {
            return <div>No users found</div>;
        }
    }
    

    return (
        <div style={{ padding: '24px' }}>
            <main>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '16px' }}>
                    <h2>HERE ARE ALL THE USERS</h2>
                    {/* <Button 
                        type="primary" 
                        icon={<PlusOutlined />}
                        onClick={handleAdd}
                    >
                        Add User
                    </Button> */}
                </div>
                <table>
                    <thead>
                        <tr>
                            <th>ID | NAME</th>
                            <th>SERIAL NUMBER</th>
                            <th>GENDER</th>
                            <th>CARD UID</th>
                            <th>DATE</th>
                            <th>DEVICE</th>
                            <th>ACTIONS</th>
                        </tr>
                    </thead>
                    <tbody>
                        {users.map(user => (
                            <tr 
                                key={user.id}
                                style={{
                                    backgroundColor: user.add_card == 0 ? '#ffebcc' : 'transparent',
                                    color: user.add_card == 0 ? 'black' : 'inherit'
                                }}
                            >
                                <td>{user.id} | {user.username}</td>
                                <td>{user.serialnumber}</td>
                                <td>{user.gender}</td>
                                <td>{user.card_uid}</td>
                                <td>{new Date(user.user_date).toLocaleDateString('en-US', {
                                    year: 'numeric',
                                    month: 'long',
                                    day: 'numeric',
                                    hour: '2-digit',
                                    minute: '2-digit'
                                })}</td>
                                <td>{user.device_dep}</td>
                                <td>
                                    <Space>
                                        <Button
                                            type="primary"
                                            icon={<EditOutlined />}
                                            onClick={() => handleEdit(user)}
                                        >
                                            Edit
                                        </Button>
                                        <Button
                                            danger
                                            icon={<DeleteOutlined />}
                                            onClick={() => handleDelete(user.id)}
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
                title={editingUser ? 'Edit User' : 'Add User'}
                open={isModalVisible}
                onOk={handleModalSubmit}
                onCancel={() => setIsModalVisible(false)}
            >
                <Form
                    form={form}
                    layout="vertical"
                >
                    <Form.Item
                        name="username"
                        label="Username"
                        rules={[{ required: true, message: 'Please input username!' }]}
                    >
                        <Input />
                    </Form.Item>
                    <Form.Item
                        name="serialnumber"
                        label="Serial Number"
                        rules={[{ required: true, message: 'Please input serial number!' }]}
                    >
                        <Input />
                    </Form.Item>
                    <Form.Item
                        name="gender"
                        label="Gender"
                        rules={[{ required: true, message: 'Please select gender!' }]}
                    >
                        <Select
                            placeholder="Select gender"
                        >
                            <Select.Option value="Male">Male</Select.Option>
                            <Select.Option value="Female">Female</Select.Option>
                        </Select>
                    </Form.Item>
                    <Form.Item
                        name="email"
                        label="Email"
                        rules={[{ required: true, message: 'Please input email!' }]}
                    >
                        <Input />
                    </Form.Item>
                    <Form.Item
                        name="device_dep"
                        label="Device"
                        rules={[{ required: true, message: 'Please input device!' }]}
                    >
                        <Select
                            placeholder="Select device"
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

export default UserList;

