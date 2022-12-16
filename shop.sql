-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 16, 2022 at 12:42 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `canteen`
--

-- --------------------------------------------------------

--
-- Table structure for table `shop`
--

CREATE TABLE `shop` (
  `s_id` int(11) NOT NULL,
  `s_username` varchar(45) NOT NULL,
  `s_pwd` varchar(45) NOT NULL,
  `s_name` varchar(45) NOT NULL,
  `s_location` varchar(100) NOT NULL,
  `s_openhour` time NOT NULL,
  `s_closehour` time NOT NULL,
  `s_status` tinyint(4) NOT NULL DEFAULT 1 COMMENT 'shop ready for taking orders or not(1 for open, 0 for close)\r\n',
  `s_preorderstatus` tinyint(4) NOT NULL DEFAULT 1 COMMENT 'shop is ready for preorder or not',
  `s_email` varchar(45) NOT NULL,
  `s_phoneno` varchar(10) NOT NULL,
  `s_pic` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `shop`
--

INSERT INTO `shop` (`s_id`, `s_username`, `s_pwd`, `s_name`, `s_location`, `s_openhour`, `s_closehour`, `s_status`, `s_preorderstatus`, `s_email`, `s_phoneno`, `s_pic`) VALUES
(1, 'Canteen1', 'canteen1', 'GJB CANTEEN', 'GJB', '10:00:00', '18:00:00', 1, 1, 'canteen1@gmail.com', '9999999999', 'canteen1.jpg'),
(2, 'Canteen2', 'canteen2', 'NRN CANTEEN', 'NRN', '10:00:00', '18:00:00', 1, 1, 'canteen2@gmail.com', '8888888888', 'canteen2.jpg'),
(3, 'Canteen3', 'canteen3', 'Srikantu Canteen', 'Admin Block', '10:00:00', '18:00:00', 1, 1, 'canteen3@gmail.com', '7777777777', 'canteen3.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `shop`
--
ALTER TABLE `shop`
  ADD PRIMARY KEY (`s_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `shop`
--
ALTER TABLE `shop`
  MODIFY `s_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
