-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 01, 2022 at 06:09 AM
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
(1, 'Canteen1', 'canteen1', 'GJB CANTEEN', 'GJB', '10:00:00', '05:00:00', 1, 1, 'canteen1@gmail.com', '9999999999', NULL),
(2, 'Canteen2', 'canteen2', 'NRN CANTEEN', 'NRN', '10:00:00', '05:00:00', 1, 1, 'canteen2@gmail.com', '8888888888', NULL),
(3, 'Canteen3', 'canteen3', 'Srikantu Canteen', 'Admin Block', '10:00:00', '05:00:00', 1, 1, 'canteen3@gmail.com', '7777777777', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`ct_id`),
  ADD KEY `fk_ct_c` (`c_id`),
  ADD KEY `fk_ct_f` (`f_id`),
  ADD KEY `fk_ct_s` (`s_id`);

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
  MODIFY `ct_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `c_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `food`
--
ALTER TABLE `food`
  MODIFY `f_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_detail`
--
ALTER TABLE `order_detail`
  MODIFY `ord_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_header`
--
ALTER TABLE `order_header`
  MODIFY `orh_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shop`
--
ALTER TABLE `shop`
  MODIFY `s_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
