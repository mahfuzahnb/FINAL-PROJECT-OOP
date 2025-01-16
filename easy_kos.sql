-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 06, 2025 at 03:19 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `easy_kos`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `username`, `password`, `created_at`) VALUES
(1, 'admin', '12345', '2024-12-27 10:23:47');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `saldo` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `username`, `password`, `email`, `name`, `phone`, `address`, `saldo`) VALUES
(2, 'cust', '12345', 'customer@example.com', 'John Doe', '081234567890', 'Jl. Anggrek No. 123, Bandung', 500000.00),
(3, 'custy', '12345', '', '', '', '', 150000.00);

-- --------------------------------------------------------

--
-- Table structure for table `layanans`
--

CREATE TABLE `layanans` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `price` double NOT NULL,
  `durasi` int(11) NOT NULL,
  `deskripsi` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `layanans`
--

INSERT INTO `layanans` (`id`, `name`, `price`, `durasi`, `deskripsi`, `created_at`) VALUES
(1, 'Paket Cuci Rumah', 150000, 120, 'Layanan pembersihan menyeluruh untuk seluruh ruangan di rumah Anda.', '2024-12-27 10:28:27'),
(2, 'Paket Bersih Kamar Mandi', 50000, 60, 'Pembersihan mendalam untuk kamar mandi agar selalu higienis.', '2024-12-27 10:28:27');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `orderId` int(11) NOT NULL,
  `serviceId` int(11) NOT NULL,
  `customerId` int(11) NOT NULL,
  `fullName` varchar(100) NOT NULL,
  `phoneNumber` varchar(20) NOT NULL,
  `location` text NOT NULL,
  `notes` text DEFAULT NULL,
  `status` enum('pending','confirmed','cancel') DEFAULT 'pending',
  `saldoEWallet` double DEFAULT 0,
  `paymentMethod` varchar(50) NOT NULL,
  `duration` varchar(50) DEFAULT NULL,
  `servicePrice` double NOT NULL,
  `scheduleDate` date NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`orderId`, `serviceId`, `customerId`, `fullName`, `phoneNumber`, `location`, `notes`, `status`, `saldoEWallet`, `paymentMethod`, `duration`, `servicePrice`, `scheduleDate`, `createdAt`, `updatedAt`) VALUES
(1, 2, 3, 'Putri', '0123456789', 'Koriya', '', 'confirmed', 0, 'eWallet', '60', 50000, '2025-01-23', '2025-01-06 14:16:45', '2025-01-06 14:17:05'),
(2, 1, 3, 'Putrih', '0123456789', 'Koriya', '', 'pending', 0, 'eWallet', '120', 150000, '2025-02-20', '2025-01-06 14:17:01', '2025-01-06 14:17:01'),
(3, 1, 2, 'Tara', '087777654452', 'Amerisya Usyara', '', 'pending', 0, 'eWallet', '120', 150000, '2025-01-17', '2025-01-06 14:17:48', '2025-01-06 14:17:48');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `paymentId` int(11) NOT NULL,
  `orderId` int(11) NOT NULL,
  `customerId` int(11) NOT NULL,
  `paymentMethod` enum('credit_card','bank_transfer','e_wallet') NOT NULL,
  `priceLayanan` double NOT NULL,
  `saldoEWallet` double DEFAULT 0,
  `totalPembayaran` double NOT NULL,
  `paymentDate` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`paymentId`, `orderId`, `customerId`, `paymentMethod`, `priceLayanan`, `saldoEWallet`, `totalPembayaran`, `paymentDate`) VALUES
(1, 1, 3, 'credit_card', 50000, 200000, 0, '2025-01-06 14:17:05');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','customer') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`, `created_at`) VALUES
(1, 'admins', '123456', 'admin', '2024-12-27 10:22:48'),
(2, 'cust', '12345', 'customer', '2024-12-27 10:23:27'),
(3, 'custy', '12345', 'customer', '2025-01-06 14:14:27');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `layanans`
--
ALTER TABLE `layanans`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`orderId`),
  ADD KEY `serviceId` (`serviceId`),
  ADD KEY `customerId` (`customerId`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`paymentId`),
  ADD KEY `orderId` (`orderId`),
  ADD KEY `customerId` (`customerId`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `layanans`
--
ALTER TABLE `layanans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `orderId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `paymentId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admins`
--
ALTER TABLE `admins`
  ADD CONSTRAINT `admins_ibfk_1` FOREIGN KEY (`id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`serviceId`) REFERENCES `layanans` (`id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`customerId`) REFERENCES `customers` (`id`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `orders` (`orderId`),
  ADD CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`customerId`) REFERENCES `customers` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
