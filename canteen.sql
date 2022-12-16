-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 16, 2022 at 12:44 PM
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

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `customer_order` (IN `order_id` INT(11))   BEGIN
	SELECT orh.orh_refcode AS reference_code, CONCAT(c.c_firstname,' ',c.c_lastname) AS customer_name, f.f_name AS food_name, ord.ord_buyprice AS buy_price, ord.ord_amount AS amount, ord.ord_note AS order_note,orh.orh_ordertime AS order_time, orh,orh_pickuptime AS pickup_time
    From order_header orh 
    INNER JOIN order_detail ord ON orh.orh_id=ord_id
    INNER JOIN food f ON f.f_id=ord.f_id
    INNER JOIN customer c ON orh.c_id=c.c_id
    INNER JOIN shop s ON orh.s_id=s.s_id
    WHERE orh.orh_id=order_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `customer_order_history` (IN `customer_id` INT(11))   BEGIN
	SELECT orh.orh_refcode AS reference_code, CONCAT(c.c_firstname,' ',c.c_lastname) AS customer_name,
    s.s_name AS shop_name, orh.orh_ordertime AS order_time, orh.orh_pickuptime AS pickup_time,
    orh.orh_orderstatus AS order_status
    FROM order_header orh INNER JOIN customer c ON orh.c_id = c.c_id
   
    INNER JOIN shop s ON orh.s_id = s.s_id
    WHERE c.c_id = customer_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `shop_alltime_revenue` (IN `shop_id` INT(11))   BEGIN
	SELECT SUM(ord.ord_amount*ord.ord_buyprice) AS alltime_revenue 
    FROM order_header orh INNER JOIN order_detail ord ON orh.orh_id = ord.orh_id
    INNER JOIN food f ON f.f_id = ord.f_id INNER JOIN shop s ON s.s_id = orh.s_id
    WHERE s.s_id = shop_id AND orh.orh_orderstatus = 'FNSH';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `shop_menu_revenue` (IN `shop_id` INT(11))   BEGIN
	SELECT f.f_name AS food_name, SUM(ord.ord_amount*ord.ord_buyprice) AS menu_revenue
    FROM order_header orh INNER JOIN order_detail ord ON orh.orh_id = ord.orh_id
    INNER JOIN food f ON f.f_id = ord.f_id
    WHERE orh.s_id = shop_id AND orh.orh_orderstatus = 'FNSH'
    GROUP BY ord.f_id ORDER BY menu_revenue DESC;
END$$

DELIMITER ;

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
(1, 'pujitha', 'pujitharc', 'pujitha', 'rc', 'pujitharoopa@gmail.com', 'F', 'STD'),
(2, 'admin', 'admin123', 'canteen', 'admin', 'admin@gmail.com', 'F', 'ADM');

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
(1, 1, 'Masala Dosa', '40.00', 1, 1, 'mdosa.jpg'),
(2, 1, 'Plain dosa', '30.00', 1, 1, 'pdosa.jpg'),
(3, 1, 'Idli', '30.00', 1, 1, 'idli.jpg'),
(4, 1, 'Vade', '10.00', 1, 1, 'vade.jpg'),
(5, 1, 'Palav', '30.00', 1, 1, 'palav.jpeg'),
(6, 1, 'Parota', '30.00', 1, 1, 'parota.jpg'),
(7, 2, 'Veg Sandwich', '40.00', 1, 1, 'sandwich.jpg'),
(8, 2, 'Corn Sandwich', '40.00', 1, 1, 'corn sandwich.jpg'),
(9, 2, 'Maggi', '30.00', 1, 1, 'maggi.jpg'),
(10, 2, 'Cold coffee', '20.00', 1, 1, 'cold-coffee.jpg'),
(11, 3, 'Meals', '70.00', 1, 1, 'Lunch Thali.jpg'),
(12, 3, 'Set Dosa', '30.00', 1, 1, 'Set dosa.jpg'),
(13, 3, 'Pakoda', '15.00', 1, 1, 'pakoda.jpg'),
(14, 3, 'Puri', '30.00', 1, 1, 'poori.jpg'),
(15, 3, 'Rava Idli', '30.00', 1, 1, 'Rava idle.jpg'),
(16, 3, 'Curd rice', '30.00', 1, 1, 'curd rice.jpg');

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
(1, 1, 2, 1, '30.00', ''),
(2, 1, 4, 1, '10.00', ''),
(3, 2, 2, 1, '30.00', ''),
(4, 3, 8, 1, '40.00', ''),
(5, 4, 12, 1, '30.00', ''),
(6, 5, 2, 1, '30.00', ''),
(7, 6, 9, 1, '30.00', '');

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
(1, '202212100000001', 1, 1, '2022-12-10 13:12:40', '2022-12-11 10:00:00', 'FNSH', '2022-12-10 20:15:25'),
(2, '202212100000002', 1, 1, '2022-12-10 15:40:15', '2022-12-11 10:00:00', 'FNSH', '2022-12-10 22:40:53'),
(3, '202212140000003', 1, 2, '2022-12-14 10:01:43', '2022-12-15 10:00:00', 'FNSH', '2022-12-14 15:49:52'),
(4, '202212160000004', 1, 3, '2022-12-16 04:52:03', '2022-12-16 11:50:00', 'FNSH', '2022-12-16 10:23:03'),
(5, '202212160000005', 1, 1, '2022-12-16 05:05:08', '2022-12-16 12:05:00', 'FNSH', '2022-12-16 16:40:34'),
(6, '202212160000006', 1, 2, '2022-12-16 05:05:48', '2022-12-16 12:05:00', 'ACPT', NULL);

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
  MODIFY `ct_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `c_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `food`
--
ALTER TABLE `food`
  MODIFY `f_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `order_detail`
--
ALTER TABLE `order_detail`
  MODIFY `ord_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `order_header`
--
ALTER TABLE `order_header`
  MODIFY `orh_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `shop`
--
ALTER TABLE `shop`
  MODIFY `s_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
