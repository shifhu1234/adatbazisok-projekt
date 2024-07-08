-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 26, 2023 at 11:16 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `konferencia_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `article`
--

CREATE TABLE `article` (
  `id` int(11) NOT NULL,
  `users_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `section_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `article`
--

INSERT INTO `article` (`id`, `users_id`, `title`, `section_id`) VALUES
(1, 1, 'Cikk11', 1),
(2, 1, 'Cikk12', 1),
(3, 1, 'Cikk13', 1),
(52, 1, 'Cikk21', 2),
(53, 1, 'Cikk22', 2),
(54, 1, 'Cikk23', 2),
(55, 1, 'Cikk24', 2),
(56, 1, 'Cikk 31', 3),
(57, 1, 'Cikk32', 5),
(58, 1, 'Cikk33', 3),
(59, 1, 'Cikk34', 3),
(60, 1, 'Cikk35', 3),
(61, 1, 'Cikk44', 6),
(62, 51, 'szerzo1', 9),
(63, 51, 'cikk51', 8),
(64, 51, 'Cikk52', 8),
(65, 51, 'Cikk53', 5),
(66, 51, 'Cikk54', 5),
(67, 51, 'Cikk55', 2),
(68, 51, 'Cikk56', 21),
(69, 51, 'CikkUres', 18),
(70, 51, 'CikkKategNlekuli', NULL),
(71, 51, 'NincsSzekcioCikk', 7),
(72, 52, 'Szero2', 24),
(73, 52, 'szerzo2', 20),
(74, 52, 'Szekciokbategyuk', NULL),
(75, 52, 'Ujcikk', NULL),
(76, 52, 'LegyenolyanCikk', NULL),
(77, 52, 'LegyenCikkMelynekNeveMegegyezik', NULL),
(78, 52, 'EzLegyen cikk', NULL),
(79, 52, 'kateg nelkuli cikk', NULL),
(80, 52, 'lectureline', NULL),
(81, 52, 'cikkhozzaadasa', NULL),
(82, 52, 'randomszekciok', NULL),
(83, 52, 'sokcikkhozzadva', NULL),
(84, 52, 'hozzaadottCikk', NULL),
(85, 1, 'Cikkek', NULL),
(86, 1, 'Amiket', NULL),
(87, 1, 'Nem', NULL),
(88, 1, 'Kell', NULL),
(89, 1, 'Szekcioba', NULL),
(90, 1, 'Sorolni', NULL),
(91, 1, 'Ezért', NULL),
(92, 1, 'Készítek', NULL),
(93, 1, 'Nem1', NULL),
(94, 1, 'Cikket', NULL),
(95, 1, 'Amit', NULL),
(96, 1, 'Nemsorolok', NULL),
(97, 1, 'Szekciokba', NULL),
(98, 1, 'UtolsoSzekcio', NULL),
(99, 1, 'HozzarendeltEloadasTeszt', NULL),
(100, 1, 'Teszt', NULL),
(102, 53, 'TeljesNev', NULL),
(103, 53, 'TeljesNev2', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `conference`
--

CREATE TABLE `conference` (
  `id` int(11) NOT NULL,
  `users_id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `section_name` varchar(255) NOT NULL,
  `conference_starting_time` time DEFAULT NULL,
  `length` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `conference`
--

INSERT INTO `conference` (`id`, `users_id`, `article_id`, `section_name`, `conference_starting_time`, `length`) VALUES
(1, 1, 1, 'Szekcio1', '01:01:00', 20),
(2, 1, 2, 'Szekcio1', '00:57:00', 45),
(3, 1, 3, 'Szekcio1', '03:57:00', 45),
(4, 1, 52, 'Szekcio2', '22:57:00', 20),
(5, 1, 53, 'Szekcio2', '23:57:00', 20),
(6, 1, 54, 'Szekcio2', '01:00:00', 45),
(7, 1, 55, 'Szekcio2', '23:58:00', 45),
(8, 1, 56, 'Szekcio3', NULL, NULL),
(9, 1, 57, 'Szekcio5', '22:56:00', 20),
(10, 1, 58, 'Szekcio3', NULL, NULL),
(11, 1, 59, 'Szekcio3', NULL, NULL),
(12, 1, 60, 'Szekcio3', NULL, NULL),
(13, 1, 61, 'Szekcio6', NULL, NULL),
(14, 51, 62, 'Literary Lane', NULL, NULL),
(15, 51, 63, 'Math Marvels', NULL, NULL),
(16, 51, 64, 'Math Marvels', NULL, NULL),
(17, 51, 65, 'Szekcio5', NULL, NULL),
(18, 51, 66, 'Szekcio5', NULL, NULL),
(19, 51, 67, 'Szekcio2', NULL, NULL),
(20, 51, 68, 'Literature Lounge', NULL, NULL),
(21, 51, 69, 'Coding Cove', NULL, NULL),
(22, 51, 70, '', NULL, NULL),
(23, 51, 71, 'Science Safari', NULL, NULL),
(24, 52, 72, 'Digital Design District', NULL, NULL),
(25, 52, 73, 'Physics Plaza', NULL, NULL),
(26, 52, 74, '', NULL, NULL),
(27, 52, 75, '', NULL, NULL),
(28, 52, 76, '', NULL, NULL),
(29, 52, 77, '', NULL, NULL),
(30, 52, 78, '', NULL, NULL),
(31, 52, 79, '', NULL, NULL),
(32, 52, 80, '', NULL, NULL),
(33, 52, 81, '', NULL, NULL),
(34, 52, 82, '', NULL, NULL),
(35, 52, 83, '', NULL, NULL),
(36, 52, 84, '', NULL, NULL),
(37, 1, 85, '', NULL, NULL),
(38, 1, 86, '', NULL, NULL),
(39, 1, 87, '', NULL, NULL),
(40, 1, 88, '', NULL, NULL),
(41, 1, 89, '', NULL, NULL),
(42, 1, 90, '', NULL, NULL),
(43, 1, 91, '', NULL, NULL),
(44, 1, 92, '', NULL, NULL),
(45, 1, 93, '', NULL, NULL),
(46, 1, 94, '', NULL, NULL),
(47, 1, 95, '', NULL, NULL),
(48, 1, 96, '', NULL, NULL),
(49, 1, 97, '', NULL, NULL),
(50, 1, 98, '', NULL, NULL),
(51, 1, 99, '', NULL, NULL),
(52, 1, 100, '', NULL, NULL),
(54, 53, 102, '', NULL, NULL),
(55, 53, 103, '', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `section`
--

CREATE TABLE `section` (
  `id` int(11) NOT NULL,
  `section_name` varchar(255) NOT NULL,
  `users_id` int(11) DEFAULT NULL,
  `section_starting_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `section`
--

INSERT INTO `section` (`id`, `section_name`, `users_id`, `section_starting_time`) VALUES
(1, 'Szekcio1', 1, '2023-11-05 23:03:00'),
(2, 'Szekcio2', 2, NULL),
(3, 'Szekcio3', 4, NULL),
(4, 'Szekcio4', 8, NULL),
(5, 'Szekcio5', 1, NULL),
(6, 'Szekcio6', NULL, NULL),
(7, 'Science Safari', 1, NULL),
(8, 'Math Marvels', NULL, NULL),
(9, 'Literary Lane', 6, NULL),
(10, 'History Haven', NULL, NULL),
(11, 'Artistic Alcove', NULL, NULL),
(12, 'Language Lounge', NULL, NULL),
(13, 'Technology Trek', NULL, NULL),
(14, 'Geography Gallery', NULL, NULL),
(15, 'Music Meadow', NULL, NULL),
(16, 'Physical Fitness Frontier', NULL, NULL),
(17, 'Chemistry Corner', NULL, NULL),
(18, 'Coding Cove', NULL, NULL),
(19, 'Biology Boulevard', NULL, NULL),
(20, 'Physics Plaza', NULL, NULL),
(21, 'Literature Lounge', NULL, NULL),
(22, 'Mathematics Manor', NULL, NULL),
(23, 'History Hangout', NULL, NULL),
(24, 'Digital Design District', NULL, NULL),
(25, 'Environmental Exploratorium', NULL, NULL),
(26, 'Fine Arts Forum', NULL, NULL),
(27, 'Language Lab', NULL, NULL),
(28, 'Geology Gallery', NULL, NULL),
(29, 'Robotics Realm', NULL, NULL),
(30, 'Economics Enclave', NULL, NULL),
(31, 'Astronomy Arena', NULL, NULL),
(32, 'Health and Wellness Haven', NULL, NULL),
(33, 'Culinary Corner', NULL, NULL),
(34, 'Psychology Plaza', NULL, NULL),
(35, 'Educational Ecology', NULL, NULL),
(36, 'Philosophy Pavilion', NULL, NULL),
(37, 'Physics', NULL, NULL),
(38, 'Math', NULL, NULL),
(39, 'History', NULL, NULL),
(40, 'Coding', NULL, NULL),
(41, 'Biology', NULL, NULL),
(42, 'Literature', NULL, NULL),
(43, 'Chemistry', NULL, NULL),
(44, 'Art', NULL, NULL),
(45, 'Language', NULL, NULL),
(46, 'Geography', NULL, NULL),
(47, 'Music', NULL, NULL),
(48, 'Design', NULL, NULL),
(49, 'Robotics', NULL, NULL),
(50, 'Economics', NULL, NULL),
(51, 'Astronomy', NULL, NULL),
(52, 'Health', NULL, NULL),
(53, 'Culinary', NULL, NULL),
(54, 'Psychology', NULL, NULL),
(55, 'Environmental', NULL, NULL),
(56, 'Philosophy', NULL, NULL),
(57, 'Sociology', NULL, NULL),
(58, 'Engineering', NULL, NULL),
(59, 'Political', NULL, NULL),
(60, 'Virtual', NULL, NULL),
(61, 'Renewable', NULL, NULL),
(62, 'Ancient', NULL, NULL),
(63, 'Dance', NULL, NULL),
(64, 'Media', NULL, NULL),
(65, 'Ethics', NULL, NULL),
(66, 'Entrepreneurship', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'szerzo',
  `prefix` varchar(255) DEFAULT NULL,
  `institution` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `password`, `email`, `role`, `prefix`, `institution`) VALUES
(1, 'admin', '$2b$10$WdlmO32ggusMaIWIz.UeVeDkB2dxGyxak3xvyeAuDTV3br6aEwMIS', 'admin@admin', 'admin', 'dr', 'Intezmeny1'),
(2, 'user2', '$2b$10$w7a7vJzvNn2xBbuUgjJjwemdyoDkftSctJt3W8H2ezhsmYtYYxcLq', 'user2@example.com', 'admin', NULL, NULL),
(3, 'user3', '$2b$10$ey4VmMiRTMKlc4czUpPIS.91xZwTChG8Zq4wOngshDSy0cI1Im9yO', 'user3@example.com', 'admin', NULL, NULL),
(4, 'user4', '$2b$10$3dz1c29oCRBXnq9XO7/hC.MZH0GGO.wyN0nN9FzadO3/dxSmTT/U2', 'user4@example.com', 'szerzo', NULL, NULL),
(5, 'user5', '$2b$10$vx4Zp1TqemW0a.8.YSRsUOVeI6vf/VNvJ6I5HpR0x8cFfgY/qR2oi', 'user5@example.com', 'szerzo', NULL, NULL),
(6, 'user6', '$2b$10$MWeOIM5RcEJzXstQ9FvIqOuRfSmkJW6dcmgm.jWZ8VlVmK4IIV8wq', 'user6@example.com', 'szerzo', NULL, NULL),
(7, 'user7', '$2b$10$TO/7SAR9VKIiFioS5ZbTyunbWELjLmFh3FF6pCevy8hW/C.GkH8Je', 'user7@example.com', 'szerzo', NULL, NULL),
(8, 'user8', '$2b$10$qZf3M/S2EAIvF.5/5Ilgx.qMTv2geA1IChXO9s/D8X2xZd2uHTViO', 'user8@example.com', 'szerzo', NULL, NULL),
(9, 'user9', '$2b$10$GwHZZvNGhG42R0P3pKqz.uQXgpxC6TZpWcP4OPaPAtqfEKFy7IdZu', 'user9@example.com', 'szerzo', NULL, NULL),
(10, 'user10', '$2b$10$MlENXDtJQ/9bWIZiUqEvauoB4wzYUdZQQNciLbcqTD1a2nxkLIRfG', 'user10@example.com', 'szerzo', NULL, NULL),
(11, 'user11', '$2b$10$UZ8qDhjoXsEHbYbL2wHKLOzLzRuHXm6hIUVF2o21tGGDaU2dyuYKW', 'user11@example.com', 'szerzo', NULL, NULL),
(12, 'user12', '$2b$10$2osStQPwoiUOcVD/b5GkAuvnoy9UfDkI.l2nyB/7vGrJBQVpmTqX6', 'user12@example.com', 'szerzo', NULL, NULL),
(13, 'user13', '$2b$10$Lkm2aJhsxrhhtISHzSsTjOzQ.GDU5YOJ5VKbVV1BXhgzNr4IATfxK', 'user13@example.com', 'szerzo', NULL, NULL),
(14, 'user14', '$2b$10$hTGgJQ1yE9M2f0I3EJeL/.bY8tmW4yIxXaZONxkFQEyV2obKoNU.O', 'user14@example.com', 'szerzo', NULL, NULL),
(15, 'user15', '$2b$10$6Kq4N9z6nvFFLl3Hv9aeGuv.GQ5YlCOltyTJXEBR6wz/3lOMIt3Je', 'user15@example.com', 'szerzo', NULL, NULL),
(16, 'user16', '$2b$10$QGq8xncEZvXQF2/w3Un2ceBywksJ4UevZGb/iNLM/NSqoCjGmtZC2', 'user16@example.com', 'szerzo', NULL, NULL),
(17, 'user17', '$2b$10$0EYWFSlWSFopgWGheO2jwu7TS2lrYR4OhQxHgFJ5/Zeylu1rkw2bC', 'user17@example.com', 'szerzo', NULL, NULL),
(18, 'user18', '$2b$10$OVKKU2uZseojq0ISbxDK1e4nMGW7sJIspE0AB2b.2ATUjQDfnF5rW', 'user18@example.com', 'szerzo', NULL, NULL),
(19, 'user19', '$2b$10$dLJldG4eb96PwWeui2oMA.9fZjjbMlS9phlgtpJ.WTHNbr/l1aYRa', 'user19@example.com', 'szerzo', NULL, NULL),
(20, 'user20', '$2b$10$7Jwa/KuFD84j2lnt0pjKJ.ygPdBq/nWpKwB9cD.KH.kVb1qY1WbWK', 'user20@example.com', 'szerzo', NULL, NULL),
(21, 'user21', '$2b$10$ZH/3.UdKj5s1YveJrMA1bO3f/Md./ZLqEFHj9jbN.eer7qU9SYYmi', 'user21@example.com', 'szerzo', NULL, NULL),
(22, 'user22', '$2b$10$4.sOo/tPh.gprfC3LBfBPOhcte4TRdHl3kdyhgm3IXuW7aGK2q9nu', 'user22@example.com', 'szerzo', NULL, NULL),
(23, 'user23', '$2b$10$y0XkGZZ.7RSI9Ayz1Ub.R.u3J0BwBLD9QKerYVVubhyE7Af20X56C', 'user23@example.com', 'szerzo', NULL, NULL),
(24, 'user24', '$2b$10$9i6a9xEeZUsqHt.7Tmc8k.u2U/YoMlzP2O5Kgz/2fzY8j74pM4vG6', 'user24@example.com', 'szerzo', NULL, NULL),
(25, 'user25', '$2b$10$6TDxtR0LizleC9iX/RPK6eMlATJ8Ch9N0ZN9DPKD63Kt8Tiy4tPd6', 'user25@example.com', 'szerzo', NULL, NULL),
(26, 'user26', '$2b$10$Gph7y2Wgoq5JWJjzZ1RZ/OrnycUvlQebyrtPZqDWEVv0JWv.Qp7x2', 'user26@example.com', 'szerzo', NULL, NULL),
(27, 'user27', '$2b$10$ltP.78dCNSerZJZ9IjYYIebDV04cf9JLy9.vYUxdGRlffUzeyxpgW', 'user27@example.com', 'szerzo', NULL, NULL),
(28, 'user28', '$2b$10$RxysrA.NaIxjeuB51dy9Tu.B.0aP7RNBsvNe.EfJ19lZG/n9s4tSy', 'user28@example.com', 'szerzo', NULL, NULL),
(29, 'user29', '$2b$10$X3qRVLNt5j8IyFfYB8DszeIi/9dA4UgU0I.bw6EjDtk1LRRs4M7.a', 'user29@example.com', 'szerzo', NULL, NULL),
(30, 'user30', '$2b$10$8MUeZT01h3zDlX.GC5S3RuotjLIfvY2eMHvtCCGzq1lqGsj7ubj2S', 'user30@example.com', 'szerzo', NULL, NULL),
(31, 'user31', '$2b$10$MZ1l9tD2Dw8sU1b6MZVw3uThpmWbP1kTMYiJDA5Ovq5Y1RXZl2QDu', 'user31@example.com', 'szerzo', NULL, NULL),
(32, 'user32', '$2b$10$ONODsV2v.PNNHzD3ZihNm.5yEtv9TbC0/0A2mFZFcS4Q1gmfc4nZe', 'user32@example.com', 'szerzo', NULL, NULL),
(33, 'user33', '$2b$10$BUQUovV2wWDbMcRZ3TIR2Ot.ogWfSyTJj9VwL58vCo1bTOsKhvKXS', 'user33@example.com', 'szerzo', NULL, NULL),
(34, 'user34', '$2b$10$3tA.AKndomh7cvRfmD7x2OksIevh2ajdx9YXqHBUvsMHRsGmEP2e.', 'user34@example.com', 'szerzo', NULL, NULL),
(35, 'user35', '$2b$10$fTK4p98vn9IiFtiNxBh8z.fF5YRUv8Qe6YQWvES6I12V9yydeFwKa', 'user35@example.com', 'szerzo', NULL, NULL),
(36, 'user36', '$2b$10$4cluADUohuyF.RBuDPj.MexC8LpZ.lwi4G3w8NrUVhGxvBj.l6t8u', 'user36@example.com', 'szerzo', NULL, NULL),
(37, 'user37', '$2b$10$g2EkpXX2N19JEL/e3kEC/O9kiB/5RTQ1gqVDoiTwTfGZi.4mK9/qy', 'user37@example.com', 'szerzo', NULL, NULL),
(38, 'user38', '$2b$10$rL6yEgyyD/MQpO7mPxBzFe6/47b6YeGBjJlRn.ZFVrsXy8ke/vZ.e', 'user38@example.com', 'szerzo', NULL, NULL),
(39, 'user39', '$2b$10$1hBOV7aCqX8qjD/gTOaZdOndKU0O/.P/VjLVy6ch3ZGqY.0XX0ymO', 'user39@example.com', 'szerzo', NULL, NULL),
(40, 'user40', '$2b$10$xlwMDs2SNY55JcCILrkZ8uy2TRNRxLVO/3MYnLuBdrNpPHB/SuqIq', 'user40@example.com', 'szerzo', NULL, NULL),
(41, 'user41', '$2b$10$SGbI2AI3z0QkJ9JzsgHOhO2Swt6Xqs2PlB9ATNT/4XjiSD/ndVLgS', 'user41@example.com', 'szerzo', NULL, NULL),
(42, 'user42', '$2b$10$8w5DdZJmP8U2pL55fsdGMeqtcDMa6C66vwYcT5G5qXhVgN5sgEQ5y', 'user42@example.com', 'szerzo', NULL, NULL),
(43, 'user43', '$2b$10$5o6yWbWu6Nj8cdvHqem7Le/Zz/NHDNSoAoj8iE7jMTud0WGh7T9wm', 'user43@example.com', 'szerzo', NULL, NULL),
(44, 'user44', '$2b$10$uGr5LMF/GhdqA0vRgDUdWeD6R5r0M6UBf3TVEUerheBVC3Ve/JM16', 'user44@example.com', 'szerzo', NULL, NULL),
(45, 'user45', '$2b$10$5lIaIaEg4rS.f72z.XKMf.gmJ3Gn9W3B/q1BiF8pY4KifHsc/AYJ2', 'user45@example.com', 'szerzo', NULL, NULL),
(46, 'user46', '$2b$10$ZLiO8uGhXOgq9Q4PmH9BLeJue3JF/jVOI/qDWqu3h/YEwdkJN1WQO', 'user46@example.com', 'szerzo', NULL, NULL),
(47, 'user47', '$2b$10$2W5sDk1zqBoqkjT5PQX5d.eB2W58H2oOAK26VAG6/N1dSyR0OueCy', 'user47@example.com', 'szerzo', NULL, NULL),
(48, 'user48', '$2b$10$JtnkmNSVsPXCMePBCR7bnuwjve26Lg1/3YwA.P44js3e7b.UeGgeG', 'user48@example.com', 'szerzo', NULL, NULL),
(49, 'user49', '$2b$10$8V./IHUeiFZuM/JRDaqec.2yZTjH.6FPhSM6c1HfGAdmzsqLY/mSK', 'user49@example.com', 'szerzo', NULL, NULL),
(50, 'user50', '$2b$10$v3EDcU3phBCrv7eg/68zj.K7bWNTu4y.5m5UQV8RQ0xL9ZvaRwwQ2', 'user50@example.com', 'szerzo', NULL, NULL),
(51, 'szerzo1', '$2b$10$wFh4M6L1.LrPL8.Zn3S5h.UoH0QAht2feUQzukw01k/8jZnOO3.OO', 'szerzo@szerzo', 'szerzo', NULL, NULL),
(52, 'szerzo2', '$2b$10$6hKTFyKvuxXV/9yfDw8il.quikLftqRBhVfaEW.GEDgryJRy21r1.', 'szerzo2@szerzo2', 'szerzo', NULL, NULL),
(53, 'TeljesNev', '$2b$10$bINeRLQC/xf02F8tvULhreLoKoL9vUB4gJSt/QZdGwcK8Z.SMuboa', 'TeljesNev@TeljesNev', 'szerzo', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `article`
--
ALTER TABLE `article`
  ADD PRIMARY KEY (`id`),
  ADD KEY `article_ibfk_1` (`users_id`),
  ADD KEY `article_ibfk_2` (`section_id`);

--
-- Indexes for table `conference`
--
ALTER TABLE `conference`
  ADD PRIMARY KEY (`id`),
  ADD KEY `conference_ibfk_1` (`users_id`),
  ADD KEY `conference_ibfk_2` (`article_id`);

--
-- Indexes for table `section`
--
ALTER TABLE `section`
  ADD PRIMARY KEY (`id`),
  ADD KEY `section_ibfk_1` (`users_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `article`
--
ALTER TABLE `article`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT for table `conference`
--
ALTER TABLE `conference`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `section`
--
ALTER TABLE `section`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `article`
--
ALTER TABLE `article`
  ADD CONSTRAINT `article_ibfk_1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `article_ibfk_2` FOREIGN KEY (`section_id`) REFERENCES `section` (`id`);

--
-- Constraints for table `conference`
--
ALTER TABLE `conference`
  ADD CONSTRAINT `conference_ibfk_1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `conference_ibfk_2` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `section`
--
ALTER TABLE `section`
  ADD CONSTRAINT `section_ibfk_1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
