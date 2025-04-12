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
-- check if admin table exists
DROP TABLE IF EXISTS `admin`;
--
-- Tạo bảng mới
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

-- check if devices table exists
DROP TABLE IF EXISTS `devices`;
--
CREATE TABLE `devices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_name` varchar(50) NOT NULL,
  `device_dep` varchar(20) NOT NULL,
  `device_uid` text NOT NULL,
  `device_date` date NOT NULL,
  `device_mode` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
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

-- check if users table exists
DROP TABLE IF EXISTS `users`;
--
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(30) NOT NULL DEFAULT 'None',
  `serialnumber` varchar(30) NOT NULL DEFAULT 'None',
  `gender` varchar(10) NOT NULL DEFAULT 'None',
  `email` varchar(50) NOT NULL DEFAULT 'None',
  `card_uid` varchar(30) NOT NULL,
  `card_select` tinyint(1) NOT NULL DEFAULT 0,
  `user_date` date NOT NULL,
  `add_card` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `username`, `gender`, `email`, `card_uid`, `card_select`, `user_date`, `add_card`) VALUES
(2, 'Nguyen Van A', 'Male', 'vdlaptrinh@gmail.com', '911277', 0, '2021-06-21', 1),
(4, 'Nguyen Van B', 'Female', 'vdlaptrinh@gmail.com', '4448724', 0, '2021-06-21', 1),
(15, 'Nguyen Van C', 'Male', 'vdlaptrinh@gmail.com', '12715413', 0, '2021-06-22', 1),
(17, 'Nguyen Van D', 'Male', 'vdlaptrinh@gmail.com', '8198525', 0, '2021-06-22', 1),
(18, 'Nguyen Van E', 'Female', 'vdlaptrinh@gmail.com', '12715501', 1, '2021-06-22', 1),
(30, 'Tran Van C',  'Male', 'vdlaptrinh@gmail.com', '2243724', 0, '2021-06-22', 1),
(31, 'Tran Van A',  'Female', 'vdlaptrinh@gmail.com', '15198951', 0, '2021-06-23', 1),
(32, 'Tran Van B',  'Female', 'vdlaptrinh@gmail.com', '12715493', 0, '2021-06-23', 1),
(33, 'Tran Van D', 'Female', 'vdlaptrinh@gmail.com', '2249554', 0, '2021-06-23', 1),
(34, 'Tran Van E', 'Male', 'vdlaptrinh@gmail.com', '15650647', 0, '2021-06-23', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users_logs`
--

-- check if users_logs table exists
DROP TABLE IF EXISTS `users_logs`;
--
CREATE TABLE `users_logs` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `serialnumber` varchar(100) NOT NULL,
  `card_uid` varchar(30) NOT NULL,
  `device_id` int(11) NOT NULL,
  `checkindate` date NOT NULL,
  `timein` time NOT NULL,
  `timeout` time NOT NULL,
  `card_out` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`device_id`) REFERENCES `devices` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Đang đổ dữ liệu cho bảng `users_logs`
--

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--

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

-- Create a new table for user-device relationships

-- check if user_devices table exists
DROP TABLE IF EXISTS `user_devices`;
--
CREATE TABLE `user_devices` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `device_id` INT(11) NOT NULL,
  `add_card` TINYINT(1) NOT NULL DEFAULT 0,
  `card_select` TINYINT(1) NOT NULL DEFAULT 0,
  `card_uid` VARCHAR(30) NOT NULL,
  `add_date` DATE NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`device_id`) REFERENCES `devices` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);


INSERT INTO user_devices (user_id, device_id, add_card, card_select, card_uid, add_date)
VALUES 
  (2, 3, 1, 0, '911277', '2021-06-23'),
  (4, 3, 1, 0, '4448724', '2021-06-23'),
  (15, 1, 1, 0, '12715413', '2021-06-23'),
  (17, 1, 1, 0, '8198525', '2021-06-23');



