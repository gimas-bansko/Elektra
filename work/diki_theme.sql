-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Време на генериране:  5 фев 2025 в 14:36
-- Версия на сървъра: 10.4.32-MariaDB
-- Версия на PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данни: `elektra`
--

-- --------------------------------------------------------

--
-- Структура на таблица `main_theme`
--

DROP TABLE IF EXISTS `main_theme`;
CREATE TABLE `main_theme` (
  `id` bigint(20) NOT NULL,
  `num` smallint(5) UNSIGNED NOT NULL CHECK (`num` >= 0),
  `title` longtext NOT NULL,
  `remark` longtext NOT NULL,
  `tasks_total` smallint(5) UNSIGNED NOT NULL CHECK (`tasks_total` >= 0),
  `tasks_knowledge` smallint(5) UNSIGNED NOT NULL CHECK (`tasks_knowledge` >= 0),
  `tasks_comprehension` smallint(5) UNSIGNED NOT NULL CHECK (`tasks_comprehension` >= 0),
  `tasks_application` smallint(5) UNSIGNED NOT NULL CHECK (`tasks_application` >= 0),
  `tasks_analysis` smallint(5) UNSIGNED NOT NULL CHECK (`tasks_analysis` >= 0)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Схема на данните от таблица `main_theme`
--

INSERT INTO `main_theme` (`id`, `num`, `title`, `remark`, `tasks_total`, `tasks_knowledge`, `tasks_comprehension`, `tasks_application`, `tasks_analysis`) VALUES
(1, 1, 'Микропроцесор. Архитектура на микропроцесор', '', 24, 9, 8, 3, 4),
(2, 2, 'Многоядрени процесори на Intel', '', 28, 13, 10, 3, 2),
(3, 3, 'Многоядрени процесори на AMD', '', 28, 13, 10, 3, 2),
(4, 4, 'Дънна платка с процесор Intel Core i', '', 23, 7, 8, 5, 3),
(5, 5, 'Дънна платка с процесор на AMD', '', 23, 7, 8, 5, 3),
(6, 6, 'Статични и динамични памети в компютърните системи', '', 26, 10, 10, 4, 2),
(7, 7, 'Постоянни памети в компютърните системи', '', 27, 13, 7, 5, 2),
(8, 8, 'Мрежов хардуер', '', 26, 11, 9, 3, 3),
(9, 9, 'Видове топологии на компютърните мрежи и администриране', '', 27, 12, 9, 4, 2),
(10, 10, 'Мрежови модели', '', 26, 9, 12, 3, 2),
(11, 11, 'Мрежови протоколи', '', 26, 11, 8, 5, 2),
(12, 12, 'Магнитни и полупроводникови запомнящи устройства', '', 25, 8, 12, 2, 3),
(13, 13, 'Оптични запомнящи устройства', '', 26, 10, 10, 4, 2),
(14, 14, 'Сканиращи и печатащи устройства', '', 26, 9, 12, 3, 2),
(15, 15, 'Периферни устройства за видео и звук', '', 27, 11, 11, 3, 2),
(16, 16, 'Алгоритми и типове данни', '', 25, 9, 10, 3, 3),
(17, 17, 'Оператори за управление на изчислителния процес', '', 27, 11, 11, 3, 2),
(18, 18, 'Процеси, нишки, алгоритми за планиране и управление на паметта в \r\nоперационната система (ОС)', '', 24, 9, 7, 5, 3);

--
-- Indexes for dumped tables
--

--
-- Индекси за таблица `main_theme`
--
ALTER TABLE `main_theme`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `main_theme`
--
ALTER TABLE `main_theme`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
