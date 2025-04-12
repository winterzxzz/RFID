import React, { useState, useEffect } from 'react';
import { Table, Space, Button, Modal, Form, Input, Select, Pagination    } from 'antd';
import { PlusOutlined } from '@ant-design/icons';
import { EditOutlined, DeleteOutlined } from '@ant-design/icons';
import apiClient from '../../configs/api_client';
import { toast } from 'react-toastify';
import io from 'socket.io-client';

const UserList = () => {
    const [users, setUsers] = useState([]);
    const [loading, setLoading] = useState(false);
    const [isModalVisible, setIsModalVisible] = useState(false);
    const [editingUser, setEditingUser] = useState(null);
    const [form] = Form.useForm();
    const [departments, setDepartments] = useState([]);
    const [pagination, setPagination] = useState({
        total: 0,
        totalPages: 0,
        currentPage: 1,
        limit: 10
    });

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

    // Fetch users data
    useEffect(() => {
        fetchUsers(pagination.currentPage, pagination.limit);
    }, [pagination.currentPage, pagination.limit]);


    const fetchUsers = async (page, limit) => {
        setLoading(true);
        try {
            console.log(page, limit);
            const response = await apiClient.get(`/users?page=${page}&limit=${limit}`);
            const data = response.data;
            if(data['status_code'] == 200) {
                setUsers([...data['data']['items']]);
                setPagination(data['data']['pagination']);
                setDepartments(data['data']['departments']);
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


    const handleModalSubmit = async () => {
        try {
            const values = await form.validateFields();
            if (editingUser) {
                // Handle update
                const response = await apiClient.put(`/users/${editingUser.id}`, {
                    username: values.username,
                    serialnumber: values.serialnumber,
                    gender: values.gender,
                    email: values.email,
                });
                if (response.data.status_code === 200) {
                    toast.success('Sửa thông tin sinh viên thành công');
                    setUsers(users.map(user => user.id === editingUser.id ? response.data.data : user));
                }
            } else {
                // Handle create
                // const response = await apiClient.post('/users', {
                //     username: values.username,
                //     serialnumber: values.serialnumber,
                //     gender: values.gender,
                //     email: editingUser.email,
                //     card_uid: values.card_uid,
                //     device_uid: editingUser.device_uid,
                //     device_dep: values.device_dep
                // });
                // if (response.data.status_code === 200) {
                //     toast.success('Thêm sinh viên thành công');
                //     setUsers([...users, response.data.data]);
                // }
            }
            fetchUsers();
            setIsModalVisible(false);
        } catch (error) {
            toast.error(error.response.data.message);
        }
    };

    const handleDelete = async (userId) => {
        Modal.confirm({
            title: 'Bạn có chắc chắn muốn xoá sinh viên này?',
            content: 'Hành động này không thể hoàn tác.',
            okText: 'Xoá',
            okType: 'danger',
            cancelText: 'Hủy',
            onOk: async () => {
                try {
                    const response = await apiClient.delete(`/users/${userId}`);
                    if (response.data.status_code === 200) {
                        toast.success('Xoá sinh viên thành công');
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
            return <div>Không có dữ liệu</div>;
        }
    }
    

    return (
        <div style={{ padding: '24px' }}>
            <main>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '16px' }}>
                    <h2>DANH SÁCH SINH VIÊN</h2>
                    
                    <div style={{ marginTop: '16px', display: 'flex', justifyContent: 'flex-end' }}>
                    <Pagination
                        current={pagination.currentPage}
                        pageSize={pagination.limit}
                        total={pagination.total}
                        pageSizeOptions={['10', '20', '30', '40', '50']}
                        onChange={(page, size) => {
                            setPagination({
                                ...pagination,
                                currentPage: page,
                                limit: size
                            });
                        }}
                        showSizeChanger
                        showQuickJumper
                        showTotal={(total) => `Tổng ${total} bản ghi`}
                        style={{ color: '#ffffff' }}
                        
                    />
                </div>
                </div>
                <table>
                    <thead>
                        <tr>
                            <th>ID | TÊN</th>
                            <th>MÃ SINH VIÊN</th>
                            <th>GIỚI TÍNH</th>
                            <th>CARD UID</th>
                            <th>NGÀY ĐĂNG KÝ</th>
                            <th>THAO TÁC</th>
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
                                <td>{new Date(user.user_date).toLocaleDateString()}</td>
                                <td>
                                    <Space>
                                        <Button
                                            type="primary"
                                            icon={<EditOutlined />}
                                            onClick={() => handleEdit(user)}
                                        >
                                            SỬA
                                        </Button>
                                        <Button
                                            danger
                                            icon={<DeleteOutlined />}
                                            onClick={() => handleDelete(user.id)}
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
                title={editingUser ? 'SỬA THÔNG TIN SINH VIÊN' : 'THÊM SINH VIÊN'}
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
                        label="Tên"
                        rules={[{ required: true, message: 'Vui lòng nhập tên!' }]}
                    >
                        <Input />
                    </Form.Item>
                    <Form.Item
                        name="serialnumber"
                        label="Mã sinh viên"
                        rules={[{ required: true, message: 'Vui lòng nhập mã sinh viên!' }]}
                    >
                        <Input />
                    </Form.Item>
                    <Form.Item
                        name="gender"
                        label="Giới tính"
                        rules={[{ required: true, message: 'Vui lòng chọn giới tính!' }]}
                    >
                        <Select
                            placeholder="Chọn giới tính"
                        >
                            <Select.Option value="Male">Male</Select.Option>
                            <Select.Option value="Female">Female</Select.Option>
                        </Select>
                    </Form.Item>
                    <Form.Item
                        name="email"
                        label="Email"
                        rules={[{ required: true, message: 'Vui lòng nhập email!' }]}
                    >
                        <Input />
                    </Form.Item>
                </Form>
            </Modal>
        </div>
    );
};

export default UserList;

