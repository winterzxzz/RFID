-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th6 23, 2021 lúc 12:42 PM
-- Phiên bản máy phục vụ: 10.4.11-MariaDB
-- Phiên bản PHP: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `rfidattendance`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `admin_name` varchar(30) NOT NULL,
  `admin_email` varchar(80) NOT NULL,
  `admin_pwd` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Đang đổ dữ liệu cho bảng `admin`
--

INSERT INTO `admin` (`id`, `admin_name`, `admin_email`, `admin_pwd`) VALUES
(1, 'admin', 'vdlaptrinh@gmail.com', '$2y$10$89uX3LBy4mlU/DcBveQ1l.32nSianDP/E1MfUh.Z.6B4Z0ql3y7PK');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `devices`
--

CREATE TABLE `devices` (
  `id` int(11) NOT NULL,
  `device_name` varchar(50) NOT NULL,
  `device_dep` varchar(20) NOT NULL,
  `device_uid` text NOT NULL,
  `device_date` date NOT NULL,
  `device_mode` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Đang đổ dữ liệu cho bảng `devices`
--

INSERT INTO `devices` (`id`, `device_name`, `device_dep`, `device_uid`, `device_date`, `device_mode`) VALUES
(1, 'ESP32', 'DTVT', '8f19e31055c56b05', '2021-06-21', 1),
(3, 'ESP8266', 'DTVT 20A', '8ceb36c810343326', '2021-06-22', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(30) NOT NULL DEFAULT 'None',
  `serialnumber` double NOT NULL DEFAULT 0,
  `gender` varchar(10) NOT NULL DEFAULT 'None',
  `email` varchar(50) NOT NULL DEFAULT 'None',
  `card_uid` varchar(30) NOT NULL,
  `card_select` tinyint(1) NOT NULL DEFAULT 0,
  `user_date` date NOT NULL,
  `device_uid` varchar(20) NOT NULL DEFAULT '0',
  `device_dep` varchar(20) NOT NULL DEFAULT '0',
  `add_card` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `username`, `serialnumber`, `gender`, `email`, `card_uid`, `card_select`, `user_date`, `device_uid`, `device_dep`, `add_card`) VALUES
(2, 'Nguyen Van A', 1, 'Male', 'vdlaptrinh@gmail.com', '911277', 0, '2021-06-21', '8ceb36c810343326', 'DTVT 20A', 1),
(4, 'Nguyen Van B', 2, 'Female', 'vdlaptrinh@gmail.com', '4448724', 0, '2021-06-21', '8ceb36c810343326', 'DTVT 20A', 1),
(15, 'Nguyen Van C', 3, 'Male', 'vdlaptrinh@gmail.com', '12715413', 0, '2021-06-22', '8ceb36c810343326', 'DTVT 20A', 1),
(17, 'Nguyen Van D', 4, 'Male', 'vdlaptrinh@gmail.com', '8198525', 0, '2021-06-22', '8ceb36c810343326', 'DTVT 20A', 1),
(18, 'Nguyen Van E', 5, 'Female', 'vdlaptrinh@gmail.com', '12715501', 1, '2021-06-22', '8ceb36c810343326', 'DTVT 20A', 1),
(30, 'Tran Van C', 7, 'Male', 'vdlaptrinh@gmail.com', '2243724', 0, '2021-06-22', '8ceb36c810343326', 'DTVT 20A', 1),
(31, 'Tran Van A', 6, 'Female', 'vdlaptrinh@gmail.com', '15198951', 0, '2021-06-23', '8ceb36c810343326', 'DTVT 20A', 1),
(32, 'Tran Van B', 8, 'Female', 'vdlaptrinh@gmail.com', '12715493', 0, '2021-06-23', '8ceb36c810343326', 'DTVT 20A', 1),
(33, 'Tran Van D', 9, 'Female', 'vdlaptrinh@gmail.com', '2249554', 0, '2021-06-23', '8ceb36c810343326', 'DTVT 20A', 1),
(34, 'Tran Van E', 10, 'Male', 'vdlaptrinh@gmail.com', '15650647', 0, '2021-06-23', '8ceb36c810343326', 'DTVT 20A', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users_logs`
--

CREATE TABLE `users_logs` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `serialnumber` double NOT NULL,
  `card_uid` varchar(30) NOT NULL,
  `device_uid` varchar(20) NOT NULL,
  `device_dep` varchar(20) NOT NULL,
  `checkindate` date NOT NULL,
  `timein` time NOT NULL,
  `timeout` time NOT NULL,
  `card_out` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Đang đổ dữ liệu cho bảng `users_logs`
--

INSERT INTO `users_logs` (`id`, `username`, `serialnumber`, `card_uid`, `device_uid`, `device_dep`, `checkindate`, `timein`, `timeout`, `card_out`) VALUES
(1, 'Nguyen Van B', 2, '4448724', '8f19e31055c56b05', 'DTVT', '2021-06-21', '19:40:21', '20:33:27', 1),
(2, 'Nguyen Van A', 1, '911277', '8f19e31055c56b05', 'DTVT', '2021-06-21', '19:40:27', '20:33:22', 1),
(3, 'Nguyen Van H', 8, '15198951', '8f19e31055c56b05', 'DTVT', '2021-06-21', '20:33:36', '20:34:13', 1),
(4, 'Nguyen Van J', 10, '12715493', '8f19e31055c56b05', 'DTVT', '2021-06-21', '20:33:40', '20:34:27', 1),
(5, 'Nguyen Van I', 9, '2243724', '8f19e31055c56b05', 'DTVT', '2021-06-21', '20:33:44', '20:34:32', 1),
(6, 'Nguyen Van C', 3, '12715413', '8f19e31055c56b05', 'DTVT', '2021-06-21', '20:33:46', '20:34:24', 1),
(7, 'Nguyen Van F', 6, '15650647', '8f19e31055c56b05', 'DTVT', '2021-06-21', '20:33:49', '20:34:40', 1),
(8, 'Nguyen Van E', 5, '12715501', '8f19e31055c56b05', 'DTVT', '2021-06-21', '20:33:54', '20:34:46', 1),
(9, 'Nguyen Van G', 7, '2249554', '8f19e31055c56b05', 'DTVT', '2021-06-21', '20:33:57', '20:34:42', 1),
(10, 'Nguyen Van D', 4, '8198525', '8f19e31055c56b05', 'DTVT', '2021-06-21', '20:34:00', '20:34:20', 1),
(11, 'Nguyen Van B', 2, '4448724', '8f19e31055c56b05', 'DTVT', '2021-06-21', '20:38:25', '20:39:39', 1),
(12, 'Nguyen Van A', 1, '911277', '8f19e31055c56b05', 'DTVT', '2021-06-21', '20:38:52', '20:39:36', 1),
(13, 'Nguyen Van G', 7, '2249554', '8f19e31055c56b05', 'DTVT', '2021-06-21', '20:39:01', '20:39:47', 1),
(14, 'Nguyen Van E', 5, '12715501', '8f19e31055c56b05', 'DTVT', '2021-06-21', '20:39:05', '20:39:43', 1),
(15, 'Nguyen Van J', 10, '12715493', '8f19e31055c56b05', 'DTVT', '2021-06-21', '20:39:08', '20:40:01', 1),
(16, 'Nguyen Van C', 3, '12715413', '8f19e31055c56b05', 'DTVT', '2021-06-21', '20:39:15', '20:39:58', 1),
(17, 'Nguyen Van F', 6, '15650647', '8f19e31055c56b05', 'DTVT', '2021-06-21', '20:39:18', '20:39:55', 1),
(18, 'Nguyen Van H', 8, '15198951', '8f19e31055c56b05', 'DTVT', '2021-06-21', '20:39:22', '20:39:52', 1),
(19, 'Nguyen Van D', 4, '8198525', '8f19e31055c56b05', 'DTVT', '2021-06-21', '20:39:24', '20:40:04', 1),
(20, 'Nguyen Van I', 9, '2243724', '8f19e31055c56b05', 'DTVT', '2021-06-21', '20:39:28', '20:40:07', 1),
(21, 'Nguyen Van B', 2, '4448724', '8f19e31055c56b05', 'DTVT', '2021-06-21', '20:42:47', '21:11:46', 1),
(22, 'Nguyen Van A', 1, '911277', '8f19e31055c56b05', 'DTVT', '2021-06-21', '21:10:20', '21:11:42', 1),
(23, 'Nguyen Van F', 6, '15650647', '8f19e31055c56b05', 'DTVT', '2021-06-21', '21:10:24', '21:11:39', 1),
(24, 'Nguyen Van E', 5, '12715501', '8f19e31055c56b05', 'DTVT', '2021-06-21', '21:10:42', '21:11:31', 1),
(25, 'Nguyen Van D', 4, '8198525', '8f19e31055c56b05', 'DTVT', '2021-06-21', '21:10:46', '21:11:33', 1),
(26, 'Nguyen Van H', 8, '15198951', '8f19e31055c56b05', 'DTVT', '2021-06-21', '21:10:49', '21:11:36', 1),
(27, 'Nguyen Van I', 9, '2243724', '8f19e31055c56b05', 'DTVT', '2021-06-21', '21:10:53', '21:11:22', 1),
(28, 'Nguyen Van G', 7, '2249554', '8f19e31055c56b05', 'DTVT', '2021-06-21', '21:10:57', '21:11:19', 1),
(29, 'Nguyen Van J', 10, '12715493', '8f19e31055c56b05', 'DTVT', '2021-06-21', '21:11:00', '21:11:12', 1),
(30, 'Nguyen Van C', 3, '12715413', '8f19e31055c56b05', 'DTVT', '2021-06-21', '21:11:03', '21:11:15', 1),
(31, 'Nguyen Van A', 1, '911277', '8f19e31055c56b05', 'DTVT', '2021-06-21', '21:19:51', '21:23:18', 1),
(32, 'Nguyen Van B', 2, '4448724', '8f19e31055c56b05', 'DTVT', '2021-06-21', '21:20:26', '21:23:20', 1),
(33, 'Nguyen Van A', 1, '911277', '8f19e31055c56b05', 'DTVT', '2021-06-22', '04:15:59', '04:56:09', 1),
(34, 'Nguyen Van B', 2, '4448724', '8f19e31055c56b05', 'DTVT', '2021-06-22', '04:16:00', '04:56:13', 1),
(35, 'Nguyen Van J', 10, '12715493', '8f19e31055c56b05', 'DTVT', '2021-06-22', '04:56:25', '04:57:03', 1),
(36, 'Nguyen Van H', 8, '15198951', '8f19e31055c56b05', 'DTVT', '2021-06-22', '04:56:30', '04:56:57', 1),
(37, 'Nguyen Van G', 7, '2249554', '8f19e31055c56b05', 'DTVT', '2021-06-22', '04:56:30', '04:56:59', 1),
(38, 'Nguyen Van C', 3, '12715413', '8f19e31055c56b05', 'DTVT', '2021-06-22', '04:56:33', '04:56:54', 1),
(39, 'Nguyen Van I', 9, '2243724', '8f19e31055c56b05', 'DTVT', '2021-06-22', '04:56:37', '04:56:50', 1),
(40, 'Nguyen Van F', 6, '15650647', '8f19e31055c56b05', 'DTVT', '2021-06-22', '04:56:40', '04:57:58', 1),
(41, 'Nguyen Van A', 1, '911277', '8f19e31055c56b05', 'DTVT', '2021-06-22', '04:57:47', '05:03:54', 1),
(42, 'Nguyen Van B', 2, '4448724', '8f19e31055c56b05', 'DTVT', '2021-06-22', '04:57:49', '05:03:46', 1),
(43, 'Nguyen Van J', 10, '12715493', '8f19e31055c56b05', 'DTVT', '2021-06-22', '04:57:51', '05:06:58', 1),
(44, 'Nguyen Van G', 7, '2249554', '8f19e31055c56b05', 'DTVT', '2021-06-22', '04:57:54', '05:04:19', 1),
(45, 'Nguyen Van H', 8, '15198951', '8f19e31055c56b05', 'DTVT', '2021-06-22', '04:57:56', '05:04:08', 1),
(46, 'Nguyen Van I', 9, '2243724', '8f19e31055c56b05', 'DTVT', '2021-06-22', '04:58:02', '05:04:00', 1),
(47, 'Nguyen Van C', 3, '12715413', '8f19e31055c56b05', 'DTVT', '2021-06-22', '05:04:14', '05:06:54', 1),
(48, 'Nguyen Van F', 6, '15650647', '8f19e31055c56b05', 'DTVT', '2021-06-22', '05:04:34', '05:06:49', 1),
(49, 'Nguyen Van A', 1, '911277', '8f19e31055c56b05', 'DTVT', '2021-06-22', '05:04:47', '05:05:34', 1),
(50, 'Nguyen Van B', 2, '4448724', '8f19e31055c56b05', 'DTVT', '2021-06-22', '05:04:51', '05:05:28', 1),
(51, 'Nguyen Van H', 8, '15198951', '8f19e31055c56b05', 'DTVT', '2021-06-22', '05:05:01', '05:06:45', 1),
(52, 'Nguyen Van I', 9, '2243724', '8f19e31055c56b05', 'DTVT', '2021-06-22', '05:05:10', '05:06:43', 1),
(53, 'Nguyen Van A', 1, '911277', '8f19e31055c56b05', 'DTVT', '2021-06-22', '05:06:38', '05:07:19', 1),
(54, 'Nguyen Van B', 2, '4448724', '8f19e31055c56b05', 'DTVT', '2021-06-22', '05:06:40', '05:07:18', 1),
(55, 'Nguyen Van G', 7, '2249554', '8f19e31055c56b05', 'DTVT', '2021-06-22', '05:06:52', '05:07:08', 1),
(56, 'Nguyen Van C', 3, '12715413', '8f19e31055c56b05', 'DTVT', '2021-06-22', '05:07:03', '09:14:47', 1),
(57, 'Nguyen Van J', 10, '12715493', '8f19e31055c56b05', 'DTVT', '2021-06-22', '05:07:06', '09:14:58', 1),
(58, 'Nguyen Van H', 8, '15198951', '8f19e31055c56b05', 'DTVT', '2021-06-22', '05:07:10', '09:14:52', 1),
(59, 'Nguyen Van I', 9, '2243724', '8f19e31055c56b05', 'DTVT', '2021-06-22', '05:07:13', '09:15:00', 1),
(60, 'Nguyen Van F', 6, '15650647', '8f19e31055c56b05', 'DTVT', '2021-06-22', '05:07:15', '09:14:55', 1),
(61, 'Nguyen Van B', 2, '4448724', '8f19e31055c56b05', 'DTVT', '2021-06-22', '09:14:44', '09:15:40', 1),
(62, 'Nguyen Van G', 7, '2249554', '8f19e31055c56b05', 'DTVT', '2021-06-22', '09:14:50', '09:15:54', 1),
(63, 'Nguyen Van B', 2, '4448724', '8f19e31055c56b05', 'DTVT', '2021-06-22', '10:36:25', '00:00:00', 0),
(64, 'Nguyen Van A', 1, '911277', '8f19e31055c56b05', 'DTVT', '2021-06-22', '10:36:27', '00:00:00', 0),
(65, 'Nguyen Van H', 8, '15198951', '8f19e31055c56b05', 'DTVT', '2021-06-22', '10:36:31', '00:00:00', 0),
(66, 'Nguyen Van C', 3, '12715413', '8f19e31055c56b05', 'DTVT', '2021-06-22', '10:36:39', '00:00:00', 0),
(67, 'Tran Van A', 6, '12715493', '8ceb36c810343326', 'DTVT 20A', '2021-06-22', '16:07:23', '16:08:40', 1),
(68, 'Tran Van B', 7, '2243724', '8ceb36c810343326', 'DTVT 20A', '2021-06-22', '16:08:23', '16:08:51', 1),
(69, 'Tran Van C', 7, '2243724', '8ceb36c810343326', 'DTVT 20A', '2021-06-22', '16:24:29', '16:30:37', 1),
(76, 'Nguyen Van A', 1, '911277', '8ceb36c810343326', 'DTVT 20A', '2021-06-23', '12:15:31', '12:16:41', 1),
(77, 'Nguyen Van B', 2, '4448724', '8ceb36c810343326', 'DTVT 20A', '2021-06-23', '12:15:36', '12:16:39', 1),
(78, 'Tran Van E', 10, '15650647', '8ceb36c810343326', 'DTVT 20A', '2021-06-23', '12:15:42', '12:16:34', 1),
(79, 'Tran Van B', 8, '12715493', '8ceb36c810343326', 'DTVT 20A', '2021-06-23', '12:15:45', '12:16:31', 1),
(80, 'Tran Van C', 7, '2243724', '8ceb36c810343326', 'DTVT 20A', '2021-06-23', '12:15:50', '12:16:48', 1),
(81, 'Tran Van D', 9, '2249554', '8ceb36c810343326', 'DTVT 20A', '2021-06-23', '12:15:53', '12:16:25', 1),
(82, 'Tran Van A', 6, '15198951', '8ceb36c810343326', 'DTVT 20A', '2021-06-23', '12:15:57', '12:16:23', 1),
(83, 'Nguyen Van D', 4, '8198525', '8ceb36c810343326', 'DTVT 20A', '2021-06-23', '12:16:00', '12:16:18', 1),
(84, 'Nguyen Van C', 3, '12715413', '8ceb36c810343326', 'DTVT 20A', '2021-06-23', '12:16:03', '12:16:44', 1),
(85, 'Nguyen Van E', 5, '12715501', '8ceb36c810343326', 'DTVT 20A', '2021-06-23', '12:16:06', '12:16:29', 1);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `devices`
--
ALTER TABLE `devices`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `users_logs`
--
ALTER TABLE `users_logs`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `devices`
--
ALTER TABLE `devices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT cho bảng `users_logs`
--
ALTER TABLE `users_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
