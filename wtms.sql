-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 20, 2025 at 05:05 PM
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
-- Database: `wtms`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_submissions`
--

CREATE TABLE `tbl_submissions` (
  `submission_id` int(11) NOT NULL,
  `work_id` int(11) NOT NULL,
  `iD` int(11) NOT NULL,
  `submission_text` text NOT NULL,
  `submitted_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_submissions`
--

INSERT INTO `tbl_submissions` (`submission_id`, `work_id`, `iD`, `submission_text`, `submitted_at`) VALUES
(111, 6, 1, 'sudah', '2025-06-20 14:31:24'),
(112, 1, 1, 'done', '2025-06-20 14:52:59'),
(113, 6, 1, 'hy', '2025-06-20 14:54:07'),
(114, 6, 1, 'hy', '2025-06-20 14:56:09'),
(115, 1, 1, 'hello', '2025-06-20 15:03:47'),
(116, 2, 2, 'machine is good', '2025-06-20 17:43:54'),
(117, 2, 2, 'sudah check', '2025-06-20 17:52:59'),
(118, 2, 2, 'sudah siap', '2025-06-20 18:11:18'),
(119, 2, 2, 'nak apa', '2025-06-20 18:32:27'),
(120, 2, 2, 'hay', '2025-06-20 18:35:52'),
(121, 2, 2, 'siap', '2025-06-20 18:38:35'),
(122, 2, 2, 'sudah siap', '2025-06-20 18:42:21'),
(123, 2, 2, 'success', '2025-06-20 19:25:40'),
(124, 2, 2, 'finish', '2025-06-20 19:31:07'),
(125, 2, 2, 'assigned task', '2025-06-20 21:05:08'),
(126, 4, 4, 'finish', '2025-06-20 21:12:11');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_works`
--

CREATE TABLE `tbl_works` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `assigned_to` int(11) NOT NULL,
  `date_assigned` date NOT NULL,
  `due_date` date NOT NULL,
  `status` varchar(20) DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_works`
--

INSERT INTO `tbl_works` (`id`, `title`, `description`, `assigned_to`, `date_assigned`, `due_date`, `status`) VALUES
(1, 'Prepare Material A', 'Prepare raw material A for assembly.', 1, '2025-05-25', '2025-05-28', 'completed'),
(2, 'Inspect Machine X', 'Conduct inspection for machine X.', 2, '2025-05-25', '2025-05-29', 'completed'),
(3, 'Clean Area B', 'Deep clean work area B before audit.', 3, '2025-05-25', '2025-05-30', 'completed'),
(4, 'Test Circuit Board', 'Perform unit test for circuit batch 4.', 4, '2025-05-25', '2025-05-28', 'completed'),
(5, 'Document Process', 'Write SOP for packaging unit.', 5, '2025-05-25', '2025-05-29', 'pending'),
(6, 'Paint Booth Check', 'Routine check on painting booth.', 1, '2025-05-25', '2025-05-30', 'completed'),
(7, 'Label Inventory', 'Label all boxes in section C.', 2, '2025-05-25', '2025-05-28', 'pending'),
(8, 'Update Database', 'Update inventory in MySQL system.', 3, '2025-05-25', '2025-05-29', 'completed'),
(9, 'Maintain Equipment', 'Oil and tune cutting machine.', 4, '2025-05-25', '2025-05-30', 'pending'),
(10, 'Prepare Report', 'Prepare monthly performance report.', 5, '2025-05-25', '2025-05-30', 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `worker_table`
--

CREATE TABLE `worker_table` (
  `iD` int(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` int(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `profile_pic` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `worker_table`
--

INSERT INTO `worker_table` (`iD`, `name`, `email`, `phone`, `password`, `address`, `profile_pic`) VALUES
(1, 'killa', 'killa274@gmail.com', 182447616, '431bf3b995a99c2cd6899b97187d1542a965cec9', 'korea', ''),
(2, 'mia', 'mia222@gmail.com', 112223333, '1c6637a8f2e1f75e06ff9984894d6bd16a3a36a9', 'penang', ''),
(3, 'nana', 'nana123@gmail.com', 113334455, '40bd001563085fc35165329ea1ff5c5ecbdbbeef', 'Langkawi', ''),
(4, 'maisyarah', 'mai444@gmail.com', 144545544, '9a3e61b6bcc8abec08f195526c3132d5a4a98cc0', 'Perak', ''),
(5, 'Faris', 'faris555@gmail.com', 155555555, 'cfa1150f1787186742a9a884b73a43d8cf219f9b', 'Kelantan', ''),
(6, 'Ammar', 'ammar111@gmail.com', 112221212, '6216f8a75fd5bb3d5f22b6f9958cdede3fc086c2', 'Johor', ''),
(7, 'surti', 'surti999@gmail.com', 2945678, 'afc97ea131fd7e2695a98ef34013608f97f34e1d', 'tanjung rambutan', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_submissions`
--
ALTER TABLE `tbl_submissions`
  ADD PRIMARY KEY (`submission_id`);

--
-- Indexes for table `tbl_works`
--
ALTER TABLE `tbl_works`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `worker_table`
--
ALTER TABLE `worker_table`
  ADD PRIMARY KEY (`iD`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_submissions`
--
ALTER TABLE `tbl_submissions`
  MODIFY `submission_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=127;

--
-- AUTO_INCREMENT for table `tbl_works`
--
ALTER TABLE `tbl_works`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `worker_table`
--
ALTER TABLE `worker_table`
  MODIFY `iD` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
