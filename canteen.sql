-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 11, 2023 at 10:44 AM
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
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `ct_id` int(11) NOT NULL,
  `c_id` int(11) NOT NULL,
  `s_id` int(11) NOT NULL,
  `f_id` int(11) NOT NULL,
  `ct_amount` int(11) NOT NULL,
  `ct_note` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `c_id` int(11) NOT NULL,
  `c_username` varchar(45) NOT NULL,
  `c_pwd` varchar(45) NOT NULL,
  `c_firstname` varchar(45) NOT NULL,
  `c_lastname` varchar(45) NOT NULL,
  `c_email` varchar(45) NOT NULL,
  `c_gender` varchar(1) NOT NULL COMMENT 'M for male, F for female',
  `c_type` varchar(3) NOT NULL COMMENT 'STD for student\r\nINS for instructor\r\nSTF for staff\r\nGUE for guest\r\nADM for admin\r\nOTH for others'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`c_id`, `c_username`, `c_pwd`, `c_firstname`, `c_lastname`, `c_email`, `c_gender`, `c_type`) VALUES
(1, 'pujitha', 'eedc3eee1077124a31477d7dd474b3a0', 'pujitha', 'rc', 'pujitharoopa@gmail.com', 'F', 'STD'),
(2, 'admin', '0192023a7bbd73250516f069df18b500', 'canteen', 'admin', 'admin@gmail.com', 'F', 'ADM'),
(6, 'sadana', '2e998a1df270ed90b6ff22afc4c4cbe3', 'sadana', 'h j', 'sadana@gmail.com', 'F', 'STF'),
(7, 'sapna', '0f3d1ff7fe53fa572e455d4275e02f4b', 'sapna', 's', 'sapna@gmail.com', 'F', 'OTH');

-- --------------------------------------------------------

--
-- Table structure for table `food`
--

CREATE TABLE `food` (
  `f_id` int(11) NOT NULL,
  `s_id` int(11) NOT NULL,
  `f_name` varchar(100) NOT NULL,
  `f_price` decimal(6,2) NOT NULL,
  `f_todayavail` tinyint(4) NOT NULL DEFAULT 1 COMMENT 'Food is available to order or not\r\n',
  `f_preorderavail` tinyint(4) NOT NULL DEFAULT 1,
  `f_pic` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `food`
--

INSERT INTO `food` (`f_id`, `s_id`, `f_name`, `f_price`, `f_todayavail`, `f_preorderavail`, `f_pic`) VALUES
(1, 1, 'Masala Dosa', '40.00', 1, 1, '1_1.jpg'),
(2, 1, 'Plain dosa', '30.00', 1, 1, '2_1.jpg'),
(3, 1, 'Idli', '30.00', 1, 1, '3_1.jpg'),
(4, 1, 'Vade', '10.00', 1, 1, '4_1.jpg'),
(5, 1, 'Palav', '30.00', 1, 1, '5_1.jpeg'),
(6, 1, 'Parota', '30.00', 1, 1, '6_1.jpg'),
(7, 2, 'Veg Sandwich', '40.00', 1, 1, '7_2.jpg'),
(8, 2, 'Corn Sandwich', '40.00', 1, 1, '8_2.jpg'),
(9, 2, 'Maggi', '30.00', 1, 1, '9_2.jpg'),
(10, 2, 'Cold coffee', '20.00', 1, 1, '10_2.jpg'),
(11, 3, 'Meals', '70.00', 1, 1, '11_3.jpg'),
(12, 3, 'Set Dosa', '30.00', 1, 1, '12_3.jpg'),
(13, 3, 'Pakoda', '15.00', 1, 1, '13_3.jpg'),
(14, 3, 'Puri', '30.00', 1, 1, '14_3.jpg'),
(15, 3, 'Rava Idli', '30.00', 1, 1, '15_3.jpg'),
(16, 3, 'Curd rice', '30.00', 1, 1, '16_3.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `order_detail`
--

CREATE TABLE `order_detail` (
  `ord_id` int(11) NOT NULL,
  `orh_id` int(11) NOT NULL,
  `f_id` int(11) NOT NULL,
  `ord_amount` int(11) NOT NULL,
  `ord_buyprice` decimal(6,2) NOT NULL COMMENT 'To keep the snapshot menu cost at the time of the purchase',
  `ord_note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `order_detail`
--

INSERT INTO `order_detail` (`ord_id`, `orh_id`, `f_id`, `ord_amount`, `ord_buyprice`, `ord_note`) VALUES
(11, 10, 8, 1, '40.00', ''),
(12, 11, 9, 1, '30.00', ''),
(13, 12, 1, 1, '40.00', ''),
(14, 13, 8, 2, '40.00', ''),
(15, 14, 11, 1, '70.00', ''),
(16, 15, 9, 1, '30.00', ''),
(17, 16, 6, 1, '30.00', ''),
(18, 17, 13, 2, '15.00', ''),
(19, 18, 3, 1, '30.00', ''),
(20, 19, 8, 1, '40.00', ''),
(21, 20, 6, 1, '30.00', ''),
(22, 21, 7, 1, '40.00', ''),
(23, 22, 11, 1, '70.00', 'extra sambar');

-- --------------------------------------------------------

--
-- Table structure for table `order_header`
--

CREATE TABLE `order_header` (
  `orh_id` int(11) NOT NULL,
  `orh_refcode` varchar(15) DEFAULT NULL,
  `c_id` int(11) NOT NULL,
  `s_id` int(11) NOT NULL,
  `orh_ordertime` timestamp NOT NULL DEFAULT current_timestamp(),
  `orh_pickuptime` datetime NOT NULL,
  `orh_orderstatus` varchar(10) NOT NULL,
  `orh_finishedtime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `order_header`
--

INSERT INTO `order_header` (`orh_id`, `orh_refcode`, `c_id`, `s_id`, `orh_ordertime`, `orh_pickuptime`, `orh_orderstatus`, `orh_finishedtime`) VALUES
(10, '202212220000010', 1, 2, '2022-12-22 04:39:41', '2022-12-22 10:15:00', 'FNSH', '2022-12-22 10:10:45'),
(11, '202212240000011', 1, 2, '2022-12-24 05:52:19', '2022-12-24 11:31:00', 'FNSH', '2022-12-24 11:30:40'),
(12, '202212240000012', 1, 1, '2022-12-24 06:01:52', '2022-12-24 11:35:00', 'FNSH', '2022-12-24 11:32:22'),
(13, '202212280000013', 1, 2, '2022-12-28 10:55:14', '2022-12-28 16:30:00', 'FNSH', '2022-12-28 16:42:39'),
(14, '202301050000014', 7, 3, '2023-01-05 07:28:35', '2023-01-05 13:10:00', 'FNSH', '2023-01-05 13:07:38'),
(15, '202301050000015', 6, 2, '2023-01-05 07:29:11', '2023-01-05 13:05:00', 'FNSH', '2023-01-05 13:03:23'),
(16, '202301060000016', 7, 1, '2023-01-06 09:23:52', '2023-01-06 15:00:00', 'FNSH', '2023-01-06 14:59:18'),
(17, '202301070000017', 1, 3, '2023-01-07 06:28:26', '2023-01-07 12:05:00', 'FNSH', '2023-01-07 12:05:22'),
(18, '202301070000018', 7, 1, '2023-01-07 06:35:04', '2023-01-07 12:10:00', 'FNSH', '2023-01-07 12:08:27'),
(19, '202301070000019', 6, 2, '2023-01-07 06:37:37', '2023-01-07 12:15:00', 'FNSH', '2023-01-07 12:14:40'),
(20, '202301090000020', 6, 1, '2023-01-09 05:09:09', '2023-01-09 11:00:00', 'FNSH', '2023-01-09 10:58:02'),
(21, '202301090000021', 7, 2, '2023-01-09 05:09:48', '2023-01-09 11:00:00', 'FNSH', '2023-01-09 10:58:17'),
(22, '202301090000022', 1, 3, '2023-01-09 10:26:33', '2023-01-09 16:10:00', 'FNSH', '2023-01-09 16:12:18');

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
(1, 'Canteen1', '9c740c9ae927a5793fe29170264736e4', 'GJB CANTEEN', 'GJB', '10:00:00', '17:00:00', 1, 1, 'canteen1@gmail.com', '9999999999', 'shop1.jpg'),
(2, 'Canteen2', 'eafaac93a6fb9405a96c002c246357ee', 'NRN CANTEEN', 'NRN', '10:00:00', '18:00:00', 1, 1, 'canteen2@gmail.com', '8888888888', 'shop2.jpg'),
(3, 'Canteen3', '74074d1bf9ba65f12eb3cf1010d3b644', 'Srikantu Canteen', 'Admin Block', '10:00:00', '18:00:00', 1, 1, 'canteen3@gmail.com', '7777777777', 'shop3.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`ct_id`),
  ADD KEY `fk_ct_f` (`f_id`),
  ADD KEY `fk_ct_s` (`s_id`),
  ADD KEY `fk_ct_c` (`c_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`c_id`),
  ADD KEY `c_username` (`c_username`),
  ADD KEY `c_email` (`c_email`);

--
-- Indexes for table `food`
--
ALTER TABLE `food`
  ADD PRIMARY KEY (`f_id`),
  ADD KEY `s_id` (`s_id`);

--
-- Indexes for table `order_detail`
--
ALTER TABLE `order_detail`
  ADD PRIMARY KEY (`ord_id`),
  ADD KEY `fk_f_ord` (`f_id`),
  ADD KEY `fk_orh_ord` (`orh_id`);

--
-- Indexes for table `order_header`
--
ALTER TABLE `order_header`
  ADD PRIMARY KEY (`orh_id`),
  ADD KEY `fk_c_orh` (`c_id`),
  ADD KEY `fk_s_orh` (`s_id`);

--
-- Indexes for table `shop`
--
ALTER TABLE `shop`
  ADD PRIMARY KEY (`s_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `ct_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `c_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `food`
--
ALTER TABLE `food`
  MODIFY `f_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `order_detail`
--
ALTER TABLE `order_detail`
  MODIFY `ord_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `order_header`
--
ALTER TABLE `order_header`
  MODIFY `orh_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `shop`
--
ALTER TABLE `shop`
  MODIFY `s_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `fk_ct_c` FOREIGN KEY (`c_id`) REFERENCES `customer` (`c_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_ct_f` FOREIGN KEY (`f_id`) REFERENCES `food` (`f_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_ct_s` FOREIGN KEY (`s_id`) REFERENCES `shop` (`s_id`) ON DELETE CASCADE;

--
-- Constraints for table `food`
--
ALTER TABLE `food`
  ADD CONSTRAINT `fk_food_shop_id` FOREIGN KEY (`s_id`) REFERENCES `shop` (`s_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `order_detail`
--
ALTER TABLE `order_detail`
  ADD CONSTRAINT `fk_f_ord` FOREIGN KEY (`f_id`) REFERENCES `food` (`f_id`),
  ADD CONSTRAINT `fk_orh_ord` FOREIGN KEY (`orh_id`) REFERENCES `order_header` (`orh_id`);

--
-- Constraints for table `order_header`
--
ALTER TABLE `order_header`
  ADD CONSTRAINT `fk_c_orh` FOREIGN KEY (`c_id`) REFERENCES `customer` (`c_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_s_orh` FOREIGN KEY (`s_id`) REFERENCES `shop` (`s_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
