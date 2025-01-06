import { useNavigate } from 'react-router-dom';
import { Modal } from 'antd';


function Navigation() {
    const navigate = useNavigate();
    
    const isLoggedIn = localStorage.getItem('token');
    console.log(isLoggedIn);

    const handleLogout = () => {
        Modal.confirm({
            title: 'Are you sure you want to log out?',
            content: 'This action cannot be undone.',
            okText: 'Yes',
            okType: 'danger',
            cancelText: 'No',
            onOk: async () => {
                localStorage.removeItem('token');
                navigate('/login');
            }
        });
    }

    if(isLoggedIn) {
        return (
            <nav>
                <button onClick={() => navigate('/users')}>Users</button>
                <button onClick={() => navigate('/users-log')}>Users Log</button>
                <button onClick={() => navigate('/devices')}>Devices</button>
                <button onClick={handleLogout}>Log Out</button>
            </nav>
        );
    } else {
        return (
            <nav>
                <button onClick={() => navigate('/login')}>Log In</button>
            </nav>
        );
    }
}

export default Navigation;
