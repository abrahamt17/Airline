-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 31, 2024 at 10:05 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `airline_databse`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertRandomPrices` ()   BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE flight_id INT;
    DECLARE cur CURSOR FOR SELECT FlightID FROM flights;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO flight_id;
        IF done THEN
            LEAVE read_loop;
        END IF;
        INSERT INTO `price` (`FlightID`, `Price`, `Currency`)
        VALUES (flight_id, FLOOR(4000 + (RAND() * 1000)), 'Birr');
    END LOOP;
    CLOSE cur;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `BookingID` int(11) NOT NULL,
  `UserID` int(11) DEFAULT NULL,
  `FlightID` int(11) DEFAULT NULL,
  `BookingDate` date DEFAULT NULL,
  `TotalPrice` decimal(10,2) DEFAULT NULL,
  `Status` varchar(20) DEFAULT NULL,
  `PassengerID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`BookingID`, `UserID`, `FlightID`, `BookingDate`, `TotalPrice`, `Status`, `PassengerID`) VALUES
(23, 3, 374, '2024-05-31', '4397.00', 'On Time', 32);

-- --------------------------------------------------------

--
-- Table structure for table `checkin`
--

CREATE TABLE `checkin` (
  `CheckInID` int(11) NOT NULL,
  `BookingID` int(11) DEFAULT NULL,
  `CheckInTime` datetime DEFAULT NULL,
  `SeatNumber` varchar(5) DEFAULT NULL,
  `BoardingPass` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customersupport`
--

CREATE TABLE `customersupport` (
  `SupportID` int(11) NOT NULL,
  `UserID` int(11) DEFAULT NULL,
  `Query` text DEFAULT NULL,
  `Response` text DEFAULT NULL,
  `SupportDate` datetime DEFAULT NULL,
  `Status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `destinationguides`
--

CREATE TABLE `destinationguides` (
  `GuideID` int(11) NOT NULL,
  `Destination` varchar(50) DEFAULT NULL,
  `GuideContent` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `destinationguides`
--

INSERT INTO `destinationguides` (`GuideID`, `Destination`, `GuideContent`) VALUES
(1, 'Addis Ababa', 'Explore the capital city with its rich history, museums, and vibrant markets.'),
(2, 'Dire Dawa', 'Discover the historic railway town and its unique culture.'),
(3, 'Bahir Dar', 'Visit the beautiful Lake Tana and the Blue Nile Falls.'),
(4, 'Lalibela', 'Experience the rock-hewn churches and religious heritage.');

-- --------------------------------------------------------

--
-- Table structure for table `flights`
--

CREATE TABLE `flights` (
  `FlightID` int(11) NOT NULL,
  `Airline` varchar(50) DEFAULT NULL,
  `FlightNumber` varchar(10) DEFAULT NULL,
  `DepartureAirport` varchar(50) DEFAULT NULL,
  `ArrivalAirport` varchar(50) DEFAULT NULL,
  `DepartureTime` datetime DEFAULT NULL,
  `ArrivalTime` datetime DEFAULT NULL,
  `Duration` time DEFAULT NULL,
  `Class` varchar(20) DEFAULT NULL,
  `Status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `flights`
--

INSERT INTO `flights` (`FlightID`, `Airline`, `FlightNumber`, `DepartureAirport`, `ArrivalAirport`, `DepartureTime`, `ArrivalTime`, `Duration`, `Class`, `Status`) VALUES
(5, 'Ethiopian Airlines', 'ET101', 'Addis Ababa', 'Dire Dawa', '2024-05-30 08:30:00', '2024-05-30 10:00:00', '01:30:00', 'Economy', 'On Time'),
(6, 'Ethiopian Airlines', 'ET102', 'Dire Dawa', 'Addis Ababa', '2024-05-30 10:30:00', '2024-05-30 12:00:00', '01:30:00', 'Economy', 'Delayed'),
(7, 'Ethiopian Airlines', 'ET103', 'Addis Ababa', 'Mekelle', '2024-05-30 11:00:00', '2024-05-30 12:30:00', '01:30:00', 'Business', 'On Time'),
(8, 'Ethiopian Airlines', 'ET104', 'Mekelle', 'Addis Ababa', '2024-05-30 13:00:00', '2024-05-30 14:30:00', '01:30:00', 'Business', 'Cancelled'),
(9, 'Ethiopian Airlines', 'ET105', 'Addis Ababa', 'Gondar', '2024-05-30 14:00:00', '2024-05-30 15:30:00', '01:30:00', 'First Class', 'On Time'),
(10, 'Ethiopian Airlines', 'ET106', 'Gondar', 'Addis Ababa', '2024-05-30 16:00:00', '2024-05-30 17:30:00', '01:30:00', 'First Class', 'Delayed'),
(11, 'Ethiopian Airlines', 'ET107', 'Addis Ababa', 'Bahir Dar', '2024-05-30 17:00:00', '2024-05-30 18:30:00', '01:30:00', 'Economy', 'On Time'),
(12, 'Ethiopian Airlines', 'ET108', 'Bahir Dar', 'Addis Ababa', '2024-05-30 19:00:00', '2024-05-30 20:30:00', '01:30:00', 'Economy', 'Cancelled'),
(13, 'Ethiopian Airlines', 'ET109', 'Addis Ababa', 'Hawassa', '2024-05-30 20:00:00', '2024-05-30 21:30:00', '01:30:00', 'Business', 'On Time'),
(14, 'Ethiopian Airlines', 'ET110', 'Hawassa', 'Addis Ababa', '2024-05-30 22:00:00', '2024-05-30 23:30:00', '01:30:00', 'Business', 'Delayed'),
(15, 'Ethiopian Airlines', 'ET111', 'Addis Ababa', 'Jijiga', '2024-05-30 23:00:00', '2024-05-31 00:30:00', '01:30:00', 'First Class', 'On Time'),
(16, 'Ethiopian Airlines', 'ET112', 'Jijiga', 'Addis Ababa', '2024-05-31 01:00:00', '2024-05-31 02:30:00', '01:30:00', 'First Class', 'Cancelled'),
(17, 'Ethiopian Airlines', 'ET113', 'Addis Ababa', 'Jimma', '2024-05-31 02:00:00', '2024-05-31 03:30:00', '01:30:00', 'Economy', 'On Time'),
(18, 'Ethiopian Airlines', 'ET114', 'Jimma', 'Addis Ababa', '2024-05-31 04:00:00', '2024-05-31 05:30:00', '01:30:00', 'Economy', 'Delayed'),
(19, 'Ethiopian Airlines', 'ET115', 'Addis Ababa', 'Adama', '2024-05-31 05:00:00', '2024-05-31 06:30:00', '01:30:00', 'Business', 'On Time'),
(20, 'Ethiopian Airlines', 'ET116', 'Adama', 'Addis Ababa', '2024-05-31 07:00:00', '2024-05-31 08:30:00', '01:30:00', 'Business', 'Cancelled'),
(21, 'Ethiopian Airlines', 'ET117', 'Addis Ababa', 'Arba Minch', '2024-05-31 08:00:00', '2024-05-31 09:30:00', '01:30:00', 'First Class', 'On Time'),
(22, 'Ethiopian Airlines', 'ET118', 'Arba Minch', 'Addis Ababa', '2024-05-31 10:00:00', '2024-05-31 11:30:00', '01:30:00', 'First Class', 'Delayed'),
(23, 'Ethiopian Airlines', 'ET119', 'Addis Ababa', 'Harar', '2024-05-31 11:00:00', '2024-05-31 12:30:00', '01:30:00', 'Economy', 'On Time'),
(24, 'Ethiopian Airlines', 'ET120', 'Harar', 'Addis Ababa', '2024-05-31 13:00:00', '2024-05-31 14:30:00', '01:30:00', 'Economy', 'Cancelled'),
(25, 'Ethiopian Airlines', 'ET121', 'Addis Ababa', 'Shashamane', '2024-05-31 14:00:00', '2024-05-31 15:30:00', '01:30:00', 'Business', 'On Time'),
(26, 'Ethiopian Airlines', 'ET122', 'Shashamane', 'Addis Ababa', '2024-05-31 16:00:00', '2024-05-31 17:30:00', '01:30:00', 'Business', 'Delayed'),
(27, 'Ethiopian Airlines', 'ET123', 'Addis Ababa', 'Debre Markos', '2024-05-31 17:00:00', '2024-05-31 18:30:00', '01:30:00', 'First Class', 'On Time'),
(28, 'Ethiopian Airlines', 'ET124', 'Debre Markos', 'Addis Ababa', '2024-05-31 19:00:00', '2024-05-31 20:30:00', '01:30:00', 'First Class', 'Cancelled'),
(29, 'Ethiopian Airlines', 'ET125', 'Addis Ababa', 'Woldia', '2024-05-31 20:00:00', '2024-05-31 21:30:00', '01:30:00', 'Economy', 'On Time'),
(30, 'Ethiopian Airlines', 'ET126', 'Woldia', 'Addis Ababa', '2024-05-31 22:00:00', '2024-05-31 23:30:00', '01:30:00', 'Economy', 'Delayed'),
(31, 'Ethiopian Airlines', 'ET127', 'Addis Ababa', 'Nekemte', '2024-05-31 23:00:00', '2024-06-01 00:30:00', '01:30:00', 'Business', 'On Time'),
(32, 'Ethiopian Airlines', 'ET128', 'Nekemte', 'Addis Ababa', '2024-06-01 01:00:00', '2024-06-01 02:30:00', '01:30:00', 'Business', 'Cancelled'),
(33, 'Ethiopian Airlines', 'ET129', 'Addis Ababa', 'Sodo', '2024-06-01 02:00:00', '2024-06-01 03:30:00', '01:30:00', 'First Class', 'On Time'),
(34, 'Ethiopian Airlines', 'ET130', 'Sodo', 'Addis Ababa', '2024-06-01 04:00:00', '2024-06-01 05:30:00', '01:30:00', 'First Class', 'Delayed'),
(35, 'Ethiopian Airlines', 'ET131', 'Addis Ababa', 'Dilla', '2024-06-01 05:00:00', '2024-06-01 06:30:00', '01:30:00', 'Economy', 'On Time'),
(36, 'Ethiopian Airlines', 'ET132', 'Dilla', 'Addis Ababa', '2024-06-01 07:00:00', '2024-06-01 08:30:00', '01:30:00', 'Economy', 'Delayed'),
(337, 'Ethiopian Airlines', 'ET151', 'Dire Dawa', 'Addis Ababa', '2024-05-25 08:30:00', '2024-05-25 10:00:00', '01:30:00', 'Economy', 'On Time'),
(338, 'Ethiopian Airlines', 'ET153', 'Dire Dawa', 'Addis Ababa', '2024-05-25 10:30:00', '2024-05-25 12:00:00', '01:30:00', 'Economy', 'Delayed'),
(339, 'Ethiopian Airlines', 'ET154', 'Dire Dawa', 'Addis Ababa', '2024-05-25 11:30:00', '2024-05-25 13:00:00', '01:30:00', 'Business', 'On Time'),
(340, 'Ethiopian Airlines', 'ET155', 'Dire Dawa', 'Addis Ababa', '2024-05-25 13:30:00', '2024-05-25 15:00:00', '01:30:00', 'Business', 'Cancelled'),
(341, 'Ethiopian Airlines', 'ET156', 'Dire Dawa', 'Addis Ababa', '2024-05-25 15:30:00', '2024-05-25 17:00:00', '01:30:00', 'First Class', 'On Time'),
(342, 'Ethiopian Airlines', 'ET157', 'Mekelle', 'Addis Ababa', '2024-05-25 09:00:00', '2024-05-25 10:30:00', '01:30:00', 'Economy', 'On Time'),
(343, 'Ethiopian Airlines', 'ET158', 'Mekelle', 'Addis Ababa', '2024-05-25 11:00:00', '2024-05-25 12:30:00', '01:30:00', 'Economy', 'Delayed'),
(344, 'Ethiopian Airlines', 'ET159', 'Mekelle', 'Addis Ababa', '2024-05-25 13:00:00', '2024-05-25 14:30:00', '01:30:00', 'Business', 'On Time'),
(345, 'Ethiopian Airlines', 'ET160', 'Mekelle', 'Addis Ababa', '2024-05-25 15:00:00', '2024-05-25 16:30:00', '01:30:00', 'Business', 'Cancelled'),
(346, 'Ethiopian Airlines', 'ET161', 'Mekelle', 'Addis Ababa', '2024-05-25 17:00:00', '2024-05-25 18:30:00', '01:30:00', 'First Class', 'On Time'),
(347, 'Ethiopian Airlines', 'ET162', 'Gondar', 'Addis Ababa', '2024-05-25 08:00:00', '2024-05-25 09:30:00', '01:30:00', 'Economy', 'On Time'),
(348, 'Ethiopian Airlines', 'ET163', 'Gondar', 'Addis Ababa', '2024-05-25 10:00:00', '2024-05-25 11:30:00', '01:30:00', 'Economy', 'Delayed'),
(349, 'Ethiopian Airlines', 'ET164', 'Gondar', 'Addis Ababa', '2024-05-25 12:00:00', '2024-05-25 13:30:00', '01:30:00', 'Business', 'On Time'),
(350, 'Ethiopian Airlines', 'ET165', 'Gondar', 'Addis Ababa', '2024-05-25 14:00:00', '2024-05-25 15:30:00', '01:30:00', 'Business', 'Cancelled'),
(351, 'Ethiopian Airlines', 'ET166', 'Gondar', 'Addis Ababa', '2024-05-25 16:00:00', '2024-05-25 17:30:00', '01:30:00', 'First Class', 'On Time'),
(352, 'Ethiopian Airlines', 'ET167', 'Bahir Dar', 'Addis Ababa', '2024-05-25 07:30:00', '2024-05-25 09:00:00', '01:30:00', 'Economy', 'On Time'),
(353, 'Ethiopian Airlines', 'ET168', 'Bahir Dar', 'Addis Ababa', '2024-05-25 09:30:00', '2024-05-25 11:00:00', '01:30:00', 'Economy', 'Delayed'),
(354, 'Ethiopian Airlines', 'ET169', 'Bahir Dar', 'Addis Ababa', '2024-05-25 11:30:00', '2024-05-25 13:00:00', '01:30:00', 'Business', 'On Time'),
(355, 'Ethiopian Airlines', 'ET170', 'Bahir Dar', 'Addis Ababa', '2024-05-25 13:30:00', '2024-05-25 15:00:00', '01:30:00', 'Business', 'Cancelled'),
(356, 'Ethiopian Airlines', 'ET171', 'Bahir Dar', 'Addis Ababa', '2024-05-25 15:30:00', '2024-05-25 17:00:00', '01:30:00', 'First Class', 'On Time'),
(357, 'Ethiopian Airlines', 'ET172', 'Hawassa', 'Addis Ababa', '2024-05-25 08:00:00', '2024-05-25 09:30:00', '01:30:00', 'Economy', 'On Time'),
(358, 'Ethiopian Airlines', 'ET173', 'Hawassa', 'Addis Ababa', '2024-05-25 10:00:00', '2024-05-25 11:30:00', '01:30:00', 'Economy', 'Delayed'),
(359, 'Ethiopian Airlines', 'ET174', 'Hawassa', 'Addis Ababa', '2024-05-25 12:00:00', '2024-05-25 13:30:00', '01:30:00', 'Business', 'On Time'),
(360, 'Ethiopian Airlines', 'ET175', 'Hawassa', 'Addis Ababa', '2024-05-25 14:00:00', '2024-05-25 15:30:00', '01:30:00', 'Business', 'Cancelled'),
(361, 'Ethiopian Airlines', 'ET176', 'Hawassa', 'Addis Ababa', '2024-05-25 16:00:00', '2024-05-25 17:30:00', '01:30:00', 'First Class', 'On Time'),
(362, 'Ethiopian Airlines', 'ET177', 'Jijiga', 'Addis Ababa', '2024-05-25 08:30:00', '2024-05-25 10:00:00', '01:30:00', 'Economy', 'On Time'),
(363, 'Ethiopian Airlines', 'ET178', 'Jijiga', 'Addis Ababa', '2024-05-25 10:30:00', '2024-05-25 12:00:00', '01:30:00', 'Economy', 'Delayed'),
(364, 'Ethiopian Airlines', 'ET179', 'Jijiga', 'Addis Ababa', '2024-05-25 12:30:00', '2024-05-25 14:00:00', '01:30:00', 'Business', 'On Time'),
(365, 'Ethiopian Airlines', 'ET180', 'Jijiga', 'Addis Ababa', '2024-05-25 14:30:00', '2024-05-25 16:00:00', '01:30:00', 'Business', 'Cancelled'),
(366, 'Ethiopian Airlines', 'ET181', 'Jijiga', 'Addis Ababa', '2024-05-25 16:30:00', '2024-05-25 18:00:00', '01:30:00', 'First Class', 'On Time'),
(367, 'Ethiopian Airlines', 'ET182', 'Jimma', 'Addis Ababa', '2024-05-25 09:00:00', '2024-05-25 10:30:00', '01:30:00', 'Economy', 'On Time'),
(368, 'Ethiopian Airlines', 'ET183', 'Jimma', 'Addis Ababa', '2024-05-25 10:45:00', '2024-05-25 12:15:00', '01:30:00', 'Economy', 'Delayed'),
(369, 'Ethiopian Airlines', 'ET184', 'Jimma', 'Addis Ababa', '2024-05-25 12:30:00', '2024-05-25 14:00:00', '01:30:00', 'Business', 'On Time'),
(370, 'Ethiopian Airlines', 'ET134', 'Jimma', 'Addis Ababa', '2024-05-25 14:15:00', '2024-05-25 15:45:00', '01:30:00', 'Business', 'Cancelled'),
(371, 'Ethiopian Airlines', 'ET135', 'Jimma', 'Addis Ababa', '2024-05-25 16:00:00', '2024-05-25 17:30:00', '01:30:00', 'First Class', 'On Time'),
(372, 'Ethiopian Airlines', 'ET136', 'Adama', 'Addis Ababa', '2024-05-25 08:30:00', '2024-05-25 10:00:00', '01:30:00', 'Economy', 'On Time'),
(373, 'Ethiopian Airlines', 'ET137', 'Adama', 'Addis Ababa', '2024-05-25 10:15:00', '2024-05-25 11:45:00', '01:30:00', 'Economy', 'Delayed'),
(374, 'Ethiopian Airlines', 'ET138', 'Adama', 'Addis Ababa', '2024-05-25 12:00:00', '2024-05-25 13:30:00', '01:30:00', 'Business', 'On Time'),
(375, 'Ethiopian Airlines', 'ET139', 'Adama', 'Addis Ababa', '2024-05-25 13:45:00', '2024-05-25 15:15:00', '01:30:00', 'Business', 'Cancelled'),
(376, 'Ethiopian Airlines', 'ET140', 'Adama', 'Addis Ababa', '2024-05-25 15:30:00', '2024-05-25 17:00:00', '01:30:00', 'First Class', 'On Time'),
(377, 'Ethiopian Airlines', 'ET141', 'Dessie', 'Addis Ababa', '2024-05-25 08:45:00', '2024-05-25 10:15:00', '01:30:00', 'Economy', 'On Time'),
(378, 'Ethiopian Airlines', 'ET142', 'Dessie', 'Addis Ababa', '2024-05-25 10:30:00', '2024-05-25 12:00:00', '01:30:00', 'Economy', 'Delayed'),
(379, 'Ethiopian Airlines', 'ET143', 'Dessie', 'Addis Ababa', '2024-05-25 12:15:00', '2024-05-25 13:45:00', '01:30:00', 'Business', 'On Time'),
(380, 'Ethiopian Airlines', 'ET144', 'Dessie', 'Addis Ababa', '2024-05-25 14:00:00', '2024-05-25 15:30:00', '01:30:00', 'Business', 'Cancelled'),
(381, 'Ethiopian Airlines', 'ET145', 'Dessie', 'Addis Ababa', '2024-05-25 15:45:00', '2024-05-25 17:15:00', '01:30:00', 'First Class', 'On Time'),
(382, 'Ethiopian Airlines', 'ET146', 'Bishoftu', 'Addis Ababa', '2024-05-25 09:15:00', '2024-05-25 10:45:00', '01:30:00', 'Economy', 'On Time'),
(383, 'Ethiopian Airlines', 'ET147', 'Bishoftu', 'Addis Ababa', '2024-05-25 11:00:00', '2024-05-25 12:30:00', '01:30:00', 'Economy', 'Delayed'),
(384, 'Ethiopian Airlines', 'ET148', 'Bishoftu', 'Addis Ababa', '2024-05-25 12:45:00', '2024-05-25 14:15:00', '01:30:00', 'Business', 'On Time'),
(385, 'Ethiopian Airlines', 'ET149', 'Bishoftu', 'Addis Ababa', '2024-05-25 14:30:00', '2024-05-25 16:00:00', '01:30:00', 'Business', 'Cancelled'),
(386, 'Ethiopian Airlines', 'ET150', 'Bishoftu', 'Addis Ababa', '2024-05-25 16:15:00', '2024-05-25 17:45:00', '01:30:00', 'First Class', 'On Time'),
(387, 'Ethiopian Airlines', 'ET201', 'Addis Ababa', 'Dire Dawa', '2024-05-25 08:00:00', '2024-05-25 09:30:00', '01:30:00', 'Economy', 'On Time'),
(388, 'Ethiopian Airlines', 'ET202', 'Addis Ababa', 'Dire Dawa', '2024-05-25 10:00:00', '2024-05-25 11:30:00', '01:30:00', 'Economy', 'Delayed'),
(389, 'Ethiopian Airlines', 'ET203', 'Addis Ababa', 'Dire Dawa', '2024-05-25 12:00:00', '2024-05-25 13:30:00', '01:30:00', 'Business', 'On Time'),
(390, 'Ethiopian Airlines', 'ET204', 'Addis Ababa', 'Dire Dawa', '2024-05-25 14:00:00', '2024-05-25 15:30:00', '01:30:00', 'Business', 'Cancelled'),
(391, 'Ethiopian Airlines', 'ET205', 'Addis Ababa', 'Dire Dawa', '2024-05-25 16:00:00', '2024-05-25 17:30:00', '01:30:00', 'First Class', 'On Time'),
(392, 'Ethiopian Airlines', 'ET206', 'Addis Ababa', 'Mekelle', '2024-05-25 08:15:00', '2024-05-25 09:45:00', '01:30:00', 'Economy', 'On Time'),
(393, 'Ethiopian Airlines', 'ET207', 'Addis Ababa', 'Mekelle', '2024-05-25 10:15:00', '2024-05-25 11:45:00', '01:30:00', 'Economy', 'Delayed'),
(394, 'Ethiopian Airlines', 'ET208', 'Addis Ababa', 'Mekelle', '2024-05-25 12:15:00', '2024-05-25 13:45:00', '01:30:00', 'Business', 'On Time'),
(395, 'Ethiopian Airlines', 'ET209', 'Addis Ababa', 'Mekelle', '2024-05-25 14:15:00', '2024-05-25 15:45:00', '01:30:00', 'Business', 'Cancelled'),
(396, 'Ethiopian Airlines', 'ET210', 'Addis Ababa', 'Mekelle', '2024-05-25 16:15:00', '2024-05-25 17:45:00', '01:30:00', 'First Class', 'On Time'),
(397, 'Ethiopian Airlines', 'ET211', 'Addis Ababa', 'Gondar', '2024-05-25 08:30:00', '2024-05-25 10:00:00', '01:30:00', 'Economy', 'On Time'),
(398, 'Ethiopian Airlines', 'ET212', 'Addis Ababa', 'Gondar', '2024-05-25 10:30:00', '2024-05-25 12:00:00', '01:30:00', 'Economy', 'Delayed'),
(399, 'Ethiopian Airlines', 'ET213', 'Addis Ababa', 'Gondar', '2024-05-25 12:30:00', '2024-05-25 14:00:00', '01:30:00', 'Business', 'On Time'),
(400, 'Ethiopian Airlines', 'ET214', 'Addis Ababa', 'Gondar', '2024-05-25 14:30:00', '2024-05-25 16:00:00', '01:30:00', 'Business', 'Cancelled'),
(401, 'Ethiopian Airlines', 'ET215', 'Addis Ababa', 'Gondar', '2024-05-25 16:30:00', '2024-05-25 18:00:00', '01:30:00', 'First Class', 'On Time'),
(402, 'Ethiopian Airlines', 'ET216', 'Addis Ababa', 'Bahir Dar', '2024-05-25 08:45:00', '2024-05-25 10:15:00', '01:30:00', 'Economy', 'On Time'),
(403, 'Ethiopian Airlines', 'ET217', 'Addis Ababa', 'Bahir Dar', '2024-05-25 10:45:00', '2024-05-25 12:15:00', '01:30:00', 'Economy', 'Delayed'),
(404, 'Ethiopian Airlines', 'ET218', 'Addis Ababa', 'Bahir Dar', '2024-05-25 12:45:00', '2024-05-25 14:15:00', '01:30:00', 'Business', 'On Time'),
(405, 'Ethiopian Airlines', 'ET219', 'Addis Ababa', 'Bahir Dar', '2024-05-25 14:45:00', '2024-05-25 16:15:00', '01:30:00', 'Business', 'Cancelled'),
(406, 'Ethiopian Airlines', 'ET220', 'Addis Ababa', 'Bahir Dar', '2024-05-25 16:45:00', '2024-05-25 18:15:00', '01:30:00', 'First Class', 'On Time'),
(407, 'Ethiopian Airlines', 'ET221', 'Addis Ababa', 'Hawassa', '2024-05-25 09:00:00', '2024-05-25 10:30:00', '01:30:00', 'Economy', 'On Time'),
(408, 'Ethiopian Airlines', 'ET222', 'Addis Ababa', 'Hawassa', '2024-05-25 11:00:00', '2024-05-25 12:30:00', '01:30:00', 'Economy', 'Delayed'),
(409, 'Ethiopian Airlines', 'ET223', 'Addis Ababa', 'Hawassa', '2024-05-25 13:00:00', '2024-05-25 14:30:00', '01:30:00', 'Business', 'On Time'),
(410, 'Ethiopian Airlines', 'ET224', 'Addis Ababa', 'Hawassa', '2024-05-25 15:00:00', '2024-05-25 16:30:00', '01:30:00', 'Business', 'Cancelled'),
(411, 'Ethiopian Airlines', 'ET225', 'Addis Ababa', 'Hawassa', '2024-05-25 17:00:00', '2024-05-25 18:30:00', '01:30:00', 'First Class', 'On Time'),
(412, 'Ethiopian Airlines', 'ET226', 'Addis Ababa', 'Jijiga', '2024-05-25 09:15:00', '2024-05-25 10:45:00', '01:30:00', 'Economy', 'On Time'),
(413, 'Ethiopian Airlines', 'ET227', 'Addis Ababa', 'Jijiga', '2024-05-25 11:15:00', '2024-05-25 12:45:00', '01:30:00', 'Economy', 'Delayed'),
(414, 'Ethiopian Airlines', 'ET228', 'Addis Ababa', 'Jijiga', '2024-05-25 13:15:00', '2024-05-25 14:45:00', '01:30:00', 'Business', 'On Time'),
(415, 'Ethiopian Airlines', 'ET229', 'Addis Ababa', 'Jijiga', '2024-05-25 15:15:00', '2024-05-25 16:45:00', '01:30:00', 'Business', 'Cancelled'),
(416, 'Ethiopian Airlines', 'ET230', 'Addis Ababa', 'Jijiga', '2024-05-25 17:15:00', '2024-05-25 18:45:00', '01:30:00', 'First Class', 'On Time'),
(417, 'Ethiopian Airlines', 'ET231', 'Addis Ababa', 'Jimma', '2024-05-25 09:30:00', '2024-05-25 11:00:00', '01:30:00', 'Economy', 'On Time'),
(418, 'Ethiopian Airlines', 'ET232', 'Addis Ababa', 'Jimma', '2024-05-25 11:30:00', '2024-05-25 13:00:00', '01:30:00', 'Economy', 'Delayed'),
(419, 'Ethiopian Airlines', 'ET233', 'Addis Ababa', 'Jimma', '2024-05-25 13:30:00', '2024-05-25 15:00:00', '01:30:00', 'Business', 'On Time'),
(420, 'Ethiopian Airlines', 'ET234', 'Addis Ababa', 'Jimma', '2024-05-25 15:30:00', '2024-05-25 17:00:00', '01:30:00', 'Business', 'Cancelled'),
(421, 'Ethiopian Airlines', 'ET235', 'Addis Ababa', 'Jimma', '2024-05-25 17:30:00', '2024-05-25 19:00:00', '01:30:00', 'First Class', 'On Time'),
(422, 'Ethiopian Airlines', 'ET236', 'Addis Ababa', 'Adama', '2024-05-25 09:45:00', '2024-05-25 11:15:00', '01:30:00', 'Economy', 'On Time'),
(423, 'Ethiopian Airlines', 'ET237', 'Addis Ababa', 'Adama', '2024-05-25 11:45:00', '2024-05-25 13:15:00', '01:30:00', 'Economy', 'Delayed'),
(424, 'Ethiopian Airlines', 'ET238', 'Addis Ababa', 'Adama', '2024-05-25 13:45:00', '2024-05-25 15:15:00', '01:30:00', 'Business', 'On Time'),
(425, 'Ethiopian Airlines', 'ET239', 'Addis Ababa', 'Adama', '2024-05-25 15:45:00', '2024-05-25 17:15:00', '01:30:00', 'Business', 'Cancelled'),
(426, 'Ethiopian Airlines', 'ET240', 'Addis Ababa', 'Adama', '2024-05-25 17:45:00', '2024-05-25 19:15:00', '01:30:00', 'First Class', 'On Time'),
(427, 'Ethiopian Airlines', 'ET241', 'Addis Ababa', 'Dessie', '2024-05-25 10:00:00', '2024-05-25 11:30:00', '01:30:00', 'Economy', 'On Time'),
(428, 'Ethiopian Airlines', 'ET242', 'Addis Ababa', 'Dessie', '2024-05-25 12:00:00', '2024-05-25 13:30:00', '01:30:00', 'Economy', 'Delayed'),
(429, 'Ethiopian Airlines', 'ET243', 'Addis Ababa', 'Dessie', '2024-05-25 14:00:00', '2024-05-25 15:30:00', '01:30:00', 'Business', 'On Time'),
(430, 'Ethiopian Airlines', 'ET244', 'Addis Ababa', 'Dessie', '2024-05-25 16:00:00', '2024-05-25 17:30:00', '01:30:00', 'Business', 'Cancelled'),
(431, 'Ethiopian Airlines', 'ET245', 'Addis Ababa', 'Dessie', '2024-05-25 18:00:00', '2024-05-25 19:30:00', '01:30:00', 'First Class', 'On Time'),
(432, 'Ethiopian Airlines', 'ET246', 'Addis Ababa', 'Bishoftu', '2024-05-25 10:15:00', '2024-05-25 11:45:00', '01:30:00', 'Economy', 'On Time'),
(433, 'Ethiopian Airlines', 'ET247', 'Addis Ababa', 'Bishoftu', '2024-05-25 12:15:00', '2024-05-25 13:45:00', '01:30:00', 'Economy', 'Delayed'),
(434, 'Ethiopian Airlines', 'ET248', 'Addis Ababa', 'Bishoftu', '2024-05-25 14:15:00', '2024-05-25 15:45:00', '01:30:00', 'Business', 'On Time'),
(435, 'Ethiopian Airlines', 'ET249', 'Addis Ababa', 'Bishoftu', '2024-05-25 16:15:00', '2024-05-25 17:45:00', '01:30:00', 'Business', 'Cancelled'),
(436, 'Ethiopian Airlines', 'ET250', 'Addis Ababa', 'Bishoftu', '2024-05-25 18:15:00', '2024-05-25 19:45:00', '01:30:00', 'First Class', 'On Time'),
(437, 'Ethiopian Airlines', 'ET251', 'Addis Ababa', 'Arba Minch', '2024-05-25 10:30:00', '2024-05-25 12:00:00', '01:30:00', 'Economy', 'On Time'),
(438, 'Ethiopian Airlines', 'ET252', 'Addis Ababa', 'Arba Minch', '2024-05-25 12:30:00', '2024-05-25 14:00:00', '01:30:00', 'Economy', 'Delayed'),
(439, 'Ethiopian Airlines', 'ET253', 'Addis Ababa', 'Arba Minch', '2024-05-25 14:30:00', '2024-05-25 16:00:00', '01:30:00', 'Business', 'On Time'),
(440, 'Ethiopian Airlines', 'ET254', 'Addis Ababa', 'Arba Minch', '2024-05-25 16:30:00', '2024-05-25 18:00:00', '01:30:00', 'Business', 'Cancelled'),
(441, 'Ethiopian Airlines', 'ET255', 'Addis Ababa', 'Arba Minch', '2024-05-25 18:30:00', '2024-05-25 20:00:00', '01:30:00', 'First Class', 'On Time'),
(442, 'Ethiopian Airlines', 'ET256', 'Addis Ababa', 'Harar', '2024-05-25 11:00:00', '2024-05-25 12:30:00', '01:30:00', 'Economy', 'On Time'),
(443, 'Ethiopian Airlines', 'ET257', 'Addis Ababa', 'Harar', '2024-05-25 13:00:00', '2024-05-25 14:30:00', '01:30:00', 'Economy', 'Delayed'),
(444, 'Ethiopian Airlines', 'ET258', 'Addis Ababa', 'Harar', '2024-05-25 15:00:00', '2024-05-25 16:30:00', '01:30:00', 'Business', 'On Time'),
(445, 'Ethiopian Airlines', 'ET259', 'Addis Ababa', 'Harar', '2024-05-25 17:00:00', '2024-05-25 18:30:00', '01:30:00', 'Business', 'Cancelled'),
(446, 'Ethiopian Airlines', 'ET260', 'Addis Ababa', 'Harar', '2024-05-25 19:00:00', '2024-05-25 20:30:00', '01:30:00', 'First Class', 'On Time'),
(447, 'Ethiopian Airlines', 'ET261', 'Addis Ababa', 'Shashamane', '2024-05-25 10:30:00', '2024-05-25 12:00:00', '01:30:00', 'Economy', 'On Time'),
(448, 'Ethiopian Airlines', 'ET262', 'Addis Ababa', 'Shashamane', '2024-05-25 12:30:00', '2024-05-25 14:00:00', '01:30:00', 'Economy', 'Delayed'),
(449, 'Ethiopian Airlines', 'ET263', 'Addis Ababa', 'Shashamane', '2024-05-25 14:30:00', '2024-05-25 16:00:00', '01:30:00', 'Business', 'On Time'),
(450, 'Ethiopian Airlines', 'ET264', 'Addis Ababa', 'Shashamane', '2024-05-25 16:30:00', '2024-05-25 18:00:00', '01:30:00', 'Business', 'Cancelled'),
(451, 'Ethiopian Airlines', 'ET265', 'Addis Ababa', 'Shashamane', '2024-05-25 18:30:00', '2024-05-25 20:00:00', '01:30:00', 'First Class', 'On Time'),
(452, 'Ethiopian Airlines', 'ET266', 'Addis Ababa', 'Debre Markos', '2024-05-25 11:00:00', '2024-05-25 12:30:00', '01:30:00', 'Economy', 'On Time'),
(453, 'Ethiopian Airlines', 'ET267', 'Addis Ababa', 'Debre Markos', '2024-05-25 13:00:00', '2024-05-25 14:30:00', '01:30:00', 'Economy', 'Delayed'),
(454, 'Ethiopian Airlines', 'ET268', 'Addis Ababa', 'Debre Markos', '2024-05-25 15:00:00', '2024-05-25 16:30:00', '01:30:00', 'Business', 'On Time'),
(455, 'Ethiopian Airlines', 'ET269', 'Addis Ababa', 'Debre Markos', '2024-05-25 17:00:00', '2024-05-25 18:30:00', '01:30:00', 'Business', 'Cancelled'),
(456, 'Ethiopian Airlines', 'ET270', 'Addis Ababa', 'Debre Markos', '2024-05-25 19:00:00', '2024-05-25 20:30:00', '01:30:00', 'First Class', 'On Time');

-- --------------------------------------------------------

--
-- Table structure for table `flightstatus`
--

CREATE TABLE `flightstatus` (
  `StatusID` int(11) NOT NULL,
  `FlightID` int(11) DEFAULT NULL,
  `StatusTime` datetime DEFAULT NULL,
  `Status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `name`) VALUES
(1, 'Addis Ababa'),
(2, 'Dire Dawa'),
(3, 'Mekelle'),
(4, 'Gondar'),
(5, 'Bahir Dar'),
(6, 'Hawassa'),
(7, 'Jijiga'),
(8, 'Jimma'),
(9, 'Adama'),
(10, 'Arba Minch'),
(11, 'Harar'),
(12, 'Shashamane'),
(13, 'Debre Markos'),
(14, 'Woldia'),
(15, 'Nekemte'),
(16, 'Sodo'),
(17, 'Dilla');

-- --------------------------------------------------------

--
-- Table structure for table `loyaltyprogram`
--

CREATE TABLE `loyaltyprogram` (
  `LoyaltyProgramID` int(11) NOT NULL,
  `UserID` int(11) DEFAULT NULL,
  `Points` int(11) DEFAULT NULL,
  `MembershipLevel` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loyaltyprogram`
--

INSERT INTO `loyaltyprogram` (`LoyaltyProgramID`, `UserID`, `Points`, `MembershipLevel`) VALUES
(1, 1, 1000, 'Gold'),
(2, 2, 500, 'Silver');

-- --------------------------------------------------------

--
-- Table structure for table `passengers`
--

CREATE TABLE `passengers` (
  `PassengerID` int(11) NOT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `PhoneNumber` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `passengers`
--

INSERT INTO `passengers` (`PassengerID`, `FirstName`, `LastName`, `Email`, `PhoneNumber`) VALUES
(32, 'abel', 'melkamu', 'abel@gmail.com', '0987654321');

-- --------------------------------------------------------

--
-- Table structure for table `price`
--

CREATE TABLE `price` (
  `PriceID` int(11) NOT NULL,
  `FlightID` int(11) NOT NULL,
  `Price` decimal(10,2) NOT NULL,
  `Currency` varchar(10) NOT NULL DEFAULT 'Birr'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `price`
--

INSERT INTO `price` (`PriceID`, `FlightID`, `Price`, `Currency`) VALUES
(1, 5, '4032.00', 'Birr'),
(2, 6, '4769.00', 'Birr'),
(3, 7, '4747.00', 'Birr'),
(4, 8, '4432.00', 'Birr'),
(5, 9, '4916.00', 'Birr'),
(6, 10, '4287.00', 'Birr'),
(7, 11, '4686.00', 'Birr'),
(8, 12, '4569.00', 'Birr'),
(9, 13, '4790.00', 'Birr'),
(10, 14, '4242.00', 'Birr'),
(11, 15, '4841.00', 'Birr'),
(12, 16, '4479.00', 'Birr'),
(13, 17, '4873.00', 'Birr'),
(14, 18, '4928.00', 'Birr'),
(15, 19, '4022.00', 'Birr'),
(16, 20, '4326.00', 'Birr'),
(17, 21, '4563.00', 'Birr'),
(18, 22, '4839.00', 'Birr'),
(19, 23, '4508.00', 'Birr'),
(20, 24, '4021.00', 'Birr'),
(21, 25, '4584.00', 'Birr'),
(22, 26, '4856.00', 'Birr'),
(23, 27, '4528.00', 'Birr'),
(24, 28, '4074.00', 'Birr'),
(25, 29, '4785.00', 'Birr'),
(26, 30, '4705.00', 'Birr'),
(27, 31, '4172.00', 'Birr'),
(28, 32, '4743.00', 'Birr'),
(29, 33, '4202.00', 'Birr'),
(30, 34, '4779.00', 'Birr'),
(31, 35, '4292.00', 'Birr'),
(32, 36, '4122.00', 'Birr'),
(33, 370, '4734.00', 'Birr'),
(34, 371, '4303.00', 'Birr'),
(35, 372, '4315.00', 'Birr'),
(36, 373, '4669.00', 'Birr'),
(37, 374, '4397.00', 'Birr'),
(38, 375, '4978.00', 'Birr'),
(39, 376, '4700.00', 'Birr'),
(40, 377, '4568.00', 'Birr'),
(41, 378, '4739.00', 'Birr'),
(42, 379, '4991.00', 'Birr'),
(43, 380, '4741.00', 'Birr'),
(44, 381, '4732.00', 'Birr'),
(45, 382, '4437.00', 'Birr'),
(46, 383, '4988.00', 'Birr'),
(47, 384, '4631.00', 'Birr'),
(48, 385, '4192.00', 'Birr'),
(49, 386, '4067.00', 'Birr'),
(50, 337, '4761.00', 'Birr'),
(51, 338, '4602.00', 'Birr'),
(52, 339, '4729.00', 'Birr'),
(53, 340, '4838.00', 'Birr'),
(54, 341, '4004.00', 'Birr'),
(55, 342, '4505.00', 'Birr'),
(56, 343, '4514.00', 'Birr'),
(57, 344, '4057.00', 'Birr'),
(58, 345, '4741.00', 'Birr'),
(59, 346, '4537.00', 'Birr'),
(60, 347, '4462.00', 'Birr'),
(61, 348, '4701.00', 'Birr'),
(62, 349, '4120.00', 'Birr'),
(63, 350, '4494.00', 'Birr'),
(64, 351, '4113.00', 'Birr'),
(65, 352, '4084.00', 'Birr'),
(66, 353, '4082.00', 'Birr'),
(67, 354, '4158.00', 'Birr'),
(68, 355, '4546.00', 'Birr'),
(69, 356, '4253.00', 'Birr'),
(70, 357, '4630.00', 'Birr'),
(71, 358, '4390.00', 'Birr'),
(72, 359, '4060.00', 'Birr'),
(73, 360, '4133.00', 'Birr'),
(74, 361, '4484.00', 'Birr'),
(75, 362, '4024.00', 'Birr'),
(76, 363, '4666.00', 'Birr'),
(77, 364, '4259.00', 'Birr'),
(78, 365, '4299.00', 'Birr'),
(79, 366, '4716.00', 'Birr'),
(80, 367, '4683.00', 'Birr'),
(81, 368, '4270.00', 'Birr'),
(82, 369, '4301.00', 'Birr'),
(83, 387, '4695.00', 'Birr'),
(84, 388, '4572.00', 'Birr'),
(85, 389, '4777.00', 'Birr'),
(86, 390, '4171.00', 'Birr'),
(87, 391, '4522.00', 'Birr'),
(88, 392, '4096.00', 'Birr'),
(89, 393, '4917.00', 'Birr'),
(90, 394, '4298.00', 'Birr'),
(91, 395, '4737.00', 'Birr'),
(92, 396, '4793.00', 'Birr'),
(93, 397, '4753.00', 'Birr'),
(94, 398, '4389.00', 'Birr'),
(95, 399, '4684.00', 'Birr'),
(96, 400, '4256.00', 'Birr'),
(97, 401, '4229.00', 'Birr'),
(98, 402, '4378.00', 'Birr'),
(99, 403, '4204.00', 'Birr'),
(100, 404, '4887.00', 'Birr'),
(101, 405, '4821.00', 'Birr'),
(102, 406, '4447.00', 'Birr'),
(103, 407, '4771.00', 'Birr'),
(104, 408, '4513.00', 'Birr'),
(105, 409, '4255.00', 'Birr'),
(106, 410, '4736.00', 'Birr'),
(107, 411, '4915.00', 'Birr'),
(108, 412, '4367.00', 'Birr'),
(109, 413, '4090.00', 'Birr'),
(110, 414, '4352.00', 'Birr'),
(111, 415, '4491.00', 'Birr'),
(112, 416, '4396.00', 'Birr'),
(113, 417, '4510.00', 'Birr'),
(114, 418, '4364.00', 'Birr'),
(115, 419, '4287.00', 'Birr'),
(116, 420, '4344.00', 'Birr'),
(117, 421, '4862.00', 'Birr'),
(118, 422, '4275.00', 'Birr'),
(119, 423, '4792.00', 'Birr'),
(120, 424, '4133.00', 'Birr'),
(121, 425, '4290.00', 'Birr'),
(122, 426, '4052.00', 'Birr'),
(123, 427, '4389.00', 'Birr'),
(124, 428, '4792.00', 'Birr'),
(125, 429, '4792.00', 'Birr'),
(126, 430, '4585.00', 'Birr'),
(127, 431, '4548.00', 'Birr'),
(128, 432, '4988.00', 'Birr'),
(129, 433, '4298.00', 'Birr'),
(130, 434, '4523.00', 'Birr'),
(131, 435, '4721.00', 'Birr'),
(132, 436, '4038.00', 'Birr'),
(133, 437, '4027.00', 'Birr'),
(134, 438, '4023.00', 'Birr'),
(135, 439, '4033.00', 'Birr'),
(136, 440, '4098.00', 'Birr'),
(137, 441, '4391.00', 'Birr'),
(138, 442, '4659.00', 'Birr'),
(139, 443, '4125.00', 'Birr'),
(140, 444, '4647.00', 'Birr'),
(141, 445, '4862.00', 'Birr'),
(142, 446, '4371.00', 'Birr'),
(143, 447, '4268.00', 'Birr'),
(144, 448, '4227.00', 'Birr'),
(145, 449, '4333.00', 'Birr'),
(146, 450, '4985.00', 'Birr'),
(147, 451, '4926.00', 'Birr'),
(148, 452, '4673.00', 'Birr'),
(149, 453, '4590.00', 'Birr'),
(150, 454, '4933.00', 'Birr'),
(151, 455, '4894.00', 'Birr'),
(152, 456, '4671.00', 'Birr');

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `ServiceID` int(11) NOT NULL,
  `ServiceName` varchar(50) DEFAULT NULL,
  `ServiceDescription` text DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`ServiceID`, `ServiceName`, `ServiceDescription`, `Price`) VALUES
(1, 'Extra Baggage', 'Additional baggage allowance', '50.00'),
(2, 'Meal', 'In-flight meal', '20.00'),
(3, 'Seat Upgrade', 'Upgrade to business class', '200.00'),
(4, 'Priority Boarding', 'Priority boarding for faster boarding process', '30.00');

-- --------------------------------------------------------

--
-- Table structure for table `travelinfo`
--

CREATE TABLE `travelinfo` (
  `InfoID` int(11) NOT NULL,
  `InfoType` varchar(50) DEFAULT NULL,
  `Content` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `travelinfo`
--

INSERT INTO `travelinfo` (`InfoID`, `InfoType`, `Content`) VALUES
(1, 'Baggage Policy', 'Each passenger is allowed one carry-on and one checked bag. Additional baggage can be purchased.'),
(2, 'Check-In Policy', 'Online check-in is available 24 hours before departure and closes 2 hours before departure.'),
(3, 'Cancellation Policy', 'Cancellations are allowed up to 24 hours before departure with a full refund. After that, a fee applies.');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `UserID` int(11) NOT NULL,
  `Username` varchar(50) NOT NULL,
  `PasswordHash` varchar(255) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `PhoneNumber` varchar(15) DEFAULT NULL,
  `DateJoined` date DEFAULT NULL,
  `LoyaltyProgramID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UserID`, `Username`, `PasswordHash`, `Email`, `PhoneNumber`, `DateJoined`, `LoyaltyProgramID`) VALUES
(1, 'admin', 'adminhashedpassword', 'admin@example.com', '123-456-7890', '2024-01-01', NULL),
(2, 'test_user', 'testhashedpassword', 'test@example.com', '098-765-4321', '2024-02-01', NULL),
(3, 'abrham', '25d55ad283aa400af464c76d713c07ad', 'abrhamabebe@gmail.com', '0948910520', '2024-05-24', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`BookingID`),
  ADD KEY `UserID` (`UserID`),
  ADD KEY `FlightID` (`FlightID`),
  ADD KEY `bookings_ibfk_3` (`PassengerID`);

--
-- Indexes for table `checkin`
--
ALTER TABLE `checkin`
  ADD PRIMARY KEY (`CheckInID`),
  ADD KEY `BookingID` (`BookingID`);

--
-- Indexes for table `customersupport`
--
ALTER TABLE `customersupport`
  ADD PRIMARY KEY (`SupportID`),
  ADD KEY `UserID` (`UserID`);

--
-- Indexes for table `destinationguides`
--
ALTER TABLE `destinationguides`
  ADD PRIMARY KEY (`GuideID`);

--
-- Indexes for table `flights`
--
ALTER TABLE `flights`
  ADD PRIMARY KEY (`FlightID`),
  ADD UNIQUE KEY `FlightNumber` (`FlightNumber`);

--
-- Indexes for table `flightstatus`
--
ALTER TABLE `flightstatus`
  ADD PRIMARY KEY (`StatusID`),
  ADD KEY `FlightID` (`FlightID`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loyaltyprogram`
--
ALTER TABLE `loyaltyprogram`
  ADD PRIMARY KEY (`LoyaltyProgramID`),
  ADD KEY `UserID` (`UserID`);

--
-- Indexes for table `passengers`
--
ALTER TABLE `passengers`
  ADD PRIMARY KEY (`PassengerID`);

--
-- Indexes for table `price`
--
ALTER TABLE `price`
  ADD PRIMARY KEY (`PriceID`),
  ADD KEY `FlightID` (`FlightID`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`ServiceID`);

--
-- Indexes for table `travelinfo`
--
ALTER TABLE `travelinfo`
  ADD PRIMARY KEY (`InfoID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`),
  ADD UNIQUE KEY `Username` (`Username`),
  ADD UNIQUE KEY `Email` (`Email`),
  ADD KEY `LoyaltyProgramID` (`LoyaltyProgramID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `BookingID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `checkin`
--
ALTER TABLE `checkin`
  MODIFY `CheckInID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customersupport`
--
ALTER TABLE `customersupport`
  MODIFY `SupportID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `destinationguides`
--
ALTER TABLE `destinationguides`
  MODIFY `GuideID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `flights`
--
ALTER TABLE `flights`
  MODIFY `FlightID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=457;

--
-- AUTO_INCREMENT for table `flightstatus`
--
ALTER TABLE `flightstatus`
  MODIFY `StatusID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `loyaltyprogram`
--
ALTER TABLE `loyaltyprogram`
  MODIFY `LoyaltyProgramID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `passengers`
--
ALTER TABLE `passengers`
  MODIFY `PassengerID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `price`
--
ALTER TABLE `price`
  MODIFY `PriceID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=153;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `ServiceID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `travelinfo`
--
ALTER TABLE `travelinfo`
  MODIFY `InfoID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`),
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`FlightID`) REFERENCES `flights` (`FlightID`),
  ADD CONSTRAINT `bookings_ibfk_3` FOREIGN KEY (`PassengerID`) REFERENCES `passengers` (`PassengerID`);

--
-- Constraints for table `checkin`
--
ALTER TABLE `checkin`
  ADD CONSTRAINT `checkin_ibfk_1` FOREIGN KEY (`BookingID`) REFERENCES `bookings` (`BookingID`);

--
-- Constraints for table `customersupport`
--
ALTER TABLE `customersupport`
  ADD CONSTRAINT `customersupport_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`);

--
-- Constraints for table `flightstatus`
--
ALTER TABLE `flightstatus`
  ADD CONSTRAINT `flightstatus_ibfk_1` FOREIGN KEY (`FlightID`) REFERENCES `flights` (`FlightID`);

--
-- Constraints for table `loyaltyprogram`
--
ALTER TABLE `loyaltyprogram`
  ADD CONSTRAINT `loyaltyprogram_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`);

--
-- Constraints for table `price`
--
ALTER TABLE `price`
  ADD CONSTRAINT `price_ibfk_1` FOREIGN KEY (`FlightID`) REFERENCES `flights` (`FlightID`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`LoyaltyProgramID`) REFERENCES `loyaltyprogram` (`LoyaltyProgramID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
