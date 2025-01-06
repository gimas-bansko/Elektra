-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Време на генериране:  6 яну 2025 в 22:31
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
-- Структура на таблица `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add Документ', 7, 'add_documents'),
(26, 'Can change Документ', 7, 'change_documents'),
(27, 'Can delete Документ', 7, 'delete_documents'),
(28, 'Can view Документ', 7, 'view_documents'),
(29, 'Can add Действие', 8, 'add_log'),
(30, 'Can change Действие', 8, 'change_log'),
(31, 'Can delete Действие', 8, 'delete_log'),
(32, 'Can view Действие', 8, 'view_log'),
(33, 'Can add Училище/организация', 9, 'add_school'),
(34, 'Can change Училище/организация', 9, 'change_school'),
(35, 'Can delete Училище/организация', 9, 'delete_school'),
(36, 'Can view Училище/организация', 9, 'view_school'),
(37, 'Can add Специалност', 10, 'add_specialty'),
(38, 'Can change Специалност', 10, 'change_specialty'),
(39, 'Can delete Специалност', 10, 'delete_specialty'),
(40, 'Can view Специалност', 10, 'view_specialty'),
(41, 'Can add Въпрос', 11, 'add_task'),
(42, 'Can change Въпрос', 11, 'change_task'),
(43, 'Can delete Въпрос', 11, 'delete_task'),
(44, 'Can view Въпрос', 11, 'view_task'),
(45, 'Can add Тема', 12, 'add_theme'),
(46, 'Can change Тема', 12, 'change_theme'),
(47, 'Can delete Тема', 12, 'delete_theme'),
(48, 'Can view Тема', 12, 'view_theme'),
(49, 'Can add Пофил на потребител', 13, 'add_userprofile'),
(50, 'Can change Пофил на потребител', 13, 'change_userprofile'),
(51, 'Can delete Пофил на потребител', 13, 'delete_userprofile'),
(52, 'Can view Пофил на потребител', 13, 'view_userprofile'),
(53, 'Can add Тема - точка', 14, 'add_themeitem'),
(54, 'Can change Тема - точка', 14, 'change_themeitem'),
(55, 'Can delete Тема - точка', 14, 'delete_themeitem'),
(56, 'Can view Тема - точка', 14, 'view_themeitem'),
(57, 'Can add Въпрос - опция', 15, 'add_taskitem'),
(58, 'Can change Въпрос - опция', 15, 'change_taskitem'),
(59, 'Can delete Въпрос - опция', 15, 'delete_taskitem'),
(60, 'Can view Въпрос - опция', 15, 'view_taskitem');

-- --------------------------------------------------------

--
-- Структура на таблица `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$600000$bAENMC2y6CBzHiVvZTa7sj$MP961DiZWk5LKNig+de4AKqeNf9wD+aKmJxqhxmyeGU=', '2025-01-06 19:09:29.263939', 1, 'superadmin', 'Георги', 'Бориков', 'ggborikov@abv.bg', 1, 1, '2024-12-29 17:32:38.000000'),
(2, 'pbkdf2_sha256$600000$RWfc0Po5N9BUkizdDNHsIE$67D49ArZ/dLSqU4KFPLJWBiuSslah0gCNFCagSxXVdg=', NULL, 0, 'guestadmin', 'Гост', 'Админ', 'ga@ad.com', 0, 1, '2024-12-29 21:35:09.000000'),
(3, 'pbkdf2_sha256$600000$PEevvgdmijM2ilQntfJs4g$ullQlEiWASWqqMTtkX7eq6rErh6GnKns/W3cRTV6YIY=', '2024-12-31 17:52:19.656400', 0, 'schooladmin1', 'Училищен', 'Админ', '', 0, 1, '2024-12-29 21:38:59.000000'),
(4, 'pbkdf2_sha256$600000$Na4YoANjNOepAC37fCZz2I$c2jwxDw8oBet84B/aoFbvd91i5HKDLxniPSuJD2hkDk=', NULL, 0, 'teacher1', 'Учител', '1', '', 0, 1, '2024-12-29 21:40:28.000000'),
(5, 'pbkdf2_sha256$600000$q8x1XojW1qkF40PJsicOQz$vmotFZ0od9zKMNmA9wibUBz0crHJXz12noZb9D4qscg=', '2024-12-30 15:34:38.037155', 0, 'teacher2', 'Учител', '2', '', 0, 1, '2024-12-29 21:40:55.000000'),
(6, 'pbkdf2_sha256$600000$1bY0hDrKYA0R7qUdBAYwPR$/wrXG/7djhixTHJ8dt6Itqc2ES5NFRVfOmIWK8SUaWw=', NULL, 0, 'student1', 'Ученник', '1', '', 0, 1, '2024-12-29 21:41:11.000000'),
(7, 'pbkdf2_sha256$600000$JeGmRVAFHowS0VnPnurjtR$s9r+PkOfMVeOk0phB4xwgIvvbqVpBZu4zefd9guzwh0=', NULL, 0, 'student2', 'Ученик', '2', '', 0, 1, '2024-12-29 21:41:28.000000'),
(8, 'pbkdf2_sha256$600000$UVMIfVg53LiGDkJJhGHyj2$MfEf4n0TTcxyXVEzdfSIl/4Kh6wG0gW12qG/Kd+Fwx0=', NULL, 0, 'schooladmin2', 'Училищен', 'Админ2', '', 0, 1, '2024-12-29 21:43:33.000000');

-- --------------------------------------------------------

--
-- Структура на таблица `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2024-12-29 21:09:36.347150', '1', 'superadmin', 2, '[{\"changed\": {\"fields\": [\"First name\", \"Last name\", \"Email address\"]}}]', 4, 1),
(2, '2024-12-29 21:28:23.910932', '1', 'Потребител #1: Георги Бориков', 2, '[{\"changed\": {\"fields\": [\"\\u0420\\u043e\\u043b\\u044f\"]}}]', 13, 1),
(3, '2024-12-29 21:28:33.656121', '1', 'Потребител #1: Георги Бориков', 2, '[]', 13, 1),
(4, '2024-12-29 21:35:09.486784', '2', 'guestadmin', 1, '[{\"added\": {}}]', 4, 1),
(5, '2024-12-29 21:38:18.035693', '2', 'guestadmin', 2, '[{\"changed\": {\"fields\": [\"First name\", \"Last name\", \"Email address\"]}}]', 4, 1),
(6, '2024-12-29 21:39:00.173324', '3', 'schooladmin', 1, '[{\"added\": {}}]', 4, 1),
(7, '2024-12-29 21:40:28.986736', '4', 'teacher1', 1, '[{\"added\": {}}]', 4, 1),
(8, '2024-12-29 21:40:55.378738', '5', 'teacher2', 1, '[{\"added\": {}}]', 4, 1),
(9, '2024-12-29 21:41:11.479666', '6', 'student1', 1, '[{\"added\": {}}]', 4, 1),
(10, '2024-12-29 21:41:28.487982', '7', 'student2', 1, '[{\"added\": {}}]', 4, 1),
(11, '2024-12-29 21:42:04.140175', '7', 'student2', 2, '[{\"changed\": {\"fields\": [\"First name\", \"Last name\"]}}]', 4, 1),
(12, '2024-12-29 21:43:06.094932', '3', 'schooladmin1', 2, '[{\"changed\": {\"fields\": [\"Username\", \"First name\", \"Last name\"]}}]', 4, 1),
(13, '2024-12-29 21:43:33.620263', '8', 'schooladmin2', 1, '[{\"added\": {}}]', 4, 1),
(14, '2024-12-29 21:43:55.770110', '8', 'schooladmin2', 2, '[{\"changed\": {\"fields\": [\"First name\", \"Last name\"]}}]', 4, 1),
(15, '2024-12-29 21:44:23.194661', '6', 'student1', 2, '[{\"changed\": {\"fields\": [\"First name\", \"Last name\"]}}]', 4, 1),
(16, '2024-12-29 21:44:48.961425', '4', 'teacher1', 2, '[{\"changed\": {\"fields\": [\"First name\", \"Last name\"]}}]', 4, 1),
(17, '2024-12-29 21:45:07.588953', '5', 'teacher2', 2, '[{\"changed\": {\"fields\": [\"First name\", \"Last name\"]}}]', 4, 1),
(18, '2024-12-29 21:49:45.954542', '1', 'ПГЕЕ гр. Банско', 1, '[{\"added\": {}}]', 9, 1),
(19, '2024-12-29 21:49:50.875952', '1', 'ПГЕЕ гр. Банско', 2, '[]', 9, 1),
(20, '2024-12-29 21:59:49.457792', '1', '5230501: Компютърна техника и технологии', 1, '[{\"added\": {}}]', 10, 1),
(21, '2024-12-29 22:07:43.540542', '1', '5230501: Компютърна техника и технологии', 2, '[{\"changed\": {\"fields\": [\"\\u041d\\u0418\\u041f\"]}}]', 10, 1),
(22, '2024-12-29 22:20:16.364299', '2', '4810201: Системно програмиране', 1, '[{\"added\": {}}]', 10, 1),
(23, '2024-12-29 22:21:03.334446', '1', 'НИП КТТ', 1, '[{\"added\": {}}]', 7, 1),
(24, '2024-12-29 22:21:24.988625', '2', 'НИП СП', 1, '[{\"added\": {}}]', 7, 1),
(25, '2024-12-29 22:21:48.929347', '3', 'Наредба №1', 1, '[{\"added\": {}}]', 7, 1),
(26, '2024-12-29 22:26:12.300797', '2', 'ПГП гр. Някъде', 1, '[{\"added\": {}}]', 9, 1),
(27, '2024-12-29 22:26:38.283387', '1', 'ПГЕЕ гр. Банско', 2, '[{\"changed\": {\"fields\": [\"\\u0421\\u043f\\u0435\\u0446\\u0438\\u0430\\u043b\\u043d\\u043e\\u0441\\u0442\\u0438\"]}}]', 9, 1),
(28, '2024-12-29 22:26:57.973369', '1', 'ПГЕЕ гр. Банско', 2, '[]', 9, 1),
(29, '2024-12-29 22:27:04.041944', '2', 'ПГП гр. Някъде', 2, '[]', 9, 1),
(30, '2024-12-29 22:28:01.363091', '2', 'Потребител #2: Гост Админ', 2, '[{\"changed\": {\"fields\": [\"\\u0420\\u043e\\u043b\\u044f\"]}}]', 13, 1),
(31, '2024-12-29 22:28:26.087382', '3', 'Потребител #3: Училищен Админ', 2, '[{\"changed\": {\"fields\": [\"\\u0420\\u043e\\u043b\\u044f\"]}}]', 13, 1),
(32, '2024-12-29 22:28:46.650117', '2', 'Потребител #2: Гост Админ', 2, '[]', 13, 1),
(33, '2024-12-29 22:28:58.460575', '3', 'Потребител #3: Училищен Админ', 2, '[{\"changed\": {\"fields\": [\"\\u0423\\u0447\\u0438\\u043b\\u0438\\u0449\\u0435\"]}}]', 13, 1),
(34, '2024-12-29 22:29:10.500511', '8', 'Потребител #8: Училищен Админ2', 2, '[{\"changed\": {\"fields\": [\"\\u0423\\u0447\\u0438\\u043b\\u0438\\u0449\\u0435\", \"\\u0420\\u043e\\u043b\\u044f\"]}}]', 13, 1),
(35, '2024-12-29 22:29:26.776729', '4', 'Потребител #4: Учител 1', 2, '[{\"changed\": {\"fields\": [\"\\u0423\\u0447\\u0438\\u043b\\u0438\\u0449\\u0435\", \"\\u0420\\u043e\\u043b\\u044f\"]}}]', 13, 1),
(36, '2024-12-29 22:29:42.090423', '5', 'Потребител #5: Учител 2', 2, '[{\"changed\": {\"fields\": [\"\\u0423\\u0447\\u0438\\u043b\\u0438\\u0449\\u0435\", \"\\u0420\\u043e\\u043b\\u044f\"]}}]', 13, 1),
(37, '2024-12-29 22:30:03.534036', '6', 'Потребител #6: Ученник 1', 2, '[{\"changed\": {\"fields\": [\"\\u0423\\u0447\\u0438\\u043b\\u0438\\u0449\\u0435\", \"\\u0421\\u043f\\u0435\\u0446\\u0438\\u0430\\u043b\\u043d\\u043e\\u0441\\u0442\"]}}]', 13, 1),
(38, '2024-12-29 22:30:12.589720', '7', 'Потребител #7: Ученик 2', 2, '[{\"changed\": {\"fields\": [\"\\u0423\\u0447\\u0438\\u043b\\u0438\\u0449\\u0435\", \"\\u0421\\u043f\\u0435\\u0446\\u0438\\u0430\\u043b\\u043d\\u043e\\u0441\\u0442\"]}}]', 13, 1),
(39, '2024-12-29 22:34:59.852600', '1', 'Тема 1. Микропроцесор. Архитектура на микропроцесор', 1, '[{\"added\": {}}]', 12, 1),
(40, '2024-12-29 22:35:20.740224', '1', 'Тема 1. Микропроцесор. Архитектура на микропроцесор', 2, '[{\"changed\": {\"fields\": [\"\\u0417\\u043d\\u0430\\u043d\\u0438\\u0435\", \"\\u0420\\u0430\\u0437\\u0431\\u0438\\u0440\\u0430\\u043d\\u0435\", \"\\u041f\\u0440\\u0438\\u043b\\u043e\\u0436\\u0435\\u043d\\u0438\\u0435\", \"\\u0410\\u043d\\u0430\\u043b\\u0438\\u0437\"]}}]', 12, 1),
(41, '2024-12-29 22:35:34.129815', '1', 'Тема 1. Микропроцесор. Архитектура на микропроцесор', 2, '[{\"changed\": {\"fields\": [\"\\u041f\\u0440\\u0438\\u043b\\u043e\\u0436\\u0435\\u043d\\u0438\\u0435\", \"\\u0410\\u043d\\u0430\\u043b\\u0438\\u0437\"]}}]', 12, 1),
(42, '2024-12-29 22:41:05.684359', '1', '1. Дефинира пRISC и CISC микропроцесори. Развитие на микропроцесорите.онятието микропроцесор. Проследява развитието на микропроцесорите.', 1, '[{\"added\": {}}]', 14, 1),
(43, '2024-12-29 22:42:00.206551', '2', '2. Основни функционални блокове на CISC микропроцесор', 1, '[{\"added\": {}}]', 14, 1),
(44, '2024-12-29 22:43:39.141734', '3', '3. Технически параметри на микропроцесорите', 1, '[{\"added\": {}}]', 14, 1),
(45, '2024-12-29 22:44:37.605345', '4', '1. Режими на работа на микропроцесорите', 1, '[{\"added\": {}}]', 14, 1),
(46, '2024-12-29 22:45:54.870147', '5', '5. Тенденции в развитието на микропроцесорите, съвместимост', 1, '[{\"added\": {}}]', 14, 1),
(47, '2024-12-29 22:46:28.317847', '4', '4. Режими на работа на микропроцесорите', 2, '[{\"changed\": {\"fields\": [\"\\u0422\\u043e\\u0447\\u043a\\u0430 \\u2116\"]}}]', 14, 1),
(48, '2025-01-04 20:05:16.311727', '1', 'Потребител #1: Георги Бориков', 2, '[]', 13, 1),
(49, '2025-01-04 20:05:55.224243', '6', 'Потребител #6: Ученник 1', 2, '[{\"changed\": {\"fields\": [\"\\u041f\\u043e\\u043b\"]}}]', 13, 1),
(50, '2025-01-04 20:06:02.086453', '3', 'Потребител #3: Училищен Админ', 2, '[]', 13, 1),
(51, '2025-01-04 20:13:59.111544', '1', 'ПГЕЕ гр. Банско', 2, '[{\"changed\": {\"fields\": [\"\\u041b\\u043e\\u0433\\u043e\"]}}]', 9, 1),
(52, '2025-01-04 20:14:51.621826', '2', 'ПГП гр. Някъде', 2, '[{\"changed\": {\"fields\": [\"\\u041b\\u043e\\u0433\\u043e\"]}}]', 9, 1),
(53, '2025-01-04 20:24:29.449307', '2', 'Потребител #2: Гост Админ', 2, '[{\"changed\": {\"fields\": [\"\\u0423\\u0447\\u0438\\u043b\\u0438\\u0449\\u0435\"]}}]', 13, 1),
(54, '2025-01-04 20:27:25.448123', '1', 'Потребител #1: Георги Бориков', 2, '[{\"changed\": {\"fields\": [\"\\u0423\\u0447\\u0438\\u043b\\u0438\\u0449\\u0435\"]}}]', 13, 1),
(55, '2025-01-04 20:31:47.486143', '1', 'Потребител #1: Георги Бориков', 2, '[{\"changed\": {\"fields\": [\"\\u0423\\u0447\\u0438\\u043b\\u0438\\u0449\\u0435\"]}}]', 13, 1),
(56, '2025-01-04 20:35:26.079610', '3', 'Потребител #3: Училищен Админ', 2, '[{\"changed\": {\"fields\": [\"\\u0421\\u043f\\u0435\\u0446\\u0438\\u0430\\u043b\\u043d\\u043e\\u0441\\u0442\"]}}]', 13, 1),
(57, '2025-01-04 20:50:53.523506', '1', 'Потребител #1: Георги Бориков', 2, '[{\"changed\": {\"fields\": [\"\\u0421\\u043f\\u0435\\u0446\\u0438\\u0430\\u043b\\u043d\\u043e\\u0441\\u0442\"]}}]', 13, 1),
(58, '2025-01-05 17:55:25.833453', '1', '1. Дефинира понятието микропроцесор. Проследява развитието на микропроцесорите.', 2, '[{\"changed\": {\"fields\": [\"\\u0417\\u0430\\u0433\\u043b\\u0430\\u0432\\u0438\\u0435\"]}}]', 14, 1),
(59, '2025-01-05 18:01:23.329862', '1', '1. RISC и CISC микропроцесори. Развитие на микропроцесорите', 2, '[{\"changed\": {\"fields\": [\"\\u0417\\u0430\\u0433\\u043b\\u0430\\u0432\\u0438\\u0435\", \"\\u0417\\u0430\\u0433\\u043b\\u0430\\u0432\\u0438\\u0435\"]}}]', 14, 1),
(60, '2025-01-05 18:02:42.105769', '2', '2. Основни функционални блокове на CISC микропроцесор', 2, '[{\"changed\": {\"fields\": [\"\\u0417\\u0430\\u0433\\u043b\\u0430\\u0432\\u0438\\u0435\"]}}]', 14, 1);

-- --------------------------------------------------------

--
-- Структура на таблица `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(7, 'main', 'documents'),
(8, 'main', 'log'),
(9, 'main', 'school'),
(10, 'main', 'specialty'),
(11, 'main', 'task'),
(15, 'main', 'taskitem'),
(12, 'main', 'theme'),
(14, 'main', 'themeitem'),
(13, 'main', 'userprofile'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Структура на таблица `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2024-12-29 17:31:51.510410'),
(2, 'auth', '0001_initial', '2024-12-29 17:31:51.887365'),
(3, 'admin', '0001_initial', '2024-12-29 17:31:51.983611'),
(4, 'admin', '0002_logentry_remove_auto_add', '2024-12-29 17:31:51.990608'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2024-12-29 17:31:52.003608'),
(6, 'contenttypes', '0002_remove_content_type_name', '2024-12-29 17:31:52.054150'),
(7, 'auth', '0002_alter_permission_name_max_length', '2024-12-29 17:31:52.102819'),
(8, 'auth', '0003_alter_user_email_max_length', '2024-12-29 17:31:52.113822'),
(9, 'auth', '0004_alter_user_username_opts', '2024-12-29 17:31:52.119819'),
(10, 'auth', '0005_alter_user_last_login_null', '2024-12-29 17:31:52.152329'),
(11, 'auth', '0006_require_contenttypes_0002', '2024-12-29 17:31:52.155332'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2024-12-29 17:31:52.162331'),
(13, 'auth', '0008_alter_user_username_max_length', '2024-12-29 17:31:52.172850'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2024-12-29 17:31:52.183160'),
(15, 'auth', '0010_alter_group_name_max_length', '2024-12-29 17:31:52.193673'),
(16, 'auth', '0011_update_proxy_permissions', '2024-12-29 17:31:52.201670'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2024-12-29 17:31:52.211671'),
(18, 'main', '0001_initial', '2024-12-29 17:31:52.832414'),
(19, 'sessions', '0001_initial', '2024-12-29 17:31:52.857415'),
(20, 'main', '0002_remove_userprofile_school_id_and_more', '2024-12-29 21:15:37.517969'),
(21, 'main', '0003_school_logo_userprofile_gender_and_more', '2025-01-04 20:03:23.676098'),
(22, 'main', '0004_alter_school_logo', '2025-01-04 20:13:35.286383');

-- --------------------------------------------------------

--
-- Структура на таблица `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('21sh22a77rh34si6t8gfns7voclo9zfa', '.eJxVjMsOwiAQRf-FtSHyKDAu3fsNZIYBqRqalHZl_HfbpAvd3nPueYuI61Lj2vMcRxYXocTpdyNMz9x2wA9s90mmqS3zSHJX5EG7vE2cX9fD_QtU7HV721J0Dlb7AJp8Mk6zy0MIbNUWAeW8VcpQAQMEJivGUsLAZ0BKupATny_YWzgY:1tUsTh:J9tI6D6pjdp8u44mGiM6HBsgZ3VnpOXPRn7uKzlJQ6c', '2025-01-20 19:09:29.274534'),
('30emskj9uh6r4ei6hvktjk5vy3fdbovc', '.eJxVjMsOwiAQRf-FtSHyKDAu3fsNZIYBqRqalHZl_HfbpAvd3nPueYuI61Lj2vMcRxYXocTpdyNMz9x2wA9s90mmqS3zSHJX5EG7vE2cX9fD_QtU7HV721J0Dlb7AJp8Mk6zy0MIbNUWAeW8VcpQAQMEJivGUsLAZ0BKupATny_YWzgY:1tUFbV:uouOqJmsaDReuSupFStz-keCGmqOcFqkShdsfDt-hNk', '2025-01-19 01:38:57.340694'),
('3ru5pv463wmorx95l7ebw670mclzfkq8', '.eJxVjMsOwiAQRf-FtSHyKDAu3fsNZIYBqRqalHZl_HfbpAvd3nPueYuI61Lj2vMcRxYXocTpdyNMz9x2wA9s90mmqS3zSHJX5EG7vE2cX9fD_QtU7HV721J0Dlb7AJp8Mk6zy0MIbNUWAeW8VcpQAQMEJivGUsLAZ0BKupATny_YWzgY:1tUAOG:BmSidPGyYyAxTKPgzqUcOjIEefKwR4otkuFC2S8jNw0', '2025-01-18 20:04:56.430846'),
('8mstj9f58xi14czbvnd70qat11v2cskj', 'e30:1tUBse:pdrhJabkhjQIc1vl2dTVa_-W0OgcmJIBZ0gB55qA0Gc', '2025-01-18 21:40:24.685498'),
('df9u2zir7nyvk0cyr7e8s99a7vpt30it', '.eJxVjMsOwiAQRf-FtSHyKDAu3fsNZIYBqRqalHZl_HfbpAvd3nPueYuI61Lj2vMcRxYXocTpdyNMz9x2wA9s90mmqS3zSHJX5EG7vE2cX9fD_QtU7HV721J0Dlb7AJp8Mk6zy0MIbNUWAeW8VcpQAQMEJivGUsLAZ0BKupATny_YWzgY:1tUC4B:DUggkm-H9BZPSbjBaa4Bpduh9K-TqYsgCjDCGfdMjMo', '2025-01-18 21:52:19.757616'),
('dr803shmi80ajfgx539dzaa7vijt79ve', '.eJxVjMsOwiAQRf-FtSHyKDAu3fsNZIYBqRqalHZl_HfbpAvd3nPueYuI61Lj2vMcRxYXocTpdyNMz9x2wA9s90mmqS3zSHJX5EG7vE2cX9fD_QtU7HV721J0Dlb7AJp8Mk6zy0MIbNUWAeW8VcpQAQMEJivGUsLAZ0BKupATny_YWzgY:1tUEuq:QANcjOaSqg-LmLU7z8XGZzGxd0S86Mph9139IrpsrVE', '2025-01-19 00:54:52.877419'),
('h1hz9wjgo5jq324vq0vfvtoqtsg9hv0h', '.eJxVjMsOwiAQRf-FtSHyKDAu3fsNZIYBqRqalHZl_HfbpAvd3nPueYuI61Lj2vMcRxYXocTpdyNMz9x2wA9s90mmqS3zSHJX5EG7vE2cX9fD_QtU7HV721J0Dlb7AJp8Mk6zy0MIbNUWAeW8VcpQAQMEJivGUsLAZ0BKupATny_YWzgY:1tUAhd:r9RVWvaGYoj0XAjUqRQgxxvDb8bGxBtyQFM38aeRp8A', '2025-01-18 20:24:57.285524'),
('iqppbszl75bm1jzfqtdmmpyym5nvockj', '.eJxVjMsOwiAQRf-FtSHyKDAu3fsNZIYBqRqalHZl_HfbpAvd3nPueYuI61Lj2vMcRxYXocTpdyNMz9x2wA9s90mmqS3zSHJX5EG7vE2cX9fD_QtU7HV721J0Dlb7AJp8Mk6zy0MIbNUWAeW8VcpQAQMEJivGUsLAZ0BKupATny_YWzgY:1tTWVn:JaFKZPGmjnc_EGlQpIojCrSBbRrL1Fp1KAiq5ewddms', '2025-01-17 01:30:03.184676'),
('l4rsxt8r9edreck8mjbiocw72kxiyith', '.eJxVjMsOwiAQRf-FtSHyKDAu3fsNZIYBqRqalHZl_HfbpAvd3nPueYuI61Lj2vMcRxYXocTpdyNMz9x2wA9s90mmqS3zSHJX5EG7vE2cX9fD_QtU7HV721J0Dlb7AJp8Mk6zy0MIbNUWAeW8VcpQAQMEJivGUsLAZ0BKupATny_YWzgY:1tS1s1:7tT4KQbm4McDON9jJOzBXcYygyH3r1R34iQgekenYbc', '2025-01-12 22:34:49.613757'),
('mc01p662lmy6j84pzz6sx7bxrnbm8ho7', '.eJxVjMsOwiAQRf-FtSHyKDAu3fsNZIYBqRqalHZl_HfbpAvd3nPueYuI61Lj2vMcRxYXocTpdyNMz9x2wA9s90mmqS3zSHJX5EG7vE2cX9fD_QtU7HV721J0Dlb7AJp8Mk6zy0MIbNUWAeW8VcpQAQMEJivGUsLAZ0BKupATny_YWzgY:1tSzeg:pVsPc5IbeDT1fzuqP5BgkxuZXMrJCWhXwJ7WHEJKrFc', '2025-01-15 14:25:02.052397'),
('pul6ra6t7qsyfia6bc9bup9kvwt15rqa', 'e30:1tUBqa:uC2hg0NIhfndIzVVqi5YI3hRB5U7e__xQABuE5gAt-8', '2025-01-18 21:38:16.378424'),
('pzwm5erx2frykg6kmwkc6cykpemcfs83', '.eJxVjMsOwiAQRf-FtSHyKDAu3fsNZIYBqRqalHZl_HfbpAvd3nPueYuI61Lj2vMcRxYXocTpdyNMz9x2wA9s90mmqS3zSHJX5EG7vE2cX9fD_QtU7HV721J0Dlb7AJp8Mk6zy0MIbNUWAeW8VcpQAQMEJivGUsLAZ0BKupATny_YWzgY:1tRzD1:POrK6kLmN90kQWTtHnWoosZjhZcqnQIETPObHPZXigk', '2025-01-12 19:44:19.901785'),
('tz54oipwy1dbmmsciysur2b65ehlfbxa', '.eJxVjMsOwiAQRf-FtSHyKDAu3fsNZIYBqRqalHZl_HfbpAvd3nPueYuI61Lj2vMcRxYXocTpdyNMz9x2wA9s90mmqS3zSHJX5EG7vE2cX9fD_QtU7HV721J0Dlb7AJp8Mk6zy0MIbNUWAeW8VcpQAQMEJivGUsLAZ0BKupATny_YWzgY:1tS1ti:VfzIDthWanLwGbe_dFxTXsZfKmg5OMPx9Zk9HDqhe7A', '2025-01-12 22:36:34.874467'),
('zuy5o3kagr3p5v5o2a2e1617463tlfrz', '.eJxVjDsOwjAQBe_iGlkbO_4sJX3OYK1_OIBsKU4qxN2RpRTQvpl5b-bo2Is7etrcGtmVSXb53TyFZ6oDxAfVe-Oh1X1bPR8KP2nnS4vpdTvdv4NCvYxaKfRI3lhAMcecSSjUkgTAhDBFSEnLDNLOWlDSmZQFY9AggPKoAvt8Ac1VNu0:1tSgPj:GThGiHTGGvglDa2lw_h8Lo521dDVUIuTTM9UVzAF52U', '2025-01-14 17:52:19.666660');

-- --------------------------------------------------------

--
-- Структура на таблица `main_documents`
--

CREATE TABLE `main_documents` (
  `id` bigint(20) NOT NULL,
  `title` varchar(200) NOT NULL,
  `attachment` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `main_documents`
--

INSERT INTO `main_documents` (`id`, `title`, `attachment`) VALUES
(1, 'НИП КТТ', 'docs/nip_5230501_wzxmivn.pdf'),
(2, 'НИП СП', 'docs/nip_4810201_cVhcOsC.pdf'),
(3, 'Наредба №1', 'docs/nrdb1-2020-prof-izpiti_031221.pdf');

-- --------------------------------------------------------

--
-- Структура на таблица `main_log`
--

CREATE TABLE `main_log` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_name` varchar(50) DEFAULT NULL,
  `action` varchar(200) NOT NULL,
  `date` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `main_log`
--

INSERT INTO `main_log` (`id`, `user_id`, `user_name`, `action`, `date`) VALUES
(1, 1, ' ', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2024-12-29 17:33:30.665833'),
(2, 1, ' ', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2024-12-29 18:27:38.681625'),
(3, 1, ' ', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2024-12-29 19:08:32.972003'),
(4, 1, ' ', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2024-12-29 19:44:19.894282'),
(5, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2024-12-29 22:52:05.236036'),
(6, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2024-12-29 23:02:50.715711'),
(7, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2024-12-29 23:11:18.610759'),
(8, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2024-12-29 23:26:42.746228'),
(9, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2024-12-29 23:32:45.655836'),
(10, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2024-12-29 23:33:35.135310'),
(11, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2024-12-30 00:13:28.610553'),
(12, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2024-12-30 00:39:58.844953'),
(13, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2024-12-30 15:26:10.855676'),
(14, 5, 'Учител 2', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2024-12-30 15:34:38.042161'),
(15, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2024-12-30 15:38:37.968664'),
(16, 3, 'Училищен Админ', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2024-12-30 22:35:03.205529'),
(17, 3, 'Училищен Админ', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2024-12-30 22:36:52.016029'),
(18, 3, 'Училищен Админ', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2024-12-31 17:52:19.661657'),
(19, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-01 13:47:56.481767'),
(20, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-01 14:18:28.150119'),
(21, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-01 14:25:02.045397'),
(22, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-01 16:07:10.705088'),
(23, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-01 20:16:00.048597'),
(24, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-02 00:06:54.039159'),
(25, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-02 00:06:55.025960'),
(26, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-02 22:28:48.392225'),
(27, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-02 22:31:34.629940'),
(28, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-03 00:36:41.196043'),
(29, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-03 00:40:10.325806'),
(30, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-03 00:43:05.809580'),
(31, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-03 01:30:03.180674'),
(32, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-03 10:42:08.604567'),
(33, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-03 15:17:02.068735'),
(34, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-03 15:30:42.377557'),
(35, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-03 18:41:55.187402'),
(36, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-04 19:33:43.142281'),
(37, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-04 19:35:59.496697'),
(38, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-04 19:37:12.552027'),
(39, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-04 20:24:57.281519'),
(40, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-04 21:38:16.386368'),
(41, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-04 21:40:24.822721'),
(42, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-04 21:48:07.548822'),
(43, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-04 21:49:34.123116'),
(44, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-04 21:52:19.750588'),
(45, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-05 00:54:52.873133'),
(46, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-05 01:38:57.336150'),
(47, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-05 17:10:39.330227'),
(48, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-06 19:09:29.269385');

-- --------------------------------------------------------

--
-- Структура на таблица `main_school`
--

CREATE TABLE `main_school` (
  `id` bigint(20) NOT NULL,
  `short_name` varchar(20) NOT NULL,
  `full_name` longtext NOT NULL,
  `city` varchar(50) NOT NULL,
  `address` varchar(50) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `email` varchar(35) NOT NULL,
  `boss` varchar(50) NOT NULL,
  `logo` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `main_school`
--

INSERT INTO `main_school` (`id`, `short_name`, `full_name`, `city`, `address`, `phone_number`, `email`, `boss`, `logo`) VALUES
(1, 'ПГЕЕ', 'ПРОФЕСИОНАЛНА ГИМНАЗИЯ ПО ЕЛЕКТРОНИКА И ЕНЕРГЕТИКА', 'гр. Банско', '', '', '', '', 'sys_pics/Logo_large.png'),
(2, 'ПГП', 'ПРОФЕСИОНАЛНА ГИМНАЗИЯ ПО ПРОГРАМИРАНЕ', 'гр. Някъде', '', '', '', '', 'sys_pics/voice_line.png');

-- --------------------------------------------------------

--
-- Структура на таблица `main_school_specialities`
--

CREATE TABLE `main_school_specialities` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) NOT NULL,
  `specialty_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `main_school_specialities`
--

INSERT INTO `main_school_specialities` (`id`, `school_id`, `specialty_id`) VALUES
(2, 1, 1),
(3, 1, 2),
(1, 2, 2);

-- --------------------------------------------------------

--
-- Структура на таблица `main_specialty`
--

CREATE TABLE `main_specialty` (
  `id` bigint(20) NOT NULL,
  `professional_field_num` varchar(3) NOT NULL,
  `professional_field_name` varchar(100) NOT NULL,
  `profession_num` varchar(6) NOT NULL,
  `profession_name` varchar(100) NOT NULL,
  `specialty_num` varchar(8) NOT NULL,
  `specialty_name` varchar(100) NOT NULL,
  `nip` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `main_specialty`
--

INSERT INTO `main_specialty` (`id`, `professional_field_num`, `professional_field_name`, `profession_num`, `profession_name`, `specialty_num`, `specialty_name`, `nip`) VALUES
(1, '523', 'Електроника, автоматика, комуникационна и компютърна техника', '523050', 'Техник на компютърни системи', '5230501', 'Компютърна техника и технологии', 'docs/nip_5230501.pdf'),
(2, '481', 'Компютърни науки', '481020', 'Системен програмист', '4810201', 'Системно програмиране', 'docs/nip_4810201.pdf');

-- --------------------------------------------------------

--
-- Структура на таблица `main_task`
--

CREATE TABLE `main_task` (
  `id` bigint(20) NOT NULL,
  `num` smallint(5) UNSIGNED NOT NULL CHECK (`num` >= 0),
  `text` longtext NOT NULL,
  `type` smallint(5) UNSIGNED NOT NULL CHECK (`type` >= 0),
  `level` smallint(5) UNSIGNED NOT NULL CHECK (`level` >= 0),
  `picture` varchar(100) NOT NULL,
  `group` smallint(5) UNSIGNED NOT NULL CHECK (`group` >= 0),
  `mark_red` tinyint(1) DEFAULT NULL,
  `mark_green` tinyint(1) DEFAULT NULL,
  `mark_yellow` tinyint(1) DEFAULT NULL,
  `item_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `main_taskitem`
--

CREATE TABLE `main_taskitem` (
  `id` bigint(20) NOT NULL,
  `leading_char` varchar(4) NOT NULL,
  `text` varchar(200) NOT NULL,
  `value` varchar(20) NOT NULL,
  `value_name` varchar(200) NOT NULL,
  `checked` tinyint(1) DEFAULT NULL,
  `checked_t` tinyint(1) DEFAULT NULL,
  `value_t` varchar(20) NOT NULL,
  `task_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `main_task_school`
--

CREATE TABLE `main_task_school` (
  `id` bigint(20) NOT NULL,
  `task_id` bigint(20) NOT NULL,
  `school_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `main_task_themes`
--

CREATE TABLE `main_task_themes` (
  `id` bigint(20) NOT NULL,
  `task_id` bigint(20) NOT NULL,
  `theme_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `main_theme`
--

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `main_theme`
--

INSERT INTO `main_theme` (`id`, `num`, `title`, `remark`, `tasks_total`, `tasks_knowledge`, `tasks_comprehension`, `tasks_application`, `tasks_analysis`) VALUES
(1, 1, 'Микропроцесор. Архитектура на микропроцесор', '', 24, 9, 8, 3, 4);

-- --------------------------------------------------------

--
-- Структура на таблица `main_themeitem`
--

CREATE TABLE `main_themeitem` (
  `id` bigint(20) NOT NULL,
  `item` smallint(5) UNSIGNED NOT NULL CHECK (`item` >= 0),
  `title` longtext NOT NULL,
  `criterion` longtext NOT NULL,
  `total_points` smallint(5) UNSIGNED NOT NULL CHECK (`total_points` >= 0),
  `knowledge` smallint(5) UNSIGNED NOT NULL CHECK (`knowledge` >= 0),
  `comprehension` smallint(5) UNSIGNED NOT NULL CHECK (`comprehension` >= 0),
  `application` smallint(5) UNSIGNED NOT NULL CHECK (`application` >= 0),
  `analysis` smallint(5) UNSIGNED NOT NULL CHECK (`analysis` >= 0),
  `theme_id_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `main_themeitem`
--

INSERT INTO `main_themeitem` (`id`, `item`, `title`, `criterion`, `total_points`, `knowledge`, `comprehension`, `application`, `analysis`, `theme_id_id`) VALUES
(1, 1, 'RISC и CISC микропроцесори. Развитие на микропроцесорите', 'Дефинира понятието „микропроцесор“, пояснява разликата между CISC и RISC процесорите, проследява хронологично развитието на процесорите.', 20, 4, 3, 0, 0, 1),
(2, 2, 'Основни функционални блокове на CISC микропроцесор', 'Чертае обобщена блок-схема на микропроцесор с фон Нойманова (Принстънска) архитектура. Обяснява функциите на отделните блокове и връзките между тях.', 30, 2, 1, 1, 2, 1),
(3, 3, 'Технически параметри на микропроцесорите', 'Изброява и пояснява основните параметри на процесорите.', 10, 1, 2, 0, 0, 1),
(4, 4, 'Режими на работа на микропроцесорите', 'Посочва и обяснява режимите на работа на процесорите', 20, 0, 2, 2, 0, 1),
(5, 5, 'Тенденции в развитието на микропроцесорите, съвместимост', 'Представя тенденциите в развитието на микропроцесорите. Определя възможностите за съвместимост между различните архитектури', 20, 2, 0, 0, 2, 1);

-- --------------------------------------------------------

--
-- Структура на таблица `main_userprofile`
--

CREATE TABLE `main_userprofile` (
  `id` bigint(20) NOT NULL,
  `access_level` smallint(5) UNSIGNED NOT NULL CHECK (`access_level` >= 0),
  `session_screen` smallint(5) UNSIGNED NOT NULL CHECK (`session_screen` >= 0),
  `session_theme` smallint(5) UNSIGNED NOT NULL CHECK (`session_theme` >= 0),
  `user_id` int(11) NOT NULL,
  `school_id` bigint(20) DEFAULT NULL,
  `speciality_id` bigint(20) DEFAULT NULL,
  `gender` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `main_userprofile`
--

INSERT INTO `main_userprofile` (`id`, `access_level`, `session_screen`, `session_theme`, `user_id`, `school_id`, `speciality_id`, `gender`) VALUES
(1, 1, 1, 1, 1, 1, 1, 1),
(2, 2, 1, 1, 2, 1, NULL, 1),
(3, 3, 1, 1, 3, 1, 2, 1),
(4, 4, 1, 1, 4, 1, NULL, 1),
(5, 4, 1, 1, 5, 2, NULL, 1),
(6, 5, 1, 1, 6, 1, 1, 0),
(7, 5, 1, 1, 7, 2, 2, 1),
(8, 3, 1, 1, 8, 2, NULL, 1);

--
-- Indexes for dumped tables
--

--
-- Индекси за таблица `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Индекси за таблица `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Индекси за таблица `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Индекси за таблица `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Индекси за таблица `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Индекси за таблица `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Индекси за таблица `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Индекси за таблица `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Индекси за таблица `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Индекси за таблица `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Индекси за таблица `main_documents`
--
ALTER TABLE `main_documents`
  ADD PRIMARY KEY (`id`);

--
-- Индекси за таблица `main_log`
--
ALTER TABLE `main_log`
  ADD PRIMARY KEY (`id`);

--
-- Индекси за таблица `main_school`
--
ALTER TABLE `main_school`
  ADD PRIMARY KEY (`id`);

--
-- Индекси за таблица `main_school_specialities`
--
ALTER TABLE `main_school_specialities`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `main_school_specialities_school_id_specialty_id_c782cac5_uniq` (`school_id`,`specialty_id`),
  ADD KEY `main_school_speciali_specialty_id_78354343_fk_main_spec` (`specialty_id`);

--
-- Индекси за таблица `main_specialty`
--
ALTER TABLE `main_specialty`
  ADD PRIMARY KEY (`id`);

--
-- Индекси за таблица `main_task`
--
ALTER TABLE `main_task`
  ADD PRIMARY KEY (`id`),
  ADD KEY `main_task_item_id_1d36f96a_fk_main_themeitem_id` (`item_id`);

--
-- Индекси за таблица `main_taskitem`
--
ALTER TABLE `main_taskitem`
  ADD PRIMARY KEY (`id`),
  ADD KEY `main_taskitem_task_id_396d8f83_fk_main_task_id` (`task_id`);

--
-- Индекси за таблица `main_task_school`
--
ALTER TABLE `main_task_school`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `main_task_school_task_id_school_id_1c972fe8_uniq` (`task_id`,`school_id`),
  ADD KEY `main_task_school_school_id_e5d27546_fk_main_school_id` (`school_id`);

--
-- Индекси за таблица `main_task_themes`
--
ALTER TABLE `main_task_themes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `main_task_themes_task_id_theme_id_30649038_uniq` (`task_id`,`theme_id`),
  ADD KEY `main_task_themes_theme_id_d3221678_fk_main_theme_id` (`theme_id`);

--
-- Индекси за таблица `main_theme`
--
ALTER TABLE `main_theme`
  ADD PRIMARY KEY (`id`);

--
-- Индекси за таблица `main_themeitem`
--
ALTER TABLE `main_themeitem`
  ADD PRIMARY KEY (`id`),
  ADD KEY `main_themeitem_theme_id_id_ed7a6412_fk_main_theme_id` (`theme_id_id`);

--
-- Индекси за таблица `main_userprofile`
--
ALTER TABLE `main_userprofile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD KEY `main_userprofile_school_id_74f42cf3_fk_main_school_id` (`school_id`),
  ADD KEY `main_userprofile_speciality_id_475d0b2d_fk_main_specialty_id` (`speciality_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `main_documents`
--
ALTER TABLE `main_documents`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `main_log`
--
ALTER TABLE `main_log`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `main_school`
--
ALTER TABLE `main_school`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `main_school_specialities`
--
ALTER TABLE `main_school_specialities`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `main_specialty`
--
ALTER TABLE `main_specialty`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `main_task`
--
ALTER TABLE `main_task`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `main_taskitem`
--
ALTER TABLE `main_taskitem`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `main_task_school`
--
ALTER TABLE `main_task_school`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `main_task_themes`
--
ALTER TABLE `main_task_themes`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `main_theme`
--
ALTER TABLE `main_theme`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `main_themeitem`
--
ALTER TABLE `main_themeitem`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `main_userprofile`
--
ALTER TABLE `main_userprofile`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Ограничения за дъмпнати таблици
--

--
-- Ограничения за таблица `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Ограничения за таблица `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Ограничения за таблица `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения за таблица `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения за таблица `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения за таблица `main_school_specialities`
--
ALTER TABLE `main_school_specialities`
  ADD CONSTRAINT `main_school_speciali_specialty_id_78354343_fk_main_spec` FOREIGN KEY (`specialty_id`) REFERENCES `main_specialty` (`id`),
  ADD CONSTRAINT `main_school_specialities_school_id_9588fab6_fk_main_school_id` FOREIGN KEY (`school_id`) REFERENCES `main_school` (`id`);

--
-- Ограничения за таблица `main_task`
--
ALTER TABLE `main_task`
  ADD CONSTRAINT `main_task_item_id_1d36f96a_fk_main_themeitem_id` FOREIGN KEY (`item_id`) REFERENCES `main_themeitem` (`id`);

--
-- Ограничения за таблица `main_taskitem`
--
ALTER TABLE `main_taskitem`
  ADD CONSTRAINT `main_taskitem_task_id_396d8f83_fk_main_task_id` FOREIGN KEY (`task_id`) REFERENCES `main_task` (`id`);

--
-- Ограничения за таблица `main_task_school`
--
ALTER TABLE `main_task_school`
  ADD CONSTRAINT `main_task_school_school_id_e5d27546_fk_main_school_id` FOREIGN KEY (`school_id`) REFERENCES `main_school` (`id`),
  ADD CONSTRAINT `main_task_school_task_id_57251098_fk_main_task_id` FOREIGN KEY (`task_id`) REFERENCES `main_task` (`id`);

--
-- Ограничения за таблица `main_task_themes`
--
ALTER TABLE `main_task_themes`
  ADD CONSTRAINT `main_task_themes_task_id_8ea4c748_fk_main_task_id` FOREIGN KEY (`task_id`) REFERENCES `main_task` (`id`),
  ADD CONSTRAINT `main_task_themes_theme_id_d3221678_fk_main_theme_id` FOREIGN KEY (`theme_id`) REFERENCES `main_theme` (`id`);

--
-- Ограничения за таблица `main_themeitem`
--
ALTER TABLE `main_themeitem`
  ADD CONSTRAINT `main_themeitem_theme_id_id_ed7a6412_fk_main_theme_id` FOREIGN KEY (`theme_id_id`) REFERENCES `main_theme` (`id`);

--
-- Ограничения за таблица `main_userprofile`
--
ALTER TABLE `main_userprofile`
  ADD CONSTRAINT `main_userprofile_school_id_74f42cf3_fk_main_school_id` FOREIGN KEY (`school_id`) REFERENCES `main_school` (`id`),
  ADD CONSTRAINT `main_userprofile_speciality_id_475d0b2d_fk_main_specialty_id` FOREIGN KEY (`speciality_id`) REFERENCES `main_specialty` (`id`),
  ADD CONSTRAINT `main_userprofile_user_id_15c416f4_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
