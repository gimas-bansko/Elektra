-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Време на генериране:  7 фев 2025 в 17:15
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

DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
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

DROP TABLE IF EXISTS `auth_user`;
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
(1, 'pbkdf2_sha256$600000$bAENMC2y6CBzHiVvZTa7sj$MP961DiZWk5LKNig+de4AKqeNf9wD+aKmJxqhxmyeGU=', '2025-02-05 19:02:04.857440', 1, 'superadmin', 'Георги', 'Бориков', 'ggborikov@abv.bg', 1, 1, '2024-12-29 17:32:38.000000'),
(2, 'pbkdf2_sha256$600000$RWfc0Po5N9BUkizdDNHsIE$67D49ArZ/dLSqU4KFPLJWBiuSslah0gCNFCagSxXVdg=', NULL, 0, 'guestadmin', 'Гост', 'Админ', 'ga@ad.com', 0, 1, '2024-12-29 21:35:09.000000'),
(3, 'pbkdf2_sha256$600000$PEevvgdmijM2ilQntfJs4g$ullQlEiWASWqqMTtkX7eq6rErh6GnKns/W3cRTV6YIY=', '2025-02-02 10:34:57.423937', 0, 'schooladmin1', 'Училищен', 'Админ', '', 0, 1, '2024-12-29 21:38:59.000000'),
(4, 'pbkdf2_sha256$600000$Na4YoANjNOepAC37fCZz2I$c2jwxDw8oBet84B/aoFbvd91i5HKDLxniPSuJD2hkDk=', NULL, 0, 'teacher1', 'Учител', '1', '', 0, 1, '2024-12-29 21:40:28.000000'),
(5, 'pbkdf2_sha256$600000$q8x1XojW1qkF40PJsicOQz$vmotFZ0od9zKMNmA9wibUBz0crHJXz12noZb9D4qscg=', '2024-12-30 15:34:38.037155', 0, 'teacher2', 'Учител', '2', '', 0, 1, '2024-12-29 21:40:55.000000'),
(6, 'pbkdf2_sha256$600000$1bY0hDrKYA0R7qUdBAYwPR$/wrXG/7djhixTHJ8dt6Itqc2ES5NFRVfOmIWK8SUaWw=', NULL, 0, 'student1', 'Ученник', '1', '', 0, 1, '2024-12-29 21:41:11.000000'),
(7, 'pbkdf2_sha256$600000$JeGmRVAFHowS0VnPnurjtR$s9r+PkOfMVeOk0phB4xwgIvvbqVpBZu4zefd9guzwh0=', NULL, 0, 'student2', 'Ученик', '2', '', 0, 1, '2024-12-29 21:41:28.000000'),
(8, 'pbkdf2_sha256$600000$UVMIfVg53LiGDkJJhGHyj2$MfEf4n0TTcxyXVEzdfSIl/4Kh6wG0gW12qG/Kd+Fwx0=', NULL, 0, 'schooladmin2', 'Училищен', 'Админ2', '', 0, 1, '2024-12-29 21:43:33.000000');

-- --------------------------------------------------------

--
-- Структура на таблица `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
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
(60, '2025-01-05 18:02:42.105769', '2', '2. Основни функционални блокове на CISC микропроцесор', 2, '[{\"changed\": {\"fields\": [\"\\u0417\\u0430\\u0433\\u043b\\u0430\\u0432\\u0438\\u0435\"]}}]', 14, 1),
(61, '2025-02-05 12:41:24.657159', '1', '1. RISC и CISC микропроцесори. Развитие на микропроцесорите', 3, '', 14, 1),
(62, '2025-02-05 12:41:24.660735', '2', '2. Основни функционални блокове на CISC микропроцесор', 3, '', 14, 1),
(63, '2025-02-05 12:41:24.662702', '3', '3. Технически параметри на микропроцесорите', 3, '', 14, 1),
(64, '2025-02-05 12:41:24.665963', '4', '4. Режими на работа на микропроцесорите', 3, '', 14, 1),
(65, '2025-02-05 12:41:31.800743', '5', '5. Тенденции в развитието на микропроцесорите, съвместимост', 3, '', 14, 1),
(66, '2025-02-05 12:41:52.985207', '1', 'Тема 1. Микропроцесор. Архитектура на микропроцесор', 3, '', 12, 1);

-- --------------------------------------------------------

--
-- Структура на таблица `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
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

DROP TABLE IF EXISTS `django_migrations`;
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
(22, 'main', '0004_alter_school_logo', '2025-01-04 20:13:35.286383'),
(23, 'main', '0005_remove_theme_remark_theme_specialty', '2025-02-05 14:23:22.738554'),
(24, 'main', '0006_remove_task_mark_green_remove_task_mark_red_and_more', '2025-02-07 16:12:25.744066');

-- --------------------------------------------------------

--
-- Структура на таблица `django_session`
--

DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('21sh22a77rh34si6t8gfns7voclo9zfa', '.eJxVjMsOwiAQRf-FtSHyKDAu3fsNZIYBqRqalHZl_HfbpAvd3nPueYuI61Lj2vMcRxYXocTpdyNMz9x2wA9s90mmqS3zSHJX5EG7vE2cX9fD_QtU7HV721J0Dlb7AJp8Mk6zy0MIbNUWAeW8VcpQAQMEJivGUsLAZ0BKupATny_YWzgY:1tVcDq:7iyKYtIObV8sWGQnLdzNcXtQB-bIS4jN436eNbOuBaA', '2025-01-22 20:00:10.235656'),
('30emskj9uh6r4ei6hvktjk5vy3fdbovc', '.eJxVjMsOwiAQRf-FtSHyKDAu3fsNZIYBqRqalHZl_HfbpAvd3nPueYuI61Lj2vMcRxYXocTpdyNMz9x2wA9s90mmqS3zSHJX5EG7vE2cX9fD_QtU7HV721J0Dlb7AJp8Mk6zy0MIbNUWAeW8VcpQAQMEJivGUsLAZ0BKupATny_YWzgY:1tUFbV:uouOqJmsaDReuSupFStz-keCGmqOcFqkShdsfDt-hNk', '2025-01-19 01:38:57.340694'),
('3ru5pv463wmorx95l7ebw670mclzfkq8', '.eJxVjMsOwiAQRf-FtSHyKDAu3fsNZIYBqRqalHZl_HfbpAvd3nPueYuI61Lj2vMcRxYXocTpdyNMz9x2wA9s90mmqS3zSHJX5EG7vE2cX9fD_QtU7HV721J0Dlb7AJp8Mk6zy0MIbNUWAeW8VcpQAQMEJivGUsLAZ0BKupATny_YWzgY:1tUAOG:BmSidPGyYyAxTKPgzqUcOjIEefKwR4otkuFC2S8jNw0', '2025-01-18 20:04:56.430846'),
('68kgmisyij3ra5xnkmzzdrg0h1bq8gyj', '.eJxVjMsOwiAQRf-FtSHyKDAu3fsNZIYBqRqalHZl_HfbpAvd3nPueYuI61Lj2vMcRxYXocTpdyNMz9x2wA9s90mmqS3zSHJX5EG7vE2cX9fD_QtU7HV721J0Dlb7AJp8Mk6zy0MIbNUWAeW8VcpQAQMEJivGUsLAZ0BKupATny_YWzgY:1tfkey:sHjY1M30j4acTjj8h4d9TyEIjzlgi25nEmcc_ONARhA', '2025-02-19 19:02:04.860445'),
('8mstj9f58xi14czbvnd70qat11v2cskj', 'e30:1tUBse:pdrhJabkhjQIc1vl2dTVa_-W0OgcmJIBZ0gB55qA0Gc', '2025-01-18 21:40:24.685498'),
('df9u2zir7nyvk0cyr7e8s99a7vpt30it', '.eJxVjMsOwiAQRf-FtSHyKDAu3fsNZIYBqRqalHZl_HfbpAvd3nPueYuI61Lj2vMcRxYXocTpdyNMz9x2wA9s90mmqS3zSHJX5EG7vE2cX9fD_QtU7HV721J0Dlb7AJp8Mk6zy0MIbNUWAeW8VcpQAQMEJivGUsLAZ0BKupATny_YWzgY:1tUC4B:DUggkm-H9BZPSbjBaa4Bpduh9K-TqYsgCjDCGfdMjMo', '2025-01-18 21:52:19.757616'),
('dr803shmi80ajfgx539dzaa7vijt79ve', '.eJxVjMsOwiAQRf-FtSHyKDAu3fsNZIYBqRqalHZl_HfbpAvd3nPueYuI61Lj2vMcRxYXocTpdyNMz9x2wA9s90mmqS3zSHJX5EG7vE2cX9fD_QtU7HV721J0Dlb7AJp8Mk6zy0MIbNUWAeW8VcpQAQMEJivGUsLAZ0BKupATny_YWzgY:1tUEuq:QANcjOaSqg-LmLU7z8XGZzGxd0S86Mph9139IrpsrVE', '2025-01-19 00:54:52.877419'),
('h1hz9wjgo5jq324vq0vfvtoqtsg9hv0h', '.eJxVjMsOwiAQRf-FtSHyKDAu3fsNZIYBqRqalHZl_HfbpAvd3nPueYuI61Lj2vMcRxYXocTpdyNMz9x2wA9s90mmqS3zSHJX5EG7vE2cX9fD_QtU7HV721J0Dlb7AJp8Mk6zy0MIbNUWAeW8VcpQAQMEJivGUsLAZ0BKupATny_YWzgY:1tUAhd:r9RVWvaGYoj0XAjUqRQgxxvDb8bGxBtyQFM38aeRp8A', '2025-01-18 20:24:57.285524'),
('iqppbszl75bm1jzfqtdmmpyym5nvockj', '.eJxVjMsOwiAQRf-FtSHyKDAu3fsNZIYBqRqalHZl_HfbpAvd3nPueYuI61Lj2vMcRxYXocTpdyNMz9x2wA9s90mmqS3zSHJX5EG7vE2cX9fD_QtU7HV721J0Dlb7AJp8Mk6zy0MIbNUWAeW8VcpQAQMEJivGUsLAZ0BKupATny_YWzgY:1tTWVn:JaFKZPGmjnc_EGlQpIojCrSBbRrL1Fp1KAiq5ewddms', '2025-01-17 01:30:03.184676'),
('l4rsxt8r9edreck8mjbiocw72kxiyith', '.eJxVjMsOwiAQRf-FtSHyKDAu3fsNZIYBqRqalHZl_HfbpAvd3nPueYuI61Lj2vMcRxYXocTpdyNMz9x2wA9s90mmqS3zSHJX5EG7vE2cX9fD_QtU7HV721J0Dlb7AJp8Mk6zy0MIbNUWAeW8VcpQAQMEJivGUsLAZ0BKupATny_YWzgY:1tS1s1:7tT4KQbm4McDON9jJOzBXcYygyH3r1R34iQgekenYbc', '2025-01-12 22:34:49.613757'),
('mc01p662lmy6j84pzz6sx7bxrnbm8ho7', '.eJxVjMsOwiAQRf-FtSHyKDAu3fsNZIYBqRqalHZl_HfbpAvd3nPueYuI61Lj2vMcRxYXocTpdyNMz9x2wA9s90mmqS3zSHJX5EG7vE2cX9fD_QtU7HV721J0Dlb7AJp8Mk6zy0MIbNUWAeW8VcpQAQMEJivGUsLAZ0BKupATny_YWzgY:1tSzeg:pVsPc5IbeDT1fzuqP5BgkxuZXMrJCWhXwJ7WHEJKrFc', '2025-01-15 14:25:02.052397'),
('mhtgpirm4fge6zuqbj163dad66dyqwds', '.eJxVjDsOwjAQBe_iGlkbO_4sJX3OYK1_OIBsKU4qxN2RpRTQvpl5b-bo2Is7etrcGtmVSXb53TyFZ6oDxAfVe-Oh1X1bPR8KP2nnS4vpdTvdv4NCvYxaKfRI3lhAMcecSSjUkgTAhDBFSEnLDNLOWlDSmZQFY9AggPKoAvt8Ac1VNu0:1teXJZ:ViazKLmTKan7A6wbZYNnIWfBvtgMjGkvO2HMXVhsE9U', '2025-02-16 10:34:57.437078'),
('pul6ra6t7qsyfia6bc9bup9kvwt15rqa', 'e30:1tUBqa:uC2hg0NIhfndIzVVqi5YI3hRB5U7e__xQABuE5gAt-8', '2025-01-18 21:38:16.378424'),
('pzwm5erx2frykg6kmwkc6cykpemcfs83', '.eJxVjMsOwiAQRf-FtSHyKDAu3fsNZIYBqRqalHZl_HfbpAvd3nPueYuI61Lj2vMcRxYXocTpdyNMz9x2wA9s90mmqS3zSHJX5EG7vE2cX9fD_QtU7HV721J0Dlb7AJp8Mk6zy0MIbNUWAeW8VcpQAQMEJivGUsLAZ0BKupATny_YWzgY:1tRzD1:POrK6kLmN90kQWTtHnWoosZjhZcqnQIETPObHPZXigk', '2025-01-12 19:44:19.901785'),
('tz54oipwy1dbmmsciysur2b65ehlfbxa', '.eJxVjMsOwiAQRf-FtSHyKDAu3fsNZIYBqRqalHZl_HfbpAvd3nPueYuI61Lj2vMcRxYXocTpdyNMz9x2wA9s90mmqS3zSHJX5EG7vE2cX9fD_QtU7HV721J0Dlb7AJp8Mk6zy0MIbNUWAeW8VcpQAQMEJivGUsLAZ0BKupATny_YWzgY:1tS1ti:VfzIDthWanLwGbe_dFxTXsZfKmg5OMPx9Zk9HDqhe7A', '2025-01-12 22:36:34.874467'),
('zuy5o3kagr3p5v5o2a2e1617463tlfrz', '.eJxVjDsOwjAQBe_iGlkbO_4sJX3OYK1_OIBsKU4qxN2RpRTQvpl5b-bo2Is7etrcGtmVSXb53TyFZ6oDxAfVe-Oh1X1bPR8KP2nnS4vpdTvdv4NCvYxaKfRI3lhAMcecSSjUkgTAhDBFSEnLDNLOWlDSmZQFY9AggPKoAvt8Ac1VNu0:1tSgPj:GThGiHTGGvglDa2lw_h8Lo521dDVUIuTTM9UVzAF52U', '2025-01-14 17:52:19.666660');

-- --------------------------------------------------------

--
-- Структура на таблица `main_documents`
--

DROP TABLE IF EXISTS `main_documents`;
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

DROP TABLE IF EXISTS `main_log`;
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
(48, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-06 19:09:29.269385'),
(49, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-01-08 20:00:10.229972'),
(50, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-02-01 23:37:43.370849'),
(51, 3, 'Училищен Админ', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-02-02 10:34:57.428760'),
(52, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-02-02 12:02:30.264277'),
(53, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-02-02 13:15:20.684828'),
(54, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-02-02 13:44:51.785674'),
(55, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-02-02 17:07:12.512169'),
(56, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-02-02 18:51:25.707509'),
(57, 1, 'Георги Бориков', 'ВЛИЗАНЕ В ПЛАТФОРМАТА', '2025-02-05 19:02:04.860445');

-- --------------------------------------------------------

--
-- Структура на таблица `main_school`
--

DROP TABLE IF EXISTS `main_school`;
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

DROP TABLE IF EXISTS `main_school_specialities`;
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

DROP TABLE IF EXISTS `main_specialty`;
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

DROP TABLE IF EXISTS `main_task`;
CREATE TABLE `main_task` (
  `id` bigint(20) NOT NULL,
  `num` smallint(5) UNSIGNED NOT NULL CHECK (`num` >= 0),
  `text` longtext NOT NULL,
  `type` smallint(5) UNSIGNED NOT NULL CHECK (`type` >= 0),
  `level` smallint(5) UNSIGNED NOT NULL CHECK (`level` >= 0),
  `picture` varchar(100) NOT NULL,
  `group` smallint(5) UNSIGNED NOT NULL CHECK (`group` >= 0),
  `item_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `main_taskitem`
--

DROP TABLE IF EXISTS `main_taskitem`;
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

DROP TABLE IF EXISTS `main_task_school`;
CREATE TABLE `main_task_school` (
  `id` bigint(20) NOT NULL,
  `task_id` bigint(20) NOT NULL,
  `school_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `main_theme`
--

DROP TABLE IF EXISTS `main_theme`;
CREATE TABLE `main_theme` (
  `id` bigint(20) NOT NULL,
  `num` smallint(5) UNSIGNED NOT NULL CHECK (`num` >= 0),
  `title` longtext NOT NULL,
  `tasks_total` smallint(5) UNSIGNED NOT NULL CHECK (`tasks_total` >= 0),
  `tasks_knowledge` smallint(5) UNSIGNED NOT NULL CHECK (`tasks_knowledge` >= 0),
  `tasks_comprehension` smallint(5) UNSIGNED NOT NULL CHECK (`tasks_comprehension` >= 0),
  `tasks_application` smallint(5) UNSIGNED NOT NULL CHECK (`tasks_application` >= 0),
  `tasks_analysis` smallint(5) UNSIGNED NOT NULL CHECK (`tasks_analysis` >= 0),
  `specialty_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `main_theme`
--

INSERT INTO `main_theme` (`id`, `num`, `title`, `tasks_total`, `tasks_knowledge`, `tasks_comprehension`, `tasks_application`, `tasks_analysis`, `specialty_id`) VALUES
(1, 1, 'Микропроцесор. Архитектура на микропроцесор', 24, 9, 8, 3, 4, 1),
(2, 2, 'Многоядрени процесори на Intel', 28, 13, 10, 3, 2, 1),
(3, 3, 'Многоядрени процесори на AMD', 28, 13, 10, 3, 2, 1),
(4, 4, 'Дънна платка с процесор Intel Core i', 23, 7, 8, 5, 3, 1),
(5, 5, 'Дънна платка с процесор на AMD', 23, 7, 8, 5, 3, 1),
(6, 6, 'Статични и динамични памети в компютърните системи', 26, 10, 10, 4, 2, 1),
(7, 7, 'Постоянни памети в компютърните системи', 27, 13, 7, 5, 2, 1),
(8, 8, 'Мрежов хардуер', 26, 11, 9, 3, 3, 1),
(9, 9, 'Видове топологии на компютърните мрежи и администриране', 27, 12, 9, 4, 2, 1),
(10, 10, 'Мрежови модели', 26, 9, 12, 3, 2, 1),
(11, 11, 'Мрежови протоколи', 26, 11, 8, 5, 2, 1),
(12, 12, 'Магнитни и полупроводникови запомнящи устройства', 25, 8, 12, 2, 3, 1),
(13, 13, 'Оптични запомнящи устройства', 26, 10, 10, 4, 2, 1),
(14, 14, 'Сканиращи и печатащи устройства', 26, 9, 12, 3, 2, 1),
(15, 15, 'Периферни устройства за видео и звук', 27, 11, 11, 3, 2, 1),
(16, 16, 'Алгоритми и типове данни', 25, 9, 10, 3, 3, 1),
(17, 17, 'Оператори за управление на изчислителния процес', 27, 11, 11, 3, 2, 1),
(18, 18, 'Процеси, нишки, алгоритми за планиране и управление на паметта в \r\nоперационната система (ОС)', 24, 9, 7, 5, 3, 1);

-- --------------------------------------------------------

--
-- Структура на таблица `main_themeitem`
--

DROP TABLE IF EXISTS `main_themeitem`;
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
(1, 1, 'RISC и CISC микропроцесори. Развитие на микропроцесорите', 'Дефинира понятието „микропроцесор“, пояснява разликата между CISC и RISC процесорите, проследява хронологичното развитието на процесорите', 20, 4, 3, 0, 0, 1),
(2, 2, 'Основни функционални блокове на CISC микропроцесор', 'Чертае обобщена блок-схема на микропроцесор с фон Нойманова (Принстънска) архитектура. Обяснява функциите на отделните блокове и връзките между тях', 30, 2, 1, 1, 2, 1),
(3, 3, 'Технически параметри на микропроцесорите', 'Изброява и пояснява основните параметри на процесорите', 10, 1, 2, 0, 0, 1),
(4, 4, 'Режими на работа на микропроцесорите', 'Посочва и обяснява режимите на работа на процесорите', 20, 0, 2, 2, 0, 1),
(5, 5, 'Тенденции в развитието на микропроцесорите, съвместимост', 'Представя тенденциите в развитието на микропроцесорите. Определя възможностите за съвместимост между различните архитектури', 20, 2, 0, 0, 2, 1),
(6, 1, 'Пакети от данни, пренасяни по мрежата. Полета на пакета данни', 'Дефинира и обяснява основните полета в пакетите от \r\nданни, пренасяни по мрежата', 10, 1, 2, 0, 0, 10),
(7, 2, 'Многослоен процес на комуникация', 'Дефинира и обяснява многослоен процес на комуникация по мрежите', 10, 1, 2, 0, 0, 10),
(8, 3, 'Мрежови протоколи', 'Дефинира и обяснява основните мрежови протоколи', 10, 1, 2, 0, 0, 10),
(9, 4, 'Модел OSI. Слоеве на модела', 'Чертае структурата на OSI модела и обяснява функциите на всеки слой', 20, 3, 2, 1, 0, 10),
(10, 5, 'Моделът DoD. Слоеве на модела', 'Чертае структурата на DoD модела и обяснява функциите на всеки слой', 20, 3, 2, 1, 0, 10),
(11, 6, 'Сравнение на слоевете на модела OSI и модела DoD', 'Сравнява двата модела и прави изводи за основните разлики между тях', 30, 0, 2, 1, 2, 10),
(12, 1, 'Многоядрена технология. Развитие на многоядрените процесори .', 'Обяснява многоядрена технология. Описва развитието на многоядрените процесори.', 20, 4, 3, 0, 0, 2),
(13, 2, 'Поколения микроархитектури на процесори Core i на Intel', 'Посочва основните поколения микроархитектури на процесори Core i на \r\nIntel и открива разликите им', 20, 4, 0, 2, 0, 2),
(14, 3, 'Основни параметри на процесори Core i на Intel', 'Дефинира и обяснява основните параметри на процесорите', 20, 4, 3, 0, 0, 2),
(15, 4, 'Видове технологии.', 'Описва видовете технологии – Hyper-Threading (HTT), ММХ технология и Virtualization Technology', 10, 1, 2, 0, 0, 2),
(16, 5, 'Напишете методите за разграничаване на хардуерните от софтуерните проблеми в компютърна система. Вашият компютър разполага с мощна видеокарта, но при по-голямо натоварване образът започва да „насича”', 'Написва методите за разграничаване на хардуерните от софтуерните проблеми в компютърна система. Вашият компютър разполага с мощна видеокарта, но при по-голямо натоварване образът започва да „насича”. Посочете две възможни причини.', 30, 0, 2, 1, 2, 2),
(17, 1, 'Многоядрена технология. Развитие на многоядрените процесори на AMD.', 'Обяснява многоядрена технология. Описва развитие на многоядрените процесори на AMD.', 20, 4, 3, 0, 0, 3),
(18, 2, 'Особености в архитектурата на процесори AMD.', 'Посочва и обяснява особеностите в архитектурата на процесори AMD.', 20, 4, 0, 2, 0, 3),
(19, 3, 'Основни параметри на процесори AMD.', 'Дефинира и обяснява основните параметри на процесори AMD.', 20, 4, 3, 0, 0, 3),
(20, 4, 'Видове технологии.', 'Описва видовете технологии – Virtualization Technology, ММХ технология и \r\nCool`n Quiet', 10, 1, 2, 0, 0, 3),
(21, 5, 'Опишете основните стъпки от методиката за откриване и отстраняване на хардуерни \r\nпроблеми и дефекти в компютърна система. Коя е основната причина, която често води до \r\nдефектиране на CPU, HDD, CD/DVD-ROM и понякога и видеокартата при преносимите компютри?', 'Описва основните стъпки от методиката за откриване и отстраняване на хардуерни проблеми и дефекти в компютърна система. Коя е основната причина, която често води до дефектиране на CPU, HDD, CD/DVD-ROM и понякога и видеокартата при преносимите компютри?', 30, 0, 2, 1, 2, 3),
(22, 1, 'Функции на основните блокове на дънна платка за процесор Intel Core i7 Socket LGA1366. \r\nФорм фактор на дънната платка.', 'Чертае блокова схема на дънна платка с процесор Intel Core i7 Socket LGA1366. Посочва основните и блокове й обяснява предназначението им. Дефинира понятието форм фактор на дънната платка.', 30, 1, 2, 2, 1, 4),
(23, 2, 'Особености на хъбовата архитектура. Видове хъбов интерфейс.', 'Прави сравнение между хъбовата архитектура и архитектура северен/южен мост и посочва предимствата й. Изброява и обяснява видовете хъбов интерфейс.', 20, 2, 4, 0, 0, 4),
(24, 3, 'PCI Express шина и USB шина, характеристики, спецификации.', 'Дефинира PCI Express шина и USB шина, описва характеристики им и посочва основните им специфик', 20, 3, 2, 1, 0, 4),
(25, 4, 'Сравнение на дънни платки с процесор Intel Core i7 и дънна платка от предишно поколение \r\nотносно процесор, процесорна шина, тип и обем DRAM памет, разширителни шини, видеокарта, интерфейс за твърд диск.', 'Сравнява дънни платки с процесор Intel Core i7 и дънна платка от предишно поколение относно процесор, процесорна шина, тип и обем DRAM памет, разширителни шини, видеокарта, интерфейс за твърд диск – открива разликите и прави изводи', 30, 1, 0, 2, 2, 4),
(26, 1, 'Функции на основните блокове на дънна платка за процесор AMD с чипсет от серия 800.', 'Чертае блокова схема на дънна платка с процесор AMD с чипсет от серия 800. Посочва основните й блокове и обяснява предназначението им', 30, 0, 4, 1, 1, 5),
(27, 2, 'Особености на HyperTransport технологията. Технологии за ускоряване на вход/изход.', 'Дефинира и обяснява HyperTransport технологията. Дефинира и обяснява технологии за ускоряване на вход/изход.', 20, 3, 2, 1, 0, 5),
(28, 3, 'PCI Express шина и AGP шина, характеристики, спецификации.', 'Дефинира и описва PCI Express шина и AGP шина, изброява основните им\r\nхарактеристики и спецификации.', 20, 3, 2, 1, 0, 5),
(29, 4, 'Сравнение на дънни платки с процесор AMD с чипсет от серия 800 и дънна платка от предишно поколение относно процесор, процесорна шина, тип и обем DRAM памет, разширителни шини, видеокарта, интерфейс за твърд диск.', 'Сравнява дънни платки с процесор AMD с чипсет от серия 800 и дънна платка от предишно поколение относно процесор, процесорна шина, тип и обем DRAM памет, разширителни шини, видеокарта, интерфейс за твърд диск.', 30, 1, 0, 2, 2, 5),
(30, 1, 'RAM памет, характеристики, видове .', 'Дефинира RAM памет, изброява и описва основните характеристики на паметта, различава основните видове памет', 10, 3, 1, 0, 0, 6),
(31, 2, 'Особености на статична памет. КЕШ памет – предназначение и нива.', 'Описва особеностите на статична памет. Обяснява същност на КЕШ памет, изброява нивата и обяснява техните параметри и предназначение', 20, 1, 3, 1, 0, 6),
(32, 3, 'Особености на динамичните памети. Видове динамични памети – основни параметри.', 'Описва особеностите на динамичните памети. Чертае схема на клетка памет. \r\nИзброява и описва видовете динамични памети и основните им параметри.', 20, 1, 3, 1, 0, 6),
(33, 4, 'Модули DRAM – SIMM, DIMM, RIMM.', 'Посочва основните модули DRAM и описва параметрите на DIMM и RIMM', 20, 4, 3, 0, 0, 6),
(34, 5, 'Сравнение на основните модули динамични памети спрямо тактова честота, захранващо \r\nнапрежение, капацитет на модулите и скорост на обмен.', 'Разделя основните модули динамични памети спрямо тактова честота, захранващо напрежение, капацитет на модулите и скорост на обмен и прави изводи относно приложението им.', 30, 1, 0, 2, 2, 6),
(35, 1, 'RОM памет, характеристики, видове', 'Дефинира RОM памет, описва основните характеристики, изброява основните видове RОM.', 10, 5, 0, 0, 0, 7),
(36, 2, 'Особености на PROM и EPROM.', 'Описва особеностите на PROM и EPROM. Прави сравнение между двата вида памети, открива разликите и посочва предимствата', 20, 3, 2, 1, 0, 7),
(37, 3, 'Особености на EEPROM и Flash ROM .', 'Описва особеностите на EEPROM и Flash ROM. Прави сравнение между двата вида памети, открива разликите и посочва предимствата.', 20, 3, 2, 1, 0, 7),
(38, 4, 'Същност и предназначение на BIOS.', 'Обяснява същността и предназначението на BIOS. Изброява и обяснява четирите основни функции на BIOS.', 20, 1, 3, 1, 0, 7),
(39, 5, 'Основните стъпки от методиката за откриване и отстраняване на хардуерни проблеми и \r\nдефекти в компютърна система.', 'Определя основните стъпки от методиката за откриване и отстраняване на хардуерни проблеми и дефекти в компютърна система. Дава пример за откриване на дефектирал компонент.', 30, 1, 0, 2, 2, 7),
(40, 1, 'Видове носещи среди при компютърните мрежи.', 'Изброява и описва основните носещи среди при компютърните мрежи.', 10, 3, 1, 0, 0, 8),
(41, 2, 'Кабелна система при компютърните мрежи. Видове кабели.', 'Описва характеристиките и спецификациите на основните видове кабели. Извършва сравнение между тях и открива предимствата им', 20, 0, 2, 2, 0, 8),
(42, 3, 'Мрежови устройства за компютърни мрежи – мрежова карта, пасивни устройства.', 'Дефинира и обяснява основните характеристики на мрежовата карта и пасивните мрежови устройства', 10, 1, 2, 0, 0, 8),
(43, 4, 'Активни и разделящи мрежови устройства.', 'Описва основните характеристики на активни и разделящи мрежови устройства. Открива разликите и посочва предимствата между тях.', 20, 3, 0, 1, 1, 8),
(44, 5, 'Мрежови устройства за компютърни мрежи с оптични кабели', 'Обяснява предназначението на мрежови устройства за компютърни мрежи с \r\nоптични кабели.', 10, 1, 2, 0, 0, 8),
(45, 6, 'Безжични локални мрежи.', 'Описва безжични локални мрежи.', 10, 3, 1, 0, 0, 8),
(46, 7, 'Сравнение между основните видове кабели, използвани в компютърните мрежи.', 'Извършва сравнение между основните видове кабели спрямо използваема дължина, скорост на предаване, гъвкавост, леснота при инсталиране, податливост на смущение, специални възможности, препоръчителна употреба, цена и прави изводи за приложението им .', 20, 0, 1, 0, 2, 8),
(47, 1, 'Категоризация на мрежите според физическия обхват.', 'Посочва видовете компютърни мрежи според физическия обхват', 10, 5, 0, 0, 0, 9),
(48, 2, 'Мрежи с линейна шина. Комуникации по шинна мрежа.', 'Обяснява мрежи с линейна шина и комуникация по мрежата. Изчертава примерна схема на посочената топология', 10, 1, 2, 0, 0, 9),
(49, 3, 'Кръгови мрежи. Комуникации по кръгова мрежа.', 'Обяснява кръгова мрежа и комуникация по мрежата. Изчертава примерна \r\nсхема на посочената топология.', 10, 1, 2, 0, 0, 9),
(50, 4, 'Мрежи от тип звезда. Комуникации по мрежа от тип звезда.', 'Обяснява мрежи от тип звезда и комуникация по мрежата. Изчертава примерна схема на посочената топология', 10, 1, 2, 0, 0, 9),
(51, 5, 'Сравнение на трите вида топологии спрямо техните характеристики .', 'Сравнява трите вида топологии, открива разликите, посочва предимствата и недостатъците на всяка топология и прави изводи.', 20, 1, 1, 1, 1, 9),
(52, 6, 'Компютърни мрежи спрямо метода на администриране – равноправна мрежа (peer-to-peer \r\nnetwork) и мрежа клиент-сървър (server based network). Видове сървъри.', 'Обяснява видовете компютърни мрежи спрямо метода на администриране – равноправна мрежа (peer-to-peer network) и мрежа клиент-сървър (server based network). Посочва видовете сървъри.', 20, 3, 2, 1, 0, 9),
(53, 7, 'Сравнение на компютърните мрежи според метода на администриране.', 'Сравнява компютърни мрежи спрямо метода на администриране – равноправна мрежа (peer-to-peer network) и мрежа клиент-сървър (server based network), открива разликите и посочва предимствата на всяка една от тях.', 20, 0, 0, 2, 1, 9),
(54, 1, 'Архитектура на TCP/IP.', 'Дефинира и обяснява архитектура на TCP/IP.', 10, 3, 1, 0, 0, 11),
(55, 2, 'Протоколи в мрежовия слой. IP адрес и класове IP адреси.', 'Дефинира и обяснява IP адрес и класове IP адреси.', 10, 1, 2, 0, 0, 11),
(56, 3, 'Правила при IP адресирането. Мрежова маска.', 'Описва IPv4 и IPv6 адресите, като открива и посочва разликите между тях.', 20, 2, 1, 2, 0, 11),
(57, 4, 'Частни и служебни адресни пространства. Мрежова маска', 'Обяснява частни и служебни адресни пространства. Предлага пример за \r\nмрежова маска.', 20, 1, 1, 1, 1, 11),
(58, 5, 'Транспортни протоколи – TCP и UDP.', 'Сравнява транспортни протоколи – TCP и UDP, открива разликите и посочва предимствата.', 10, 0, 1, 1, 0, 11),
(59, 6, 'Виртуални частни мрежи.', 'Описва същността и принципа на VPN', 20, 3, 0, 1, 1, 11),
(60, 7, 'Протоколи, използвани при VPN', 'Сравнява протоколите РРТР и L2TP', 10, 1, 2, 0, 0, 11),
(61, 1, 'Външни запомнящи устройства, видове според принципа на запис и четене на информацията. Метод на магнитен запис/четене', 'Изброява видовете запомнящи устройства според принципа на запис/четене на информацията. Обяснява метода на магнитен запис/четене.', 10, 1, 2, 0, 0, 12),
(62, 2, 'Принципно устройство на твърд диск (HDD). Характеристики и логическа организация на твърд диск.', 'Обяснява устройството и функциите на основните компоненти на твърд диск. \r\nПосочва и описва характеристиките на твърдия диск и обяснява логическата \r\nму организация', 20, 2, 4, 0, 0, 12),
(63, 3, 'SSD запомнящи устройства. Характеристики. Предимства на SSD спрямо HDD.', 'Описва полупроводникови запомнящи устройства. Сравнява твърди дискове и полупроводникови запомнящи устройства, открива разликите и определя предимствата.', 20, 3, 2, 1, 0, 12),
(64, 4, 'Интерфейси за твърди дискове. Сравнение на АТА и SATA интерфейси.', 'Изброява дисковите интерфейси. Обяснява предназначението и характеристиките им. Прави сравнение между тях и посочва предимствата им', 10, 1, 2, 0, 0, 12),
(65, 5, 'RAID kонтролери за HDD, спецификации.', 'Дефинира RAID технология. Обяснява понятието RAID масив. Изчертава и обяснява видовете стандартни RAID нива – RAID 0 и RAID1. Изброява комбинациите от RAID масиви. Различава хардуерен от софтуерен RAID масив, посочва предимствата и недостатъците и прави изводи.', 40, 1, 2, 1, 3, 12),
(66, 1, 'Външни запомнящи устройства, видове според принципа на запис и четене на информацията. Метод на оптично четене.', 'Изброява външни запомнящи устройства според принципа на запис и четене на информацията. Обяснява метод на оптично четене.', 10, 3, 1, 0, 0, 13),
(67, 2, 'Структура и запис на CD-ROM, CD-R и CD-RW, физическа организация на паметта.', 'Чертае структурите на CD-ROM, CD-R и CD-RW, обяснява методите на запис, описва физическа организация на паметта.', 20, 0, 2, 2, 0, 13),
(68, 3, 'Структура и запис на DVD, кодиране на информацията, стандарти на DVD.', 'Описва структурата и обяснява записа и кодиране на информацията на DVD, посочва четири стандарта на DVD.', 20, 4, 3, 0, 0, 13),
(69, 4, 'Blue Ray запомнящи устройства, характеристики и видове.', 'Обяснява Blue Ray запомнящи устройства, посочва видовете Blue Ray и параметрите им.', 20, 3, 2, 1, 0, 13),
(70, 5, 'Съпоставка между различните видове оптични дискове спрямо стъпката на пътечката(микрона), минимална дължина на вълната (микрона), според плътността на съхранените данни (GB/inch), и според вълната на лазера (nm).', 'Съпоставя различните видове оптични дискове CD, DVD и Blue Ray спрямо стъпката на пътечката (микрона), минимална дължина на вълната (микрона),  според плътността на съхранените данни (GB/inch), и според вълната на лазера (nm). Разпознава разликите и посочва предимствата между тях.', 30, 0, 2, 1, 2, 13),
(71, 1, 'Класификация на скенерите спрямо конструкцията и технологията на сканиране. USB шина– характеристики и спецификации .', 'Изброява видовете скенери спрямо конструкцията и технологията на сканиране. Описва характеристиките и спецификациите на USB шина.', 20, 4, 3, 0, 0, 14),
(72, 2, 'CIS (Contact Image Censor) скенери, устройство и принцип на действие, основни параметри. \r\nCCD (Couple Charge Device ) скенери, устройство и принцип на действие, характеристики.', 'Описва устройството на CIS (Contact Image Censor) скенер и обяснява принципа му на действие. Описва устройството на CCD (Couple Charge Device) скенер и обяснява принципа му на действие. Посочва основните им параметри.', 20, 2, 4, 0, 0, 14),
(73, 3, 'Мастилено-струйни принтери, устройство и принцип на действие, основни параметри. Лазерни принтери, принципно устройство, основни параметри', 'Описва устройство и обяснява принцип на действие на мастилено-струйни принтери с термо- и пиезо- метод на печат. Описва устройството на лазерен принтер и дефинира основните му параметри.', 20, 1, 3, 1, 0, 14),
(74, 4, 'Плотери – предназначение и видове.', 'Обяснява предназначението на плотерите. Разпознава растерни от векторни плотери. Посочва видовете векторни плотери и видовете растерни плотери.', 20, 1, 1, 1, 1, 14),
(75, 5, 'Цветни лазерни принтери. Сравнение между монохромен и цветен лазерен принтер.', 'Описва устройство на цветен лазерен принтер. Определя разликите между монохромен и цветен лазерен принтер.', 20, 1, 1, 1, 1, 14),
(76, 1, 'Видеосистема. LCD монитори, принципно устройство. LCD монитори с пасивни и активни \r\nматрици.', 'Формулира понятието видеосистема. Описва принципно устройство на LCD монитори. Обяснява разликата между LCD монитори с пасивни и активни матрици.', 20, 3, 2, 1, 0, 15),
(77, 2, 'Плазмени монитори и OLED (Organic Light Emitting Diode) монитори, устройство и принцип \r\nна действие. Сравнение на трите вида монитори.', 'Описва устройството и принципа на действие на плазмени монитори и OLED (Organic Light Emitting Diode) монитори. Сравнява и анализира характеристиките на трите вида монитори, открива разликите и посочва предимствата на всеки един от тях', 20, 0, 3, 0, 1, 15),
(78, 3, 'Цифрови камери – основни функционални блокове, параметри.', 'Изброява и обяснява основни функционални блокове на цифровите камери. Посочва основни параметри на цифровите камери.', 20, 4, 3, 0, 0, 15),
(79, 4, 'Видеокарти, функционални блокове, характеристики, стандарти. IEEE 1394 и HDMI –предназначение и особеност', 'Описва функционалните блокове на видеокартите, посочва основните им характеристики и стандарти. Обяснява предназначение и особености на IEEE 1394 и HDMI.', 20, 4, 3, 0, 0, 15),
(80, 5, 'Цифров звук, аналогово-цифрово и цифрово-аналогово преобразуване на звука, формати за \r\nцифров звук.', 'Обяснява предназначението на звукова карта, описва аналогово-цифрово и цифрово-аналогово преобразуване на звука, дава примери за формати за цифров звук.', 20, 0, 0, 2, 1, 15),
(81, 1, 'Алгоритъм – определение. Начини за представяне на алгоритми. Елементи на блок-схемите.', 'Описва понятието алгоритъм. Посочва начините за представянето на алгоритми. Обяснява елементите на блок-схемите.', 20, 4, 3, 0, 0, 16),
(82, 2, 'Видове алгоритми – линеен алгоритъм, разклонени алгоритми, циклични алгоритми. Видове \r\nциклични алгоритми.', 'Начертава и обяснява различните видове алгоритми. Разпознава различните видове циклични алгоритми.', 30, 0, 0, 1, 3, 16),
(83, 4, 'Основни типове данни. Скаларни и съставни типове данни.', 'Изброява основните типове данни. Дава примери за скаларни типове данни.', 20, 4, 3, 0, 0, 16),
(84, 3, 'Променливи и константи. Правила за именуване на променливи и константи.', 'Посочва правилата за именуване на променливи и константи', 10, 1, 2, 0, 0, 16),
(85, 5, 'Масиви. Едномерни и многомерни масиви', 'Описва понятията едномерен и многомерен масив. Изброява основните типове задачи за едномерен масив. Дава пример.', 20, 0, 2, 2, 0, 16),
(86, 1, 'Оператори – видове. Синтаксис на операторите– за въвеждане, извеждане, присвояване', 'Изброява и обяснява различните видове оператори и синтаксиса на операторите за въвеждане, извеждане и за присвояване', 10, 1, 2, 0, 0, 17),
(87, 2, 'Циклични конструкции – видове.', 'Дефинира и обяснява различните циклични структури.', 10, 3, 1, 0, 0, 17),
(88, 3, 'Условни оператори. Съставни логически условия. Вложени условни оператори.', 'Посочва и обяснява условни оператори, включително вложени условни оператори', 20, 4, 3, 0, 0, 17),
(89, 4, 'Оператори за цикъл. Вложени циклични оператори', 'Обяснява циклични оператори, включително вложени циклични оператори.', 20, 1, 3, 1, 0, 17),
(90, 5, 'Обръщане на елементите в едномерен масив.', 'Описва и обяснява как се обръщат елементите на едномерен масив.', 20, 2, 1, 2, 0, 17),
(91, 6, 'Сума от елементите на масив', 'Представя и обяснява как се изчислява сума на елементи на масив', 20, 0, 1, 0, 2, 17),
(92, 1, 'Процеси в операционната система. Начини за организация на процесите. Състояния на процесите.', 'Дефинира понятието процес. Посочва начините на организация на процесите и тяхното състояние.', 20, 4, 3, 0, 0, 18),
(93, 2, 'Блок за управление на процес в операционната система. Операции с процеси.', 'Описва как се управляват процесите, какви операции им се присвояват и ситуации при прекъсването им.', 10, 1, 2, 0, 0, 18),
(94, 3, 'Нишки. Безизходни ситуации. Условия за възникване на мъртва хватка.', 'Посочва правилата за изпълнение на нишки в процесите, приликите и разликите им с процесите.', 20, 1, 1, 1, 1, 18),
(96, 4, 'Управление на паметта в операционната система. Методи за управление на паметта.', 'Посочва изисквания за организация на паметта при нейното управление от \r\nОС, описва принципи и методи на обработка на данните в паметта.', 20, 2, 1, 2, 0, 18),
(97, 5, 'Софтуерни методи за диагностика и ремонт на компютърна система. Основни проблеми в \r\nоперационната система.', 'Определя основните стъпки от методиката за откриване и отстраняване на софтуерни проблеми и дефекти в компютърна система. Дава пример за основни проблеми в операционната система.', 30, 1, 0, 2, 2, 18);

-- --------------------------------------------------------

--
-- Структура на таблица `main_userprofile`
--

DROP TABLE IF EXISTS `main_userprofile`;
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
(1, 1, 1, 1, 1, 1, 2, 1),
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
-- Индекси за таблица `main_theme`
--
ALTER TABLE `main_theme`
  ADD PRIMARY KEY (`id`),
  ADD KEY `main_theme_specialty_id_5d20d011_fk_main_specialty_id` (`specialty_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `main_documents`
--
ALTER TABLE `main_documents`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `main_log`
--
ALTER TABLE `main_log`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

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
-- AUTO_INCREMENT for table `main_theme`
--
ALTER TABLE `main_theme`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `main_themeitem`
--
ALTER TABLE `main_themeitem`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

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
-- Ограничения за таблица `main_theme`
--
ALTER TABLE `main_theme`
  ADD CONSTRAINT `main_theme_specialty_id_5d20d011_fk_main_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `main_specialty` (`id`);

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
