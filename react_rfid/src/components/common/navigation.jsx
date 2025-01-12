import { useNavigate } from 'react-router-dom';
import { Modal } from 'antd';



function Navigation() {
    const navigate = useNavigate();

    
    const isLoggedIn = localStorage.getItem('token') !== null || localStorage.getItem('token') !== undefined; 
    console.log(isLoggedIn);


    const handleLogout = () => {
        Modal.confirm({
            title: 'Bạn có chắc chắn muốn đăng xuất?',
            content: 'Hành động này không thể hoàn tác.',
            okText: 'Đăng xuất',
            okType: 'danger',
            cancelText: 'Hủy',
            onOk: async () => {
                localStorage.removeItem('token');
                navigate('/login');
            }
        });
    }
    
    if(isLoggedIn) {
        return (
            <nav>
                <button onClick={() => navigate('/users')}>DANH SÁCH SINH VIÊN</button>
                <button onClick={() => navigate('/users-log')}>LỊCH SỬ ĐIỂM DANH</button>
                <button onClick={() => navigate('/devices')}>THIẾT BỊ</button>
                <button onClick={handleLogout}>ĐĂNG XUẤT</button>
            </nav>
        );
    } else {
        return (
            <nav>
                <button onClick={() => navigate('/login')}>ĐĂNG NHẬP</button>
            </nav>
        );
    }
}

export default Navigation;
